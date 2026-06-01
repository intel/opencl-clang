// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_upsample(__global int *sourceA, __global uint *sourceB,
                            __global long *destValues) {
  int tid = get_global_id(0);
  vstore3(upsample(vload3(tid, sourceA), vload3(tid, sourceB)), tid,
          destValues);
}
