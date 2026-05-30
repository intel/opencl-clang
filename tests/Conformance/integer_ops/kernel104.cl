// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar *sourceA, __global uchar *sourceB,
                          __global uchar *destValues) {
  int tid = get_global_id(0);
  uchar3 sA = vload3(tid, sourceA);
  uchar3 sB = vload3(tid, sourceB);
  uchar3 dst = rhadd(sA, sB);
  vstore3(dst, tid, destValues);
}
