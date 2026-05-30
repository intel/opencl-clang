/*  'testsuite/read_image_attributes.cl'  */

// RUN: %occ-cli %s %cfg_path --cl-device=%cl_device --output=%t.bc
// RUN: llvm-dis %t.bc -o - | FileCheck %s

// CHECK-NOT:     attributes{{.*}}readnone

const sampler_t smp =
    CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

void ocl_read_image1d_attributes(__read_only image1d_t img,
                                 __global float *resf, __global int *resi) {
  *resf += read_imagef(img, 0).x;
  *resf += read_imagef(img, .0f).x;
  *resf += read_imagef(img, smp, 0).x;
  *resf += read_imagef(img, smp, .0f).x;

  *resi += read_imagei(img, 0).x;
  *resi += read_imagei(img, .0f).x;
  *resi += read_imagei(img, smp, 0).x;
  *resi += read_imagei(img, smp, .0f).x;

  *resi += read_imageui(img, 0).x;
  *resi += read_imageui(img, .0f).x;
  *resi += read_imageui(img, smp, 0).x;
  *resi += read_imageui(img, smp, .0f).x;
}
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0:#[0-9]+]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]

void ocl_read_image1d_buffer_attributes(__read_only image1d_buffer_t img,
                                        __global float *resf,
                                        __global int *resi) {
  *resf += read_imagef(img, 0).x;
  *resi += read_imagei(img, 0).x;
  *resi += read_imageui(img, 0).x;
}
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]

void ocl_read_image1d_arr_attributes(__read_only image1d_array_t img,
                                     __global float *resf, __global int *resi) {
  *resf += read_imagef(img, (int2)(0)).x;
  *resf += read_imagef(img, smp, (int2)(0)).x;
  *resf += read_imagef(img, smp, (float2)(0)).x;

  *resi += read_imagei(img, (int2)(0)).x;
  *resi += read_imagei(img, smp, (int2)(0)).x;
  *resi += read_imagei(img, smp, (float2)(0)).x;

  *resi += read_imageui(img, (int2)(0)).x;
  *resi += read_imageui(img, smp, (int2)(0)).x;
  *resi += read_imageui(img, smp, (float2)(0)).x;
}
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]

void ocl_read_image2d_attributes(__read_only image2d_t img,
                                 __global float *resf, __global int *resi) {
  *resf += read_imagef(img, (int2)0).x;
  *resf += read_imagef(img, smp, (int2)0).x;
  *resf += read_imagef(img, smp, (float2).0f).x;

  *resi += read_imagei(img, (int2)0).x;
  *resi += read_imagei(img, smp, (int2)0).x;
  *resi += read_imagei(img, smp, (float2).0f).x;

  *resi += read_imageui(img, (int2)0).x;
  *resi += read_imageui(img, smp, (int2)0).x;
  *resi += read_imageui(img, smp, (float2).0f).x;
}
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]

void ocl_read_image2d_array_attributes(__read_only image2d_array_t img,
                                       __global float *resf,
                                       __global int *resi) {
  *resf += read_imagef(img, (int4)0).x;
  *resf += read_imagef(img, smp, (int4)0).x;
  *resf += read_imagef(img, smp, (float4).0f).x;

  *resi += read_imagei(img, (int4)0).x;
  *resi += read_imagei(img, smp, (int4)0).x;
  *resi += read_imagei(img, smp, (float4).0f).x;

  *resi += read_imageui(img, (int4)0).x;
  *resi += read_imageui(img, smp, (int4)0).x;
  *resi += read_imageui(img, smp, (float4).0f).x;
}
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]

void ocl_read_image3d_attributes(__read_only image3d_t img,
                                 __global float *resf, __global int *resi) {
  *resf += read_imagef(img, (int4)0).x;
  *resf += read_imagef(img, smp, (int4)0).x;
  *resf += read_imagef(img, smp, (float4).0f).x;

  *resi += read_imagei(img, (int4)0).x;
  *resi += read_imagei(img, smp, (int4)0).x;
  *resi += read_imagei(img, smp, (float4).0f).x;

  *resi += read_imageui(img, (int4)0).x;
  *resi += read_imageui(img, smp, (int4)0).x;
  *resi += read_imageui(img, smp, (float4).0f).x;
}
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]

void ocl_read_image2d_depth_attributes(__read_only image2d_depth_t img,
                                       __global float *resf,
                                       __global int *resi) {
  *resf += read_imagef(img, (int2)0);
  *resf += read_imagef(img, smp, (int2)0);
  *resf += read_imagef(img, smp, (float2).0f);
}
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]

void ocl_read_image2d_array_depth_attributes(
    __read_only image2d_array_depth_t img, __global float *resf,
    __global int *resi) {
  *resf += read_imagef(img, (int4)0);
  *resf += read_imagef(img, smp, (int4)0);
  *resf += read_imagef(img, smp, (float4).0f);
}
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]
// CHECK:         declare{{.*}}read_image{{.*}}[[ATTRS0]]

// CHECK-DAG:     attributes [[ATTRS0]]{{.*}}memory(read)
