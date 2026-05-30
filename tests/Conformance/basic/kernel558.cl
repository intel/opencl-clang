// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global uint *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global uint8 *results) {
  int tid = get_global_id(0);
  uint8 tmp =
      vload8(offsets[tid], ((__global uint *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
