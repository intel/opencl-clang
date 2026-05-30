#ifndef M_PI_F
	#define M_PI_F 3.14159265358979323846
#endif

#define spring				 0.5f
#define damping				 0.02f
#define shear				 0.1f
#define attraction			 0.0f
#define boundaryDamping		 -1.0f
#define globalDamping		 1.0f
#define gravity				-0.03f
#define deltaTime			 0.01f

inline void collideSpheres(float4 posA, float4 posB, float4 velA, float4 velB, float radiusA, float radiusB, float4 *force)
{
	float4 relPos = posB - posA;
	float dist = length(relPos);
	float collideDist = radiusA + radiusB;

	if (dist < collideDist)
	{
		float4 norm = normalize(relPos);
		float4 relVel = velB - velA;
		float4 tanVel = relVel - norm * dot(norm, relVel);

		*force -= norm * spring * (collideDist - dist);
		*force += relVel * damping;
		*force += tanVel * shear;
		*force += relPos * attraction;
	}
}

inline float4 quaternionConjugate(const float4 v)
{
	return (float4)(-v.x, -v.y, -v.z, v.w);
}

inline float4 quaternionMultiply(const float4 a, const float4 b)
{
	return (float4)(
		a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y,
		a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x,
		a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w,
		a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z
		);
}

inline float4 quaternionMultiplyVector(const float4 q, const float4 v)
{
	return (float4)(
		q.w*v.x + q.x*v.w + q.y*v.z - q.z*v.y,
		q.w*v.y - q.x*v.z + q.y*v.w + q.z*v.x,
		q.w*v.z + q.x*v.y - q.y*v.x + q.z*v.w,
		0.0f
		);
}

inline float4 quaternionAngleRotator(const float angle, const float4 axis)
{
	float sinAngle = sin(angle*0.5f);
	float cosAngle = cos(angle*0.5f);

	float4 ret = axis;

	ret.x *= sinAngle;
	ret.y *= sinAngle;
	ret.z *= sinAngle;
	ret.w = cosAngle;

	return ret;
}

inline float4 rotateVectorAxisAngle(const float4 v, const float angle, const float4 axis)
{
	float4 q = quaternionAngleRotator(angle, axis);
	return quaternionMultiplyVector(q, quaternionMultiply(v, quaternionConjugate(q)));
}

__kernel
void reset(__global int* __restrict hList)
{
	const uint idX = get_global_id(0);

	hList[idX] = 0;
}

__kernel
void create(
	const __global float4* __restrict allocPos,
	__global int* __restrict hList,
	__global int* __restrict pList,
	const float particleRadius,
	const int gridSize,
	const int maxPartPerCell
)
{
	const uint idX = get_global_id(0);

	float4 pos = allocPos[idX];

	int xId = (int)(pos.x / (2.0f*particleRadius));
	xId = max(xId, 0);
	xId = min(xId, gridSize - 1);

	int yId = (int)(pos.y / (2.0f*particleRadius));
	yId = max(yId, 0);
	yId = min(yId, gridSize - 1);

	int zId = (int)(pos.z / (2.0f*particleRadius));
	zId = max(zId, 0);
	zId = min(zId, gridSize - 1);

	int gridId = zId * gridSize*gridSize + yId * gridSize + xId;

	int cellOffset = gridId * maxPartPerCell;
	int particleOffset = atomic_inc(hList + gridId);
	particleOffset = min(particleOffset, maxPartPerCell - 1);

	pList[cellOffset + particleOffset] = idX;
}

__kernel
void collide(
	const __global float4* __restrict allocPos,
	const __global float4* __restrict allocVel0,
	__global float4* __restrict allocVel1,
	__global int* __restrict gCounter,
	const __global int* __restrict hList,
	const __global int* __restrict pList,
	const float particleRadius,
	const int gridSize,
	const int maxPartPerCell
)
{
	const uint idX = get_global_id(0);

	float4 pos = allocPos[idX];
	float4 vel = allocVel0[idX];
	float4 force = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	int xId = convert_int(pos.x / (2.0f*particleRadius));
	int yId = convert_int(pos.y / (2.0f*particleRadius));
	int zId = convert_int(pos.z / (2.0f*particleRadius));

	int xIdMin = max(xId - 1, 0);
	int yIdMin = max(yId - 1, 0);
	int zIdMin = max(zId - 1, 0);

	int xIdMax = min(xId + 1, gridSize - 1);
	int yIdMax = min(yId + 1, gridSize - 1);
	int zIdMax = min(zId + 1, gridSize - 1);

	int lCounter = 0;

	for (int k = zIdMin; k <= zIdMax; ++k)
	{
		for (int j = yIdMin; j <= yIdMax; ++j)
		{
			for (int i = xIdMin; i <= xIdMax; ++i)
			{
				int gridId = k * gridSize*gridSize + j * gridSize + i;
				int cellOffset = gridId * maxPartPerCell;
				int numParts = hList[gridId];

				for (int x = 0; x < numParts; ++x)
				{
					int pindex = pList[cellOffset + x];

					if (pindex == (int)(idX))
					{
						continue;
					}

					float4 pos2 = allocPos[pindex];
					float4 vel2 = allocVel0[pindex];

					++lCounter;
					collideSpheres(pos, pos2, vel, vel2, particleRadius, particleRadius, &force);
				}
			}
		}
	}

	atomic_add(gCounter, lCounter);

	allocVel1[idX] = vel + force;
}

