// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test3(void) { printf("%.0u\n", 0); }
