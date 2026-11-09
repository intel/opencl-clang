//===----------------------------------------------------------------------===//
//
//  This file defines the options accepted by opencl-clang.
//
//===----------------------------------------------------------------------===//

include "llvm/Option/OptParser.td"

//===----------------------------------------------------------------------===//
// Common options
//===----------------------------------------------------------------------===//
def x : Separate<["-"], "x">,
  HelpText<"Specify the language of the input source code.">;
def s : Separate<["-"], "s">,
  HelpText<"Specify the source file name to use in diagnostics.">;

def triple : Separate<["-"], "triple">,
  HelpText<"Specify target triple (e.g. spir64-unknown-unknown).">;
def target_triple : Separate<["-"], "target-triple">,
  HelpText<"Specify target triple for SPIR (ignored).">;

def Xclang : Separate<["-"], "Xclang">,
  HelpText<"Pass argument to clang -cc1.">;

//===----------------------------------------------------------------------===//
// Preprocessor Options (language independent)
//===----------------------------------------------------------------------===//
def D : JoinedOrSeparate<["-"], "D">, Flags<[RenderJoined]>,
  HelpText<"Define a preprocessor macro.">;
def I : JoinedOrSeparate<["-"], "I">, Flags<[RenderJoined]>,
  HelpText<"Add directory to include search path.">;

//===----------------------------------------------------------------------===//
// Debugging and Profiling Options (language independent)
//===----------------------------------------------------------------------===//
def g : Flag<["-"], "g">, HelpText<"Generate source level debug information">;
def gline_tables_only : Flag<["-"], "gline-tables-only">,
  HelpText<"Generate line number information only. This is a less expensive "
           "alternative to -g that allows source level debugging of the "
           "program.">;

def profiling : Flag<["-"], "profiling">, HelpText<"Allow profiling">;
def coverage: Flag<["-"], "coverage">,
  HelpText<"Enable source level coverage analysis">;

//===----------------------------------------------------------------------===//
// OpenCL compiler options
//===----------------------------------------------------------------------===//

// Helpers for OpenCL compiler options. Note, that "-cl-" can't be used as an
// option prefix, as OptTable strips all the prefix characters from the
// beginning of an argument before looking it up, so e.g. "-coverage" wouldn't
// be recognized.
class CLFlag<string f> : Flag<["-"], "cl-" # f> {}
class CLJoinedEQ<string f> : Joined<["-"], "cl-" # f # "="> {}

//===----------------------------------------------------------------------===//
// 5.8.6.2 Math Intrinsics Options
//===----------------------------------------------------------------------===//
def cl_single_precision_constant : CLFlag<"single-precision-constant">,
  HelpText<"Force implicit conversions of double-precision floating-point "
           "literals to single precision.">;
def cl_denorms_are_zero : CLFlag<"denorms-are-zero">,
  HelpText<"Flush denormalized floating-point numbers to zero. This is a "
           "performance hint and the OpenCL compiler can choose to ignore it.">;
def cl_fp32_correctly_rounded_divide_sqrt :
  CLFlag<"fp32-correctly-rounded-divide-sqrt">,
  HelpText<"Specify that the single precision floating point divide and sqrt "
           "used in the program source are correctly rounded.">;

//===----------------------------------------------------------------------===//
// 5.8.6.3 Optimization Options
//===----------------------------------------------------------------------===//
def cl_opt_disable : CLFlag<"opt-disable">,
  HelpText<"Disable all optimizations. Optimizations are enabled by default.">;
def cl_uniform_work_group_size: CLFlag<"uniform-work-group-size">,
  HelpText<"This requires that the global work-size be a multiple of the "
           "work-group size specified to clEnqueueNDRangeKernel.">;
def cl_no_subgroup_ifp: CLFlag<"no-subgroup-ifp">,
  HelpText<"Kernels in this program do not require sub-groups to make "
           "independent forward progress.">;
def cl_mad_enable : CLFlag<"mad-enable">,
  HelpText<"Allow a * b + c to be replaced by a mad instruction.">;
def cl_no_signed_zeros : CLFlag<"no-signed-zeros">,
  HelpText<"Allow optimizations for floating-point arithmetic that ignore the "
           "signedness of zero.">;
def cl_unsafe_math_optimizations: CLFlag<"unsafe-math-optimizations">,
  HelpText<"Allow optimizations for floating-point arithmetic that may violate "
           "IEEE 754 rules. This option implies -cl-no-signed-zeros, "
           "-cl-mad-enable, and -cl-denorms-are-zero.">;
def cl_finite_math_only: CLFlag<"finite-math-only">,
  HelpText<"Allow optimizations for floating-point arithmetic that assume that "
           "arguments and results are not NaNs, +Inf, -Inf.">;
def cl_fast_relaxed_math: CLFlag<"fast-relaxed-math">,
  HelpText<"Sets the optimization options -cl-finite-math-only and "
           "-cl-unsafe-math-optimizations. This option causes the preprocessor "
           "macro __FAST_RELAXED_MATH__ to be defined in the OpenCL program.">;

//===----------------------------------------------------------------------===//
// 5.8.6.4 Options to Request or Suppress Warnings
//===----------------------------------------------------------------------===//
def w : Flag<["-"], "w">, HelpText<"Suppress all warnings.">;
def Werror : Flag<["-"], "Werror">, HelpText<"Treat warnings as errors.">;
def W_Joined : Joined<["-"], "W">, HelpText<"Enable/disable warning flags.">;
def W_Separate : Separate<["-"], "W">;

//===----------------------------------------------------------------------===//
// 5.8.6.5. Options Controlling the OpenCL C Version
//===----------------------------------------------------------------------===//
def cl_std : CLJoinedEQ<"std">,
  Values<"CL1.0,CL1.1,CL1.2,CL2.0,CL3.0,CL3.1,CLC++,CLC++1.0,CLC++2021">,
  HelpText<"Specify OpenCL language version.">;

//===----------------------------------------------------------------------===//
// 5.8.6.6. Options for Querying Kernel Argument Information
//===----------------------------------------------------------------------===//
def cl_kernel_arg_info: CLFlag<"kernel-arg-info">,
  HelpText<"Store information about the arguments of a kernel(s) in the "
           "program executable.">;

//===----------------------------------------------------------------------===//
// 5.8.7.3. SPIR Compilation Options
//===----------------------------------------------------------------------===//
def spir_std : Joined<["-"], "spir-std=">, Values<"1.0,1.2">,
  HelpText<"Specify the SPIR version to target. The default is 1.2.">;
