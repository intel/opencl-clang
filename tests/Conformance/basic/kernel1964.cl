// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global long *long_out, __global ulong *ulong_out) {
  long_out[0] = LONG_MAX;
  long_out[1] = LONG_MIN;
  ulong_out[0] = ULONG_MAX;
}
