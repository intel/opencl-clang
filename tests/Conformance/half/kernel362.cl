// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float8 *p, __global half *f) {
  __local float8 data[128];
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  data[lid] = p[i];
  vstorea_half8_rtn(data[lid], i, f);
}
