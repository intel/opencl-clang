// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
typedef struct myUnpackedStruct {
  double2 vec;
  char cPost;
} testStruct;
__kernel void test_vec_align_struct(__constant double2 *source,
                                    __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec));
}
