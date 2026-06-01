// Can't test in-memory-headers using lit
// XFAIL: *

// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#include "foo/bar/baz/simple_header11.h"
#include "foo/bar/baz/simple_header15.h"
#include "foo/bar/baz/simple_header3.h"
#include "foo/bar/baz/simple_header7.h"
#include "foo/bar/simple_header10.h"
#include "foo/bar/simple_header14.h"
#include "foo/bar/simple_header2.h"
#include "foo/bar/simple_header6.h"
#include "foo/simple_header1.h"
#include "foo/simple_header13.h"
#include "foo/simple_header5.h"
#include "foo/simple_header9.h"
#include "simple_header0.h"
#include "simple_header12.h"
#include "simple_header4.h"
#include "simple_header8.h"
__kernel void CompositeKernel(__global float *src, __global float *dst) {
  CopyBuffer0(src, dst);
  CopyBuffer1(src, dst);
  CopyBuffer2(src, dst);
  CopyBuffer3(src, dst);
  CopyBuffer4(src, dst);
  CopyBuffer5(src, dst);
  CopyBuffer6(src, dst);
  CopyBuffer7(src, dst);
  CopyBuffer8(src, dst);
  CopyBuffer9(src, dst);
  CopyBuffer10(src, dst);
  CopyBuffer11(src, dst);
  CopyBuffer12(src, dst);
  CopyBuffer13(src, dst);
  CopyBuffer14(src, dst);
  CopyBuffer15(src, dst);
}
