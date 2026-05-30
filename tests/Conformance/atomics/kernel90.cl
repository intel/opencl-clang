// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
// Counter keeps track of which index in counts we are using.
// We get that value, increment it, and then set that index in counts to our
// thread ID. At the end of this we should have all thread IDs in some random
// location in counts exactly once. If atom_add failed then we will write over
// various thread IDs and we will be missing some.

__kernel void add_index_test(__global int *counter, __global int *counts) {
  int tid = get_global_id(0);

  int counter_to_use = atom_add(counter, 1);
  counts[counter_to_use] = tid;
}