// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uint *sourceA, __global uint *destValues) {
  int tid = get_global_id(0);
  uint2 tmp = vload2(tid, destValues);
  tmp -= (vload2(tid, sourceA));
  vstore2(tmp, tid, destValues);
}
