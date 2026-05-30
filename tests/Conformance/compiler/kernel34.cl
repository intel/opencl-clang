// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define VALUE
__kernel void define_test(__global int *src, __global int *dstA,
                          __global int *dstB) {
  int tid = get_global_id(0);
#ifdef VALUE
  dstA[tid] = src[tid] * 2;
#else
  dstA[tid] = src[tid] * 4;
#endif

#undef VALUE
#ifdef VALUE
  dstB[tid] = src[tid] * 2;
#else
  dstB[tid] = src[tid] * 4;
#endif
}
