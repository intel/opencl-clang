// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short *src, __global uchar2 *dst) {
  int tid = get_global_id(0);
  uchar2 tmp = as_uchar2(src[tid]);
  dst[tid] = tmp;
}
