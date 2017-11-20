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

if(NOT PATCH)
    find_program(PATCH NAMES patch)
endif()

if(NOT CLANG)
    find_program(CLANG NAMES clang-4.0)
    if("${CLANG}" STREQUAL "CLANG-NOTFOUND" )
        message(FATAL_ERROR " clang-4.0 not found")
    endif()
endif()

if(NOT CLANGXX)
    find_program(CLANGXX NAMES clang++-4.0)
    if("${CLANGXX}" STREQUAL "CLANGXX-NOTFOUND" )
        message(FATAL_ERROR " clang++-4.0 not found")
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
            COMMAND ${CMAKE_COMMAND} -E copy "${CCLANG_INSTALL_DIR}/lib/libcommon_clang.so" ${CCLANG_INSTALL_ARTIFACTS_DIR}
            COMMAND ${CMAKE_COMMAND} -E copy_directory "${CCLANG_INSTALL_DIR}/include/cclang/" ${CCLANG_INSTALL_ARTIFACTS_DIR}
            DEPENDEES install
            COMMENT "Copying common clang artifacts from ${CCLANG_INSTALL_DIR} to ${CCLANG_INSTALL_ARTIFACTS_DIR}"
            )
endif()

