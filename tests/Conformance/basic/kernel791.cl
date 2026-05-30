// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__local short *sSharedStorage, __global short *srcValues,
                      __global uint *offsets, __global short *destBuffer,
                      uint alignmentOffset) {
  int tid = get_global_id(0);
  sSharedStorage[3 * offsets[tid]] = (short)0;
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
  __local short *sp = (sSharedStorage + 3 * offsets[tid]) + alignmentOffset;
  __global short *dp = (destBuffer + 3 * offsets[tid]) + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
