// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort *sourceA,
                          __global ushort *destValues) {
  int tid = get_global_id(0);
  ushort3 tmp = vload3(tid, destValues);
  tmp += (vload3(tid, sourceA));
  vstore3(tmp, tid, destValues);
}
