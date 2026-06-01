// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void test_fn(__global double4 *srcValues, __global uint *offsets,
                      __global double4 *destBuffer, uint alignmentOffset) {
  __private double4 sPrivateStorage[8];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (double4)(double)0;

  vstore4(srcValues[tid], offsets[tid],
          ((__private double *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private double *sp =
      (__private double *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global double *dp =
      (__global double *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
