// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test6(void) { printf("%s\n", "%%"); }
