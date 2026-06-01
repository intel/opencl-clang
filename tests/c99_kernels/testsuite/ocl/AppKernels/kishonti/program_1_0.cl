
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


#define GridIndex uint
#define Empty (GridIndex)(0-1)

inline GridIndex gPos(int x, int y, int z)
{
	return z*gSize.y*gSize.x + y*gSize.x + x;
}

__kernel void ResetGrid(__global GridIndex *gList, __global GridIndex *gCount) // 3D linear
{
	const size_t i = get_global_id(0);
	gList[i] = Empty;
	gCount[i] = 0;
}

__kernel void ResetParticleList(__global GridIndex *pList) // 1D linear
{
	pList[get_global_id(0)] = Empty;
}

__kernel void PlaceParticles(const uint startSlice, const uint endSlice,
	__global const float3 *restrict x,
	__global GridIndex *gList,
	__global GridIndex *pList,
	__global GridIndex *gCount)
{
	const size_t i = get_global_id(0);

	const float3 xi = x[i];

	int3 relPos = clamp(convert_int3((xi - SpaceMin)/(GridRadius*2.0f)), (int3)(0), gSize - 1);

	if(startSlice <= relPos.z && relPos.z <= endSlice)
	{
		uint gridPos = gPos(relPos.x, relPos.y, relPos.z);

		atomic_xchg(pList + i, atomic_xchg(gList + gridPos, i));
		atomic_inc(gCount + gridPos);
	}
}

__kernel void ResetGridOffsets(__global GridIndex *gCount, __global uint *gOffset)
{
	const size_t i = get_global_id(0);
	gOffset[i] = gCount[i];
}

