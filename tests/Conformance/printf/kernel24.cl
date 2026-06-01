// RUN: %occ-cli %s --cl-options= --cl-device=%cl_device %cfg_path
__kernel void test1(void) { printf("%+#21.15E\n", 789456123.0); }
