// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel(char16 c, uchar16 uc, short16 s, ushort16 us, int16 i,
                          uint16 ui, float16 f, __global float16 *result) {
  result[0] = convert_float16(c);
  result[1] = convert_float16(uc);
  result[2] = convert_float16(s);
  result[3] = convert_float16(us);
  result[4] = convert_float16(i);
  result[5] = convert_float16(ui);
  result[6] = f;
}
