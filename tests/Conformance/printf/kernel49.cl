// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test7(void) {
  uchar2 tmp = (uchar2)(0xFA, 0xFB);
  printf("%#v2hhx\n", tmp);
}
