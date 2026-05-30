// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global uint3 *sourceA, __global uint3 *sourceB,
                          __global uint3 *sourceC, __global uint3 *destValues) {
  int tid = get_global_id(0);
  uint3 tmp = bitselect(vload3(tid, (__global uint *)sourceA),
                        vload3(tid, (__global uint *)sourceB),
                        vload3(tid, (__global uint *)sourceC));
  vstore3(tmp, tid, (__global uint *)destValues);
}
