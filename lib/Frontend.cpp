//===--- Frontend.cpp - Clang frontend wrapper implementation ---*- C++ -*-===//
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

#include "Frontend.h"
#include "BuiltInHeaders.h"

#include "clang/CodeGen/CodeGenAction.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Frontend/TextDiagnosticPrinter.h"

#include "llvm/Config/llvm-config.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
class FEImpl : public FrontendAction {
public:
  explicit FEImpl(LLVMContext &Ctx) : Ctx(Ctx) {}

  std::string &&getDiagnostics() { return std::move(DiagBuffer); }

private:
  friend class FrontendAction;
  Expected<OutputType> runImpl(InputType &&Input);

  IntrusiveRefCntPtr<clang::DiagnosticsEngine> getDiagEngine();

  IntrusiveRefCntPtr<vfs::OverlayFileSystem>
  getVFS(ArrayRef<FrontendSource> Input);

  LLVMContext &Ctx;

#if LLVM_VERSION_MAJOR >= 21
  clang::DiagnosticOptions DiagOpts;
#else  // LLVM_VERSION_MAJOR >= 21
  IntrusiveRefCntPtr<clang::DiagnosticOptions> DiagOpts =
      makeIntrusiveRefCnt<clang::DiagnosticOptions>();
#endif // LLVM_VERSION_MAJOR >= 21

  std::string DiagBuffer;
  raw_string_ostream DiagStream{DiagBuffer};
};
} // namespace

Expected<FrontendAction::OutputType>
FrontendAction::runImpl(FrontendAction::InputType &&Input) {
  return static_cast<FEImpl *>(this)->runImpl(std::move(Input));
}

std::string &&FrontendAction::getDiagnostics() {
  return std::move(static_cast<FEImpl *>(this)->getDiagnostics());
}

std::unique_ptr<FrontendAction> FrontendAction::get(LLVMContext &Ctx) {
  return std::unique_ptr<FrontendAction>(new FEImpl(Ctx));
}

Expected<FrontendAction::OutputType> FEImpl::runImpl(InputType &&Input) {
  using namespace clang;

  CompilerInstance CI;

  // Set up diagnostics before anything else, so that we can report any errors
  // that occur during initialization.
  auto Diags = getDiagEngine();
  CI.setDiagnostics(Diags.get());
  CI.setVerboseOutputStream(DiagStream);

  // Set up the virtual file system and the source manager.
  auto VFS = getVFS(Input.Sources);
#if LLVM_VERSION_MAJOR >= 22
  CI.setVirtualFileSystem(std::move(VFS));
  CI.createFileManager();
  CI.createSourceManager();
#else  // LLVM_VERSION_MAJOR >= 22
  CI.createFileManager(std::move(VFS));
  CI.createSourceManager(CI.getFileManager());
#endif // LLVM_VERSION_MAJOR >= 22

  // Set up the compiler invocation from user args.
  CompilerInvocation::CreateFromArgs(CI.getInvocation(), Input.Args, *Diags);

#if LLVM_VERSION_MAJOR >= 20
  ProcessWarningOptions(*Diags, CI.getDiagnosticOpts(),
                        CI.getFileManager().getVirtualFileSystem());
#else  // LLVM_VERSION_MAJOR >= 20
  ProcessWarningOptions(*Diags, CI.getDiagnosticOpts());
#endif // LLVM_VERSION_MAJOR >= 20

  if (Diags->hasErrorOccurred())
    return createStringError(inconvertibleErrorCode(),
                             "Failed to set up compiler invocation");

  // Compile the source code to LLVM IR.
  auto Action = std::make_unique<EmitLLVMOnlyAction>(&Ctx);
  if (!CI.ExecuteAction(*Action))
    return createStringError(inconvertibleErrorCode(),
                             "Failed to compile source code");

  auto OutputModule = Action->takeModule();
  if (!OutputModule)
    return createStringError(inconvertibleErrorCode(),
                             "Failed to take output module");

  return std::move(OutputModule);
}

IntrusiveRefCntPtr<clang::DiagnosticsEngine> FEImpl::getDiagEngine() {
  using namespace clang;

  IntrusiveRefCntPtr<DiagnosticIDs> DiagID = new DiagnosticIDs();
#if LLVM_VERSION_MAJOR >= 21
  DiagOpts.ShowPresumedLoc = 1;
  DiagnosticOptions &DiagPrinterOpts = DiagOpts;
#else  // LLVM_VERSION_MAJOR >= 21
  DiagOpts->ShowPresumedLoc = 1;
  DiagnosticOptions *DiagPrinterOpts = DiagOpts.get();
#endif // LLVM_VERSION_MAJOR >= 21

  // The DiagnosticEngine takes ownership of the diagnostic client, so we don't
  // need to delete it or use any smart pointers.
  auto *DiagPrinter = new TextDiagnosticPrinter(DiagStream, DiagPrinterOpts);

  IntrusiveRefCntPtr<DiagnosticsEngine> Diags =
      new DiagnosticsEngine(DiagID, DiagOpts, DiagPrinter);
  return Diags;
}

IntrusiveRefCntPtr<vfs::OverlayFileSystem>
FEImpl::getVFS(ArrayRef<FrontendSource> Sources) {
  const BuiltInHeaders &Headers = BuiltInHeaders::get();
  auto OvlFS =
      makeIntrusiveRefCnt<vfs::OverlayFileSystem>(Headers.getFileSystem());

  // Map memory buffers to a virtual file system
  auto MemFS = makeIntrusiveRefCnt<vfs::InMemoryFileSystem>();
  OvlFS->pushOverlay(MemFS);

  for (const auto &Src : Sources) {
    static constexpr time_t ModTime = 0;

    StringRef Data = Src.Data.rtrim('\0');
    MemFS->addFile(Src.Filename, ModTime,
                   MemoryBuffer::getMemBuffer(Data, Src.Filename));
  }

  return OvlFS;
}
