// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_add_sat_uchar3(__global uchar *srcA, __global uchar *srcB,
                                  __global uchar *dst) {
  int tid = get_global_id(0);

  uchar3 tmp = add_sat(vload3(tid, srcA), vload3(tid, srcB));
  vstore3(tmp, tid, dst);
}
