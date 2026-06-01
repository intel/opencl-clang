// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myUnpackedStruct {
  uint arrPre[12];
  uint4 vec;
  uint arrPost[12];
} testStruct;
__kernel void test_vec_align_struct(__constant uint4 *source,
                                    __global ulong *dest) {
  __private testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__private uchar *)&(test.vec));
}
