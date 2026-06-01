// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local int16 *sSharedStorage, __global int16 *srcValues,
                      __global uint *offsets, __global int16 *destBuffer,
                      uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[offsets[tid]] = (int16)(int)0;
  sSharedStorage[offsets[tid] + 1] = sSharedStorage[offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore16(srcValues[tid], offsets[tid],
           ((__local int *)sSharedStorage) + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local int *sp =
      (__local int *)(sSharedStorage + offsets[tid]) + alignmentOffset;
  __global int *dp =
      (__global int *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; (size_t)i < sizeof(sSharedStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
