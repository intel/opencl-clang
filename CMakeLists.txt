#
#  Copyright (c) 2017, Intel Corporation
# 
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  the rights to use, copy, modify, merge, publish, distribute, sublicense,
#  and/or sell copies of the Software, and to permit persons to whom the
#  Software is furnished to do so, subject to the following conditions:
# 
#  The above copyright notice and this permission notice shall be included
#  in all copies or substantial portions of the Software.
# 
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
#  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#  OTHER DEALINGS IN THE SOFTWARE.
#

#
# Common clang
#

cmake_minimum_required(VERSION 3.4.3)

set(CCLANG_LIB_NAME cclang)
set(CCLANG_LIB_NAME ${CCLANG_LIB_NAME} PARENT_SCOPE)

if(NOT DEFINED COMMON_CLANG_LIBRARY_NAME)
    set(COMMON_CLANG_LIBRARY_NAME common_clang)
endif()

if(NOT PATCH)
    find_program(PATCH NAMES patch)
endif()


# function version_from_exe - Decode the output of "${exefile} --version".
# The expected version number format is three or fewer decimal values
# separated by periods.
#
# The caller passes in variable names to be set by this function:
# - _ver_full - Full version string, like "3" or "3.8" or "3.8.5"
# - _vermajor - major version - first field
# - _verminor - minor version - second field
# - _vermicro - "micro" version - third field
#
# Fields not present are returned as blank.
#
# Only the first line from "exefile --version" is examined.
#
# Processing:
# - All text in parentheses is discard.
# - Discarded: The first word and, if present, "version".
# - The first remaining word is considered the version number.
#
# Example version output (first line only):
#
# Fedora example:
##  $ clang --version
##  clang version 5.0.1 (tags/RELEASE_501/final)
#
##  $ gcc --version
##  gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
#
# Ubuntu example:
##  $ clang --version
##  clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
#
##  $ gcc --version
##  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609

function (version_from_exe exefile _ver_full _vermajor _verminor _vermicro)
    execute_process(
        COMMAND "${exefile}" "--version"
        RESULT_VARIABLE var_result
        OUTPUT_VARIABLE var_stdout
        ERROR_VARIABLE var_stderr
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_STRIP_TRAILING_WHITESPACE
        )
    if(NOT var_result EQUAL 0)
        message("version number request failed: ${var_result}: \"${exefile}\"")
        if(NOT "${var_stderr}" STREQUAL "")
            message("version request: \"${var_stderr}\"")
        endif()
        set(${_ver_full} "")
        set(${_vermajor} "")
        set(${_verminor} "")
        set(${_vermicro} "")
        return()
    endif()

    # Discard all but first line
    string(FIND "${var_stdout}" "\n" nl)
    string(SUBSTRING "${var_stdout}" 0 ${nl} var_stdout)

    # Remove all parenthesized items.
    string(REGEX REPLACE "\\([^)]+\\)" "" var_stdout "${var_stdout}")

    # Remove first word and optional following "version"
    string(REGEX REPLACE "^[A-Za-z0-9_]+( +version +)? +" "" var_stdout "${var_stdout}")

    string(REGEX MATCH "^([0-9]+)((\\.([0-9]+))(\\.([0-9]+))?)?" var_stdout "${var_stdout}")
    #                    (      )((   (      ))(   (      )) )
    #                    1       23   4        5   6

    set("${_ver_full}" "${CMAKE_MATCH_0}" PARENT_SCOPE)
    set("${_vermajor}" "${CMAKE_MATCH_1}" PARENT_SCOPE)
    set("${_verminor}" "${CMAKE_MATCH_4}" PARENT_SCOPE)
    set("${_vermicro}" "${CMAKE_MATCH_6}" PARENT_SCOPE)
endfunction()


if(NOT DEFINED CLANG)
    find_program(CLANG NAMES clang)
    if("${CLANG}" STREQUAL "CLANG-NOTFOUND" )
        unset(CLANG CACHE)
    else()
        version_from_exe("${CLANG}" "clang_ver_full" "clang_ver_major" "clang_ver_minor" "clang_ver_micro")

        if("${clang_ver_major}" STREQUAL "")
            unset(CLANG CACHE)
        elseif("${clang_ver_major}" LESS 4)
            unset(CLANG CACHE)
        endif()
    endif()
endif()

if(NOT DEFINED CLANGXX)
    find_program(CLANGXX NAMES clang++)
    if("${CLANGXX}" STREQUAL "CLANGXX-NOTFOUND" )
        unset(CLANGXX CACHE)
    else()
        version_from_exe("${CLANGXX}" "clangxx_ver_full" "clangxx_ver_major" "clangxx_ver_minor" "clangxx_ver_micro")

        if("${clangxx_ver_major}" STREQUAL "")
            unset(CLANGXX CACHE)
        elseif("${clangxx_ver_major}" LESS 4)
            unset(CLANGXX CACHE)
        endif()
    endif()
