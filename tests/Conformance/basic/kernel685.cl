// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#define PRIV_TYPE uchar2
#define PRIV_SIZE 128
__kernel void test_fn(__global uchar2 *src, __global uint *offsets,
                      __global uint *alignmentOffsets,
                      __global uchar2 *results) {
  __private PRIV_TYPE sPrivateStorage[PRIV_SIZE];
  int tid = get_global_id(0);

  for (int i = 0; i < 128; i++)
    sPrivateStorage[i] = src[i];

  uchar2 tmp = vload2(offsets[tid], ((__private uchar *)sPrivateStorage) +
                                        alignmentOffsets[tid]);
  results[tid] = tmp;
}
