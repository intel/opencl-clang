// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void GetILogBConstants(__global int *out) {
  out[0] = FP_ILOGB0;
  out[1] = FP_ILOGBNAN;
}
