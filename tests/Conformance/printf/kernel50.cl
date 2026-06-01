// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test7(void) {
  ushort2 tmp = (ushort2)(0x1234, 0x8765);
  printf("%#v2hx\n", tmp);
}
