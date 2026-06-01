// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local float2 *sSharedStorage,
                      __global float2 *srcValues, __global uint *offsets,
                      __global float2 *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[offsets[tid]] = (float2)(float)0;
  sSharedStorage[offsets[tid] + 1] = sSharedStorage[offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore2(srcValues[tid], offsets[tid],
          ((__local float *)sSharedStorage) + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local float *sp =
      (__local float *)(sSharedStorage + offsets[tid]) + alignmentOffset;
  __global float *dp =
      (__global float *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; (size_t)i < sizeof(sSharedStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
