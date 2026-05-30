// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ulong *sourceA, __global ulong *sourceB,
                          __global ulong *destValues) {
  int tid = get_global_id(0);
  ulong3 sA = vload3(tid, sourceA);
  ulong3 sB = vload3(tid, sourceB);
  ulong3 dst = hadd(sA, sB);
  vstore3(dst, tid, destValues);
}
