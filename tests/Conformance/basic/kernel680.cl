// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE char2
#define PRIV_SIZE 128
__kernel void test_fn(__global char2 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global char2 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 128; i++)
    sPrivateStorage[i] = src[i];

  char2 tmp = vload2(offsets[tid], ((__private char *)sPrivateStorage) +
                                       alignmentOffsets[tid]);
  results[tid] = tmp;
}
