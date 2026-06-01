// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global ushort *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ushort *results) {
  int tid = get_global_id(0);
  ushort3 tmp =
      vload3(offsets[tid], ((__global ushort *)src) + alignmentOffsets[tid]);
  results[3 * tid] = tmp.s0;
  results[3 * tid + 1] = tmp.s1;
  results[3 * tid + 2] = tmp.s2;
}
