// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global char *sourceA, __global char *destValues) {
  int tid = get_global_id(0);
  char4 tmp = vload4(tid, destValues);
  tmp |= (vload4(tid, sourceA));
  vstore4(tmp, tid, destValues);
}
