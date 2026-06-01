// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

kernel void test(global ulong *results, local ushort *mem0, local ushort2 *mem2,
                 local ushort2 *mem3, local ushort4 *mem4, local ushort8 *mem8,
                 local ushort16 *mem16) {
  results[0] = (ulong)&mem0[0];
  results[1] = (ulong)&mem2[0];
  results[2] = (ulong)&mem3[0];
  results[3] = (ulong)&mem4[0];
  results[4] = (ulong)&mem8[0];
  results[5] = (ulong)&mem16[0];
}
