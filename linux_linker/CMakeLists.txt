add_executable(linux_resource_linker linux_resource_linker.cpp)

if(LLVM_USE_HOST_TOOLS)
  build_native_tool(linux_resource_linker LINUX_RESOURCE_LINKER_COMMAND)
  add_custom_target(linux_resource_linker-host DEPENDS ${LINUX_RESOURCE_LINKER_COMMAND} )
  add_dependencies(linux_resource_linker linux_resource_linker-host)
else()
  set(LINUX_RESOURCE_LINKER_COMMAND linux_resource_linker)
endif()

set(LINUX_RESOURCE_LINKER_COMMAND ${LINUX_RESOURCE_LINKER_COMMAND} PARENT_SCOPE)
