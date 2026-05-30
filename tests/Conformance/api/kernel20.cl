// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
typedef struct {
  int A;
  int B;
} input_pair_t;

__kernel void sample_test(__global input_pair_t *src, __global int *dst) {
  int tid = get_global_id(0);

  dst[tid] = src[tid].A + src[tid].B;
}
