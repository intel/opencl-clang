// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel(char c, uchar uc, short s, ushort us, int i, uint ui,
                          float f, __global float *result) {
  result[0] = (c);
  result[1] = (uc);
  result[2] = (s);
  result[3] = (us);
  result[4] = (i);
  result[5] = (ui);
  result[6] = f;
}
