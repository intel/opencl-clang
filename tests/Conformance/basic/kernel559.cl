// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global uint *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global uint16 *results) {
  int tid = get_global_id(0);
  uint16 tmp =
      vload16(offsets[tid], ((__global uint *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
