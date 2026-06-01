// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
__kernel void test_convert_int3_sat_rtz_double3(__global double *src,
                                                __global int *dest) {
  size_t i = get_global_id(0);
  if (i + 1 < get_global_size(0))
    vstore3(convert_int3_sat_rtz(vload3(i, src)), i, dest);
  else {
    double3 in;
    int3 out;
    if (0 == (i & 1))
      in.y = src[3 * i + 1];
    in.x = src[3 * i];
    out = convert_int3_sat_rtz(in);
    dest[3 * i] = out.x;
    if (0 == (i & 1))
      dest[3 * i + 1] = out.y;
  }
}
