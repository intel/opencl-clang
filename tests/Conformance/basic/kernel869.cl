// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ulong16 *srcValues, __global uint *offsets,
                      __global ulong16 *destBuffer, uint alignmentOffset) {
  __private ulong16 sPrivateStorage[2];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (ulong16)(ulong)0;

  vstore16(srcValues[tid], offsets[tid],
           ((__private ulong *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private ulong *sp =
      (__private ulong *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global ulong *dp =
      (__global ulong *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
