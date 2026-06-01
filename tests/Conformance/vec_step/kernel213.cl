// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

typedef uint4 TypeToTest;
__kernel void test_step_typedef_var(__global TypeToTest *source,
                                    __global int *dest) {
  int tid = get_global_id(0);
  dest[tid] = vec_step(source[tid]);
}
