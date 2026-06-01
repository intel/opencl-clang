// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant uint *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global uint2 *results) {
  int tid = get_global_id(0);
  uint2 tmp =
      vload2(offsets[tid], ((__constant uint *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
