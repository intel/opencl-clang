// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char *srcA, __global char8 *srcB,
                   __global char8 *srcC, __global char8 *dst) {
  int tid = get_global_id(0);

  char valA = srcA[tid];
  char8 valB = srcB[tid];
  char8 valC = srcC[tid];
  char8 destVal = valC ? valA : valB;
  dst[tid] = destVal;
}
