// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ushort2 *srcValues, __global uint *offsets,
                      __global ushort2 *destBuffer, uint alignmentOffset) {
  __private ushort2 sPrivateStorage[64];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (ushort2)(ushort)0;

  vstore2(srcValues[tid], offsets[tid],
          ((__private ushort *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private ushort *sp =
      (__private ushort *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global ushort *dp =
      (__global ushort *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
