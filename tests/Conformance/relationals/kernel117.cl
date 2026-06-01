// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global short16 *sourceA, __global short16 *sourceB,
                          __global short16 *sourceC,
                          __global short16 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = select(sourceA[tid], sourceB[tid], sourceC[tid]);
}
