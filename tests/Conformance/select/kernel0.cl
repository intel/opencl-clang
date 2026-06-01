// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_uchar_uchar(__global uchar *dest, __global uchar *src1,
                                 __global uchar *src2, __global uchar *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
