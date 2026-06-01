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
#define Real_t float
//#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100

#ifdef USING_DOUBLE_PRECISIONQ
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
#endif /* USING_DOUBLE_PRECISIONQ */

#define MT_RNG_COUNT 4096
#define MT_MM 9
#define MT_NN 19
#define MT_WMASK 0xFFFFFFFFU
#define MT_UMASK 0xFFFFFFFEU
#define MT_LMASK 0x1U
#define MT_SHIFT0 12
#define MT_SHIFTB 7
#define MT_SHIFTC 15
#define MT_SHIFT1 18

__kernel void MersenneTwister(__global Real_t* d_Rand, __global unsigned mint* ds_matrixa, __global unsigned mint* ds_maskb, __global unsigned mint* ds_maskc, __global unsigned mint* ds_seed, mint nPerRng)
{
	int globalID = get_global_id(0);

	int iState, iState1, iStateM, iOut;
	unsigned int mti, mti1, mtiM, x;
	unsigned int mt[MT_NN], matrix_a, mask_b, mask_c;

	matrix_a = ds_matrixa[globalID];
	mask_b = ds_maskb[globalID];
	mask_c = ds_maskc[globalID];

	mt[0] = ds_seed[globalID];
	for(iState = 1; iState < MT_NN; iState++) {
		mt[iState] = (1812433253U * (mt[iState - 1] ^ (mt[iState - 1] >> 30)) + iState) & MT_WMASK;
	}
	iState = 0;
	mti1 = mt[0];

	iOut = 0;
	for(iOut = 0; iOut<nPerRng; iOut++) {
		iState1 = iState + 1;
		iStateM = iState + MT_MM;
		if(iState1 >= MT_NN) iState1 -= MT_NN;
		if(iStateM >= MT_NN) iStateM -= MT_NN;
		mti = mti1;
		mti1 = mt[iState1];
		mtiM = mt[iStateM];

		x = (mti & MT_UMASK) | (mti1 & MT_LMASK);
		x = mtiM ^ (x >> 1) ^ ((x & 1) ? matrix_a : 0);

		mt[iState] = x;
		iState = iState1;

		x ^= (x >> MT_SHIFT0);
		x ^= (x << MT_SHIFTB) & mask_b;
		x ^= (x << MT_SHIFTC) & mask_c;
		x ^= (x >> MT_SHIFT1);

		d_Rand[globalID + iOut * MT_RNG_COUNT] = ((Real_t)x + 1.0)/4294967296.0;
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
