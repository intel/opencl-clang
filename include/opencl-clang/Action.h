//===--- Action.h - Base class for the frontend wrapper actions -*- C++ -*-===//
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

#ifndef OPENCL_CLANG_ACTION_H
#define OPENCL_CLANG_ACTION_H

#include "llvm/Support/Error.h"

template <typename ActionImpl, typename InputT, typename OutputT> class Action {
public:
  using InputType = InputT;
  using OutputType = OutputT;

  llvm::Expected<OutputType> run(llvm::Expected<InputType> &&Input) {
    if (!Input)
      return Input.takeError();
    return static_cast<ActionImpl *>(this)->runImpl(std::move(*Input));
  }

  Action(const Action &) = delete;
  Action(Action &&) = delete;
  Action &operator=(const Action &) = delete;
  Action &operator=(Action &&) = delete;

  virtual ~Action() = default;

protected:
  Action() = default;
};

#endif // OPENCL_CLANG_ACTION_H
