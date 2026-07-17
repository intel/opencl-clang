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

\file common.cpp

\*****************************************************************************/

#include "common.h"

#include <fstream>
#include <iostream>
#include <iterator>
#include <string>
using namespace std;

string readFile(const string &filename, ios_base::openmode mode) {
  ifstream file(filename, mode);
  if (!file.is_open()) {
    cerr << "Failed to open file " << filename << endl;
    return string();
  }

  // copies all data into buffer
  string buffer((istreambuf_iterator<char>(file)),
                (istreambuf_iterator<char>()));
  file.close();
  return buffer;
}
