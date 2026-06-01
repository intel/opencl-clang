// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__constant half *p, __global float3 *f) {
  size_t i = get_global_id(0);
  f[i] = vloada_half3(i, p);
  ((__global float *)f)[4 * i + 3] = vload_half(4 * i + 3, p);
}
