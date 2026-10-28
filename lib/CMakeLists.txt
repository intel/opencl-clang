# Embedded headers
add_subdirectory(Headers)

#
# TblGen the options include file
#
set (COMPILE_OPTIONS_TD  OpenCLClangOptions.td)
set (COMPILE_OPTIONS_INC OpenCLClangOptions.inc)
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
  ${CMAKE_CURRENT_SOURCE_DIR}/../include/opencl-clang/OpenCLClang.h

  Action.h
  Bitcode.h
  BuiltInHeaders.h
  Frontend.h
  SPIRV.h
  SmallVectorStream.h

  Options.h
  BinaryResult.h
  ${COMPILE_OPTIONS_TD}
  ${COMPILE_OPTIONS_INC}
)

set(TARGET_SOURCE_FILES
  Bitcode.cpp
  BuiltInHeaders.cpp
  Driver.cpp
  Frontend.cpp
  SPIRV.cpp

  Options.cpp
  OptionsCompile.cpp
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
            ${CMAKE_CURRENT_SOURCE_DIR}/../include
            ${CMAKE_CURRENT_BINARY_DIR}
            ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}
            )

link_directories(
    ${LLVM_LIBRARY_DIRS}
)

set(OPENCL_CLANG_LINK_LIBS "")

if(NOT LLVMSPIRVLib IN_LIST LLVM_AVAILABLE_LIBS OR (USE_PREBUILT_LLVM AND LLVM_LINK_LLVM_DYLIB))
  # SPIRV-LLVM-Translator is not included into LLVM as a component.
  # So, we need to list it here explicitly as an external library
  list(APPEND OPENCL_CLANG_LINK_LIBS LLVMSPIRVLib)
endif()

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

add_llvm_library(${TARGET_NAME} SHARED
  ${TARGET_INCLUDE_FILES}
  ${TARGET_SOURCE_FILES}

  DEPENDS CClangCompileOptions
  LINK_COMPONENTS
    all
  LINK_LIBS
    ${OPENCL_CLANG_LINK_LIBS}
    opencl-clang-embedded-headers
  )

target_compile_definitions(${TARGET_NAME} PRIVATE
  OPENCL_CLANG_NATIVE_TRIPLE="${OPENCL_CLANG_NATIVE_TRIPLE}")

# Configure resource file on Windows
if (WIN32)
    # windows_resource_file should be defined by llvm_add_library and should
    # contain full patch to a .rc file
    # It also might not be defined if this library is built out-of-tree:
    # let's use our copy of .rc file from LLVM source tree in that case
    if (NOT DEFINED windows_resource_file)
        set(windows_resource_file ${CMAKE_CURRENT_SOURCE_DIR}/../windows_resource_file.rc)
    endif(NOT DEFINED windows_resource_file)

    set(RC_CHAR_TM "\\231")
    set(RC_CHAR_R "\\256")

    set(RC_FILE_VERSION "${PRODUCT_VER_MAJOR}.${PRODUCT_VER_MINOR}.${LLVM_VER_MAJOR}.${LLVM_VER_MINOR}")
    set(RC_PRODUCT_NAME "Intel${RC_CHAR_R} Front-end Library for OpenCL${RC_CHAR_TM} software")

    # Adjust content of the resource file by specifying compile definitions
    set_property(SOURCE ${windows_resource_file}
        PROPERTY COMPILE_DEFINITIONS
            "RC_VERSION_FIELD_1=${PRODUCT_VER_MAJOR}"
            "RC_VERSION_FIELD_2=${PRODUCT_VER_MINOR}"
            "RC_VERSION_FIELD_3=${LLVM_VER_MAJOR}"
            "RC_VERSION_FIELD_4=${LLVM_VER_MINOR}"
            "RC_COMPANY_NAME=\"Intel Corporation\""
            "RC_FILE_DESCRIPTION=\"${RC_PRODUCT_NAME}\""
            "RC_FILE_VERSION=\"${RC_FILE_VERSION}\""
            "RC_INTERNAL_NAME=\"${TARGET_NAME}\""
            "RC_ORIGINAL_FILENAME=\"${TARGET_NAME}.dll\""
            "RC_PRODUCT_NAME=\"${RC_PRODUCT_NAME}\""
            "RC_PRODUCT_VERSION=\"${RC_FILE_VERSION}\""
            "RC_COPYRIGHT=\"Copyright (C) 2018 Intel Corporation\"")

    # Enable compiler generation of Control Flow Guard security checks.
    target_compile_options(${TARGET_NAME} PUBLIC "/guard:cf")
    set_property(TARGET ${TARGET_NAME} APPEND_STRING PROPERTY
        LINK_FLAGS "/DYNAMICBASE /GUARD:CF")

elseif(UNIX)
    set_property(TARGET ${TARGET_NAME} APPEND_STRING PROPERTY
        LINK_FLAGS " -Wl,--no-undefined")
endif(WIN32)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/../include/opencl-clang/OpenCLClang.h
        DESTINATION include/opencl-clang
        COMPONENT ${TARGET_NAME})

# Install backward-compatibility forwarding header
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/../include/opencl-clang/OpenCLClang.h
        DESTINATION include/cclang
        RENAME common_clang.h
        COMPONENT ${TARGET_NAME})

SET_LINUX_EXPORTS_FILE( ${TARGET_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/../OpenCLClang.map )

add_custom_target(deploy DEPENDS install-${TARGET_NAME})
