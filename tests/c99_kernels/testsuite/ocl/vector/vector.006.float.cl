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
    float8 vf = (float8)(1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f, 8.0f);
    float4 odd = vf.odd;
    float4 even = vf.even;
    float2 high = vf.even.hi;
    float2 low = vf.odd.lo;

    if (!((high.s0 == 5.0f) && (high.s1 == 7.0f)))
        return -1;
    if (!((low.s0 == 2.0f) && (low.s1 == 4.0f)))
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
