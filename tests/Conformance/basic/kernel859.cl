// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint16 *srcValues, __global uint *offsets,
                      __global uint16 *destBuffer, uint alignmentOffset) {
  __private uint16 sPrivateStorage[4];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (uint16)(uint)0;

  vstore16(srcValues[tid], offsets[tid],
           ((__private uint *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private uint *sp =
      (__private uint *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global uint *dp =
      (__global uint *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
