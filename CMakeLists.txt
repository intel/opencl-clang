project( common_clang )
cmake_minimum_required(VERSION 2.8.8)

# Do not omit TARGET_OBJECTS expression from the SOURCES target
# property
# `cmake --help-policy CMP0051` for details.
cmake_policy(SET CMP0051 NEW)
cmake_policy(SET CMP0057 NEW)
cmake_policy(SET CMP0022 NEW)

set(CMAKE_MODULE_PATH
  ${CMAKE_MODULE_PATH}
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")

include(CMakeFunctions)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(USE_PREBUILT_LLVM ON)

    add_definitions(-DUSE_PREBUILT_LLVM)

    if(NOT PREFERRED_LLVM_VERSION)
        set(PREFERRED_LLVM_VERSION "8.0.0")
    endif(NOT PREFERRED_LLVM_VERSION)
    message(STATUS "Looking for LLVM version ${PREFERRED_LLVM_VERSION}")
    find_package(LLVM ${PREFERRED_LLVM_VERSION} REQUIRED)

    message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
    message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")

    set(CMAKE_MODULE_PATH
      ${CMAKE_MODULE_PATH}
      ${LLVM_CMAKE_DIR})

    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    option(LLVMSPIRV_INCLUDED_IN_LLVM
      "Set to ON if libLLVMSPIRVLib is linked into libLLVM" ON)
    if(LLVMSPIRV_INCLUDED_IN_LLVM)
        message(STATUS "Assuming that libLLVMSPIRVLib is linked into libLLVM")
    else(LLVMSPIRV_INCLUDED_IN_LLVM)
        message(STATUS
          "Assuming that libLLVMSPIRVLib is NOT linked into libLLVM")
        if(NOT SPIRV_TRANSLATOR_DIR)
            message(FATAL_ERROR "SPIRV_TRANSLATOR_DIR is required")
        endif(NOT SPIRV_TRANSLATOR_DIR)
    endif(LLVMSPIRV_INCLUDED_IN_LLVM)
else(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(USE_PREBUILT_LLVM OFF)
endif(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)

include(AddLLVM)
include(TableGen)

find_package(Git REQUIRED)

if (NOT WIN32)
    add_subdirectory( linux_linker )
endif()

if (CMAKE_SIZEOF_VOID_P EQUAL 4)
    set(ADDR 32)
else ()
    set(ADDR 64)
endif (CMAKE_SIZEOF_VOID_P EQUAL 4)

# set windows binary suffix
if (WIN32)
    set (BUILD_PLATFORM ${ADDR})
else (WIN32)
    set (BUILD_PLATFORM "")
endif (WIN32)

# set that name of the main output file as a target name
if (NOT DEFINED COMMON_CLANG_LIBRARY_NAME)
    set(COMMON_CLANG_LIBRARY_NAME common_clang)
endif()
set(TARGET_NAME ${COMMON_CLANG_LIBRARY_NAME}${BUILD_PLATFORM} )

if(NOT USE_PREBUILT_LLVM)
    set(TARGET_BRANCH "ocl-open-80")
    set(CLANG_SOURCE_DIR ${LLVM_SOURCE_DIR}/tools/clang)
    set(CLANG_BASE_REVISION master)

    set(SPIRV_SOURCE_DIR ${LLVM_SOURCE_DIR}/projects/llvm-spirv)
    set(SPIRV_BASE_REVISION master)

    apply_patches(${CLANG_SOURCE_DIR}
                  ${CMAKE_CURRENT_SOURCE_DIR}/patches/clang
                  ${CLANG_BASE_REVISION}
                  ${TARGET_BRANCH})
    apply_patches(${SPIRV_SOURCE_DIR}
                  ${CMAKE_CURRENT_SOURCE_DIR}/patches/spirv
                  ${SPIRV_BASE_REVISION}
                  ${TARGET_BRANCH})
endif(NOT USE_PREBUILT_LLVM)

#
# TblGen the options include file
#
set (COMPILE_OPTIONS_TD  opencl_clang_options.td)
set (COMPILE_OPTIONS_INC opencl_clang_options.inc)

set(LLVM_TABLEGEN_EXE "llvm-tblgen")
set(LLVM_TARGET_DEFINITIONS ${COMPILE_OPTIONS_TD})
if(USE_PREBUILT_LLVM)
  set(TABLEGEN_ADDITIONAL -I ${LLVM_INCLUDE_DIRS})
else(USE_PREBUILT_LLVM)
  set(TABLEGEN_ADDITIONAL "")
endif(USE_PREBUILT_LLVM)
tablegen(LLVM ${COMPILE_OPTIONS_INC} -gen-opt-parser-defs ${TABLEGEN_ADDITIONAL})
add_public_tablegen_target(CClangCompileOptions)

#
# Source code
#
set(TARGET_INCLUDE_FILES
    common_clang.h
    options.h
    binary_result.h
    pch_mgr.h
    ${COMPILE_OPTIONS_TD}
    ${COMPILE_OPTIONS_INC}
)

set(TARGET_SOURCE_FILES
    common_clang.cpp
    options.cpp
    pch_mgr.cpp
    options_compile.cpp
)

#
# Resources
#

set( PRODUCT_VER_MAJOR 2 )
set( PRODUCT_VER_MINOR 0 )
set (LLVM_VER_MAJOR ${LLVM_VERSION_MAJOR} )
set (LLVM_VER_MINOR ${LLVM_VERSION_MINOR} )

if (WIN32)
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/common_clang.rc.in
        ${CMAKE_CURRENT_BINARY_DIR}/common_clang.rc
        @ONLY)
    list (APPEND TARGET_SOURCE_FILES ${CMAKE_CURRENT_BINARY_DIR}/common_clang.rc)
endif (WIN32)

add_definitions( -D__STDC_LIMIT_MACROS )
add_definitions( -D__STDC_CONSTANT_MACROS )
add_definitions( -DCOMMON_CLANG_EXPORTS )
if (NOT WIN32)
    add_definitions( -DLIBCOMMON_CLANG_NAME="lib${COMMON_CLANG_LIBRARY_NAME}.so")
endif()

#
# Include directories
#

if(NOT USE_PREBUILT_LLVM)
    set(CLANG_BINARY_DIR ${LLVM_BINARY_DIR}/tools/clang/)
    set(CLANG_SOURCE_DIR ${LLVM_MAIN_SRC_DIR}/tools/clang/)
    include_directories(
        ${CLANG_BINARY_DIR}/include # for tablegened includes
        ${CLANG_SOURCE_DIR}/include # for basic headers
        ${SPIRV_SOURCE_DIR}/include)
endif(NOT USE_PREBUILT_LLVM)

if(USE_PREBUILT_LLVM AND NOT LLVMSPIRV_INCLUDED_IN_LLVM)
    include_directories(${SPIRV_TRANSLATOR_DIR}/include)
    link_directories(${SPIRV_TRANSLATOR_DIR}/lib${LLVM_LIBDIR_SUFFIX})
endif(USE_PREBUILT_LLVM AND NOT LLVMSPIRV_INCLUDED_IN_LLVM)

include_directories( AFTER
            ${LLVM_INCLUDE_DIRS}
            ${CMAKE_CURRENT_BINARY_DIR}
            ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}
            )

