// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void math_kernel3(__global double *out, __global ulong *in) {
  size_t i = get_global_id(0);
  if (i + 1 < get_global_size(0)) {
    ulong3 u0 = vload3(0, in + 3 * i);
    double3 f0 = nan(u0);
    vstore3(f0, 0, out + 3 * i);
  } else {
    size_t parity =
        i & 1; // Figure out how many elements are left over after BUFFER_SIZE %
               // (3*sizeof(float)). Assume power of two buffer size
    ulong3 u0;
    switch (parity) {
    case 1:
      u0 = (ulong3)(in[3 * i], 0xdeaddeaddeaddeadUL, 0xdeaddeaddeaddeadUL);
      break;
    case 0:
      u0 = (ulong3)(in[3 * i], in[3 * i + 1], 0xdeaddeaddeaddeadUL);
      break;
    }
    double3 f0 = nan(u0);
    switch (parity) {
    case 0:
      out[3 * i + 1] = f0.y;
      // fall through
    case 1:
      out[3 * i] = f0.x;
      break;
    }
  }
}
