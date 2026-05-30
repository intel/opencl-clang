// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar16 *srcValues, __global uint *offsets,
                      __global uchar16 *destBuffer, uint alignmentOffset) {
  __private uchar16 sPrivateStorage[16];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (uchar16)(uchar)0;

  vstore16(srcValues[tid], offsets[tid],
           ((__private uchar *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private uchar *sp =
      (__private uchar *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global uchar *dp =
      (__global uchar *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
