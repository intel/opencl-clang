// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short2 *srcValues, __global uint *offsets,
                      __global short2 *destBuffer, uint alignmentOffset) {
  __private short2 sPrivateStorage[64];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (short2)(short)0;

  vstore2(srcValues[tid], offsets[tid],
          ((__private short *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private short *sp =
      (__private short *)(sPrivateStorage + offsets[tid]) + alignmentOffset;
  __global short *dp =
      (__global short *)(destBuffer + offsets[tid]) + alignmentOffset;
  for (i = 0; i < sizeof(sPrivateStorage[0]) / sizeof(*sp); i++)
    dp[i] = sp[i];
}
