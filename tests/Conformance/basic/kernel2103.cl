// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

constant uchar mem0[3] = {0};
constant uchar2 mem2[3] = {(uchar2)(0)};
constant uchar3 mem3[3] = {(uchar3)(0)};
constant uchar4 mem4[3] = {(uchar4)(0)};
constant uchar8 mem8[3] = {(uchar8)(0)};
constant uchar16 mem16[3] = {(uchar16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
