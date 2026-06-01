// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void CopyBuffer(__global float *src, __global float *dst) {
  int id = (int)get_global_id(0);
  dst[id] = src[id];
}
constant struct bar {
  float x, y, z, r;
  int color;
} foo = {0.f, 0.f, 0.f, 0.f, 0};
