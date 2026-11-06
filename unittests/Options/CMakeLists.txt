#===----------------------------------------------------------------------===//
#
# Unit tests for opencl-clang's Options library (lib/Options): command-line
# tokenization, the TableGen-derived option table, and the option parser.
#
#===----------------------------------------------------------------------===//

set(LLVM_LINK_COMPONENTS
  Option
  Support
)

add_opencl_clang_unittest(OpenCLClangOptionsTests
  CommandLineTest.cpp
  OptionsTest.cpp
  OptionParserTest.cpp

  # OptionParser::process() reaches into BuiltInHeaders for the default
  # include search path. Rather than linking the real implementation (and
  # its embedded headers dependency), provide a lightweight mock definition
  # of BuiltInHeaders' functions.
  BuiltInHeadersMock.cpp

  LINK_LIBS opencl-clang-options
)

target_compile_definitions(OpenCLClangOptionsTests PRIVATE
  OPENCL_CLANG_NATIVE_TRIPLE="${OPENCL_CLANG_NATIVE_TRIPLE}")
