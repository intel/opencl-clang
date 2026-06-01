// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void readTest(__global char *inBuffer, __global char *outBuffer) {
  int tid = get_global_id(0);
  outBuffer[tid] = inBuffer[tid];
}
