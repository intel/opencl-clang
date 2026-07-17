set(OPENCL_CLANG_LIBRARY_NAME ${TARGET_NAME})
set(TARGET_NAME occ-cli)

include_directories("${OPENCL_CLANG_SOURCE_DIR}")
link_directories("${LLVM_LIBRARY_DIRS}")

add_executable(${TARGET_NAME}
  main.cpp
  common.cpp
  compile.cpp
  IniFiles.cpp
)

add_dependencies(${TARGET_NAME} ${OPENCL_CLANG_LIBRARY_NAME})

target_link_libraries( ${TARGET_NAME}
                       ${OPENCL_CLANG_LIBRARY_NAME} )
