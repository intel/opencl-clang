// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_buffer_read_float4(__global float4 *dst) {
  int tid = get_global_id(0);

  dst[tid] = (float)3.40282346638528860e+38;
}
