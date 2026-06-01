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
#define PADDED_NUM_ATOMS 160

#define REDUCE_VALUE(NAME, TYPE) {\
    TYPE sum = NAME[index]; \
    for (int i = index+bufferSize; i < totalSize; i += bufferSize) \
        sum += NAME[i]; \
    NAME[index] = sum; \
}

/**
 * Reduce the derivatives computed in the N^2 energy kernel, and compute all per-particle energy terms.
 */

__kernel void computePerParticleEnergy(int bufferSize, int numBuffers, __global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq
        , __global const float* globals, __global const float* restrict params1, __global const float* restrict params2, __global const float* restrict params3, __global const float* restrict values1, __global const float* restrict values2, __global float* restrict derivBuffers1, __global float* restrict derivBuffers2, __global float* restrict derivChain1, __global float* restrict derivChain2) {
    real energy = 0;
    unsigned int index = get_global_id(0);
    while (index < NUM_ATOMS) {
        // Reduce the derivatives

        int totalSize = bufferSize*numBuffers;
        REDUCE_VALUE(derivBuffers1, float)
REDUCE_VALUE(derivBuffers2, float)


        // Now calculate the per-particle energy terms.

        real4 pos = posq[index];
        real4 force = (real4) 0;
        float deriv1 = derivBuffers1[index];
float deriv2 = derivBuffers2[index];
real temp10 = 0.00000000e+00f;
/*1*/ deriv1 += temp10;
real temp11 = 1.40000000e-01f+params2[index];
real temp12 = temp11*temp11;
real temp13 = 2.83919551e+01f*temp12;
real temp14 = params2[index]/values2[index];
real temp15 = 0.0f;
real temp16 = 0.0f;
{
float multiplier = temp14;
temp15 = multiplier;
multiplier *= multiplier;
temp16 = multiplier;
multiplier *= multiplier;
temp15 *= multiplier;
temp16 *= multiplier;
};
real temp17 = -6.00000000e+00f*temp15;
real temp18 = values2[index]*values2[index];
real temp19 = params2[index]/temp18;
real temp20 = temp17*temp19;
real temp21 = temp13*temp20;
real temp22 = RECIP(globals[1]);
real temp23 = RECIP(globals[0]);
real temp24 = temp22-temp23;
real temp25 = 6.94677280e+01f*temp24;
real temp26 = params1[index]*params1[index];
real temp27 = temp25*temp26;
real temp28 = temp27/temp18;
real temp29 = temp21+temp28;
/*1*/ deriv2 += temp29;
real temp30 = temp13*temp16;
real temp31 = temp27/values2[index];
real temp32 = temp30-temp31;
/*1*/ energy += temp32;
real temp33 = 1.00000000e+00f;
real temp34 = -9.00000000e-03f+params2[index];
real temp35 = values1[index]*temp34;
real temp36 = temp35*temp35;
real temp37 = 8.00000000e-01f*temp36;
real temp38 = temp35-temp37;
real temp39 = temp35*temp35*temp35;
real temp40 = 4.85000000e+00f*temp39;
real temp41 = temp38+temp40;
real temp42 = tanh(temp41);
real temp43 = temp42*temp42;
real temp44 = temp33-temp43;
real temp45 = 2.00000000e+00f*temp35;
real temp46 = temp45*temp34;
real temp47 = 8.00000000e-01f*temp46;
real temp48 = temp34-temp47;
real temp49 = 3.00000000e+00f*temp36;
real temp50 = temp49*temp34;
real temp51 = 4.85000000e+00f*temp50;
real temp52 = temp48+temp51;
real temp53 = temp44*temp52;
real temp54 = params2[index]*temp53;
real temp55 = params2[index]*params2[index];
real temp56 = temp54/temp55;
real temp57 = RECIP(temp34);
real temp58 = temp42/params2[index];
real temp59 = temp57-temp58;
real temp60 = temp59*temp59;
real temp61 = temp56/temp60;
real dV1dV0 = temp61;
derivBuffers1[index] = deriv1;
derivBuffers2[index] = deriv2;
forceBuffers[index] = forceBuffers[index]+force;
real totalDeriv1 = dV1dV0;
deriv2 *= totalDeriv1;
derivChain1[index] = deriv1;
derivChain2[index] = deriv2;

        index += get_global_size(0);
    }
    energyBuffer[get_global_id(0)] += energy;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
