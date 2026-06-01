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
__kernel void computeBondedForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, int groups, __global const uint4* restrict atomIndices0, __global const uint4* restrict bufferIndices0, __global float8* customArg1) {
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
const real PI = 3.14159265358979323846f;
real4 v0 = (real4) (pos1.xyz-pos2.xyz, 0.0f);
real4 v1 = (real4) (pos3.xyz-pos2.xyz, 0.0f);
real4 v2 = (real4) (pos3.xyz-pos4.xyz, 0.0f);
real4 cp0 = cross(v0, v1);
real4 cp1 = cross(v1, v2);
real cosangle = dot(normalize(cp0), normalize(cp1));
real theta;
if (cosangle > 0.99f || cosangle < -0.99f) {
    // We're close to the singularity in acos(), so take the cross product and use asin() instead.

    real4 cross_prod = cross(cp0, cp1);
    real scale = dot(cp0, cp0)*dot(cp1, cp1);
    theta = asin(SQRT(dot(cross_prod, cross_prod)/scale));
    if (cosangle < 0)
        theta = PI-theta;
}
else
   theta = acos(cosangle);
theta = (dot(v0, cp1) >= 0 ? theta : -theta);
float8 torsionParams = customArg1[index];
if (theta < 0.0f)
    theta += PI;
else
    theta -= PI;
cosangle = -cosangle;
real cosFactor = cosangle;
real dEdAngle = -torsionParams.s1;
real rbEnergy = torsionParams.s0;
rbEnergy += torsionParams.s1*cosFactor;
dEdAngle -= 2.0f*torsionParams.s2*cosFactor;
cosFactor *= cosangle;
dEdAngle -= 3.0f*torsionParams.s3*cosFactor;
rbEnergy += torsionParams.s2*cosFactor;
cosFactor *= cosangle;
dEdAngle -= 4.0f*torsionParams.s4*cosFactor;
rbEnergy += torsionParams.s3*cosFactor;
cosFactor *= cosangle;
dEdAngle -= 5.0f*torsionParams.s5*cosFactor;
rbEnergy += torsionParams.s4*cosFactor;
rbEnergy += torsionParams.s5*cosFactor*cosangle;
energy += rbEnergy;
dEdAngle *= sin(theta);

real normCross1 = dot(cp0, cp0);
real normSqrBC = dot(v1, v1);
real normBC = SQRT(normSqrBC);
real normCross2 = dot(cp1, cp1);
real dp = 1.0f/normSqrBC;
real4 ff = (real4) ((-dEdAngle*normBC)/normCross1, dot(v0, v1)*dp, dot(v2, v1)*dp, (dEdAngle*normBC)/normCross2);
real4 force1 = ff.x*cp0;
real4 force4 = ff.w*cp1;
real4 s = ff.y*force1 - ff.z*force4;
real4 force2 = s-force1;
real4 force3 = -s-force4;

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
