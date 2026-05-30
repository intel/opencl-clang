// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_step_type(__global long4 *source, __global int *dest) {
  int tid = get_global_id(0);
  dest[tid] = vec_step(long4);
}
