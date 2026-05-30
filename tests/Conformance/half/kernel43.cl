// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__constant half *p, __global float16 *f) {
  size_t i = get_global_id(0);
  f[i] = vloada_half16(i, p);
}
