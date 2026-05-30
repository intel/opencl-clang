// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_float_rtz_uint(__global uint *src,
                                          __global float *dest) {
  size_t i = get_global_id(0);
  dest[i] = convert_float_rtz(src[i]);
}
