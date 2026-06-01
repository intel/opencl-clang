// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_uint8_int8(__global uint8 *dest, __global uint8 *src1,
                                __global uint8 *src2, __global int8 *cmp) {
  size_t tid = get_global_id(0);
  if (tid < get_global_size(0))
    dest[tid] = select(src1[tid], src2[tid], cmp[tid]);
}
