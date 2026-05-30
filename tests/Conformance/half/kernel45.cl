// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float3 *f) {
  ushort4 data[4];
  half *hdata_p = (half *)&data;
  size_t i = get_global_id(0);
  global ushort *i_p = (global ushort *)p + i * 4;
  int offset = i & 3;
  data[offset] = (ushort4)(i_p[0], i_p[1], i_p[2], USHRT_MAX);
  data[offset ^ 1] = USHRT_MAX;
  data[offset ^ 2] = USHRT_MAX;
  data[offset ^ 3] = USHRT_MAX;
  f[i] = vloada_half3(offset, hdata_p);
  mem_fence(CLK_GLOBAL_MEM_FENCE);
  ((__global float *)f)[4 * i + 3] = vload_half(4 * i + 3, p);
}
