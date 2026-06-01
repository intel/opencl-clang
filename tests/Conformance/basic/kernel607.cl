// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__local uint4 *sSharedStorage, __global uint4 *src,
                      __global uint *offsets, __global uint *alignmentOffsets,
                      __global uint4 *results) {
  int tid = get_global_id(0);
  int lid = get_local_id(0);

  if (lid == 0) {
    for (int i = 0; i < 512; i++)
      sSharedStorage[i] = src[i];
  }
  barrier(CLK_LOCAL_MEM_FENCE);

  uint4 tmp = vload4(offsets[tid],
                     ((__local uint *)sSharedStorage) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
