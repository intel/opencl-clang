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

\file common.h

\*****************************************************************************/

#ifndef _COMMON_
#define _COMMON_

#include <string>
#include <fstream>

std::string readFile(const std::string &filename, std::ios_base::openmode mode = std::ios_base::in);

#endif // _COMMON_
