//===----------------------------------------------------------------------===//
//
//  This file defines the options accepted by common_clang.
//
//===----------------------------------------------------------------------===//

// Include the common option parsing interfaces.
include "llvm/Option/OptParser.td"

def s : Separate<["-"], "s">;
def cl_denorms_are_zero : Flag<["-"], "cl-denorms-are-zero">;
def cl_no_signed_zeroes : Flag<["-"], "cl-no-signed-zeroes">;
def cl_unsafe_math_optimizations: Flag<["-"], "cl-unsafe-math-optimizations">;
def cl_finite_math_only: Flag<["-"], "cl-finite-math-only">;
def cl_fast_relaxed_math: Flag<["-"], "cl-fast-relaxed-math">;
def create_library: Flag<["-"], "create-library">;
def enable_link_options: Flag<["-"], "enable-link-options">;
def dump_opt_llvm : Joined<["-"], "dump-opt-llvm=">;
def dump_opt_asm : Joined<["-"], "dump-opt-asm=">;

