set(LLVM_TOOLS_DIR ${LLVM_TOOLS_BINARY_DIR})

set(OPENCL_CLANG_TEST_DEVICE "DEFAULT" CACHE STRING "Device name for opencl-clang lit tests (section key in ConfExt.ini)")

add_subdirectory(occ-cli)

# Set the depends list as a variable so that it can grow conditionally.
# NOTE: Sync the substitutions in test/lit.cfg when adding to this list.
set(OPENCL_CLANG_TEST_DEPENDS
  FileCheck
  llvm-dis
  count
  not
  occ-cli
  ${TARGET_NAME}
)

configure_lit_site_cfg(
  ${CMAKE_CURRENT_SOURCE_DIR}/lit.site.cfg.py.in
  ${CMAKE_CURRENT_BINARY_DIR}/lit.site.cfg.py
  MAIN_CONFIG
  ${CMAKE_CURRENT_SOURCE_DIR}/lit.cfg.py
)

add_lit_testsuite(check-opencl-clang "Running the OpenCL Clang regression tests"
  ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${OPENCL_CLANG_TEST_DEPENDS}
  )
set_target_properties(check-opencl-clang PROPERTIES FOLDER "OpenCL-Clang Tests")
