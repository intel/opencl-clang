// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant short *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global short2 *results) {
  int tid = get_global_id(0);
  short2 tmp =
      vload2(offsets[tid], ((__constant short *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
