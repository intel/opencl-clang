/*****************************************************************************\

Copyright(c) Intel Corporation(2009 - 2016).

INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE.THIS CODE IS
LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY SUPPORT,
ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES.INTEL DOES NOT
PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS.INTEL SPECIFICALLY
DISCLAIMS ANY WARRANTY OF MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR ANY
PARTICULAR PURPOSE, OR ANY OTHER WARRANTY.Intel disclaims all liability,
including liability for infringement of any proprietary rights, relating to
use of the code.No license, express or implied, by estoppel or otherwise,
to any intellectual property rights is granted herein.

\file compile.cpp

\*****************************************************************************/

#include "IniFiles.h"
#include "common.h"
#include "opencl_clang.h"
#include "main.h"

#include <algorithm>
#include <cstring>
#include <iostream>
#include <memory>
#include <string>
#include <vector>
using namespace std;
using namespace Intel::OpenCL::ClangFE;

void printCompileUsage(const string&);

int compile(const vector<string> &args) {
  if (args.size() <= 1) {
    cerr << "At least kernel name should be specified!" << endl;
    return -1;
  }

  // read options
  const string ccl_compile_version = "0.2.4";
  string cl_options = "";
  string cl_optionsEx = "";
  string cl_version = "";
  string cl_device = "";
  string cfg_path = "";
  string ir_file = "";
  string cl_file_path;

  int verbose = 0;

  bool half = false;
  bool doubles = false;
  bool subgroups = false;
  bool channels = false;

  for (const auto &arg : args) {
    // searching --help parameter
    string arg_name("--help");
    if (arg.find(arg_name) != string::npos) {
      printCompileUsage(args[0]);
      return 0;
    }

    // searching --version parameter
    arg_name = "--version";
    if (arg.find(arg_name) != string::npos) {
      cout << ccl_compile_version << endl;
      return 0;
    }

    // searching --verbose parameter
    arg_name = "--verbose";
    if (arg.find(arg_name) != string::npos) {
      verbose = 1;
      continue;
    }

    // searching --cl-options parameter
    arg_name = "--cl-options=";
    if (arg.find(arg_name) != string::npos) {
      cl_options = string(arg.c_str() + arg_name.size());
      continue;
    }

    // searching --cl-options-ex parameter
    arg_name = "--cl-options-ex=";
    if (arg.find(arg_name) != string::npos) {
      cl_optionsEx = string(arg.c_str() + arg_name.size());
      continue;
    }

    // searching --cl-version parameter
    arg_name = "--cl-version=";
    if (arg.find(arg_name) != string::npos) {
      cl_version = string(arg.c_str() + arg_name.size());
      continue;
    }

    // searching --cl-device parameter
    arg_name = "--cl-device=";
    if (arg.find(arg_name) != string::npos) {
      cl_device = string(arg.c_str() + arg_name.size());
      transform(cl_device.begin(), cl_device.end(), cl_device.begin(),
                ::toupper);
      continue;
    }

    // searching --use-half option
    arg_name = "--use-half";
    if (arg.find(arg_name) != string::npos) {
      half = true;
      continue;
    }

    // searching --use-double option
    arg_name = "--use-double";
    if (arg.find(arg_name) != string::npos) {
      doubles = true;
      continue;
    }

    // searching --use-subgroups option
    arg_name = "--use-subgroups";
    if (arg.find(arg_name) != string::npos) {
      subgroups = true;
      continue;
    }

    // searching --use-channels option
    arg_name = "--use-channels";
    if (arg.find(arg_name) != string::npos) {
      channels = true;
      continue;
    }

    // searching ConfExt.ini file
    arg_name = "--config-path=";
    if (arg.find(arg_name) != string::npos) {
      cfg_path = string(arg.c_str() + arg_name.size());
      continue;
    }

    // searching --output parameter
    arg_name = "--output=";
    if (arg.find(arg_name) != string::npos) {
      ir_file = string(arg.c_str() + arg_name.size());
      continue;
    }

    cl_file_path = arg;
  }

  if (cl_file_path.empty()) {
    cout << "Please specify <cl_file_path>" << endl;
    return -1;
  }

  string cl_program_source = readFile(cl_file_path);
  if (cl_program_source.empty()) {
    return -1;
  }

  IniFile ini(cfg_path + "/ConfExt.ini", verbose);
  if (!ini.Open()) {
    return -1;
  }

  cl_options += ' ' + ini.GetSecondKeyVal(cl_device, "pszOptions");

  // The order of extension in cl_optionsEx is as the following:
  // 1. Extensions defined in the config file
  // 2. Extensions specified via -cl-options-ex options of occ-cli
  // 3. Extensions enabled by -use-<extension> options of occ-cli
  // Note that former extension in cl_optionsEx overwrite previous.
  cl_optionsEx.insert(0, ini.GetSecondKeyVal(cl_device, "pszOptionsEx")+' ');

  // Enable device extensions specified via command line
  string device_extensions("-cl-ext=");
  if (half) {
    device_extensions += "+cl_khr_fp16,";
    cl_options += " -D cl_khr_fp16";
  }
  if (doubles) {
    device_extensions += "+cl_khr_fp64,";
    cl_options += " -D cl_khr_fp64";
  }
  if (subgroups) {
    device_extensions += "+cl_khr_subgroups,";
    cl_options += " -D cl_khr_subgroups";
  }
  if (channels) {
    device_extensions += "+cl_intel_channels,";
    cl_options += " -D cl_intel_channels";
  }
  if (device_extensions != "-cl-ext=") {
    cl_optionsEx += ' ' + device_extensions;
  }

  if (cl_version.empty()) {
    cl_version = ini.GetSecondKeyVal(cl_device, "pszOpenCLVer");
  }

  if (verbose != 0) {
    cout << "pszOptions: " << cl_options.c_str() << endl;
    cout << "pszOptionsEx: " << cl_optionsEx.c_str() << endl;
    cout << "pszOpenCLVer: " << cl_version.c_str() << endl;
    cout << "pszProgramSource: " << endl
         << string(30, '-') << endl
         << cl_program_source.c_str() << endl
         << string(30, '-') << endl;
  }

  // optional outbound pointer to the compilation results
  unique_ptr<IOCLFEBinaryResult *> pBinaryResult(new IOCLFEBinaryResult *);
  int err = Compile(cl_program_source.c_str(), NULL, 0, NULL, NULL, 0, cl_options.c_str(),
    cl_optionsEx.c_str(), cl_version.c_str(), pBinaryResult.get());

  if (err != 0) {
    if (verbose == 0) {
      cout << "pszOptions: " << cl_options.c_str() << endl;
      cout << "pszOptionsEx: " << cl_optionsEx.c_str() << endl;
      cout << "pszOpenCLVer: " << cl_version.c_str() << endl;
    }

    cerr << "ERROR: Failed to compile program:" << endl
         << string(30, '-') << endl
         << (*pBinaryResult)->GetErrorLog() << endl
         << string(30, '-') << endl;
    return err;
  }

  if ((*pBinaryResult)->GetIRSize() == 0) {
    cerr << (*pBinaryResult)->GetErrorLog() << endl;
    cerr << static_cast<unsigned int>((*pBinaryResult)->GetIRSize()) << endl;
    return -1;
  }

  cout << "Kernel " << cl_file_path << " successfully compiled" << endl;

  if (ir_file == "-") {
    fwrite((*pBinaryResult)->GetIR(), sizeof(char),
           (*pBinaryResult)->GetIRSize(), stdout);
  } else if (!ir_file.empty()) {
    FILE *pFile;
    pFile = fopen(ir_file.c_str(), "wb");
    if (!pFile) {
      cerr << "Can't open " << ir_file << ".\n";
      return -1;
    }
    fwrite((*pBinaryResult)->GetIR(), sizeof(char),
           (*pBinaryResult)->GetIRSize(), pFile);
    fclose(pFile);
    cout << "IR file saved to : " << ir_file.c_str() << endl;

    if (verbose != 0) {
      cout << "IR file size: " << (*pBinaryResult)->GetIRSize() / 1024 << " kB"
           << endl;
    }
  }
  return 0;
}

