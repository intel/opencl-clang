// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global long8 *srcValues, __global uint *offsets,
                      __global long *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  vstore8(srcValues[tid], offsets[tid], destBuffer + alignmentOffset);
}
