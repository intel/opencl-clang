// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
static int foo(int x, int y) { return x * x + y * y; }
