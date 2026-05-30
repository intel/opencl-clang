// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char16 *srcA, __global char *srcB,
                   __global char16 *srcC, __global char16 *dst) {
  int tid = get_global_id(0);

  char16 valA = srcA[tid];
  char valB = srcB[tid];
  char16 valC = srcC[tid];
  char16 destVal = valC ? valA : valB;
  dst[tid] = destVal;
}
