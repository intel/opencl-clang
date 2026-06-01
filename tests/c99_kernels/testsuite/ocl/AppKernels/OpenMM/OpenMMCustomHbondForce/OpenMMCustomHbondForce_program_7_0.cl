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
#define NUM_ACCEPTORS 1
#define NUM_DONORS 1
#define PADDED_NUM_ATOMS 32
#define PI 3.14159265e+00f

/**
 * Compute the difference between two vectors, setting the fourth component to the squared magnitude.
 */
real4 delta(real4 vec1, real4 vec2) {
    real4 result = (real4) (vec1.x-vec2.x, vec1.y-vec2.y, vec1.z-vec2.z, 0);
    result.w = result.x*result.x + result.y*result.y + result.z*result.z;
    return result;
}

/**
 * Compute the difference between two vectors, taking periodic boundary conditions into account
 * and setting the fourth component to the squared magnitude.
 */
real4 deltaPeriodic(real4 vec1, real4 vec2, real4 periodicBoxSize, real4 invPeriodicBoxSize, real4 periodicBoxVecX, real4 periodicBoxVecY, real4 periodicBoxVecZ) {
    real4 result = (real4) (vec1.x-vec2.x, vec1.y-vec2.y, vec1.z-vec2.z, 0);
#ifdef USE_PERIODIC
    APPLY_PERIODIC_TO_DELTA(result)
#endif
    result.w = result.x*result.x + result.y*result.y + result.z*result.z;
    return result;
}

/**
 * Compute the angle between two vectors.  The w component of each vector should contain the squared magnitude.
 */
real computeAngle(real4 vec1, real4 vec2) {
    real dotProduct = vec1.x*vec2.x + vec1.y*vec2.y + vec1.z*vec2.z;
    real cosine = dotProduct*RSQRT(vec1.w*vec2.w);
    real angle;
    if (cosine > 0.99f || cosine < -0.99f) {
        // We're close to the singularity in acos(), so take the cross product and use asin() instead.

        real4 crossProduct = cross(vec1, vec2);
        real scale = vec1.w*vec2.w;
        angle = asin(SQRT(dot(crossProduct, crossProduct)/scale));
        if (cosine < 0.0f)
            angle = PI-angle;
    }
    else
       angle = acos(cosine);
    return angle;
}

/**
 * Compute the cross product of two vectors, setting the fourth component to the squared magnitude.
 */
real4 computeCross(real4 vec1, real4 vec2) {
    real4 result = cross(vec1, vec2);
    result.w = result.x*result.x + result.y*result.y + result.z*result.z;
    return result;
}

/**
 * Compute forces on donors.
 */
