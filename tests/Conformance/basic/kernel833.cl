// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global char8 *srcValues, __global uint *offsets,
                      __global char8 *destBuffer, uint alignmentOffset) {
  __private char8 sPrivateStorage[32];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (char8)(char)0;

  vstore8(srcValues[tid], offsets[tid],
          ((__private char *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private char *sp =
      (__private char *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global char *dp =
      (__global char *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
