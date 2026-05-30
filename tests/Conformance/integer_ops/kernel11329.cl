// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char2 *srcA, __global char *srcB,
                   __global char *srcC, __global char2 *dst) {
  int tid = get_global_id(0);

  char2 valA = srcA[tid];
  char valB = srcB[tid];
  char valC = srcC[tid];
  char2 destVal = valC ? valA : valB;
  dst[tid] = destVal;
}
