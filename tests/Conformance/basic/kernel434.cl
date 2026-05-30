// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_if(__global int *src, __global int *dst) {
  int tid = get_global_id(0);

  if (src[tid] == 0)
    dst[tid] = 0x12345678;
  else if (src[tid] == 1)
    dst[tid] = 0x23456781;
  else if (src[tid] == 2)
    dst[tid] = 0x34567812;
  else if (src[tid] == 3)
    dst[tid] = 0x45678123;
  else if (src[tid] == 4)
    dst[tid] = 0x56781234;
  else if (src[tid] == 5)
    dst[tid] = 0x67812345;
  else if (src[tid] == 6)
    dst[tid] = 0x78123456;
  else if (src[tid] == 7)
    dst[tid] = 0x81234567;
  else
    dst[tid] = 0x7FFFFFFF;
}
