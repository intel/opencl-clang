// RUN: %occ-cli %s --cl-options="-DTEST_MACRO=1" --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global int *dst) { dst[0] = TEST_MACRO; }
