// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE short2
#define PRIV_SIZE 64
__kernel void test_fn(__global short2 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global short2 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 64; i++)
    sPrivateStorage[i] = src[i];

  short2 tmp = vload2(offsets[tid], ((__private short *)sPrivateStorage) +
                                        alignmentOffsets[tid]);
  results[tid] = tmp;
}
