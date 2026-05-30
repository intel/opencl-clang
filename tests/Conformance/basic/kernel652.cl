// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant int *src, __global uint *offsets,
                      __global uint *alignmentOffsets, __global int4 *results) {
  int tid = get_global_id(0);
  int4 tmp =
      vload4(offsets[tid], ((__constant int *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
