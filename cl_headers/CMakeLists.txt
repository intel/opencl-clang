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

set(OPENCL_HEADERS_DIR "${CLANG_SOURCE_DIR}/lib/Headers")
copy_file(${OPENCL_HEADERS_DIR}/opencl-c.h opencl-c.h)

add_custom_target (
    opencl.headers.target
    DEPENDS
    opencl-c.h
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
    list(APPEND CL_HEADERS_SRC
         opencl-c.h.cpp
    )
endif()

add_library(${CL_HEADERS_LIB} OBJECT
    ${CL_HEADERS_SRC}
)

add_dependencies(${CL_HEADERS_LIB} opencl.headers.target)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/opencl-c.h
    DESTINATION include/cclang
)
