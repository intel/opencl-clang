// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ushort *srcValues, __global uint *offsets,
                      __global ushort3 *destBuffer, uint alignmentOffset) {
  __private ushort3 sPrivateStorage[42];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (ushort3)(ushort)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private ushort *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private ushort *sp = ((__private ushort *)sPrivateStorage) +
                         3 * offsets[tid] + alignmentOffset;
  __global ushort *dp =
      ((__global ushort *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
