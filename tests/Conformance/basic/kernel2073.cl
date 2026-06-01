// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

kernel void test(global ulong *results) {
  local uchar mem0[3];
  local uchar2 mem2[3];
  local uchar3 mem3[3];
  local uchar4 mem4[3];
  local uchar8 mem8[3];
  local uchar16 mem16[3];
  results[0] = (ulong)&mem0[0];
  results[1] = (ulong)&mem2[0];
  results[2] = (ulong)&mem3[0];
  results[3] = (ulong)&mem4[0];
  results[4] = (ulong)&mem8[0];
  results[5] = (ulong)&mem16[0];
}
