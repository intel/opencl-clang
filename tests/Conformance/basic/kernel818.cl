// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local ulong8 *sSharedStorage,
                      __global ulong8 *srcValues, __global uint *offsets,
                      __global ulong8 *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[offsets[tid]] = (ulong8)(ulong)0;
  sSharedStorage[offsets[tid] + 1] = sSharedStorage[offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore8(srcValues[tid], offsets[tid],
          ((__local ulong *)sSharedStorage) + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local ulong *sp =
      (__local ulong *)(sSharedStorage + offsets[tid]) + alignmentOffset;
  __global ulong *dp =
      (__global ulong *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; (size_t)i < sizeof(sSharedStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
