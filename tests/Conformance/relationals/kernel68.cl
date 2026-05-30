// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global ushort3 *sourceA, __global ushort3 *sourceB,
                          __global ushort3 *sourceC,
                          __global ushort3 *destValues) {
  int tid = get_global_id(0);
  ushort3 tmp = bitselect(vload3(tid, (__global ushort *)sourceA),
                          vload3(tid, (__global ushort *)sourceB),
                          vload3(tid, (__global ushort *)sourceC));
  vstore3(tmp, tid, (__global ushort *)destValues);
}
