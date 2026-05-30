// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel_long(long2 l, ulong2 ul, __global float2 *result) {
  result[0] = convert_float2(l);
  result[1] = convert_float2(ul);
}
