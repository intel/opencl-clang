// Can't test in-memory-headers using lit
// XFAIL: *

// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#include "simple_header.h"
__kernel void AnotherCopyBuffer(__global float *src, __global float *dst) {
  CopyBuffer(src, dst);
}
