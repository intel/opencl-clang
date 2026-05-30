// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar *sourceA, __global uchar *destValues) {
  int tid = get_global_id(0);
  uchar3 tmp = vload3(tid, destValues);
  tmp &= (vload3(tid, sourceA));
  vstore3(tmp, tid, destValues);
}
