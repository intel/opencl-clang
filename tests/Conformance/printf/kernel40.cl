// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test4(void) { printf("%04x\n", 399); }
