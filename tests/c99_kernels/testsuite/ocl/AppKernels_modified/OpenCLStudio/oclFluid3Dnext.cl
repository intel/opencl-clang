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
	float density;
	float stiffness0;
	float stiffness1;
	float viscosity0;
	float viscosity1;
	float radius;

	float cellSize;
	int cellCountX;
	int cellCountY;

} System;


//
// map particles into voxel grid
//
__kernel void clHash(__global uint* cell, __global uint* index, __global float4* state, __global const System* param)
{
    const uint particle = get_global_id(0);
    int2 grid;
    grid.x = (int)floor(state[particle].x/param->cellSize);
    grid.y = (int)floor(state[particle].y/param->cellSize);
    cell[particle] = grid.y*param->cellCountX + grid.x;
    index[particle] = particle;
}

__kernel void clReorder(__global const uint *index, __global const float4* stateIn, __global float4* stateOut)
{
    const uint particle= get_global_id(0);
	uint sortedIndex = index[particle];
	stateOut[particle] = stateIn[sortedIndex];
}

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

__kernel void clInitFluid(__global System* param)
{
	param->deltaTime = 0.0333333333;

	param->density = 10000.00;
	param->stiffness0 =  0.004;
	param->stiffness1 =  0.01;
	param->viscosity0 =  1;
	param->viscosity1 =  1;

	float spacing = 1;//0.2516;
	param->radius = 12;

	param->cellSize = 1;
	param->cellCountX = 1024/param->cellSize;
	param->cellCountY = 768/param->cellSize;
	//param->particleRadius = 0.87*pow(param->mass/param->density, 1/3.0f);
	param->particleRadius = 0.87*pow(1.0f/param->density, 1/3.0f);
}


float W(float h, float q)
{
	float value = 0;

	q/=h;

	if (q < 1)
	{
		value = 1.0f-3.0f/2.0f*q*q+3.0f/4.0f*q*q*q;
	}
	else if (q < 2.0f)
	{
		q = 2.0f - q;
		value = 1.0f/4.0f*q*q*q;
	}

	return 2.0f/(3.0f*h)*value;
}

__kernel void clComputePressure(__global float4* state, __global float2* pressure, __global const uint* cellStart, __global const uint* cellEnd, __global const System* param)
{
    uint particle = get_global_id(0);
    float4 stateI = state[particle];

    int2 grid;
    grid.x = (int)floor(stateI.x/param->cellSize);
    grid.y = (int)floor(stateI.y/param->cellSize);

	int x0=max(grid.x-1,0);
	int x1=min(grid.x+1,param->cellCountX-1);
	int y0=max(grid.y-1,0);
	int y1=min(grid.y+1,param->cellCountY-1);

    float density = 0;
	for(int x = x0; x <= x1; x++)
	{
		for(int y = y0; y <= y1; y++)
		{
			int cell = y*param->cellCountX + x;

			uint start = cellStart[cell];
			if (start != 0xFFFFFFFFU)
			{
				uint end = cellEnd[cell];
				for(uint j = start; j < end; j++)
				{
					if(j != particle)
					{
						float4 stateJ = state[j];
						float2 rIJ = stateJ.xy - stateI.xy;
						density += W(param->cellSize, length(rIJ));
					}
				}
			}
		}
	}
	if (density != 0)
	{
		float tait = 0.87*(pow(density/100.0f, 7.0f)-1.0f);
		pressure[particle] = tait/(density*density);
	}
	else
	{
		pressure[particle] = 0;
	}
}

