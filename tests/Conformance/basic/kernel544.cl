// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__global short *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global short16 *results) {
  int tid = get_global_id(0);
  short16 tmp =
      vload16(offsets[tid], ((__global short *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
