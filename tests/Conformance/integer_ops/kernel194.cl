// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char *sourceA, __global char *sourceB,
                          __global char *destValues) {
  int tid = get_global_id(0);
  char3 sA = vload3(tid, sourceA);
  char3 sB = vload3(tid, sourceB);
  char3 dst = rotate(sA, sB);
  vstore3(dst, tid, destValues);
}
