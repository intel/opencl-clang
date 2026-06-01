// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test8(void) {
private
  int x;
  x = (int)-1;
  printf("%i\n", x);
}
