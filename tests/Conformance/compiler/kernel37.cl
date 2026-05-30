// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void pragma_test(__global int *dstA) {
#pragma A fool thinks himself to be wise,                                      \
    but a wise man knows himself to be a fool.
  int tid = get_global_id(0);
#pragma
  dstA[tid] = tid;
#pragma mark Though I am not naturally honest, I am so sometimes by chance.
}
