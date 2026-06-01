// RUN: %occ-cli %s --cl-options="-I %p/includeTestDirectory" --cl-device=%cl_device %cfg_path
#include "./testIncludeFile.h"
__kernel void sample_test(__global int *dst) { dst[0] = HEADER_FOUND; }
