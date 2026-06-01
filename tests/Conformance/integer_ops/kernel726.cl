// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global ushort *sourceA,
                          __global ushort *destValues) {
  int tid = get_global_id(0);
  destValues[tid] += (sourceA[tid]);
}
