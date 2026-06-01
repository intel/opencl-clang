// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global ulong8 *sourceA, __global ulong8 *sourceB,
                          __global ulong8 *sourceC,
                          __global ulong8 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = select(sourceA[tid], sourceB[tid], sourceC[tid]);
}
