// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global long *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global long2 *results) {
  int tid = get_global_id(0);
  long2 tmp =
      vload2(offsets[tid], ((__global long *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
