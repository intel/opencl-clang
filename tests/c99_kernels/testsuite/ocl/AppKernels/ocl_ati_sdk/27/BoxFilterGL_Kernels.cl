/* ============================================================

Copyright (c) 2009-2010 Advanced Micro Devices, Inc.  All rights reserved.

Redistribution and use of this material is permitted under the following
conditions:

Redistributions must retain the above copyright notice and all terms of this
license.

In no event shall anyone redistributing or accessing or using this material
commence or participate in any arbitration or legal action relating to this
material against Advanced Micro Devices, Inc. or any copyright holders or
contributors. The foregoing shall survive any expiration or termination of
this license or any agreement or access or use related to this material.

ANY BREACH OF ANY TERM OF THIS LICENSE SHALL RESULT IN THE IMMEDIATE REVOCATION
OF ALL RIGHTS TO REDISTRIBUTE, ACCESS OR USE THIS MATERIAL.

THIS MATERIAL IS PROVIDED BY ADVANCED MICRO DEVICES, INC. AND ANY COPYRIGHT
HOLDERS AND CONTRIBUTORS "AS IS" IN ITS CURRENT CONDITION AND WITHOUT ANY
REPRESENTATIONS, GUARANTEE, OR WARRANTY OF ANY KIND OR IN ANY WAY RELATED TO
SUPPORT, INDEMNITY, ERROR FREE OR UNINTERRUPTED OPERA TION, OR THAT IT IS FREE
FROM DEFECTS OR VIRUSES.  ALL OBLIGATIONS ARE HEREBY DISCLAIMED - WHETHER
EXPRESS, IMPLIED, OR STATUTORY - INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED
WARRANTIES OF TITLE, MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
ACCURACY, COMPLETENESS, OPERABILITY, QUALITY OF SERVICE, OR NON-INFRINGEMENT.
IN NO EVENT SHALL ADVANCED MICRO DEVICES, INC. OR ANY COPYRIGHT HOLDERS OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, PUNITIVE,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, REVENUE, DATA, OR PROFITS; OR
BUSINESS INTERRUPTION) HOWEVER CAUSED OR BASED ON ANY THEORY OF LIABILITY
ARISING IN ANY WAY RELATED TO THIS MATERIAL, EVEN IF ADVISED OF THE POSSIBILITY
OF SUCH DAMAGE. THE ENTIRE AND AGGREGATE LIABILITY OF ADVANCED MICRO DEVICES,
INC. AND ANY COPYRIGHT HOLDERS AND CONTRIBUTORS SHALL NOT EXCEED TEN DOLLARS
(US $10.00). ANYONE REDISTRIBUTING OR ACCESSING OR USING THIS MATERIAL ACCEPTS
THIS ALLOCATION OF RISK AND AGREES TO RELEASE ADVANCED MICRO DEVICES, INC. AND
ANY COPYRIGHT HOLDERS AND CONTRIBUTORS FROM ANY AND ALL LIABILITIES,
OBLIGATIONS, CLAIMS, OR DEMANDS IN EXCESS OF TEN DOLLARS (US $10.00). THE
FOREGOING ARE ESSENTIAL TERMS OF THIS LICENSE AND, IF ANY OF THESE TERMS ARE
CONSTRUED AS UNENFORCEABLE, FAIL IN ESSENTIAL PURPOSE, OR BECOME VOID OR
DETRIMENTAL TO ADVANCED MICRO DEVICES, INC. OR ANY COPYRIGHT HOLDERS OR
CONTRIBUTORS FOR ANY REASON, THEN ALL RIGHTS TO REDISTRIBUTE, ACCESS OR USE
THIS MATERIAL SHALL TERMINATE IMMEDIATELY. MOREOVER, THE FOREGOING SHALL
SURVIVE ANY EXPIRATION OR TERMINATION OF THIS LICENSE OR ANY AGREEMENT OR
ACCESS OR USE RELATED TO THIS MATERIAL.

NOTICE IS HEREBY PROVIDED, AND BY REDISTRIBUTING OR ACCESSING OR USING THIS
MATERIAL SUCH NOTICE IS ACKNOWLEDGED, THAT THIS MATERIAL MAY BE SUBJECT TO
RESTRICTIONS UNDER THE LAWS AND REGULATIONS OF THE UNITED STATES OR OTHER
COUNTRIES, WHICH INCLUDE BUT ARE NOT LIMITED TO, U.S. EXPORT CONTROL LAWS SUCH
AS THE EXPORT ADMINISTRATION REGULATIONS AND NATIONAL SECURITY CONTROLS AS
DEFINED THEREUNDER, AS WELL AS STATE DEPARTMENT CONTROLS UNDER THE U.S.
MUNITIONS LIST. THIS MATERIAL MAY NOT BE USED, RELEASED, TRANSFERRED, IMPORTED,
EXPORTED AND/OR RE-EXPORTED IN ANY MANNER PROHIBITED UNDER ANY APPLICABLE LAWS,
INCLUDING U.S. EXPORT CONTROL LAWS REGARDING SPECIFICALLY DESIGNATED PERSONS,
COUNTRIES AND NATIONALS OF COUNTRIES SUBJECT TO NATIONAL SECURITY CONTROLS.
MOREOVER, THE FOREGOING SHALL SURVIVE ANY EXPIRATION OR TERMINATION OF ANY
LICENSE OR AGREEMENT OR ACCESS OR USE RELATED TO THIS MATERIAL.

NOTICE REGARDING THE U.S. GOVERNMENT AND DOD AGENCIES: This material is
provided with "RESTRICTED RIGHTS" and/or "LIMITED RIGHTS" as applicable to
computer software and technical data, respectively. Use, duplication,
distribution or disclosure by the U.S. Government and/or DOD agencies is
subject to the full extent of restrictions in all applicable regulations,
including those found at FAR52.227 and DFARS252.227 et seq. and any successor
regulations thereof. Use of this material by the U.S. Government and/or DOD
agencies is acknowledgment of the proprietary rights of any copyright holders
and contributors, including those of Advanced Micro Devices, Inc., as well as
the provisions of FAR52.227-14 through 23 regarding privately developed and/or
commercial computer software.

This license forms the entire agreement regarding the subject matter hereof and
supersedes all proposals and prior discussions and writings between the parties
with respect thereto. This license does not affect any ownership, rights, title,
or interest in, or relating to, this material. No terms of this license can be
modified or waived, and no breach of this license can be excused, unless done
so in a writing signed by all affected parties. Each term of this license is
separately enforceable. If any term of this license is determined to be or
becomes unenforceable or illegal, such term shall be reformed to the minimum
extent necessary in order for this license to remain in effect in accordance
with its terms as modified by such reformation. This license shall be governed
by and construed in accordance with the laws of the State of Texas without
regard to rules on conflicts of law of any state or jurisdiction or the United
Nations Convention on the International Sale of Goods. All disputes arising out
of this license shall be subject to the jurisdiction of the federal and state
courts in Austin, Texas, and all defenses are hereby waived concerning personal
jurisdiction and venue of these courts.

============================================================ */

