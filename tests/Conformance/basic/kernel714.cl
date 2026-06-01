// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE long16
#define PRIV_SIZE 2
__kernel void test_fn(__global long16 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global long16 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 2; i++)
    sPrivateStorage[i] = src[i];

  long16 tmp = vload16(offsets[tid], ((__private long *)sPrivateStorage) +
                                         alignmentOffsets[tid]);
  results[tid] = tmp;
}
