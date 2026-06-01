// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_convert_ushort3_sat_rtz_uint3(__global uint *src,
                                                 __global ushort *dest) {
  size_t i = get_global_id(0);
  if (i + 1 < get_global_size(0))
    vstore3(convert_ushort3_sat_rtz(vload3(i, src)), i, dest);
  else {
    uint3 in;
    ushort3 out;
    if (0 == (i & 1))
      in.y = src[3 * i + 1];
    in.x = src[3 * i];
    out = convert_ushort3_sat_rtz(in);
    dest[3 * i] = out.x;
    if (0 == (i & 1))
      dest[3 * i + 1] = out.y;
  }
}
