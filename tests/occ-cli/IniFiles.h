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

\file IniFiles.h

\*****************************************************************************/

#ifndef _INI_FILES_
#define _INI_FILES_

#include <map>
#include <string>

class IniFile {
public:
  IniFile(std::string _fileDir, int _verbose = 0)
      : fileDir(_fileDir), verbose(_verbose) {}

  bool Open();
  std::string GetSecondKeyVal(std::string firstKey, std::string secondKey);

private:
  std::map<std::string, std::map<std::string, std::string>> heads;
  std::string fileDir;
  // verbose != 0 enable debug messages
  int verbose;
};

#endif // _INI_FILES_
