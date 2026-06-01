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
__kernel void computeBondedForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, int groups, __global const uint2* restrict atomIndices0, __global const uint2* restrict bufferIndices0, __global float2* customArg1) {
real energy = 0.0f;
if ((groups&1) != 0)
for (unsigned int index = get_global_id(0); index < 9; index += get_global_size(0)) {
    uint2 atoms = atomIndices0[index];
    uint2 buffers = bufferIndices0[index];
    unsigned int atom1 = atoms.x;
    real4 pos1 = posq[atom1];
    unsigned int atom2 = atoms.y;
    real4 pos2 = posq[atom2];
real4 delta = pos2-pos1;
real r = SQRT(delta.x*delta.x + delta.y*delta.y + delta.z*delta.z);
float2 bondParams = customArg1[index];
real deltaIdeal = r-bondParams.x;
energy += 0.5f * bondParams.y*deltaIdeal*deltaIdeal;
real dEdR = bondParams.y * deltaIdeal;

dEdR = (r > 0.0f) ? (dEdR / r) : 0.0f;
delta.xyz *= dEdR;
real4 force1 = delta;
real4 force2 = -delta;
    {
    unsigned int offset = atom1+buffers.x*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force1.xyz;
    forceBuffers[offset] = force;
    }
    {
    unsigned int offset = atom2+buffers.y*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force2.xyz;
    forceBuffers[offset] = force;
    }
}
energyBuffer[get_global_id(0)] += energy;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
