// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE char16
#define PRIV_SIZE 16
__kernel void test_fn(__global char16 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global char16 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 16; i++)
    sPrivateStorage[i] = src[i];

  char16 tmp = vload16(offsets[tid], ((__private char *)sPrivateStorage) +
                                         alignmentOffsets[tid]);
  results[tid] = tmp;
}
