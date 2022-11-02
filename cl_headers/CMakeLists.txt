set(CL_HEADERS_LIB cl_headers)
set(CLANG_COMMAND $<TARGET_FILE:clang> )
if(LLVM_USE_HOST_TOOLS AND NOT OPENCL_CLANG_BUILD_EXTERNAL)
  build_native_tool(clang CLANG_COMMAND)
endif()

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
        DEPENDS ${HEADER} ${DEPS} ${CLANG_COMMAND}
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
set(CL30 "-cl-std=CL3.0")
# Add OpenCL C 3.0 Optional features
set(OPTS30 "-cl-ext=+__opencl_c_3d_image_writes,+__opencl_c_atomic_order_acq_rel,+__opencl_c_atomic_order_seq_cst,+__opencl_c_atomic_scope_device,+__opencl_c_atomic_scope_all_devices,+__opencl_c_device_enqueue,+__opencl_c_generic_address_space,+__opencl_c_images,+__opencl_c_int64,+__opencl_c_pipes,+__opencl_c_program_scope_global_variables,+__opencl_c_read_write_images,+__opencl_c_subgroups,+__opencl_c_work_group_collective_functions")
set(OPTS30_FP64 "-D__opencl_c_fp64=1")

set(SPIR_TRIPLE "-triple;spir-unknown-unknown")
set(SPIR64_TRIPLE "-triple;spir64-unknown-unknown")

if (BUILD_X64)
    set(HOST_TRIPLE  "${SPIR64_TRIPLE}")
else()
    set(HOST_TRIPLE  "${SPIR_TRIPLE}")
endif()

set(OPTS -cl-ext=+all,-cl_khr_fp64,-__opencl_c_fp64)
create_pcm(opencl-c-12-spir.pcm cl12spir opencl-c-base.h "${SPIR_TRIPLE};${CL12};${OPTS}" "${DEPS}")
create_pcm(opencl-c-20-spir.pcm cl20spir opencl-c-base.h "${SPIR_TRIPLE};${CL20};${OPTS}" "${DEPS}")
create_pcm(opencl-c-30-spir.pcm cl30spir opencl-c-base.h "${SPIR_TRIPLE};${CL30};${OPTS};${OPTS30}" "${DEPS}")
create_pcm(opencl-c-12-spir64.pcm cl12spir64 opencl-c-base.h "${SPIR64_TRIPLE};${CL12};${OPTS}" "${DEPS}")
create_pcm(opencl-c-20-spir64.pcm cl20spir64 opencl-c-base.h "${SPIR64_TRIPLE};${CL20};${OPTS}" "${DEPS}")
create_pcm(opencl-c-30-spir64.pcm cl30spir64 opencl-c-base.h "${SPIR64_TRIPLE};${CL30};${OPTS};${OPTS30}" "${DEPS}")
set(OPTS -cl-ext=+all)
create_pcm(opencl-c-12-spir-fp64.pcm cl12spirfp64 opencl-c-base.h "${SPIR_TRIPLE};${CL12};${OPTS}" "${DEPS}")
create_pcm(opencl-c-20-spir-fp64.pcm cl20spirfp64 opencl-c-base.h "${SPIR_TRIPLE};${CL20};${OPTS}" "${DEPS}")
create_pcm(opencl-c-30-spir-fp64.pcm cl30spirfp64 opencl-c-base.h "${SPIR_TRIPLE};${CL30};${OPTS};${OPTS30};${OPTS30_FP64}" "${DEPS}")
create_pcm(opencl-c-12-spir64-fp64.pcm cl12spir64fp64 opencl-c-base.h "${SPIR64_TRIPLE};${CL12};${OPTS}" "${DEPS}")
create_pcm(opencl-c-20-spir64-fp64.pcm cl20spir64fp64 opencl-c-base.h "${SPIR64_TRIPLE};${CL20};${OPTS}" "${DEPS}")
create_pcm(opencl-c-30-spir64-fp64.pcm cl30spir64fp64 opencl-c-base.h "${SPIR64_TRIPLE};${CL30};${OPTS};${OPTS30};${OPTS30_FP64}" "${DEPS}")

