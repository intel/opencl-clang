// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel3(__global float *out, __global float *out2,
                           __global float *in) {
  size_t i = get_global_id(0);
  if (i + 1 < get_global_size(0)) {
    float3 f0 = vload3(0, in + 3 * i);
    float3 iout = NAN;
    f0 = fract(f0, &iout);
    vstore3(f0, 0, out + 3 * i);
    vstore3(iout, 0, out2 + 3 * i);
  } else {
    size_t parity =
        i & 1; // Figure out how many elements are left over after BUFFER_SIZE %
               // (3*sizeof(float)). Assume power of two buffer size
    float3 iout = NAN;
    float3 f0;
    switch (parity) {
    case 1:
      f0 = (float3)(in[3 * i], NAN, NAN);
      break;
    case 0:
      f0 = (float3)(in[3 * i], in[3 * i + 1], NAN);
      break;
    }
    f0 = fract(f0, &iout);
    switch (parity) {
    case 0:
      out[3 * i + 1] = f0.y;
      out2[3 * i + 1] = iout.y;
      // fall through
    case 1:
      out[3 * i] = f0.x;
      out2[3 * i] = iout.x;
      break;
    }
  }
}
