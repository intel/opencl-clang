// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float *f) {
  __private ushort data[1];
  __private half *hdata_p = (__private half *)data;
  size_t i = get_global_id(0);
  data[0] = ((__global ushort *)p)[i];
  f[i] = vload_half(0, hdata_p);
}
