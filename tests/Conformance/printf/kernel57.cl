// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test8(__global void *x, __global int *xAddr) {
  printf("%p\n", x);
  *xAddr = (long)x;
}
