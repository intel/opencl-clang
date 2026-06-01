// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global long3 *sourceA, __global long3 *sourceB,
                          __global long3 *sourceC, __global long3 *destValues) {
  int tid = get_global_id(0);
  long3 tmp = bitselect(vload3(tid, (__global long *)sourceA),
                        vload3(tid, (__global long *)sourceB),
                        vload3(tid, (__global long *)sourceC));
  vstore3(tmp, tid, (__global long *)destValues);
}
