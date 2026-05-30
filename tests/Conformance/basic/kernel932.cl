// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global char *src, __global uchar4 *dst) {
  int tid = get_global_id(0);
  uchar4 tmp = as_uchar4(vload3(tid, src));
  dst[tid] = tmp;
}
