// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test7(void) {
  long2 tmp = (long2)(12345678, 98765432);
  printf("%v2ld\n", tmp);
}
