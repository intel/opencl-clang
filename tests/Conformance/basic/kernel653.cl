// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant int *src, __global uint *offsets,
                      __global uint *alignmentOffsets, __global int8 *results) {
  int tid = get_global_id(0);
  int8 tmp =
      vload8(offsets[tid], ((__constant int *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