endif()

if((NOT DEFINED CLANG ) OR (NOT DEFINED CLANGXX ))
    if((DEFINED CLANG ) OR (DEFINED CLANGXX ))
        message(SEND_ERROR "${CMAKE_CURRENT_LIST_FILE}: CLANG = \"${CLANG}\"")
        message(SEND_ERROR "${CMAKE_CURRENT_LIST_FILE}: CLANGXX = \"${CLANGXX}\"")
        message(FATAL_ERROR "${CMAKE_CURRENT_LIST_FILE}: inconsistent CLANG vs CLANGXX")
    endif()
endif()


if(NOT DEFINED CLANG)
    find_program(CLANG NAMES clang-4.0)
    if("${CLANG}" STREQUAL "CLANG-NOTFOUND" )
        message(FATAL_ERROR "${CMAKE_CURRENT_LIST_FILE}: clang-4.0 not found")
    endif()
endif()

if(NOT DEFINED CLANGXX)
    find_program(CLANGXX NAMES clang++-4.0)
    if("${CLANGXX}" STREQUAL "CLANGXX-NOTFOUND" )
        message(FATAL_ERROR "${CMAKE_CURRENT_LIST_FILE}: clang++-4.0 not found")
    endif()
endif()

set(CCLANG_OPTIONS
    "-DBUILD_X64:BOOL=ON"
    "-DLLVM_USE_INTEL_JITEVENTS:BOOL=ON"
    "-DLLVM_USE_LINKER:STRING=gold"
    "-DCMAKE_CXX_COMPILER:FILEPATH=${CLANGXX}"
    "-DCMAKE_C_COMPILER:FILEPATH=${CLANG}"
    "-DLLVM_OPTIMIZED_TABLEGEN=ON"
    "-DLLVM_TARGETS_TO_BUILD='X86'"
    "-DCOMMON_CLANG_LIBRARY_NAME:STRING=${COMMON_CLANG_LIBRARY_NAME}"
)

if(NOT LLVM_SOURCE_DIR)
    set(LLVM_SOURCE_DIR   "${CMAKE_CURRENT_SOURCE_DIR}/../llvm_source")
endif()

if(NOT CLANG_SOURCE_DIR)
    set(CLANG_SOURCE_DIR  "${CMAKE_CURRENT_SOURCE_DIR}/../clang_source")
endif()

if(NOT OCL_HEADERS_DIR)
    set(OCL_HEADERS_DIR   "${CMAKE_CURRENT_SOURCE_DIR}/../opencl_headers")
endif()

set (CCLANG_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/cclang")

if(NOT CCLANG_INSTALL_DIR)
    set(CCLANG_INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/install")
endif()

# Use LLVM sources stored at LLVM_SOURCE_DIR.
set(LLVM_SOURCE_URL ${LLVM_SOURCE_DIR})
# Also tar archive with stock/pure LLVM sources can be used. Just specify the path ...
# set(LLVM_SOURCE_URL "${CMAKE_CURRENT_SOURCE_DIR}/llvm-4.0.0.src.tar.xz")

# Use CLANG sources stored at CLANG_SOURCE_DIR.
set(CLANG_SOURCE_URL ${CLANG_SOURCE_DIR})

# Use CCLANG sources stored at CCLANG_SOURCE_DIR
set(CCLANG_SOURCE_URL ${CCLANG_SOURCE_DIR})

message(STATUS "LLVM_SOURCE_URL    = ${LLVM_SOURCE_URL}")
message(STATUS "CLANG_SOURCE_URL   = ${CLANG_SOURCE_URL}")
message(STATUS "CCLANG_LIB_NAME    = ${CCLANG_LIB_NAME}")
message(STATUS "CCLANG_SOURCE_URL  = ${CCLANG_SOURCE_URL}")
message(STATUS "CCLANG_BUILD_TYPE  = ${CMAKE_BUILD_TYPE}")
message(STATUS "CCLANG_INSTALL_DIR = ${CCLANG_INSTALL_DIR}")
message(STATUS "CCLANG_OPTIONS     = ${CCLANG_OPTIONS}")


# Customization patches will be applied to LLVM if present.
file(GLOB LLVM_PATCH_FILES "${CMAKE_CURRENT_SOURCE_DIR}/llvm_patches/releases/4.0.0/patches/*.patch")
# Sort list of patch files.
list(SORT LLVM_PATCH_FILES)

# Customization patches will be applied to CLANG if present.
file(GLOB CLANG_PATCH_FILES "${CMAKE_CURRENT_SOURCE_DIR}/clang_patches/releases/4.0.1/patches/*.patch")
# Sort list of patch files.
list(SORT CLANG_PATCH_FILES)


include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)


ExternalProject_Add(${CCLANG_LIB_NAME}
    URL ${LLVM_SOURCE_URL}
    PREFIX src
    BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/src
    CMAKE_ARGS -G ${CMAKE_GENERATOR}
               -DCMAKE_BUILD_TYPE=$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>$<$<CONFIG:ReleaseInternal>:Release>
               -DCMAKE_INSTALL_PREFIX=${CCLANG_INSTALL_DIR}
               ${CCLANG_OPTIONS}
)

ExternalProject_Add_Step(${CCLANG_LIB_NAME} "add_clang"
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CLANG_SOURCE_URL} ${CMAKE_CURRENT_BINARY_DIR}/src/src/${CCLANG_LIB_NAME}/tools/clang
            DEPENDEES download
            COMMENT "Copying ${CLANG_SOURCE_URL} to ${CMAKE_CURRENT_BINARY_DIR}/src/src/${CCLANG_LIB_NAME}/tools/clang"
            )

