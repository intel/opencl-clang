// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float16 *srcValues, __global uint *offsets,
                      __global float16 *destBuffer, uint alignmentOffset) {
  __private float16 sPrivateStorage[4];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (float16)(float)0;

  vstore16(srcValues[tid], offsets[tid],
           ((__private float *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private float *sp =
      (__private float *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global float *dp =
      (__global float *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
