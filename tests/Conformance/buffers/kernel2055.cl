// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
typedef struct {
  int a;
  float b;
} TestStruct;
__kernel void read_write_struct(__global TestStruct *src,
                                __global TestStruct *dst) {
  int tid = get_global_id(0);

  dst[tid].a = src[tid].a;
  dst[tid].b = src[tid].b;
}
