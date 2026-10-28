//===--- Driver.cpp - OpenCL Clang Driver -----------------------*- C++ -*-===//
//
// Copyright (c) Intel Corporation (2026).
//
// INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE. THIS CODE IS
// LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY SUPPORT,
// ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES. INTEL DOES NOT
// PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS. INTEL SPECIFICALLY
// DISCLAIMS ANY WARRANTY OF MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR ANY
// PARTICULAR PURPOSE, OR ANY OTHER WARRANTY. Intel disclaims all liability,
// including liability for infringement of any proprietary rights, relating to
// use of the code. No license, express or implied, by estoppel or otherwise,
// to any intellectual property rights is granted herein.
//
//===----------------------------------------------------------------------===//

#include "BinaryResult.h"
#include "Bitcode.h"
#include "Frontend.h"
#include "Options/OptionParser.h"
#include "SPIRV.h"

#include "opencl-clang/OpenCLClang.h"

#include "llvm/ADT/StringMap.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Support/ManagedStatic.h"

#include <algorithm>
#include <memory>

#if defined _DEBUG
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>
#include <thread>
#endif

using namespace llvm;
using namespace Intel::OpenCL::ClangFE;

namespace {
class Driver {
public:
  Driver(const char *OpenCLVersion);

  Driver(const Driver &) = delete;
  Driver &operator=(const Driver &) = delete;
  Driver(Driver &&) = delete;
  Driver &operator=(Driver &&) = delete;

  bool setOptions(const char *Options, const char *OptionsEx);
  bool compile(const char *ProgramSource, const char **InputHeaders,
               unsigned NumInputHeaders, const char **InputHeadersNames,
               IOCLFEBinaryResult **BinaryResult);

private:
  static void initializeLLVM();
  static int initializeLLVMOnce();

  static std::unique_ptr<LLVMContext> createLLVMContext();

  SPIRV::TranslatorOpts getSPIRVTranslatorOpts() const;

  // Serializes the module produced by the frontend into the requested output
  // format: SPIR-V or LLVM bitcode.
  Expected<SmallVector<char>>
  emitOutput(Expected<std::unique_ptr<Module>> &&Module) const;

  OptionParser OptionsParser;
  std::unique_ptr<LLVMContext> Context;
};
} // namespace

// The LLVM libraries user is expected to call llvm_shutdown before the static
// objects are destroyed, so it is registered with atexit. This function
// mustn't be invoked from a static object constructor, from a DllMain function
// (Windows specific), or from a function w\ __attribute__ ((constructor))
// (Linux specific).
void Driver::initializeLLVM() {
  [[maybe_unused]] static int Init = initializeLLVMOnce();
}

int Driver::initializeLLVMOnce() {
  atexit([]() { llvm::llvm_shutdown(); });
  return 0;
}

std::unique_ptr<LLVMContext> Driver::createLLVMContext() {
  initializeLLVM();
  return std::make_unique<LLVMContext>();
}

Driver::Driver(const char *OpenCLVersion)
    : OptionsParser(OpenCLVersion), Context(createLLVMContext()) {}

bool Driver::setOptions(const char *Options, const char *OptionsEx) {
  return OptionsParser.process(Options, OptionsEx);
}

bool Driver::compile(const char *ProgramSource, const char **InputHeaders,
                     unsigned NumInputHeaders, const char **InputHeadersNames,
                     IOCLFEBinaryResult **BinaryResult) {
  bool Success = false;

  // Prepare the input for the frontend action.
  SmallVector<FrontendSource> Sources;

  StringRef SourceName = OptionsParser.getSourceName();
  Sources.emplace_back(ProgramSource, SourceName);

  for (unsigned I = 0; I < NumInputHeaders; ++I)
    Sources.emplace_back(InputHeaders[I], InputHeadersNames[I]);

  auto &CCArgs = OptionsParser.getCCArgs();
  SmallVector<const char *> Args;
  Args.reserve(CCArgs.size());
  llvm::transform(CCArgs, std::back_inserter(Args),
                  [](auto &Arg) { return Arg.c_str(); });
  FrontendInput Input = {Sources, Args};

  auto Result = std::make_unique<OCLFEBinaryResult>();
  Result->setIRType(IrTypeCompiledObject);
  Result->setIRName(SourceName);
  Result->setResult(CL_COMPILE_PROGRAM_FAILURE);

  // Run the Clang frontend and get the generated LLVM module.
  auto FE = FrontendAction::get(*Context);
  auto ExpectedOutput = emitOutput(FE->run(Input));

  std::string Log = FE->getDiagnostics();
  if (ExpectedOutput) {
    Success = true;
    Result->setIRBuffer(std::move(*ExpectedOutput));
    Result->setResult(CL_SUCCESS);
  } else {
    Log.append("\n");
    Log.append(toString(ExpectedOutput.takeError()));
  }

  Result->setLog(std::move(Log));

  if (BinaryResult)
    *BinaryResult = Result.release();
  return Success;
}

Expected<SmallVector<char>>
Driver::emitOutput(Expected<std::unique_ptr<Module>> &&Module) const {
  if (OptionsParser.hasEmitSPIRV())
    return SPIRVWriterAction(getSPIRVTranslatorOpts()).run(std::move(Module));
  return BCWriterAction().run(std::move(Module));
}

