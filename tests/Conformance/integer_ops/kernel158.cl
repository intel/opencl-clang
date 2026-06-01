// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short *sourceA, __global short *sourceB,
                          __global short *destValues) {
  int tid = get_global_id(0);
  short3 sA = vload3(tid, sourceA);
  short3 sB = vload3(tid, sourceB);
  short3 dst = mul_hi(sA, sB);
  vstore3(dst, tid, destValues);
}
