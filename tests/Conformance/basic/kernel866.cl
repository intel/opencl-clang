// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ulong *srcValues, __global uint *offsets,
                      __global ulong3 *destBuffer, uint alignmentOffset) {
  __private ulong3 sPrivateStorage[10];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (ulong3)(ulong)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private ulong *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private ulong *sp =
      ((__private ulong *)sPrivateStorage) + 3 * offsets[tid] + alignmentOffset;
  __global ulong *dp =
      ((__global ulong *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
