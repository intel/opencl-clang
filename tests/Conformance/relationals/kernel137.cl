// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global ushort16 *sourceA,
                          __global ushort16 *sourceB,
                          __global ushort16 *sourceC,
                          __global ushort16 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = select(sourceA[tid], sourceB[tid], sourceC[tid]);
}
