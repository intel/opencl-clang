// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ulong16_float16(__global float16 *src,
                                           __global ulong16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong16(src[i]);
}
