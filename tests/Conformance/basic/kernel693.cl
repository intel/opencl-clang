// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE short8
#define PRIV_SIZE 16
__kernel void test_fn(__global short8 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global short8 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 16; i++)
    sPrivateStorage[i] = src[i];

  short8 tmp = vload8(offsets[tid], ((__private short *)sPrivateStorage) +
                                        alignmentOffsets[tid]);
  results[tid] = tmp;
}
