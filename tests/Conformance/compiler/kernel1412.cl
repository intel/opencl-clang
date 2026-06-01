// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void CopyBuffer210(__global float *src, __global float *dst) {
  int id = (int)get_global_id(0);
  dst[id] = src[id];
}
