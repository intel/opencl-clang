// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test8(__global int *x) { printf("%d\n", *x); }
