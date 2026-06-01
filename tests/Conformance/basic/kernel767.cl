// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global ulong4 *srcValues, __global uint *offsets,
                      __global ulong *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  vstore4(srcValues[tid], offsets[tid], destBuffer + alignmentOffset);
}
