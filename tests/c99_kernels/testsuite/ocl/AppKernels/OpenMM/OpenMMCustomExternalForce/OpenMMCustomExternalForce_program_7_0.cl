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
__kernel void computeBondedForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, int groups, __global const uint* restrict atomIndices0, __global const uint* restrict bufferIndices0, __global float* customArg1, __global float2* customArg2) {
real energy = 0.0f;
if ((groups&1) != 0)
for (unsigned int index = get_global_id(0); index < 2; index += get_global_size(0)) {
    uint atoms = atomIndices0[index];
    uint buffers = bufferIndices0[index];
    unsigned int atom1 = atoms;
    real4 pos1 = posq[atom1];
float2 particleParams1 = customArg2[index];
real temp6 = pos1.y-particleParams1.x;
real temp7 = temp6*temp6;
real temp8 = particleParams1.y*temp7;
real temp9 = pos1.x+temp8;
real temp10 = customArg1[0]*temp9;
energy += temp10;
real dEdX = customArg1[0];
real temp11 = 2.00000000e+00f*temp6;
real temp12 = particleParams1.y*temp11;
real temp13 = customArg1[0]*temp12;
real dEdY = temp13;
real temp14 = 0.00000000e+00f;
real dEdZ = temp14;

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
