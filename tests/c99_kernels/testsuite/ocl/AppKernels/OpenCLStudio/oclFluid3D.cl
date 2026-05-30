// Copyright [2011] [Geist Software Labs Inc.]
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

typedef struct
{
    float deltaTime;
    float particleRadius;
    float cellSize;
    float mass;
    float viscosity;
    float pressure;
    float density;
    float spacing;
    float stiffness;
    float viscosityConstant;
    float pressureConstant;
    float kernelConstant;
    float velocitylimit;
} System;

#define BUCKETS 16777216

int4 gridPosition(float4 position, float cellSize)
{
    int4 gridPos;
    gridPos.x = (int)floor(position.x/cellSize);
    gridPos.y = (int)floor(position.y/cellSize);
    gridPos.z = (int)floor(position.z/cellSize);
    gridPos.w = 0;
    return gridPos;
}

uint hashKey(int4 gridPoint)
{
    const uint p1 = 73856093;
    const uint p2 = 19349663;
    const uint p3 = 83492791;
    uint n = p1*gridPoint.x ^ p2*gridPoint.y ^ p3*gridPoint.z;
    n %= BUCKETS;
    return n;
}

//
// map particles into voxel grid
//
__kernel void clHash(__global uint* cell, __global uint* index, __global const float4* position, __global const System* param)
{
    const uint particle = get_global_id(0);

    int4 grid = gridPosition(position[particle], param->cellSize);
    cell[particle] = hashKey(grid);
    index[particle] = particle;
}

__kernel void clReorder(__global const uint *index, __global const float4* posIn, __global const float4* velIn, __global float4* posOut,  __global float4* velOut)
{
    const uint particle= get_global_id(0);
    uint sortedIndex = index[particle];
    posOut[particle] = posIn[sortedIndex];
    velOut[particle] = velIn[sortedIndex];
}

//
// find particles per voxel
//
__kernel void clInitBounds(__global uint* cellStart, __global uint* cellEnd)
{
    const uint index = get_global_id(0);
    cellStart[index] = 0xFFFFFFFFU;
    cellEnd[index] = 0xFFFFFFFFU;
}

__kernel void clFindBounds(__global uint* cellStart, __global uint* cellEnd, __global const uint* cell, __local uint *localHash)
{
    const uint numParticles = get_global_size(0);
    const uint particle = get_global_id(0);
    const uint threadid = get_local_id(0);

    uint hash = cell[particle];

    localHash[threadid + 1] = hash;
    if(particle > 0 && threadid == 0)
    {
        localHash[0] = cell[particle - 1];
    }
    barrier(CLK_LOCAL_MEM_FENCE);

    if(particle == 0)
    {
        cellStart[hash] = 0;
        return;
    }
    if(hash != localHash[threadid])
    {
        cellEnd[localHash[threadid]]  = cellStart[hash] = particle;
    }
    if(particle == numParticles - 1)
    {
        cellEnd[hash] = numParticles;
    }
}


//
// Compute smoothed particle hydrodynamics
//
#ifndef M_PI_F
	#define M_PI_F M_PI
#endif

#define DensityVariable(smoothinglength, distance) pow(smoothinglength*smoothinglength - distance*distance, 3.0f)
#define DensityConstant(smoothinglength) (315.0/(64.0*M_PI_F* pow(smoothinglength, 9.0f)))
#define PressureVariable(smoothinglength, vector, distance) (vector*(smoothinglength-distance)*(smoothinglength-distance))
#define PressureConstant(smoothinglength) (-45.0 / (M_PI_F * pow(smoothinglength, 6.0f)))
#define ViscosityVariable(smoothinglength, distance) (smoothinglength-distance)
#define ViscosityConstant(smoothinglength) (-45.0/(M_PI_F * pow(smoothinglength, 6.0f)))

