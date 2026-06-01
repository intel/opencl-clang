// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE uchar
#define PRIV_SIZE 255
__kernel void test_fn(__global uchar *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global uchar *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < PRIV_SIZE; i++) {
    sPrivateStorage[i] = src[i];
  }

  uchar3 tmp = vload3(offsets[tid], (sPrivateStorage) + alignmentOffsets[tid]);
  results[3 * tid] = tmp.s0;
  results[3 * tid + 1] = tmp.s1;
  results[3 * tid + 2] = tmp.s2;
}
