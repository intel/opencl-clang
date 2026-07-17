// RUN: %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL1.2" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL2.0" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL1.2" --cl-options-ex="-cl-ext=-all,+cl_khr_fp64" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL2.0" --cl-options-ex="-cl-ext=-all,+cl_khr_fp64" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL3.0" --cl-options-ex="-cl-ext=-all,+cl_khr_fp64,+__opencl_c_fp64,-cl_khr_3d_image_writes,+__opencl_c_images" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL3.1" --cl-options-ex="-cl-ext=-all,+cl_khr_fp64,+__opencl_c_fp64,-cl_khr_3d_image_writes,+__opencl_c_images" --cl-device=%cl_device %cfg_path --output=%t.bc

// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL1.2" --cl-options-ex="-cl-ext=-cl_khr_fp64" --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s
// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL2.0" --cl-options-ex="-cl-ext=-cl_khr_fp64" --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s
// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL3.0" --cl-options-ex="-cl-ext=-cl_khr_fp64,-__opencl_c_fp64,-cl_khr_3d_image_writes" --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s
// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL3.1" --cl-options-ex="-cl-ext=-cl_khr_fp64,-__opencl_c_fp64,-cl_khr_3d_image_writes" --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s
// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL1.2" --cl-options-ex="-cl-ext=-all" --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s
// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL2.0" --cl-options-ex="-cl-ext=-all" --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s
// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL3.0" --cl-options-ex="-cl-ext=-all" --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s
// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL3.1" --cl-options-ex="-cl-ext=-all" --cl-device=%cl_device %cfg_path 2>&1 | FileCheck %s

__kernel void
MyKernel(const float fConstant, const double dConstant,
         // CHECK: error: use of type 'double' requires [[FP64:cl_khr_fp64( and __opencl_c_fp64)?]] support
         __global double *pDouble)
         // CHECK: error: use of type 'double' requires [[FP64]] support
{
  float f = fConstant + 1.0;
  // CHECK: warning: double precision constant requires [[FP64]], casting to single precision
  double d = fConstant;
  // CHECK: error: use of type 'double' requires [[FP64]] support

  f = cos(1.0);
  // CHECK: warning: double precision constant requires [[FP64]], casting to single precision

  f = (double)1.0f;
  // CHECK: use of type 'double' requires [[FP64]] support
}
