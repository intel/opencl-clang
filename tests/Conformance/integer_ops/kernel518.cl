// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_abs_char3(__global char *srcA, __global uchar *dst) {
  int tid = get_global_id(0);

  uchar3 tmp = abs(vload3(tid, srcA));
  vstore3(tmp, tid, dst);
}
