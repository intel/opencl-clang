// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant char *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global char2 *results) {
  int tid = get_global_id(0);
  char2 tmp =
      vload2(offsets[tid], ((__constant char *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
