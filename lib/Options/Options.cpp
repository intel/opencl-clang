//===--- Options.cpp - Option table definitions -----------------*- C++ -*-===//
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

#include "Options.h"

#include "llvm/ADT/StringExtras.h"
#include "llvm/Config/llvm-config.h"
#include "llvm/Option/Option.h"

#include <iterator>

using namespace llvm;
using namespace llvm::opt;

namespace {
#if LLVM_VERSION_MAJOR >= 24
#define OPTTABLE_CODE
#include "Options.inc"
#undef OPTTABLE_CODE

class OptionTable : public OptTable {
public:
  OptionTable() : OptTable(optionTables()) {}
};
#else // LLVM_VERSION_MAJOR >= 24
#if LLVM_VERSION_MAJOR >= 20
#define OPTTABLE_STR_TABLE_CODE
#include "Options.inc"
#undef OPTTABLE_STR_TABLE_CODE

#define OPTTABLE_PREFIXES_TABLE_CODE
#include "Options.inc"
#undef OPTTABLE_PREFIXES_TABLE_CODE
#elif LLVM_VERSION_MAJOR >= 16
#define PREFIX(NAME, VALUE)                                                    \
  constexpr StringLiteral NAME##_init[] = VALUE;                               \
  constexpr ArrayRef<StringLiteral> NAME(NAME##_init,                          \
                                         std::size(NAME##_init) - 1);
#include "Options.inc"
#undef PREFIX
#else // LLVM_VERSION_MAJOR >= 16
#define PREFIX(NAME, VALUE) constexpr const char *const NAME[] = VALUE;
#include "Options.inc"
#undef PREFIX
#endif // LLVM_VERSION_MAJOR >= 20

constexpr OptTable::Info InfoTable[] = {
#if LLVM_VERSION_MAJOR >= 18
#define OPTION(...) LLVM_CONSTRUCT_OPT_INFO(__VA_ARGS__),
#else // LLVM_VERSION_MAJOR >= 18
#define OPTION(PREFIX, NAME, ID, KIND, GROUP, ALIAS, ALIASARGS, FLAGS, PARAM,  \
               HELPTEXT, METAVAR, VALUES)                                      \
  {PREFIX, NAME,  HELPTEXT,    METAVAR,     OPT_##ID,  Option::KIND##Class,    \
   PARAM,  FLAGS, OPT_##GROUP, OPT_##ALIAS, ALIASARGS, VALUES},
#endif // LLVM_VERSION_MAJOR >= 18
#include "Options.inc"
#undef OPTION
};

#if LLVM_VERSION_MAJOR >= 16
class OptionTable : public GenericOptTable {
public:
#if LLVM_VERSION_MAJOR >= 20
  OptionTable()
      : GenericOptTable(OptionStrTable, OptionPrefixesTable, InfoTable) {}
#else  // LLVM_VERSION_MAJOR >= 20
  OptionTable() : GenericOptTable(InfoTable) {}
#endif // LLVM_VERSION_MAJOR >= 20
};
#else  // LLVM_VERSION_MAJOR >= 16
class OptionTable : public OptTable {
public:
  OptionTable() : OptTable(InfoTable) {}
};
#endif // LLVM_VERSION_MAJOR >= 16
#endif // LLVM_VERSION_MAJOR >= 24
} // namespace

const OptTable &getOptTable() {
  static OptionTable TheOptTable;
  return TheOptTable;
}

SmallVector<StringRef> getOptionValuesSplit(OptionID ID) {
  SmallVector<StringRef> Values;
  StringRef CommaSeparatedValues = getOptionValues(ID);
  SplitString(CommaSeparatedValues, Values, ",");
  return Values;
}

StringRef getOptionValues(OptionID ID) {
  // The option info table is indexed by (ID - 1), matching
  // OptTable::getInfo. The Values field holds the comma-separated Values<>
  // list from Options.td.
  const unsigned Index = static_cast<unsigned>(ID);
#if LLVM_VERSION_MAJOR >= 24
  static const OptTable::Tables Tables = optionTables();
  if (Index == 0 || Index > Tables.Infos.size())
    return {};
  const OptTable::Info &Info = Tables.Infos[Index - 1];
  return Tables.StrTable[Tables.InfoExtras[Info.ExtraOffset].ValuesOffset];
#else  // LLVM_VERSION_MAJOR >= 24
  if (Index == 0 || Index > std::size(InfoTable))
    return {};
  return InfoTable[Index - 1].Values;
#endif // LLVM_VERSION_MAJOR >= 24
}
