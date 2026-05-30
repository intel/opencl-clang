// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void kernelA(__global int *dst) { dst[get_global_id(0)] *= 3; }
__kernel void kernelB(__global int *dst) { dst[get_global_id(0)]++; }
