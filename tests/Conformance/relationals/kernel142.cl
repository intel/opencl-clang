// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global uint16 *sourceA, __global uint16 *sourceB,
                          __global uint16 *sourceC,
                          __global uint16 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = select(sourceA[tid], sourceB[tid], sourceC[tid]);
}
