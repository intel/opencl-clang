// RUN: %occ-cli %s --cl-options="-DTYPE=int -DSTRING=\"%d\\n\"" --cl-device=%cl_device %cfg_path --output=%t.bc
// RUN: llvm-dis < %t.bc | FileCheck %s

// Regression test: quoted_tokenize() must not drop a backslash that
// does not escape a quote, itself, or a delimiter. A macro value such
// as "%d\n" was previously tokenized to "%dn", losing the newline.

// CHECK: @.str = {{.*}}constant {{.*}} c"%d\0A\00"

#define AS_STRING(s) AS_STRING_(s)
#define AS_STRING_(s) #s

kernel void test_printf_arguments(global const TYPE *input) {
  const int gid = get_global_id(0);
  TYPE i = input[gid];
  printf(AS_STRING(STRING), i);
}
