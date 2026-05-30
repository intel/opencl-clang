// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ulong *src, __global uchar8 *dst) {
  int tid = get_global_id(0);
  uchar8 tmp = as_uchar8(src[tid]);
  dst[tid] = tmp;
}
