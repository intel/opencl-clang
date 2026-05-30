// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global short *sourceA, __global short *destValues) {
  int tid = get_global_id(0);
  short16 tmp = vload16(tid, destValues);
  tmp ^= (vload16(tid, sourceA));
  vstore16(tmp, tid, destValues);
}
