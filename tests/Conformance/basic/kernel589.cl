// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__local uchar16 *sSharedStorage, __global uchar16 *src,
                      __global uint *offsets, __global uint *alignmentOffsets,
                      __global uchar16 *results) {
  int tid = get_global_id(0);
  int lid = get_local_id(0);

  if (lid == 0) {
    for (int i = 0; i < 512; i++)
      sSharedStorage[i] = src[i];
  }
  barrier(CLK_LOCAL_MEM_FENCE);

  uchar16 tmp = vload16(offsets[tid], ((__local uchar *)sSharedStorage) +
                                          alignmentOffsets[tid]);
  results[tid] = tmp;
}
