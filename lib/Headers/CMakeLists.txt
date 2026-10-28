#
# Embed the OpenCL C headers provided by Clang into the library.
#

if(USE_PREBUILT_LLVM)
  if(EXISTS "${LLVM_LIBRARY_DIRS}/clang/${LLVM_VERSION_MAJOR}.${LLVM_VERSION_MINOR}.${LLVM_VERSION_PATCH}/")
    set(OPENCL_HEADERS_SRC_DIR
      "${LLVM_LIBRARY_DIRS}/clang/${LLVM_VERSION_MAJOR}.${LLVM_VERSION_MINOR}.${LLVM_VERSION_PATCH}/include")
  elseif(EXISTS "${LLVM_LIBRARY_DIRS}/clang/${LLVM_VERSION_MAJOR}/")
    set(OPENCL_HEADERS_SRC_DIR
      "${LLVM_LIBRARY_DIRS}/clang/${LLVM_VERSION_MAJOR}/include")
  else()
    message(FATAL_ERROR "[OPENCL-CLANG] Couldn't find prebuilt LLVM include directory.")
  endif()
else()
  set(OPENCL_HEADERS_SRC_DIR "${CLANG_SOURCE_DIR}/lib/Headers")
endif()

set(OPENCL_HEADERS
  opencl-c.h
  opencl-c-base.h
)

# The headers are copied into a separate directory, so that the embedder picks
# up only the OpenCL C headers.
set(OPENCL_HEADERS_DIR ${CMAKE_CURRENT_BINARY_DIR}/opencl-headers)
set(OPENCL_HEADERS_H ${CMAKE_CURRENT_BINARY_DIR}/opencl-headers.h)

check_c23_embed_supported(HAVE_C23_EMBED)

# MSVC limits the size of string literals, so the C (hex byte array) output is
# used on Windows.
if(HAVE_C23_EMBED OR WIN32)
  set(OPENCL_HEADERS_C ${CMAKE_CURRENT_BINARY_DIR}/opencl-headers.c)
else()
  set(OPENCL_HEADERS_C ${CMAKE_CURRENT_BINARY_DIR}/opencl-headers.cpp)
endif()

set(OPENCL_HEADER_FILES "")
foreach(header ${OPENCL_HEADERS})
  add_custom_command(
    OUTPUT ${OPENCL_HEADERS_DIR}/${header}
    MAIN_DEPENDENCY ${OPENCL_HEADERS_SRC_DIR}/${header}
    COMMAND ${CMAKE_COMMAND} -E copy ${OPENCL_HEADERS_SRC_DIR}/${header} ${OPENCL_HEADERS_DIR}/${header}
    COMMENT "Copying ${header}"
  )
  list(APPEND OPENCL_HEADER_FILES ${OPENCL_HEADERS_DIR}/${header})
endforeach()

add_custom_command(
  COMMENT "Embedding OpenCL C headers: ${OPENCL_HEADERS}"
  DEPENDS ${DIR_RESOURCE_EMBEDDER} ${OPENCL_HEADER_FILES}
  OUTPUT ${OPENCL_HEADERS_C} ${OPENCL_HEADERS_H}
  COMMAND ${Python3_EXECUTABLE} ${DIR_RESOURCE_EMBEDDER} ${RESOURCE_EMBEDDER_OPTS} ${OPENCL_HEADERS_DIR} ${OPENCL_HEADERS_C} opencl_headers "\"*.h\""
)

add_library(opencl-clang-embedded-headers OBJECT
  ${OPENCL_HEADERS_C}
  ${OPENCL_HEADERS_H}
)
target_include_directories(opencl-clang-embedded-headers PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
set_target_properties(opencl-clang-embedded-headers PROPERTIES POSITION_INDEPENDENT_CODE ON)

if (HAVE_C23_EMBED)
  target_compile_features(opencl-clang-embedded-headers PRIVATE c_std_23)
endif()

install(FILES ${OPENCL_HEADER_FILES}
        DESTINATION include/cclang
)
