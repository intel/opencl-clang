// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar8 *srcValues, __global uint *offsets,
                      __global uchar8 *destBuffer, uint alignmentOffset) {
  __private uchar8 sPrivateStorage[32];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (uchar8)(uchar)0;

  vstore8(srcValues[tid], offsets[tid],
          ((__private uchar *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private uchar *sp =
      (__private uchar *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global uchar *dp =
      (__global uchar *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
