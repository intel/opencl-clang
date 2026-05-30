//global include for a all OpenCL programs
//This software contains source code provided by NVIDIA Corporation.

#ifdef cl_khr_fp64
    #pragma OPENCL EXTENSION cl_khr_fp64 : enable
#endif

#ifdef cl_amd_fp64
    #pragma OPENCL EXTENSION cl_amd_fp64 : enable
#endif

#define BLOCKDIM 256
#define LOOP_UNROLL 4

// Macros to simplify shared memory addressing
#define SX(i) sharedPos[i + mul24((uint)get_local_size(0), (uint)get_local_id(1))]

// This macro is only used the multithreadBodies (MT) versions of kernel code below
#define SX_SUM(i,j) sharedPos[i + mul24((uint)get_local_size(0), (uint)j)]    // i + blockDimx * j

float4 bodyBodyInteraction(float4 ai, float4 bi, float4 bj, float softeningSquared)
{
    float4 r;

    // r_ij  [3 FLOPS]
    r.x = bi.x - bj.x;
    r.y = bi.y - bj.y;
    r.z = bi.z - bj.z;
    //r.w = 0;

    // distSqr = dot(r_ij, r_ij) + EPS^2  [6 FLOPS]
    float distSqr = r.x * r.x + r.y * r.y + r.z * r.z;
    distSqr += softeningSquared;

    // invDistCube =1/distSqr^(3/2)  [4 FLOPS (2 mul, 1 sqrt, 1 inv)]
    float invDist = rsqrt((float)distSqr);
	float invDistCube =  invDist * invDist * invDist;

    // s = m_j * invDistCube [1 FLOP]
    float s = bj.w * invDistCube;

    // a_i =  a_i + s * r_ij [6 FLOPS]
    ai.x += r.x * s;
    ai.y += r.y * s;
    ai.z += r.z * s;

    return ai;
}

// This is the "tile_calculation" function from the GPUG3 article.
float4 gravitation(float4 myPos, float4 accel, float softeningSquared, __local float4* sharedPos)
{
    // The CUDA 1.1 compiler cannot determine that i is not going to
    // overflow in the loop below.  Therefore if int is used on 64-bit linux
    // or windows (or long instead of long long on win64), the compiler
    // generates suboptimal code.  Therefore we use long long on win64 and
    // long on everything else. (Workaround for Bug ID 347697)
#ifdef _Win64
    unsigned long long i = 0;
#else
    unsigned long i = 0;
#endif

    // Here we unroll the loop

    // Note that having an unsigned int loop counter and an unsigned
    // long index helps the compiler generate efficient code on 64-bit
    // OSes.  The compiler can't assume the 64-bit index won't overflow
    // so it incurs extra integer operations.  This is a standard issue
    // in porting 32-bit code to 64-bit OSes.
    int blockDimx = get_local_size(0);
    for (unsigned int counter = 0; counter < blockDimx; )
    {
        accel = bodyBodyInteraction(accel, SX(i++), myPos, softeningSquared);
	counter++;
#if LOOP_UNROLL > 1
        accel = bodyBodyInteraction(accel, SX(i++), myPos, softeningSquared);
	counter++;
#endif
#if LOOP_UNROLL > 2
        accel = bodyBodyInteraction(accel, SX(i++), myPos, softeningSquared);
        accel = bodyBodyInteraction(accel, SX(i++), myPos, softeningSquared);
	counter += 2;
#endif
#if LOOP_UNROLL > 4
        accel = bodyBodyInteraction(accel, SX(i++), myPos, softeningSquared);
        accel = bodyBodyInteraction(accel, SX(i++), myPos, softeningSquared);
        accel = bodyBodyInteraction(accel, SX(i++), myPos, softeningSquared);
        accel = bodyBodyInteraction(accel, SX(i++), myPos, softeningSquared);
	counter += 4;
#endif
    }

    return accel;
}

// WRAP is used to force each block to start working on a different
// chunk (and wrap around back to the beginning of the array) so that
// not all multiprocessors try to read the same memory locations at
// once.
#define WRAP(x,m) (((x)<m)?(x):(x-m))  // Mod without divide, works on values from 0 up to 2m


float4 computeBodyAccel_noMT(float4 bodyPos,
                             __global float4* positions,
                             int numBodies,
                             float softeningSquared,
                             __local float4* sharedPos)
{
    float4 acc = (float4)(0,0,0,0);

    unsigned int threadIdxx = get_local_id(0);
    unsigned int threadIdxy = get_local_id(1);
    unsigned int blockIdxx = get_group_id(0);
    unsigned int blockIdxy = get_group_id(1);
    unsigned int gridDimx = get_num_groups(0);
    unsigned int blockDimx = get_local_size(0);
    unsigned int blockDimy = get_local_size(1);
    unsigned int numTiles = numBodies / mul24(blockDimx, blockDimy);

    for (unsigned int tile = blockIdxy; tile < numTiles + blockIdxy; tile++)
    {
        sharedPos[threadIdxx + mul24(blockDimx, threadIdxy)] =
            positions[WRAP(blockIdxx + tile, gridDimx) * blockDimx + threadIdxx];

        barrier(CLK_LOCAL_MEM_FENCE);// __syncthreads();

        // This is the "tile_calculation" function from the GPUG3 article.
        acc = gravitation(bodyPos, acc, softeningSquared, sharedPos);

        barrier(CLK_LOCAL_MEM_FENCE);// __syncthreads();
    }

    return acc;
}

__kernel void integrateBodies_noMT(
            __global float4* newPos,
            __global float4* newVel,
            __global float4* oldPos,
            __global float4* oldVel,
            float deltaTime,
            float damping,
            float softeningSquared,
            int numBodies,
            __local float4* sharedPos)
{
    unsigned int threadIdxx = get_local_id(0);
    unsigned int threadIdxy = get_local_id(1);
    unsigned int blockIdxx = get_group_id(0);
    unsigned int blockIdxy = get_group_id(1);
    unsigned int gridDimx = get_num_groups(0);
    unsigned int blockDimx = get_local_size(0);
    unsigned int blockDimy = get_local_size(1);

    unsigned int index = mul24(blockIdxx, blockDimx) + threadIdxx;
    float4 pos = oldPos[index];
    float4 accel = computeBodyAccel_noMT(pos, oldPos, numBodies, softeningSquared, sharedPos);

    // acceleration = force \ mass;
    // new velocity = old velocity + acceleration * deltaTime
    // note we factor out the body's mass from the equation, here and in bodyBodyInteraction
    // (because they cancel out).  Thus here force == acceleration
    float4 vel = oldVel[index];

    vel.x += accel.x * deltaTime;
    vel.y += accel.y * deltaTime;
    vel.z += accel.z * deltaTime;

    vel.x *= damping;
    vel.y *= damping;
    vel.z *= damping;

    // new position = old position + velocity * deltaTime
    pos.x += vel.x * deltaTime;
    pos.y += vel.y * deltaTime;
    pos.z += vel.z * deltaTime;

    // store new position and velocity
    newPos[index] = pos;
    newVel[index] = vel;
}







// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
