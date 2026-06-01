// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global int *outOffsets) {
  // We use local ID here so we don't have to worry about offsets
  // Also note that these should be the same for ALL threads, so we won't worry
  // about contention
  outOffsets[0] = (int)get_global_offset(0);
  outOffsets[1] = (int)get_global_offset(1);
  outOffsets[2] = (int)get_global_offset(2);
}
