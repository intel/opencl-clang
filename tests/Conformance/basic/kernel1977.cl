// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel_long(long4 l, ulong4 ul, __global float4 *result) {
  result[0] = convert_float4(l);
  result[1] = convert_float4(ul);
}
