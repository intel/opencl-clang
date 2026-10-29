cmake_minimum_required(VERSION 3.13.4)

if(NOT DEFINED BASE_LLVM_VERSION)
  set(BASE_LLVM_VERSION 14.0.0)
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

option(LLVMSPIRV_INCLUDED_IN_LLVM
  "Set to ON if libLLVMSPIRVLib is linked into libLLVM" ON)
option(APPLY_PATCHES "Apply local patches" ON)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(USE_PREBUILT_LLVM ON)

    add_definitions(-DUSE_PREBUILT_LLVM)

    if(NOT PREFERRED_LLVM_VERSION)
        set(PREFERRED_LLVM_VERSION "15.0.0")
    endif(NOT PREFERRED_LLVM_VERSION)
    message(STATUS "[OPENCL-CLANG] Looking for LLVM version ${PREFERRED_LLVM_VERSION}")
    find_package(LLVM ${PREFERRED_LLVM_VERSION} REQUIRED)

    message(STATUS "[OPENCL-CLANG] Using LLVMConfig.cmake in: ${LLVM_DIR}")
    message(STATUS "[OPENCL-CLANG] Found LLVM ${LLVM_PACKAGE_VERSION}")

    set(CMAKE_MODULE_PATH
      ${CMAKE_MODULE_PATH}
      ${LLVM_CMAKE_DIR})

    # A prebuilt clang may predate the CL3.1 patches carried in patches/clang
    # (only applied when building clang from source, see below). Probe it so
    # we don't try to generate a PCM with a -cl-std value the compiler rejects.
    find_program(OPENCL_CLANG_PROBE_CLANG clang PATHS ${LLVM_TOOLS_BINARY_DIR} NO_DEFAULT_PATH)
    file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/cl31_check.cl" "")
    execute_process(
        COMMAND ${OPENCL_CLANG_PROBE_CLANG} -cl-std=CL3.1 -x cl -fsyntax-only "${CMAKE_CURRENT_BINARY_DIR}/cl31_check.cl"
        RESULT_VARIABLE CLANG_CL31_CHECK_RESULT
        OUTPUT_QUIET
        ERROR_QUIET
    )
    if(CLANG_CL31_CHECK_RESULT EQUAL 0)
        set(CLANG_SUPPORTS_CL31 TRUE)
    else()
        set(CLANG_SUPPORTS_CL31 FALSE)
        message(STATUS "[OPENCL-CLANG] ${OPENCL_CLANG_PROBE_CLANG} does not support -cl-std=CL3.1; skipping OpenCL 3.1 PCM generation")
    endif()

    set(CMAKE_CXX_STANDARD 14)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

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
    set(CLANG_SUPPORTS_CL31 TRUE)
    find_package(Git REQUIRED)
endif(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)

if(NOT CLANG_SUPPORTS_CL31)
  add_definitions(-DOPENCL_CLANG_NO_CL31_PCM)
endif()

include(AddLLVM)
include(TableGen)

if (NOT WIN32)
    add_subdirectory(tools/linux-resource-linker bin)
endif()

# LLVM 15 builds with C++14 by default, opencl-clang requires C++17.
if(NOT CMAKE_CXX_STANDARD OR CMAKE_CXX_STANDARD LESS 17)
    set(CMAKE_CXX_STANDARD 17)
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
    set(COMMON_CLANG_LIBRARY_NAME "opencl-clang")
endif()
set(TARGET_NAME ${COMMON_CLANG_LIBRARY_NAME}${BUILD_PLATFORM} )

if(NOT USE_PREBUILT_LLVM)

    if(NOT LLVM_EXTERNAL_CLANG_SOURCE_DIR)
        set(LLVM_BASE_REVISION release_15)
        set(CLANG_SOURCE_DIR ${LLVM_SOURCE_DIR}/tools/clang)
        set(CLANG_BASE_REVISION release_15)
    elseif(EXISTS "${LLVM_EXTERNAL_CLANG_SOURCE_DIR}/CMakeLists.txt")
	    set(LLVM_BASE_REVISION release/15.x)
        set(CLANG_SOURCE_DIR "${LLVM_EXTERNAL_CLANG_SOURCE_DIR}")
        set(CLANG_BASE_REVISION release/15.x)
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

    set(SPIRV_BASE_REVISION llvm_release_150)
    set(TARGET_BRANCH "ocl-open-150")
    get_filename_component(LLVM_MONOREPO_DIR ${LLVM_SOURCE_DIR} DIRECTORY)
    set(LLVM_PATCHES_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/patches/llvm
                          ${CMAKE_CURRENT_SOURCE_DIR}/patches/clang)

   if(APPLY_PATCHES)
      message(STATUS "APPLY_PATCHES is enabled.")
      apply_patches(${LLVM_MONOREPO_DIR}
                    "${LLVM_PATCHES_DIRS}"
                    ${LLVM_BASE_REVISION}
                    ${TARGET_BRANCH})
      apply_patches(${SPIRV_SOURCE_DIR}
                    ${CMAKE_CURRENT_SOURCE_DIR}/patches/spirv
                    ${SPIRV_BASE_REVISION}
                    ${TARGET_BRANCH})
    else()
      message(STATUS "APPLY_PATCHES is disabled, skip patch apply process.")
    endif()
endif(NOT USE_PREBUILT_LLVM)

add_subdirectory(cl_headers)
add_subdirectory(lib)

if(LLVM_INCLUDE_TESTS)
  set(OPENCL_CLANG_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
  add_subdirectory(tests)
endif()
