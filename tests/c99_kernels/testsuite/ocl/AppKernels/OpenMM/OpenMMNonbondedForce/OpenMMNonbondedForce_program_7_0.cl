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
#define CUTOFF 1.00000000e+00f
#define CUTOFF_SQUARED 1.00000000e+00f
#define FIRST_EXCLUSION_TILE 0
#define FORCE_WORK_GROUP_SIZE 32
#define LAST_EXCLUSION_TILE 1
#define NUM_ATOMS 2
#define NUM_BLOCKS 1
#define NUM_TILES_WITH_EXCLUSIONS 1
#define PADDED_NUM_ATOMS 32
#define PARAMETER_SIZE_IS_EVEN 1
#define TILE_SIZE 32
#define USE_EXCLUSIONS 1
#define USE_SYMMETRIC 1

#ifdef SUPPORTS_64_BIT_ATOMICS
#pragma OPENCL EXTENSION cl_khr_int64_base_atomics : enable
#endif
#define WARPS_PER_GROUP (FORCE_WORK_GROUP_SIZE/TILE_SIZE)

typedef struct {
    real x, y, z;
    real q;
    real fx, fy, fz;

#ifndef PARAMETER_SIZE_IS_EVEN
    real padding;
#endif
} AtomData;

/**
 * Compute nonbonded interactions.
 */
