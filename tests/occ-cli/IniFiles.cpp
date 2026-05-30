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

\file IniFiles.cpp

\*****************************************************************************/

#include "IniFiles.h"

#include <fstream>
#include <iostream>
using namespace std;

bool IniFile::Open() {
  ifstream ini_file(fileDir.c_str());
  if (!ini_file.is_open()) {
    cerr << "Can't read " + fileDir + " file!" << endl;
    return false;
  }

  heads.clear();
  string tmp = "", fKey = "";
  while (getline(ini_file, tmp)) {
    size_t pos = tmp.find("=");

    if (pos == string::npos) {
      // '=' not found, added first key
      tmp.erase(tmp.find(']'));
      tmp.erase(tmp.begin());
      heads[tmp].clear();
      fKey = tmp;
    } else {
      // Add new second Key
      string secondKey, keyVal;
      secondKey = tmp.substr(0, pos);
      keyVal = tmp.substr(pos + 1, tmp.length());
      heads[fKey][secondKey] = keyVal;
    }
  }
  ini_file.close();

  cout << "Read " + fileDir + " config file success." << endl;
  return true;
}

string IniFile::GetSecondKeyVal(string firstKey, string secondKey) {
  if (heads.find(firstKey) == heads.end()) {
    cerr << "First key : " + firstKey + " not found!" << endl;
    return "";
  }

  if (heads[firstKey].find(secondKey) == heads[firstKey].end()) {
    cerr << "Second key : " + secondKey + " not found!" << endl;
    return "";
  }

  if (verbose) {
    cout << "Read option : " + secondKey + " = " + heads[firstKey][secondKey]
         << endl;
  }
  return heads[firstKey][secondKey];
}
