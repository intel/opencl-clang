// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
void test_function_to_call(__global int *output, __global int *input,
                           int where);

__kernel void test_kernel_to_call(__global int *output, __global int *input,
                                  int where) {
  int b;
  if (where == 0) {
    output[get_global_id(0)] = 0;
  }
  for (b = 0; b < where; b++)
    output[get_global_id(0)] += input[b];
}

__kernel void test_call_kernel(__global int *src, __global int *dst,
                               int times) {
  int tid = get_global_id(0);
  int a;
  dst[tid] = 1;
  for (a = 0; a < times; a++)
    test_kernel_to_call(dst, src, tid);
}
void test_function_to_call(__global int *output, __global int *input,
                           int where) {
  int b;
  if (where == 0) {
    output[get_global_id(0)] = 0;
  }
  for (b = 0; b < where; b++)
    output[get_global_id(0)] += input[b];
}

__kernel void test_call_function(__global int *src, __global int *dst,
                                 int times) {
  int tid = get_global_id(0);
  int a;
  dst[tid] = 1;
  for (a = 0; a < times; a++)
    test_function_to_call(dst, src, tid);
}
