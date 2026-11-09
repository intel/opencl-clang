cmake_minimum_required(VERSION 3.20.0)

if(NOT DEFINED OPENCL_CLANG_BUILD_EXTERNAL)
  # check if we build inside llvm or not
  if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(OPENCL_CLANG_BUILD_EXTERNAL YES)
  endif(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
endif(NOT DEFINED OPENCL_CLANG_BUILD_EXTERNAL)

if(OPENCL_CLANG_BUILD_EXTERNAL)
  project(OPENCL_CLANG
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

if(CMAKE_CROSSCOMPILING AND OPENCL_CLANG_BUILD_EXTERNAL)
  include(CrossCompile)
  llvm_create_cross_target(${PROJECT_NAME} NATIVE "" Release)
endif()

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(USE_PREBUILT_LLVM ON)

    add_definitions(-DUSE_PREBUILT_LLVM)

    if(NOT PREFERRED_LLVM_VERSION)
        set(PREFERRED_LLVM_VERSION "24.0")
    endif(NOT PREFERRED_LLVM_VERSION)
    message(STATUS "[OPENCL-CLANG] Looking for LLVM version ${PREFERRED_LLVM_VERSION}")
    find_package(LLVM ${PREFERRED_LLVM_VERSION} REQUIRED)

    message(STATUS "[OPENCL-CLANG] Using LLVMConfig.cmake in: ${LLVM_DIR}")
    message(STATUS "[OPENCL-CLANG] Found LLVM ${LLVM_PACKAGE_VERSION}")

    set(CMAKE_MODULE_PATH
      ${CMAKE_MODULE_PATH}
      ${LLVM_CMAKE_DIR})

    # The resource embedder script requires Python 3. In-tree builds get it from
    # the LLVM build configuration.
    find_package(Python3 REQUIRED COMPONENTS Interpreter)

    set(CMAKE_CXX_STANDARD 17)
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

# LLVM 15 and older build with C++14 by default, opencl-clang requires C++17.
if(NOT CMAKE_CXX_STANDARD OR CMAKE_CXX_STANDARD LESS 17)
    set(CMAKE_CXX_STANDARD 17)
endif()

use_rtti(FALSE)
use_eh(TRUE)

if (CMAKE_SIZEOF_VOID_P EQUAL 4)
  set(ADDR 32)
elseif (CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(ADDR 64)
else ()
  # CMAKE_SIZEOF_VOID_P might not be set on windows x86 in in-tree build
  message(WARNING "[OPENCL-CLANG] CMAKE_SIZEOF_VOID_P is not set")
  if (WIN32 AND LLVM_BUILD_32_BITS)
    set(ADDR 32)
  endif()
endif (CMAKE_SIZEOF_VOID_P EQUAL 4)

# Native SPIR triple -- derived from host pointer size.
if(ADDR EQUAL 64)
  set(OPENCL_CLANG_NATIVE_TRIPLE "spir64-unknown-unknown")
else()
  set(OPENCL_CLANG_NATIVE_TRIPLE "spir-unknown-unknown")
endif()

# set windows binary suffix
if (WIN32)
    set (BUILD_PLATFORM ${ADDR})
else (WIN32)
    set (BUILD_PLATFORM "")
endif (WIN32)

# set that name of the main output file as a target name
if (NOT DEFINED OPENCL_CLANG_LIBRARY_NAME)
    # COMMON_CLANG_LIBRARY_NAME is the name of the variable used by the
    # opencl-clang branches for LLVM 15 and older.
    if (DEFINED COMMON_CLANG_LIBRARY_NAME)
        set(OPENCL_CLANG_LIBRARY_NAME ${COMMON_CLANG_LIBRARY_NAME})
    else()
        set(OPENCL_CLANG_LIBRARY_NAME "opencl-clang")
    endif()
endif()
set(TARGET_NAME ${OPENCL_CLANG_LIBRARY_NAME}${BUILD_PLATFORM} )

if(NOT USE_PREBUILT_LLVM)

    if(NOT LLVM_EXTERNAL_CLANG_SOURCE_DIR)
        set(CLANG_SOURCE_DIR ${LLVM_SOURCE_DIR}/tools/clang)
    elseif(EXISTS "${LLVM_EXTERNAL_CLANG_SOURCE_DIR}/CMakeLists.txt")
        set(CLANG_SOURCE_DIR "${LLVM_EXTERNAL_CLANG_SOURCE_DIR}")
    endif()
    if(EXISTS ${CLANG_SOURCE_DIR})
        message(STATUS "[OPENCL-CLANG] Using Clang source code directory: ${CLANG_SOURCE_DIR}")
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

    set(CLANG_BASE_REVISION main)
    set(SPIRV_BASE_REVISION main)
    set(TARGET_BRANCH main)
    get_filename_component(LLVM_MONOREPO_DIR ${LLVM_SOURCE_DIR} DIRECTORY)
    set(LLVM_PATCHES_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/patches/llvm
                          ${CMAKE_CURRENT_SOURCE_DIR}/patches/clang)

    # Apply the LLVM core patches together with the Clang patches to the
    # monorepo in a single call: apply_patches creates the target branch on its
    # first invocation, so subsequent calls on the same repository are skipped.
    apply_patches(${LLVM_MONOREPO_DIR}
                  "${LLVM_PATCHES_DIRS}"
                  ${CLANG_BASE_REVISION}
                  ${TARGET_BRANCH})
    apply_patches(${SPIRV_SOURCE_DIR}
                  ${CMAKE_CURRENT_SOURCE_DIR}/patches/spirv
                  ${SPIRV_BASE_REVISION}
                  ${TARGET_BRANCH})
endif(NOT USE_PREBUILT_LLVM)

add_subdirectory(utils)
add_subdirectory(lib)

if(LLVM_INCLUDE_TESTS)
  set(OPENCL_CLANG_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
  # The build directory corresponding to this project, used by the lit Unit
  # test suite to locate the compiled unit test binaries.
  set(OPENCL_CLANG_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR})
  add_subdirectory(unittests)
  add_subdirectory(tests)
endif()
