// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void test_fn(__global double16 *srcValues, __global uint *offsets,
                      __global double16 *destBuffer, uint alignmentOffset) {
  __private double16 sPrivateStorage[2];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (double16)(double)0;

  vstore16(srcValues[tid], offsets[tid],
           ((__private double *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private double *sp =
      (__private double *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global double *dp =
      (__global double *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
