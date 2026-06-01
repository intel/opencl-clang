// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__local long *sSharedStorage, __global long *src,
                      __global uint *offsets, __global uint *alignmentOffsets,
                      __global long *results) {
  int tid = get_global_id(0);
  int lid = get_local_id(0);

  if (lid == 0) {
    for (int i = 0; i < 341; i++) {
      sSharedStorage[3 * i] = src[3 * i];
      sSharedStorage[3 * i + 1] = src[3 * i + 1];
      sSharedStorage[3 * i + 2] = src[3 * i + 2];
    }
  }
  barrier(CLK_LOCAL_MEM_FENCE);

  long3 tmp = vload3(offsets[tid],
                     ((__local long *)sSharedStorage) + alignmentOffsets[tid]);
  results[3 * tid] = tmp.s0;
  results[3 * tid + 1] = tmp.s1;
  results[3 * tid + 2] = tmp.s2;
}
