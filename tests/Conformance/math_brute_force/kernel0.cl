// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void IsTininessDetectedBeforeRounding(__global float *out) {
  volatile float a = 0x1.000002p-126f;
  volatile float b = 0x1.fffffcp-1f;
  out[0] = a * b;
}
