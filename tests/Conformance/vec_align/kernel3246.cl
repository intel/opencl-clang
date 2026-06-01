// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
typedef struct myUnpackedStruct {
  double arrPre[5];
  double3 vec;
  double arrPost[5];
} testStruct;
__kernel void test_vec_align_struct(__constant double3 *source,
                                    __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec));
}
