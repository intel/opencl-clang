// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short *srcValues, __global uint *offsets,
                      __global short3 *destBuffer, uint alignmentOffset) {
  __private short3 sPrivateStorage[42];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (short3)(short)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private short *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private short *sp =
      ((__private short *)sPrivateStorage) + 3 * offsets[tid] + alignmentOffset;
  __global short *dp =
      ((__global short *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
