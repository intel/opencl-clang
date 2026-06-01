// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local ushort16 *sSharedStorage,
                      __global ushort16 *srcValues, __global uint *offsets,
                      __global ushort16 *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[offsets[tid]] = (ushort16)(ushort)0;
  sSharedStorage[offsets[tid] + 1] = sSharedStorage[offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore16(srcValues[tid], offsets[tid],
           ((__local ushort *)sSharedStorage) + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local ushort *sp =
      (__local ushort *)(sSharedStorage + offsets[tid]) + alignmentOffset;
  __global ushort *dp =
      (__global ushort *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; (size_t)i < sizeof(sSharedStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
