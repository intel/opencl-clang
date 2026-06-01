// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global int *outputID_A, __global int *outputID_B,
                   __global int *outputID_C) {
  size_t id0 = get_local_id(0) + get_group_id(0) * get_local_size(0);
  size_t id1 = get_local_id(1) + get_group_id(1) * get_local_size(1);
  size_t id2 = get_local_id(2) + get_group_id(2) * get_local_size(2);
  size_t id = (id2 * get_global_size(0) * get_global_size(1)) +
              (id1 * get_global_size(0)) + id0;

  outputID_A[id] = get_global_id(0);
  outputID_B[id] = get_global_id(1);
  outputID_C[id] = get_global_id(2);
}
