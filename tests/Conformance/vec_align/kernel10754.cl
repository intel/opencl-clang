// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct __attribute__((packed)) myPackedStruct {
  char arrPre[12];
  char16 vec;
  char3 arrPost;
} testStruct;
__kernel void test_vec_align_packed_struct_arr(__global testStruct *source,
                                               __global ulong *dest) {
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__global uchar *)&(source[tid].vec) -
                      (__global uchar *)&(source[0]));
}
