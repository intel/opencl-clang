// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void write_up(__global int *dst, int length) {

  dst[get_global_id(0)] *= 2;
}
__kernel void write_down(__global int *dst, int length) {

  dst[get_global_id(0)]--;
}
