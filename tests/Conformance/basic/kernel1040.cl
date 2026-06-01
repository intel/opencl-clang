// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void test_fn(__global ushort4 *src, __global short *dst) {
  int tid = get_global_id(0);
  short3 tmp = as_short3(src[tid]);
  vstore3(tmp, tid, dst);
}
