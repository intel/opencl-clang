// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_upsample(__global ushort *sourceA, __global ushort *sourceB,
                            __global uint *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = upsample(sourceA[tid], sourceB[tid]);
}
