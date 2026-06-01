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

int main_function_ocl(int argc, ulong **argv, __global int *ocl_test_results) {
    ulong16 x;
    ulong4 a = (ulong4)(1, 2, 3, 4);
    ulong4 b = (ulong4)(5, 6, 7, 8);
    ulong4 c = (ulong4)(9, 10, 11, 12);
    ulong4 d = (ulong4)(13, 14, 15, 16);

    x = (ulong16)(a, b, c, d);

    if (!((x.s0 == 1) && (x.s1 == 2) && (x.s2 == 3) && (x.s3 == 4)))
        return -1;
    if (!((x.s4 == 5) && (x.s5 == 6) && (x.s6 == 7) && (x.s7 == 8)))
        return -1;
    if (!((x.s8 == 9) && (x.s9 == 10) && (x.sA == 11) && (x.sB == 12)))
        return -1;
    if (!((x.sC == 13) && (x.sD == 14) && (x.sE == 15) && (x.sF == 16)))
        return -1;

    x = (ulong16)(a.xxxx, b.xyz, c.xyz, d.xyz, a.yzw);

    if (!((x.s0 == 1) && (x.s1 == 1) && (x.s2 == 1) && (x.s3 == 1)))
        return -1;
    if (!((x.s4 == 5) && (x.s5 == 6) && (x.s6 == 7) && (x.s7 == 9)))
        return -1;
    if (!((x.s8 == 10) && (x.s9 == 11) && (x.sA == 13) && (x.sB == 14)))
        return -1;
    if (!((x.sC == 15) && (x.sD == 2) && (x.sE == 3) && (x.sF == 4)))
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
