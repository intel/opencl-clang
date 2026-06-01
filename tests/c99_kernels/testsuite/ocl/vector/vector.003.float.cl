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
    float16 x;
    float4 a = (float4)(1.0f, 2.0f, 3.0f, 4.0f);
    float4 b = (float4)(5.0f, 6.0f, 7.0f, 8.0f);
    float4 c = (float4)(9.0f, 10.0f, 11.0f, 12.0f);
    float4 d = (float4)(13.0f, 14.0f, 15.0f, 16.0f);

    x = (float16)(a, b, c, d);

    if (!((x.s0 == 1.0f) && (x.s1 == 2.0f) && (x.s2 == 3.0f) && (x.s3 == 4.0f)))
        return -1;
    if (!((x.s4 == 5.0f) && (x.s5 == 6.0f) && (x.s6 == 7.0f) && (x.s7 == 8.0f)))
        return -1;
    if (!((x.s8 == 9.0f) && (x.s9 == 10.0f) && (x.sA == 11.0f) && (x.sB == 12.0f)))
        return -1;
    if (!((x.sC == 13.0f) && (x.sD == 14.0f) && (x.sE == 15.0f) && (x.sF == 16.0f)))
        return -1;

    x = (float16)(a.xxxx, b.xyz, c.xyz, d.xyz, a.yzw);

    if (!((x.s0 == 1.0f) && (x.s1 == 1.0f) && (x.s2 == 1.0f) && (x.s3 == 1.0f)))
        return -1;
    if (!((x.s4 == 5.0f) && (x.s5 == 6.0f) && (x.s6 == 7.0f) && (x.s7 == 9.0f)))
        return -1;
    if (!((x.s8 == 10.0f) && (x.s9 == 11.0f) && (x.sA == 13.0f) && (x.sB == 14.0f)))
        return -1;
    if (!((x.sC == 15.0f) && (x.sD == 2.0f) && (x.sE == 3.0f) && (x.sF == 4.0f)))
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
