// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE ulong16
#define PRIV_SIZE 2
__kernel void test_fn(__global ulong16 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ulong16 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 2; i++)
    sPrivateStorage[i] = src[i];

  ulong16 tmp = vload16(offsets[tid], ((__private ulong *)sPrivateStorage) +
                                          alignmentOffsets[tid]);
  results[tid] = tmp;
}
