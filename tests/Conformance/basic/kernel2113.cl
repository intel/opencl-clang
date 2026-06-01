// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant long mem0[3] = {0};
constant long2 mem2[3] = {(long2)(0)};
constant long3 mem3[3] = {(long3)(0)};
constant long4 mem4[3] = {(long4)(0)};
constant long8 mem8[3] = {(long8)(0)};
constant long16 mem16[3] = {(long16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
