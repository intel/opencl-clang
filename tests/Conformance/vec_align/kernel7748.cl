// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
typedef struct myStruct {
  char c;
  double8 vec;
  double arrPost[5];
} testStruct;
__kernel void test_vec_align_struct_arr(__global testStruct *source,
                                        __global ulong *dest) {
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__global uchar *)&(source[tid].vec));
}
