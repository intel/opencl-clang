// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
extern constant float foo;
float access_foo() { return foo; }
