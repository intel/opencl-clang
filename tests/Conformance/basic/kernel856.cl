// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint *srcValues, __global uint *offsets,
                      __global uint3 *destBuffer, uint alignmentOffset) {
  __private uint3 sPrivateStorage[21];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (uint3)(uint)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private uint *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private uint *sp =
      ((__private uint *)sPrivateStorage) + 3 * offsets[tid] + alignmentOffset;
  __global uint *dp =
      ((__global uint *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
