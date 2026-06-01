// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_upsample(__global uchar16 *sourceA,
                            __global uchar16 *sourceB,
                            __global ushort16 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = upsample(sourceA[tid], sourceB[tid]);
}
