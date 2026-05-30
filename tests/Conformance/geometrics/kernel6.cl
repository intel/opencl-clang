// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void sample_test(__global float3 *sourceA, __global float3 *sourceB,
                          __global float *destValues) {
  int tid = get_global_id(0);
  destValues[tid] = dot(vload3(tid, (__global float *)sourceA),
                        vload3(tid, (__global float *)sourceB));
}
