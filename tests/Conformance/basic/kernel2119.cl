// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
constant double mem0[3] = {0};
constant double2 mem2[3] = {(double2)(0)};
constant double3 mem3[3] = {(double3)(0)};
constant double4 mem4[3] = {(double4)(0)};
constant double8 mem8[3] = {(double8)(0)};
constant double16 mem16[3] = {(double16)(0)};

kernel void test(global ulong *results) {
  results[0] = (ulong)&mem0;
  results[1] = (ulong)&mem2;
  results[2] = (ulong)&mem3;
  results[3] = (ulong)&mem4;
  results[4] = (ulong)&mem8;
  results[5] = (ulong)&mem16;
}
