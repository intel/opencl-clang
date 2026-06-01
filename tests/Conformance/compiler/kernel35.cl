// RUN: %occ-cli %s --cl-options=" -I%S " --cl-device=%cl_device %cfg_path
#include "includeTestDirectory/testIncludeFile.h"
__kernel void include_test(__global int *src, __global int *dstA) {
  int tid = get_global_id(0);
#ifdef HEADER_FOUND
  dstA[tid] = HEADER_FOUND;
#else
  dstA[tid] = 0;
#endif
}
