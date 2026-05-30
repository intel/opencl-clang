// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float *f) {
  __local ushort data[128];
  __local half *hdata_p = (__local half *)data;
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  data[lid] = ((__global ushort *)p)[i];
  f[i] = vload_half(lid, hdata_p);
}
