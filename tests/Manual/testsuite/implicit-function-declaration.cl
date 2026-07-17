// RUN: not %occ-cli %s --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s

__kernel void test() {
  bar();
  // CHECK: error: use of undeclared identifier 'bar'
}
