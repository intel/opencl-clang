// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global uchar *sourceA, __global uchar *destValues) {
  int tid = get_global_id(0);
  uchar8 tmp = vload8(tid, destValues);
  tmp ^= (vload8(tid, sourceA));
  vstore8(tmp, tid, destValues);
}
