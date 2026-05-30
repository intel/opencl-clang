// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__local double16 *sSharedStorage, __global double16 *src,
                      __global uint *offsets, __global uint *alignmentOffsets,
                      __global double16 *results) {
  int tid = get_global_id(0);
  int lid = get_local_id(0);

  if (lid == 0) {
    for (int i = 0; i < 64; i++)
      sSharedStorage[i] = src[i];
  }
  barrier(CLK_LOCAL_MEM_FENCE);

  double16 tmp = vload16(offsets[tid], ((__local double *)sSharedStorage) +
                                           alignmentOffsets[tid]);
  results[tid] = tmp;
}
