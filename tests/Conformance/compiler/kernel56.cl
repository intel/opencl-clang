// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
extern int foo(int, int);
int access_foo() {
  int blah = foo(3, 4);
  return blah + 5;
}
