// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myStruct {
  ushort arrPre[5];
  ushort8 vec;
  ushort3 arrPost;
} testStruct;
__kernel void test_vec_align_struct_arr(__global testStruct *source,
                                        __global ulong *dest) {
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__global uchar *)&(source[tid].vec));
}
