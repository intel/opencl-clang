// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel(char2 c, uchar2 uc, short2 s, ushort2 us, int2 i,
                          uint2 ui, float2 f, __global float2 *result) {
  result[0] = convert_float2(c);
  result[1] = convert_float2(uc);
  result[2] = convert_float2(s);
  result[3] = convert_float2(us);
  result[4] = convert_float2(i);
  result[5] = convert_float2(ui);
  result[6] = f;
}
