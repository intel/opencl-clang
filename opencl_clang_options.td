//===----------------------------------------------------------------------===//
//
//  This file defines the options accepted by common_clang.
//
//===----------------------------------------------------------------------===//

// Include the common option parsing interfaces.
include "llvm/Option/OptParser.td"


//===----------------------------------------------------------------------===//
// OpenCL Options
//===----------------------------------------------------------------------===//
def g_Flag : Flag<["-"], "g">, HelpText<"Generate source level debug information">;
def gline_tables_only_Flag : Flag<["-"], "gline-tables-only">;
def profiling : Flag<["-"], "profiling">, HelpText<"Allow profiling">;
def w : Flag<["-"], "w">, HelpText<"Suppress all warnings">;
def D : JoinedOrSeparate<["-"], "D">;
def I : JoinedOrSeparate<["-"], "I">, Flags<[RenderJoined]>, HelpText<"Add directory to include search path">;
def s : Separate<["-"], "s">;
def Werror : Flag<["-"], "Werror">;
def cl_single_precision_constant : Flag<["-"], "cl-single-precision-constant">;
def cl_denorms_are_zero : Flag<["-"], "cl-denorms-are-zero">;
def cl_fp32_correctly_rounded_divide_sqrt : Flag<["-"], "cl-fp32-correctly-rounded-divide-sqrt">;
def cl_opt_disable : Flag<["-"], "cl-opt-disable">;
def cl_mad_enable : Flag<["-"], "cl-mad-enable">;
def cl_no_signed_zeros : Flag<["-"], "cl-no-signed-zeros">;
def cl_unsafe_math_optimizations: Flag<["-"], "cl-unsafe-math-optimizations">;
def cl_finite_math_only: Flag<["-"], "cl-finite-math-only">;
def cl_fast_relaxed_math: Flag<["-"], "cl-fast-relaxed-math">;
def cl_kernel_arg_info: Flag<["-"], "cl-kernel-arg-info">;
def cl_std_CL1_1: Flag<["-"], "cl-std=CL1.1">;
def cl_std_CL1_2: Flag<["-"], "cl-std=CL1.2">;
def cl_std_CL2_0: Flag<["-"], "cl-std=CL2.0">;
def cl_std_CL3_0: Flag<["-"], "cl-std=CL3.0">;
def cl_uniform_work_group_size: Flag<["-"], "cl-uniform-work-group-size">;
def cl_no_subgroup_ifp: Flag<["-"], "cl-no-subgroup-ifp">;
def triple : Separate<["-"], "triple">,  HelpText<"Specify target triple (e.g. i686-apple-darwin9)">;
def target_triple : Separate<["-"], "target-triple">,  HelpText<"Specify target triple for spir">;
def spir_std_1_0: Flag<["-"], "spir-std=1.0">;
def spir_std_1_2: Flag<["-"], "spir-std=1.2">;
def x : Separate<["-"], "x">;
