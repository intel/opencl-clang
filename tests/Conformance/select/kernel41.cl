// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_short16_ushort16(__global short16 *dest,
                                      __global short16 *src1,
                                      __global short16 *src2,
                                      __global ushort16 *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
