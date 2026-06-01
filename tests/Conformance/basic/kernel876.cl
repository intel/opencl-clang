// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void test_fn(__global double *srcValues, __global uint *offsets,
                      __global double3 *destBuffer, uint alignmentOffset) {
  __private double3 sPrivateStorage[10];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (double3)(double)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private double *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private double *sp = ((__private double *)sPrivateStorage) +
                         3 * offsets[tid] + alignmentOffset;
  __global double *dp =
      ((__global double *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
