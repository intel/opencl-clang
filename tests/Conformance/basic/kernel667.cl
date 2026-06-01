// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant ulong *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ulong4 *results) {
  int tid = get_global_id(0);
  ulong4 tmp =
      vload4(offsets[tid], ((__constant ulong *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
