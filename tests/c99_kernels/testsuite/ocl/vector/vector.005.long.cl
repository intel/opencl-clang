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

int main_function_ocl(int argc, long **argv, __global int *ocl_test_results) {
    long4 vf = (long4)(1, 2, 3, 4);
    long2 low = vf.lo; // returns vf.xy
    long2 high = vf.hi; // returns vf.zw
    long2 even = vf.even; // returns vf.xz
    long2 odd = vf.odd; // returns vf.yw

    if (!((low.s0 == 1) && (low.s1 == 2)))
        return -1;
    if (!((high.s0 == 3) && (high.s1 == 4)))
        return -1;
    if (!((even.s0 == 1) && (even.s1 == 3)))
        return -1;
    if (!((odd.s0 == 2) && (odd.s1 == 4)))
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
