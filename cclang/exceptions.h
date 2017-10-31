/*****************************************************************************\

Copyright (c) Intel Corporation (2009-2017).

    INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE.  THIS CODE IS
    LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY SUPPORT,
    ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL DOES NOT
    PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY
    DISCLAIMS ANY WARRANTY OF MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR ANY
    PARTICULAR PURPOSE, OR ANY OTHER WARRANTY.  Intel disclaims all liability,
    including liability for infringement of any proprietary rights, relating to
    use of the code. No license, express or implied, by estoppel or otherwise,
    to any intellectual property rights is granted herein.

  \file exceptions.h

\*****************************************************************************/

#pragma once
#include <stdexcept>

/// macro for convenient definition of common clang exceptions
#define DEFINE_COMMON_CLANG_EXCEPTION(__name)                                      \
  class __name : public std::domain_error {                                    \
  public:                                                                      \
    __name(const std::string &str) : std::domain_error(str) {}                 \
  };

DEFINE_COMMON_CLANG_EXCEPTION(pch_error)
