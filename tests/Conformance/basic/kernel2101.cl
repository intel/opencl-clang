// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant char mem0[3] = {0};
constant char2 mem2[3] = {(char2)(0)};
constant char3 mem3[3] = {(char3)(0)};
constant char4 mem4[3] = {(char4)(0)};
constant char8 mem8[3] = {(char8)(0)};
constant char16 mem16[3] = {(char16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
