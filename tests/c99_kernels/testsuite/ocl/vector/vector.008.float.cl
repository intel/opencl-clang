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
void transpose( float4 m[4] ) {
    // read matrix into a float16 vector
    float16 x = (float16)( m[0], m[1], m[2], m[3] );
    float16 t;
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

int main_function_ocl(int argc, char **argv, __global int *ocl_test_results) {
    float4 a = (float4)(1.0f, 2.0f, 3.0f, 4.0f);
	float4 b = (float4)(5.0f, 6.0f, 7.0f, 8.0f);
    float4 c = (float4)(9.0f, 10.0f, 11.0f, 12.0f);
	float4 d = (float4)(13.0f, 14.0f, 15.0f, 16.0f);
	float4 temp[4] = {a, b, c, d};

	transpose(temp);

    if (!((temp[0][0] == 1.0f) && (temp[0][1] == 5.0f) && (temp[0][2] == 9.0f) && (temp[0][3] == 13.0f)))
        return -1;
    if (!((temp[1][0] == 2.0f) && (temp[1][1] == 6.0f) && (temp[1][2] == 10.0f) && (temp[1][3] == 14.0f)))
        return -1;
    if (!((temp[2][0] == 3.0f) && (temp[2][1] == 7.0f) && (temp[2][2] == 11.0f) && (temp[2][3] == 15.0f)))
        return -1;
    if (!((temp[3][0] == 4.0f) && (temp[3][1] == 8.0f) && (temp[3][2] == 12.0f) && (temp[3][3] == 16.0f)))
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
