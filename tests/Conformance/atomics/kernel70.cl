// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_global_int32_extended_atomics : enable
__kernel void test_atomic_fn(volatile __global int *destMemory,
                             __global int *oldValues) {
  int tid = get_global_id(0);

  size_t numBits = sizeof(destMemory[0]) * 8;
  int whichResult = tid / numBits;
  int bitIndex = tid - (whichResult * numBits);

  oldValues[tid] = atomic_and(&destMemory[whichResult], ~(1L << bitIndex));
}
