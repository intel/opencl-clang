// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
typedef struct {
  int a;
  float b;
} TestStruct;
__kernel void test_buffer_read_struct(__global TestStruct *dst) {
  int tid = get_global_id(0);

  dst[tid].a = ((1 << 16) + 1);
  dst[tid].b = (float)3.40282346638528860e+38;
}
