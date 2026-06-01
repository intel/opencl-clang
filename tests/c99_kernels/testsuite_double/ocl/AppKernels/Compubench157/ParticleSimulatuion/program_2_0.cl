inline float4 quaternionConjugate(const float4 v)
{
	return (float4)(-v.s0, -v.s1, -v.s2, v.s3);
}

inline float4 quaternionMultiply(const float4 a, const float4 b)
{
	return (float4)
	(
		a.s3*b.s0 +a.s0*b.s3 +a.s1*b.s2 -a.s2*b.s1,
		a.s3*b.s1 -a.s0*b.s2 +a.s1*b.s3 +a.s2*b.s0,
		a.s3*b.s2 +a.s0*b.s1 -a.s1*b.s0 +a.s2*b.s3,
		a.s3*b.s3 -a.s0*b.s0 -a.s1*b.s1 -a.s2*b.s2
	);
}

inline float4 quaternionMultiplyVector(const float4 q, const float4 v)
{
	return (float4)
	(
		q.s3*v.s0 +q.s0*v.s3 +q.s1*v.s2 -q.s2*v.s1,
		q.s3*v.s1 -q.s0*v.s2 +q.s1*v.s3 +q.s2*v.s0,
		q.s3*v.s2 +q.s0*v.s1 -q.s1*v.s0 +q.s2*v.s3,
		0.0f
	);
}

inline float4 quaternionAngleRotator(const float angle, const float4 axis)
{
	float cosAngle;
	float sinAngle = sincos(angle*0.5f, &cosAngle);

	float4 r = axis;
	r.s0 *= sinAngle;
	r.s1 *= sinAngle;
	r.s2 *= sinAngle;
	r.s3  = cosAngle;

	return r;
}

inline float4 rotateVectorAxisAngle(const float4 v, const float angle, const float4 axis)
{
	float4 q = quaternionAngleRotator(angle, axis);
	return quaternionMultiplyVector(q, quaternionMultiply(v, quaternionConjugate(q)));
}

#define spring				 0.5f
#define damping				 0.02f
#define shear				 0.1f
#define attraction			 0.0f
#define boundaryDamping		-0.5f
#define globalDamping		 1.0f
#define gravity				-0.03f
#define deltaTime			 0.01f
#define deltaR  (particleRadius * 0.5f)

#define CELL_SEARCH_MARGIN 1

//Adapted from https://www.thasler.org/blog/?p=93

// setting float2 double
inline float2 dp_set(float a)
{
	float2 z;
	z.x = a;
	z.y = 0.0f;
	return z;
}

// adding float2 doubles
inline float2 dp_add(float2 dp_a, float2 dp_b)
{
	float2 dp_c;
	float t1, t2, e;

	t1 = dp_a.x + dp_b.x;
	e = t1 - dp_a.x;
	t2 = ((dp_b.x - e) + (dp_a.x - (t1 - e))) + dp_a.y + dp_b.y;

	dp_c.x = t1 + t2;
	dp_c.y = t2 - (dp_c.x - t1);
	return dp_c;
}

inline float2 dp_add_nopt(float2 dp_a, float2 dp_b, float opt_stop1, float opt_stop2)
{
	float2 dp_c;
	float t1, t2, e;

	t1 = dp_a.x + dp_b.x;
	e = opt_stop1*(t1 - dp_a.x);
	t2 = (opt_stop1*(dp_b.x - e) + opt_stop2*(dp_a.x - (t1 - e))) + dp_a.y + dp_b.y;

	dp_c.x = t1 + t2;
	dp_c.y = t2 - opt_stop1*(dp_c.x - t1);
	return dp_c;
}

__kernel
void resetGCounter(__global int* restrict gCounter)
{
	gCounter[0] = 0;
}

__kernel
void resetHeadList(__global int* restrict hList)
{
	const int index = get_global_id(0);

	hList[index] = 0;
}

