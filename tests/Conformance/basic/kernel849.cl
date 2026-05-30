// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ushort16 *srcValues, __global uint *offsets,
                      __global ushort16 *destBuffer, uint alignmentOffset) {
  __private ushort16 sPrivateStorage[8];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (ushort16)(ushort)0;

  vstore16(srcValues[tid], offsets[tid],
           ((__private ushort *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private ushort *sp =
      (__private ushort *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global ushort *dp =
      (__global ushort *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
