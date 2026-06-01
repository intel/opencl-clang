// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global int *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global int16 *results) {
  int tid = get_global_id(0);
  int16 tmp =
      vload16(offsets[tid], ((__global int *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
