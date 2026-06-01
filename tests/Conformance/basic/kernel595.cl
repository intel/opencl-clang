// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__local ushort2 *sSharedStorage, __global ushort2 *src,
                      __global uint *offsets, __global uint *alignmentOffsets,
                      __global ushort2 *results) {
  int tid = get_global_id(0);
  int lid = get_local_id(0);

  if (lid == 0) {
    for (int i = 0; i < 2048; i++)
      sSharedStorage[i] = src[i];
  }
  barrier(CLK_LOCAL_MEM_FENCE);

  ushort2 tmp = vload2(offsets[tid], ((__local ushort *)sSharedStorage) +
                                         alignmentOffsets[tid]);
  results[tid] = tmp;
}
