// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#define PRIV_TYPE double16
#define PRIV_SIZE 2
__kernel void test_fn(__global double16 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global double16 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 2; i++)
    sPrivateStorage[i] = src[i];

  double16 tmp = vload16(offsets[tid], ((__private double *)sPrivateStorage) +
                                           alignmentOffsets[tid]);
  results[tid] = tmp;
}
