// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant ushort mem0[3] = {0};
constant ushort2 mem2[3] = {(ushort2)(0)};
constant ushort3 mem3[3] = {(ushort3)(0)};
constant ushort4 mem4[3] = {(ushort4)(0)};
constant ushort8 mem8[3] = {(ushort8)(0)};
constant ushort16 mem16[3] = {(ushort16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
