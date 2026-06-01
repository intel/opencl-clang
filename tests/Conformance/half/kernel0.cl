// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float *f) {
  size_t i = get_global_id(0);
  f[i] = vload_half(i, p);
}
