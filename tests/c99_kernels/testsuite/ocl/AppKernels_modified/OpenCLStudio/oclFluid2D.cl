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
 	float dT;

	float h;
	float containerW;
	float containerH;
	float cellSize;
	int cellCountX;
	int cellCountY;

	float p0;
	float vmax;
	float B;

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
	param->dT = 0.00333333333;

	float spacing = 1;//0.2516;

	param->h = 0.0075;  // meters
	param->containerW = 3.22; // meters
	param->containerH = 1; // meters
	param->cellSize = 2*param->h;
	param->cellCountX = param->containerW/param->cellSize;
	param->cellCountY = param->containerH/param->cellSize;

	param->p0 = 1000.0f;  // kPa
	param->vmax = 10.0f;  // maximum expected fluid velocity
	param->B = 100.0f*param->p0*param->vmax*param->vmax/7.0;

}

__kernel void clInitPressure(__global float2* pressure, __global System* param)
{
    uint particle = get_global_id(0);

	pressure[particle].x = param->p0;
	pressure[particle].y = 0;
}


/*
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
*/

/*
need derivate.
float Wendland(float h, float q)
{
	q/=h;
	if (q <= 2.0f)
	{
		return 0.0348151438/(h*h)*pow(2.0f - q,4.0f)*( 1.0f + 2*q);
	}
	return 0;
}
*/

float W(float h, float q)
{
	float r2 = q*q;
	float h2 = h*h;
	return 0.39894228/h*exp(-0.5*r2/h2);
}


float dW(float h, float q)
{
	float r2 = q*q;
	float h2 = h*h;
	return q*W(h,q);
}



__kernel void clIntegrateVelocity0(__global float4* state, __global const System* param)
{
    uint particle = get_global_id(0);
    float4 stateI = state[particle];

	stateI.xy += stateI.zw*param->dT;
	stateI.zw += stateI.zw*param->dT;
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

    float p = pressure[particle].x;
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
						float2 r = stateI.xy - stateJ.xy;
						float2 v = stateI.zw - stateJ.zw;
						float d = length(r);
						r/=d;

						p += dot(v,r)*dW(param->h, d);
					}
				}
			}
		}
	}
	pressure[particle].x = p;
	pressure[particle].y = param->B*(pow(p/param->p0,7)-1);
}

__kernel void clComputeForces(__global float4* state, __global float2* pressure, __global float2* force, __global const uint* cellStart, __global const uint* cellEnd, __global const System* param)
{
    uint particle = get_global_id(0);
    float2 pI = pressure[particle];
    float4 stateI = state[particle];

    int2 grid;
    grid.x = (int)floor(stateI.x/param->cellSize);
    grid.y = (int)floor(stateI.y/param->cellSize);

	int x0=max(grid.x-1,0);
	int x1=min(grid.x+1,param->cellCountX-1);
	int y0=max(grid.y-1,0);
	int y1=min(grid.y+1,param->cellCountY-1);

	float2 Fviscosity = 0;
	float2 Fp  = 0;
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
						float2 r = stateI.xy - stateJ.xy;
						float2 v = stateI.zw - stateJ.zw;
						float d = length(r);
						r/=d;
						float w = dW(param->h, d);

						float2 pJ = pressure[j];
						Fp = -(pI.y/(pI.x*pI.x) + pJ.y/(pJ.x*pJ.x))*w*r;

						//Fviscosity +=
						//Ftension +=
					}
				}
			}
		}
	}

	force[particle] = (Fp + Fviscosity + 0.25f*Fsurface) - (float2)(0,9.81);
}



__kernel void clIntegrateHalf(__global float4* state, __global const System* param)
{
    uint particle = get_global_id(0);
    float4 stateI = state[particle];

	stateI.xy += stateI.zw*param->dT;
}

__kernel void clIntegrateForce(__global float4* state, __global float2* force, __global uint* index, __global const System* param)
{
    const uint particle = get_global_id(0);
	uint sorted = index[particle];
	state[sorted].zw += force[particle]*param->dT;
}

__kernel void clIntegrateVelocity(__global float4* state, __global const System* param)
{
    const uint particle = get_global_id(0);
	float4 stateI = state[particle];

	stateI.xy += stateI.zw*param->dT;
	stateI.xy = clamp(stateI.xy, (float2)(param->h,param->h), (float2)(param->containerW-param->h,param->containerH-param->h));
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

bool collideAABB(__global const BVHNode* node, float4 particle, __global const System* param)
{
    float2 invR = (float2)(1.0f,1.0f) / normalize(particle.zw);
    float2 tbot = invR * (node->bbMin - particle.xy);
    float2 ttop = invR * (node->bbMax - particle.xy);

    float2 tmin = min(ttop, tbot);
    float2 tmax = max(ttop, tbot);

    // find the largest tmin and the smallest tmax
    float near = max(tmin.x, tmin.y);
    float far = min(tmax.x, tmax.y);

	if (far >= near)
	{
        return near < fast_length(particle.zw*param->dT);
    }
    return false;
}

__kernel void clCollideBVH(__global float4* state,
                           __global const System* param,
                           __global const BVHNode* bvh,
                           uint bvhRoot,
                           __global const float2* line)
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
			float4 stateJ = state[particle];

			float2 u0 = line[bvh[iter].bit*2+0];
			float2 u1 = line[bvh[iter].bit*2+1];
			float2 u = u1 - u0;

			float2 v0 = stateJ.xy;
			float2 v1 = stateJ.xy+stateJ.zw* param->dT;
			float2 v = v1 - v0;

			float2 w = u0 - v0;
			float D = u.x*v.y - u.y*v.x;
			float s = v.x*w.y - v.y*w.x;
			float t = u.x*w.y - u.y*w.x;

			if (fabs(D) > .000001f)
			{
				s = s/D;
				t = t/D;
				if ((s >= 0 && s <= 1) && (t >= 0 && t <=1))
				{
					float2 n = sign(D)*normalize((float2)(-u.y, u.x));

					// postition
					state[particle].xy = v0 - v*(0.5f/dot(v,n));
					// velocity
					state[particle].zw = state[particle].zw - n*dot(n, state[particle].zw);
				}
			}
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
