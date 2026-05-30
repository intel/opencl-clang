// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uchar *srcValues, __global uint *offsets,
                      __global uchar3 *destBuffer, uint alignmentOffset) {
  __private uchar3 sPrivateStorage[85];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (uchar3)(uchar)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private uchar *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private uchar *sp =
      ((__private uchar *)sPrivateStorage) + 3 * offsets[tid] + alignmentOffset;
  __global uchar *dp =
      ((__global uchar *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
