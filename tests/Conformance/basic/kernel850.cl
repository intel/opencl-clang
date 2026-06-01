// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int2 *srcValues, __global uint *offsets,
                      __global int2 *destBuffer, uint alignmentOffset) {
  __private int2 sPrivateStorage[32];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (int2)(int)0;

  vstore2(srcValues[tid], offsets[tid],
          ((__private int *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private int *sp =
      (__private int *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global int *dp =
      (__global int *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
