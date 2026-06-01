// RUN: %occ-cli %s --cl-options="-DFIRST=5 -DSECOND=37" --cl-device=%cl_device %cfg_path
__kernel void CopyBuffer(__global float *src, __global float *dst) {
  int id = (int)get_global_id(0);
  float temp = src[id] - 42;
  dst[id] = FIRST + temp + SECOND;
}
