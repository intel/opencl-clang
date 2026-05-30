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

/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 *
 * One invocation of calPriceVega kernel, i.e one work thread caluculates the
 * price value and path derivative from given initial price, strike price,
 * interest rate and maturity
 */

 typedef struct _MonteCalroAttrib
 {
     float4 strikePrice;
     float4 c1;
     float4 c2;
     float4 c3;
     float4 initPrice;
     float4 sigma;
     float4 timeStep;
 }MonteCarloAttrib;



/**
 * @brief Left shift
 * @param input input to be shifted
 * @param shift shifting count
 * @param output result after shifting input
 */
void
lshift128(uint4 input, uint shift, uint4* output)
{
    unsigned int invshift = 32u - shift;

    uint4 temp;
    temp.x = input.x << shift;
    temp.y = (input.y << shift) | (input.x >> invshift);
    temp.z = (input.z << shift) | (input.y >> invshift);
    temp.w = (input.w << shift) | (input.z >> invshift);

    *output = temp;
}

/**
 * @brief Right shift
 * @param input input to be shifted
 * @param shift shifting count
 * @param output result after shifting input
 */
void
rshift128(uint4 input, uint shift, uint4* output)
{
    unsigned int invshift = 32u - shift;

    uint4 temp;

    temp.w = input.w >> shift;
    temp.z = (input.z >> shift) | (input.w << invshift);
    temp.y = (input.y >> shift) | (input.z << invshift);
    temp.x = (input.x >> shift) | (input.y << invshift);

    *output = temp;
}

/**
 * @brief Generates gaussian random numbers by using
 *        Mersenenne Twister algo and box muller transformation
 * @param seedArray  seed
 * @param gaussianRand1 gaussian random number generatred
 * @param gaussianRand2 gaussian random number generarted
 * @param nextRand  generated seed for next usage
 */
void generateRand(uint4 seed,
                  float4 *gaussianRand1,
                  float4 *gaussianRand2,
                  uint4 *nextRand)
{

    uint mulFactor = 4;
    uint4 temp[8];

    uint4 state1 = seed;
    uint4 state2 = (uint4)(0);
    uint4 state3 = (uint4)(0);
    uint4 state4 = (uint4)(0);
    uint4 state5 = (uint4)(0);

    uint stateMask = 1812433253u;
    uint thirty = 30u;
    uint4 mask4 = (uint4)(stateMask);
    uint4 thirty4 = (uint4)(thirty);
    uint4 one4 = (uint4)(1u);
    uint4 two4 = (uint4)(2u);
    uint4 three4 = (uint4)(3u);
    uint4 four4 = (uint4)(4u);

    uint4 r1 = (uint4)(0);
    uint4 r2 = (uint4)(0);

    uint4 a = (uint4)(0);
    uint4 b = (uint4)(0);

    uint4 e = (uint4)(0);
    uint4 f = (uint4)(0);

    unsigned int thirteen  = 13u;
    unsigned int fifteen = 15u;
    unsigned int shift = 8u * 3u;

    unsigned int mask11 = 0xfdff37ffu;
    unsigned int mask12 = 0xef7f3f7du;
    unsigned int mask13 = 0xff777b7du;
    unsigned int mask14 = 0x7ff7fb2fu;


    const float one = 1.0f;
    const float intMax = 4294967296.0f;
    const float PI = 3.14159265358979f;
    const float two = 2.0f;

    float4 r;
    float4 phi;

    float4 temp1;
    float4 temp2;

    //Initializing states.
    state2 = mask4 * (state1 ^ (state1 >> thirty4)) + one4;
    state3 = mask4 * (state2 ^ (state2 >> thirty4)) + two4;
    state4 = mask4 * (state3 ^ (state3 >> thirty4)) + three4;
    state5 = mask4 * (state4 ^ (state4 >> thirty4)) + four4;

    uint i = 0;
    for(i = 0; i < mulFactor; ++i)
    {
        switch(i)
        {
            case 0:
                r1 = state4;
                r2 = state5;
                a = state1;
                b = state3;
                break;
            case 1:
                r1 = r2;
                r2 = temp[0];
                a = state2;
                b = state4;
                break;
            case 2:
                r1 = r2;
                r2 = temp[1];
                a = state3;
                b = state5;
                break;
            case 3:
                r1 = r2;
                r2 = temp[2];
                a = state4;
                b = state1;
                break;
            default:
                break;

        }

        lshift128(a, shift, &e);
        rshift128(r1, shift, &f);

        temp[i].x = a.x ^ e.x ^ ((b.x >> thirteen) & mask11) ^ f.x ^ (r2.x << fifteen);
        temp[i].y = a.y ^ e.y ^ ((b.y >> thirteen) & mask12) ^ f.y ^ (r2.y << fifteen);
        temp[i].z = a.z ^ e.z ^ ((b.z >> thirteen) & mask13) ^ f.z ^ (r2.z << fifteen);
        temp[i].w = a.w ^ e.w ^ ((b.w >> thirteen) & mask14) ^ f.w ^ (r2.w << fifteen);
    }

    temp1 = convert_float4(temp[0]) * one / intMax;
    temp2 = convert_float4(temp[1]) * one / intMax;

    // Applying Box Mullar Transformations.
    r = sqrt((-two) * log(temp1));
    phi  = two * PI * temp2;
    *gaussianRand1 = r * cos(phi);
    *gaussianRand2 = r * sin(phi);
    *nextRand = temp[2];

}

/**
 * @brief   calculates the  price and vega for all trajectories
 */
