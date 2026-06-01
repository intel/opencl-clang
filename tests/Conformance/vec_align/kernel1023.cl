// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myUnpackedStruct {
  int3 tPre;
  int8 vec;
  char cPost;
} testStruct;
__kernel void test_vec_align_struct(__constant int8 *source,
                                    __global ulong *dest) {
  __private testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__private uchar *)&(test.vec));
}
