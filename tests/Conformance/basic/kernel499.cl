// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_loop(__global int *src, __global int *loopindx,
                        __global int *loopcnt, __global int *dst) {
  int tid = get_global_id(0);
  int n = get_global_size(0);
  int i, j;

  dst[tid] = 0;
  for (i = 0, j = loopindx[tid]; i < loopcnt[tid]; i++, j++) {
    if (j >= n)
      j = 0;
    dst[tid] += src[j];
  }
}
