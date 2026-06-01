// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global uchar3 *sourceA, __global uchar3 *sourceB,
                          __global uchar3 *sourceC,
                          __global uchar3 *destValues) {
  int tid = get_global_id(0);
  uchar3 tmp = bitselect(vload3(tid, (__global uchar *)sourceA),
                         vload3(tid, (__global uchar *)sourceB),
                         vload3(tid, (__global uchar *)sourceC));
  vstore3(tmp, tid, (__global uchar *)destValues);
}
