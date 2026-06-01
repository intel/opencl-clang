// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void math_kernel3(__global double *out, __global double *in,
                           __global double *in2) {
  size_t i = get_global_id(0);
  if (i + 1 < get_global_size(0)) {
    double3 d0 = vload3(0, in + 3 * i);
    double3 d1 = vload3(0, in2 + 3 * i);
    d0 = atan2(d0, d1);
    vstore3(d0, 0, out + 3 * i);
  } else {
    size_t parity =
        i & 1; // Figure out how many elements are left over after BUFFER_SIZE %
               // (3*sizeof(float)). Assume power of two buffer size
    double3 d0, d1;
    switch (parity) {
    case 1:
      d0 = (double3)(in[3 * i], NAN, NAN);
      d1 = (double3)(in2[3 * i], NAN, NAN);
      break;
    case 0:
      d0 = (double3)(in[3 * i], in[3 * i + 1], NAN);
      d1 = (double3)(in2[3 * i], in2[3 * i + 1], NAN);
      break;
    }
    d0 = atan2(d0, d1);
    switch (parity) {
    case 0:
      out[3 * i + 1] = d0.y;
      // fall through
    case 1:
      out[3 * i] = d0.x;
      break;
    }
  }
}
