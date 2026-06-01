// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local ushort *sSharedStorage,
                      __global ushort *srcValues, __global uint *offsets,
                      __global ushort *destBuffer, uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[3 * offsets[tid]] = (ushort)0;
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
  __local ushort *sp = (sSharedStorage + 3 * offsets[tid]) + alignmentOffset;
  __global ushort *dp = (destBuffer + 3 * offsets[tid]) + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
