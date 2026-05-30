// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local ulong *sSharedStorage, __global ulong *srcValues,
                      __global uint *offsets, __global ulong *destBuffer,
                      uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[3 * offsets[tid]] = (ulong)0;
  sSharedStorage[3 * offsets[tid] + 1] = sSharedStorage[3 * offsets[tid]];
  sSharedStorage[3 * offsets[tid] + 2] = sSharedStorage[3 * offsets[tid]];
  sSharedStorage[3 * offsets[tid] + 3] = sSharedStorage[3 * offsets[tid]];
  sSharedStorage[3 * offsets[tid] + 4] = sSharedStorage[3 * offsets[tid]];
  sSharedStorage[3 * offsets[tid] + 5] = sSharedStorage[3 * offsets[tid]];
  barrier(CLK_LOCAL_MEM_FENCE);

  vstore3(vload3(tid, srcValues), offsets[tid],
          sSharedStorage + alignmentOffset);

  barrier(CLK_LOCAL_MEM_FENCE);

  int i;
  __local ulong *sp = (sSharedStorage + 3 * offsets[tid]) + alignmentOffset;
  __global ulong *dp = (destBuffer + 3 * offsets[tid]) + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
