// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float8 *srcValues, __global uint *offsets,
                      __global float8 *destBuffer, uint alignmentOffset) {
  __private float8 sPrivateStorage[8];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (float8)(float)0;

  vstore8(srcValues[tid], offsets[tid],
          ((__private float *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private float *sp =
      (__private float *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global float *dp =
      (__global float *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
