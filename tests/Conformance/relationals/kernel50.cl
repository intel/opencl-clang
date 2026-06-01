// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global char3 *sourceA, __global char3 *sourceB,
                          __global char3 *sourceC, __global char3 *destValues) {
  int tid = get_global_id(0);
  char3 tmp = bitselect(vload3(tid, (__global char *)sourceA),
                        vload3(tid, (__global char *)sourceB),
                        vload3(tid, (__global char *)sourceC));
  vstore3(tmp, tid, (__global char *)destValues);
}
