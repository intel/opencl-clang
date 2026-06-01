// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_long16_long16(__global long16 *dest, __global long16 *src1,
                                   __global long16 *src2,
                                   __global long16 *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
