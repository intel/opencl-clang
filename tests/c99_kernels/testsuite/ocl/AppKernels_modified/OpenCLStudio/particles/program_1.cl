//global include for a all OpenCL programs

typedef struct
{
	float4 gravity;
	float deltaTime;
	float particleRadius;
	float cellSize;
	uint buckets;
} System;

int4 gridPosition(float4 position, float cellSize){
    int4 gridPos;
    gridPos.x = (int)floor(position.x/cellSize);
    gridPos.y = (int)floor(position.y/cellSize);
    gridPos.z = (int)floor(position.z/cellSize);
    gridPos.w = 0;
    return gridPos;
}

uint hashKey(int4 gridPoint, int buckets)
{
	const uint p1 = 73856093; //
	const uint p2 = 19349663;
	const uint p3 = 83492791;
	uint n = p1*gridPoint.x ^ p2*gridPoint.y ^ p3*gridPoint.z;
	n %= buckets;
	return n;
}

//
// integrate particles
//
__kernel void clIntegrate(__global float4* posIn, __global float4* velIn, __global float4* forceIn,  __global const System* param)
{
    const uint particle = get_global_id(0);

    float4 pos = posIn[particle];
    float4 vel = velIn[particle] + forceIn[particle];

    //Gravity
    vel += -0.0005f*param->deltaTime*param->gravity;
    vel.w = 0.0f;
    pos += vel * param->deltaTime;
    pos.w = 1.0f;

    posIn[particle] = pos;
    velIn[particle] = vel;
}

__kernel void clClipBox(__global float4* posIn, __global float4* velIn, __global const System* param)
{
    const uint numParticles = get_global_size(0);
    const uint particle = get_global_id(0);

    float4 pos = posIn[particle];
    float4 vel = velIn[particle];
	float radius = param->particleRadius;

    //Collide with cube
    if(pos.x < -1.0f + radius)
	{
        pos.x = -1.0f + radius;
        vel.x *= -0.5;
    }
    if(pos.x > 1.0f - radius)
	{
        pos.x = 1.0f - radius;
        vel.x *= -0.5;
    }

    if(pos.y < -1.0f + radius)
	{
        pos.y = -1.0f + radius;
        vel.y *= -0.5;
    }
    if(pos.y > 1.0f - radius)
	{
        pos.y = 1.0f - radius;
        vel.y *= -0.5;
    }

    if(pos.z < -1.0f + radius)
	{
        pos.z = -1.0f + radius;
        vel.z *= -0.5;
    }
    if(pos.z > 1.0f - radius)
	{
        pos.z = 1.0f - radius;
        vel.z *= -0.5;
    }

    posIn[particle] = pos;
    velIn[particle] = vel;
}

//
// map particles into voxel grid
//
__kernel void clHash(__global uint* cell, __global uint* index, __global const float4* position, __global const System* param)
{
    const uint particle = get_global_id(0);

	int4 grid = gridPosition(position[particle], param->cellSize);
    cell[particle] = hashKey(grid, param->buckets);
    index[particle] = particle;
}

__kernel void reorder(__global const uint *index, __global const float4* posIn, __global const float4* velIn, __global float4* posOut,  __global float4* velOut)
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

__kernel void clBounds(__global uint* cellStart, __global uint* cellEnd, __global const uint* cell,__local uint *localHash)
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
// Compute collisions
//

float4 collideSpheres(float4 posA, float4 posB, float4 velA, float4 velB, float radiusA, float radiusB, float spring, float damping, float shear, float attraction)
{
    //Calculate relative position
    float4 relPos = (float4)(posB.x - posA.x, posB.y - posA.y, posB.z - posA.z, 0);
    float dist = sqrt(relPos.x * relPos.x + relPos.y * relPos.y + relPos.z * relPos.z);
    float collideDist = radiusA + radiusB;

    float4 force = (float4)(0, 0, 0, 0);
    if(dist < collideDist)
	{
        float4 norm = (float4)(relPos.x / dist, relPos.y / dist, relPos.z / dist, 0);

        //Relative velocity
        float4 relVel = (float4)(velB.x - velA.x, velB.y - velA.y, velB.z - velA.z, 0);

        //Relative tangential velocity
        float relVelDotNorm = relVel.x * norm.x + relVel.y * norm.y + relVel.z * norm.z;
        float4 tanVel = (float4)(relVel.x - relVelDotNorm * norm.x, relVel.y - relVelDotNorm * norm.y, relVel.z - relVelDotNorm * norm.z, 0);

        //Spring force (potential)
        float springFactor = -spring * (collideDist - dist);
        force = (float4)(springFactor * norm.x + damping * relVel.x + shear * tanVel.x + attraction * relPos.x,
						 springFactor * norm.y + damping * relVel.y + shear * tanVel.y + attraction * relPos.y,
						 springFactor * norm.z + damping * relVel.z + shear * tanVel.z + attraction * relPos.z,
							0);
    }

    return force;
}

__kernel void clCollideParticles(__global float4* forceOut, __global const float4* posIn, __global const float4* valIn, __global const uint* index, __global const uint* cellStart, __global const uint* cellEnd, __global const System* param)
{
	uint numParticles = get_global_size(0);
    uint particle = get_global_id(0);

    float4 pos = posIn[particle];
    float4 vel = valIn[particle];
    float4 force = (float4)(0, 0, 0, 0);

    int4 gridPos = gridPosition(pos, param->cellSize);

    for(int z = -1; z <= 1; z++)
	{
        for(int y = -1; y <= 1; y++)
		{
            for(int x = -1; x <= 1; x++)
			{
                uint cell = hashKey(gridPos + (int4)(x, y, z, 0), param->buckets);

                uint start = cellStart[cell];
                if(start != 0xFFFFFFFFU)
				{
					uint end = cellEnd[cell];
					for(uint j = start; j < end; j++)
					{
						if(j != particle)
						{
							force += collideSpheres(pos, posIn[j],vel, valIn[j],param->particleRadius, param->particleRadius, 0.5, 0.02, 0.1, 0);
						}
					}
				}
            }
		}
	}

    forceOut[index[particle]] = force;
}


__kernel void clCollideSpheres(__global float4* forceOut, __global const float4* posIn, __global const float4* valIn, __global const uint* index, __global const float4* spheres, uint sphereCount, __global const System* param)
{
    uint particle = get_global_id(0);

    float4 pos = posIn[particle];
    float4 vel = valIn[particle];
    float4 force = (float4)(0, 0, 0, 0);

	for (int i=0; i<sphereCount; i++)
	{
		force += collideSpheres(
			pos, (float4)(spheres[i].x, spheres[i].y, spheres[i].z, 0),
			vel, (float4)(0, 0, 0, 0),
			param->particleRadius, spheres[i].w,
			0.5, 0.02, 0.1, 0);
    };


    forceOut[index[particle]] = forceOut[index[particle]] + force;
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
