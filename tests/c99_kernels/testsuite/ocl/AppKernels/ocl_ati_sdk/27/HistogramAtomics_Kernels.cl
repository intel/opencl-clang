/* ============================================================

Copyright (c) 2010 Advanced Micro Devices, Inc.  All rights reserved.

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

#define NBINS        256
#define BITS_PER_PIX 8


#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable

#define MIN(a,b) ((a) < (b)) ? (a) : (b)
#define MAX(a,b) ((a) > (b)) ? (a) : (b)

#define NBANKS 16

// histogramKernel work group size must be integer multiple of 256

__kernel __attribute__((reqd_work_group_size(256,1,1)))
void histogramKernel(__global uint4 *Image,
                     __global uint  *Histogram,
                              uint  n4VectorsPerThread)
{
    __local uint subhists[NBANKS * NBINS];

    uint tid     = get_global_id(0);
    uint ltid    = get_local_id(0);
    uint Stride  = get_global_size(0);

    uint i, idx;
    uint4 temp, temp2;
    const uint shft = (uint) BITS_PER_PIX;
    const uint msk =  (uint) (NBINS-1);
    uint offset = (uint) ltid % (uint) (NBANKS);

    uint lmem_items = NBANKS * NBINS;
    uint lmem_items_per_thread;
    uint lmem_max_threads;

    // parallel LDS clear

    // first, calculate threads per item, at least 1:
    lmem_max_threads = MIN( 1, get_local_size(0) / lmem_items );
    // but no more than we have items:
    lmem_max_threads = MAX( 1, lmem_max_threads / lmem_items );
    // calculate threads total:
    lmem_max_threads = lmem_items / lmem_max_threads;
    // but no more than LDS banks:
    lmem_max_threads = MIN( get_local_size(0), lmem_max_threads );

    lmem_items_per_thread = lmem_items / lmem_max_threads;

    // now, clear LDS
    __local uint4 *p = (__local uint4 *) subhists;

    if( ltid < lmem_max_threads )
    {
       for(i=0, idx=ltid; i<lmem_items_per_thread/4; i++, idx+=lmem_max_threads)
       {
          p[idx] = 0;
       }
    }

    barrier( CLK_LOCAL_MEM_FENCE );

    // read & scatter phase

    for( i=0, idx=tid; i<n4VectorsPerThread; i++, idx += Stride )
    {
       temp = Image[idx];
       temp2 = (temp & msk) * (uint4) NBANKS + offset;

       (void) atom_inc( subhists + temp2.x );
       (void) atom_inc( subhists + temp2.y );
       (void) atom_inc( subhists + temp2.z );
       (void) atom_inc( subhists + temp2.w );

       temp = temp >> shft;
       temp2 = (temp & msk) * (uint4) NBANKS + offset;

       (void) atom_inc( subhists + temp2.x );
       (void) atom_inc( subhists + temp2.y );
       (void) atom_inc( subhists + temp2.z );
       (void) atom_inc( subhists + temp2.w );

       temp = temp >> shft;
       temp2 = (temp & msk) * (uint4) NBANKS + offset;

       (void) atom_inc( subhists + temp2.x );
       (void) atom_inc( subhists + temp2.y );
       (void) atom_inc( subhists + temp2.z );
       (void) atom_inc( subhists + temp2.w );

       temp = temp >> shft;
       temp2 = (temp & msk) * (uint4) NBANKS + offset;

       (void) atom_inc( subhists + temp2.x );
       (void) atom_inc( subhists + temp2.y );
       (void) atom_inc( subhists + temp2.z );
       (void) atom_inc( subhists + temp2.w );
    }

    barrier( CLK_LOCAL_MEM_FENCE );

    // reduce __local banks to single histogram per work-group

    if( ltid < NBINS )
    {
       uint bin = 0;

       for( i=0; i<NBANKS; i++ )
       {
          bin += subhists[ (ltid * NBANKS) + i ];
       }

       Histogram[ (get_group_id(0) * NBINS) + ltid ] = bin;
    }
}

__kernel void reduceKernel( __global uint *Histogram, uint nSubHists )
{
    uint tid = get_global_id(0);
    uint bin = 0;

    // Reduce work-group histograms into single histogram,
    // one thread for each bin.

    for( int i=0; i < nSubHists; i++ )
       bin += Histogram[ (i * NBINS) + tid ];

    Histogram[ tid ] = bin;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
