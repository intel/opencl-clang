// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
typedef double4 TypeToTest;
__kernel void test_step_typedef_var(__global TypeToTest *source,
                                    __global int *dest) {
  int tid = get_global_id(0);
  dest[tid] = vec_step(source[tid]);
}
