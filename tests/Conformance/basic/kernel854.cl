// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int16 *srcValues, __global uint *offsets,
                      __global int16 *destBuffer, uint alignmentOffset) {
  __private int16 sPrivateStorage[4];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (int16)(int)0;

  vstore16(srcValues[tid], offsets[tid],
           ((__private int *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private int *sp =
      (__private int *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global int *dp =
      (__global int *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
