/*
 * Copyright 1993-2009 NVIDIA Corporation.  All rights reserved.
 *
 * NVIDIA Corporation and its licensors retain all intellectual property and
 * proprietary rights in and to this software and related documentation.
 * Any use, reproduction, disclosure, or distribution of this software
 * and related documentation without an express license agreement from
 * NVIDIA Corporation is strictly prohibited.
 *
 * Please refer to the applicable NVIDIA end user license agreement (EULA)
 * associated with this source code for terms and conditions that govern
 * your use of this NVIDIA software.
 *
 */

#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint long
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100

#define QRNG_DIMENSIONS 3
#define QRNG_RESOLUTION 31
#define INT_SCALE (1.0f / (float)0x80000001U)

////////////////////////////////////////////////////////////////////////////////
// Niederreiter quasirandom number generation kernel
////////////////////////////////////////////////////////////////////////////////
__kernel void QuasirandomGenerator(__global float *d_Output,
                                   __constant unsigned mint *c_Table,
				                   unsigned mint seed,
				                   unsigned mint N)
{
    unsigned int globalID_x   = get_global_id(0);
    unsigned int localID_y    = get_local_id(1);
    unsigned int globalSize_x = get_global_size(0);

    for (unsigned int pos = globalID_x; pos < N; pos += globalSize_x) {
        unsigned int result = 0;
        unsigned int data = seed + pos;

        for(int bit = 0; bit < QRNG_RESOLUTION; bit++, data >>= 1)
            if(data & 1) result ^= c_Table[bit+localID_y*QRNG_RESOLUTION];

        d_Output[mul24(localID_y,N) + pos] = (float)(result + 1) * INT_SCALE;
    }
}

////////////////////////////////////////////////////////////////////////////////
// Moro's Inverse Cumulative Normal Distribution function approximation
////////////////////////////////////////////////////////////////////////////////
float MoroInvCNDgpu(float P){
    const float a1 = 2.50662823884f;
    const float a2 = -18.61500062529f;
    const float a3 = 41.39119773534f;
    const float a4 = -25.44106049637f;
    const float b1 = -8.4735109309f;
    const float b2 = 23.08336743743f;
    const float b3 = -21.06224101826f;
    const float b4 = 3.13082909833f;
    const float c1 = 0.337475482272615f;
    const float c2 = 0.976169019091719f;
    const float c3 = 0.160797971491821f;
    const float c4 = 2.76438810333863E-02f;
    const float c5 = 3.8405729373609E-03f;
    const float c6 = 3.951896511919E-04f;
    const float c7 = 3.21767881768E-05f;
    const float c8 = 2.888167364E-07f;
    const float c9 = 3.960315187E-07f;
    float y, z;

    if(P <= 0 || P >= 1.0f)
        return (float)0x7FFFFFFF;

    y = P - 0.5f;
    if(fabs(y) < 0.42f){
        z = y * y;
        z = y * (((a4 * z + a3) * z + a2) * z + a1) / ((((b4 * z + b3) * z + b2) * z + b1) * z + 1.0f);
    } else {
        if(y > 0)
            z = log(-log(1.0f - P));
        else
            z = log(-log(P));

        z = c1 + z * (c2 + z * (c3 + z * (c4 + z * (c5 + z * (c6 + z * (c7 + z * (c8 + z * c9)))))));
        if(y < 0) z = -z;
    }

    return z;
}

__kernel void InverseCND(__global float *d_Output,
	                     unsigned mint pathN,
                         unsigned mint iDevice,
                         unsigned mint nDevice)
{
    float q = 1.0f / (float)(pathN*nDevice + 1);
    unsigned int globalID   = get_global_id(0);
    unsigned int globalSize = get_global_size(0);

    for(unsigned int pos = globalID; pos < pathN; pos += globalSize){
        float d = (float)(iDevice*pathN + pos + 1) * q;
        d_Output[pos] = MoroInvCNDgpu(d);
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
