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

int main_function_ocl(int argc, ushort **argv, __global int *ocl_test_results) {
    ushort4 pos = (ushort4)(1, 2, 3, 4);
    pos.xw = (ushort2)(5, 6);// pos = (5, 2, 3, 6)
    if (!((pos.x == 5) && (pos.y == 2) && (pos.z == 3) && (pos.w == 6)))
        return -1;

    pos.wx = (ushort2)(7, 8);// pos = (8, 2, 3, 7)
    if (!((pos.x == 8) && (pos.y == 2) && (pos.z == 3) && (pos.w == 7)))
        return -1;

    pos.xyz = (ushort3)(3, 5, 9); // pos = (3, 5, 9, 7)
    if (!((pos.x == 3) && (pos.y == 5) && (pos.z == 9) && (pos.w == 7)))
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
