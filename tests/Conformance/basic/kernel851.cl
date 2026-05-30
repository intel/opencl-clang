// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global int *srcValues, __global uint *offsets,
                      __global int3 *destBuffer, uint alignmentOffset) {
  __private int3 sPrivateStorage[21];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (int3)(int)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private int *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private int *sp =
      ((__private int *)sPrivateStorage) + 3 * offsets[tid] + alignmentOffset;
  __global int *dp =
      ((__global int *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
