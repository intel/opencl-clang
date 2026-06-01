// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global ushort4 *sourceA, __global ushort4 *sourceB,
                          __global ushort4 *sourceC,
                          __global ushort4 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = bitselect(sourceA[tid], sourceB[tid], sourceC[tid]);
}
