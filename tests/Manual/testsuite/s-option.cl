// REQUIRES: linux

// RUN: %occ-cli %s --cl-options="-g -s ./tmp/kernel.cl" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-1

// CHECK-1: !1 = !DIFile(filename: "tmp/kernel.cl",

// absolute path

// RUN: %occ-cli %s --cl-options="-g -s /tmp/kernel.cl" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-2

// CHECK-2: !1 = !DIFile(filename: "/tmp/kernel.cl",

// more complicated test cases

// RUN: %occ-cli %s --cl-options="-g -s ./tmp/../tmp/../tmp/kernel.cl" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-3

// CHECK-3: !1 = !DIFile(filename: "tmp/../tmp/../tmp/kernel.cl",

// RUN: %occ-cli %s --cl-options="-g -s /tmp/../tmp/../tmp/kernel.cl" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-4

// CHECK-4: !1 = !DIFile(filename: "/tmp/../tmp/../tmp/kernel.cl",

// test cases with spaces

// RUN: %occ-cli %s --cl-options='-g -s "/path with spaces/kernel.cl"' --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-6

// CHECK-6: !1 = !DIFile(filename: "/path with spaces/kernel.cl",

// RUN: %occ-cli %s --cl-options="-g -s /path\ with\ spaces/kernel.cl" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-7

// CHECK-7: !1 = !DIFile(filename: "/path with spaces/kernel.cl",

// non-ascii characters

// RUN: %occ-cli %s --cl-options="-g -s /tmp/❶❷❸❹❺❻❼❽❾❿.cl" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-8

// CHECK-8: !1 = !DIFile(filename: "/tmp/\E2\9D\B6\E2\9D\B7\E2\9D\B8\E2\9D\B9\E2\9D\BA\E2\9D\BB\E2\9D\BC\E2\9D\BD\E2\9D\BE\E2\9D\BF.cl",

// multiply slashes

// RUN: %occ-cli %s --cl-options="-g -s /tmp//path///to//kernel.cl" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s --check-prefix=CHECK-9

// Clang normalizes only the last segment.
// CHECK-9: !1 = !DIFile(filename: "/tmp//path///to/kernel.cl",

__kernel void test(__global int *text) {
  int gid = get_global_id(0);
  text[gid] += gid;
}
