// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test2(void) { printf("%04.5o\n", 10); }
