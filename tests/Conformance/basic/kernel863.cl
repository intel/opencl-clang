// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global long8 *srcValues, __global uint *offsets,
                      __global long8 *destBuffer, uint alignmentOffset) {
  __private long8 sPrivateStorage[4];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (long8)(long)0;

  vstore8(srcValues[tid], offsets[tid],
          ((__private long *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private long *sp =
      (__private long *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global long *dp =
      (__global long *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
