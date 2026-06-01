// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test1(void) { printf("%4G\n", 0.023); }
