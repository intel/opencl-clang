// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myUnpackedStruct {
  uint arrPre[5];
  uint3 vec;
  uint arrPost[5];
} testStruct;
__kernel void test_vec_align_struct(__constant uint3 *source,
                                    __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec));
}
