/*
 * For a description of the algorithm and the terms used, please see the
 * documentation for this sample.
 *
 * Each work-item invocation of this kernel, calculates the position for
 * one particle
 *
 * Work-items use local memory to reduce memory bandwidth and reuse of data
 */



__kernel

void

nbody_sim(

    __global float4* pos ,

    __global float4* vel,

    int numBodies,

    float deltaTime,

    float epsSqr,

    __local float4* localPos,
    __global float4* newPosition,
    __global float4* newVelocity)

{
    unsigned int tid = get_local_id(0);

    unsigned int gid = get_global_id(0);

    unsigned int localSize = get_local_size(0);



    // Number of tiles we need to iterate

    unsigned int numTiles = numBodies / localSize;



    // position of this work-item

    float4 myPos = pos[gid];

    float4 acc = (float4)(0.0f, 0.0f, 0.0f, 0.0f);



    for(int i = 0; i < numTiles; ++i)

    {

        // load one tile into local memory

        int idx = i * localSize + tid;

        localPos[tid] = pos[idx];



        // Synchronize to make sure data is available for processing

        barrier(CLK_LOCAL_MEM_FENCE);



        // calculate acceleration effect due to each body

        // a[i->j] = m[j] * r[i->j] / (r^2 + epsSqr)^(3/2)

        for(int j = 0; j < localSize; ++j)

        {

            // Calculate acceleartion caused by particle j on particle i

            float4 r = localPos[j] - myPos;

            float distSqr = r.x * r.x  +  r.y * r.y  +  r.z * r.z;

            float invDist = 1.0f / sqrt(distSqr + epsSqr);

            float invDistCube = invDist * invDist * invDist;

            float s = localPos[j].w * invDistCube;



            // accumulate effect of all particles

            acc += s * r;

        }



        // Synchronize so that next tile can be loaded

        barrier(CLK_LOCAL_MEM_FENCE);

    }



    float4 oldVel = vel[gid];



    // updated position and velocity

    float4 newPos = myPos + oldVel * deltaTime + acc * 0.5f * deltaTime * deltaTime;

    newPos.w = myPos.w;



    float4 newVel = oldVel + acc * deltaTime;



    // write to global memory

    newPosition[gid] = newPos;

    newVelocity[gid] = newVel;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
