cmake_minimum_required(VERSION 3.13.4)

if(NOT DEFINED BASE_LLVM_VERSION)
  set(BASE_LLVM_VERSION 16.0.0)
endif(NOT DEFINED BASE_LLVM_VERSION)
set(OPENCL_CLANG_VERSION ${BASE_LLVM_VERSION}.0)

if(NOT DEFINED OPENCL_CLANG_BUILD_EXTERNAL)
  # check if we build inside llvm or not
  if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(OPENCL_CLANG_BUILD_EXTERNAL YES)
  endif(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
endif(NOT DEFINED OPENCL_CLANG_BUILD_EXTERNAL)

if(OPENCL_CLANG_BUILD_EXTERNAL)
  project(OPENCL_CLANG
    VERSION
    ${OPENCL_CLANG_VERSION}
    LANGUAGES
      CXX
      C
  )
endif()

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

if(LLVM_USE_HOST_TOOLS AND OPENCL_CLANG_BUILD_EXTERNAL)
  include(CrossCompile)
  llvm_create_cross_target(${PROJECT_NAME} NATIVE "" Release)
endif()

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(USE_PREBUILT_LLVM ON)

    add_definitions(-DUSE_PREBUILT_LLVM)

    if(NOT PREFERRED_LLVM_VERSION)
        set(PREFERRED_LLVM_VERSION "16.0.0")
    endif(NOT PREFERRED_LLVM_VERSION)
    message(STATUS "[OPENCL-CLANG] Looking for LLVM version ${PREFERRED_LLVM_VERSION}")
    find_package(LLVM ${PREFERRED_LLVM_VERSION} REQUIRED)

    message(STATUS "[OPENCL-CLANG] Using LLVMConfig.cmake in: ${LLVM_DIR}")
    message(STATUS "[OPENCL-CLANG] Found LLVM ${LLVM_PACKAGE_VERSION}")

    set(CMAKE_MODULE_PATH
      ${CMAKE_MODULE_PATH}
      ${LLVM_CMAKE_DIR})

    set(CMAKE_CXX_STANDARD 14)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    option(LLVMSPIRV_INCLUDED_IN_LLVM
      "Set to ON if libLLVMSPIRVLib is linked into libLLVM" ON)
    if(LLVMSPIRV_INCLUDED_IN_LLVM)
        message(STATUS "[OPENCL-CLANG] Assuming that libLLVMSPIRVLib is linked into libLLVM")
    else(LLVMSPIRV_INCLUDED_IN_LLVM)
        message(STATUS
          "[OPENCL-CLANG] Assuming that libLLVMSPIRVLib is NOT linked into libLLVM")
        if(NOT SPIRV_TRANSLATOR_DIR)
            message(FATAL_ERROR "[OPENCL-CLANG] SPIRV_TRANSLATOR_DIR is required")
        endif(NOT SPIRV_TRANSLATOR_DIR)
    endif(LLVMSPIRV_INCLUDED_IN_LLVM)
else(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(USE_PREBUILT_LLVM OFF)
    find_package(Git REQUIRED)
endif(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)

include(AddLLVM)
include(TableGen)

if (NOT WIN32)
    add_subdirectory( linux_linker bin)
endif()

use_rtti(FALSE)
use_eh(TRUE)

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
if (NOT DEFINED OPENCL_CLANG_LIBRARY_NAME)
    set(OPENCL_CLANG_LIBRARY_NAME "opencl-clang")
endif()
set(TARGET_NAME ${OPENCL_CLANG_LIBRARY_NAME}${BUILD_PLATFORM} )

# PCH_EXTENSION can override PCH extension map in options_compile.cpp.
# Example: "cl_khr_3d_image_writes,cl_khr_depth_images"
set(PCH_EXTENSION "" CACHE STRING "Comma-separated list of OpenCL extensions")
if (NOT "${PCH_EXTENSION}" STREQUAL "")
  add_definitions(-DPCH_EXTENSION="${PCH_EXTENSION}")
endif()

if(NOT USE_PREBUILT_LLVM)

    if(NOT LLVM_EXTERNAL_CLANG_SOURCE_DIR)
        set(CLANG_SOURCE_DIR ${LLVM_SOURCE_DIR}/tools/clang)
    elseif(EXISTS "${LLVM_EXTERNAL_CLANG_SOURCE_DIR}/CMakeLists.txt")
        set(CLANG_SOURCE_DIR "${LLVM_EXTERNAL_CLANG_SOURCE_DIR}")
    endif()
    if(EXISTS ${CLANG_SOURCE_DIR})
        message(STATUS "[OPENCL-CLANG] Using Clang source code direcotry: ${CLANG_SOURCE_DIR}")
    else()
        message(FATAL_ERROR
            "[OPENCL-CLANG] Can't find Clang source code directory!\n"
            "If you are using LLVM monorepo:\n"
            "  1. Clean CMake cache: `rm CMakeCache.txt`\n"
            "  2. Enable Clang project with `-DLLVM_ENABLE_PROJECTS=\"clang\"` option\n"
            "If Clang is used as a separate repository (not monorepo), it should "
            "be checked out at `llvm/tools/clang`."
        )
    endif()

    if(NOT LLVM_EXTERNAL_LLVM_SPIRV_SOURCE_DIR)
        set(SPIRV_SOURCE_DIR ${LLVM_SOURCE_DIR}/projects/llvm-spirv)
    elseif(EXISTS "${LLVM_EXTERNAL_LLVM_SPIRV_SOURCE_DIR}/CMakeLists.txt")
        set(SPIRV_SOURCE_DIR ${LLVM_EXTERNAL_LLVM_SPIRV_SOURCE_DIR})
    endif()
    if(EXISTS ${SPIRV_SOURCE_DIR})
        message(STATUS "[OPENCL-CLANG] Using SPIRV-LLVM-Translator source code directory: ${SPIRV_SOURCE_DIR}")
    else()
        message(FATAL_ERROR
            "[OPENCL-CLANG] Can't find SPIRV-LLVM-Translator source code dir!\n"
            "If you are using LLVM monorepo, SPIRV-LLVM-Translator should be checked out "
            "at '<monorepo_root_dir>/llvm-spirv' and it should be enabled as an external LLVM "
            "project using the following 2 options:\n"
            "  -DLLVM_EXTERNAL_PROJECTS=\"opencl-clang;llvm-spirv\"\n"
            "  -DLLVM_EXTERNAL_LLVM_SPIRV_SOURCE_DIR=\"<monorepo_root_dir>/llvm-spirv\"\n"
            "If you are not using LLVM monorepo, SPIRV-LLVM-Translator should be checked "
            "out at `llvm/projects/llvm-spirv`"
        )
    endif()

    set(CLANG_BASE_REVISION master)
    set(SPIRV_BASE_REVISION master)
    set(TARGET_BRANCH "ocl-open-110")

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

find_program(LLVM_TABLEGEN_EXE "llvm-tblgen" ${LLVM_TOOLS_BINARY_DIR})
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
    opencl_clang.h
    options.h
    binary_result.h
    pch_mgr.h
    ${COMPILE_OPTIONS_TD}
    ${COMPILE_OPTIONS_INC}
)

set(TARGET_SOURCE_FILES
    opencl_clang.cpp
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

add_definitions( -D__STDC_LIMIT_MACROS )
add_definitions( -D__STDC_CONSTANT_MACROS )
add_definitions( -DOPENCL_CLANG_EXPORTS )

#
# Include directories
#

if(NOT USE_PREBUILT_LLVM)
    set(CLANG_BINARY_DIR ${LLVM_BINARY_DIR}/tools/clang/)
    include_directories(
        ${CLANG_BINARY_DIR}/include  # for tablegened includes
        ${CLANG_SOURCE_DIR}/include  # for basic headers
        ${SPIRV_SOURCE_DIR}/include) # for SPIRV headers
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

set(OPENCL_CLANG_LINK_LIBS ${CMAKE_DL_LIBS})

if(NOT LLVMSPIRVLib IN_LIST LLVM_AVAILABLE_LIBS OR (USE_PREBUILT_LLVM AND LLVM_LINK_LLVM_DYLIB))
  # SPIRV-LLVM-Translator is not included into LLVM as a component.
  # So, we need to list it here explicitly as an external library
  list(APPEND OPENCL_CLANG_LINK_LIBS LLVMSPIRVLib)
endif()

add_subdirectory(cl_headers)

set(LLVM_REQUIRES_EH ON)

if(USE_PREBUILT_LLVM OR CLANG_LINK_CLANG_DYLIB)
  list(APPEND OPENCL_CLANG_LINK_LIBS clang-cpp)
else()
  list(APPEND OPENCL_CLANG_LINK_LIBS
# The list of clang libraries is taken from clang makefile
# (build/tools/clang/tools/driver/CMakeFiles/clang.dir/link.txt)
# All duplicate libraries are there on purpose
    clangBasic
    clangCodeGen
    clangDriver
    clangFrontend
    clangFrontendTool
    clangCodeGen
    clangRewriteFrontend
    clangARCMigrate
    clangStaticAnalyzerFrontend
    clangStaticAnalyzerCheckers
    clangStaticAnalyzerCore
    clangCrossTU
    clangIndex
    clangFrontend
    clangDriver
    clangParse
    clangSerialization
    clangSema
    clangAnalysis
    clangEdit
    clangFormat
    clangToolingInclusions
    clangToolingCore
    clangRewrite
    clangASTMatchers
    clangAST
    clangLex
    clangBasic
  )
endif()

add_library(${TARGET_NAME} SHARED
    ${TARGET_INCLUDE_FILES}
    ${TARGET_SOURCE_FILES}
    $<TARGET_OBJECTS:cl_headers>
)

# Same CRT compile option are reqiured to avoid link errors on Windows.
# MD and MDd are choosed by default for release and debug build in LLVM.
# If users set MT or MTd flags, they also need to add the flags for
# opencl-clang sources using a custom macro set_msvc_crt_flags.
if(COMMAND set_msvc_crt_flags)
    set_msvc_crt_flags(${TARGET_NAME})
endif()

add_dependencies(${TARGET_NAME} CClangCompileOptions)

if (WIN32)
    # Enable compiler generation of Control Flow Guard security checks.
    target_compile_options(${TARGET_NAME} PUBLIC "/guard:cf")
    set_property(TARGET ${TARGET_NAME} APPEND_STRING PROPERTY
        LINK_FLAGS "/DYNAMICBASE /GUARD:CF")

elseif(UNIX)
    set_property(TARGET ${TARGET_NAME} APPEND_STRING PROPERTY
        COMPILE_DEFINITIONS LIBOPENCL_CLANG_NAME="$<TARGET_SONAME_FILE_NAME:${TARGET_NAME}>")

    set_property(TARGET ${TARGET_NAME} APPEND_STRING PROPERTY
        LINK_FLAGS " -Wl,--no-undefined")
endif(WIN32)

# Enable new IN_LIST operator.
cmake_policy(SET CMP0057 NEW)
set(OTHER_LIBRARIES)
if ("NVPTX" IN_LIST LLVM_TARGETS_TO_BUILD)
    list(APPEND OTHER_LIBRARIES LLVMNVPTXCodeGen LLVMNVPTXDesc LLVMNVPTXInfo)
endif()
if ("AMDGPU" IN_LIST LLVM_TARGETS_TO_BUILD)
    list(APPEND OTHER_LIBRARIES LLVMAMDGPUCodeGen LLVMAMDGPUAsmParser LLVMAMDGPUDesc LLVMAMDGPUInfo)
endif()

target_link_libraries( ${TARGET_NAME}
                       LINK_PRIVATE
                       ${OPENCL_CLANG_LINK_LIBS}
                       LLVMX86CodeGen
                       LLVMX86AsmParser
                       LLVMX86Desc
                       LLVMX86Info
                       LLVMX86Disassembler
                       LLVMAnalysis
                       LLVMCodeGen
                       LLVMCore
                       LLVMipo
                       LLVMInstCombine
                       LLVMInstrumentation
                       LLVMMC
                       LLVMMCParser
                       LLVMObjCARCOpts
                       LLVMOption
                       LLVMScalarOpts
                       LLVMSupport
                       LLVMTransformUtils
                       LLVMVectorize
                       LLVMAsmPrinter
                       LLVMSelectionDAG
                       LLVMMCDisassembler
                       LLVMProfileData
                       LLVMObject
                       LLVMBitWriter
                       LLVMIRReader
                       LLVMAsmParser
                       LLVMTarget
                       LLVMBitReader
                       ${OTHER_LIBRARIES}
                      )

install(FILES opencl_clang.h
        DESTINATION include/cclang
        COMPONENT ${TARGET_NAME})

#
# Stripped PDB files
#
if (WIN32)
    get_target_property(RT_OUTPUT_DIRECTORY ${TARGET_NAME} RUNTIME_OUTPUT_DIRECTORY)
    file(TO_NATIVE_PATH ${RT_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/${TARGET_NAME}_stripped.pdb PDB_NAME)
    if (${MSVC_VERSION} EQUAL 1500)
        # Visual Studio 2008
        set_target_properties(${TARGET_NAME} PROPERTIES LINK_FLAGS    "${LINK_FLAGS} /PDBSTRIPPED:${PDB_NAME}")
    else (${MSVC_VERSION} EQUAL 1500)
        # Visual Studio 2010 (assumed if not Visual Studio 2008)
        # This is a fix due to a bug in CMake, Does not add the flag /DEBUG to the linker flags in Release mode.
        # The /DEBUG flag is required in order to create stripped pdbs.
        set_target_properties(${TARGET_NAME} PROPERTIES LINK_FLAGS_DEBUG    "${LINK_FLAGS_DEBUG} /PDBSTRIPPED:${PDB_NAME}")
        set_target_properties(${TARGET_NAME} PROPERTIES LINK_FLAGS_RELEASE    "${LINK_FLAGS_RELEASE} /DEBUG /PDBSTRIPPED:${PDB_NAME}")
    endif (${MSVC_VERSION} EQUAL 1500)
    if (INSTALL_PDBS)
        install(FILES ${RT_OUTPUT_DIRECTORY}/\${BUILD_TYPE}/${TARGET_NAME}.pdb DESTINATION bin)
    endif(INSTALL_PDBS)
    install(FILES ${RT_OUTPUT_DIRECTORY}/\${BUILD_TYPE}/${TARGET_NAME}_stripped.pdb DESTINATION bin)
else (WIN32)
    SET_LINUX_EXPORTS_FILE( ${TARGET_NAME} opencl_clang.map )
endif(WIN32)