__kernel void computeDonorForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, __global const int4* restrict exclusions,
        __global const int4* restrict donorAtoms, __global const int4* restrict acceptorAtoms, __global const int4* restrict donorBufferIndices, __local real4* posBuffer, real4 periodicBoxSize, real4 invPeriodicBoxSize,
        real4 periodicBoxVecX, real4 periodicBoxVecY, real4 periodicBoxVecZ
        , __global const float* restrict globals, __global const float4* restrict donorparam1, __global const float2* restrict acceptorparam1) {
    real energy = 0;
    real4 f1 = (real4) 0;
    real4 f2 = (real4) 0;
    real4 f3 = (real4) 0;
    for (int donorStart = 0; donorStart < NUM_DONORS; donorStart += get_global_size(0)) {
        // Load information about the donor this thread will compute forces on.

        int donorIndex = donorStart+get_global_id(0);
        int4 atoms, exclusionIndices;
        real4 d1, d2, d3;
        if (donorIndex < NUM_DONORS) {
            atoms = donorAtoms[donorIndex];
            d1 = (atoms.x > -1 ? posq[atoms.x] : (real4) 0);
            d2 = (atoms.y > -1 ? posq[atoms.y] : (real4) 0);
            d3 = (atoms.z > -1 ? posq[atoms.z] : (real4) 0);
#ifdef USE_EXCLUSIONS
            exclusionIndices = exclusions[donorIndex];
#endif
        }
        else
            atoms = (int4) (-1, -1, -1, -1);
        for (int acceptorStart = 0; acceptorStart < NUM_ACCEPTORS; acceptorStart += get_local_size(0)) {
            // Load the next block of acceptors into local memory.

            int blockSize = min((int) get_local_size(0), NUM_ACCEPTORS-acceptorStart);
            if (get_local_id(0) < blockSize) {
                int4 atoms2 = acceptorAtoms[acceptorStart+get_local_id(0)];
                posBuffer[3*get_local_id(0)] = (atoms2.x > -1 ? posq[atoms2.x] : (real4) 0);
                posBuffer[3*get_local_id(0)+1] = (atoms2.y > -1 ? posq[atoms2.y] : (real4) 0);
                posBuffer[3*get_local_id(0)+2] = (atoms2.z > -1 ? posq[atoms2.z] : (real4) 0);
            }
            barrier(CLK_LOCAL_MEM_FENCE);
            if (donorIndex < NUM_DONORS) {
                for (int index = 0; index < blockSize; index++) {
#ifdef USE_EXCLUSIONS
                    int acceptorIndex = acceptorStart+index;
                    if (acceptorIndex == exclusionIndices.x || acceptorIndex == exclusionIndices.y || acceptorIndex == exclusionIndices.z || acceptorIndex == exclusionIndices.w)
                        continue;
#endif
                    // Compute the interaction between a donor and an acceptor.

                    real4 a1 = posBuffer[3*index];
                    real4 a2 = posBuffer[3*index+1];
                    real4 a3 = posBuffer[3*index+2];
                    real4 deltaD1A1 = deltaPeriodic(d1, a1, periodicBoxSize, invPeriodicBoxSize, periodicBoxVecX, periodicBoxVecY, periodicBoxVecZ);
#ifdef USE_CUTOFF
                    if (deltaD1A1.w < CUTOFF_SQUARED) {
#endif
                        real r_D1A1 = SQRT(deltaD1A1.w);
real4 deltaD1D2 = delta(d1, d2);
real angle_A1D1D2 = computeAngle(deltaD1A1, deltaD1D2);
real4 deltaA1D1 = delta(a1, d1);
real4 deltaA1A2 = delta(a1, a2);
real angle_D1A1A2 = computeAngle(deltaA1D1, deltaA1A2);
real4 deltaA3A2 = delta(a3, a2);
real4 cross_A3A2_A1A2 = computeCross(deltaA3A2, deltaA1A2);
real4 cross_A1A2_A1D1 = computeCross(deltaA1A2, deltaA1D1);
real dihedral_A3A2A1D1 = computeAngle(cross_A3A2_A1A2, cross_A1A2_A1D1);
dihedral_A3A2A1D1 *= (deltaA3A2.x*cross_A1A2_A1D1.x + deltaA3A2.y*cross_A1A2_A1D1.y + deltaA3A2.z*cross_A1A2_A1D1.z < 0 ? -1 : 1);
float4 donorParams1 = donorparam1[index];
float2 acceptorParams1 = acceptorparam1[index];
real temp13 = 5.00000000e-01f*globals[0];
real temp14 = r_D1A1-donorParams1.x;
real temp15 = temp14*temp14;
real temp16 = temp13*temp15;
real temp17 = 5.00000000e-01f*globals[1];
real temp18 = angle_A1D1D2-donorParams1.y;
real temp19 = temp18*temp18;
real temp20 = temp17*temp19;
real temp21 = temp16+temp20;
real temp22 = 5.00000000e-01f*globals[2];
real temp23 = angle_D1A1A2-donorParams1.z;
real temp24 = temp23*temp23;
real temp25 = temp22*temp24;
real temp26 = temp21+temp25;
real temp27 = acceptorParams1.y*dihedral_A3A2A1D1;
real temp28 = temp27-acceptorParams1.x;
real temp29 = cos(temp28);
real temp30 = 1.00000000e+00f+temp29;
real temp31 = globals[3]*temp30;
real temp32 = temp26+temp31;
energy += temp32;
real temp33 = 2.00000000e+00f*temp18;
real temp34 = temp17*temp33;
real dEdAngle0 = temp34;
real temp35 = 2.00000000e+00f*temp23;
real temp36 = temp22*temp35;
real dEdAngle1 = temp36;
real temp37 = sin(temp28);
real temp38 = temp37*acceptorParams1.y;
real temp39 = globals[3]*temp38;
real temp40 = -temp39;
real dEdDihedral0 = temp40;
real temp41 = 2.00000000e+00f*temp14;
real temp42 = temp13*temp41;
real dEdDistance0 = temp42;
f1.xyz += -(dEdDistance0/r_D1A1)*deltaD1A1.xyz;
{
real4 crossProd = cross(deltaD1D2, deltaD1A1);
real lengthCross = max(length(crossProd), (real) 1e-6f);
real4 deltaCross0 = -cross(deltaD1A1, crossProd)*dEdAngle0/(deltaD1A1.w*lengthCross);
real4 deltaCross2 = cross(deltaD1D2, crossProd)*dEdAngle0/(deltaD1D2.w*lengthCross);
real4 deltaCross1 = -(deltaCross0+deltaCross2);
f1.xyz += deltaCross1.xyz;
f2.xyz += deltaCross2.xyz;
}
{
real4 crossProd = cross(deltaA1A2, deltaA1D1);
real lengthCross = max(length(crossProd), (real) 1e-6f);
real4 deltaCross0 = -cross(deltaA1D1, crossProd)*dEdAngle1/(deltaA1D1.w*lengthCross);
real4 deltaCross2 = cross(deltaA1A2, crossProd)*dEdAngle1/(deltaA1A2.w*lengthCross);
real4 deltaCross1 = -(deltaCross0+deltaCross2);
f1.xyz += deltaCross0.xyz;
}
{
real r = SQRT(deltaA1A2.w);
real4 ff;
ff.x = (-dEdDihedral0*r)/cross_A3A2_A1A2.w;
ff.y = (deltaA3A2.x*deltaA1A2.x + deltaA3A2.y*deltaA1A2.y + deltaA3A2.z*deltaA1A2.z)/deltaA1A2.w;
ff.z = (deltaA1D1.x*deltaA1A2.x + deltaA1D1.y*deltaA1A2.y + deltaA1D1.z*deltaA1A2.z)/deltaA1A2.w;
ff.w = (dEdDihedral0*r)/cross_A1A2_A1D1.w;
real4 internalF0 = ff.x*cross_A3A2_A1A2;
real4 internalF3 = ff.w*cross_A1A2_A1D1;
real4 s = ff.y*internalF0 - ff.z*internalF3;
f1.xyz += internalF3.xyz;
}

#ifdef USE_CUTOFF
                    }
#endif
                }
            }
        }

        // Write results

        if (donorIndex < NUM_DONORS) {
            int4 bufferIndices = donorBufferIndices[donorIndex];
            if (atoms.x > -1) {
                unsigned int offset = atoms.x+bufferIndices.x*PADDED_NUM_ATOMS;
                real4 force = forceBuffers[offset];
                force.xyz += f1.xyz;
                forceBuffers[offset] = force;
            }
            if (atoms.y > -1) {
                unsigned int offset = atoms.y+bufferIndices.y*PADDED_NUM_ATOMS;
                real4 force = forceBuffers[offset];
                force.xyz += f2.xyz;
                forceBuffers[offset] = force;
            }
            if (atoms.z > -1) {
                unsigned int offset = atoms.z+bufferIndices.z*PADDED_NUM_ATOMS;
                real4 force = forceBuffers[offset];
                force.xyz += f3.xyz;
                forceBuffers[offset] = force;
            }
        }
    }
    energyBuffer[get_global_id(0)] += energy;
}
/**
 * Compute forces on acceptors.
 */
