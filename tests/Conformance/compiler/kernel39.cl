// RUN: %occ-cli %s --cl-options=-D__IMAGE_SUPPORT__ --cl-device=%cl_device %cfg_path
kernel void enabled(global int *buf) {
  int n = get_global_id(0);
  buf[n] = 0;
#ifndef __IMAGE_SUPPORT__
  ERROR;
#endif
}
