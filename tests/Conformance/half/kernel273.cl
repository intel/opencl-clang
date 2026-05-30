// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test(__global double16 *p, __global half *f) {
  size_t i = get_global_id(0);
  vstore_half16_rtp(p[i], i, f);
}
