// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(float src1, float src2, __global float *dst) {
  dst[0] = src1 + src2;
}
