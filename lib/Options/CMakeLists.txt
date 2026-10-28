#
# TblGen the options include file
#
find_program(LLVM_TABLEGEN_EXE "llvm-tblgen" ${LLVM_TOOLS_BINARY_DIR})

set(TABLEGEN_ADDITIONAL "")
if(USE_PREBUILT_LLVM)
  list(APPEND TABLEGEN_ADDITIONAL -I ${LLVM_INCLUDE_DIRS})
endif()

set(LLVM_TARGET_DEFINITIONS Options.td)
llvm_tablegen(Options.inc -gen-opt-parser-defs ${TABLEGEN_ADDITIONAL})
add_public_tablegen_target(opencl-clang-options-tablegen)

add_library(opencl-clang-options OBJECT
  CommandLine.cpp
  OptionParser.cpp
  Options.cpp
)
add_dependencies(opencl-clang-options opencl-clang-options-tablegen)
target_compile_definitions(opencl-clang-options PRIVATE
  OPENCL_CLANG_NATIVE_TRIPLE="${OPENCL_CLANG_NATIVE_TRIPLE}")
target_include_directories(opencl-clang-options
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/..
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  INTERFACE ${CMAKE_CURRENT_BINARY_DIR})
set_target_properties(opencl-clang-options PROPERTIES
  POSITION_INDEPENDENT_CODE ON)

llvm_update_compile_flags(opencl-clang-options)