__kernel
void integrate(
	__global float4* __restrict allocPos,
	__global float4* __restrict allocVel0,
	const __global float4* __restrict allocVel1,
	const float phase,
	const float particleRadius
)
{
	const uint idX = get_global_id(0);

	float4 pos = allocPos[idX];
	float4 vel = allocVel1[idX];

	float phaseRad = (convert_float(M_PI_F) / 180.0f) * phase;

	float4 g = (float4)(0.0f, gravity, 0.0f, 0.0f);

	const float4 rotX = (float4)(1.0f, 0.0f, 0.0f, 0.0f);
	const float4 rotY = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
	const float4 rotZ = (float4)(0.0f, 0.0f, 1.0f, 0.0f);

	g = rotateVectorAxisAngle(g, -phaseRad / 4.0f, rotX);
	g = rotateVectorAxisAngle(g, -phaseRad / 2.0f, rotY);
	g = rotateVectorAxisAngle(g, phaseRad, rotZ);

	vel += g * deltaTime;

	vel *= globalDamping;

	pos += vel * deltaTime;

	if (pos.x < particleRadius)
	{
		pos.x = particleRadius;
		vel.x *= boundaryDamping;
	}

	if (pos.x > 1.0f - particleRadius)
	{
		pos.x = 1.0f - particleRadius;
		vel.x *= boundaryDamping;
	}

	if (pos.y < particleRadius)
	{
		pos.y = particleRadius;
		vel.y *= boundaryDamping;
	}

	if (pos.y > 1.0f - particleRadius)
	{
		pos.y = 1.0f - particleRadius;
		vel.y *= boundaryDamping;
	}

	if (pos.z < particleRadius)
	{
		pos.z = particleRadius;
		vel.z *= boundaryDamping;
	}

	if (pos.z > 1.0f - particleRadius)
	{
		pos.z = 1.0f - particleRadius;
		vel.z *= boundaryDamping;
	}

	allocPos[idX] = pos;
	allocVel0[idX] = vel;
}

__kernel
void reorder
(
	__global int* restrict hList,
	__global const int* restrict hListScan,
	__global const float4* restrict pos0, __global float4* restrict pos1,
	__global const float4* restrict vel0, __global float4* restrict vel1,
	__global const float4* restrict col0, __global float4* restrict col1,
	const float particleRadius,
	const int gridSize,
	const int maxPartPerCell
)
{
	const uint idX = get_global_id(0);

	float4 pos = pos0[idX];

	int xId = (int)(pos.x / (2.0f*particleRadius));
	xId = max(xId, 0);
	xId = min(xId, gridSize - 1);

	int yId = (int)(pos.y / (2.0f*particleRadius));
	yId = max(yId, 0);
	yId = min(yId, gridSize - 1);

	int zId = (int)(pos.z / (2.0f*particleRadius));
	zId = max(zId, 0);
	zId = min(zId, gridSize - 1);

	int gridId = zId * gridSize*gridSize + yId * gridSize + xId;

	int cellOffset = hListScan[gridId];
	int particleOffset = atomic_inc(hList + gridId);

	pos1[cellOffset + particleOffset] = pos0[idX];
	vel1[cellOffset + particleOffset] = vel0[idX];
	col1[cellOffset + particleOffset] = col0[idX];
}

__kernel
void swap
(
	__global const float4* restrict pos0, __global float4* restrict pos1,
	__global const float4* restrict vel0, __global float4* restrict vel1,
	__global const float4* restrict col0, __global float4* restrict col1
)
{
	const uint idX = get_global_id(0);

	pos1[idX] = pos0[idX];
	vel1[idX] = vel0[idX];
	col1[idX] = col0[idX];
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
