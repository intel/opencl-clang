// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
extern __kernel void CopyBuffer0(__global float *src, __global float *dst);
extern __kernel void CopyBuffer1(__global float *src, __global float *dst);
extern __kernel void CopyBuffer2(__global float *src, __global float *dst);
extern __kernel void CopyBuffer3(__global float *src, __global float *dst);
extern __kernel void CopyBuffer4(__global float *src, __global float *dst);
extern __kernel void CopyBuffer5(__global float *src, __global float *dst);
extern __kernel void CopyBuffer6(__global float *src, __global float *dst);
extern __kernel void CopyBuffer7(__global float *src, __global float *dst);
__kernel void CompositeKernel(__global float *src, __global float *dst) {
  CopyBuffer0(src, dst);
  CopyBuffer1(src, dst);
  CopyBuffer2(src, dst);
  CopyBuffer3(src, dst);
  CopyBuffer4(src, dst);
  CopyBuffer5(src, dst);
  CopyBuffer6(src, dst);
  CopyBuffer7(src, dst);
}
