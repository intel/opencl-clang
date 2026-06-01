#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint int
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100

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



//Passed down by clBuildProgram
#define LOG2_WARP_SIZE 5U
#define     WARP_COUNT 6

////////////////////////////////////////////////////////////////////////////////
// Common definition
////////////////////////////////////////////////////////////////////////////////
#define HISTOGRAM256_BIN_COUNT 256

#define      UINT_BITS 32U
#define      WARP_SIZE (1U << LOG2_WARP_SIZE)

//Workgroup size
#define HISTOGRAM256_WORKGROUP_SIZE (WARP_COUNT * WARP_SIZE)

//Local memory per workgroup
#define HISTOGRAM256_WORKGROUP_MEMORY (WARP_COUNT * HISTOGRAM256_BIN_COUNT)



////////////////////////////////////////////////////////////////////////////////
// Main computation pass: compute per-workgroup partial histograms
////////////////////////////////////////////////////////////////////////////////
#define TAG_MASK ( (1U << (UINT_BITS - LOG2_WARP_SIZE)) - 1U )

inline void addByte(volatile __local unsigned mint *l_WarpHist, unsigned mint data, unsigned mint tag){
    uint count;
    do{
        count = l_WarpHist[data] & TAG_MASK;
        count = tag | (count + 1);
        l_WarpHist[data] = count;
    }while(l_WarpHist[data] != count);
}

inline void addWord(volatile __local unsigned mint *l_WarpHist, unsigned mint data, unsigned mint tag){
    addByte(l_WarpHist, (data >>  0) & 0xFFU, tag);
    addByte(l_WarpHist, (data >>  8) & 0xFFU, tag);
    addByte(l_WarpHist, (data >> 16) & 0xFFU, tag);
    addByte(l_WarpHist, (data >> 24) & 0xFFU, tag);
}

__kernel __attribute__((reqd_work_group_size(HISTOGRAM256_WORKGROUP_SIZE, 1, 1)))
void histogram256(
    __global unsigned mint *d_PartialHistograms,
    __global unsigned mint *d_Data,
    unsigned mint dataCount
){
    //Per-warp substorage storage
    __local uint l_Hist[WARP_COUNT * HISTOGRAM256_BIN_COUNT];
    __local uint *l_WarpHist = l_Hist + (get_local_id(0) >> LOG2_WARP_SIZE) * HISTOGRAM256_BIN_COUNT;

    //Clear shared memory storage for current threadblock before processing
    for(uint i = 0; i < (HISTOGRAM256_BIN_COUNT / WARP_SIZE); i++)
        l_Hist[get_local_id(0) + i  * (WARP_COUNT * WARP_SIZE)] = 0;

    const uint tag =  get_local_id(0) << (32 - LOG2_WARP_SIZE);

    //Read through the entire input buffer, build per-warp histograms
    barrier(CLK_LOCAL_MEM_FENCE);
    for(uint pos = get_global_id(0); pos < dataCount; pos += get_global_size(0)){
        uint data = d_Data[pos];
        addWord(l_WarpHist, data, tag);
    }

    //Per-block histogram reduction
    barrier(CLK_LOCAL_MEM_FENCE);
    for(uint pos = get_local_id(0); pos < HISTOGRAM256_BIN_COUNT; pos += HISTOGRAM256_WORKGROUP_SIZE){
        uint sum = 0;

        for(uint i = 0; i < WARP_COUNT; i++)
            sum += l_Hist[pos + i * HISTOGRAM256_BIN_COUNT] & TAG_MASK;

        d_PartialHistograms[get_group_id(0) * HISTOGRAM256_BIN_COUNT + pos] = sum;
    }
}



////////////////////////////////////////////////////////////////////////////////
// Merge histogram256() output
// Run one workgroup per bin; each workgroup adds up the same bin counter
// from every partial histogram. Reads are uncoalesced, but mergeHistogram256
// takes only a fraction of total processing time
////////////////////////////////////////////////////////////////////////////////
//Passed down by clBuildProgram
#define MERGE_WORKGROUP_SIZE 256

__kernel __attribute__((reqd_work_group_size(MERGE_WORKGROUP_SIZE, 1, 1)))
void mergeHistogram256(
    __global unsigned mint *d_Histogram,
    __global unsigned mint *d_PartialHistograms,
    unsigned mint histogramCount
){
    __local uint l_Data[MERGE_WORKGROUP_SIZE];

    uint sum = 0;
    for(uint i = get_local_id(0); i < histogramCount; i += MERGE_WORKGROUP_SIZE)
        sum += d_PartialHistograms[get_group_id(0) + i * HISTOGRAM256_BIN_COUNT];
    l_Data[get_local_id(0)] = sum;

    for(uint stride = MERGE_WORKGROUP_SIZE / 2; stride > 0; stride >>= 1){
        barrier(CLK_LOCAL_MEM_FENCE);
        if(get_local_id(0) < stride)
            l_Data[get_local_id(0)] += l_Data[get_local_id(0) + stride];
    }

    if(get_local_id(0) == 0)
        d_Histogram[get_group_id(0)] = l_Data[0];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
