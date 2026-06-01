// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global short4 *src, __global ushort4 *dst) {
  int tid = get_global_id(0);
  ushort4 tmp = as_ushort4(src[tid]);
  dst[tid] = tmp;
}
