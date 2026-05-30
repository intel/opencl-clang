// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global ulong *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ulong16 *results) {
  int tid = get_global_id(0);
  ulong16 tmp =
      vload16(offsets[tid], ((__global ulong *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
