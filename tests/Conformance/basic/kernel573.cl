// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global float *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global float8 *results) {
  int tid = get_global_id(0);
  float8 tmp =
      vload8(offsets[tid], ((__global float *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
