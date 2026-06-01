// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__local short *sSharedStorage, __global short *src,
                      __global uint *offsets, __global uint *alignmentOffsets,
                      __global short *results) {
  int tid = get_global_id(0);
  int lid = get_local_id(0);

  if (lid == 0) {
    for (int i = 0; i < 1365; i++) {
      sSharedStorage[3 * i] = src[3 * i];
      sSharedStorage[3 * i + 1] = src[3 * i + 1];
      sSharedStorage[3 * i + 2] = src[3 * i + 2];
    }
  }
  barrier(CLK_LOCAL_MEM_FENCE);

  short3 tmp = vload3(offsets[tid], ((__local short *)sSharedStorage) +
                                        alignmentOffsets[tid]);
  results[3 * tid] = tmp.s0;
  results[3 * tid + 1] = tmp.s1;
  results[3 * tid + 2] = tmp.s2;
}
