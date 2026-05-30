// Can't test in-memory-headers using lit
// XFAIL: *

// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#include "foo/simple_header1.h"
#include "simple_header0.h"
__kernel void CompositeKernel(__global float *src, __global float *dst) {
  CopyBuffer0(src, dst);
  CopyBuffer1(src, dst);
}
