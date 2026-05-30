// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myStruct {
  char c;
  short16 vec;
  short arrPost[5];
} testStruct;
__kernel void test_vec_align_struct_arr(__global testStruct *source,
                                        __global ulong *dest) {
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__global uchar *)&(source[tid].vec));
}
