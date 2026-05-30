// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant ushort *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ushort2 *results) {
  int tid = get_global_id(0);
  ushort2 tmp =
      vload2(offsets[tid], ((__constant ushort *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
