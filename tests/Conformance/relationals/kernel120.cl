// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global int4 *sourceA, __global int4 *sourceB,
                          __global int4 *sourceC, __global int4 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = select(sourceA[tid], sourceB[tid], sourceC[tid]);
}