void
calOutputs(float4 strikePrice,
                float4 meanDeriv1,
                float4  meanDeriv2,
                float4 meanPrice1,
                float4 meanPrice2,
                float4 *pathDeriv1,
                float4 *pathDeriv2,
                float4 *priceVec1,
                float4 *priceVec2)
{
    float4 temp1 = (float4)0.0f;
    float4 temp2 = (float4)0.0f;
    float4 temp3 = (float4)0.0f;
    float4 temp4 = (float4)0.0f;

    float4 tempDiff1 = meanPrice1 - strikePrice;
    float4 tempDiff2 = meanPrice2 - strikePrice;
    if(tempDiff1.x > 0.0f)
    {
        temp1.x = 1.0f;
        temp3.x = tempDiff1.x;
    }
    if(tempDiff1.y > 0.0f)
    {
        temp1.y = 1.0f;
        temp3.y = tempDiff1.y ;
    }
    if(tempDiff1.z > 0.0f)
    {
        temp1.z = 1.0f;
        temp3.z = tempDiff1.z;
    }
    if(tempDiff1.w > 0.0f)
    {
        temp1.w = 1.0f;
        temp3.w = tempDiff1.w;
    }

    if(tempDiff2.x > 0.0f)
    {
        temp2.x = 1.0f;
        temp4.x = tempDiff2.x;
    }
    if(tempDiff2.y > 0.0f)
    {
        temp2.y = 1.0f;
        temp4.y = tempDiff2.y;
    }
    if(tempDiff2.z > 0.0f)
    {
        temp2.z = 1.0f;
        temp4.z = tempDiff2.z;
    }
    if(tempDiff2.w > 0.0f)
    {
        temp2.w = 1.0f;
        temp4.w = tempDiff2.w;
    }

    *pathDeriv1 = meanDeriv1 * temp1;
    *pathDeriv2 = meanDeriv2 * temp2;
    *priceVec1 = temp3;
    *priceVec2 = temp4;
}

/**
 * @brief   Calculates the  price and vega for all trajectories for given random numbers
 * @param   attrib  structure of inputs for simulation
 * @param   width   width of random array
 * @param   priceSamples    array of calculated price samples
 * @param   pathDeriv   array calculated path derivatives
 */
__kernel
void
calPriceVega(MonteCarloAttrib attrib,
            int noOfSum,
            int width,
            __global uint4 *randArray,
            __global float4 *priceSamples,
            __global float4 *pathDeriv)
{


        float4 strikePrice = attrib.strikePrice;
        float4 c1 = attrib.c1;
        float4 c2 = attrib.c2;
        float4 c3 = attrib.c3;
        float4 initPrice = attrib.initPrice;
        float4 sigma = attrib.sigma;
        float4 timeStep = attrib.timeStep;

        size_t xPos = get_global_id(0);
        size_t yPos = get_global_id(1);

        float4 temp = (float4)0.0f;

        float4 price1 = (float4)0.0f;
        float4 price2 = (float4)0.0f;
        float4 pathDeriv1 = (float4)0.0f;
        float4 pathDeriv2 = (float4)0.0f;

        float4 trajPrice1 = initPrice;
        float4 trajPrice2 = initPrice;

        float4 sumPrice1 = initPrice;
        float4 sumPrice2 = initPrice;

        float4 meanPrice1 = temp;
        float4 meanPrice2 = temp;

        float4 sumDeriv1 = temp;
        float4 sumDeriv2 = temp;

        float4 meanDeriv1 = temp;
        float4 meanDeriv2 = temp;

        float4 finalRandf1 = temp;
        float4 finalRandf2 = temp;

        uint4 nextRand = randArray[yPos * width + xPos];

        //Run the Monte Carlo simulation a total of Num_Sum - 1 times
        for(int i = 1; i < noOfSum; i++)
        {
            uint4 tempRand = nextRand;
            generateRand(tempRand, &finalRandf1, &finalRandf2, &nextRand);

            //Calculate the trajectory price and sum price for all trajectories
            trajPrice1 = trajPrice1 * exp(c1 + c2 * finalRandf1);
            trajPrice2 = trajPrice2 * exp(c1 + c2 * finalRandf2);

            sumPrice1 = sumPrice1 + trajPrice1;
            sumPrice2 = sumPrice2 + trajPrice2;

            temp = c3 * timeStep * i;

            // Calculate the derivative price for all trajectories
            sumDeriv1 = sumDeriv1 + trajPrice1
                        * ((log(trajPrice1 / initPrice) - temp) / sigma);

            sumDeriv2 = sumDeriv2 + trajPrice2
                        * ((log(trajPrice2 / initPrice) - temp) / sigma);

        }

        //Calculate the average price and “average derivative” of each simulated path
        meanPrice1 = sumPrice1 / noOfSum;
        meanPrice2 = sumPrice2 / noOfSum;
        meanDeriv1 = sumDeriv1 / noOfSum;
        meanDeriv2 = sumDeriv2 / noOfSum;

        calOutputs(strikePrice, meanDeriv1, meanDeriv2, meanPrice1,
                    meanPrice2, &pathDeriv1, &pathDeriv2, &price1, &price2);

        priceSamples[(yPos * width + xPos) * 2] = price1;
        priceSamples[(yPos * width + xPos) * 2 + 1] = price2;
        pathDeriv[(yPos * width + xPos) * 2] = pathDeriv1;
        pathDeriv[(yPos * width + xPos) * 2 + 1] = pathDeriv2;

}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
