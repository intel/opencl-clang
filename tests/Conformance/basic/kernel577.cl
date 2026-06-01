// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__global double *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global double4 *results) {
  int tid = get_global_id(0);
  double4 tmp =
      vload4(offsets[tid], ((__global double *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
