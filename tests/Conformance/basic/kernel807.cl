// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local uint4 *sSharedStorage, __global uint4 *srcValues,
                      __global uint *offsets, __global uint4 *destBuffer,
                      uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[offsets[tid]] = (uint4)(uint)0;
  sSharedStorage[offsets[tid] + 1] = sSharedStorage[offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore4(srcValues[tid], offsets[tid],
          ((__local uint *)sSharedStorage) + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local uint *sp =
      (__local uint *)(sSharedStorage + offsets[tid]) + alignmentOffset;
  __global uint *dp =
      (__global uint *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; (size_t)i < sizeof(sSharedStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
