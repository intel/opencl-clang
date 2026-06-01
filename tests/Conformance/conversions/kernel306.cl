// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_uchar_int(__global int *src, __global uchar *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_uchar(src[i]);
}
