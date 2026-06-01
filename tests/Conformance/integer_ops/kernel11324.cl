// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char *srcA, __global char2 *srcB,
                   __global char2 *srcC, __global char2 *dst) {
  int tid = get_global_id(0);

  char valA = srcA[tid];
  char2 valB = srcB[tid];
  char2 valC = srcC[tid];
  char2 destVal = valC ? valA : valB;
  dst[tid] = destVal;
}
