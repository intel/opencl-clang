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
 * On invocation of kernel blackScholes, each work thread calculates call price
 * and put price values for given stoke price, option strike price,
 * time to expiration date, risk free interest and volatility factor.
 */

#define S_LOWER_LIMIT 10.0f
#define S_UPPER_LIMIT 100.0f
#define K_LOWER_LIMIT 10.0f
#define K_UPPER_LIMIT 100.0f
#define T_LOWER_LIMIT 1.0f
#define T_UPPER_LIMIT 10.0f
#define R_LOWER_LIMIT 0.01f
#define R_UPPER_LIMIT 0.05f
#define SIGMA_LOWER_LIMIT 0.01f
#define SIGMA_UPPER_LIMIT 0.10f

/**
 * @brief   Abromowitz Stegun approxmimation for PHI (Cumulative Normal Distribution Function)
 * @param   X input value
 * @param   phi pointer to store calculated CND of X
 */
void phi(float4 X, float4* phi)
{
    float4 y;
    float4 absX;
    float4 t;
    float4 result;

    const float4 c1 = (float4)0.319381530f;
    const float4 c2 = (float4)-0.356563782f;
    const float4 c3 = (float4)1.781477937f;
    const float4 c4 = (float4)-1.821255978f;
    const float4 c5 = (float4)1.330274429f;

    const float4 zero = (float4)0.0f;
    const float4 one = (float4)1.0f;
    const float4 two = (float4)2.0f;
    const float4 temp4 = (float4)0.2316419f;

    const float4 oneBySqrt2pi = (float4)0.398942280f;

    absX = fabs(X);
    t = one/(one + temp4 * absX);

    y = one - oneBySqrt2pi * exp(-X*X/two) * t
        * (c1 + t
              * (c2 + t
                    * (c3 + t
                          * (c4 + t * c5))));

    result = (X < zero)? (one - y) : y;

    *phi = result;
}

/*
 * @brief   Calculates the call and put prices by using Black Scholes model
 * @param   s       Array of random values of current option price
 * @param   sigma   Array of random values sigma
 * @param   k       Array of random values strike price
 * @param   t       Array of random values of expiration time
 * @param   r       Array of random values of risk free interest rate
 * @param   width   Width of call price or put price array
 * @param   call    Array of calculated call price values
 * @param   put     Array of calculated put price values
 */
__kernel
void
blackScholes(const __global float4 *randArray,
             int width,
             __global float4 *call,
             __global float4 *put)
{
    float4 d1, d2;
    float4 phiD1, phiD2;
    float4 sigmaSqrtT;
    float4 KexpMinusRT;

    size_t xPos = get_global_id(0);
    size_t yPos = get_global_id(1);
    float4 two = (float4)2.0f;
    float4 inRand = randArray[yPos * width + xPos];
    float4 S = S_LOWER_LIMIT * inRand + S_UPPER_LIMIT * (1.0f - inRand);
    float4 K = K_LOWER_LIMIT * inRand + K_UPPER_LIMIT * (1.0f - inRand);
    float4 T = T_LOWER_LIMIT * inRand + T_UPPER_LIMIT * (1.0f - inRand);
    float4 R = R_LOWER_LIMIT * inRand + R_UPPER_LIMIT * (1.0f - inRand);
    float4 sigmaVal = SIGMA_LOWER_LIMIT * inRand + SIGMA_UPPER_LIMIT * (1.0f - inRand);


    sigmaSqrtT = sigmaVal * sqrt(T);

    d1 = (log(S/K) + (R + sigmaVal * sigmaVal / two)* T)/ sigmaSqrtT;
    d2 = d1 - sigmaSqrtT;

    KexpMinusRT = K * exp(-R * T);
    phi(d1, &phiD1);
    phi(d2, &phiD2);
    call[yPos * width + xPos] = S * phiD1 - KexpMinusRT * phiD2;
    phi(-d1, &phiD1);
    phi(-d2, &phiD2);
    put[yPos * width + xPos]  = KexpMinusRT * phiD2 - S * phiD1;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
