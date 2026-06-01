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

int main_function_ocl(int argc, int **argv, __global int *ocl_test_results) {
    int4 a;
    int4 f = (int4)(INT_MAX, 2, INT_MIN, 4);

    a.xyzw = f.s0123;
    if (!((a.s0 == INT_MAX) && (a.s1 == 2) && (a.s2 == INT_MIN) && (a.s3 == 4)))
        return -1;

    a.xyzw = f.s3021;
    if (!((a.s0 == 4) && (a.s1 == INT_MAX) && (a.s2 == INT_MIN) && (a.s3 == 2)))
        return -1;

    a.wyzx = f.s1231;
    if (!((a.s0 == 2) && (a.s1 == INT_MIN) && (a.s2 == 4) && (a.s3 == 2)))
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
