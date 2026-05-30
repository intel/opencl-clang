// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_char16_uchar16(__global char16 *dest,
                                    __global char16 *src1,
                                    __global char16 *src2,
                                    __global uchar16 *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