/**********************************************************
*         BoxFilter SAT kernels
***********************************************************/


/*
 * HorizontalSAT0 - For first horizontal pass for SAT computation
 *                - input : 8 bpp image
 *	          - output : 32 bpp data
 * HorizontalSAT - For rest of the horizontal passes
 * VerticalSAT - All the vertical SAT passes
 * BoxFilter - Reads 4 values from SAT for each pixel and computes average value of the pixel
 */


__kernel void box_filter(__global uint4* inputImage, __global uchar4* outputImage, int N)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int width = get_global_size(0);
	int height = get_global_size(1);
	int k = (N - 1) / 2;

	if(x < k || y < k || x > width - k - 1 || y > height - k - 1)
	{
		outputImage[x + y * width] = (uchar4)(0);
		return;
	}

	/* N should be an odd number */
	int4 filterSize = (int4)(N * N);

	int2 posA = (int2)(x - k, y - k);
	int2 posB = (int2)(x + k, y - k);
	int2 posC = (int2)(x + k, y + k);
	int2 posD = (int2)(x - k, y + k);

	int4 sumA = (int4)(0);
	int4 sumB = (int4)(0);
	int4 sumC = (int4)(0);
	int4 sumD = (int4)(0);

	/* Shift coordinates to get corresponding values from SAT */
	posA.x -= 1;
	posA.y -= 1;
	posB.y -= 1;
	posD.x -= 1;

	if(posA.x >= 0 && posA.y >= 0)
	{
		sumA = convert_int4(inputImage[posA.x + posA.y * width]);
	}
	if(posB.x >= 0 && posB.y >= 0)
	{
		sumB = convert_int4(inputImage[posB.x + posB.y * width]);
	}
	if(posD.x >= 0 && posD.y >= 0)
	{
		sumD = convert_int4(inputImage[posD.x + posD.y * width]);
	}
	sumC = convert_int4(inputImage[posC.x + posC.y * width]);

	outputImage[x + y * width] = convert_uchar4((sumA + sumC - sumB - sumD) / filterSize);

}

