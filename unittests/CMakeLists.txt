#===----------------------------------------------------------------------===//
#
# Unit tests for opencl-clang.
#
#===----------------------------------------------------------------------===//

# Custom target that builds (but does not run) all opencl-clang unit tests.
add_custom_target(OpenCLClangUnitTests)
set_target_properties(OpenCLClangUnitTests PROPERTIES
  FOLDER "OpenCL-Clang Tests/Unit")

# Computed here (rather than inside the function below) because
# CMAKE_CURRENT_SOURCE_DIR in a CMake function reflects the caller's
# directory, not this file's directory.
set(OPENCL_CLANG_INTERNAL_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../include)

# add_opencl_clang_unittest(test_name source1 [source2 ...] [LINK_LIBS lib1 ...])
#
# Defines a gtest-based unit test executable for opencl-clang. This wraps
# LLVM's add_unittest() (see llvm/cmake/modules/AddLLVM.cmake) and additionally
# makes the opencl-clang internal headers directory (include/opencl-clang)
# available to the test sources.
#
# Arguments:
#   test_name    - Name of the test executable target.
#   source files - One or more .cpp files, including Google Test test cases and
#                  any helper translation units the test needs to link.
#   LINK_LIBS    - Optional list of additional libraries to link against.
function(add_opencl_clang_unittest test_name)
  cmake_parse_arguments(ARG "" "" "LINK_LIBS" ${ARGN})

  add_unittest(OpenCLClangUnitTests ${test_name} ${ARG_UNPARSED_ARGUMENTS})
  target_include_directories(${test_name} PRIVATE
    ${OPENCL_CLANG_INTERNAL_INCLUDE_DIR}
  )
  target_link_libraries(${test_name} PRIVATE ${ARG_LINK_LIBS})
endfunction()

add_subdirectory(Options)