__kernel void computeNonbonded(
#ifdef SUPPORTS_64_BIT_ATOMICS
        __global long* restrict forceBuffers,
#else
        __global real4* restrict forceBuffers,
#endif
        __global real* restrict energyBuffer, __global const real4* restrict posq, __global const unsigned int* restrict exclusions,
        __global const ushort2* restrict exclusionTiles, unsigned int startTileIndex, unsigned int numTileIndices
#ifdef USE_CUTOFF
        , __global const int* restrict tiles, __global const unsigned int* restrict interactionCount, real4 periodicBoxSize, real4 invPeriodicBoxSize,
        real4 periodicBoxVecX, real4 periodicBoxVecY, real4 periodicBoxVecZ, unsigned int maxTiles, __global const real4* restrict blockCenter,
        __global const real4* restrict blockSize, __global const int* restrict interactingAtoms
#endif
        ) {
    const unsigned int totalWarps = get_global_size(0)/TILE_SIZE;
    const unsigned int warp = get_global_id(0)/TILE_SIZE;
    const unsigned int tgx = get_local_id(0) & (TILE_SIZE-1);
    const unsigned int tbx = get_local_id(0) - tgx;
    real energy = 0;
    __local AtomData localData[FORCE_WORK_GROUP_SIZE];

    // First loop: process tiles that contain exclusions.

    const unsigned int firstExclusionTile = FIRST_EXCLUSION_TILE+warp*(LAST_EXCLUSION_TILE-FIRST_EXCLUSION_TILE)/totalWarps;
    const unsigned int lastExclusionTile = FIRST_EXCLUSION_TILE+(warp+1)*(LAST_EXCLUSION_TILE-FIRST_EXCLUSION_TILE)/totalWarps;
    for (int pos = firstExclusionTile; pos < lastExclusionTile; pos++) {
        const ushort2 tileIndices = exclusionTiles[pos];
        const unsigned int x = tileIndices.x;
        const unsigned int y = tileIndices.y;
        real4 force = 0;
        unsigned int atom1 = x*TILE_SIZE + tgx;
        real4 posq1 = posq[atom1];

#ifdef USE_EXCLUSIONS
        unsigned int excl = exclusions[pos*TILE_SIZE+tgx];
#endif
        const bool hasExclusions = true;
        if (x == y) {
            // This tile is on the diagonal.

            const unsigned int localAtomIndex = get_local_id(0);
            localData[localAtomIndex].x = posq1.x;
            localData[localAtomIndex].y = posq1.y;
            localData[localAtomIndex].z = posq1.z;
            localData[localAtomIndex].q = posq1.w;

            SYNC_WARPS;
            for (unsigned int j = 0; j < TILE_SIZE; j++) {
                int atom2 = tbx+j;
                real4 posq2 = (real4) (localData[atom2].x, localData[atom2].y, localData[atom2].z, localData[atom2].q);
                real4 delta = (real4) (posq2.xyz - posq1.xyz, 0);
#ifdef USE_PERIODIC
                APPLY_PERIODIC_TO_DELTA(delta)
#endif
                real r2 = delta.x*delta.x + delta.y*delta.y + delta.z*delta.z;
                real invR = RSQRT(r2);
                real r = r2*invR;

                atom2 = y*TILE_SIZE+j;
#ifdef USE_SYMMETRIC
                real dEdR = 0;
#else
                real4 dEdR1 = (real4) 0;
                real4 dEdR2 = (real4) 0;
#endif
#ifdef USE_EXCLUSIONS
                bool isExcluded = (atom1 >= NUM_ATOMS || atom2 >= NUM_ATOMS || !(excl & 0x1));
#endif
                real tempEnergy = 0;
                {
#ifdef USE_DOUBLE_PRECISION
    unsigned long includeInteraction;
#else
    unsigned int includeInteraction;
#endif
#if USE_EWALD
    bool needCorrection = hasExclusions && isExcluded && atom1 != atom2 && atom1 < NUM_ATOMS && atom2 < NUM_ATOMS;
    includeInteraction = ((!isExcluded && r2 < CUTOFF_SQUARED) || needCorrection);
    const real alphaR = EWALD_ALPHA*r;
    const real expAlphaRSqr = EXP(-alphaR*alphaR);
    const real prefactor = 138.935456f*posq1.w*posq2.w*invR;

#ifdef USE_DOUBLE_PRECISION
    const real erfcAlphaR = erfc(alphaR);
#else
    // This approximation for erfc is from Abramowitz and Stegun (1964) p. 299.  They cite the following as
    // the original source: C. Hastings, Jr., Approximations for Digital Computers (1955).  It has a maximum
    // error of 1.5e-7.

    const real t = RECIP(1.0f+0.3275911f*alphaR);
    const real erfcAlphaR = (0.254829592f+(-0.284496736f+(1.421413741f+(-1.453152027f+1.061405429f*t)*t)*t)*t)*t*expAlphaRSqr;
#endif
    real tempForce = 0;
    if (needCorrection) {
        // Subtract off the part of this interaction that was included in the reciprocal space contribution.

        if (1-erfcAlphaR > 1e-6) {
            real erfAlphaR = erf(alphaR); // Our erfc approximation is not accurate enough when r is very small, which happens with Drude particles.
            tempForce = -prefactor*(erfAlphaR-alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
            tempEnergy += -prefactor*erfAlphaR;
        }
    }
    else {
#if 0
        real sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
        real sig2 = invR*sig;
        sig2 *= sig2;
        real sig6 = sig2*sig2*sig2;
        real epssig6 = sig6*(sigmaEpsilon1.y*sigmaEpsilon2.y);
        tempForce = epssig6*(12.0f*sig6 - 6.0f);
        real ljEnergy = epssig6*(sig6 - 1.0f);
        #if 0
        if (r > LJ_SWITCH_CUTOFF) {
            real x = r-LJ_SWITCH_CUTOFF;
            real switchValue = 1+x*x*x*(LJ_SWITCH_C3+x*(LJ_SWITCH_C4+x*LJ_SWITCH_C5));
            real switchDeriv = x*x*(3*LJ_SWITCH_C3+x*(4*LJ_SWITCH_C4+x*5*LJ_SWITCH_C5));
            tempForce = tempForce*switchValue - ljEnergy*switchDeriv*r;
            ljEnergy *= switchValue;
        }
        #endif
        tempForce += prefactor*(erfcAlphaR+alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
        tempEnergy += select((real) 0, ljEnergy + prefactor*erfcAlphaR, includeInteraction);
#else
        tempForce = prefactor*(erfcAlphaR+alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
        tempEnergy += select((real) 0, prefactor*erfcAlphaR, includeInteraction);
#endif
    }
    dEdR += select((real) 0, tempForce*invR*invR, includeInteraction);
#else
#ifdef USE_CUTOFF
    includeInteraction = (!isExcluded && r2 < CUTOFF_SQUARED);
#else
    includeInteraction = (!isExcluded);
#endif
    real tempForce = 0;
  #if 0
    real sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
    real sig2 = invR*sig;
    sig2 *= sig2;
    real sig6 = sig2*sig2*sig2;
    real epssig6 = sig6*(sigmaEpsilon1.y*sigmaEpsilon2.y);
    tempForce = epssig6*(12.0f*sig6 - 6.0f);
    real ljEnergy = epssig6*(sig6-1);
    #if 0
    if (r > LJ_SWITCH_CUTOFF) {
        real x = r-LJ_SWITCH_CUTOFF;
        real switchValue = 1+x*x*x*(LJ_SWITCH_C3+x*(LJ_SWITCH_C4+x*LJ_SWITCH_C5));
        real switchDeriv = x*x*(3*LJ_SWITCH_C3+x*(4*LJ_SWITCH_C4+x*5*LJ_SWITCH_C5));
        tempForce = tempForce*switchValue - ljEnergy*switchDeriv*r;
        ljEnergy *= switchValue;
    }
    #endif
    ljEnergy = select((real) 0, ljEnergy, includeInteraction);
    tempEnergy += ljEnergy;
  #endif
#if 1
  #ifdef USE_CUTOFF
    const real prefactor = 138.935456f*posq1.w*posq2.w;
    tempForce += prefactor*(invR - 2.0f*REACTION_FIELD_K*r2);
    tempEnergy += select((real) 0, prefactor*(invR + REACTION_FIELD_K*r2 - REACTION_FIELD_C), includeInteraction);
  #else
    const real prefactor = 138.935456f*posq1.w*posq2.w*invR;
    tempForce += prefactor;
    tempEnergy += select((real) 0, prefactor, includeInteraction);
  #endif
#endif
    dEdR += select((real) 0, tempForce*invR*invR, includeInteraction);
#endif
}


                energy += 0.5f*tempEnergy;
#ifdef USE_SYMMETRIC
                force.xyz -= delta.xyz*dEdR;
#else
                force.xyz -= dEdR1.xyz;
#endif
#ifdef USE_EXCLUSIONS
                excl >>= 1;
#endif
                SYNC_WARPS;
            }
        }
        else {
            // This is an off-diagonal tile.

            const unsigned int localAtomIndex = get_local_id(0);
            unsigned int j = y*TILE_SIZE + tgx;
            real4 tempPosq = posq[j];
            localData[localAtomIndex].x = tempPosq.x;
            localData[localAtomIndex].y = tempPosq.y;
            localData[localAtomIndex].z = tempPosq.z;
            localData[localAtomIndex].q = tempPosq.w;

            localData[localAtomIndex].fx = 0;
            localData[localAtomIndex].fy = 0;
            localData[localAtomIndex].fz = 0;
            SYNC_WARPS;
#ifdef USE_EXCLUSIONS
            excl = (excl >> tgx) | (excl << (TILE_SIZE - tgx));
#endif
            unsigned int tj = tgx;
            for (j = 0; j < TILE_SIZE; j++) {
                int atom2 = tbx+tj;
                real4 posq2 = (real4) (localData[atom2].x, localData[atom2].y, localData[atom2].z, localData[atom2].q);
                real4 delta = (real4) (posq2.xyz - posq1.xyz, 0);
#ifdef USE_PERIODIC
                APPLY_PERIODIC_TO_DELTA(delta)
#endif
                real r2 = delta.x*delta.x + delta.y*delta.y + delta.z*delta.z;
#ifdef PRUNE_BY_CUTOFF
                if (r2 < CUTOFF_SQUARED) {
#endif
                    real invR = RSQRT(r2);
                    real r = r2*invR;

                    atom2 = y*TILE_SIZE+tj;
#ifdef USE_SYMMETRIC
                    real dEdR = 0;
#else
                    real4 dEdR1 = (real4) 0;
                    real4 dEdR2 = (real4) 0;
#endif
#ifdef USE_EXCLUSIONS
                    bool isExcluded = (atom1 >= NUM_ATOMS || atom2 >= NUM_ATOMS || !(excl & 0x1));
#endif
                    real tempEnergy = 0;
                    {
#ifdef USE_DOUBLE_PRECISION
    unsigned long includeInteraction;
#else
    unsigned int includeInteraction;
#endif
#if USE_EWALD
    bool needCorrection = hasExclusions && isExcluded && atom1 != atom2 && atom1 < NUM_ATOMS && atom2 < NUM_ATOMS;
    includeInteraction = ((!isExcluded && r2 < CUTOFF_SQUARED) || needCorrection);
    const real alphaR = EWALD_ALPHA*r;
    const real expAlphaRSqr = EXP(-alphaR*alphaR);
    const real prefactor = 138.935456f*posq1.w*posq2.w*invR;

#ifdef USE_DOUBLE_PRECISION
    const real erfcAlphaR = erfc(alphaR);
#else
    // This approximation for erfc is from Abramowitz and Stegun (1964) p. 299.  They cite the following as
    // the original source: C. Hastings, Jr., Approximations for Digital Computers (1955).  It has a maximum
    // error of 1.5e-7.

    const real t = RECIP(1.0f+0.3275911f*alphaR);
    const real erfcAlphaR = (0.254829592f+(-0.284496736f+(1.421413741f+(-1.453152027f+1.061405429f*t)*t)*t)*t)*t*expAlphaRSqr;
#endif
    real tempForce = 0;
    if (needCorrection) {
        // Subtract off the part of this interaction that was included in the reciprocal space contribution.

        if (1-erfcAlphaR > 1e-6) {
            real erfAlphaR = erf(alphaR); // Our erfc approximation is not accurate enough when r is very small, which happens with Drude particles.
            tempForce = -prefactor*(erfAlphaR-alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
            tempEnergy += -prefactor*erfAlphaR;
        }
    }
    else {
#if 0
        real sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
        real sig2 = invR*sig;
        sig2 *= sig2;
        real sig6 = sig2*sig2*sig2;
        real epssig6 = sig6*(sigmaEpsilon1.y*sigmaEpsilon2.y);
        tempForce = epssig6*(12.0f*sig6 - 6.0f);
        real ljEnergy = epssig6*(sig6 - 1.0f);
        #if 0
        if (r > LJ_SWITCH_CUTOFF) {
            real x = r-LJ_SWITCH_CUTOFF;
            real switchValue = 1+x*x*x*(LJ_SWITCH_C3+x*(LJ_SWITCH_C4+x*LJ_SWITCH_C5));
            real switchDeriv = x*x*(3*LJ_SWITCH_C3+x*(4*LJ_SWITCH_C4+x*5*LJ_SWITCH_C5));
            tempForce = tempForce*switchValue - ljEnergy*switchDeriv*r;
            ljEnergy *= switchValue;
        }
        #endif
        tempForce += prefactor*(erfcAlphaR+alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
        tempEnergy += select((real) 0, ljEnergy + prefactor*erfcAlphaR, includeInteraction);
#else
        tempForce = prefactor*(erfcAlphaR+alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
        tempEnergy += select((real) 0, prefactor*erfcAlphaR, includeInteraction);
#endif
    }
    dEdR += select((real) 0, tempForce*invR*invR, includeInteraction);
#else
#ifdef USE_CUTOFF
    includeInteraction = (!isExcluded && r2 < CUTOFF_SQUARED);
#else
    includeInteraction = (!isExcluded);
#endif
    real tempForce = 0;
  #if 0
    real sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
    real sig2 = invR*sig;
    sig2 *= sig2;
    real sig6 = sig2*sig2*sig2;
    real epssig6 = sig6*(sigmaEpsilon1.y*sigmaEpsilon2.y);
    tempForce = epssig6*(12.0f*sig6 - 6.0f);
    real ljEnergy = epssig6*(sig6-1);
    #if 0
    if (r > LJ_SWITCH_CUTOFF) {
        real x = r-LJ_SWITCH_CUTOFF;
        real switchValue = 1+x*x*x*(LJ_SWITCH_C3+x*(LJ_SWITCH_C4+x*LJ_SWITCH_C5));
        real switchDeriv = x*x*(3*LJ_SWITCH_C3+x*(4*LJ_SWITCH_C4+x*5*LJ_SWITCH_C5));
        tempForce = tempForce*switchValue - ljEnergy*switchDeriv*r;
        ljEnergy *= switchValue;
    }
    #endif
    ljEnergy = select((real) 0, ljEnergy, includeInteraction);
    tempEnergy += ljEnergy;
  #endif
#if 1
  #ifdef USE_CUTOFF
    const real prefactor = 138.935456f*posq1.w*posq2.w;
    tempForce += prefactor*(invR - 2.0f*REACTION_FIELD_K*r2);
    tempEnergy += select((real) 0, prefactor*(invR + REACTION_FIELD_K*r2 - REACTION_FIELD_C), includeInteraction);
  #else
    const real prefactor = 138.935456f*posq1.w*posq2.w*invR;
    tempForce += prefactor;
    tempEnergy += select((real) 0, prefactor, includeInteraction);
  #endif
#endif
    dEdR += select((real) 0, tempForce*invR*invR, includeInteraction);
#endif
}


                    energy += tempEnergy;
#ifdef USE_SYMMETRIC
                    delta.xyz *= dEdR;
                    force.xyz -= delta.xyz;
                    localData[tbx+tj].fx += delta.x;
                    localData[tbx+tj].fy += delta.y;
                    localData[tbx+tj].fz += delta.z;
#else
                    force.xyz -= dEdR1.xyz;
                    localData[tbx+tj].fx += dEdR2.x;
                    localData[tbx+tj].fy += dEdR2.y;
                    localData[tbx+tj].fz += dEdR2.z;
#endif
#ifdef PRUNE_BY_CUTOFF
                }
#endif
#ifdef USE_EXCLUSIONS
                excl >>= 1;
#endif
                tj = (tj + 1) & (TILE_SIZE - 1);
                SYNC_WARPS;
            }
        }

        // Write results.

#ifdef SUPPORTS_64_BIT_ATOMICS
        unsigned int offset = x*TILE_SIZE + tgx;
        atom_add(&forceBuffers[offset], (long) (force.x*0x100000000));
        atom_add(&forceBuffers[offset+PADDED_NUM_ATOMS], (long) (force.y*0x100000000));
        atom_add(&forceBuffers[offset+2*PADDED_NUM_ATOMS], (long) (force.z*0x100000000));
        if (x != y) {
            offset = y*TILE_SIZE + tgx;
            atom_add(&forceBuffers[offset], (long) (localData[get_local_id(0)].fx*0x100000000));
            atom_add(&forceBuffers[offset+PADDED_NUM_ATOMS], (long) (localData[get_local_id(0)].fy*0x100000000));
            atom_add(&forceBuffers[offset+2*PADDED_NUM_ATOMS], (long) (localData[get_local_id(0)].fz*0x100000000));
        }
#else
        unsigned int offset1 = x*TILE_SIZE + tgx + warp*PADDED_NUM_ATOMS;
        unsigned int offset2 = y*TILE_SIZE + tgx + warp*PADDED_NUM_ATOMS;
        forceBuffers[offset1].xyz += force.xyz;
        if (x != y)
            forceBuffers[offset2] += (real4) (localData[get_local_id(0)].fx, localData[get_local_id(0)].fy, localData[get_local_id(0)].fz, 0.0f);
#endif
    }

    // Second loop: tiles without exclusions, either from the neighbor list (with cutoff) or just enumerating all
    // of them (no cutoff).

#ifdef USE_CUTOFF
    unsigned int numTiles = interactionCount[0];
    int pos = (int) (numTiles > maxTiles ? startTileIndex+warp*(long)numTileIndices/totalWarps : warp*(long)numTiles/totalWarps);
    int end = (int) (numTiles > maxTiles ? startTileIndex+(warp+1)*(long)numTileIndices/totalWarps : (warp+1)*(long)numTiles/totalWarps);
#else
    const unsigned int numTiles = numTileIndices;
    int pos = (int) (startTileIndex+warp*(long)numTiles/totalWarps);
    int end = (int) (startTileIndex+(warp+1)*(long)numTiles/totalWarps);
#endif
    int skipBase = 0;
    int currentSkipIndex = tbx;
    __local int atomIndices[FORCE_WORK_GROUP_SIZE];
    __local volatile int skipTiles[FORCE_WORK_GROUP_SIZE];
    skipTiles[get_local_id(0)] = -1;

    while (pos < end) {
        const bool hasExclusions = false;
        real4 force = 0;
        bool includeTile = true;

        // Extract the coordinates of this tile.

        int x, y;
        bool singlePeriodicCopy = false;
#ifdef USE_CUTOFF
        if (numTiles <= maxTiles) {
            x = tiles[pos];
            real4 blockSizeX = blockSize[x];
            singlePeriodicCopy = (0.5f*periodicBoxSize.x-blockSizeX.x >= CUTOFF &&
                                  0.5f*periodicBoxSize.y-blockSizeX.y >= CUTOFF &&
                                  0.5f*periodicBoxSize.z-blockSizeX.z >= CUTOFF);
        }
        else
#endif
        {
            y = (int) floor(NUM_BLOCKS+0.5f-SQRT((NUM_BLOCKS+0.5f)*(NUM_BLOCKS+0.5f)-2*pos));
            x = (pos-y*NUM_BLOCKS+y*(y+1)/2);
            if (x < y || x >= NUM_BLOCKS) { // Occasionally happens due to roundoff error.
                y += (x < y ? -1 : 1);
                x = (pos-y*NUM_BLOCKS+y*(y+1)/2);
            }

            // Skip over tiles that have exclusions, since they were already processed.

            SYNC_WARPS;
            while (skipTiles[tbx+TILE_SIZE-1] < pos) {
                SYNC_WARPS;
                if (skipBase+tgx < NUM_TILES_WITH_EXCLUSIONS) {
                    ushort2 tile = exclusionTiles[skipBase+tgx];
                    skipTiles[get_local_id(0)] = tile.x + tile.y*NUM_BLOCKS - tile.y*(tile.y+1)/2;
                }
                else
                    skipTiles[get_local_id(0)] = end;
                skipBase += TILE_SIZE;
                currentSkipIndex = tbx;
                SYNC_WARPS;
            }
            while (skipTiles[currentSkipIndex] < pos)
                currentSkipIndex++;
            includeTile = (skipTiles[currentSkipIndex] != pos);
        }
        if (includeTile) {
            unsigned int atom1 = x*TILE_SIZE + tgx;

            // Load atom data for this tile.

            real4 posq1 = posq[atom1];

            const unsigned int localAtomIndex = get_local_id(0);
#ifdef USE_CUTOFF
            unsigned int j = (numTiles <= maxTiles ? interactingAtoms[pos*TILE_SIZE+tgx] : y*TILE_SIZE + tgx);
#else
            unsigned int j = y*TILE_SIZE + tgx;
#endif
            atomIndices[get_local_id(0)] = j;
            if (j < PADDED_NUM_ATOMS) {
                real4 tempPosq = posq[j];
                localData[localAtomIndex].x = tempPosq.x;
                localData[localAtomIndex].y = tempPosq.y;
                localData[localAtomIndex].z = tempPosq.z;
                localData[localAtomIndex].q = tempPosq.w;

                localData[localAtomIndex].fx = 0;
                localData[localAtomIndex].fy = 0;
                localData[localAtomIndex].fz = 0;
            }
            else {
                localData[localAtomIndex].x = 0;
                localData[localAtomIndex].y = 0;
                localData[localAtomIndex].z = 0;
            }
            SYNC_WARPS;
#ifdef USE_PERIODIC
            if (singlePeriodicCopy) {
                // The box is small enough that we can just translate all the atoms into a single periodic
                // box, then skip having to apply periodic boundary conditions later.

                real4 blockCenterX = blockCenter[x];
                APPLY_PERIODIC_TO_POS_WITH_CENTER(posq1, blockCenterX)
                APPLY_PERIODIC_TO_POS_WITH_CENTER(localData[localAtomIndex], blockCenterX)
                SYNC_WARPS;
                unsigned int tj = tgx;
                for (j = 0; j < TILE_SIZE; j++) {
                    int atom2 = tbx+tj;
                    real4 posq2 = (real4) (localData[atom2].x, localData[atom2].y, localData[atom2].z, localData[atom2].q);
                    real4 delta = (real4) (posq2.xyz - posq1.xyz, 0);
                    real r2 = delta.x*delta.x + delta.y*delta.y + delta.z*delta.z;
#ifdef PRUNE_BY_CUTOFF
                    if (r2 < CUTOFF_SQUARED) {
#endif
                        real invR = RSQRT(r2);
                        real r = r2*invR;

                        atom2 = atomIndices[tbx+tj];
#ifdef USE_SYMMETRIC
                        real dEdR = 0;
#else
                        real4 dEdR1 = (real4) 0;
                        real4 dEdR2 = (real4) 0;
#endif
#ifdef USE_EXCLUSIONS
                        bool isExcluded = (atom1 >= NUM_ATOMS || atom2 >= NUM_ATOMS);
#endif
                        real tempEnergy = 0;
                        {
#ifdef USE_DOUBLE_PRECISION
    unsigned long includeInteraction;
#else
    unsigned int includeInteraction;
#endif
#if USE_EWALD
    bool needCorrection = hasExclusions && isExcluded && atom1 != atom2 && atom1 < NUM_ATOMS && atom2 < NUM_ATOMS;
    includeInteraction = ((!isExcluded && r2 < CUTOFF_SQUARED) || needCorrection);
    const real alphaR = EWALD_ALPHA*r;
    const real expAlphaRSqr = EXP(-alphaR*alphaR);
    const real prefactor = 138.935456f*posq1.w*posq2.w*invR;

#ifdef USE_DOUBLE_PRECISION
    const real erfcAlphaR = erfc(alphaR);
#else
    // This approximation for erfc is from Abramowitz and Stegun (1964) p. 299.  They cite the following as
    // the original source: C. Hastings, Jr., Approximations for Digital Computers (1955).  It has a maximum
    // error of 1.5e-7.

    const real t = RECIP(1.0f+0.3275911f*alphaR);
    const real erfcAlphaR = (0.254829592f+(-0.284496736f+(1.421413741f+(-1.453152027f+1.061405429f*t)*t)*t)*t)*t*expAlphaRSqr;
#endif
    real tempForce = 0;
    if (needCorrection) {
        // Subtract off the part of this interaction that was included in the reciprocal space contribution.

        if (1-erfcAlphaR > 1e-6) {
            real erfAlphaR = erf(alphaR); // Our erfc approximation is not accurate enough when r is very small, which happens with Drude particles.
            tempForce = -prefactor*(erfAlphaR-alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
            tempEnergy += -prefactor*erfAlphaR;
        }
    }
    else {
#if 0
        real sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
        real sig2 = invR*sig;
        sig2 *= sig2;
        real sig6 = sig2*sig2*sig2;
        real epssig6 = sig6*(sigmaEpsilon1.y*sigmaEpsilon2.y);
        tempForce = epssig6*(12.0f*sig6 - 6.0f);
        real ljEnergy = epssig6*(sig6 - 1.0f);
        #if 0
        if (r > LJ_SWITCH_CUTOFF) {
            real x = r-LJ_SWITCH_CUTOFF;
            real switchValue = 1+x*x*x*(LJ_SWITCH_C3+x*(LJ_SWITCH_C4+x*LJ_SWITCH_C5));
            real switchDeriv = x*x*(3*LJ_SWITCH_C3+x*(4*LJ_SWITCH_C4+x*5*LJ_SWITCH_C5));
            tempForce = tempForce*switchValue - ljEnergy*switchDeriv*r;
            ljEnergy *= switchValue;
        }
        #endif
        tempForce += prefactor*(erfcAlphaR+alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
        tempEnergy += select((real) 0, ljEnergy + prefactor*erfcAlphaR, includeInteraction);
#else
        tempForce = prefactor*(erfcAlphaR+alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
        tempEnergy += select((real) 0, prefactor*erfcAlphaR, includeInteraction);
#endif
    }
    dEdR += select((real) 0, tempForce*invR*invR, includeInteraction);
#else
#ifdef USE_CUTOFF
    includeInteraction = (!isExcluded && r2 < CUTOFF_SQUARED);
#else
    includeInteraction = (!isExcluded);
#endif
    real tempForce = 0;
  #if 0
    real sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
    real sig2 = invR*sig;
    sig2 *= sig2;
    real sig6 = sig2*sig2*sig2;
    real epssig6 = sig6*(sigmaEpsilon1.y*sigmaEpsilon2.y);
    tempForce = epssig6*(12.0f*sig6 - 6.0f);
    real ljEnergy = epssig6*(sig6-1);
    #if 0
    if (r > LJ_SWITCH_CUTOFF) {
        real x = r-LJ_SWITCH_CUTOFF;
        real switchValue = 1+x*x*x*(LJ_SWITCH_C3+x*(LJ_SWITCH_C4+x*LJ_SWITCH_C5));
        real switchDeriv = x*x*(3*LJ_SWITCH_C3+x*(4*LJ_SWITCH_C4+x*5*LJ_SWITCH_C5));
        tempForce = tempForce*switchValue - ljEnergy*switchDeriv*r;
        ljEnergy *= switchValue;
    }
    #endif
    ljEnergy = select((real) 0, ljEnergy, includeInteraction);
    tempEnergy += ljEnergy;
  #endif
#if 1
  #ifdef USE_CUTOFF
    const real prefactor = 138.935456f*posq1.w*posq2.w;
    tempForce += prefactor*(invR - 2.0f*REACTION_FIELD_K*r2);
    tempEnergy += select((real) 0, prefactor*(invR + REACTION_FIELD_K*r2 - REACTION_FIELD_C), includeInteraction);
  #else
    const real prefactor = 138.935456f*posq1.w*posq2.w*invR;
    tempForce += prefactor;
    tempEnergy += select((real) 0, prefactor, includeInteraction);
  #endif
#endif
    dEdR += select((real) 0, tempForce*invR*invR, includeInteraction);
#endif
}


                        energy += tempEnergy;
#ifdef USE_SYMMETRIC
                        delta.xyz *= dEdR;
                        force.xyz -= delta.xyz;
                        localData[tbx+tj].fx += delta.x;
                        localData[tbx+tj].fy += delta.y;
                        localData[tbx+tj].fz += delta.z;
#else
                        force.xyz -= dEdR1.xyz;
                        localData[tbx+tj].fx += dEdR2.x;
                        localData[tbx+tj].fy += dEdR2.y;
                        localData[tbx+tj].fz += dEdR2.z;
#endif
#ifdef PRUNE_BY_CUTOFF
                    }
#endif
                    tj = (tj + 1) & (TILE_SIZE - 1);
                    SYNC_WARPS;
                }
            }
            else
#endif
            {
                // We need to apply periodic boundary conditions separately for each interaction.

                unsigned int tj = tgx;
                for (j = 0; j < TILE_SIZE; j++) {
                    int atom2 = tbx+tj;
                    real4 posq2 = (real4) (localData[atom2].x, localData[atom2].y, localData[atom2].z, localData[atom2].q);
                    real4 delta = (real4) (posq2.xyz - posq1.xyz, 0);
#ifdef USE_PERIODIC
                    APPLY_PERIODIC_TO_DELTA(delta)
#endif
                    real r2 = delta.x*delta.x + delta.y*delta.y + delta.z*delta.z;
#ifdef PRUNE_BY_CUTOFF
                    if (r2 < CUTOFF_SQUARED) {
#endif
                        real invR = RSQRT(r2);
                        real r = r2*invR;

                        atom2 = atomIndices[tbx+tj];
#ifdef USE_SYMMETRIC
                        real dEdR = 0;
#else
                        real4 dEdR1 = (real4) 0;
                        real4 dEdR2 = (real4) 0;
#endif
#ifdef USE_EXCLUSIONS
                        bool isExcluded = (atom1 >= NUM_ATOMS || atom2 >= NUM_ATOMS);
#endif
                        real tempEnergy = 0;
                        {
#ifdef USE_DOUBLE_PRECISION
    unsigned long includeInteraction;
#else
    unsigned int includeInteraction;
#endif
#if USE_EWALD
    bool needCorrection = hasExclusions && isExcluded && atom1 != atom2 && atom1 < NUM_ATOMS && atom2 < NUM_ATOMS;
    includeInteraction = ((!isExcluded && r2 < CUTOFF_SQUARED) || needCorrection);
    const real alphaR = EWALD_ALPHA*r;
    const real expAlphaRSqr = EXP(-alphaR*alphaR);
    const real prefactor = 138.935456f*posq1.w*posq2.w*invR;

#ifdef USE_DOUBLE_PRECISION
    const real erfcAlphaR = erfc(alphaR);
#else
    // This approximation for erfc is from Abramowitz and Stegun (1964) p. 299.  They cite the following as
    // the original source: C. Hastings, Jr., Approximations for Digital Computers (1955).  It has a maximum
    // error of 1.5e-7.

    const real t = RECIP(1.0f+0.3275911f*alphaR);
    const real erfcAlphaR = (0.254829592f+(-0.284496736f+(1.421413741f+(-1.453152027f+1.061405429f*t)*t)*t)*t)*t*expAlphaRSqr;
#endif
    real tempForce = 0;
    if (needCorrection) {
        // Subtract off the part of this interaction that was included in the reciprocal space contribution.

        if (1-erfcAlphaR > 1e-6) {
            real erfAlphaR = erf(alphaR); // Our erfc approximation is not accurate enough when r is very small, which happens with Drude particles.
            tempForce = -prefactor*(erfAlphaR-alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
            tempEnergy += -prefactor*erfAlphaR;
        }
    }
    else {
#if 0
        real sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
        real sig2 = invR*sig;
        sig2 *= sig2;
        real sig6 = sig2*sig2*sig2;
        real epssig6 = sig6*(sigmaEpsilon1.y*sigmaEpsilon2.y);
        tempForce = epssig6*(12.0f*sig6 - 6.0f);
        real ljEnergy = epssig6*(sig6 - 1.0f);
        #if 0
        if (r > LJ_SWITCH_CUTOFF) {
            real x = r-LJ_SWITCH_CUTOFF;
            real switchValue = 1+x*x*x*(LJ_SWITCH_C3+x*(LJ_SWITCH_C4+x*LJ_SWITCH_C5));
            real switchDeriv = x*x*(3*LJ_SWITCH_C3+x*(4*LJ_SWITCH_C4+x*5*LJ_SWITCH_C5));
            tempForce = tempForce*switchValue - ljEnergy*switchDeriv*r;
            ljEnergy *= switchValue;
        }
        #endif
        tempForce += prefactor*(erfcAlphaR+alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
        tempEnergy += select((real) 0, ljEnergy + prefactor*erfcAlphaR, includeInteraction);
#else
        tempForce = prefactor*(erfcAlphaR+alphaR*expAlphaRSqr*TWO_OVER_SQRT_PI);
        tempEnergy += select((real) 0, prefactor*erfcAlphaR, includeInteraction);
#endif
    }
    dEdR += select((real) 0, tempForce*invR*invR, includeInteraction);
#else
#ifdef USE_CUTOFF
    includeInteraction = (!isExcluded && r2 < CUTOFF_SQUARED);
#else
    includeInteraction = (!isExcluded);
#endif
    real tempForce = 0;
  #if 0
    real sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
    real sig2 = invR*sig;
    sig2 *= sig2;
    real sig6 = sig2*sig2*sig2;
    real epssig6 = sig6*(sigmaEpsilon1.y*sigmaEpsilon2.y);
    tempForce = epssig6*(12.0f*sig6 - 6.0f);
    real ljEnergy = epssig6*(sig6-1);
    #if 0
    if (r > LJ_SWITCH_CUTOFF) {
        real x = r-LJ_SWITCH_CUTOFF;
        real switchValue = 1+x*x*x*(LJ_SWITCH_C3+x*(LJ_SWITCH_C4+x*LJ_SWITCH_C5));
        real switchDeriv = x*x*(3*LJ_SWITCH_C3+x*(4*LJ_SWITCH_C4+x*5*LJ_SWITCH_C5));
        tempForce = tempForce*switchValue - ljEnergy*switchDeriv*r;
        ljEnergy *= switchValue;
    }
    #endif
    ljEnergy = select((real) 0, ljEnergy, includeInteraction);
    tempEnergy += ljEnergy;
  #endif
#if 1
  #ifdef USE_CUTOFF
    const real prefactor = 138.935456f*posq1.w*posq2.w;
    tempForce += prefactor*(invR - 2.0f*REACTION_FIELD_K*r2);
    tempEnergy += select((real) 0, prefactor*(invR + REACTION_FIELD_K*r2 - REACTION_FIELD_C), includeInteraction);
  #else
    const real prefactor = 138.935456f*posq1.w*posq2.w*invR;
    tempForce += prefactor;
    tempEnergy += select((real) 0, prefactor, includeInteraction);
  #endif
#endif
    dEdR += select((real) 0, tempForce*invR*invR, includeInteraction);
#endif
}


                        energy += tempEnergy;
#ifdef USE_SYMMETRIC
                        delta.xyz *= dEdR;
                        force.xyz -= delta.xyz;
                        localData[tbx+tj].fx += delta.x;
                        localData[tbx+tj].fy += delta.y;
                        localData[tbx+tj].fz += delta.z;
#else
                        force.xyz -= dEdR1.xyz;
                        localData[tbx+tj].fx += dEdR2.x;
                        localData[tbx+tj].fy += dEdR2.y;
                        localData[tbx+tj].fz += dEdR2.z;
#endif
#ifdef PRUNE_BY_CUTOFF
                    }
#endif
                    tj = (tj + 1) & (TILE_SIZE - 1);
                    SYNC_WARPS;
                }
            }

            // Write results.

#ifdef USE_CUTOFF
            unsigned int atom2 = atomIndices[get_local_id(0)];
#else
            unsigned int atom2 = y*TILE_SIZE + tgx;
#endif
#ifdef SUPPORTS_64_BIT_ATOMICS
            atom_add(&forceBuffers[atom1], (long) (force.x*0x100000000));
            atom_add(&forceBuffers[atom1+PADDED_NUM_ATOMS], (long) (force.y*0x100000000));
            atom_add(&forceBuffers[atom1+2*PADDED_NUM_ATOMS], (long) (force.z*0x100000000));
            if (atom2 < PADDED_NUM_ATOMS) {
                atom_add(&forceBuffers[atom2], (long) (localData[get_local_id(0)].fx*0x100000000));
                atom_add(&forceBuffers[atom2+PADDED_NUM_ATOMS], (long) (localData[get_local_id(0)].fy*0x100000000));
                atom_add(&forceBuffers[atom2+2*PADDED_NUM_ATOMS], (long) (localData[get_local_id(0)].fz*0x100000000));
            }
#else
            unsigned int offset1 = atom1 + warp*PADDED_NUM_ATOMS;
            unsigned int offset2 = atom2 + warp*PADDED_NUM_ATOMS;
            forceBuffers[offset1].xyz += force.xyz;
            if (atom2 < PADDED_NUM_ATOMS)
                forceBuffers[offset2] += (real4) (localData[get_local_id(0)].fx, localData[get_local_id(0)].fy, localData[get_local_id(0)].fz, 0.0f);
#endif
        }
        pos++;
    }
    energyBuffer[get_global_id(0)] += energy;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
