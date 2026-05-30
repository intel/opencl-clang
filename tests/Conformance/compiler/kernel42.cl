// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
static constant struct bar {
  float x, y, z, r;
  int color;
} foo = {3.14159};
