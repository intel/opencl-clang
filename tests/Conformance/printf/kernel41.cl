// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test5(void) { printf("%4c\n", '1'); }
