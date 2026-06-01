// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global short3 *sourceA, __global short3 *sourceB,
                          __global short3 *sourceC,
                          __global short3 *destValues) {
  int tid = get_global_id(0);
  short3 tmp = bitselect(vload3(tid, (__global short *)sourceA),
                         vload3(tid, (__global short *)sourceB),
                         vload3(tid, (__global short *)sourceC));
  vstore3(tmp, tid, (__global short *)destValues);
}
