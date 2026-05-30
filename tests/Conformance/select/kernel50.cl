// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void select_uint3_uint3(__global uint *dest, __global uint *src1,
                                 __global uint *src2, __global uint *cmp) {
  size_t tid = get_global_id(0);
  size_t size = get_global_size(0);
  if (tid + 1 < size) // can't run off the end
    vstore3(select(vload3(tid, src1), vload3(tid, src2), vload3(tid, cmp)), tid,
            dest);
  else if (tid + 1 == size) {
    size_t leftovers = 1 + (size & 1);
    uint3 a, b;
    uint3 c;
    switch (leftovers) {
    case 2:
      a.y = src1[3 * tid + 1];
      b.y = src2[3 * tid + 1];
      c.y = cmp[3 * tid + 1];
    // fall through
    case 1:
      a.x = src1[3 * tid];
      b.x = src2[3 * tid];
      c.x = cmp[3 * tid];
      break;
    }
    a = select(a, b, c);
    switch (leftovers) {
    case 2:
      dest[3 * tid + 1] = a.y;
    // fall through
    case 1:
      dest[3 * tid] = a.x;
      break;
    }
  }
}
