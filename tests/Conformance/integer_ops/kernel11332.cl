// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global char *srcA, __global char *srcB,
                   __global char *srcC, __global char *dst) {
  int tid = get_global_id(0);

  char valA = srcA[tid];
  char valB = srcB[tid];
  char3 valC = vload3(tid, srcC);
  char3 destVal = valC ? valA : valB;
  vstore3(destVal, tid, dst);
}
