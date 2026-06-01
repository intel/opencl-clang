// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test_smoothstep3(__global float *edge0, __global float *edge1,
                               __global float *x, __global float *dst) {
  int tid = get_global_id(0);

  vstore3(smoothstep(vload3(tid, edge0), vload3(tid, edge1), vload3(tid, x)),
          tid, dst);
}
