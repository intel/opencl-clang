// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort *sourceA, __global ushort *sourceB,
                          __global ushort *destValues) {
  int tid = get_global_id(0);
  ushort3 sA = vload3(tid, sourceA);
  ushort3 sB = vload3(tid, sourceB);
  ushort3 dst = mul_hi(sA, sB);
  vstore3(dst, tid, destValues);
}
