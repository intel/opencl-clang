// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(const __global half *p, __global float8 *f) {
  size_t i = get_global_id(0);
  f[i] = vloada_half8(i, p);
}
