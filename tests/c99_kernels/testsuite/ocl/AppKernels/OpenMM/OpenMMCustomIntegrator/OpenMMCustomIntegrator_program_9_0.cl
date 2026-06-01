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
#define WORK_GROUP_SIZE 64

/**
 * Load the position of a particle.
 */
mixed4 loadPos(__global const real4* restrict posq, __global const real4* restrict posqCorrection, int index) {
#ifdef USE_MIXED_PRECISION
    real4 pos1 = posq[index];
    real4 pos2 = posqCorrection[index];
    return (mixed4) (pos1.x+(mixed)pos2.x, pos1.y+(mixed)pos2.y, pos1.z+(mixed)pos2.z, pos1.w);
#else
    return posq[index];
#endif
}

/**
 * Store the position of a particle.
 */
void storePos(__global real4* restrict posq, __global real4* restrict posqCorrection, int index, mixed4 pos) {
#ifdef USE_MIXED_PRECISION
    posq[index] = (real4) ((real) pos.x, (real) pos.y, (real) pos.z, (real) pos.w);
    posqCorrection[index] = (real4) (pos.x-(real) pos.x, pos.y-(real) pos.y, pos.z-(real) pos.z, 0);
#else
    posq[index] = pos;
#endif
}

__kernel void computePerDof(__global real4* restrict posq, __global real4* restrict posqCorrection, __global mixed4* restrict posDelta,
        __global mixed4* restrict velm, __global const real4* restrict force, __global const mixed2* restrict dt, __global const mixed* restrict globals,
        __global const mixed* restrict params, __global mixed* restrict sum, __global const float4* restrict gaussianValues,
        unsigned int gaussianBaseIndex, __global const float4* restrict uniformValues, const real energy
        ) {
    mixed stepSize = dt[0].y;
    int index = get_global_id(0);
    while (index < NUM_ATOMS) {
#ifdef LOAD_POS_AS_DELTA
        mixed4 position = loadPos(posq, posqCorrection, index)+posDelta[index];
#else
        mixed4 position = loadPos(posq, posqCorrection, index);
#endif
        mixed4 velocity = velm[index];
        real4 f = force[index];
        mixed mass = 1/velocity.w;
        if (velocity.w != 0.0) {
            int gaussianIndex = gaussianBaseIndex;
            int uniformIndex = 0;
            {
float temp0_8 = stepSize*f.x;
float temp0_9 = temp0_8/mass;
float temp0_10 = velocity.x+temp0_9;
velocity.x = temp0_10;
float temp1_8 = stepSize*f.y;
float temp1_9 = temp1_8/mass;
float temp1_10 = velocity.y+temp1_9;
velocity.y = temp1_10;
float temp2_8 = stepSize*f.z;
float temp2_9 = temp2_8/mass;
float temp2_10 = velocity.z+temp2_9;
velocity.z = temp2_10;
velm[index] = convert_mixed4(velocity);
}
{
float temp0_8 = stepSize*velocity.x;
float temp0_9 = position.x+temp0_8;
position.x = temp0_9;
float temp1_8 = stepSize*velocity.y;
float temp1_9 = position.y+temp1_8;
position.y = temp1_9;
float temp2_8 = stepSize*velocity.z;
float temp2_9 = position.z+temp2_8;
position.z = temp2_9;
storePos(posq, posqCorrection, index, position);
}

        }
        index += get_global_size(0);
    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