__kernel void clInitFluid(__global System* param)
{
    param->deltaTime = 0.005;

    param->mass = 0.006;
    param->density = 1000;
    param->viscosity = 6.0;
    param->pressure = 0;
    param->velocitylimit = 500;
    param->stiffness =  1;

    param->spacing = 0.87*pow(param->mass/param->density, 1/3.0f);
    param->particleRadius = 0.5*param->spacing;
    param->cellSize = 2.0*param->spacing;

    param->kernelConstant = DensityConstant(param->cellSize);
    param->viscosityConstant = -param->viscosity*ViscosityConstant(param->cellSize);
    param->pressureConstant = -PressureConstant(param->cellSize);
}

__kernel void clCalculateDensity(__global float4* position, __global float4* velocity, __global const uint* cellStart, __global const uint* cellEnd, __global const System* param)
{
    uint particle = get_global_id(0);

    float4 posI = position[particle];

    float density = 0;
    int4 grid = gridPosition(posI, param->cellSize);

    int count =0;
    for(int z = -1; z <= 1; z++)
    {
        for(int y = -1; y <= 1; y++)
        {
            for(int x = -1; x <= 1; x++)
            {
                uint cell = hashKey(grid + (int4)(x, y, z, 0));
                uint start = cellStart[cell];
                if (start != 0xFFFFFFFFU)
                {
                    uint end = cellEnd[cell];
                    for(uint j = start; j < end; j++)
                    {
                        if(j != particle)
                        {
                            float4 vector = posI - position[j];
                            vector.w = 0;
                            float vlen = fast_length(vector);
                            if (vlen < param->cellSize)
                            {
                                density += DensityVariable(param->cellSize,vlen);
                                count++;
                            }
                        }
                    }
                }
            }
        }
    }
    if (count > 2)
    {
        density = max(1.0f, param->mass * param->kernelConstant* density);
        position[particle].w = density; // density
        velocity[particle].w = param->pressure + param->stiffness * (density - param->density);  // pressure
    }
    else
    {
        position[particle].w = param->density; // density
        velocity[particle].w = param->pressure;  // pressure
    }
}

__kernel void clCalculateForces(__global const float4* position, __global const float4* velocity, __global float4* force,  __global const uint* index, __global const uint* cellStart, __global const uint* cellEnd, __global const System* param)
{
    uint particle = get_global_id(0);

    //float4 gravity = (float4)(0,0,1,0);
    float4 posI = position[particle];
    float4 velI = velocity[particle];

    float4 pressure = 0;
    float4 viscosity = 0;
    int4 grid = gridPosition(posI, param->cellSize);
    for(int z = -1; z <= 1; z++)
    {
        for(int y = -1; y <= 1; y++)
        {
            for(int x = -1; x <= 1; x++)
            {
                uint cell = hashKey(grid + (int4)(x, y, z, 0));
                uint start = cellStart[cell];
                if(start != 0xFFFFFFFFU)
                {
                    uint end = cellEnd[cell];
                    for(uint j = start; j < end; j++)
                    {
                        if(j != particle)
                        {
                            float4 posJ = position[j];

                            float4 vector = posI - posJ;
                            vector.w = 0;
                            float vlen = fast_length(vector);
                            if (vlen < param->cellSize)
                            {
                                float4 velJ = velocity[j];

                                float density2 = posI.w*posJ.w;
                                float pressure2 = velI.w+velJ.w;

                                pressure += pressure2/density2*PressureVariable(param->cellSize,vector/vlen,vlen);
                                //vlen = min(vlen, 0.01*param->particleRadius);
                                viscosity += (velJ-velI)/density2*ViscosityVariable(param->cellSize,vlen);
                            }
                        }
                    }
                }
            }
        }
    }

    float4 forceI = force[index[particle]];
    forceI += (param->pressureConstant*pressure + param->viscosityConstant*viscosity)*param->mass;
    forceI.w = 0;
    force[index[particle]] = forceI;
}


__kernel void clIntegrateForce(__global float4* velIn, __global float4* forceIn,  __global const System* param)
{
    const uint particle = get_global_id(0);

    float4 vel = velIn[particle];
    float4 force = forceIn[particle];
    float speed = fast_length(force);
    if (speed > param->velocitylimit)
    {
        force *= param->velocitylimit / speed;
    }
    vel += force * param->deltaTime;
    velIn[particle] = vel;
}