__kernel void clComputeForces(__global float4* state, __global float2* pressure, __global float2* force, __global const uint* cellStart, __global const uint* cellEnd, __global const System* param)
{
    uint particle = get_global_id(0);
    float2 pressureI = pressure[particle];
    float4 stateI = state[particle];

    int2 grid;
    grid.x = (int)floor(stateI.x/param->cellSize);
    grid.y = (int)floor(stateI.y/param->cellSize);

	int x0=max(grid.x-1,0);
	int x1=min(grid.x+1,param->cellCountX-1);
	int y0=max(grid.y-1,0);
	int y1=min(grid.y+1,param->cellCountY-1);

	float2 Fviscosity = 0;
	float2 Fpressure = 0;
	float2 Fsurface = 0;

    float2 dsp = 0;
	for(int x = x0; x <= x1; x++)
	{
		for(int y = y0; y <= y1; y++)
		{
			int cell = y*param->cellCountX + x;

			uint start = cellStart[cell];
			if (start != 0xFFFFFFFFU)
			{
				uint end = cellEnd[cell];
				for(uint j = start; j < end; j++)
				{
					if(j != particle)
					{
						float4 stateJ = state[j];

						float2 rIJ = stateJ.xy - stateI.xy;
						float r = length(rIJ);
						float2 w = W(param->cellSize, r);
						float2 g = rIJ/r*w;

						float2 pressureJ = pressure[j];

						Fpressure = -(pressureI.x + pressureJ.x)*g;
						Fsurface = rIJ*w;
						//Fviscosity +=
						//Ftension +=
					}
				}
			}
		}
	}

	force[particle] = (Fpressure + Fviscosity + 0.25f*Fsurface) - (float2)(0,9.81);
}

__kernel void clIntegrateForce(__global float4* state, __global float2* force, __global uint* index, __global const System* param)
{
    const uint particle = get_global_id(0);
	uint sorted = index[particle];
	state[sorted].zw += force[particle]*param->deltaTime;
}

__kernel void clIntegrateVelocity(__global float4* state, __global const System* param)
{
    const uint particle = get_global_id(0);
	float4 stateI = state[particle];

	stateI.xy += stateI.zw*param->deltaTime;
	stateI.xy = clamp(stateI.xy, (float2)(1,1), (float2)(1024,768));
	state[particle] = stateI;
}


//
//
//
#define QUEUE_SIZE 256

typedef struct
{
	float2 bbMin;
	float2 bbMax;
	int left;
	int right;
	uint bit;
	uint trav;
} BVHNode;

bool collideLine(uint triangle, __global const float2* vertex, float4* state,__global const System* param)
{
	return true;
}

int intersectBox(float2 r_o, float2 r_d, float2 boxmin, float2 boxmax, float *tnear, float *tfar)
{
    // compute intersection of ray with all six bbox planes
    float2 invR = (float2)(1.0f,1.0f) / normalize(r_d);
    float2 tbot = invR * (boxmin - r_o);
    float2 ttop = invR * (boxmax - r_o);

    // re-order intersections to find smallest and largest on each axis
    float2 tmin = min(ttop, tbot);
    float2 tmax = max(ttop, tbot);

/*
    // find the largest tmin and the smallest tmax
    float largest_tmin = max(max(tmin.x, tmin.y), max(tmin.x, tmin.z));
    float smallest_tmax = min(min(tmax.x, tmax.y), min(tmax.x, tmax.z));

    *tnear = largest_tmin;
    *tfar = smallest_tmax;
*/
    // find the largest tmin and the smallest tmax
    float largest_tmin = max(tmin.x, tmin.y);
    float smallest_tmax = min(tmax.x, tmax.y);

    *tnear = largest_tmin;
    *tfar = smallest_tmax;

    return smallest_tmax > largest_tmin;
}

bool collideAABB(__global const BVHNode* node, float4 particle, __global const System* param)
{
    float near;
    float far;
    if (intersectBox(particle.xy, particle.zw, node->bbMin, node->bbMax, &near, &far))
    {
        return near < fast_length(particle.zw);
        //return near < max(param->particleRadius, fast_length(vel));
    }
    return false;
}

__kernel void clCollideBVH(__global float4* state,
                           __global const System* param,
                           __global const BVHNode* bvh,
                           uint bvhRoot,
                           __global const uint2* vertex)
{
    uint particle = get_global_id(0);

    float4 stateI = state[particle];

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
			/*
			uint2 l0 = vertex[bvh[iter].bit*2+0];
			uint2 l1 = vertex[bvh[iter].bit*2+1];
			uint2 l = l1 - l0;

            // leaf .. intersect
            if (collideLine(bvh[iter].bit*2, vertex, &stateI,  param))
            {
                state[particle] = stateI;
                break;
            }
			*/
        }
        else
        {
            if (collideAABB(&bvh[left], stateI, param))
            {
                queue[tail] = left;
                tail = (tail+1)%QUEUE_SIZE;
            }
            if (collideAABB(&bvh[right], stateI, param))
            {
                queue[tail] = right;
                tail = (tail+1)%QUEUE_SIZE;
            }
        }
    }
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
