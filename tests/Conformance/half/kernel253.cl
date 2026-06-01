// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global float2 *p, __global half *f) {
  __private ushort data[16];
  size_t i = get_global_id(0);
  size_t offset = 0;
  size_t vecsize = vec_step(p[i]);
  vstore_half2_rtp(p[i], 0, (__private half *)(&data[0]));
  for (offset = 0; offset < vecsize; offset++) {
    vstore_half(vload_half(offset, (__private half *)data), 0,
                &f[vecsize * i + offset]);
  }
}
