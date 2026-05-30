// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant short mem0[3] = {0};
constant short2 mem2[3] = {(short2)(0)};
constant short3 mem3[3] = {(short3)(0)};
constant short4 mem4[3] = {(short4)(0)};
constant short8 mem8[3] = {(short8)(0)};
constant short16 mem16[3] = {(short16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