int checkCompileOptions(const vector<string>& args) {
  cout << "Not implemented yet" << endl;
  return 0;
}

void printCompileUsage(const string &executable) {
  // OVERVIEW
  cout << "OVERVIEW: Compile .cl" << endl << endl;

  // USAGE
  cout << "USAGE: " << executable
            << " Compile --cl-device=<device_name> --config-path=<path> "
               "[options] <cl_file_path>"
            << endl
            << endl;

  // OPTIONS
  cout
      << "OPTIONS:" << endl
      << " --cl-device=<device_name>   - Specify device name from config file"
      << endl
      << " --config-path=<path>        - Path to config file" << endl
      << endl
      << " --output=<file_name>        - Override output file name generated "
         "by compile cl file"
      << endl
      << " --cl-options=<cl_option>    - OpenCL application supplied options"
      << endl
      << " --cl-options-ex=<cl_option> - Internal extra options supplied by "
         "runtime"
      << endl
      << " --use-half                  - Add 'cl_khr_fp16' to OpenCL options"
      << endl
      << " --use-double                - Add 'cl_khr_fp64' to OpenCL options"
      << endl
      << " --use-subgroups             - Add 'cl_khr_subgroups' to OpenCL "
         "options"
      << endl
      << " --use-channels              - Add 'cl_intel_channels' to OpenCL "
         "options"
      << endl
      << " --cl-version=<cl_version>   - OpenCL version string - '120' for "
         "OpenCL 1.2, '200' for OpenCL 2.0, ..."
      << endl;

  cout << " misc:" << endl
            << " --help                      - Display available options"
            << endl
            << " --version                   - Print occ-cli version"
            << endl
            << " --verbose                   - Print addition information"
            << endl
            << endl;

  // CONFIG FILE
  cout << "CONFIG FILE:" << endl
            << "[<device_name>]" << endl
            << "pszOptions=<options>" << endl
            << "pszOptionsEx=<options>" << endl
            << "pszOpenCLVer=<version>" << endl;

}
