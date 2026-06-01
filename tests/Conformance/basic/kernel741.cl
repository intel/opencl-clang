// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global short3 *srcValues, __global uint *offsets,
                      __global short *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  if ((tid & 3) == 0) { // if "tid" is a multiple of 4
    vstore3(srcValues[3 * (tid >> 2)], offsets[tid],
            destBuffer + alignmentOffset);
  } else {
    vstore3(vload3(tid, (__global short *)srcValues), offsets[tid],
            destBuffer + alignmentOffset);
  }
}
