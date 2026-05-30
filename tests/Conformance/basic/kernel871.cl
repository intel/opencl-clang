// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global float *srcValues, __global uint *offsets,
                      __global float3 *destBuffer, uint alignmentOffset) {
  __private float3 sPrivateStorage[21];
  int tid = get_global_id(0);
  sPrivateStorage[tid] = (float3)(float)0;

  vstore3(vload3(tid, srcValues), offsets[tid],
          ((__private float *)sPrivateStorage) + alignmentOffset);

  uint i;
  __private float *sp =
      ((__private float *)sPrivateStorage) + 3 * offsets[tid] + alignmentOffset;
  __global float *dp =
      ((__global float *)destBuffer) + 3 * offsets[tid] + alignmentOffset;
  for (i = 0; i < 3; i++)
    dp[i] = sp[i];
}
