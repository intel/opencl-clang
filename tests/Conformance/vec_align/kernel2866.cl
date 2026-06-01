// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myUnpackedStruct {
  ushort3 tPre;
  ushort3 vec;
  ushort arrPost[3];
} testStruct;
__kernel void test_vec_align_struct(__constant ushort3 *source,
                                    __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec));
}