__kernel void computeAcceptorForces(__global real4* restrict forceBuffers, __global real* restrict energyBuffer, __global const real4* restrict posq, __global const int4* restrict exclusions,
        __global const int4* restrict donorAtoms, __global const int4* restrict acceptorAtoms, __global const int4* restrict acceptorBufferIndices, __local real4* restrict posBuffer, real4 periodicBoxSize, real4 invPeriodicBoxSize,
        real4 periodicBoxVecX, real4 periodicBoxVecY, real4 periodicBoxVecZ
        , __global const float* restrict globals, __global const float4* restrict donorparam1, __global const float2* restrict acceptorparam1) {
    real4 f1 = (real4) 0;
    real4 f2 = (real4) 0;
    real4 f3 = (real4) 0;
    for (int acceptorStart = 0; acceptorStart < NUM_ACCEPTORS; acceptorStart += get_global_size(0)) {
        // Load information about the acceptor this thread will compute forces on.

        int acceptorIndex = acceptorStart+get_global_id(0);
        int4 atoms, exclusionIndices;
        real4 a1, a2, a3;
        if (acceptorIndex < NUM_ACCEPTORS) {
            atoms = acceptorAtoms[acceptorIndex];
            a1 = (atoms.x > -1 ? posq[atoms.x] : (real4) 0);
            a2 = (atoms.y > -1 ? posq[atoms.y] : (real4) 0);
            a3 = (atoms.z > -1 ? posq[atoms.z] : (real4) 0);
#ifdef USE_EXCLUSIONS
            exclusionIndices = exclusions[acceptorIndex];
#endif
        }
        else
            atoms = (int4) (-1, -1, -1, -1);
        for (int donorStart = 0; donorStart < NUM_DONORS; donorStart += get_local_size(0)) {
            // Load the next block of donors into local memory.

            int blockSize = min((int) get_local_size(0), NUM_DONORS-donorStart);
            if (get_local_id(0) < blockSize) {
                int4 atoms2 = donorAtoms[donorStart+get_local_id(0)];
                posBuffer[3*get_local_id(0)] = (atoms2.x > -1 ? posq[atoms2.x] : (real4) 0);
                posBuffer[3*get_local_id(0)+1] = (atoms2.y > -1 ? posq[atoms2.y] : (real4) 0);
                posBuffer[3*get_local_id(0)+2] = (atoms2.z > -1 ? posq[atoms2.z] : (real4) 0);
            }
            barrier(CLK_LOCAL_MEM_FENCE);
            if (acceptorIndex < NUM_ACCEPTORS) {
                for (int index = 0; index < blockSize; index++) {
#ifdef USE_EXCLUSIONS
                    int donorIndex = donorStart+index;
                    if (donorIndex == exclusionIndices.x || donorIndex == exclusionIndices.y || donorIndex == exclusionIndices.z || donorIndex == exclusionIndices.w)
                        continue;
#endif
                    // Compute the interaction between a donor and an acceptor.

                    real4 d1 = posBuffer[3*index];
                    real4 d2 = posBuffer[3*index+1];
                    real4 d3 = posBuffer[3*index+2];
                    real4 deltaD1A1 = deltaPeriodic(d1, a1, periodicBoxSize, invPeriodicBoxSize, periodicBoxVecX, periodicBoxVecY, periodicBoxVecZ);
#ifdef USE_CUTOFF
                    if (deltaD1A1.w < CUTOFF_SQUARED) {
#endif
                        real r_D1A1 = SQRT(deltaD1A1.w);
real4 deltaD1D2 = delta(d1, d2);
real angle_A1D1D2 = computeAngle(deltaD1A1, deltaD1D2);
real4 deltaA1D1 = delta(a1, d1);
real4 deltaA1A2 = delta(a1, a2);
real angle_D1A1A2 = computeAngle(deltaA1D1, deltaA1A2);
real4 deltaA3A2 = delta(a3, a2);
real4 cross_A3A2_A1A2 = computeCross(deltaA3A2, deltaA1A2);
real4 cross_A1A2_A1D1 = computeCross(deltaA1A2, deltaA1D1);
real dihedral_A3A2A1D1 = computeAngle(cross_A3A2_A1A2, cross_A1A2_A1D1);
dihedral_A3A2A1D1 *= (deltaA3A2.x*cross_A1A2_A1D1.x + deltaA3A2.y*cross_A1A2_A1D1.y + deltaA3A2.z*cross_A1A2_A1D1.z < 0 ? -1 : 1);
float4 donorParams1 = donorparam1[index];
float2 acceptorParams1 = acceptorparam1[index];
real temp13 = 5.00000000e-01f*globals[1];
real temp14 = angle_A1D1D2-donorParams1.y;
real temp15 = 2.00000000e+00f*temp14;
real temp16 = temp13*temp15;
real dEdAngle0 = temp16;
real temp17 = 5.00000000e-01f*globals[2];
real temp18 = angle_D1A1A2-donorParams1.z;
real temp19 = 2.00000000e+00f*temp18;
real temp20 = temp17*temp19;
real dEdAngle1 = temp20;
real temp21 = acceptorParams1.y*dihedral_A3A2A1D1;
real temp22 = temp21-acceptorParams1.x;
real temp23 = sin(temp22);
real temp24 = temp23*acceptorParams1.y;
real temp25 = globals[3]*temp24;
real temp26 = -temp25;
real dEdDihedral0 = temp26;
real temp27 = 5.00000000e-01f*globals[0];
real temp28 = r_D1A1-donorParams1.x;
real temp29 = 2.00000000e+00f*temp28;
real temp30 = temp27*temp29;
real dEdDistance0 = temp30;
f1.xyz += (dEdDistance0/r_D1A1)*deltaD1A1.xyz;
{
real4 crossProd = cross(deltaD1D2, deltaD1A1);
real lengthCross = max(length(crossProd), (real) 1e-6f);
real4 deltaCross0 = -cross(deltaD1A1, crossProd)*dEdAngle0/(deltaD1A1.w*lengthCross);
real4 deltaCross2 = cross(deltaD1D2, crossProd)*dEdAngle0/(deltaD1D2.w*lengthCross);
real4 deltaCross1 = -(deltaCross0+deltaCross2);
f1.xyz += deltaCross0.xyz;
}
{
real4 crossProd = cross(deltaA1A2, deltaA1D1);
real lengthCross = max(length(crossProd), (real) 1e-6f);
real4 deltaCross0 = -cross(deltaA1D1, crossProd)*dEdAngle1/(deltaA1D1.w*lengthCross);
real4 deltaCross2 = cross(deltaA1A2, crossProd)*dEdAngle1/(deltaA1A2.w*lengthCross);
real4 deltaCross1 = -(deltaCross0+deltaCross2);
f1.xyz += deltaCross1.xyz;
f2.xyz += deltaCross2.xyz;
}
{
real r = SQRT(deltaA1A2.w);
real4 ff;
ff.x = (-dEdDihedral0*r)/cross_A3A2_A1A2.w;
ff.y = (deltaA3A2.x*deltaA1A2.x + deltaA3A2.y*deltaA1A2.y + deltaA3A2.z*deltaA1A2.z)/deltaA1A2.w;
ff.z = (deltaA1D1.x*deltaA1A2.x + deltaA1D1.y*deltaA1A2.y + deltaA1D1.z*deltaA1A2.z)/deltaA1A2.w;
ff.w = (dEdDihedral0*r)/cross_A1A2_A1D1.w;
real4 internalF0 = ff.x*cross_A3A2_A1A2;
real4 internalF3 = ff.w*cross_A1A2_A1D1;
real4 s = ff.y*internalF0 - ff.z*internalF3;
f3.xyz += internalF0.xyz;
f2.xyz += s.xyz-internalF0.xyz;
f1.xyz += -s.xyz-internalF3.xyz;
}

#ifdef USE_CUTOFF
                    }
#endif
                }
            }
        }

        // Write results

        if (acceptorIndex < NUM_ACCEPTORS) {
            int4 bufferIndices = acceptorBufferIndices[acceptorIndex];
            if (atoms.x > -1) {
                unsigned int offset = atoms.x+bufferIndices.x*PADDED_NUM_ATOMS;
                real4 force = forceBuffers[offset];
                force.xyz += f1.xyz;
                forceBuffers[offset] = force;
            }
            if (atoms.y > -1) {
                unsigned int offset = atoms.y+bufferIndices.y*PADDED_NUM_ATOMS;
                real4 force = forceBuffers[offset];
                force.xyz += f2.xyz;
                forceBuffers[offset] = force;
            }
            if (atoms.z > -1) {
                unsigned int offset = atoms.z+bufferIndices.z*PADDED_NUM_ATOMS;
                real4 force = forceBuffers[offset];
                force.xyz += f3.xyz;
                forceBuffers[offset] = force;
            }
        }
    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
