// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void kernel_with_bool(__global float *src, __global int *dst) {
  int tid = get_global_id(0);

  bool myBool = (src[tid] < 0.5f) && (src[tid] > -0.5f);
  if (myBool) {
    dst[tid] = (int)src[tid];
  } else {
    dst[tid] = 0;
  }
}
