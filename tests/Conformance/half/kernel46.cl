// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float3 *f) {
  __local ushort data[512];
  __local half *hdata_p = (__local half *)data;
  __global ushort *i_p = (__global ushort *)p;
  size_t i = get_global_id(0);
  size_t lid = get_local_id(0);
  int k;
  for (k = 0; k < 4; k++)
    data[lid * 4 + k] = i_p[i * 4 + k];
  f[i] = vloada_half3(lid, hdata_p);
  ((__global float *)f)[4 * i + 3] = vload_half(lid * 4 + 3, hdata_p);
}
