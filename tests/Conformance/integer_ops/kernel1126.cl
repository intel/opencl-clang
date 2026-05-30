// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global uint *inOut, __global char *control) {
  size_t tid = get_global_id(0);

  uint8 inOutVal = vload8(tid, inOut);

  if (control[tid] == 0)
    inOutVal++;
  else if (control[tid] == 1)
    ++inOutVal;
  else if (control[tid] == 2)
    inOutVal--;
  else // if( control[tid] == 3 )
    --inOutVal;

  vstore8(inOutVal, tid, inOut);
}