__kernel void clEmitter(__global float4* posIn, __global float4* velIn, uint emit, float emitSpeed, __global const System* param)
{
    const uint particle = get_global_id(0);
    if (particle > emit && particle < emit+100)
    {
	int index = emit - particle;
	posIn[particle] = (float4)(index/10*2*param->particleRadius,0.6,0.6+index%10*2*param->particleRadius,1);
	velIn[particle] = (float4)(0,emitSpeed,0,1);
    }
}

__kernel void clIntegrateVelocity(__global float4* posIn, __global float4* velIn, __global const System* param)
{
    const uint particle = get_global_id(0);

    float4 pos = posIn[particle];
    float4 vel = velIn[particle];
    pos += vel * param->deltaTime;
    posIn[particle] = pos;
}

__kernel void clGravity(__global float4* force, float4 gravity)
{
    uint particle = get_global_id(0);
    force[particle] = -9.8f*gravity;
}

//
// Collide with bounding box
//

#define EPSILON  0.00001f

#define BOUNDARY_STIFFNESS  2000
#define BOUNDARY_DAMPENING  256

float4 repulsionForce(float4 normal, float4 velocity, float dist, __global const System* param)
{
    return normal*(BOUNDARY_STIFFNESS*dist - BOUNDARY_DAMPENING*dot(normal, velocity));
}


__kernel void clClipBox(__global const float4* position, __global const float4* velocity, __global float4* force, __global const uint* index, __global const System* param, float4 minBounds, float4 maxBounds)
{
    const uint particle = get_global_id(0);

    float4 pos = position[particle];
    float4 vel = velocity[particle];
    float4 forceI = force[index[particle]];


    float diff = param->particleRadius - (pos.y - minBounds.y);
    if (diff > EPSILON)
    {
        forceI += repulsionForce((float4)(0,1,0,0), vel, diff, param);
    }

    diff = param->particleRadius - (maxBounds.y - pos.y);
    if (diff > EPSILON)
    {
        forceI += repulsionForce((float4)(0,-1,0,0), vel, diff, param);
    }

    diff = param->particleRadius - (pos.z - minBounds.z);
    if (diff > EPSILON )
    {
        forceI += repulsionForce((float4)(0,0,1,0), vel, diff, param);
    }

    diff = param->particleRadius - (maxBounds.z - pos.z);
    if (diff > EPSILON)
    {
        forceI +=  repulsionForce((float4)(0,0,-1,0), vel, diff, param);
    }

    diff = param->particleRadius - (pos.x - minBounds.x);
    if (diff > EPSILON )
    {
        forceI += repulsionForce((float4)(1,0,0,0), vel, diff, param);
    }

    diff = param->particleRadius - (maxBounds.x - pos.x);
    if (diff > EPSILON)
    {
        forceI += repulsionForce((float4)(-1,0,0,0), vel, diff, param);
    }

    force[index[particle]] = forceI; //(float4)(0,0,-0.4, 1);
}


//
// Collide with BVH
//

typedef struct
{
    float4 bbMin;
    float4 bbMax;
    uint left;
    uint right;
    uint bit;
    uint trav;
} BVHNode;

#define QUEUE_SIZE 256

