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

  \file options_link.cpp

\*****************************************************************************/

#include "options.h"

#define PREFIX(NAME, VALUE) const char *const NAME[] = VALUE;
#define OPTION(PREFIX, NAME, ID, KIND, GROUP, ALIAS, ALIASARGS, FLAGS, PARAM,  \
               HELPTEXT, METAVAR)
#include "opencl_link_options.inc"
#undef OPTION
#undef PREFIX

static const llvm::opt::OptTable::Info ClangOptionsInfoTable[] = {
#define PREFIX(NAME, VALUE)
#define OPTION(PREFIX, NAME, ID, KIND, GROUP, ALIAS, ALIASARGS, FLAGS, PARAM,  \
               HELPTEXT, METAVAR)                                              \
  {                                                                            \
    PREFIX, NAME, HELPTEXT, METAVAR, OPT_LINK_##ID,                            \
        llvm::opt::Option::KIND##Class, PARAM, FLAGS, OPT_LINK_##GROUP,        \
        OPT_LINK_##ALIAS, ALIASARGS                                            \
  }                                                                            \
  ,
#include "opencl_link_options.inc"
};

OpenCLLinkOptTable::OpenCLLinkOptTable()
    : OpenCLOptTable(ClangOptionsInfoTable) {}
