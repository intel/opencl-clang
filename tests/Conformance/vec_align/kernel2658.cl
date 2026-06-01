// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myUnpackedStruct {
  short3 s;
  uchar8 vec;
  uchar3 arrPost;
} testStruct;
__kernel void test_vec_align_struct(__constant uchar8 *source,
                                    __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec));
}
