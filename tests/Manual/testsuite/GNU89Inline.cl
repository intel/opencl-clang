// RUN: %occ-cli %s %cfg_path --cl-device=%cl_device --output=%t.bc
// RUN: llvm-dis %t.bc -o - | FileCheck %s

// CHECK: define dso_local spir_func void @a

inline void a() { return; }

void b() { a(); }
