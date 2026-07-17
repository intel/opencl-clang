/*  'testsuite/dbg-line-column.cl'  */
// "-g" option does not generate dwarf column information on Windows.
// RUN: %occ-cli %s --cl-options="-g" %cfg_path --cl-device=%cl_device --output=%t.bc
// RUN: llvm-dis %t.bc -o - | FileCheck %s

// CHECK: call void @llvm.dbg.declare(metadata i32 addrspace(1)** %input.addr, metadata ![[#]], metadata !DIExpression(DW_OP_constu, 0, DW_OP_swap, DW_OP_xderef)), !dbg ![[LOC:[0-9]+]]
// Only check there is line and scope information since column information
// isn't generated on Windows
// CHECK: ![[LOC]] = !DILocation(line: {{[0-9]+}}, {{.*}}scope: !{{[0-9]+}})

int foo(__global int *input) {
  *input += 5;

  return 3;
}

__kernel void ocl_test_kernel(__global int *ocl_test_results) {
  int a = foo(ocl_test_results);
}
