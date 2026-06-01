// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_upsample(__global ushort4 *sourceA,
                            __global ushort4 *sourceB,
                            __global uint4 *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = upsample(sourceA[tid], sourceB[tid]);
}
