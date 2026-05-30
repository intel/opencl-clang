#define PARTICLES_PER_SIDE 128
#define TOP_Y 28.500000
#define REST_LENGTH 0.100000
#define NEIGHBOUR_COUNT 8
#define PARTICLES_PER_SIDE 128
#define TOP_Y 28.500000
#define REST_LENGTH 0.100000
#define NEIGHBOUR_COUNT 8
/**
* Soft body simulation
*
* Copyright 2011 by Rightware. All rights reserved.
*/

/** These variables are by default appended by benchmark to this file before compiling. Default ones are used in compiler test. */
#ifndef PARTICLES_PER_SIDE
#define PARTICLES_PER_SIDE 128
#endif
#ifndef REST_LENGTH
#define REST_LENGTH 0.35f
#endif
#ifndef TOP_Y
#define TOP_Y 20.0f
#endif
#ifndef NEIGHBOUR_COUNT
#define NEIGHBOUR_COUNT 8
#endif

#define VERTEX_DATA_SIZE 8

#define INDEX(x, y) ((x) + ((PARTICLES_PER_SIDE) * (y)))

#define COLLISION_OBJECT_COUNT 9
__constant float collisionObjectPositionArray[COLLISION_OBJECT_COUNT * 4] =
{
     2.0, 0.0, 0.0, 0.0,
    -4.1, 0.0, 0.0, 0.0,
    -1.7, 3.5, -0.2, 0.0,
    -1.7, 0.0, 3.8, 0.0,
    -1.7, 0.0, -3.77, 0.0,
    -4.1, 0.0, -7.5, 0.0,
    -4.1, 0.0, -12.5, 0.0,
    -4.85, 3.5, 3.02, 0.0,
    -4.85, 6.42, -0.30, 0.0
};


__kernel void resetFaceNormals(__global float4* faceNormals)
{
    unsigned int i = get_global_id(0);
    faceNormals[i] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
}

__kernel void calculateFaceNormals(__global unsigned int* indexes, __global float4* positions, __global float4* faceNormals)
{
    unsigned int i = get_global_id(0);
    unsigned int offset = i * 3;
    unsigned int index1 = indexes[offset];
    unsigned int index2 = indexes[offset + 1];
    unsigned int index3 = indexes[offset + 2];

    float4 p1 = positions[index1];
    float4 p2 = positions[index2];
    float4 p3 = positions[index3];

    float4 v1 = p3 - p1;
    float4 v2 = p2 - p1;
    float4 d = cross(v1, v2);

    faceNormals[i] = fast_normalize(d);
}

__kernel void averageFaceNormals(__global float* vbo, __global float4* faceNormals, __global int* faceIndexes)
{
    unsigned int n;
    unsigned int i = get_global_id(0);
    unsigned int offset = i * 8;
    float4 normal = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
    for(n = 0; n < 8; ++n)
    {
        unsigned int faceIndex = faceIndexes[offset + n];
        if(faceIndex != -1)
        {
            normal += faceNormals[faceIndex];
        }
    }

    normal = fast_normalize(normal);

    /* Set the position to VBO. */
    {
        unsigned int vboOffset = i * VERTEX_DATA_SIZE;
        vbo[vboOffset + 4] = normal.x;
        vbo[vboOffset + 5] = normal.y;
        vbo[vboOffset + 6] = normal.z;
        vbo[vboOffset + 7] = 0.0f;
    }
}

__kernel void updateVBO(__global float4* positions, __global float* vbo)
{
    unsigned int i = get_global_id(0);
    unsigned int index = i * VERTEX_DATA_SIZE;

    vbo[index + 0] = positions[i].x;
    vbo[index + 1] = positions[i].y;
    vbo[index + 2] = positions[i].z;
    vbo[index + 3] = 0.0f;
}

__kernel void integrateSoftBody(__global float4* positions, __global float4* oldPositions, __global float4* forces)
{
    int i = get_global_id(0);
    /* Constant step size. */
    const float dt = 0.01f;
    float4 temp = positions[i];
    const float dampen = 0.93f;
    positions[i] += (positions[i] - oldPositions[i]) * dampen + forces[i] * dt * dt;
    oldPositions[i] = temp;
}

/** This kernel is and must be executed so that neighbour offsets never contain links to a particle that is also accessed in the same kernel execution.  */
__kernel void satisfyConstraints(__global float4* positions, __global int* neighbours, __global int* offsets, float tick, int startOffset)
{
    int n;
    int i = offsets[get_global_id(0)] + startOffset;

    const float restlength = REST_LENGTH;
    for(int z = 0; z < NEIGHBOUR_COUNT; ++z)
    {
        // Solve constraints in order 4,5,6,7,0,1,2,3. This reduces jitter on cloth edges.
        int j = 7 - (z < 4 ? (3-z) : NEIGHBOUR_COUNT - (z - 4) - 1);

        float rest = restlength;
        int neighbourTableOffset = i * NEIGHBOUR_COUNT + j;
        int index = neighbours[neighbourTableOffset];

        if(index >= 0)
        {
            if(j>2)
            {
                rest = half_sqrt(rest*rest + rest*rest);
            }
            if(j>4)
            {
                rest = half_sqrt((2.f*rest)*(2.f*rest)+(1.f*rest)*(1.f*rest));
            }

            float4 x1 = positions[i];
            float4 x2 = positions[index];

            float4 delta;
            float deltaDot;
            float4 deltaProjected;
            float deltalength;
            float diff;
            float separate;

            delta = x1 - x2;
            deltaDot = dot(delta, delta);

            const float softness = 0.9f;
            deltalength = half_sqrt(deltaDot);
            diff = (deltalength - rest) / deltalength;
            separate = 0.5 * diff * softness;

            deltaProjected = delta * separate;

            positions[i] -= deltaProjected;
            positions[index] += deltaProjected;
        }
        barrier(CLK_GLOBAL_MEM_FENCE);
    }

    for(n = 0; n < COLLISION_OBJECT_COUNT; ++n)
    {
        const float ballSize = 5.4f;
        int offset = n * 4;
        const float offsetZ = 7.0f;
        float4 ball = (float4)(collisionObjectPositionArray[offset], collisionObjectPositionArray[offset + 1],
            collisionObjectPositionArray[offset + 2] + offsetZ, collisionObjectPositionArray[offset + 3]);
        float4 d = positions[i] - ball;
        float len = length(d);
        const float dd = ballSize;
        if(len < dd)
        {
            d /= len;
            positions[i] -= d * (float4)(len - dd);
        }
    }

    const float4 minimum = (float4)(-250.f,  1.f, -250.0f, 0.0f);
    const float4 maximum = (float4)( 250.f,  100.f, 250.0f, 0.0f);
    positions[i] = max(positions[i], minimum);
    positions[i] = min(positions[i], maximum);

    float distance = (PARTICLES_PER_SIDE - 1) * 0.1f * 1.f;
    float offset = sin(tick * 0.03f) * distance * 1.20f;
    float offset2 = sin(tick * 0.026f) * distance * 1.15f;

    positions[INDEX(0, 0)] = (float4)(-distance * 0.5 + offset, TOP_Y, offset2 + distance, 0.0f);
    positions[INDEX(PARTICLES_PER_SIDE - 1, 0)] = (float4)(distance + offset, TOP_Y, offset2, 0.0f);
}

__kernel void applyForces(__global float4* forces)
{
    int i = get_global_id(0);
    forces[i].y = -250.f;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