ExternalProject_Add_Step(${CCLANG_LIB_NAME} "add_cclang"
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CCLANG_SOURCE_URL} ${CMAKE_CURRENT_BINARY_DIR}/src/src/${CCLANG_LIB_NAME}/projects/cclang
            DEPENDEES add_clang
            COMMENT "Copying ${CCLANG_SOURCE_URL} to ${CMAKE_CURRENT_BINARY_DIR}/src/src/${CCLANG_LIB_NAME}/projects/cclang"
            )

ExternalProject_Add_Step(${CCLANG_LIB_NAME} "add_opencl_headers"
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${OCL_HEADERS_DIR} ${CMAKE_CURRENT_BINARY_DIR}/src/src/${CCLANG_LIB_NAME}/projects/cclang
            DEPENDEES add_cclang
            DEPENDERS patch
            COMMENT "Copying ${OCL_HEADERS_DIR} to ${CMAKE_CURRENT_BINARY_DIR}/src/src/${CCLANG_LIB_NAME}/projects/cclang"
            )

# Apply customization patches to LLVM if any.
set(i 1)
set(patch_dependee "patch")
foreach(patch_file ${LLVM_PATCH_FILES})

    ExternalProject_Add_Step(${CCLANG_LIB_NAME} "patch${i}"
            COMMAND ${PATCH} -d "${CMAKE_CURRENT_BINARY_DIR}/src/src/${CCLANG_LIB_NAME}" -p1 < ${patch_file}
            DEPENDEES ${patch_dependee}
            DEPENDERS configure
            COMMENT "Apply ${patch_file} file"
            )

    set(patch_dependee "patch${i}")
    math(EXPR i "${i} + 1")

endforeach()

# Apply customization patches to CLANG if any.
foreach(patch_file ${CLANG_PATCH_FILES})

    ExternalProject_Add_Step(${CCLANG_LIB_NAME} "patch${i}"
            COMMAND ${PATCH} -d "${CMAKE_CURRENT_BINARY_DIR}/src/src/${CCLANG_LIB_NAME}/tools/clang" -p1 < ${patch_file}
            DEPENDEES ${patch_dependee}
            DEPENDERS configure
            COMMENT "Apply ${patch_file} file"
            )

    set(patch_dependee "patch${i}")
    math(EXPR i "${i} + 1")

endforeach()

if(CCLANG_INSTALL_ARTIFACTS_DIR)
    ExternalProject_Add_Step(${CCLANG_LIB_NAME} "copy_artifacts"
            COMMAND "${CMAKE_COMMAND}" -E make_directory "${CCLANG_INSTALL_ARTIFACTS_DIR}"
            COMMAND ${CMAKE_COMMAND} -E copy "${CCLANG_INSTALL_DIR}/bin/clang-4.0" ${CCLANG_INSTALL_ARTIFACTS_DIR}/clang
            COMMAND ${CMAKE_COMMAND} -E copy "${CCLANG_INSTALL_DIR}/lib/lib${COMMON_CLANG_LIBRARY_NAME}.so" ${CCLANG_INSTALL_ARTIFACTS_DIR}
            COMMAND ${CMAKE_COMMAND} -E copy_directory "${CCLANG_INSTALL_DIR}/include/cclang/" ${CCLANG_INSTALL_ARTIFACTS_DIR}
            DEPENDEES install
            COMMENT "Copying common clang artifacts from ${CCLANG_INSTALL_DIR} to ${CCLANG_INSTALL_ARTIFACTS_DIR}"
            )
endif()

