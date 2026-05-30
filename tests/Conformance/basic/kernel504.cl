// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void constant_kernel(__global float *out, __constant float *tmpF,
                              __constant int *tmpI) {
  int tid = get_global_id(0);

  float ftmp = tmpF[tid];
  float Itmp = tmpI[tid];
  out[tid] = ftmp * Itmp;
}
