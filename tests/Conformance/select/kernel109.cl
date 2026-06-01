// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void select_double2_ulong2(__global double2 *dest,
                                    __global double2 *src1,
                                    __global double2 *src2,
                                    __global ulong2 *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
