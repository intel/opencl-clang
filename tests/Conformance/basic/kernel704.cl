// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE int16
#define PRIV_SIZE 4
__kernel void test_fn(__global int16 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global int16 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 4; i++)
    sPrivateStorage[i] = src[i];

  int16 tmp = vload16(offsets[tid], ((__private int *)sPrivateStorage) +
                                        alignmentOffsets[tid]);
  results[tid] = tmp;
}
