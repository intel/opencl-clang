// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__local char8 *sSharedStorage, __global char8 *src,
                      __global uint *offsets, __global uint *alignmentOffsets,
                      __global char8 *results) {
  int tid = get_global_id(0);
  int lid = get_local_id(0);

  if (lid == 0) {
    for (int i = 0; i < 1024; i++)
      sSharedStorage[i] = src[i];
  }
  barrier(CLK_LOCAL_MEM_FENCE);

  char8 tmp = vload8(offsets[tid],
                     ((__local char *)sSharedStorage) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
