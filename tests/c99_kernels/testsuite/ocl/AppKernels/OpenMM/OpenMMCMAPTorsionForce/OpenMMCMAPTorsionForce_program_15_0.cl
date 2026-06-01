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
__kernel void computeBondedForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, int groups, __global const uint8* restrict atomIndices0, __global const uint8* restrict bufferIndices0, __global float4* customArg1, __global int2* customArg2, __global int* customArg3) {
real energy = 0.0f;
if ((groups&1) != 0)
for (unsigned int index = get_global_id(0); index < 1; index += get_global_size(0)) {
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
    unsigned int atom6 = atoms.s5;
    real4 pos6 = posq[atom6];
    unsigned int atom7 = atoms.s6;
    real4 pos7 = posq[atom7];
    unsigned int atom8 = atoms.s7;
    real4 pos8 = posq[atom8];
const real PI = 3.14159265358979323846f;

// Compute the first angle.

real4 v0a = (real4) (pos1.xyz-pos2.xyz, 0.0f);
real4 v1a = (real4) (pos3.xyz-pos2.xyz, 0.0f);
real4 v2a = (real4) (pos3.xyz-pos4.xyz, 0.0f);
real4 cp0a = cross(v0a, v1a);
real4 cp1a = cross(v1a, v2a);
real cosangle = dot(normalize(cp0a), normalize(cp1a));
real angleA;
if (cosangle > 0.99f || cosangle < -0.99f) {
    // We're close to the singularity in acos(), so take the cross product and use asin() instead.

    real4 cross_prod = cross(cp0a, cp1a);
    real scale = dot(cp0a, cp0a)*dot(cp1a, cp1a);
    angleA = asin(SQRT(dot(cross_prod, cross_prod)/scale));
    if (cosangle < 0.0f)
        angleA = PI-angleA;
}
else
   angleA = acos(cosangle);
angleA = (dot(v0a, cp1a) >= 0 ? angleA : -angleA);
angleA = fmod(angleA+2.0f*PI, 2.0f*PI);

// Compute the second angle.

real4 v0b = (real4) (pos5.xyz-pos6.xyz, 0.0f);
real4 v1b = (real4) (pos7.xyz-pos6.xyz, 0.0f);
real4 v2b = (real4) (pos7.xyz-pos8.xyz, 0.0f);
real4 cp0b = cross(v0b, v1b);
real4 cp1b = cross(v1b, v2b);
cosangle = dot(normalize(cp0b), normalize(cp1b));
real angleB;
if (cosangle > 0.99f || cosangle < -0.99f) {
    // We're close to the singularity in acos(), so take the cross product and use asin() instead.

    real4 cross_prod = cross(cp0b, cp1b);
    real scale = dot(cp0b, cp0b)*dot(cp1b, cp1b);
    angleB = asin(SQRT(dot(cross_prod, cross_prod)/scale));
    if (cosangle < 0.0f)
        angleB = PI-angleB;
}
else
   angleB = acos(cosangle);
angleB = (dot(v0b, cp1b) >= 0 ? angleB : -angleB);
angleB = fmod(angleB+2.0f*PI, 2.0f*PI);

// Identify which patch this is in.

int2 pos = customArg2[customArg3[index]];
int size = pos.y;
real delta = 2*PI/size;
int s = (int) (angleA/delta);
int t = (int) (angleB/delta);
float4 c[4];
int coeffIndex = pos.x+4*(s+size*t);
c[0] = customArg1[coeffIndex];
c[1] = customArg1[coeffIndex+1];
c[2] = customArg1[coeffIndex+2];
c[3] = customArg1[coeffIndex+3];
real da = angleA/delta-s;
real db = angleB/delta-t;

// Evaluate the spline to determine the energy and gradients.

real torsionEnergy = 0.0f;
real dEdA = 0.0f;
real dEdB = 0.0f;
torsionEnergy = da*torsionEnergy + ((c[3].w*db + c[3].z)*db + c[3].y)*db + c[3].x;
dEdA = db*dEdA + (3.0f*c[3].w*da + 2.0f*c[2].w)*da + c[1].w;
dEdB = da*dEdB + (3.0f*c[3].w*db + 2.0f*c[3].z)*db + c[3].y;
torsionEnergy = da*torsionEnergy + ((c[2].w*db + c[2].z)*db + c[2].y)*db + c[2].x;
dEdA = db*dEdA + (3.0f*c[3].z*da + 2.0f*c[2].z)*da + c[1].z;
dEdB = da*dEdB + (3.0f*c[2].w*db + 2.0f*c[2].z)*db + c[2].y;
torsionEnergy = da*torsionEnergy + ((c[1].w*db + c[1].z)*db + c[1].y)*db + c[1].x;
dEdA = db*dEdA + (3.0f*c[3].y*da + 2.0f*c[2].y)*da + c[1].y;
dEdB = da*dEdB + (3.0f*c[1].w*db + 2.0f*c[1].z)*db + c[1].y;
torsionEnergy = da*torsionEnergy + ((c[0].w*db + c[0].z)*db + c[0].y)*db + c[0].x;
dEdA = db*dEdA + (3.0f*c[3].x*da + 2.0f*c[2].x)*da + c[1].x;
dEdB = da*dEdB + (3.0f*c[0].w*db + 2.0f*c[0].z)*db + c[0].y;
dEdA /= delta;
dEdB /= delta;
energy += torsionEnergy;

// Apply the force to the first torsion.

real normCross1 = dot(cp0a, cp0a);
real normSqrBC = dot(v1a, v1a);
real normBC = SQRT(normSqrBC);
real normCross2 = dot(cp1a, cp1a);
real dp = 1.0f/normSqrBC;
real4 ff = (real4) ((-dEdA*normBC)/normCross1, dot(v0a, v1a)*dp, dot(v2a, v1a)*dp, (dEdA*normBC)/normCross2);
real4 force1 = ff.x*cp0a;
real4 force4 = ff.w*cp1a;
real4 d = ff.y*force1 - ff.z*force4;
real4 force2 = d-force1;
real4 force3 = -d-force4;

// Apply the force to the second torsion.

normCross1 = dot(cp0b, cp0b);
normSqrBC = dot(v1b, v1b);
normBC = SQRT(normSqrBC);
normCross2 = dot(cp1b, cp1b);
dp = 1.0f/normSqrBC;
ff = (real4) ((-dEdB*normBC)/normCross1, dot(v0b, v1b)*dp, dot(v2b, v1b)*dp, (dEdB*normBC)/normCross2);
real4 force5 = ff.x*cp0b;
real4 force8 = ff.w*cp1b;
d = ff.y*force5 - ff.z*force8;
real4 force6 = d-force5;
real4 force7 = -d-force8;

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
    {
    unsigned int offset = atom6+buffers.s5*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force6.xyz;
    forceBuffers[offset] = force;
    }
    {
    unsigned int offset = atom7+buffers.s6*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force7.xyz;
    forceBuffers[offset] = force;
    }
    {
    unsigned int offset = atom8+buffers.s7*PADDED_NUM_ATOMS;
    real4 force = forceBuffers[offset];
    force.xyz += force8.xyz;
    forceBuffers[offset] = force;
    }
}
energyBuffer[get_global_id(0)] += energy;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
