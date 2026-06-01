// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct __attribute__((packed)) myPackedStruct {
  float16 vec;
  char cPost;
} testStruct;
__kernel void test_vec_align_packed_struct(__constant float16 *source,
                                           __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec) - (__local uchar *)&test);
}
