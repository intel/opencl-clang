// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global uint8 *src, __global ushort16 *dst) {
  int tid = get_global_id(0);
  ushort16 tmp = as_ushort16(src[tid]);
  dst[tid] = tmp;
}
