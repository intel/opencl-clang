// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char *srcA, __global char4 *srcB,
                   __global char4 *srcC, __global char4 *dst) {
  int tid = get_global_id(0);

  char valA = srcA[tid];
  char4 valB = srcB[tid];
  char4 valC = srcC[tid];
  char4 destVal = valC ? valA : valB;
  dst[tid] = destVal;
}
