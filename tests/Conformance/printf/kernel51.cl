// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test7(void) {
  uint2 tmp = (uint2)(0x12345678, 0x87654321);
  printf("%#v2hlx\n", tmp);
}
