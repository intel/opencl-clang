// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_ushort16_short16(__global ushort16 *dest,
                                      __global ushort16 *src1,
                                      __global ushort16 *src2,
                                      __global short16 *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
