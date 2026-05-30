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
#define PADDED_NUM_ATOMS 32

#ifdef SUPPORTS_64_BIT_ATOMICS
#pragma OPENCL EXTENSION cl_khr_int64_base_atomics : enable
#endif
__kernel void computeBondedForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, int groups, __global const uint* restrict atomIndices0, __global const uint* restrict bufferIndices0, __global float4* customArg1, __global float2* customArg2) {
real energy = 0.0f;
if ((groups&1) != 0)
for (unsigned int index = get_global_id(0); index < 1; index += get_global_size(0)) {
    uint atoms = atomIndices0[index];
    uint buffers = bufferIndices0[index];
    unsigned int atom1 = atoms;
    real4 pos1 = posq[atom1];
float4 particleParams1 = customArg1[index];
float2 particleParams2 = customArg2[index];
real temp9 = pos1.x-particleParams1.x;
real temp10 = temp9*temp9;
real temp11 = particleParams1.w*temp10;
real temp12 = pos1.y-particleParams1.y;
real temp13 = temp12*temp12;
real temp14 = particleParams2.x*temp13;
real temp15 = temp11+temp14;
real temp16 = pos1.z-particleParams1.z;
real temp17 = temp16*temp16;
real temp18 = particleParams2.y*temp17;
real temp19 = temp15+temp18;
energy += temp19;
real temp20 = 2.00000000e+00f*temp9;
real temp21 = particleParams1.w*temp20;
real dEdX = temp21;
real temp22 = 2.00000000e+00f*temp12;
real temp23 = particleParams2.x*temp22;
real dEdY = temp23;
real temp24 = 2.00000000e+00f*temp16;
real temp25 = particleParams2.y*temp24;
real dEdZ = temp25;

real4 force1 = (real4) (-dEdX, -dEdY, -dEdZ, 0);

    {
    unsigned int offset = atom1+buffers*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force1.xyz;
    forceBuffers[offset] = force;
    }
}
energyBuffer[get_global_id(0)] += energy;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
