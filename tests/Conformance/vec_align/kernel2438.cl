// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myUnpackedStruct {
  char c;
  ulong8 vec;
  ulong arrPost[12];
} testStruct;
__kernel void test_vec_align_struct(__constant ulong8 *source,
                                    __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec));
}
