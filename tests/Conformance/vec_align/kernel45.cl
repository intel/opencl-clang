// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_vec_align_array(__global double2 *source,
                                   __global ulong *dest) {
  int tid = get_global_id(0);
  dest[tid] = (ulong)((__global uchar *)(source + tid));
}
