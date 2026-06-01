// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path

__kernel void sample_test(__global float3 *sourceA, __global float3 *sourceB,
                          __global float3 *sourceC,
                          __global float3 *destValues) {
  int tid = get_global_id(0);
  float3 tmp = bitselect(vload3(tid, (__global float *)sourceA),
                         vload3(tid, (__global float *)sourceB),
                         vload3(tid, (__global float *)sourceC));
  vstore3(tmp, tid, (__global float *)destValues);
}
