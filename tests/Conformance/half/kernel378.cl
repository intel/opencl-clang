// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *in, __global half *out) {
  size_t i = get_global_id(0);
  vstore_half(vload_half(i, in), i, out);
}