add_custom_target (
    opencl.pcm.target
    DEPENDS
    opencl.headers.target
    opencl-c-12-spir.pcm
    opencl-c-20-spir.pcm
    opencl-c-30-spir.pcm
    opencl-c-12-spir64.pcm
    opencl-c-20-spir64.pcm
    opencl-c-30-spir64.pcm
    opencl-c-12-spir-fp64.pcm
    opencl-c-20-spir-fp64.pcm
    opencl-c-30-spir-fp64.pcm
    opencl-c-12-spir64-fp64.pcm
    opencl-c-20-spir64-fp64.pcm
    opencl-c-30-spir64-fp64.pcm
)

function(pack_to_obj SRC DST TAG)
    add_custom_command (
        OUTPUT ${DST}
        DEPENDS ${SRC} linux_resource_linker
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
      opencl-c-30-spir.mod.cpp
      opencl-c-12-spir64.mod.cpp
      opencl-c-20-spir64.mod.cpp
      opencl-c-30-spir64.mod.cpp
      opencl-c-12-spir-fp64.mod.cpp
      opencl-c-20-spir-fp64.mod.cpp
      opencl-c-30-spir-fp64.mod.cpp
      opencl-c-12-spir64-fp64.mod.cpp
      opencl-c-20-spir64-fp64.mod.cpp
      opencl-c-30-spir64-fp64.mod.cpp
      module.modulemap.cpp
    )
    # note the .pcm -> .mod extension change
    # this is a workaround for CMake bug that caused
    # dependency cycle in generated build rules
    pack_to_obj(opencl-c-12-spir.pcm    opencl-c-12-spir.mod.cpp   "PCM_OPENCL_C_12_SPIR_PCM")
    pack_to_obj(opencl-c-20-spir.pcm    opencl-c-20-spir.mod.cpp   "PCM_OPENCL_C_20_SPIR_PCM")
    pack_to_obj(opencl-c-30-spir.pcm    opencl-c-30-spir.mod.cpp   "PCM_OPENCL_C_30_SPIR_PCM")
    pack_to_obj(opencl-c-12-spir64.pcm  opencl-c-12-spir64.mod.cpp "PCM_OPENCL_C_12_SPIR64_PCM")
    pack_to_obj(opencl-c-20-spir64.pcm  opencl-c-20-spir64.mod.cpp "PCM_OPENCL_C_20_SPIR64_PCM")
    pack_to_obj(opencl-c-30-spir64.pcm  opencl-c-30-spir64.mod.cpp "PCM_OPENCL_C_30_SPIR64_PCM")
    pack_to_obj(opencl-c-12-spir-fp64.pcm    opencl-c-12-spir-fp64.mod.cpp   "PCM_OPENCL_C_12_SPIR_FP64_PCM")
    pack_to_obj(opencl-c-20-spir-fp64.pcm    opencl-c-20-spir-fp64.mod.cpp   "PCM_OPENCL_C_20_SPIR_FP64_PCM")
    pack_to_obj(opencl-c-30-spir-fp64.pcm    opencl-c-30-spir-fp64.mod.cpp   "PCM_OPENCL_C_30_SPIR_FP64_PCM")
    pack_to_obj(opencl-c-12-spir64-fp64.pcm  opencl-c-12-spir64-fp64.mod.cpp "PCM_OPENCL_C_12_SPIR64_FP64_PCM")
    pack_to_obj(opencl-c-20-spir64-fp64.pcm  opencl-c-20-spir64-fp64.mod.cpp "PCM_OPENCL_C_20_SPIR64_FP64_PCM")
    pack_to_obj(opencl-c-30-spir64-fp64.pcm  opencl-c-30-spir64-fp64.mod.cpp "PCM_OPENCL_C_30_SPIR64_FP64_PCM")
    pack_to_obj(module.modulemap  module.modulemap.cpp  "PCM_OPENCL_C_MODULE_MAP")
endif()

add_library(${CL_HEADERS_LIB} OBJECT
    ${CL_HEADERS_SRC}
)

add_dependencies(${CL_HEADERS_LIB} opencl.pcm.target)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/opencl-c.h
    ${CMAKE_CURRENT_BINARY_DIR}/opencl-c-base.h
    ${CMAKE_CURRENT_BINARY_DIR}/module.modulemap
    DESTINATION include/cclang
)
