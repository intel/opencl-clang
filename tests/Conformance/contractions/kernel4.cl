// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL FP_CONTRACT OFF
__kernel void kernel1(__global float16 *out, const __global float16 *a,
                      const __global float16 *b, const __global float16 *c) {
  int i = get_global_id(0);
  out[i] = a[i] * b[i] + c[i];
}

__kernel void kernel2(__global float16 *out, const __global float16 *a,
                      const __global float16 *b, const __global float16 *c) {
  int i = get_global_id(0);
  out[i] = a[i] * b[i] - c[i];
}

__kernel void kernel3(__global float16 *out, const __global float16 *a,
                      const __global float16 *b, const __global float16 *c) {
  int i = get_global_id(0);
  out[i] = c[i] + a[i] * b[i];
}

__kernel void kernel4(__global float16 *out, const __global float16 *a,
                      const __global float16 *b, const __global float16 *c) {
  int i = get_global_id(0);
  out[i] = c[i] - a[i] * b[i];
}

__kernel void kernel5(__global float16 *out, const __global float16 *a,
                      const __global float16 *b, const __global float16 *c) {
  int i = get_global_id(0);
  out[i] = -(a[i] * b[i] + c[i]);
}

__kernel void kernel6(__global float16 *out, const __global float16 *a,
                      const __global float16 *b, const __global float16 *c) {
  int i = get_global_id(0);
  out[i] = -(a[i] * b[i] - c[i]);
}

__kernel void kernel7(__global float16 *out, const __global float16 *a,
                      const __global float16 *b, const __global float16 *c) {
  int i = get_global_id(0);
  out[i] = -(c[i] + a[i] * b[i]);
}

__kernel void kernel8(__global float16 *out, const __global float16 *a,
                      const __global float16 *b, const __global float16 *c) {
  int i = get_global_id(0);
  out[i] = -(c[i] - a[i] * b[i]);
}
