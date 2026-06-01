// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test1(void) { printf("%f\n", 1.0f / 0.0f); }
