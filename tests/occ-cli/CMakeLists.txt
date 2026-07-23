set(OCC_CLI_TARGET_NAME occ-cli)

include_directories("${OPENCL_CLANG_SOURCE_DIR}")
link_directories("${LLVM_LIBRARY_DIRS}")

add_executable(${OCC_CLI_TARGET_NAME}
  main.cpp
  common.cpp
  compile.cpp
  IniFiles.cpp
)

target_link_libraries(${OCC_CLI_TARGET_NAME} ${TARGET_NAMEE})
