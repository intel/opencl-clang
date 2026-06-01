// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE ushort4
#define PRIV_SIZE 32
__kernel void test_fn(__global ushort4 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global ushort4 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 32; i++)
    sPrivateStorage[i] = src[i];

  ushort4 tmp = vload4(offsets[tid], ((__private ushort *)sPrivateStorage) +
                                         alignmentOffsets[tid]);
  results[tid] = tmp;
}
