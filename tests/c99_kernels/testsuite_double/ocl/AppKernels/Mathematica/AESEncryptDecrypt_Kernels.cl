
/* ============================================================

Copyright (c) 2009 Advanced Micro Devices, Inc.  All rights reserved.

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
#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint long
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100



/**
 *
 */

unsigned char
galoisMultiplication(unsigned char a, unsigned char b)
{
    unsigned char p = 0;
    for(unsigned int i=0; i < 8; ++i)
    {
        if((b&1) == 1)
        {
            p^=a;
        }
        unsigned char hiBitSet = (a & 0x80);
        a <<= 1;
        if(hiBitSet == 0x80)
        {
            a ^= 0x1b;
        }
        b >>= 1;
    }
    return p;
}

inline uchar4
sbox(__global uchar * SBox, uchar4 block)
{
    return (uchar4)(SBox[block.x], SBox[block.y], SBox[block.z], SBox[block.w]);
}

uchar4
mixColumns(__local uchar4 * block, __private uchar4 * galiosCoeff, unsigned mint j)
{
    unsigned int bw = 4;

    uchar x, y, z, w;

    x = galoisMultiplication(block[0].x, galiosCoeff[(bw-j)%bw].x);
    y = galoisMultiplication(block[0].y, galiosCoeff[(bw-j)%bw].x);
    z = galoisMultiplication(block[0].z, galiosCoeff[(bw-j)%bw].x);
    w = galoisMultiplication(block[0].w, galiosCoeff[(bw-j)%bw].x);

    for(unsigned int k=1; k< 4; ++k)
    {
        x ^= galoisMultiplication(block[k].x, galiosCoeff[(k+bw-j)%bw].x);
        y ^= galoisMultiplication(block[k].y, galiosCoeff[(k+bw-j)%bw].x);
        z ^= galoisMultiplication(block[k].z, galiosCoeff[(k+bw-j)%bw].x);
        w ^= galoisMultiplication(block[k].w, galiosCoeff[(k+bw-j)%bw].x);
    }

    return (uchar4)(x, y, z, w);
}

uchar4
shiftRows(uchar4 row, unsigned mint j)
{
    uchar4 r = row;
    for(uint i=0; i < j; ++i)
    {
        r = r.yzwx;
    }
    return r;
}

__kernel
void AESEncrypt(__global  uchar4  		* output  ,
                __global  uchar4  		* input   ,
                __global  uchar4  		* roundKey,
                __global  uchar   		* SBox    ,
                __local   uchar4  		* block0  ,
                __local   uchar4  		* block1  ,
                const     unsigned mint	  width   ,
                const     unsigned mint   rounds   )

{
    unsigned int blockIdx = get_group_id(0);
    unsigned int blockIdy = get_group_id(1);

    unsigned int localIdx = get_local_id(0);
    unsigned int localIdy = get_local_id(1);

    unsigned int globalIndex = (((blockIdy * width/4) + blockIdx) * 4 )+ (localIdy);
    unsigned int localIndex  = localIdy;

    __private uchar4 galiosCoeff[4];
     galiosCoeff[0] = (uchar4)(2, 0, 0, 0);
     galiosCoeff[1] = (uchar4)(3, 0, 0, 0);
     galiosCoeff[2] = (uchar4)(1, 0, 0, 0);
     galiosCoeff[3] = (uchar4)(1, 0, 0, 0);

    block0[localIndex]  = input[globalIndex];

    block0[localIndex] ^= roundKey[localIndex];

    for(unsigned int r=1; r < rounds; ++r)
    {
        block0[localIndex] = sbox(SBox, block0[localIndex]);

        block0[localIndex] = shiftRows(block0[localIndex], localIndex);

        barrier(CLK_LOCAL_MEM_FENCE);
        block1[localIndex]  = mixColumns(block0, galiosCoeff, localIndex);

        barrier(CLK_LOCAL_MEM_FENCE);
        block0[localIndex] = block1[localIndex]^roundKey[r*4 + localIndex];
    }
    block0[localIndex] = sbox(SBox, block0[localIndex]);

    block0[localIndex] = shiftRows(block0[localIndex], localIndex);

    output[globalIndex] =  block0[localIndex]^roundKey[(rounds)*4 + localIndex];
}

uchar4
shiftRowsInv(uchar4 row, unsigned mint j)
{
    uchar4 r = row;
    for(uint i=0; i < j; ++i)
    {
        r = r.wxyz;
    }
    return r;
}

__kernel
void AESDecrypt(__global  uchar4  		* output    ,
                __global  uchar4  		* input     ,
                __global  uchar4  		* roundKey  ,
                __global  uchar   		* SBox      ,
                __local   uchar4  		* block0    ,
                __local   uchar4  		* block1    ,
                const     unsigned mint	  width     ,
                const     unsigned mint   rounds    )

{
    unsigned int blockIdx = get_group_id(0);
    unsigned int blockIdy = get_group_id(1);

    unsigned int localIdx = get_local_id(0);
    unsigned int localIdy = get_local_id(1);

    unsigned int globalIndex = (((blockIdy * width/4) + blockIdx) * 4 )+ (localIdy);
    unsigned int localIndex  = localIdy;

    __private uchar4 galiosCoeff[4];
     galiosCoeff[0] = (uchar4)(14, 0, 0, 0);
     galiosCoeff[1] = (uchar4)(11, 0, 0, 0);
     galiosCoeff[2] = (uchar4)(13, 0, 0, 0);
     galiosCoeff[3] = (uchar4)(9, 0, 0, 0);

    block0[localIndex]  = input[globalIndex];

    block0[localIndex] ^= roundKey[4*rounds + localIndex];

    for(unsigned int r=rounds -1 ; r > 0; --r)
    {
        block0[localIndex] = shiftRowsInv(block0[localIndex], localIndex);

        block0[localIndex] = sbox(SBox, block0[localIndex]);

        barrier(CLK_LOCAL_MEM_FENCE);
        block1[localIndex] = block0[localIndex]^roundKey[r*4 + localIndex];

        barrier(CLK_LOCAL_MEM_FENCE);
        block0[localIndex]  = mixColumns(block1, galiosCoeff, localIndex);
    }

    block0[localIndex] = shiftRowsInv(block0[localIndex], localIndex);

    block0[localIndex] = sbox(SBox, block0[localIndex]);

    output[globalIndex] =  block0[localIndex]^roundKey[localIndex];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
