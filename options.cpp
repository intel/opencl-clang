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

  \file options.cpp

\*****************************************************************************/

#include "options.h"

#include "llvm/Option/Arg.h"
#include "clang/Driver/Options.h"

#include <iterator>
#include <sstream>

using namespace llvm::opt;

OpenCLArgList::OpenCLArgList(const char *pszOptions) {
  std::back_insert_iterator<ArgsVector> it(
      std::back_inserter(m_synthesizedStrings));
  quoted_tokenize(it, pszOptions, " \t", '"', '\\');

  // need to be careful about the reallocation that could happen in
  // m_synthesizedStrings upon push_back
  for (ArgsVector::const_iterator it = m_synthesizedStrings.begin(),
                                  end = m_synthesizedStrings.end();
       it != end; ++it) {
    m_argStrings.push_back(it->c_str());
  }
  m_uiOriginalArgsCount = m_argStrings.size();
}

unsigned OpenCLArgList::MakeIndex(llvm::StringRef str) const {
  unsigned index = m_argStrings.size();

  // Tuck away so we have a reliable const char *.
  m_synthesizedStrings.push_back(std::string(str));
  m_argStrings.push_back(m_synthesizedStrings.back().c_str());

  return index;
}

unsigned OpenCLArgList::MakeIndex(llvm::StringRef str0,
                                  llvm::StringRef str1) const {
  unsigned index0 = MakeIndex(str0);
  unsigned index1 = MakeIndex(str1);
  assert(index0 + 1 == index1 && "Unexpected non-consecutive indices!");
  (void)index1;
  return index0;
}

const char *OpenCLArgList::MakeArgStringRef(llvm::StringRef str) const {
  return getArgString(MakeIndex(str));
}

std::string OpenCLArgList::getFilteredArgs(int id) const {
  std::stringstream ss;
  for (const auto &I : filtered(id)) {
    ss << I->getAsString(*this) << ' ';
  }
  return ss.str();
}

OpenCLArgList *OpenCLOptTable::ParseArgs(const char *szOptions,
                                         unsigned &missingArgIndex,
                                         unsigned &missingArgCount) const {
  std::unique_ptr<OpenCLArgList> pArgs(new OpenCLArgList(szOptions));

  // FIXME: Handle '@' args (or at least error on them).

  missingArgIndex = missingArgCount = 0;
  unsigned index = 0, argsCount = pArgs->getNumInputArgStrings();
  while (index < argsCount) {
    // Ignore empty arguments (other things may still take them as arguments).
    if (pArgs->getArgString(index)[0] == '\0') {
      ++index;
      continue;
    }

    unsigned prev = index;
    std::unique_ptr<Arg> pArg = ParseOneArg(*pArgs, index);
    assert(index > prev && "Parser failed to consume argument.");

    // Check for missing argument error.
    if (!pArg) {
      assert(index >= argsCount && "Unexpected parser error.");
      assert(index - prev - 1 && "No missing arguments!");
      missingArgIndex = prev;
      missingArgCount = index - prev - 1;
      break;
    }

    pArgs->append(pArg.get());
    m_synthesizedArgs.emplace_back(std::move(pArg));
  }
  return pArgs.release();
}
