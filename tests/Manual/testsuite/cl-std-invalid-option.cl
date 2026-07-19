// RUN: not %occ-cli %s --cl-options="-triple spir-unknown-unknown -cl-std=CL1.3" --cl-device=%cl_device %cfg_path --output=%t.bc

__kernel void MyKernel(__global int *pInt) { *pInt = 0; }
