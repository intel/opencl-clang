// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float3 *sourceA,
                          __global float3 *destValues) {
  int tid = get_global_id(0);
  vstore3(normalize(vload3(tid, (__global float *)sourceA)), tid,
          (__global float *)destValues);
}
