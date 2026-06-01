// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local uchar2 *sSharedStorage,
                      __global uchar2 *srcValues, __global uint *offsets,
                      __global uchar2 *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[offsets[tid]] = (uchar2)(uchar)0;
  sSharedStorage[offsets[tid] + 1] = sSharedStorage[offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore2(srcValues[tid], offsets[tid],
          ((__local uchar *)sSharedStorage) + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local uchar *sp =
      (__local uchar *)(sSharedStorage + offsets[tid]) + alignmentOffset;
  __global uchar *dp =
      (__global uchar *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; (size_t)i < sizeof(sSharedStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
