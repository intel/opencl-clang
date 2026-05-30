#define TILE_SIZE 32

typedef struct {
    float x, y, z;
    float q;
    float fx, fy, fz;
    float sigmaEpsilon_x;
float sigmaEpsilon_y;
float obcParams_x;
float obcParams_y;
float bornForce;
float padding;

} AtomData;

/**
 * Compute nonbonded interactions.
 */

__kernel __attribute__((reqd_work_group_size(WORK_GROUP_SIZE, 1, 1)))
void computeNonbonded(__global float4* forceBuffers, __global float* energyBuffer, __global float4* posq, __global unsigned int* exclusions,
        __global unsigned int* exclusionIndices, __local AtomData* localData, __local float4* tempBuffer, __global unsigned int* tiles,
#ifdef USE_CUTOFF
        __global unsigned int* interactionFlags, __global unsigned int* interactionCount, float4 periodicBoxSize, float4 invPeriodicBoxSize
#else
        unsigned int numTiles
#endif
        , __global float2* global_sigmaEpsilon, __global float2* global_obcParams, __global float* global_bornForce) {
#ifdef USE_CUTOFF
    unsigned int numTiles = interactionCount[0];
#endif
    unsigned int pos = get_group_id(0)*numTiles/get_num_groups(0);
    unsigned int end = (get_group_id(0)+1)*numTiles/get_num_groups(0);
    float energy = 0.0f;
    unsigned int lasty = 0xFFFFFFFF;

    while (pos < end) {
        // Extract the coordinates of this tile
        unsigned int x = tiles[pos];
        unsigned int y = ((x >> 2) & 0x7fff)*TILE_SIZE;
        bool hasExclusions = (x & 0x1);
        x = (x>>17)*TILE_SIZE;
        unsigned int baseLocalAtom = (get_local_id(0) < TILE_SIZE ? 0 : TILE_SIZE/2);
        unsigned int tgx = get_local_id(0) & (TILE_SIZE-1);
        unsigned int forceBufferOffset = (tgx < TILE_SIZE/2 ? 0 : TILE_SIZE);
        unsigned int atom1 = x + tgx;
        float4 force = 0.0f;
        float4 posq1 = posq[atom1];
        float2 sigmaEpsilon1 = global_sigmaEpsilon[atom1];
float2 obcParams1 = global_obcParams[atom1];
float bornForce1 = global_bornForce[atom1];

        if (x == y) {
            // This tile is on the diagonal.

            localData[get_local_id(0)].x = posq1.x;
            localData[get_local_id(0)].y = posq1.y;
            localData[get_local_id(0)].z = posq1.z;
            localData[get_local_id(0)].q = posq1.w;
            localData[get_local_id(0)].sigmaEpsilon_x = sigmaEpsilon1.x;
localData[get_local_id(0)].sigmaEpsilon_y = sigmaEpsilon1.y;
localData[get_local_id(0)].obcParams_x = obcParams1.x;
localData[get_local_id(0)].obcParams_y = obcParams1.y;
localData[get_local_id(0)].bornForce = bornForce1;

            barrier(CLK_LOCAL_MEM_FENCE);
            unsigned int xi = x/TILE_SIZE;
            unsigned int tile = xi+xi*PADDED_NUM_ATOMS/TILE_SIZE-xi*(xi+1)/2;
#ifdef USE_EXCLUSIONS
            unsigned int excl = exclusions[exclusionIndices[tile]+tgx] >> baseLocalAtom;
#endif
            for (unsigned int j = 0; j < TILE_SIZE/2; j++) {
#ifdef USE_EXCLUSIONS
                bool isExcluded = !(excl & 0x1);
#endif
                int atom2 = baseLocalAtom+j;
                float4 posq2 = (float4) (localData[atom2].x, localData[atom2].y, localData[atom2].z, localData[atom2].q);
                float4 delta = (float4) (posq2.xyz - posq1.xyz, 0.0f);
#ifdef USE_PERIODIC
                delta.x -= floor(delta.x*invPeriodicBoxSize.x+0.5f)*periodicBoxSize.x;
                delta.y -= floor(delta.y*invPeriodicBoxSize.y+0.5f)*periodicBoxSize.y;
                delta.z -= floor(delta.z*invPeriodicBoxSize.z+0.5f)*periodicBoxSize.z;
#endif
                float r2 = delta.x*delta.x + delta.y*delta.y + delta.z*delta.z;
                float invR = RSQRT(r2);
                float r = RECIP(invR);
                float2 sigmaEpsilon2 = (float2) (localData[atom2].sigmaEpsilon_x, localData[atom2].sigmaEpsilon_y);
float2 obcParams2 = (float2) (localData[atom2].obcParams_x, localData[atom2].obcParams_y);
float bornForce2 = localData[atom2].bornForce;

                atom2 = y+baseLocalAtom+j;
#ifdef USE_SYMMETRIC
                float dEdR = 0.0f;
#else
                float4 dEdR1 = (float4) 0.0f;
                float4 dEdR2 = (float4) 0.0f;
#endif
                float tempEnergy = 0.0f;
                #if USE_EWALD
bool needCorrection = isExcluded && atom1 != atom2 && atom1 < NUM_ATOMS && atom2 < NUM_ATOMS;
if (!isExcluded || needCorrection) {
    const float prefactor = 138.935456f*posq1.w*posq2.w*invR;
    float alphaR = EWALD_ALPHA*r;
    float erfcAlphaR = 0.0f;
    if (r2 < CUTOFF_SQUARED) {
        float normalized = ERFC_TABLE_SCALE*alphaR;
        int tableIndex = (int) normalized;
        float fract2 = normalized-tableIndex;
        float fract1 = 1.0f-fract2;
        erfcAlphaR = fract1*erfcTable[tableIndex] + fract2*erfcTable[tableIndex+1];
    }
    else if (needCorrection)
        erfcAlphaR = erfc(alphaR);
    float tempForce = 0.0f;
    if (needCorrection) {
        // Subtract off the part of this interaction that was included in the reciprocal space contribution.

        tempForce = -prefactor*((1.0f-erfcAlphaR)-alphaR*exp(-alphaR*alphaR)*TWO_OVER_SQRT_PI);
        tempEnergy += -prefactor*(1.0f-erfcAlphaR);
    }
    else if (r2 < CUTOFF_SQUARED) {
#if 1
        float sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
        float sig2 = invR*sig;
        sig2 *= sig2;
        float sig6 = sig2*sig2*sig2;
        float eps = sigmaEpsilon1.y*sigmaEpsilon2.y;
        tempForce = eps*(12.0f*sig6 - 6.0f)*sig6 + prefactor*(erfcAlphaR+alphaR*exp(-alphaR*alphaR)*TWO_OVER_SQRT_PI);
        tempEnergy += eps*(sig6 - 1.0f)*sig6 + prefactor*erfcAlphaR;
#else
        tempForce = prefactor*(erfcAlphaR+alphaR*exp(-alphaR*alphaR)*TWO_OVER_SQRT_PI);
        tempEnergy += prefactor*erfcAlphaR;
#endif
    }
    dEdR += tempForce*invR*invR;
}
#else
#ifdef USE_CUTOFF
if (!isExcluded && r2 < CUTOFF_SQUARED) {
#else
if (!isExcluded) {
#endif
    float tempForce = 0.0f;
  #if 1
    float sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
    float sig2 = invR*sig;
    sig2 *= sig2;
    float sig6 = sig2*sig2*sig2;
    float eps = sigmaEpsilon1.y*sigmaEpsilon2.y;
    tempForce = eps*(12.0f*sig6 - 6.0f)*sig6;
    tempEnergy += eps*(sig6 - 1.0f)*sig6;
  #endif
#if 1
  #ifdef USE_CUTOFF
    const float prefactor = 138.935456f*posq1.w*posq2.w;
    tempForce += prefactor*(invR - 2.0f*REACTION_FIELD_K*r2);
    tempEnergy += prefactor*(invR + REACTION_FIELD_K*r2 - REACTION_FIELD_C);
  #else
    const float prefactor = 138.935456f*posq1.w*posq2.w*invR;
    tempForce += prefactor;
    tempEnergy += prefactor;
  #endif
#endif
    dEdR += tempForce*invR*invR;
}
#endif
#ifdef USE_CUTOFF
if (atom1 < NUM_ATOMS && atom2 < NUM_ATOMS && atom1 != atom2 && r2 < CUTOFF_SQUARED) {
#else
if (atom1 < NUM_ATOMS && atom2 < NUM_ATOMS && atom1 != atom2) {
#endif
    float invRSquared = RECIP(r2);
    float rScaledRadiusJ = r+obcParams2.y;
    float rScaledRadiusI = r+obcParams1.y;
    float l_ijJ = RECIP(max(obcParams1.x, fabs(r-obcParams2.y)));
    float l_ijI = RECIP(max(obcParams2.x, fabs(r-obcParams1.y)));
    float u_ijJ = RECIP(rScaledRadiusJ);
    float u_ijI = RECIP(rScaledRadiusI);
    float l_ij2J = l_ijJ*l_ijJ;
    float l_ij2I = l_ijI*l_ijI;
    float u_ij2J = u_ijJ*u_ijJ;
    float u_ij2I = u_ijI*u_ijI;
    float t1J = log(u_ijJ/l_ijJ);
    float t1I = log(u_ijI/l_ijI);
    float t2J = (l_ij2J-u_ij2J);
    float t2I = (l_ij2I-u_ij2I);
    float t3J = t2J*invR;
    float t3I = t2I*invR;
    t1J *= invR;
    t1I *= invR;
    float term1 = 0.125f*(1.0f+obcParams2.y*obcParams2.y*invRSquared)*t3J + 0.25f*t1J*invRSquared;
    float term2 = 0.125f*(1.0f+obcParams1.y*obcParams1.y*invRSquared)*t3I + 0.25f*t1I*invRSquared;
    dEdR += (obcParams1.x < rScaledRadiusJ ? bornForce1*term1 : 0.0f);
    dEdR += (obcParams2.x < rScaledRadiusJ ? bornForce2*term2 : 0.0f);
}


                energy += 0.5f*tempEnergy;
#ifdef USE_SYMMETRIC
                force.xyz -= delta.xyz*dEdR;
#else
                force.xyz -= dEdR1.xyz;
#endif
                excl >>= 1;
            }

            // Sum the forces and write results.

            if (get_local_id(0) >= TILE_SIZE)
                tempBuffer[get_local_id(0)] = force;
            barrier(CLK_LOCAL_MEM_FENCE);
            if (get_local_id(0) < TILE_SIZE) {
#ifdef USE_OUTPUT_BUFFER_PER_BLOCK
                unsigned int offset = x + tgx + (x/TILE_SIZE)*PADDED_NUM_ATOMS;
#else
                unsigned int offset = x + tgx + get_group_id(0)*PADDED_NUM_ATOMS;
#endif
                forceBuffers[offset].xyz = forceBuffers[offset].xyz+force.xyz+tempBuffer[get_local_id(0)+TILE_SIZE].xyz;
            }
        }
        else {
            // This is an off-diagonal tile.

            if (lasty != y && get_local_id(0) < TILE_SIZE) {
                unsigned int j = y + tgx;
                float4 tempPosq = posq[j];
                localData[get_local_id(0)].x = tempPosq.x;
                localData[get_local_id(0)].y = tempPosq.y;
                localData[get_local_id(0)].z = tempPosq.z;
                localData[get_local_id(0)].q = tempPosq.w;
                float2 temp_sigmaEpsilon = global_sigmaEpsilon[j];
localData[get_local_id(0)].sigmaEpsilon_x = temp_sigmaEpsilon.x;
localData[get_local_id(0)].sigmaEpsilon_y = temp_sigmaEpsilon.y;
float2 temp_obcParams = global_obcParams[j];
localData[get_local_id(0)].obcParams_x = temp_obcParams.x;
localData[get_local_id(0)].obcParams_y = temp_obcParams.y;
localData[get_local_id(0)].bornForce = global_bornForce[j];

            }
            localData[get_local_id(0)].fx = 0.0f;
            localData[get_local_id(0)].fy = 0.0f;
            localData[get_local_id(0)].fz = 0.0f;
            barrier(CLK_LOCAL_MEM_FENCE);

            // Compute the full set of interactions in this tile.

            unsigned int xi = x/TILE_SIZE;
            unsigned int yi = y/TILE_SIZE;
            unsigned int tile = xi+yi*PADDED_NUM_ATOMS/TILE_SIZE-yi*(yi+1)/2;
#ifdef USE_EXCLUSIONS
            unsigned int excl = (hasExclusions ? exclusions[exclusionIndices[tile]+tgx] : 0xFFFFFFFF);
            excl = (excl >> baseLocalAtom) & 0xFFFF;
            excl += excl << 16;
            excl = (excl >> tgx) | (excl << (TILE_SIZE - tgx));
#endif
            unsigned int tj = tgx%(TILE_SIZE/2);
            for (unsigned int j = 0; j < TILE_SIZE/2; j++) {
#ifdef USE_EXCLUSIONS
                bool isExcluded = !(excl & 0x1);
#endif
                int atom2 = baseLocalAtom+tj;
                float4 posq2 = (float4) (localData[atom2].x, localData[atom2].y, localData[atom2].z, localData[atom2].q);
                float4 delta = (float4) (posq2.xyz - posq1.xyz, 0.0f);
#ifdef USE_PERIODIC
                delta.x -= floor(delta.x*invPeriodicBoxSize.x+0.5f)*periodicBoxSize.x;
                delta.y -= floor(delta.y*invPeriodicBoxSize.y+0.5f)*periodicBoxSize.y;
                delta.z -= floor(delta.z*invPeriodicBoxSize.z+0.5f)*periodicBoxSize.z;
#endif
                float r2 = delta.x*delta.x + delta.y*delta.y + delta.z*delta.z;
                float invR = RSQRT(r2);
                float r = RECIP(invR);
                float2 sigmaEpsilon2 = (float2) (localData[atom2].sigmaEpsilon_x, localData[atom2].sigmaEpsilon_y);
float2 obcParams2 = (float2) (localData[atom2].obcParams_x, localData[atom2].obcParams_y);
float bornForce2 = localData[atom2].bornForce;

                atom2 = y+baseLocalAtom+tj;
#ifdef USE_SYMMETRIC
                float dEdR = 0.0f;
#else
                float4 dEdR1 = (float4) 0.0f;
                float4 dEdR2 = (float4) 0.0f;
#endif
                float tempEnergy = 0.0f;
                #if USE_EWALD
bool needCorrection = isExcluded && atom1 != atom2 && atom1 < NUM_ATOMS && atom2 < NUM_ATOMS;
if (!isExcluded || needCorrection) {
    const float prefactor = 138.935456f*posq1.w*posq2.w*invR;
    float alphaR = EWALD_ALPHA*r;
    float erfcAlphaR = 0.0f;
    if (r2 < CUTOFF_SQUARED) {
        float normalized = ERFC_TABLE_SCALE*alphaR;
        int tableIndex = (int) normalized;
        float fract2 = normalized-tableIndex;
        float fract1 = 1.0f-fract2;
        erfcAlphaR = fract1*erfcTable[tableIndex] + fract2*erfcTable[tableIndex+1];
    }
    else if (needCorrection)
        erfcAlphaR = erfc(alphaR);
    float tempForce = 0.0f;
    if (needCorrection) {
        // Subtract off the part of this interaction that was included in the reciprocal space contribution.

        tempForce = -prefactor*((1.0f-erfcAlphaR)-alphaR*exp(-alphaR*alphaR)*TWO_OVER_SQRT_PI);
        tempEnergy += -prefactor*(1.0f-erfcAlphaR);
    }
    else if (r2 < CUTOFF_SQUARED) {
#if 1
        float sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
        float sig2 = invR*sig;
        sig2 *= sig2;
        float sig6 = sig2*sig2*sig2;
        float eps = sigmaEpsilon1.y*sigmaEpsilon2.y;
        tempForce = eps*(12.0f*sig6 - 6.0f)*sig6 + prefactor*(erfcAlphaR+alphaR*exp(-alphaR*alphaR)*TWO_OVER_SQRT_PI);
        tempEnergy += eps*(sig6 - 1.0f)*sig6 + prefactor*erfcAlphaR;
#else
        tempForce = prefactor*(erfcAlphaR+alphaR*exp(-alphaR*alphaR)*TWO_OVER_SQRT_PI);
        tempEnergy += prefactor*erfcAlphaR;
#endif
    }
    dEdR += tempForce*invR*invR;
}
#else
#ifdef USE_CUTOFF
if (!isExcluded && r2 < CUTOFF_SQUARED) {
#else
if (!isExcluded) {
#endif
    float tempForce = 0.0f;
  #if 1
    float sig = sigmaEpsilon1.x + sigmaEpsilon2.x;
    float sig2 = invR*sig;
    sig2 *= sig2;
    float sig6 = sig2*sig2*sig2;
    float eps = sigmaEpsilon1.y*sigmaEpsilon2.y;
    tempForce = eps*(12.0f*sig6 - 6.0f)*sig6;
    tempEnergy += eps*(sig6 - 1.0f)*sig6;
  #endif
#if 1
  #ifdef USE_CUTOFF
    const float prefactor = 138.935456f*posq1.w*posq2.w;
    tempForce += prefactor*(invR - 2.0f*REACTION_FIELD_K*r2);
    tempEnergy += prefactor*(invR + REACTION_FIELD_K*r2 - REACTION_FIELD_C);
  #else
    const float prefactor = 138.935456f*posq1.w*posq2.w*invR;
    tempForce += prefactor;
    tempEnergy += prefactor;
  #endif
#endif
    dEdR += tempForce*invR*invR;
}
#endif
#ifdef USE_CUTOFF
if (atom1 < NUM_ATOMS && atom2 < NUM_ATOMS && atom1 != atom2 && r2 < CUTOFF_SQUARED) {
#else
if (atom1 < NUM_ATOMS && atom2 < NUM_ATOMS && atom1 != atom2) {
#endif
    float invRSquared = RECIP(r2);
    float rScaledRadiusJ = r+obcParams2.y;
    float rScaledRadiusI = r+obcParams1.y;
    float l_ijJ = RECIP(max(obcParams1.x, fabs(r-obcParams2.y)));
    float l_ijI = RECIP(max(obcParams2.x, fabs(r-obcParams1.y)));
    float u_ijJ = RECIP(rScaledRadiusJ);
    float u_ijI = RECIP(rScaledRadiusI);
    float l_ij2J = l_ijJ*l_ijJ;
    float l_ij2I = l_ijI*l_ijI;
    float u_ij2J = u_ijJ*u_ijJ;
    float u_ij2I = u_ijI*u_ijI;
    float t1J = log(u_ijJ/l_ijJ);
    float t1I = log(u_ijI/l_ijI);
    float t2J = (l_ij2J-u_ij2J);
    float t2I = (l_ij2I-u_ij2I);
    float t3J = t2J*invR;
    float t3I = t2I*invR;
    t1J *= invR;
    t1I *= invR;
    float term1 = 0.125f*(1.0f+obcParams2.y*obcParams2.y*invRSquared)*t3J + 0.25f*t1J*invRSquared;
    float term2 = 0.125f*(1.0f+obcParams1.y*obcParams1.y*invRSquared)*t3I + 0.25f*t1I*invRSquared;
    dEdR += (obcParams1.x < rScaledRadiusJ ? bornForce1*term1 : 0.0f);
    dEdR += (obcParams2.x < rScaledRadiusJ ? bornForce2*term2 : 0.0f);
}


                energy += tempEnergy;
#ifdef USE_SYMMETRIC
                delta.xyz *= dEdR;
                force.xyz -= delta.xyz;
                localData[baseLocalAtom+tj+forceBufferOffset].fx += delta.x;
                localData[baseLocalAtom+tj+forceBufferOffset].fy += delta.y;
                localData[baseLocalAtom+tj+forceBufferOffset].fz += delta.z;
#else
                force.xyz -= dEdR1.xyz;
                localData[baseLocalAtom+tj+forceBufferOffset].fx += dEdR2.x;
                localData[baseLocalAtom+tj+forceBufferOffset].fy += dEdR2.y;
                localData[baseLocalAtom+tj+forceBufferOffset].fz += dEdR2.z;
#endif
                barrier(CLK_LOCAL_MEM_FENCE);
                excl >>= 1;
                tj = (tj+1)%(TILE_SIZE/2);
            }

            // Sum the forces and write results.

            if (get_local_id(0) >= TILE_SIZE)
                tempBuffer[get_local_id(0)] = force;
            barrier(CLK_LOCAL_MEM_FENCE);
            if (get_local_id(0) < TILE_SIZE) {
#ifdef USE_OUTPUT_BUFFER_PER_BLOCK
                unsigned int offset1 = x + tgx + (y/TILE_SIZE)*PADDED_NUM_ATOMS;
                unsigned int offset2 = y + tgx + (x/TILE_SIZE)*PADDED_NUM_ATOMS;
#else
                unsigned int offset1 = x + tgx + get_group_id(0)*PADDED_NUM_ATOMS;
                unsigned int offset2 = y + tgx + get_group_id(0)*PADDED_NUM_ATOMS;
#endif
                forceBuffers[offset1].xyz = forceBuffers[offset1].xyz+force.xyz+tempBuffer[get_local_id(0)+TILE_SIZE].xyz;
                float4 sum = (float4) (localData[get_local_id(0)].fx+localData[get_local_id(0)+TILE_SIZE].fx, localData[get_local_id(0)].fy+localData[get_local_id(0)+TILE_SIZE].fy, localData[get_local_id(0)].fz+localData[get_local_id(0)+TILE_SIZE].fz, 0.0f);
                forceBuffers[offset2].xyz = forceBuffers[offset2].xyz+sum.xyz;
            }
            lasty = y;
        }
        pos++;
    }
    energyBuffer[get_global_id(0)] += energy;
}


// buildOptions=-cl-fast-relaxed-math -DWORK_GROUP_SIZE=64 -DSQRT=native_sqrt -DRSQRT=native_rsqrt -DRECIP=native_recip -DCUTOFF_SQUARED=1.00000000e+000f -DNUM_ATOMS=32 -DPADDED_NUM_ATOMS=32 -DUSE_EXCLUSIONS=1 -DUSE_OUTPUT_BUFFER_PER_BLOCK=1 -DUSE_SYMMETRIC=1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -DWORK_GROUP_SIZE=64 -DSQRT=native_sqrt -DRSQRT=native_rsqrt -DRECIP=native_recip -DCUTOFF_SQUARED=1.00000000e+000f -DNUM_ATOMS=32 -DPADDED_NUM_ATOMS=32 -DUSE_EXCLUSIONS=1 -DUSE_OUTPUT_BUFFER_PER_BLOCK=1 -DUSE_SYMMETRIC=1" %cfg_path --cl-device=%cl_device 2>&1
