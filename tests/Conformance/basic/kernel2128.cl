// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

kernel void test(global ulong *results) {
private
  float mem0[3];
private
  float2 mem2[3];
private
  float3 mem3[3];
private
  float4 mem4[3];
private
  float8 mem8[3];
private
  float16 mem16[3];
  results[0] = (ulong)&mem0[0];
  results[1] = (ulong)&mem2[0];
  results[2] = (ulong)&mem3[0];
  results[3] = (ulong)&mem4[0];
  results[4] = (ulong)&mem8[0];
  results[5] = (ulong)&mem16[0];
}
