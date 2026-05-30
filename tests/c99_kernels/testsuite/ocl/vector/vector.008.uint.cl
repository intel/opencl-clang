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

// transpose a 4x4 matrix
void transpose( uint4 m[4] ) {
    // read matrix into a uint16 vector
    uint16 x = (uint16)( m[0], m[1], m[2], m[3] );
    uint16 t;
    //transpose
    t.even = x.lo;
    t.odd = x.hi;
    x.even = t.lo;
    x.odd = t.hi;
    //write back
    m[0] = x.lo.lo; // { m[0][0], m[1][0], m[2][0], m[3][0] }
    m[1] = x.lo.hi; // { m[0][1], m[1][1], m[2][1], m[3][1] }
    m[2] = x.hi.lo; // { m[0][2], m[1][2], m[2][2], m[3][2] }
    m[3] = x.hi.hi; // { m[0][3], m[1][3], m[2][3], m[3][3] }
}

int main_function_ocl(int argc, uint **argv, __global int *ocl_test_results) {
    uint4 a = (uint4)(1, 2, 3, 4);
	uint4 b = (uint4)(5, 6, 7, 8);
    uint4 c = (uint4)(9, 10, 11, 12);
	uint4 d = (uint4)(13, 14, 15, 16);
	uint4 temp[4] = {a, b, c, d};

	transpose(temp);

    if (!((temp[0][0] == 1) && (temp[0][1] == 5) && (temp[0][2] == 9) && (temp[0][3] == 13)))
        return -1;
    if (!((temp[1][0] == 2) && (temp[1][1] == 6) && (temp[1][2] == 10) && (temp[1][3] == 14)))
        return -1;
    if (!((temp[2][0] == 3) && (temp[2][1] == 7) && (temp[2][2] == 11) && (temp[2][3] == 15)))
        return -1;
    if (!((temp[3][0] == 4) && (temp[3][1] == 8) && (temp[3][2] == 12) && (temp[3][3] == 16)))
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
