// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

kernel void test(global ulong *results, constant uchar *mem0,
                 constant uchar2 *mem2, constant uchar2 *mem3,
                 constant uchar4 *mem4, constant uchar8 *mem8,
                 constant uchar16 *mem16) {
  results[0] = (ulong)&mem0[0];
  results[1] = (ulong)&mem2[0];
  results[2] = (ulong)&mem3[0];
  results[3] = (ulong)&mem4[0];
  results[4] = (ulong)&mem8[0];
  results[5] = (ulong)&mem16[0];
}
