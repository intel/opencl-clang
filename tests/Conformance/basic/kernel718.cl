// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE ulong8
#define PRIV_SIZE 4
__kernel void test_fn(__global ulong8 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ulong8 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 4; i++)
    sPrivateStorage[i] = src[i];

  ulong8 tmp = vload8(offsets[tid], ((__private ulong *)sPrivateStorage) +
                                        alignmentOffsets[tid]);
  results[tid] = tmp;
}
