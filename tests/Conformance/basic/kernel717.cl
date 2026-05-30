// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE ulong4
#define PRIV_SIZE 8
__kernel void test_fn(__global ulong4 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ulong4 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 8; i++)
    sPrivateStorage[i] = src[i];

  ulong4 tmp = vload4(offsets[tid], ((__private ulong *)sPrivateStorage) +
                                        alignmentOffsets[tid]);
  results[tid] = tmp;
}