__kernel
void createList(
	__global const float4* restrict posBuffer,
	__global int* restrict hList,
	__global int* restrict pList)
{
	const int index = get_global_id(0);

	float4 pos = posBuffer[index];

	int xId = clamp((int)floor(pos.x / (2.0f*particleRadius)), 0, gridSize-1);
	int yId = clamp((int)floor(pos.y / (2.0f*particleRadius)), 0, gridSize-1);
	int zId = clamp((int)floor(pos.z / (2.0f*particleRadius)), 0, gridSize-1);

	int gridId = zId * gridSize*gridSize + yId * gridSize + xId;

	int cellOffset = gridId * maxPartPerCell;
	int particleOffset = atomic_inc(hList+gridId);

	pList[cellOffset + particleOffset] = index;
}

__kernel
void createNeighborList(
	__global const int* restrict hList,
	__global const int* restrict pList,
	__global const float4* restrict posBuffer,
	__global int* restrict nlist,
	__global int* restrict nlist_size)
{
	const int indexA = get_global_id(0);

	const float4 posA = posBuffer[indexA];

	int xId = (int)floor(posA.x / (2.0f*particleRadius));
	int yId = (int)floor(posA.y / (2.0f*particleRadius));
	int zId = (int)floor(posA.z / (2.0f*particleRadius));

	int xIdMin = max(xId - CELL_SEARCH_MARGIN, 0);
	int yIdMin = max(yId - CELL_SEARCH_MARGIN, 0);
	int zIdMin = max(zId - CELL_SEARCH_MARGIN, 0);

	int xIdMax = min(xId + CELL_SEARCH_MARGIN, gridSize - CELL_SEARCH_MARGIN);
	int yIdMax = min(yId + CELL_SEARCH_MARGIN, gridSize - CELL_SEARCH_MARGIN);
	int zIdMax = min(zId + CELL_SEARCH_MARGIN, gridSize - CELL_SEARCH_MARGIN);

	int num_neighbors = 0;

	for(int k = zIdMin; k <= zIdMax; ++k)
	{
		for(int j = yIdMin; j <= yIdMax; ++j)
		{
			for(int i = xIdMin; i <= xIdMax; ++i)
			{
				const int gridId = k * gridSize*gridSize + j * gridSize + i;
				const int cellOffset = gridId * maxPartPerCell;
				const int numParts = hList[gridId];

				for(int x = 0; x < numParts; ++x)
				{
					const int indexB = pList[cellOffset + x];

					const float4 posB = posBuffer[indexB];
					const float4 relPos = posB - posA;
					const float dist = length(relPos);
					const float cutOff = particleRadius + particleRadius + deltaR;

					if(dist < cutOff)
					{
						int nlist_idx = num_neighbors * get_global_size(0) + indexA;
						nlist[nlist_idx] = indexB;

						++num_neighbors;
					}
				}
			}
		}
	}

	//increase the neighbor size
	nlist_size[indexA] = num_neighbors;
}

__kernel
void computeForces(
	__global const int* restrict nlist_size,
	__global const int* nlist,
	__global const float4* restrict posBuffer,
	__global const float4* restrict vel0Buffer,
	__global float4* restrict vel1Buffer,
	__global int* restrict gCounter,
	__global float4* p_opt_stop)
{
	const int indexA = get_global_id(0);

	float4 posA = posBuffer[indexA];
	float4 velA = vel0Buffer[indexA];

	float2 fA[3] = {(float2)0};

	float2 opt_stop = p_opt_stop[0].xy;
	int lCounter = 0;

	int nlist_sz = nlist_size[indexA];
	for(int i = 0; i < nlist_sz; ++i)
	{
		int indexB = nlist[get_global_size(0)*i + indexA];

		float4 posB = posBuffer[indexB];
		float4 velB = vel0Buffer[indexB];

		//compute particle pair interaction
		float4 relPosAB = posB - posA;
		float distAB = length(relPosAB);
		float collideDist = particleRadius + particleRadius;

		if(distAB < collideDist)
		{
			++lCounter;

			float4 norm = normalize(relPosAB);
			float4 relVel = velB - velA;
			float4 tanVel = relVel - norm * dot(norm, relVel);

			float4 fup;
			fup = -(norm * spring * (collideDist - distAB));
			fA[0] = dp_add_nopt( fA[0], (float2)(fup.x, 0.0f), opt_stop.x, opt_stop.y );
			fA[1] = dp_add_nopt( fA[1], (float2)(fup.y, 0.0f), opt_stop.x, opt_stop.y );
			fA[2] = dp_add_nopt( fA[2], (float2)(fup.z, 0.0f), opt_stop.x, opt_stop.y );

			fup = relVel * damping;
			fA[0] = dp_add_nopt( fA[0], (float2)(fup.x, 0.0f), opt_stop.x, opt_stop.y );
			fA[1] = dp_add_nopt( fA[1], (float2)(fup.y, 0.0f), opt_stop.x, opt_stop.y );
			fA[2] = dp_add_nopt( fA[2], (float2)(fup.z, 0.0f), opt_stop.x, opt_stop.y );

			fup = tanVel * shear;
			fA[0] = dp_add_nopt( fA[0], (float2)(fup.x, 0.0f), opt_stop.x, opt_stop.y );
			fA[1] = dp_add_nopt( fA[1], (float2)(fup.y, 0.0f), opt_stop.x, opt_stop.y );
			fA[2] = dp_add_nopt( fA[2], (float2)(fup.z, 0.0f), opt_stop.x, opt_stop.y );

			fup = relPosAB * attraction;
			fA[0] = dp_add_nopt( fA[0], (float2)(fup.x, 0.0f), opt_stop.x, opt_stop.y );
			fA[1] = dp_add_nopt( fA[1], (float2)(fup.y, 0.0f), opt_stop.x, opt_stop.y );
			fA[2] = dp_add_nopt( fA[2], (float2)(fup.z, 0.0f), opt_stop.x, opt_stop.y );
		}
	}

	//count the number of iterations for scoring
	atomic_add(gCounter, lCounter);

	vel1Buffer[indexA] = velA + (float4)(fA[0].x, fA[1].x, fA[2].x, 0.0f);
}

