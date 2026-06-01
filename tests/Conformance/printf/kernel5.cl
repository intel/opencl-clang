// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test0(void) { printf("%.5i\n", 100); }
