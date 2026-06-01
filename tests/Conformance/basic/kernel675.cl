// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_fn(__constant double *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global double2 *results) {
  int tid = get_global_id(0);
  double2 tmp =
      vload2(offsets[tid], ((__constant double *)src) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
