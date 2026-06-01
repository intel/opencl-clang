/**
 * Compute nonbonded exceptions.
 */

__kernel void computeNonbondedExceptions(__global float4* forceBuffers, __global float* energyBuffer,
        __global float4* posq, __global float4* params, __global int4* indices) {
    int index = get_global_id(0);
    float energy = 0.0f;
    while (index < NUM_EXCEPTIONS) {
        // Look up the data for this bonds.

        int4 atoms = indices[index];
        float4 exceptionParams = params[index];
        float4 delta = posq[atoms.y]-posq[atoms.x];

        // Compute the force.

        float r2 = delta.x*delta.x + delta.y*delta.y + delta.z*delta.z;
        float invR = RSQRT(r2);
        float sig2 = invR*exceptionParams.y;
        sig2 *= sig2;
        float sig6 = sig2*sig2*sig2;
        float dEdR = exceptionParams.z*(12.0f*sig6-6.0f)*sig6;
        float tempEnergy = exceptionParams.z*(sig6-1.0f)*sig6;
        dEdR += exceptionParams.x*invR;
        dEdR *= invR*invR;
        tempEnergy += exceptionParams.x*invR;
        energy += tempEnergy;
        delta.xyz *= dEdR;

        // Record the force on each of the two atoms.

        unsigned int offsetA = atoms.x+atoms.z*NUM_ATOMS;
        unsigned int offsetB = atoms.y+atoms.w*NUM_ATOMS;
        float4 forceA = forceBuffers[offsetA];
        float4 forceB = forceBuffers[offsetB];
        forceA.xyz -= delta.xyz;
        forceB.xyz += delta.xyz;
        forceBuffers[offsetA] = forceA;
        forceBuffers[offsetB] = forceB;
        index += get_global_size(0);
    }
    energyBuffer[get_global_id(0)] += energy;
}


// buildOptions=-cl-fast-relaxed-math -DWORK_GROUP_SIZE=64 -DSQRT=native_sqrt -DRSQRT=native_rsqrt -DRECIP=native_recip -DNUM_ATOMS=32 -DNUM_EXCEPTIONS=66
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -DWORK_GROUP_SIZE=64 -DSQRT=native_sqrt -DRSQRT=native_rsqrt -DRECIP=native_recip -DNUM_ATOMS=32 -DNUM_EXCEPTIONS=66" %cfg_path --cl-device=%cl_device 2>&1
