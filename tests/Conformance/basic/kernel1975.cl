// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel_long(long l, ulong ul, __global float *result) {
  result[0] = (l);
  result[1] = (ul);
}
