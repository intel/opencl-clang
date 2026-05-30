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
#define PADDED_NUM_ATOMS 320

#ifdef SUPPORTS_64_BIT_ATOMICS
#pragma OPENCL EXTENSION cl_khr_int64_base_atomics : enable
#endif
__kernel void computeBondedForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, int groups, __global const uint8* restrict atomIndices0, __global const uint8* restrict bufferIndices0, __global float4* customArg1) {
real energy = 0.0f;
if ((groups&1) != 0)
for (unsigned int index = get_global_id(0); index < 64; index += get_global_size(0)) {
    uint8 atoms = atomIndices0[index];
    uint8 buffers = bufferIndices0[index];
    unsigned int atom1 = atoms.s0;
    real4 pos1 = posq[atom1];
    unsigned int atom2 = atoms.s1;
    real4 pos2 = posq[atom2];
    unsigned int atom3 = atoms.s2;
    real4 pos3 = posq[atom3];
    unsigned int atom4 = atoms.s3;
    real4 pos4 = posq[atom4];
    unsigned int atom5 = atoms.s4;
    real4 pos5 = posq[atom5];
real4 delta = (real4) (pos1.xyz-pos2.xyz, 0);
real r2 = delta.x*delta.x + delta.y*delta.y + delta.z*delta.z;
float4 drudeParams = customArg1[index];
float k1 = drudeParams.x;
float k2 = drudeParams.y;
float k3 = drudeParams.z;

// Compute the isotropic force.

energy += 0.5f*k3*r2;
real4 force1 = -delta*k3;
real4 force2 = delta*k3;
real4 force3 = 0;
real4 force4 = 0;
real4 force5 = 0;

// Compute the first anisotropic force.

if (k1 != 0) {
    real4 dir = (real4) (pos2.xyz-pos3.xyz, 0);
    real invDist = RSQRT(dot(dir, dir));
    dir *= invDist;
    real rprime = dot(dir, delta);
    energy += 0.5f*k1*rprime*rprime;
    real4 f1 = dir*(k1*rprime);
    real4 f2 = (delta-dir*rprime)*(k1*rprime*invDist);
    force1 -= f1;
    force2 += f1-f2;
    force3 += f2;
}

// Compute the second anisotropic force.

if (k2 != 0) {
    real4 dir = (real4) (pos3.xyz-pos4.xyz, 0);
    real invDist = RSQRT(dot(dir, dir));
    dir *= invDist;
    real rprime = dot(dir, delta);
    energy += 0.5f*k2*rprime*rprime;
    real4 f1 = dir*(k2*rprime);
    real4 f2 = (delta-dir*rprime)*(k2*rprime*invDist);
    force1 -= f1;
    force2 += f1;
    force4 -= f2;
    force5 += f2;
}

    {
    unsigned int offset = atom1+buffers.s0*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force1.xyz;
    forceBuffers[offset] = force;
    }
    {
    unsigned int offset = atom2+buffers.s1*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force2.xyz;
    forceBuffers[offset] = force;
    }
    {
    unsigned int offset = atom3+buffers.s2*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force3.xyz;
    forceBuffers[offset] = force;
    }
    {
    unsigned int offset = atom4+buffers.s3*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force4.xyz;
    forceBuffers[offset] = force;
    }
    {
    unsigned int offset = atom5+buffers.s4*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force5.xyz;
    forceBuffers[offset] = force;
    }
}
energyBuffer[get_global_id(0)] += energy;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
