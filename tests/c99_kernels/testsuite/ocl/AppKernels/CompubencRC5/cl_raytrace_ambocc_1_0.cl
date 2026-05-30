#define NUMSAMPLES 16
#define INVNUMSAMPLES 1.0f/16.0f

#ifndef M_PI_F
	#define M_PI_F 3.14159274101257f
#endif

#ifdef USEHALFMATH
	// minimum accuracy 8192 ulps
	#define sin half_sin
	#define cos half_cos
	#define sqrt half_sqrt
#endif

#ifdef USENATIVEMATH
	// minimum accuracy implementation-defined
	#define sin native_sin
	#define cos native_cos
	#define sqrt native_sqrt
#endif

__constant int SPHNUM = 5;
__constant float4 sphPosArr[5] =
{
	(float4)(-6.0f, 0.0f, 0.0f, 1.0f),
	(float4)(-3.0f, 0.0f, 0.0f, 1.0f),
	(float4)( 0.0f, 0.0f, 0.0f, 1.0f),
	(float4)( 3.0f, 0.0f, 0.0f, 1.0f),
	(float4)( 6.0f, 0.0f, 0.0f, 1.0f)
};

typedef struct
{
	float4	origin;
	float4	view, right, up;
} CLCamera;

inline float nextFloat(uint* seed0, uint* seed1)
{
	*seed0 = 36969 * ((*seed0) & 65535) + ((*seed0) >> 16);
	*seed1 = 18000 * ((*seed1) & 65535) + ((*seed1) >> 16);

	return ((((*seed0) << 16) + (*seed1)) & 0xffff) * (1.0f / 0xffff);
}

inline float4 uniformSampleHemiSphere(float u1, float u2)
{
	float r = sqrt( max(0.0f, 1.0f - u1 * u1) );
	float phi = 2.0f * M_PI_F * u2;

    return (float4)(cos(phi) * r, sin(phi) * r, u1, 0.0f);
}

inline bool intersectRayPlane(float* tRay, float4 rayOrg, float4 rayDir, float4 plane)
{
	float denom = dot(plane, rayDir);
	*tRay = -1.0f * dot(plane, rayOrg) / denom;

	return *tRay > 0.0f ? 1 : 0;
}

inline bool intersectRaySphere(float* tRay, float4 rayOrg, float4 rayDir, float4 sphPos, float sphRad)
{
	float4 SphToRay = rayOrg - sphPos;

	float a = 1.0f;//dot(rayDir, rayDir);
	float b = 2.0f * dot(rayDir, SphToRay);
	float c = dot(SphToRay, SphToRay) - sphRad*sphRad;

	float disc = (b*b - 4*a*c);

	if( disc < 0.0f )
	{
		return 0;
	}

	disc = sqrt(disc);
	*tRay = (-b - disc) / (2.0f*a);

	return *tRay > 0.0f ? 1 : 0;
}

