// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global unsigned int *input,
                   __global unsigned int *outMaxes) {
  __local unsigned int localStorage[256];
  unsigned int theValue = input[get_global_id(0)];

  // If we just write linearly, there's no verification that the items in a
  // group share local data So we write reverse-linearly, which requires items
  // to read the local data written by at least one different item
  localStorage[get_local_size(0) - get_local_id(0) - 1] = theValue;

  // The barrier ensures that all local items have written to the local storage
  barrier(CLK_LOCAL_MEM_FENCE);

  // Now we loop back through the local storage and look for the max value. We
  // only do this if we're the first item in a group
  unsigned int max = 0;
  if (get_local_id(0) == 0) {
    for (size_t i = 0; i < get_local_size(0); i++) {
      if (localStorage[i] > max)
        max = localStorage[i];
    }
    outMaxes[get_group_id(0)] = max;
  }
}
