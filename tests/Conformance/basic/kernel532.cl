// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global char *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global char4 *results) {
  int tid = get_global_id(0);
  char4 tmp =
      vload4(offsets[tid], ((__global char *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