__kernel void ScanGridOffset
(
	__global GridIndex *g,
	__global GridIndex *t,
	__local uint *l
)
{
	const uint gId = get_global_id(0),
		lId = get_local_id(0),
		lIdSucc = get_local_id(0) + 1,
		lSize = get_local_size(0);

	l[lId*2] = g[gId*2];
	l[lId*2 + 1] = g[gId*2 + 1];
	barrier(CLK_LOCAL_MEM_FENCE);

	for(uint N = get_local_size(0), M = 2, m = 1; 1 <= N; N >>= 1)
	{
		if(lId < N)
		{
			const uint i = lIdSucc*M - 1;
			l[i] += l[i - m];

			M <<= 1;
			m <<= 1;
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	for(uint N = 2, M = lSize, m = lSize >> 1; N <= lSize; N <<= 1, M >>= 1, m >>= 1)
	{
		if( lIdSucc < N )
		{
			const uint i = lIdSucc*M - 1;
			l[i + m] += l[i];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	g[gId*2] = l[lId*2];
	g[gId*2 + 1] = l[lId*2 + 1];
	if(lIdSucc == lSize)
	{
		t[gId/lSize] = l[lId*2 + 1];
	}
}

__kernel void GridBlockAdd
(
	__global uint *g,
	__global uint *t,
	const uint lSize
)
{
	const size_t gId = get_global_id(0) + lSize;
	const size_t tId = get_global_id(0)/lSize;

	g[gId] += t[tId];
}

__kernel void ScanExclusivity(
	const uint regionStartOffset,
	__global GridIndex *gCount,
	__global GridIndex *gOffset
	)
{
	const size_t i = get_global_id(0);
	gOffset[i] += regionStartOffset - gCount[i];
}

__kernel void ResetSliceOffsets(__global const GridIndex *restrict gOffset, __global GridIndex *sOffset)
{
	const size_t sliceIndex = get_global_id(0);
	const size_t cellIndex = sliceIndex*gSize.y*gSize.x;

	sOffset[sliceIndex] = gOffset[cellIndex];
}

__kernel void SortParticles(__global const GridIndex *restrict gOffset,
	__global const GridIndex *restrict gList,
	__global const GridIndex *restrict pList,
	__global const float3 *restrict x,  __global float3 *x1,
	__global const float3 *restrict v00, __global float3 *v01,
	__global const float3 *restrict v10, __global float3 *v11)
{
	const uint gridPos = get_global_id(0); //gPos(get_global_id(0),get_global_id(1),get_global_id(2));

	for(GridIndex j = gList[gridPos], k = 0; j != Empty; j = pList[j], ++k)
	{
		const uint i = gOffset[gridPos] + k;
		x1[i] = x[j];
		v01[i] = v00[j];
		v11[i] = v10[j];
	}
}

__constant float DensityKernelFactor = 315.0f/(64.0f*PI*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius);

__kernel void CalculateDensity(const uint particleCount,
	__global const float3 *restrict x,
	__global float *d,
	__global const uint *restrict gOffset,
	__global const uint *restrict gCount)
{
	if(get_global_id(0) - get_global_offset(0) >= particleCount) return;
	const uint i = convert_uint(get_global_id(0));

	const float3 xi = x[i];
	float density = 0.0f;

	const int3 gps = clamp(convert_int3((xi - SpaceMin)/(2.0f*GridRadius) - 0.5f), (int3)(-1), gSize - 1);
	const int3 gps_min = max(gps, (int3)(0));
	const int3 gps_max = min(gps + 1, gSize - 1);

	for(int ox = gps_min.x; ox <= gps_max.x; ++ox)
	{
		for(int oy = gps_min.y; oy <= gps_max.y; ++oy)
		{
			for(int oz = gps_min.z; oz <= gps_max.z; ++oz)
			{
				const GridIndex start = gOffset[gPos(ox, oy, oz)];
				const GridIndex end = start + gCount[gPos(ox, oy, oz)];
				for(GridIndex j = start; j < end; ++j)
				{
					const float3 xj = x[j]; //read

					float3 xij = xj - xi;
					float r2 = dot(xij,xij);
					float D2_r2 = SmoothRadius*SmoothRadius - r2;

					D2_r2 = fmax(D2_r2, 0.0f);
					density += D2_r2*D2_r2*D2_r2;
				}
			}
		}
	}

	d[i] = density * DensityKernelFactor*ParticleMass; //write
}

__constant float ForceKernelFactor = 45.0f/(PI*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius*SmoothRadius);

__kernel void CalculateForce(const uint particleCount,
	__global float3 *f,
	__global const float3 *restrict x,
	__global const float3 *restrict v,
	__global const float *restrict d,
	__global const uint *restrict gOffset,
	__global const uint *restrict gCount) // 1D linear
{
	if(get_global_id(0) - get_global_offset(0) >= particleCount) return;
	const uint i = convert_uint(get_global_id(0));

	const float3 xi = x[i];
	const float3 vi = v[i];
	const float di = d[i]; // global loads
	float3 force = (float3)(0.0f);

	const int3 gps = clamp(convert_int3((xi - SpaceMin)/(2.0f*GridRadius) - 0.5f), (int3)(-1), gSize - 1);
	const int3 gps_min = max(gps, (int3)(0));
	const int3 gps_max = min(gps + 1, gSize - 1);

	for(int ox = gps_min.x; ox <= gps_max.x; ++ox)
	{
		for(int oy = gps_min.y; oy <= gps_max.y; ++oy)
		{
			for(int oz = gps_min.z; oz <= gps_max.z; ++oz)
			{
				/*prefetch(x + gOffset[gPos(ox, oy, oz)]*3, gCount[gPos(ox, oy, oz)]*3);
				prefetch(v + gOffset[gPos(ox, oy, oz)]*3, gCount[gPos(ox, oy, oz)]*3);
				prefetch(d + gOffset[gPos(ox, oy, oz)], gCount[gPos(ox, oy, oz)]);*/
				const GridIndex start = gOffset[gPos(ox, oy, oz)];
				const GridIndex end = start + gCount[gPos(ox, oy, oz)]; //global loads
				for(GridIndex j = start; j < end; ++j)
				{
					if(i != j)
					{
						const float3 xj = x[j]; //global load

						const float3 xij = (xj - xi)*Scale;
						const float rij = length(xij);
						const float dist = SmoothRadius - rij;

						if(dist > 0.0f) // we can avoid the loads
						{
							const float3 vj = v[j];
							const float dj = d[j]; // global loads

							const float tPressure = dist*((di+dj - 2.0f*D0)*IntStiffness)*0.5f;
							force += ((vj - vi)*Viscosity - xij/rij*tPressure)*dist/(di*dj);
						}
					}
				}
			}
		}
	}

	f[i] = force * ForceKernelFactor; // global store
}

__kernel void UpdateParticles(const float phase,
	__global const float3 *restrict x, __global float3 *x_next,
	__global const float3 *restrict v11, __global float3 *v10,
	__global const float3 *restrict v01, __global float3 *v00,
	__global const float3 *restrict f) // 1D linear
{
	const uint i = convert_uint(get_global_id(0));

	const float3 fi = f[i];
	float3 xi = x[i];
	const float3 vi = v11[i];
	const float3 v0i = v01[i]; // global load

	const float dt = FrameStep;
	float3 a = fi*ParticleMass;
	/*if(length(a) > VelocityLimit)
	{
		a *= VelocityLimit/length(a);
	}*/

	{
		const float3 difference = 2.0f*ParticleRadius - (xi - SpaceMin)*Scale;
		a += select((float3)(0.0f),  ExtStiffness*difference - Damping*vi, difference > Epsilon);
	}
	{
		const float3 difference = 2.0f*ParticleRadius - (SpaceMax - xi)*Scale;
		a -= select((float3)(0.0f),  ExtStiffness*difference + Damping*vi, difference > Epsilon);
	}

	float4 d = (float4)(0.0f, -Gravity, 0.0f, 0.0f);
	d = rotateVectorAxisAngle(d, phase/4.0f, (float4)(1.0f, 0.0f, 0.0f, 0.0f));
	d = rotateVectorAxisAngle(d, phase/2.0f, (float4)(0.0f, 1.0f, 0.0f, 0.0f));
	d = rotateVectorAxisAngle(d, -phase, (float4)(0.0f, 0.0f, 1.0f, 0.0f));

	a += d.xyz;

	if(length(a) > VelocityLimit)
	{
		a *= VelocityLimit/length(a);
	}

	// velocity and position Leapfrog integration
	const float3 vel = v0i + a*dt;
	float3 delta = vel*(dt/Scale);
	const float length_delta = length(delta);
	const float max_delta = ParticleRadius/Scale;
	if(length_delta > max_delta)
	{
		delta *= max_delta/length_delta;
	}
	xi += delta;

	const float eps = 2.0f*ParticleRadius;

	v10[i] = (v0i + vel)*0.5f;
	v00[i] = vel;
	x_next[i] = clamp(xi, SpaceMin + eps, SpaceMax - eps); // global stores
}

__kernel void InitializeFluid(__global float3 *position,
	__global float3 *position1,
	__global float3 *v, __global float3 *v1) // 1 constant
{
	const float dx = InitVolumeMax.x - InitVolumeMin.x,
		dy = InitVolumeMax.y - InitVolumeMin.y,
		dz = InitVolumeMax.z - InitVolumeMin.z;
	const float spacing = pow(dx*dy*dz, 1.0f/3.0f)/pow((float)(particleNum), 1.0f/3.0f);
	//const float spacing = Scale;

	unsigned int i = 0;
	for(float z = InitVolumeMax.z; z >= InitVolumeMin.z; z -= spacing)
		for(float y = InitVolumeMin.y; y <= InitVolumeMax.y; y += spacing)
			for(float x = InitVolumeMin.x; x <= InitVolumeMax.x && i < particleNum; x += spacing)
			{
				position[i] = (float3)(x, y, z);
				position1[i] = (float3)(x, y, z);
				v[i] = (float3)(0.0f);
				v1[i] = (float3)(0.0f);

				++i;
			}
}



// buildOptions=-cl-std=CL1.1 -D FrameStep=0.00300000002608f -D particleNum=32768 -D gSize=((int3)(32,32,32)) -D Gravity=9.81000041961670f -D Epsilon=0.00000999999975f -D PI=3.14159274101257f -D Scale=0.00400000018999f -D SmoothRadius=0.00999999977648f -D GridRadius=2.49999976158142f -D ParticleRadius=0.00499999988824f -D ParticleRadius=0.00499999988824f -D ParticleDistance=0.00590000022203f -D ParticleMass=0.00020542999846f -D IntStiffness=0.50000000000000f -D ExtStiffness=20000.00000000000000f -D Damping=256.00000000000000f -D D0=0.00000000000000f -D VelocityLimit=200.00000000000000f -D Viscosity=0.01999999955297f -D SpaceMin=((float3)(0.00000000000000f,0.00000000000000f,0.00000000000000f)) -D SpaceMax=((float3)(159.00000000000000f,159.89999389648437f,159.89999389648437f)) -D InitVolumeMin=((float3)(32.00000000000000f,0.00000000000000f,32.00000000000000f)) -D InitVolumeMax=((float3)(96.00000000000000f,64.00000000000000f,96.00000000000000f))
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1 -D FrameStep=0.00300000002608f -D particleNum=32768 -D gSize=((int3)(32,32,32)) -D Gravity=9.81000041961670f -D Epsilon=0.00000999999975f -D PI=3.14159274101257f -D Scale=0.00400000018999f -D SmoothRadius=0.00999999977648f -D GridRadius=2.49999976158142f -D ParticleRadius=0.00499999988824f -D ParticleRadius=0.00499999988824f -D ParticleDistance=0.00590000022203f -D ParticleMass=0.00020542999846f -D IntStiffness=0.50000000000000f -D ExtStiffness=20000.00000000000000f -D Damping=256.00000000000000f -D D0=0.00000000000000f -D VelocityLimit=200.00000000000000f -D Viscosity=0.01999999955297f -D SpaceMin=((float3)(0.00000000000000f,0.00000000000000f,0.00000000000000f)) -D SpaceMax=((float3)(159.00000000000000f,159.89999389648437f,159.89999389648437f)) -D InitVolumeMin=((float3)(32.00000000000000f,0.00000000000000f,32.00000000000000f)) -D InitVolumeMax=((float3)(96.00000000000000f,64.00000000000000f,96.00000000000000f))" %cfg_path --cl-device=%cl_device 2>&1
