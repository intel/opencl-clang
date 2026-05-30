#define APPLY_PERIODIC_TO_DELTA(delta) delta.xyz -= floor(delta.xyz*invPeriodicBoxSize.xyz+0.5f)*periodicBoxSize.xyz;
#define APPLY_PERIODIC_TO_POS(pos) pos.xyz -= floor(pos.xyz*invPeriodicBoxSize.xyz)*periodicBoxSize.xyz;
#define APPLY_PERIODIC_TO_POS_WITH_CENTER(pos, center) {pos.x -= floor((pos.x-center.x)*invPeriodicBoxSize.x+0.5f)*periodicBoxSize.x; \
pos.y -= floor((pos.y-center.y)*invPeriodicBoxSize.y+0.5f)*periodicBoxSize.y; \
pos.z -= floor((pos.z-center.z)*invPeriodicBoxSize.z+0.5f)*periodicBoxSize.z;}
#define EXP native_exp
#define LOG native_log
#define RECIP native_recip
#define RSQRT native_rsqrt
#define SQRT native_sqrt
#define SYNC_WARPS barrier(CLK_LOCAL_MEM_FENCE)
#define WORK_GROUP_SIZE 64
#define convert_mixed4 convert_float4
#define convert_real4 convert_float4

typedef float real;
typedef float2 real2;
typedef float3 real3;
typedef float4 real4;
typedef float mixed;
typedef float2 mixed2;
typedef float3 mixed3;
typedef float4 mixed4;
#define NUM_ATOMS 140

/**
 * Reduce a pairwise computed value, and compute per-particle values.
 */

__kernel void computePerParticleValues(int bufferSize, int numBuffers, __global real4* posq,
#ifdef SUPPORTS_64_BIT_ATOMICS
        __global long* valueBuffers
#else
        __global real* valueBuffers
#endif
        , __global const float* globals, __global const float* restrict params1, __global const float* restrict params2, __global const float* restrict params3, __global float* restrict global_values1, __global float* restrict global_values2) {
    unsigned int index = get_global_id(0);
    while (index < NUM_ATOMS) {
        // Reduce the pairwise value

#ifdef SUPPORTS_64_BIT_ATOMICS
        real sum = (1.0f/0x100000000)*valueBuffers[index];
#else
        int totalSize = bufferSize*numBuffers;
        real sum = valueBuffers[index];
        for (int i = index+bufferSize; i < totalSize; i += bufferSize)
            sum += valueBuffers[i];
#endif

        // Now calculate other values

        real4 pos = posq[index];
        float local_values1;
float local_values2;
local_values1 = sum;
real value1_temp9 = -9.00000000e-03f+params2[index];
real value1_temp10 = RECIP(value1_temp9);
real value1_temp11 = local_values1*value1_temp9;
real value1_temp12 = value1_temp11*value1_temp11;
real value1_temp13 = 8.00000000e-01f*value1_temp12;
real value1_temp14 = value1_temp11-value1_temp13;
real value1_temp15 = value1_temp11*value1_temp11*value1_temp11;
real value1_temp16 = 4.85000000e+00f*value1_temp15;
real value1_temp17 = value1_temp14+value1_temp16;
real value1_temp18 = tanh(value1_temp17);
real value1_temp19 = value1_temp18/params2[index];
real value1_temp20 = value1_temp10-value1_temp19;
real value1_temp21 = RECIP(value1_temp20);
local_values2 = value1_temp21;
global_values1[index] = local_values1;
global_values2[index] = local_values2;

        index += get_global_size(0);
    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
