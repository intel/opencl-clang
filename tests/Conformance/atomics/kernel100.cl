// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
// This test assigns a bunch of values to bins and then tries to put them in the
// bins in parallel using an atomic add to keep track of the current location to
// write into in each bin. This is the same as the memory update for the
// particles demo.

__kernel void add_index_bin_test(__global int *bin_counters, __global int *bins,
                                 __global int *bin_assignments,
                                 int max_counts_per_bin) {
  int tid = get_global_id(0);

  int location = bin_assignments[tid];
  int counter = atom_add(&bin_counters[location], 1);
  bins[location * max_counts_per_bin + counter] = tid;
}