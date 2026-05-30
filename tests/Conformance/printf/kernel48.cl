// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test7(void) {
  float4 tmp = (float4)(1.0f, 2.0f, 3.0f, 4.0f);
  printf("%2.2v4hlf\n", tmp);
}
