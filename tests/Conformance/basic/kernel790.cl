// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local short2 *sSharedStorage,
                      __global short2 *srcValues, __global uint *offsets,
                      __global short2 *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[offsets[tid]] = (short2)(short)0;
  sSharedStorage[offsets[tid] + 1] = sSharedStorage[offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore2(srcValues[tid], offsets[tid],
          ((__local short *)sSharedStorage) + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local short *sp =
      (__local short *)(sSharedStorage + offsets[tid]) + alignmentOffset;
  __global short *dp =
      (__global short *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; (size_t)i < sizeof(sSharedStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
