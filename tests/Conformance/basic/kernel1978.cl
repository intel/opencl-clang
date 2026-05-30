// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel_long(long8 l, ulong8 ul, __global float8 *result) {
  result[0] = convert_float8(l);
  result[1] = convert_float8(ul);
}
