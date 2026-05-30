// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant ulong mem0[3] = {0};
constant ulong2 mem2[3] = {(ulong2)(0)};
constant ulong3 mem3[3] = {(ulong3)(0)};
constant ulong4 mem4[3] = {(ulong4)(0)};
constant ulong8 mem8[3] = {(ulong8)(0)};
constant ulong16 mem16[3] = {(ulong16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
