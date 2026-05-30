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
__kernel void computeBondedForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, int groups, __global const uint4* restrict atomIndices0, __global const uint4* restrict bufferIndices0, __global float2* customArg1) {
real energy = 0.0f;
if ((groups&1) != 0)
for (unsigned int index = get_global_id(0); index < 2; index += get_global_size(0)) {
    uint4 atoms = atomIndices0[index];
    uint4 buffers = bufferIndices0[index];
    unsigned int atom1 = atoms.x;
    real4 pos1 = posq[atom1];
    unsigned int atom2 = atoms.y;
    real4 pos2 = posq[atom2];
    unsigned int atom3 = atoms.z;
    real4 pos3 = posq[atom3];
real4 v0 = pos2-pos1;
real4 v1 = pos2-pos3;
real4 cp = cross(v0, v1);
real rp = cp.x*cp.x + cp.y*cp.y + cp.z*cp.z;
rp = max(SQRT(rp), (real) 1.0e-06f);
real r21 = v0.x*v0.x + v0.y*v0.y + v0.z*v0.z;
real r23 = v1.x*v1.x + v1.y*v1.y + v1.z*v1.z;
real dot = v0.x*v1.x + v0.y*v1.y + v0.z*v1.z;
real cosine = clamp(dot*RSQRT(r21*r23), (real) -1, (real) 1);
real theta = acos(cosine);
float2 angleParams = customArg1[index];
real deltaIdeal = theta-angleParams.x;
energy += 0.5f*angleParams.y*deltaIdeal*deltaIdeal;
real dEdAngle = angleParams.y*deltaIdeal;

real4 force1 = cross(v0, cp)*(dEdAngle/(r21*rp));
real4 force3 = cross(cp, v1)*(dEdAngle/(r23*rp));
real4 force2 = -force1-force3;

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
    {
    unsigned int offset = atom3+buffers.z*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force3.xyz;
    forceBuffers[offset] = force;
    }
}
energyBuffer[get_global_id(0)] += energy;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
