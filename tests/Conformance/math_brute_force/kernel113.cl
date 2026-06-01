// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void math_kernel3(__global float *out, __global float *in,
                           __global float *in2) {
  size_t i = get_global_id(0);
  if (i + 1 < get_global_size(0)) {
    float3 f0 = vload3(0, in + 3 * i);
    float3 f1 = vload3(0, in2 + 3 * i);
    f0 = atan2(f0, f1);
    vstore3(f0, 0, out + 3 * i);
  } else {
    size_t parity =
        i & 1; // Figure out how many elements are left over after BUFFER_SIZE %
               // (3*sizeof(float)). Assume power of two buffer size
    float3 f0, f1;
    switch (parity) {
    case 1:
      f0 = (float3)(in[3 * i], NAN, NAN);
      f1 = (float3)(in2[3 * i], NAN, NAN);
      break;
    case 0:
      f0 = (float3)(in[3 * i], in[3 * i + 1], NAN);
      f1 = (float3)(in2[3 * i], in2[3 * i + 1], NAN);
      break;
    }
    f0 = atan2(f0, f1);
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
