// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test(__global ulong *inOut, __global char *control) {
  size_t tid = get_global_id(0);

  ulong3 inOutVal = vload3(tid, inOut);

  if (control[tid] == 0)
    inOutVal++;
  else if (control[tid] == 1)
    ++inOutVal;
  else if (control[tid] == 2)
    inOutVal--;
  else // if( control[tid] == 3 )
    --inOutVal;

  vstore3(inOutVal, tid, inOut);
}