__kernel void horizontalSAT0(__global uchar4* input,
							 __global uint4* output,
							 int i, int r, int width)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int pos = x + y * width;

	//Do a copy from input to output buffer
	//output[x + y * width] = convert_uint4(input[x + y * width]);
	//barrier(CLK_GLOBAL_MEM_FENCE);

	int c = pow((float)r, (float)i);

	uint4 sum = 0;

	for(int j = 0; j < r; j++)
	{
		if((x - (j * c)) < 0)
		{
			output[pos] = sum;
			return;
		}

		sum += convert_uint4(input[pos - (j * c)]);
	}

	output[pos] = sum;
}

__kernel void horizontalSAT(__global uint4* input,
						    __global uint4* output,
							int i, int r, int width)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int pos = x + y * width;

	int c = pow((float)r, (float)i);

	uint4 sum = 0;

	for(int j = 0; j < r; j++)
	{
		if(x - (j * c) < 0)
		{
			output[pos] = sum;
			return;
		}
		sum += input[pos - (j * c)];
	}

	output[pos] = sum;
}


__kernel void verticalSAT(__global uint4* input,
			              __global uint4* output,
			              int i, int r, int width)
{
	int x = get_global_id(0);
	int y = get_global_id(1);

	int c = pow((float)r, (float)i);

	uint4 sum = (uint4)(0);

	for(int j = 0; j < r; j++)
	{
		if(y - (j * c) < 0)
		{
			output[x + y * width] = sum;
			return;
		}

		sum += input[x + width * (y - (j * c))];
	}

	output[x + y * width] = sum;
}


/**********************************************************
*         BoxFilter Separable kernels
***********************************************************/

#define GROUP_SIZE 256

__kernel void box_filter_horizontal(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth)
{
	int x = get_global_id(0);
    int y = get_global_id(1);

	int width = get_global_size(0);
	int height = get_global_size(1);

	int pos = x + y * width;
	int k = (filterWidth - 1)/2;

	/* Discard pixels in apron */
	if(x < k || x >= (width - k))
	{
		outputImage[pos] = (uchar4)(0);
		return;
	}

	int4 size = (int4)(filterWidth);

	int4 sum = 0;
	/* Read values from (filterWidth x filterWidth) sized kernel */
	for(int X = -k; X < k; X=X+2)
	{
		sum += convert_int4(inputImage[pos + X]);
		sum += convert_int4(inputImage[pos + X + 1]);
	}
	sum += convert_int4(inputImage[pos + k]);
	outputImage[pos] = convert_uchar4(sum / size);
}


__kernel void box_filter_vertical(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth)
{
	int x = get_global_id(0);
    	int y = get_global_id(1);

	int width = get_global_size(0);
	int height = get_global_size(1);

	int pos = x + y * width;
	int k = (filterWidth - 1)/2;

	/* Discard pixels in apron */
	if(y < k || y >= (height - k))
	{
		outputImage[pos] = (uchar4)(0);
		return;
	}

	int4 size = (int4)(filterWidth);

	int4 sum = 0;
	/* Read values from (filterWidth x filterWidth) sized kernel */
	for(int Y = -k; Y < k; Y=Y+2)
	{
		sum += convert_int4(inputImage[pos + Y * width]);
		sum += convert_int4(inputImage[pos + (Y + 1) * width]);
	}
	sum += convert_int4(inputImage[pos + k * width]);
	outputImage[pos] = convert_uchar4(sum / size);
}

/* This kernel uses local memory for calculation of horizontal filter */
__kernel void box_filter_horizontal_local(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth, __local uchar4 *lds)
{
	int x = get_global_id(0);
    	int y = get_global_id(1);

	int width = get_global_size(0);
	int height = get_global_size(1);

	int pos = x + y * width;
	int k = (filterWidth - 1)/2;


	int lid = get_local_id(0);
	int gidX = get_group_id(0);
	int gidY = get_group_id(1);

	int gSizeX = get_local_size(0);
	int gSizeY = get_local_size(1);

	int firstElement = gSizeX * gidX + width * gidY * gSizeY;

	/* Load first k and last k into shared memory */
	if(lid < k)
	{
		lds[lid] = inputImage[firstElement - k + lid];
		lds[GROUP_SIZE + k + lid] = inputImage[firstElement + lid + GROUP_SIZE];
	}

	/* Load GROUP_SIZE  values into shared memory */
	lds[lid + k] = inputImage[firstElement + lid];

	barrier(CLK_LOCAL_MEM_FENCE);

	/* Discard pixels in apron */
	if(x < k || x >= (width - k))
		return;

	int4 size = (int4)(filterWidth);

	int4 sum = 0;
	/* Read values from (filterWidth x filterWidth) sized kernel */
	for(int X = -k; X <= k; X++)
	{
		sum += convert_int4(lds[lid + X + k]);
	}
	outputImage[pos] = convert_uchar4(sum / size);
}














































// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
