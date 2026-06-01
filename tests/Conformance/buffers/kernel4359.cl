// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void readTest(__global char *inBuffer, char tag) {
  int tid = get_global_id(0);
  inBuffer[tid] |= tag;
}
