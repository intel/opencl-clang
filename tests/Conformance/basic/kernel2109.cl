// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant int mem0[3] = {0};
constant int2 mem2[3] = {(int2)(0)};
constant int3 mem3[3] = {(int3)(0)};
constant int4 mem4[3] = {(int4)(0)};
constant int8 mem8[3] = {(int8)(0)};
constant int16 mem16[3] = {(int16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
