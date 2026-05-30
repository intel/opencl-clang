// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global uint *inOut, __global char *control) {
  size_t tid = get_global_id(0);

  uint16 inOutVal = vload16(tid, inOut);

  if (control[tid] == 0)
    inOutVal++;
  else if (control[tid] == 1)
    ++inOutVal;
  else if (control[tid] == 2)
    inOutVal--;
  else // if( control[tid] == 3 )
    --inOutVal;

  vstore16(inOutVal, tid, inOut);
}
