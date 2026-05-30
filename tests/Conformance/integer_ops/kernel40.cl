// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global long *sourceA, __global long *destValues) {
  int tid = get_global_id(0);
  long8 tmp = vload8(tid, destValues);
  tmp = clz(vload8(tid, sourceA));
  vstore8(tmp, tid, destValues);
}
