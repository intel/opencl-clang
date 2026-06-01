// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double16 *srcValues, __global uint *offsets,
                      __global double *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  vstore16(srcValues[tid], offsets[tid], destBuffer + alignmentOffset);
}
