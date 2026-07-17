// RUN: not %occ-cli %s --cl-options="-Werror -Wuninitialized"
// --cl-device=%cl_device %cfg_path --output=%t.bc 2>&1 | FileCheck %s

__kernel void k() {
  // CHECK: error: variable 'p' is uninitialized when used here
  int *p;
  printf("%d\n", *p);
}
