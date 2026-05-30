// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct __attribute__((packed)) myPackedStruct {
  uchar arrPre[12];
  uchar16 vec;
  uchar arrPost[12];
} testStruct;
__kernel void test_vec_align_packed_struct(__constant uchar16 *source,
                                           __global ulong *dest) {
  __private testStruct test;
  int tid = get_global_id(0);
  dest[tid] =
      (ulong)((__private uchar *)&(test.vec) - (__private uchar *)&test);
}
