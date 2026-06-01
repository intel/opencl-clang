// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void simple_task(__global float *output) { output[0] += 1; }
