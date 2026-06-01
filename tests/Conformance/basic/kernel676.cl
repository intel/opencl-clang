// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__constant double *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global double *results) {
  int tid = get_global_id(0);
  double3 tmp =
      vload3(offsets[tid], ((__constant double *)src) + alignmentOffsets[tid]);
  results[3 * tid] = tmp.s0;
  results[3 * tid + 1] = tmp.s1;
  results[3 * tid + 2] = tmp.s2;
}
