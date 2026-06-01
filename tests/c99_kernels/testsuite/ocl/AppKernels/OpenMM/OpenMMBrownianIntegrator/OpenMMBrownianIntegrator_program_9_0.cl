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
#define NUM_ATOMS 2

/**
 * Perform the first step of Brownian integration.
 */

__kernel void integrateBrownianPart1(mixed tauDeltaT, mixed noiseAmplitude, __global const real4* restrict force,
        __global mixed4* restrict posDelta, __global const mixed4* restrict velm, __global const float4* restrict random, unsigned int randomIndex) {
    randomIndex += get_global_id(0);
    for (int index = get_global_id(0); index < NUM_ATOMS; index += get_global_size(0)) {
        mixed invMass = velm[index].w;
        if (invMass != 0) {
            posDelta[index] = (mixed4) (tauDeltaT*invMass*force[index].x + noiseAmplitude*sqrt(invMass)*random[randomIndex].x,
                                        tauDeltaT*invMass*force[index].y + noiseAmplitude*sqrt(invMass)*random[randomIndex].y,
                                        tauDeltaT*invMass*force[index].z + noiseAmplitude*sqrt(invMass)*random[randomIndex].z, 0);
        }
        randomIndex += get_global_size(0);
    }
}

/**
 * Perform the second step of Brownian integration.
 */

__kernel void integrateBrownianPart2(mixed oneOverDeltaT, __global real4* posq, __global real4* posqCorrection, __global mixed4* velm, __global const mixed4* restrict posDelta) {
    for (int index = get_global_id(0); index < NUM_ATOMS; index += get_global_size(0)) {
        if (velm[index].w != 0) {
            mixed4 delta = posDelta[index];
            velm[index].x = oneOverDeltaT*delta.x;
            velm[index].y = oneOverDeltaT*delta.y;
            velm[index].z = oneOverDeltaT*delta.z;
#ifdef USE_MIXED_PRECISION
            real4 pos1 = posq[index];
            real4 pos2 = posqCorrection[index];
            mixed4 pos = (mixed4) (pos1.x+(mixed)pos2.x, pos1.y+(mixed)pos2.y, pos1.z+(mixed)pos2.z, pos1.w);
#else
            real4 pos = posq[index];
#endif
            pos.x += delta.x;
            pos.y += delta.y;
            pos.z += delta.z;
#ifdef USE_MIXED_PRECISION
            posq[index] = (real4) ((real) pos.x, (real) pos.y, (real) pos.z, (real) pos.w);
            posqCorrection[index] = (real4) (pos.x-(real) pos.x, pos.y-(real) pos.y, pos.z-(real) pos.z, 0);
#else
            posq[index] = pos;
#endif
        }
    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
