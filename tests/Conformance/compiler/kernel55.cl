// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void CopyBuffer(__global float *src, __global float *dst) {
  int id = (int)get_global_id(0);
  dst[id] = src[id];
}
int foo(int x, int y) { return x * x + y * y; }
