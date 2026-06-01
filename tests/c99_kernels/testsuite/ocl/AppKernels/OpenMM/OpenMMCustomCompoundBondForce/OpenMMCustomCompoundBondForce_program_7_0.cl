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
/**
 * Compute the difference between two vectors, setting the fourth component to the squared magnitude.
 */
real4 ccb_delta(real4 vec1, real4 vec2) {
    real4 result = (real4) (vec1.x-vec2.x, vec1.y-vec2.y, vec1.z-vec2.z, 0);
    result.w = result.x*result.x + result.y*result.y + result.z*result.z;
    return result;
}

/**
 * Compute the angle between two vectors.  The w component of each vector should contain the squared magnitude.
 */
real ccb_computeAngle(real4 vec1, real4 vec2) {
    real dotProduct = vec1.x*vec2.x + vec1.y*vec2.y + vec1.z*vec2.z;
    real cosine = dotProduct*RSQRT(vec1.w*vec2.w);
    real angle;
    if (cosine > 0.99f || cosine < -0.99f) {
        // We're close to the singularity in acos(), so take the cross product and use asin() instead.

        real4 crossProduct = cross(vec1, vec2);
        real scale = vec1.w*vec2.w;
        angle = asin(SQRT(dot(crossProduct, crossProduct)/scale));
        if (cosine < 0)
            angle = 3.14159265e+00f-angle;
    }
    else
       angle = acos(cosine);
    return angle;
}

/**
 * Compute the cross product of two vectors, setting the fourth component to the squared magnitude.
 */
real4 ccb_computeCross(real4 vec1, real4 vec2) {
    real4 result = cross(vec1, vec2);
    result.w = result.x*result.x + result.y*result.y + result.z*result.z;
    return result;
}
__kernel void computeBondedForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, int groups, __global const uint4* restrict atomIndices0, __global const uint4* restrict bufferIndices0, __global float4* customArg1, __global float2* customArg2) {
real energy = 0.0f;
if ((groups&1) != 0)
for (unsigned int index = get_global_id(0); index < 1; index += get_global_size(0)) {
    uint4 atoms = atomIndices0[index];
    uint4 buffers = bufferIndices0[index];
    unsigned int atom1 = atoms.x;
    real4 pos1 = posq[atom1];
    unsigned int atom2 = atoms.y;
    real4 pos2 = posq[atom2];
    unsigned int atom3 = atoms.z;
    real4 pos3 = posq[atom3];
    unsigned int atom4 = atoms.w;
    real4 pos4 = posq[atom4];
real4 deltaP1P2 = ccb_delta(pos1, pos2);
real r_P1P2 = sqrt(deltaP1P2.w);
real4 deltaP2P3 = ccb_delta(pos2, pos3);
real r_P2P3 = sqrt(deltaP2P3.w);
real4 deltaP3P2 = ccb_delta(pos3, pos2);
real4 deltaP3P4 = ccb_delta(pos3, pos4);
real angle_P2P3P4 = ccb_computeAngle(deltaP3P2, deltaP3P4);
real4 cross_P1P2_P3P2 = ccb_computeCross(deltaP1P2, deltaP3P2);
real4 cross_P3P2_P3P4 = ccb_computeCross(deltaP3P2, deltaP3P4);
real dihedral_P1P2P3P4 = ccb_computeAngle(cross_P1P2_P3P2, cross_P3P2_P3P4);
dihedral_P1P2P3P4 *= (deltaP1P2.x*cross_P3P2_P3P4.x + deltaP1P2.y*cross_P3P2_P3P4.y + deltaP1P2.z*cross_P3P2_P3P4.z < 0 ? -1 : 1);
float4 bondParams1 = customArg1[index];
float2 bondParams2 = customArg2[index];
real temp22 = 5.00000000e-01f*bondParams1.x;
real temp23 = r_P1P2-bondParams1.w;
real temp24 = temp23*temp23;
real temp25 = r_P2P3-bondParams1.w;
real temp26 = temp25*temp25;
real temp27 = temp24+temp26;
real temp28 = temp22*temp27;
real temp29 = 5.00000000e-01f*bondParams1.y;
real temp30 = angle_P2P3P4-bondParams2.x;
real temp31 = temp30*temp30;
real temp32 = temp29*temp31;
real temp33 = temp28+temp32;
real temp34 = dihedral_P1P2P3P4-bondParams2.y;
real temp35 = cos(temp34);
real temp36 = 1.00000000e+00f+temp35;
real temp37 = bondParams1.z*temp36;
real temp38 = temp33+temp37;
energy += temp38;
real temp39 = 2.00000000e+00f*temp30;
real temp40 = temp29*temp39;
real dEdAngle0 = temp40;
real temp41 = sin(temp34);
real temp42 = bondParams1.z*temp41;
real temp43 = -temp42;
real dEdDihedral0 = temp43;
real temp44 = 2.00000000e+00f*temp23;
real temp45 = temp22*temp44;
real dEdDistance0 = temp45;
real temp46 = 2.00000000e+00f*temp25;
real temp47 = temp22*temp46;
real dEdDistance1 = temp47;
real4 force1 = (real4) 0;
{
}
real4 force2 = (real4) 0;
{
}
real4 force3 = (real4) 0;
{
}
real4 force4 = (real4) 0;
{
}
force1.xyz += -(dEdDistance0/r_P1P2)*deltaP1P2.xyz;
force2.xyz += (dEdDistance0/r_P1P2)*deltaP1P2.xyz;
force2.xyz += -(dEdDistance1/r_P2P3)*deltaP2P3.xyz;
force3.xyz += (dEdDistance1/r_P2P3)*deltaP2P3.xyz;
{
real4 crossProd = cross(deltaP3P4, deltaP3P2);
real lengthCross = max(length(crossProd), (real) 1e-6f);
real4 deltaCross0 = -cross(deltaP3P2, crossProd)*dEdAngle0/(deltaP3P2.w*lengthCross);
real4 deltaCross2 = cross(deltaP3P4, crossProd)*dEdAngle0/(deltaP3P4.w*lengthCross);
real4 deltaCross1 = -(deltaCross0+deltaCross2);
force2.xyz += deltaCross0.xyz;
force3.xyz += deltaCross1.xyz;
force4.xyz += deltaCross2.xyz;
}
{
real r = SQRT(deltaP3P2.w);
real4 ff;
ff.x = (-dEdDihedral0*r)/cross_P1P2_P3P2.w;
ff.y = (deltaP1P2.x*deltaP3P2.x + deltaP1P2.y*deltaP3P2.y + deltaP1P2.z*deltaP3P2.z)/deltaP3P2.w;
ff.z = (deltaP3P4.x*deltaP3P2.x + deltaP3P4.y*deltaP3P2.y + deltaP3P4.z*deltaP3P2.z)/deltaP3P2.w;
ff.w = (dEdDihedral0*r)/cross_P3P2_P3P4.w;
real4 internalF0 = ff.x*cross_P1P2_P3P2;
real4 internalF3 = ff.w*cross_P3P2_P3P4;
real4 s = ff.y*internalF0 - ff.z*internalF3;
force1.xyz += internalF0.xyz;
force2.xyz += s.xyz-internalF0.xyz;
force3.xyz += -s.xyz-internalF3.xyz;
force4.xyz += internalF3.xyz;
}

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
    {
    unsigned int offset = atom4+buffers.w*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force4.xyz;
    forceBuffers[offset] = force;
    }
}
energyBuffer[get_global_id(0)] += energy;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
