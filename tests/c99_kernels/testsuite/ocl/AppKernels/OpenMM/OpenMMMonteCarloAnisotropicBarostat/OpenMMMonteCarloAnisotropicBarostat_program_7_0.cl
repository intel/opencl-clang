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
/**
 * Scale the particle positions with each axis independent.
 */

__kernel void scalePositions(float scaleX, float scaleY, float scaleZ, int numMolecules, real4 periodicBoxSize, real4 invPeriodicBoxSize,
        real4 periodicBoxVecX, real4 periodicBoxVecY, real4 periodicBoxVecZ, __global real4* restrict posq,
        __global const int* restrict moleculeAtoms, __global const int* restrict moleculeStartIndex) {
    for (int index = get_global_id(0); index < numMolecules; index += get_global_size(0)) {
        int first = moleculeStartIndex[index];
        int last = moleculeStartIndex[index+1];
        int numAtoms = last-first;

        // Find the center of each molecule.

        real3 center = (real3) 0;
        for (int atom = first; atom < last; atom++)
            center += posq[moleculeAtoms[atom]].xyz;
        center /= (real) numAtoms;

        // Move it into the first periodic box.

        real3 oldCenter = center;
        APPLY_PERIODIC_TO_POS(center)
        real3 delta = oldCenter-center;;
        real3 scaleXYZ = (real3) (scaleX, scaleY, scaleZ);

        // Now scale the position of the molecule center.

        delta = center*(scaleXYZ-1)-delta;
        for (int atom = first; atom < last; atom++) {
            real4 pos = posq[moleculeAtoms[atom]];
            pos.xyz += delta.xyz;
            posq[moleculeAtoms[atom]] = pos;
        }
    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
