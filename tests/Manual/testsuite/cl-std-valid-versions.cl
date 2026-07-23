// RUN: %occ-cli %s --cl-options="-triple spirv64-unknown-unknown -cl-std=CL1.1" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spirv64-unknown-unknown -cl-std=CL1.2" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spirv64-unknown-unknown -cl-std=CL2.0" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spirv64-unknown-unknown -cl-std=CL3.0" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spirv64-unknown-unknown -cl-std=CL3.1" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spirv64-unknown-unknown -cl-std=CLC++" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spirv64-unknown-unknown -cl-std=CLC++1.0" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: %occ-cli %s --cl-options="-triple spirv64-unknown-unknown -cl-std=CLC++2021" --cl-device=%cl_device %cfg_path --output=%t.bc

__kernel void MyKernel(__global int *pInt) { *pInt = 0; }
