project( common_clang )
cmake_minimum_required(VERSION 2.8.8)

# Do not omit TARGET_OBJECTS expression from the SOURCES target
# property
# `cmake --help-policy CMP0051` for details.
cmake_policy(SET CMP0051 NEW)

find_package(Git REQUIRED)

if (NOT WIN32)
    add_subdirectory( linux_linker )
endif()
#
# Set compiler RTTI options according to the given flag
#
macro(use_rtti val)
    if( CMAKE_COMPILER_IS_GNUCXX OR "${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
        if( ${val} )
            llvm_replace_compiler_option(CMAKE_CXX_FLAGS "-fno-rtti" "-frtti")
        else()
            llvm_replace_compiler_option(CMAKE_CXX_FLAGS "-frtti" "-fno-rtti" )
        endif()
    else(MSVC)
        if( ${val} )
            llvm_replace_compiler_option(CMAKE_CXX_FLAGS "/GR-" "/GR")
        else()
            llvm_replace_compiler_option(CMAKE_CXX_FLAGS "/GR" "/GR-" )
        endif()
    endif()
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" PARENT_SCOPE )
endmacro(use_rtti)

#
# Set compiler Exception Handling options according to the given flag
#
macro(use_eh val)
    if( CMAKE_COMPILER_IS_GNUCXX OR "${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
        if( ${val} )
            remove_definitions( -fno-exceptions )
        else()
            add_definitions( -fno-exceptions )
        endif()
    else(MSVC)
        if( ${val} )
              llvm_replace_compiler_option(CMAKE_CXX_FLAGS "/EHs-c-" "/EHsc" )
              add_definitions( /D_HAS_EXCEPTIONS=1 )
        else()
              llvm_replace_compiler_option(CMAKE_CXX_FLAGS "/EHsc" "/EHs-c-")
              add_definitions( /D_HAS_EXCEPTIONS=0 )
        endif()
    endif()
endmacro(use_eh)

macro(catFiles outFileName)
    file(WRITE ${outFileName} "")
    foreach(file ${ARGN})
        file(READ ${file} CONTENT)
        file(APPEND ${outFileName} "${CONTENT}")
    endforeach(file)
endmacro(catFiles)

use_eh(TRUE)
use_rtti(FALSE)

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

function(apply_patches repo_dir patches_dir revision_to_patch)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
        WORKING_DIRECTORY ${repo_dir}
        OUTPUT_VARIABLE CURRENT_HASH
    )
    if(NOT ${CURRENT_HASH} EQUAL ${revision_to_patch})
        message(STATUS "Skip patching of ${repo_dir}. Expected revision: ${revision_to_patch}")
        execute_process(
            COMMAND ${GIT_EXECUTABLE} log -1 --oneline --decorate
            WORKING_DIRECTORY ${repo_dir}
            OUTPUT_VARIABLE CURRENT_BRANCH
            ERROR_QUIET
        )
        message(STATUS "Current revision: ${CURRENT_BRANCH}")
        return()
    endif(NOT ${CURRENT_HASH} EQUAL ${revision_to_patch})

    file(GLOB patches ${patches_dir}/*.patch)
    if(NOT patches)
        return()
    endif()
    list(SORT patches)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} checkout -b patched
        WORKING_DIRECTORY ${repo_dir}
    )
    execute_process(
        COMMAND ${GIT_EXECUTABLE} am --3way --ignore-whitespace ${patches}
        WORKING_DIRECTORY ${repo_dir}
    )
endfunction()

set(CLANG_SOURCE_DIR ${LLVM_SOURCE_DIR}/tools/clang)
set(CLANG_REVISION a007b984aefa2192b58a534ce3087f43cd21fb27)

set(SPIRV_SOURCE_DIR ${LLVM_SOURCE_DIR}/projects/llvm-spirv)
set(SPIRV_REVISION 0c03e7a66f25c83dbd3d14e74ced9ace51ecb9d7)

apply_patches(${CLANG_SOURCE_DIR}
              ${CMAKE_CURRENT_SOURCE_DIR}/patches/clang
              ${CLANG_REVISION})
apply_patches(${SPIRV_SOURCE_DIR}
              ${CMAKE_CURRENT_SOURCE_DIR}/patches/spirv
              ${SPIRV_REVISION})

#
# TblGen the options include file
#
set (COMPILE_OPTIONS_TD  opencl_clang_options.td)
set (COMPILE_OPTIONS_INC opencl_clang_options.inc)

set(LLVM_TARGET_DEFINITIONS ${COMPILE_OPTIONS_TD})
tablegen(LLVM ${COMPILE_OPTIONS_INC} -gen-opt-parser-defs)
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
set (LLVM_VER_MAJOR 7 )
set (LLVM_VER_MINOR 0 )

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

set(CLANG_BINARY_DIR ${LLVM_BINARY_DIR}/tools/clang/)
set(CLANG_SOURCE_DIR ${LLVM_MAIN_SRC_DIR}/tools/clang/)

include_directories( AFTER
            ${CLANG_BINARY_DIR}/include # for tablegened includes
            ${CLANG_SOURCE_DIR}/include # for basic headers
            ${CMAKE_CURRENT_BINARY_DIR}
            ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}
            ${SPIRV_SOURCE_DIR}/include
            )

link_directories(
    ${LLVM_LIBRARY_DIRS}
)

add_subdirectory(cl_headers)

add_library(${TARGET_NAME} SHARED
    ${TARGET_INCLUDE_FILES}
    ${TARGET_SOURCE_FILES}
    $<TARGET_OBJECTS:cl_headers>
)

add_dependencies(${TARGET_NAME} CClangCompileOptions)

install(TARGETS ${TARGET_NAME}
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib)

install(FILES
        common_clang.h
        DESTINATION include/cclang)

# The list of clang libraries is taken from clang makefile
# (build/tools/clang/tools/driver/CMakeFiles/clang.dir/build.make)
# All duplicate libraries are there on purpose
target_link_libraries( ${TARGET_NAME}
                       LINK_PRIVATE
                       LLVMAnalysis
                       LLVMAsmParser
                       LLVMAsmPrinter
                       LLVMBitReader
                       LLVMBitWriter
                       LLVMCodeGen
                       LLVMCore
                       LLVMIRReader
                       LLVMInstCombine
                       LLVMInstrumentation
                       LLVMMC
                       LLVMMCDisassembler
                       LLVMMCParser
                       LLVMObjCARCOpts
                       LLVMObject
                       LLVMOption
                       LLVMProfileData
                       LLVMSPIRVLib
                       LLVMScalarOpts
                       LLVMSelectionDAG
                       LLVMSupport
                       LLVMTarget
                       LLVMTransformUtils
                       LLVMVectorize
                       LLVMX86AsmParser
                       LLVMX86AsmPrinter
                       LLVMX86CodeGen
                       LLVMX86Desc
                       LLVMX86Disassembler
                       LLVMX86Info
                       LLVMX86Utils
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
                       ${CMAKE_DL_LIBS}
                      )

if (NOT WIN32)
    list(APPEND LINK_LIBS pthread)
endif ()
