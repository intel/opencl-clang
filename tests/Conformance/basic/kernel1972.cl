// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_kernel(char4 c, uchar4 uc, short4 s, ushort4 us, int4 i,
                          uint4 ui, float4 f, __global float4 *result) {
  result[0] = convert_float4(c);
  result[1] = convert_float4(uc);
  result[2] = convert_float4(s);
  result[3] = convert_float4(us);
  result[4] = convert_float4(i);
  result[5] = convert_float4(ui);
  result[6] = f;
}
