// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test8(constant int *x) { printf("%d\n", *x); }
