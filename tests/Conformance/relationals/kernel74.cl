// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global int3 *sourceA, __global int3 *sourceB,
                          __global int3 *sourceC, __global int3 *destValues) {
  int tid = get_global_id(0);
  int3 tmp = bitselect(vload3(tid, (__global int *)sourceA),
                       vload3(tid, (__global int *)sourceB),
                       vload3(tid, (__global int *)sourceC));
  vstore3(tmp, tid, (__global int *)destValues);
}
