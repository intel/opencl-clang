// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_uchar4_uchar4(__global uchar4 *dest, __global uchar4 *src1,
                                   __global uchar4 *src2,
                                   __global uchar4 *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
