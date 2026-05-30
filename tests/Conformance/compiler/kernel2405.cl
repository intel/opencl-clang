// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
extern __kernel void CopyBuffer(__global float *src, __global float *dst);
__kernel void AnotherCopyBuffer(__global float *src, __global float *dst) {
  CopyBuffer(src, dst);
}
