// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint8 *srcValues, __global uint *offsets,
                      __global uint8 *destBuffer, uint alignmentOffset) {
  __private uint8 sPrivateStorage[8];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (uint8)(uint)0;

  vstore8(srcValues[tid], offsets[tid],
          ((__private uint *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private uint *sp =
      (__private uint *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global uint *dp =
      (__global uint *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
