// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef struct myUnpackedStruct {
  ulong arrPre[12];
  ulong2 vec;
  ulong3 arrPost;
} testStruct;
__kernel void test_vec_align_struct(__constant ulong2 *source,
                                    __global ulong *dest) {
  __local testStruct test;
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__local uchar *)&(test.vec));
}
