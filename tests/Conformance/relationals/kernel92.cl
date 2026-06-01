// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global ulong3 *sourceA, __global ulong3 *sourceB,
                          __global ulong3 *sourceC,
                          __global ulong3 *destValues) {
  int tid = get_global_id(0);
  ulong3 tmp = bitselect(vload3(tid, (__global ulong *)sourceA),
                         vload3(tid, (__global ulong *)sourceB),
                         vload3(tid, (__global ulong *)sourceC));
  vstore3(tmp, tid, (__global ulong *)destValues);
}
