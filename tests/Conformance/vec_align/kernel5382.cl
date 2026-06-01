// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct __attribute__((packed)) myPackedStruct {
  long arrPre[12];
  long4 vec;
  long3 arrPost;
} testStruct;
__kernel void test_vec_align_packed_struct(__constant long4 *source,
                                           __global ulong *dest) {
  __private testStruct test;
  int tid = get_global_id(0);
  dest[tid] =
      (ulong)((__private uchar *)&(test.vec) - (__private uchar *)&test);
}
