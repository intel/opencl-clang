// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ulong_rtn_uchar(__global uchar *src,
                                           __global ulong *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ulong_rtn(src[i]);
}
