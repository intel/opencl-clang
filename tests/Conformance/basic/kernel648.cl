// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant ushort *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ushort8 *results) {
  int tid = get_global_id(0);
  ushort8 tmp =
      vload8(offsets[tid], ((__constant ushort *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
