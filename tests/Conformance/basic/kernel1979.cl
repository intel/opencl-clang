// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel_long(long16 l, ulong16 ul, __global float16 *result) {
  result[0] = convert_float16(l);
  result[1] = convert_float16(ul);
}
