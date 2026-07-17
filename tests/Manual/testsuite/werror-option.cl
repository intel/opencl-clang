// RUN: %occ-cli %s --cl-options=-Werror %cfg_path --cl-device=%cl_device --output=%t.bc
// XFAIL: *

struct Node;
typedef struct {
  __global struct Node *pNext;
} Node;

__kernel void test(__global Node *pNodes) {
  __global Node *pNew;
  pNodes->pNext = pNew;
}
