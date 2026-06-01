// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_conversion(__global uchar *sourceValues,
                              __global uchar8 *destValues) {
  int tid = get_global_id(0);
  uchar src = sourceValues[tid];

  destValues[tid] = (uchar8)src;
}
