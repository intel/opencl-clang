// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global char *srcValues, __global uint *offsets,
                      __global char3 *destBuffer, uint alignmentOffset) {
  __private char3 sPrivateStorage[85];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (char3)(char)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private char *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private char *sp =
      ((__private char *)sPrivateStorage) + 3 * offsets[tid] + alignmentOffset;
  __global char *dp =
      ((__global char *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
