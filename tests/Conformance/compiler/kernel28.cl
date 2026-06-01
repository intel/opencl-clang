// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int *dst) {
#ifdef TEST_MACRO
  dst[0] = 42;
#else
  dst[0] = 24;
#endif
}
