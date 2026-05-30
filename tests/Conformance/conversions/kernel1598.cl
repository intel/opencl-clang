// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ushort16_rte_float16(__global float16 *src,
                                                __global ushort16 *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_ushort16_rte(src[i]);
}
