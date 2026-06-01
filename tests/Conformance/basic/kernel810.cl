// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local long2 *sSharedStorage, __global long2 *srcValues,
                      __global uint *offsets, __global long2 *destBuffer,
                      uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[offsets[tid]] = (long2)(long)0;
  sSharedStorage[offsets[tid] + 1] = sSharedStorage[offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore2(srcValues[tid], offsets[tid],
          ((__local long *)sSharedStorage) + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local long *sp =
      (__local long *)(sSharedStorage + offsets[tid]) + alignmentOffset;
  __global long *dp =
      (__global long *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; (size_t)i < sizeof(sSharedStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
