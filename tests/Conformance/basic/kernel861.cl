// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global long *srcValues, __global uint *offsets,
                      __global long3 *destBuffer, uint alignmentOffset) {
  __private long3 sPrivateStorage[10];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (long3)(long)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private long *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private long *sp =
      ((__private long *)sPrivateStorage) + 3 * offsets[tid] + alignmentOffset;
  __global long *dp =
      ((__global long *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
