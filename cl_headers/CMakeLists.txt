set(CL_HEADERS_LIB cl_headers)
set(CLANG_COMMAND clang)
set(LINUX_RESOURCE_LINKER_COMMAND linux_resource_linker)

function(copy_file SRC DST)
add_custom_command(
    OUTPUT  ${DST}
    MAIN_DEPENDENCY ${SRC}
    COMMAND ${CMAKE_COMMAND} -E copy "${SRC}" "${DST}"
    COMMENT "Copying '${SRC}' to ${DST}"
)
endfunction(copy_file)

if(USE_PREBUILT_LLVM)
    set(OPENCL_HEADERS_DIR
      "${LLVM_LIBRARY_DIRS}/clang/${LLVM_VERSION_MAJOR}.${LLVM_VERSION_MINOR}.${LLVM_VERSION_PATCH}/include/")
else(USE_PREBUILT_LLVM)
    set(OPENCL_HEADERS_DIR "${CLANG_SOURCE_DIR}/lib/Headers")
endif(USE_PREBUILT_LLVM)
copy_file(${OPENCL_HEADERS_DIR}/opencl-c.h opencl-c.h)
copy_file(${OPENCL_HEADERS_DIR}/opencl-c-base.h opencl-c-base.h)
copy_file(${CMAKE_CURRENT_SOURCE_DIR}/module.modulemap module.modulemap)

add_custom_target (
    opencl.headers.target
    DEPENDS
    module.modulemap
    opencl-c.h
    opencl-c-base.h
)

function(create_pcm DST MODULE HEADER OPTS DEPS)
    add_custom_command (
        OUTPUT ${DST}
        MAIN_DEPENDENCY ${MODMAP}
        DEPENDS ${HEADER} ${DEPS}
        COMMAND
        ${CLANG_COMMAND} -cc1 -x cl
        -I. -O0 ${OPTS}
        -fmodules -fmodule-name=${MODULE} -fmodule-map-file-home-is-cwd
        -emit-module "module.modulemap"
	-fno-validate-pch
        -o ${DST}
        VERBATIM
        COMMENT "Generating ${DST}"
    )
endfunction(create_pcm)

set(CL12 "-cl-std=CL1.2")
set(CL20 "-cl-std=CL2.0")

set(SPIR_TRIPLE "-triple;spir-unknown-unknown")
set(SPIR64_TRIPLE "-triple;spir64-unknown-unknown")
if (BUILD_X64)
    set(HOST_TRIPLE  "${SPIR64_TRIPLE}")
else()
    set(HOST_TRIPLE  "${SPIR_TRIPLE}")
endif()

create_pcm(opencl-c-12-spir.pcm cl12spir opencl-c-base.h "${SPIR_TRIPLE};${CL12};${OPTS}" "${DEPS}")
create_pcm(opencl-c-20-spir.pcm cl20spir opencl-c-base.h "${SPIR_TRIPLE};${CL20};${OPTS}" "${DEPS}")
create_pcm(opencl-c-12-spir64.pcm cl12spir64 opencl-c-base.h "${SPIR64_TRIPLE};${CL12};${OPTS}" "${DEPS}")
create_pcm(opencl-c-20-spir64.pcm cl20spir64 opencl-c-base.h "${SPIR64_TRIPLE};${CL20};${OPTS}" "${DEPS}")

add_custom_target (
    opencl.pcm.target
    DEPENDS
    opencl.headers.target
    opencl-c-12-spir.pcm
    opencl-c-20-spir.pcm
    opencl-c-12-spir64.pcm
    opencl-c-20-spir64.pcm
)

function(pack_to_obj SRC DST TAG)
    add_custom_command (
        OUTPUT ${DST}
        DEPENDS ${SRC} ${LINUX_RESOURCE_LINKER_COMMAND}
        COMMAND ${LINUX_RESOURCE_LINKER_COMMAND} "${SRC}" "${DST}" "${TAG}"
        COMMENT "Packing ${SRC}"
    )
endfunction(pack_to_obj)

if(WIN32)
    list(APPEND CL_HEADERS_SRC OpenCL.rc)
else()

    pack_to_obj(opencl-c.h           opencl-c.h.cpp           "PCM_OPENCL_C_H")
    pack_to_obj(opencl-c-base.h      opencl-c-base.h.cpp      "PCM_OPENCL_C_BASE_H")
    list(APPEND CL_HEADERS_SRC
      opencl-c.h.cpp
      opencl-c-base.h.cpp
      opencl-c-12-spir.mod.cpp
      opencl-c-20-spir.mod.cpp
      opencl-c-12-spir64.mod.cpp
      opencl-c-20-spir64.mod.cpp
      module.modulemap.cpp
    )
    # note the .pcm -> .mod extension change
    # this is a workaround for CMake bug that caused
    # dependency cycle in generated build rules
    pack_to_obj(opencl-c-12-spir.pcm    opencl-c-12-spir.mod.cpp   "PCM_OPENCL_C_12_SPIR_PCM")
    pack_to_obj(opencl-c-20-spir.pcm    opencl-c-20-spir.mod.cpp   "PCM_OPENCL_C_20_SPIR_PCM")
    pack_to_obj(opencl-c-12-spir64.pcm  opencl-c-12-spir64.mod.cpp "PCM_OPENCL_C_12_SPIR64_PCM")
    pack_to_obj(opencl-c-20-spir64.pcm  opencl-c-20-spir64.mod.cpp "PCM_OPENCL_C_20_SPIR64_PCM")
    pack_to_obj(module.modulemap  module.modulemap.cpp  "PCM_OPENCL_C_MODULE_MAP")

endif()

add_library(${CL_HEADERS_LIB} OBJECT
    ${CL_HEADERS_SRC}
)

add_dependencies(${CL_HEADERS_LIB} opencl.headers.target)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/opencl-c.h
    ${CMAKE_CURRENT_BINARY_DIR}/opencl-c-base.h
    ${CMAKE_CURRENT_BINARY_DIR}/module.modulemap
    DESTINATION include/cclang
)
