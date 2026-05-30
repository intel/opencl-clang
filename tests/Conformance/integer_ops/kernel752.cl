// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong *sourceA, __global ulong *destValues) {
  int tid = get_global_id(0);
  ulong3 tmp = vload3(tid, destValues);
  tmp += (vload3(tid, sourceA));
  vstore3(tmp, tid, destValues);
}