inline bool intersectWorldBoolean(float4 rayOrg, float4 rayDir, float4* hitPoint, float4* hitNormal, float currIter, float iterCount)
{
	float tCurr = 1e+6f;
	float tRay;

	#pragma unroll 5
	for(int i = 0; i < SPHNUM; ++i)
	{
		float t = currIter * 2.0f * M_PI_F / iterCount;
		float y = 1.0f + cos((i - 2.0f)*M_PI_F*0.5f + t);

		float4 sphPos = sphPosArr[i] + (float4)(0.0f, y, 0.0f, 0.0f);
		bool hasHit = intersectRaySphere(&tRay, rayOrg, rayDir, sphPos, 1.2f);
		if (hasHit && tRay < tCurr)
		{
			*hitPoint = rayOrg + rayDir * tRay;
			*hitNormal = normalize(*hitPoint - sphPos);

			tCurr = tRay;
		}
	}

	//{
	//	int i = 0;
	//	float t = currIter * 2.0f * M_PI_F / iterCount;
	//	float y = 1.0f + cos((i-2.0f)*M_PI_F*0.5f + t);
	//
	//	float4 sphPos = sphPosArr[i] + (float4)(0.0f, y, 0.0f, 0.0f);
	//	bool hasHit = intersectRaySphere(&tRay, rayOrg, rayDir, sphPos, 1.2f);
	//	if(hasHit && tRay < tCurr)
	//	{
	//		*hitPoint = rayOrg + rayDir * tRay;
	//		*hitNormal = normalize( *hitPoint - sphPos );
	//
	//		tCurr = tRay;
	//	}
	//}
	//{
	//	int i = 1;
	//	float t = currIter * 2.0f * M_PI_F / iterCount;
	//	float y = 1.0f + cos((i - 2.0f)*M_PI_F*0.5f + t);
	//
	//	float4 sphPos = sphPosArr[i] + (float4)(0.0f, y, 0.0f, 0.0f);
	//	bool hasHit = intersectRaySphere(&tRay, rayOrg, rayDir, sphPos, 1.2f);
	//	if (hasHit && tRay < tCurr)
	//	{
	//		*hitPoint = rayOrg + rayDir * tRay;
	//		*hitNormal = normalize(*hitPoint - sphPos);
	//
	//		tCurr = tRay;
	//	}
	//}
	//{
	//	int i = 2;
	//	float t = currIter * 2.0f * M_PI_F / iterCount;
	//	float y = 1.0f + cos((i - 2.0f)*M_PI_F*0.5f + t);
	//
	//	float4 sphPos = sphPosArr[i] + (float4)(0.0f, y, 0.0f, 0.0f);
	//	bool hasHit = intersectRaySphere(&tRay, rayOrg, rayDir, sphPos, 1.2f);
	//	if (hasHit && tRay < tCurr)
	//	{
	//		*hitPoint = rayOrg + rayDir * tRay;
	//		*hitNormal = normalize(*hitPoint - sphPos);
	//
	//		tCurr = tRay;
	//	}
	//}
	//{
	//	int i = 3;
	//	float t = currIter * 2.0f * M_PI_F / iterCount;
	//	float y = 1.0f + cos((i - 2.0f)*M_PI_F*0.5f + t);
	//
	//	float4 sphPos = sphPosArr[i] + (float4)(0.0f, y, 0.0f, 0.0f);
	//	bool hasHit = intersectRaySphere(&tRay, rayOrg, rayDir, sphPos, 1.2f);
	//	if (hasHit && tRay < tCurr)
	//	{
	//		*hitPoint = rayOrg + rayDir * tRay;
	//		*hitNormal = normalize(*hitPoint - sphPos);
	//
	//		tCurr = tRay;
	//	}
	//}
	//{
	//	int i = 4;
	//	float t = currIter * 2.0f * M_PI_F / iterCount;
	//	float y = 1.0f + cos((i - 2.0f)*M_PI_F*0.5f + t);
	//
	//	float4 sphPos = sphPosArr[i] + (float4)(0.0f, y, 0.0f, 0.0f);
	//	bool hasHit = intersectRaySphere(&tRay, rayOrg, rayDir, sphPos, 1.2f);
	//	if (hasHit && tRay < tCurr)
	//	{
	//		*hitPoint = rayOrg + rayDir * tRay;
	//		*hitNormal = normalize(*hitPoint - sphPos);
	//
	//		tCurr = tRay;
	//	}
	//}

	float4 plane = (float4)(0.0f, 1.0f, 0.0f, 1.2f);
	bool hasHit = intersectRayPlane(&tRay, rayOrg, rayDir, plane);
	if(hasHit && tRay < tCurr)
	{
		float4 hitPointTemp = rayOrg + rayDir * tRay;

		if(	hitPointTemp.x < 10.0f && hitPointTemp.x > -10.0f &&
			hitPointTemp.y < 10.0f && hitPointTemp.y > -10.0f &&
			hitPointTemp.z < 10.0f && hitPointTemp.z > -10.0f	)
		{
			*hitPoint = hitPointTemp;
			*hitNormal = plane;
			(*hitNormal).w = 0.0f;

			tCurr = tRay;
		}
	}

	return (tCurr != 1e+6f);
}

__kernel
void ambocc(__global const CLCamera* restrict gCamera, __global uint* restrict gSeed0, __global uint* restrict gSeed1,
		  __write_only image2d_t destTex, const float currIter, const float iterCount)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	//const uint sizeY = get_global_size(1);

	const uint currIndex = (idY * sizeX) + idX;

	float4 aoFloat4 = (float4)(0.0f, 0.0f, 0.0f, 1.0f);

	CLCamera camera = gCamera[0];

	float4 rayOrg = camera.origin;
	float4 rayDir = normalize( camera.view + camera.right * (float)(idX) + camera.up * (float)(idY) );

	float4 hitPoint;
	float4 hitNormal;

	bool primHit = intersectWorldBoolean(rayOrg, rayDir, &hitPoint, &hitNormal, currIter, iterCount);

	int aoHitCount = 0;
	if(primHit)
	{
		float4 aoRayOrg = hitPoint + hitNormal * 0.001f;

		// load seed
		uint seed0 = gSeed0[currIndex];
		uint seed1 = gSeed1[currIndex];

		for(int aoSamp = 0; aoSamp < NUMSAMPLES; ++aoSamp)
		{
			float u0 = nextFloat(&seed0, &seed1);
			float u1 = nextFloat(&seed0, &seed1);
			float4 aoRayDir = uniformSampleHemiSphere( u0, u1 );

			// orient random dir
			if( dot(aoRayDir, hitNormal) < 0.0f )
			{
				aoRayDir = -aoRayDir;
			}

			// dummy hitPoint
			bool aoHit = intersectWorldBoolean(aoRayOrg, aoRayDir, &hitPoint, &hitPoint, currIter, iterCount);
			aoHitCount += aoHit;
		}

		// save seed
		gSeed0[currIndex] = seed0;
		gSeed1[currIndex] = seed1;

		aoFloat4 = (float4)(1.0f - aoHitCount*INVNUMSAMPLES, 1.0f - aoHitCount*INVNUMSAMPLES, 1.0f - aoHitCount*INVNUMSAMPLES, 1.0f);
	}

	write_imagef(destTex, (int2)(idX,idY), aoFloat4);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
