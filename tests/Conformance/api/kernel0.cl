// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int *dst, int count) {
  int tid = get_global_id(0);

  for (int i = 0; i < count; i++)
    dst[i] = tid + i;
}
