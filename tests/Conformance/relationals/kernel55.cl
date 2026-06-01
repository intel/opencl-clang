// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global uchar2 *sourceA, __global uchar2 *sourceB,
                          __global uchar2 *sourceC,
                          __global uchar2 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = bitselect(sourceA[tid], sourceB[tid], sourceC[tid]);
}
