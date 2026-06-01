// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct __attribute__((packed)) myPackedStruct {
  short3 s;
  long8 vec;
  long3 arrPost;
} testStruct;
__kernel void test_vec_align_packed_struct(__constant long8 *source,
                                           __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec) - (__local uchar *)&test);
}
