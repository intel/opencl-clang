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

\file main.cpp

\*****************************************************************************/

#include "main.h"

#include <algorithm>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

void printUsage(const string &);

int main(int argc, char *argv[]) {
  try {
    vector<string> args(argc);
    transform(argv, argv + argc, args.begin(),
              [](char *c_str) { return string(c_str); });

    if (argc == 1) {
      printUsage(args[0]);
      return 0;
    }

    string method = "compile";
    find_if(args.begin(), args.end(), [&](const string &s) {
      string methodParam = "--method=";
      auto it = s.find(methodParam);
      if (it != string::npos) {
        method.assign(s.begin() + it + methodParam.size(), s.end());
      }
      return it != string::npos;
    });

    transform(method.begin(), method.end(), method.begin(), ::tolower);

    int retvalue = 0;
    if (method == "compile") {
      retvalue = compile(args);
    } else if (method == "checkcompileoptions") {
      retvalue = checkCompileOptions(args);
    } else {
      cerr << "Undefined method " << method << "!" << endl;
      retvalue = -1;
    }
    return retvalue;
  } catch (std::exception &e) {
    // catch std::bad_array_new_length and std::bad_alloc
    cerr << e.what() << endl;
    return -1;
  }
}

void printUsage(const string &executable) {
  cout << "Usage: " << endl;
  cout << "\t " << executable << " --method=methodName [options]" << endl;
  cout << endl;
  cout << "Available methods: " << endl;
  cout << "\t CheckCompileOptions" << endl;
  cout << "\t CheckLinkOptions" << endl;
  cout << "\t Compile" << endl;
  cout << "\t Link" << endl;
  cout << "\t GetKernelArgInfo" << endl;
  cout << endl;
  cout << "For details type: " << endl;
  cout << "\t " << executable << " --method=methodName --help" << endl;
}
