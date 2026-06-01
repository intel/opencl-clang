// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct __attribute__((packed)) myPackedStruct {
  char arrPre[5];
  char3 vec;
  char arrPost[12];
} testStruct;
__kernel void test_vec_align_packed_struct(__constant char3 *source,
                                           __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec) - (__local uchar *)&test);
}
