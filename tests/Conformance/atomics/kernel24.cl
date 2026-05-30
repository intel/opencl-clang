// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
__kernel void test_atomic_fn(volatile __global float *destMemory,
                             __global float *oldValues) {
  int tid = get_global_id(0);

  oldValues[tid] = atomic_xchg(&destMemory[0], tid);
}
