// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant uint mem0[3] = {0};
constant uint2 mem2[3] = {(uint2)(0)};
constant uint3 mem3[3] = {(uint3)(0)};
constant uint4 mem4[3] = {(uint4)(0)};
constant uint8 mem8[3] = {(uint8)(0)};
constant uint16 mem16[3] = {(uint16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
