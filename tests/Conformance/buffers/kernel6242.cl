// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_migrate(__global uint *dst, __global uint *src1,
                                  __global uint *src2, uint x) {
  int tid = get_global_id(0);
  dst[tid] = src1[tid] ^ src2[tid] ^ x;
}
