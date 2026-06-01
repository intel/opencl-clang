// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test8(void) {
  local int x;
  x = (int)3;
  printf("%+d\n", x);
}
