// RUN: not %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void line_error_test(__global int *dstA) {
  int tid = get_global_id(0);
#line 124 "fictitious/file/name.c"
#error some error
  dstA[tid] = tid;
}
