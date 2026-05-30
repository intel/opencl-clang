// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
extern constant struct bar {
  float x, y, z, r;
  int color;
} foo;
struct bar access_foo() { return foo; }
