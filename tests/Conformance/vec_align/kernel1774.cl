// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myUnpackedStruct {
  int arrPre[12];
  int16 vec;
  int3 arrPost;
} testStruct;
__kernel void test_vec_align_struct(__constant int16 *source,
                                    __global ulong *dest) {
  __private testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__private uchar *)&(test.vec));
}
