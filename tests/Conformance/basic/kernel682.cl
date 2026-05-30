// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE char4
#define PRIV_SIZE 64
__kernel void test_fn(__global char4 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global char4 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 64; i++)
    sPrivateStorage[i] = src[i];

  char4 tmp = vload4(offsets[tid], ((__private char *)sPrivateStorage) +
                                       alignmentOffsets[tid]);
  results[tid] = tmp;
}
