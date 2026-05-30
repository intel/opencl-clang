// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant float mem0[3] = {0};
constant float2 mem2[3] = {(float2)(0)};
constant float3 mem3[3] = {(float3)(0)};
constant float4 mem4[3] = {(float4)(0)};
constant float8 mem8[3] = {(float8)(0)};
constant float16 mem16[3] = {(float16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
