// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct __attribute__((packed)) myPackedStruct {
  long arrPre[12];
  long2 vec;
  long arrPost[3];
} testStruct;
__kernel void test_vec_align_packed_struct(__constant long2 *source,
                                           __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec) - (__local uchar *)&test);
}