// Builds the SPIR-V extensions status map from the list of the extensions
// specified by the --spirv-ext= option.
static SPIRV::TranslatorOpts::ExtensionsStatusMap
getSPIRVExtStatus(ArrayRef<SmallString<64>> SPIRVExts) {
  // Map name -> id for known extensions
  static const StringMap<SPIRV::ExtensionID> NameToID = {
#define EXT(X) {#X, SPIRV::ExtensionID::X},
#ifdef USE_PREBUILT_LLVM
#include "LLVMSPIRVLib/LLVMSPIRVExtensions.inc"
#else // USE_PREBUILT_LLVM
#include "LLVMSPIRVExtensions.inc"
#endif // USE_PREBUILT_LLVM
#undef EXT
  };

  // Set the initial state: assume that any known extension is disallowed.
  using ExtensionsStatusMap = SPIRV::TranslatorOpts::ExtensionsStatusMap;
  ExtensionsStatusMap Map;
  for (const auto &It : NameToID)
    Map[It.second] = ExtensionsStatusMap::mapped_type();

  for (StringRef Ext : SPIRVExts) {
    bool Enabled = Ext.front() == '+';
    StringRef ExtName = Ext.drop_front();

    if (ExtName == "all") {
      // Update status for all known extensions
      for (const auto &It : NameToID)
        Map[It.second] = Enabled;
      continue;
    }

    // Ignore unknown extensions, as targets may support non-standard SPIR-V
    // extensions. Do not reject them; this approach is more tolerant.
    auto It = NameToID.find(ExtName);
    if (It != NameToID.end())
      Map[It->second] = Enabled;
  }

  return Map;
}

SPIRV::TranslatorOpts Driver::getSPIRVTranslatorOpts() const {
  SPIRV::TranslatorOpts::ExtensionsStatusMap SPIRVExtStatusMap;
  if (OptionsParser.hasSPIRVExt())
    SPIRVExtStatusMap = getSPIRVExtStatus(OptionsParser.getSPIRVExts());

  SPIRV::TranslatorOpts Opts(SPIRV::VersionNumber::MaximumVersion,
                             SPIRVExtStatusMap);

  if (!OptionsParser.hasSPIRVExt())
    Opts.enableAllExtensions();
  if (!OptionsParser.hasOptDisable())
    Opts.setMemToRegEnabled(true);
  Opts.setPreserveOCLKernelArgTypeMetadataThroughString(true);

  return Opts;
}

static void printCompileOptions(const char *Options, const char *OptionsEx,
                                const char *OpenCLVersion, const char *Source) {
#ifdef _DEBUG
  static int ID = 0;

  if (!getenv("CCLANG_OPTIONS_DIR"))
    return;

  std::string OptionsDir = getenv("CCLANG_OPTIONS_DIR");

  std::stringstream LogPath;
  LogPath << OptionsDir << "/log_" << std::this_thread::get_id() << "_" << ID
          << ".txt";
  std::cout << LogPath.str() << std::endl;

  // Creating log file
  std::ofstream LogFile(LogPath.str(), std::ios::out);

  if (!LogFile.is_open()) {
    std::cout << "[ERROR] Can't create log file" << std::endl;
    return;
  }

  LogFile << "Options=" << Options << std::endl;
  LogFile << "OptionsEx=" << OptionsEx << std::endl;
  LogFile << "OpenCLVersion=" << OpenCLVersion << std::endl;
  LogFile << Source;
  ++ID;
  LogFile.close();
#endif
}

extern "C" CC_DLL_EXPORT int
Compile(const char *ProgramSource, const char **InputHeaders,
        unsigned NumInputHeaders, const char **InputHeadersNames,
        const char * /*PCHBuffer*/, size_t /*PCHBufferSize*/,
        const char *Options, const char *OptionsEx, const char *OpenCLVersion,
        IOCLFEBinaryResult **BinaryResult) {
  // Capturing cclang compile options
  printCompileOptions(Options, OptionsEx, OpenCLVersion, ProgramSource);

  if (BinaryResult)
    *BinaryResult = nullptr;

  try {
    Driver TheDriver(OpenCLVersion);

    if (!TheDriver.setOptions(Options, OptionsEx))
      return CL_INVALID_BUILD_OPTIONS;

    if (!TheDriver.compile(ProgramSource, InputHeaders, NumInputHeaders,
                           InputHeadersNames, BinaryResult))
      return CL_COMPILE_PROGRAM_FAILURE;
  } catch (std::bad_alloc &) {
    return CL_OUT_OF_HOST_MEMORY;
  }

  return CL_SUCCESS;
}

extern "C" CC_DLL_EXPORT bool CheckCompileOptions(const char *Options,
                                                  char *UnknownOptions,
                                                  size_t UnknownOptionsSize) {
  try {
    OptionParser Parser("200");
    return Parser.check(Options, UnknownOptions, UnknownOptionsSize);
  } catch (std::bad_alloc &) {
    if (UnknownOptions && UnknownOptionsSize > 0)
      std::fill_n(UnknownOptions, UnknownOptionsSize, '\0');
    return false;
  }
}
