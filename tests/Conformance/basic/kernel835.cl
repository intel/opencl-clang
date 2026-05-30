// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar2 *srcValues, __global uint *offsets,
                      __global uchar2 *destBuffer, uint alignmentOffset) {
  __private uchar2 sPrivateStorage[128];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (uchar2)(uchar)0;

  vstore2(srcValues[tid], offsets[tid],
          ((__private uchar *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private uchar *sp =
      (__private uchar *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global uchar *dp =
      (__global uchar *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
