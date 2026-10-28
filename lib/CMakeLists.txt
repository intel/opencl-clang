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
llvm_tablegen(${COMPILE_OPTIONS_INC} -gen-opt-parser-defs ${TABLEGEN_ADDITIONAL})
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
        # for SPIRV headers: only the main branch of SPIRV-LLVM-Translator
        # exports them via the LLVMSPIRVLib target, the release branches don't.
        ${SPIRV_SOURCE_DIR}/include)
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
    clangBasic
    clangFrontend
    clangFrontendTool
    clangSerialization
  )
endif()

if(USE_PREBUILT_LLVM AND UNIX)
  # llvm_map_components_to_libnames(... all) returns empty string if llvm is
  # pre-built locally in either static or shared type in Ubuntu 22.04 container.
  find_program(LLVM_CONFIG_EXE
    NAMES llvm-config-${PREFERRED_LLVM_VERSION} llvm-config
    PATHS ${LLVM_BINARY_DIR} ${LLVM_BINARY_DIR}/bin)
  if(NOT LLVM_CONFIG_EXE)
    message(FATAL_ERROR "[OPENCL-CLANG] llvm-config is not found")
  endif()

  execute_process(COMMAND ${LLVM_CONFIG_EXE} --libs all OUTPUT_VARIABLE ALL_LIBS)
  string(REGEX REPLACE "( |\r|\n|-l)+" ";" ALL_LLVM_LIBS ${ALL_LIBS})
  set(ALL_LLVM_LIBS "LLVMSPIRVLib${ALL_LLVM_LIBS}")
else()
  llvm_map_components_to_libnames(ALL_LLVM_LIBS all)
endif()
set(OPENCL_CLANG_EXCLUDE_LIBS_FROM_ALL "" CACHE STRING "Space-separated list of LLVM libraries to exclude from all")
if (NOT "${OPENCL_CLANG_EXCLUDE_LIBS_FROM_ALL}" STREQUAL "")
  list(REMOVE_ITEM ALL_LLVM_LIBS ${OPENCL_CLANG_EXCLUDE_LIBS_FROM_ALL})
endif()
list(APPEND OPENCL_CLANG_LINK_LIBS ${ALL_LLVM_LIBS})

add_llvm_library(${TARGET_NAME} SHARED
  ${TARGET_INCLUDE_FILES}
  ${TARGET_SOURCE_FILES}

  DEPENDS CClangCompileOptions

  LINK_LIBS
    ${OPENCL_CLANG_LINK_LIBS}
    opencl-clang-embedded-headers
  )

target_compile_definitions(${TARGET_NAME} PRIVATE
  OPENCL_CLANG_NATIVE_TRIPLE="${OPENCL_CLANG_NATIVE_TRIPLE}")

if (WIN32)
    # Configure version resource file on Windows.
    # windows_resource_file should be defined by add_llvm_library and should
    # contain the full path to a .rc file.
    # It also might not be defined if this library is built out-of-tree:
    # let's use our copy of the .rc file from the LLVM source tree in that case.
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
    set_property(TARGET ${TARGET_NAME} APPEND PROPERTY
        LINK_OPTIONS "LINKER:/DYNAMICBASE" "LINKER:/GUARD:CF")

elseif(UNIX)
    # Sanitizers do not support this flag, disable this when under sanitizer build
    if(NOT LLVM_USE_SANITIZER)
        set_property(TARGET ${TARGET_NAME} APPEND_STRING PROPERTY
            LINK_FLAGS " -Wl,--no-undefined")
    endif()
endif(WIN32)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/../include/opencl-clang/OpenCLClang.h
        DESTINATION include/opencl-clang
        COMPONENT ${TARGET_NAME})

# Install backward-compatibility forwarding header
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/../include/opencl-clang/OpenCLClang.h
        DESTINATION include/cclang
        RENAME opencl_clang.h
        COMPONENT ${TARGET_NAME})

#
# Stripped PDB files
#
if (WIN32)
    get_target_property(RT_OUTPUT_DIRECTORY ${TARGET_NAME} RUNTIME_OUTPUT_DIRECTORY)
    file(TO_NATIVE_PATH ${RT_OUTPUT_DIRECTORY}/${CMAKE_CFG_INTDIR}/${TARGET_NAME}_stripped.pdb PDB_NAME)
    if (${MSVC_VERSION} EQUAL 1500)
        # Visual Studio 2008
        set_property(TARGET ${TARGET_NAME} APPEND PROPERTY LINK_OPTIONS "LINKER:/PDBSTRIPPED:${PDB_NAME}")
    else (${MSVC_VERSION} EQUAL 1500)
        # Visual Studio 2010 (assumed if not Visual Studio 2008)
        # This is a fix due to a bug in CMake, Does not add the flag /DEBUG to the linker flags in Release mode.
        # The /DEBUG flag is required in order to create stripped pdbs.
        set_property(TARGET ${TARGET_NAME} APPEND PROPERTY LINK_OPTIONS $<$<CONFIG:Release>:LINKER:/DEBUG> "$<$<CONFIG:Debug,Release>:LINKER:/PDBSTRIPPED:${PDB_NAME}>")
    endif (${MSVC_VERSION} EQUAL 1500)
    if (INSTALL_PDBS)
        install(FILES ${RT_OUTPUT_DIRECTORY}/\${BUILD_TYPE}/${TARGET_NAME}.pdb DESTINATION bin)
    endif(INSTALL_PDBS)
    install(FILES ${RT_OUTPUT_DIRECTORY}/\${BUILD_TYPE}/${TARGET_NAME}_stripped.pdb DESTINATION bin)
else (WIN32)
    SET_LINUX_EXPORTS_FILE( ${TARGET_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/../OpenCLClang.map )
endif(WIN32)