__kernel
void createFlatList(
	__global const int* hList, __global const int* pList,
	__global int* reorderList, const int numGridCells)
{
	int index = 0;

	for(int gridId = 0; gridId < numGridCells; ++gridId)
	{
		const int gridOffset = gridId * maxPartPerCell;
		const int numParts = hList[gridId];

		for(int j = 0; j < numParts; j++)
		{
			int pindex = pList[gridOffset + j];
			reorderList[index] = pindex;

			++index;
		}
	}
}

__kernel
void shuffledReorder(
	__global int* reorderList,
	__global const float4* restrict pos0, __global float4* restrict pos1,
	__global const float4* restrict vel0, __global float4* restrict vel1,
	__global const float4* restrict col0, __global float4* restrict col1)
{
	const int index = get_global_id(0);
	const int orderIndex = reorderList[index];

	pos1[ index ] = pos0[ orderIndex ];
	vel1[ index ] = vel0[ orderIndex ];
	col1[ index ] = col0[ orderIndex ];
}

__kernel
void scannedReorder(
	__global int* restrict hList,
	__global const int* restrict hListScan,
	__global const float4* restrict pos0, __global float4* restrict pos1,
	__global const float4* restrict vel0, __global float4* restrict vel1,
	__global const float4* restrict col0, __global float4* restrict col1)
{
	const int index = get_global_id(0);

	float4 pos = pos0[index];

	int xId = clamp((int)floor(pos.x / (2.0f*particleRadius)), 0, gridSize-1);
	int yId = clamp((int)floor(pos.y / (2.0f*particleRadius)), 0, gridSize-1);
	int zId = clamp((int)floor(pos.z / (2.0f*particleRadius)), 0, gridSize-1);

	int gridId = zId * gridSize*gridSize + yId * gridSize + xId;

	int cellOffset = hListScan[gridId];
	int particleOffset = atomic_inc(hList+gridId);

	pos1[ cellOffset+particleOffset ] = pos0[ index ];
	vel1[ cellOffset+particleOffset ] = vel0[ index ];
	col1[ cellOffset+particleOffset ] = col0[ index ];
}

