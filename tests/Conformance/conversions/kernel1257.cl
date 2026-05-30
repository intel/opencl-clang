// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ushort_sat_rte_uchar(__global uchar *src,
                                                __global ushort *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ushort_sat_rte(src[i]);
}
