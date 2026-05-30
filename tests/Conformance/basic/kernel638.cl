// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_fn(__constant uchar *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global uchar8 *results) {
  int tid = get_global_id(0);
  uchar8 tmp =
      vload8(offsets[tid], ((__constant uchar *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
