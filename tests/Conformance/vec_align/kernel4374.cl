// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct __attribute__((packed)) myPackedStruct {
  short3 s;
  int16 vec;
  int arrPost[3];
} testStruct;
__kernel void test_vec_align_packed_struct(__constant int16 *source,
                                           __global ulong *dest) {
  __private testStruct test;
  int tid = get_global_id(0);
  dest[tid] =
      (ulong)((__private uchar *)&(test.vec) - (__private uchar *)&test);
}
