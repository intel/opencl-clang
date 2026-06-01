// INTEL CONFIDENTIAL
// ***************************************************************************
// Copyright (c) Intel Corporation (2014).
//
// INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE.  THIS CODE
// IS LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY
// SUPPORT, ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES.
// INTEL DOES NOT PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS.
// INTEL SPECIFICALLY DISCLAIMS ANY WARRANTY OF MERCHANTABILITY,
// NONINFRINGEMENT, FITNESS FOR ANY PARTICULAR PURPOSE, OR ANY OTHER
// WARRANTY.  Intel disclaims all liability, including liability for
// infringement of any proprietary rights, relating to use of the
// code. No license, express or implied, by estoppel or otherwise, to
// any intellectual property rights is granted herein.

int main_function_ocl(int argc, char **argv, __global int *ocl_test_results) {
    char4 pos = (char4)(1, 2, 3, 4);
    char4 swiz= pos.wzyx; // swiz = (4, 3, 2, 1)
    char4 dup = pos.xxyy; // dup = (1, 1, 2, 2)

    char3 vf = (char3)(1, 2, 3);
    char2 low = vf.lo; // (1, 2);
    char2 high = vf.hi; // (3, undefined);

    // results validation
    if (!((swiz.x == 4) && (swiz.y == 3) && (swiz.z == 2) && (swiz.w == 1)))
        return -1;

    if (!((dup.x == 1) && (dup.y == 1) && (dup.z == 2) && (dup.w == 2)))
        return -1;

    if (!((low.x == 1) && (low.y == 2)))
        return -1;

    if (!(high.x == 3))
        return -1;

    return 0;
}

__kernel void ocl_test_kernel(__global int *ocl_test_results)
{
  ocl_test_results[0] = 1; //kernel started
  ocl_test_results[3] = main_function_ocl(0,0,ocl_test_results);
  ocl_test_results[0] = 2; //kernel finished
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
// From groups/vector.lst: status: , errorcode: , message: 
