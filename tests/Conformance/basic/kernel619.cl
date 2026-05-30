// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__local ulong16 *sSharedStorage, __global ulong16 *src,
                      __global uint *offsets, __global uint *alignmentOffsets,
                      __global ulong16 *results) {
  int tid = get_global_id(0);
  int lid = get_local_id(0);

  if (lid == 0) {
    for (int i = 0; i < 64; i++)
      sSharedStorage[i] = src[i];
  }
  barrier(CLK_LOCAL_MEM_FENCE);

  ulong16 tmp = vload16(offsets[tid], ((__local ulong *)sSharedStorage) +
                                          alignmentOffsets[tid]);
  results[tid] = tmp;
}
