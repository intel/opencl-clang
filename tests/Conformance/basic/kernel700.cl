// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE int2
#define PRIV_SIZE 32
__kernel void test_fn(__global int2 *src, __global uint *offsets,
                      __global uint *alignmentOffsets, __global int2 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 32; i++)
    sPrivateStorage[i] = src[i];

  int2 tmp = vload2(offsets[tid],
                    ((__private int *)sPrivateStorage) + alignmentOffsets[tid]);
  results[tid] = tmp;
}
