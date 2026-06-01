// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__local int *src1, __global int *global_src,
                          __global int *dst) {
  int tid = get_global_id(0);

  src1[tid] = global_src[tid];
  barrier(CLK_GLOBAL_MEM_FENCE);
  dst[tid] = src1[tid];
}
