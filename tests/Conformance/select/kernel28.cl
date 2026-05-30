// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_ushort8_ushort8(__global ushort8 *dest,
                                     __global ushort8 *src1,
                                     __global ushort8 *src2,
                                     __global ushort8 *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
