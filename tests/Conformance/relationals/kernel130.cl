// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global uchar4 *sourceA, __global uchar4 *sourceB,
                          __global uchar4 *sourceC,
                          __global uchar4 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = select(sourceA[tid], sourceB[tid], sourceC[tid]);
}