bool collideTriangle(uint triangle, __global const uint* index, __global const float4* vertex, float4* pos, float4* vel, float4* force,__global const System* param)
{
    float4 V0 = vertex[index[triangle+0]];
    float4 V1 = vertex[index[triangle+1]];
    float4 V2 = vertex[index[triangle+2]];
    V0.w = 0;
    V1.w = 0;
    V2.w = 0;
    (*pos).w = 0.0;
    (*pos).w = 0.0;

    float4 u = V1 - V0;
    float4 v = V2 - V0;
    float4 n = cross(u,v);
    if (dot(n,n) == 0)
    {
        return false;
    }

    float4 w0 = *pos - V0;
    float4 displacement = *vel*param->deltaTime;

    float a = dot(n,w0);
    if (dot(n,w0) < 0)
    {
        return false; // on the other side of the triangle
    }

    float b = dot(n,displacement);
    if (fabs(b) < 0.000001)
    {
        // ray is parallel to triangle plane
        if (a == 0)             // ray lies in triangle plane
            return false;
        else
            return false;   // ray disjoint from plane
    }

    float r = -a/b;
    if (r < 0.0)
    {
        return false;       // ray goes away from triangle
    }

    float4 I = *pos + r * displacement;   // intersect point of ray and plane

    // is I inside T?
    float uu = dot(u,u);
    float uv = dot(u,v);
    float vv = dot(v,v);
    float4 w = I - V0;
    float wu = dot(w,u);
    float wv = dot(w,v);
    float D = uv * uv - uu * vv;

    // get and test parametric coords
    float s = (uv * wv - vv * wu) / D;
    if (s < 0.0 || s > 1.0)        // I is outside T
        return false;
    float t = (uv * wu - uu * wv) / D;
    if (t < 0.0 || (s + t) > 1.0)  // I is outside T
        return false;

    n = normalize(n);

    float4 Vc = *pos+displacement-V0;
    float dist = dot(Vc,n);
    float depth = param->particleRadius - dist;

    // particle penetrates surface
    if (depth > 0)
    {
        float4 dPos = normalize(displacement)*dot(n,displacement)*depth;
        float4 dTangent = *vel - dot(n,*vel)*n;

        *force += dTangent/param->deltaTime;
        *force += param->pressureConstant/param->density*PressureVariable(param->cellSize,n,dist)*param->mass;
        *pos += dPos;
        *vel = 0;
        return true;
    }

    return false;
}


int intersectBox(float4 r_o, float4 r_d, float4 boxmin, float4 boxmax, float *tnear, float *tfar)
{
    // compute intersection of ray with all six bbox planes
    float4 invR = (float4)(1.0f,1.0f,1.0f,1.0f) / normalize(r_d);
    float4 tbot = invR * (boxmin - r_o);
    float4 ttop = invR * (boxmax - r_o);

    // re-order intersections to find smallest and largest on each axis
    float4 tmin = min(ttop, tbot);
    float4 tmax = max(ttop, tbot);

    // find the largest tmin and the smallest tmax
    float largest_tmin = max(max(tmin.x, tmin.y), max(tmin.x, tmin.z));
    float smallest_tmax = min(min(tmax.x, tmax.y), min(tmax.x, tmax.z));

    *tnear = largest_tmin;
    *tfar = smallest_tmax;

    return smallest_tmax > largest_tmin;
}

bool collideAABB(__global const BVHNode* node, float4 pos, float4 vel, __global const System* param)
{
    float near;
    float far;
    if (intersectBox(pos, vel, node->bbMin, node->bbMax, &near, &far))
    {
        return near < max(param->particleRadius, fast_length(vel));
    }
    return false;
}

__kernel void clCollideBVH(__global float4* forceOut,
                           __global float4* position,
                           __global float4* velocity,
                           __global const System* param,
                           __global const BVHNode* bvh,
                           uint bvhRoot,
                           __global const uint* triangle,
                           __global const float4* vertex)
{
    uint particle = get_global_id(0);

    float4 posI = position[particle];
    float4 velI = velocity[particle];
    float4 forceI = forceOut[particle];

    uint queue[QUEUE_SIZE];
    uint head = 0;
    uint tail = 1;
    queue[0] = bvhRoot;

    while (head != tail)
    {
        uint iter = queue[head];
        head = (head+1)%QUEUE_SIZE;

        uint left = bvh[iter].left;
        uint right = bvh[iter].right;
        if (left == right)
        {
            // leaf .. intersect
            if (collideTriangle(bvh[iter].bit*3, triangle, vertex, &posI, &velI, &forceI, param))
            {
                position[particle] = posI;
                velocity[particle] = velI;
                forceOut[particle] = forceI;
                break;
            }
        }
        else
        {
            if (collideAABB(&bvh[left], posI, velI, param))
            {
                queue[tail] = left;
                tail = (tail+1)%QUEUE_SIZE;
            }
            if (collideAABB(&bvh[right], posI, velI, param))
            {
                queue[tail] = right;
                tail = (tail+1)%QUEUE_SIZE;
            }
        }
    }
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