link_directories(
    ${LLVM_LIBRARY_DIRS}
)

if (LLVM_LINK_LLVM_DYLIB)
  set (LLVM_LIBS LLVM)
else (LLVM_LINK_LLVM_DYLIB)
  set (LLVM_LIBS
    Analysis
    AsmParser
    AsmPrinter
    BitReader
    BitWriter
    CodeGen
    Core
    IRReader
    InstCombine
    Instrumentation
    MC
    MCDisassembler
    MCParser
    ObjCARCOpts
    Object
    Option
    ProfileData
    ScalarOpts
    SelectionDAG
    Support
    Target
    TransformUtils
    Vectorize
    X86AsmParser
    X86AsmPrinter
    X86CodeGen
    X86Desc
    X86Disassembler
    X86Info
    X86Utils)
endif (LLVM_LINK_LLVM_DYLIB)

if(NOT LLVM_LINK_LLVM_DYLIB OR (USE_PREBUILT_LLVM AND NOT LLVMSPIRV_INCLUDED_IN_LLVM))
    set(LLVM_LIBS ${LLVM_LIBS} SPIRVLib)
endif(NOT LLVM_LINK_LLVM_DYLIB OR (USE_PREBUILT_LLVM AND NOT LLVMSPIRV_INCLUDED_IN_LLVM))

add_subdirectory(cl_headers)

set(LLVM_REQUIRES_EH ON)

add_llvm_library(${TARGET_NAME} SHARED
  ${TARGET_INCLUDE_FILES}
  ${TARGET_SOURCE_FILES}
  $<TARGET_OBJECTS:cl_headers>

  DEPENDS CClangCompileOptions
  LINK_COMPONENTS
    ${LLVM_LIBS}
  LINK_LIBS
    clangARCMigrate
    clangAST
    clangAnalysis
    clangBasic
    clangCodeGen
    clangDriver
    clangEdit
    clangFrontend
    clangFrontendTool
    clangLex
    clangParse
    clangRewrite
    clangRewriteFrontend
    clangSema
    clangSerialization
    clangStaticAnalyzerCheckers
    clangStaticAnalyzerCore
    clangStaticAnalyzerFrontend
    ${CMAKE_DL_LIBS})

install(FILES common_clang.h
        DESTINATION include/cclang
        COMPONENT ${TARGET_NAME})

SET_LINUX_EXPORTS_FILE( ${TARGET_NAME} common_clang.map )

add_custom_target(deploy DEPENDS install-${TARGET_NAME})
