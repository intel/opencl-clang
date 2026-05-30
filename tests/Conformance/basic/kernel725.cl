// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#define PRIV_TYPE double2
#define PRIV_SIZE 16
__kernel void test_fn(__global double2 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global double2 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 16; i++)
    sPrivateStorage[i] = src[i];

  double2 tmp = vload2(offsets[tid], ((__private double *)sPrivateStorage) +
                                         alignmentOffsets[tid]);
  results[tid] = tmp;
}