__kernel
void integrate(
	__global float4* restrict posBuffer,
	__global float4* restrict vel0Buffer,
	__global const float4* restrict vel1Buffer,
	const float phase)
{
	const int index = get_global_id(0);

	float4 pos = posBuffer[index];
	float4 vel = vel1Buffer[index];

	float phaseRad = ((float)M_PI_F/180.0f) * phase;

	float4 g = (float4)(0.0f, gravity, 0.0f, 0.0f);
	g = rotateVectorAxisAngle(g, -phaseRad/4.0f, (float4)(1.0f, 0.0f, 0.0f, 0.0f));
	g = rotateVectorAxisAngle(g, -phaseRad/2.0f, (float4)(0.0f, 1.0f, 0.0f, 0.0f));
	g = rotateVectorAxisAngle(g,       phaseRad, (float4)(0.0f, 0.0f, 1.0f, 0.0f));

	vel += g * deltaTime;
	vel *= globalDamping;

	pos += vel * deltaTime;

	if(pos.s0 < particleRadius)
	{
		pos.s0 = particleRadius;
		vel.s0 *= boundaryDamping;
	}

	if(pos.s0 > 1.0f - particleRadius)
	{
		pos.s0 = 1.0f - particleRadius;
		vel.s0 *= boundaryDamping;
	}

	if(pos.s1 < particleRadius)
	{
		pos.s1 = particleRadius;
		vel.s1 *= boundaryDamping;
	}

	if(pos.s1 > 1.0f - particleRadius)
	{
		pos.s1 = 1.0f - particleRadius;
		vel.s1 *= boundaryDamping;
	}

	if(pos.s2 < particleRadius)
	{
		pos.s2 = particleRadius;
		vel.s2 *= boundaryDamping;
	}

	if(pos.s2 > 1.0f - particleRadius)
	{
		pos.s2 = 1.0f - particleRadius;
		vel.s2 *= boundaryDamping;
	}

	posBuffer[index] = pos;
	vel0Buffer[index] = vel;
}


inline void collideSpheres(float4 posA, float4 posB, float4 velA, float4 velB, float radiusA, float radiusB, float4* force, int* lcount)
{
	float4 relPos = posB - posA;
	float dist = length(relPos);
	float collideDist = radiusA + radiusB;

	if(dist < collideDist)
	{
		++(*lcount);

		float4 norm = normalize(relPos);
		float4 relVel = velB - velA;
		float4 tanVel = relVel - norm * dot(norm, relVel);

		*force = *force - norm * spring * (collideDist-dist);
		*force = *force + relVel * damping;
		*force = *force + tanVel * shear;
		*force = *force + relPos * attraction;
	}
}

__kernel
void collideList(
	__global const int* restrict hList, __global const int* restrict pList,
	__global const float4* restrict posBuffer,
	__global const float4* restrict vel0Buffer,
	__global float4* restrict vel1Buffer,
	__global int* restrict gCounter)
{
	const int index = get_global_id(0);

	float4 pos = posBuffer[index];
	float4 vel = vel0Buffer[index];

	float4 force = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	int xId = (int)(pos.x / (2.0f*particleRadius));
	int yId = (int)(pos.y / (2.0f*particleRadius));
	int zId = (int)(pos.z / (2.0f*particleRadius));

	int xIdMin = max(xId-1, 0);
	int yIdMin = max(yId-1, 0);
	int zIdMin = max(zId-1, 0);

	int xIdMax = min(xId+1, gridSize-1);
	int yIdMax = min(yId+1, gridSize-1);
	int zIdMax = min(zId+1, gridSize-1);

	int lCounter = 0;

	for(int k = zIdMin; k <= zIdMax; ++k)
	{
		for(int j = yIdMin; j <= yIdMax; ++j)
		{
			for(int i = xIdMin; i <= xIdMax; ++i)
			{
				int gridId = k * gridSize*gridSize + j * gridSize + i;
				int cellOffset = gridId * maxPartPerCell;
				int numParts = hList[gridId];

				for(int x = 0; x < numParts; ++x)
				{
					int pindex = pList[cellOffset + x];

					float4 pos2 = posBuffer[pindex];
					float4 vel2 = vel0Buffer[pindex];

					collideSpheres(pos, pos2, vel, vel2, particleRadius, particleRadius, &force, &lCounter);
				}
			}
		}
	}

	//count the number of iterations for scoring
	atomic_add(gCounter, lCounter);

	vel1Buffer[index] = vel + force;
}


// buildOptions=-cl-fast-relaxed-math -D gridSize=80 -D particleRadius=0.00625f -D maxPartPerCell=32
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D gridSize=80 -D particleRadius=0.00625f -D maxPartPerCell=32" %cfg_path --cl-device=%cl_device 2>&1
