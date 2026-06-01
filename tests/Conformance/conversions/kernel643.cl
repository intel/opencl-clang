// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_char3_sat_uchar3(__global uchar *src,
                                            __global char *dest) {
  size_t i = get_global_id(0);
  if (i + 1 < get_global_size(0))
    vstore3(convert_char3_sat(vload3(i, src)), i, dest);
  else {
    uchar3 in;
    char3 out;
    if (0 == (i & 1))
      in.y = src[3 * i + 1];
    in.x = src[3 * i];
    out = convert_char3_sat(in);
    dest[3 * i] = out.x;
    if (0 == (i & 1))
      dest[3 * i + 1] = out.y;
  }
}
