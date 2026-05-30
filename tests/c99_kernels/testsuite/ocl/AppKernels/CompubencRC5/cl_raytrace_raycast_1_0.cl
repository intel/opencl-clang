//#define FLT_MAX 	0x1.fffffep127f
//#define FLT_MIN 	0x1.0p-126f
//#define INT_MAX 	2147483647
//#define INT_MIN 	(-2147483647- 1)

typedef struct
{
	float4	pos;
	float4	dirTL, dirTR, dirBL, dirBR;
} CLCamera;
/**/

typedef struct
{
	float4	org;
	float4	dir;
} CLRay;
/**/

typedef struct
{
	float4	plane, edgePlane20, edgePlane01;
} CLTriangle;
/**/

typedef struct
{
	int	triId;			// if nohit - triId = INT_MAX
	float	tHit, b1, b2;
} CLHitRecord;
/**/

typedef struct
{
	float4	hitPosition;
	float4	hitNormal;
	float4	hitColor;
} CLHitData;
/**/

typedef struct
{
	float4	min, max;
} CLAABB2x4;
/**/

typedef struct
{
	float4	diffColor;		// currently unused
	float4	specColor;		// currently unused

	float	shininess;		// currently unused
	float	kr;
	float	kt;
	float	ior;			// currently unused

	int		texOffset;
	int		texWidth;
	int		texHeight;
	int		pad1;
} CLMaterial;
/**/

typedef struct
{
	float splitPosition;
	unsigned int data;
} CLKDNode;
/**/

// KD helpers
inline float KDGetSplitPosition(__global const CLKDNode* restrict node)
{
	return node->splitPosition;
}
inline bool KDIsLeaf(__global const CLKDNode* restrict node)
{
	return (node->data & 3) == 3;
}
inline uint KDGetSplitAxis(__global const CLKDNode* restrict node)
{
	return node->data & 3;
}
inline uint KDGetChildId(__global const CLKDNode* restrict node)
{
	return node->data >> 2;
}
inline uint KDGetTriId(__global const CLKDNode* restrict node)
{
	return node->data >> 2;
}
// ((unsigned int)(-1)) >> 2
#define KDTRIEMPTY 1073741823

#define USESTACK_VECTOR4
//#define USESTACK_ARRAY4
//#define USESTACK_ARRAY2

inline bool intersectTriangle(const CLRay* ray, const float4 plane, const float4 edgePlane20, const float4 edgePlane01, float* rayT, float* b1, float* b2)
{
	const float denom = dot(plane, ray->dir);

	*rayT = (-1.0f * dot(plane, ray->org)) / denom;

	const float4 intPt = ray->org + (*rayT) * ray->dir;

	*b1 = dot(intPt, edgePlane20);
	*b2 = dot(intPt, edgePlane01);

	bool cond = *b1 >= 0.0f && *b2 >= 0.0f && *b1 + *b2 <= 1.0f && *rayT > 0.0f;
	return cond;
}

inline bool IntersectAABB2x4(__global const CLAABB2x4* restrict aabb, const CLRay* ray, float* tnear, float* tfar)
{
	const float4 dirInv= (float4)(1.0f) / ray->dir;

	const float4 tnear4 = dirInv * (aabb->min - ray->org);
    const float4 tfar4 = dirInv * (aabb->max - ray->org);

    const float4 t0 = min(tnear4, tfar4);
    const float4 t1 = max(tnear4, tfar4);

    const float _tnear = max(max(t0.x, t0.y), t0.z);
    const float _tfar = min(min(t1.x, t1.y), t1.z);

    *tnear = _tnear;
    *tfar = _tfar;

    return (_tfar >= _tnear) && (_tfar >= 0.0f);
}

inline bool intersectKDTree(const CLRay* ray, __global const CLTriangle* restrict tris, __global const CLAABB2x4* restrict aabb, __global const CLKDNode* restrict kdnodePool, __global const int* restrict kdtriRegistry,
					 CLHitRecord* hitrec)
{
	bool hasHit = false;

	// find global range for the ray
	float gtNear, gtFar;

	if( !IntersectAABB2x4( aabb, ray, &gtNear, &gtFar ) )
		return false;

	uint offsetRoot = 0;
	bool pushDown;

	__global const CLKDNode* node;
	uint offsetNode;

	float tNear, tFar;
	tNear = tFar = gtNear;

#ifdef USESTACK_VECTOR4
	uint4 stackNode;
	float4 stackFar;
#endif
#ifdef USESTACK_ARRAY4
	uint stackNode[4];
	float stackFar[4];
#endif
#ifdef USESTACK_ARRAY2
	uint stackNode[2];
	float stackFar[2];
#endif

#if (defined USESTACK_VECTOR4) || (defined USESTACK_ARRAY4) || (defined USESTACK_ARRAY2)
	uint stackSize = 0;
#endif

	while( tFar < gtFar )
	{
#if (defined USESTACK_VECTOR4) || (defined USESTACK_ARRAY4) || (defined USESTACK_ARRAY2)
		if(stackSize == 0)
		{
#endif
			node = kdnodePool+offsetRoot;
			offsetNode = offsetRoot;
			tNear = tFar;
			tFar = gtFar;
			pushDown = true;
#if (defined USESTACK_VECTOR4) || (defined USESTACK_ARRAY4) || (defined USESTACK_ARRAY2)
		}
		else
		{
			--stackSize;
			pushDown = false;

#ifdef USESTACK_VECTOR4
			node = kdnodePool+stackNode.s0;
			offsetNode = stackNode.s0;
			tNear = tFar;
			tFar = stackFar.s0;

			stackNode.s012 = stackNode.s123;
			stackFar.s012 = stackFar.s123;
#endif
#ifdef USESTACK_ARRAY4
			node = kdnodePool+stackNode[0];
			offsetNode = stackNode[0];
			tNear = tFar;
			tFar = stackFar[0];

			stackNode[0] = stackNode[1];
			stackNode[1] = stackNode[2];
			stackNode[2] = stackNode[3];

			stackFar[0] = stackFar[1];
			stackFar[1] = stackFar[2];
			stackFar[2] = stackFar[3];
#endif
#ifdef USESTACK_ARRAY2
			node = kdnodePool+stackNode[0];
			offsetNode = stackNode[0];
			tNear = tFar;
			tFar = stackFar[0];

			stackNode[0] = stackNode[1];
			stackFar[0] = stackFar[1];
#endif
		}
#endif

		float tSplit, dir_axis, org_axis, splitPos;
		uint offsetFirst, offsetSecond, splitAxis;

		while( !KDIsLeaf(node) )
		{
			splitAxis = KDGetSplitAxis(node);
			splitPos = KDGetSplitPosition(node);

			dir_axis = ray->dir.x;
            org_axis = ray->org.x;

			dir_axis = (splitAxis==1) ? ray->dir.y : dir_axis;
			org_axis = (splitAxis==1) ? ray->org.y : org_axis;

			dir_axis = (splitAxis==2) ? ray->dir.z : dir_axis;
			org_axis = (splitAxis==2) ? ray->org.z : org_axis;

			tSplit = (splitPos - org_axis) / dir_axis;
			offsetNode = (org_axis < splitPos) || (org_axis == splitPos && dir_axis < 0.0f);

			offsetFirst = KDGetChildId(node) + 1 - offsetNode;
			offsetSecond = KDGetChildId(node) + offsetNode;

			if( tSplit > tFar || tSplit <= 0.0f)
			{
				offsetNode = offsetFirst;
			}
			else if( tSplit <= tNear )
			{
				offsetNode = offsetSecond;
			}
			else
			{
#ifdef USESTACK_VECTOR4
				stackNode = (uint4)(offsetSecond, stackNode.s012);
				stackFar = (float4)(tFar, stackFar.s012);

				//stackSize = min(stackSize+1, (uint)(4));
				stackSize = (stackSize < 3) ? stackSize+1 : 4;
#endif
#ifdef USESTACK_ARRAY4
				stackNode[3] = stackNode[2];
				stackNode[2] = stackNode[1];
				stackNode[1] = stackNode[0];
				stackNode[0] = offsetSecond;

				stackFar[3] = stackFar[2];
				stackFar[2] = stackFar[1];
				stackFar[1] = stackFar[0];
				stackFar[0] = tFar;

				//stackSize = min(stackSize+1, (uint)(4));
				stackSize = (stackSize < 3) ? stackSize+1 : 4;
#endif
#ifdef USESTACK_ARRAY2
				stackNode[1] = stackNode[0];
				stackNode[0] = offsetSecond;

				stackFar[1] = stackFar[0];
				stackFar[0] = tFar;

				//stackSize = min(stackSize+1, (uint)(2));
				stackSize = (stackSize == 0) ? 1 : 2;
#endif
				offsetNode = offsetFirst;
				tFar = tSplit;

				pushDown = false;
			}

			if(pushDown)
				offsetRoot = offsetNode;

			node = kdnodePool+offsetNode;
		}

		if( KDGetTriId(node) != KDTRIEMPTY )
		{
			int triListId = KDGetTriId(node);
			int currTri = kdtriRegistry[triListId];

			while(currTri != -1)
			{
				float _tHit, _b1, _b2;
				/**/
				bool hit = intersectTriangle( ray, tris[currTri].plane, tris[currTri].edgePlane20, tris[currTri].edgePlane01, &_tHit, &_b1, &_b2 );

				if( hit && _tHit < hitrec->tHit && _tHit <= (tFar + 0.0001f) )
				{
					hasHit = true;

					hitrec->triId = currTri;
					hitrec->tHit = _tHit;
					hitrec->b1 = _b1;
					hitrec->b2 = _b2;
				}

				++triListId;
				currTri = kdtriRegistry[triListId];
			}
		}

		if( hasHit )
			return true;
	}

	return hasHit;
}
inline float4 reflectDir(float4 inDir, float4 normal)
{
	return inDir - normal * 2.0f * dot(normal, inDir);
}

inline float4 textureBilinearLookup(__global const uchar4* restrict texture, int2 iTexSize, const float2 UV)
{
	float2 fTexSize = convert_float2(iTexSize);

	const float2 uv_f = UV*fTexSize;
	fTexSize -= 1.0f;

	const float2 uv_f00 = clamp(floor(uv_f), (float2)(0.0f), fTexSize);
	const float2 uv_f11 = clamp(ceil(uv_f), (float2)(0.0f), fTexSize);

	const uint2 uv_00 = convert_uint2(uv_f00);
	const uint2 uv_11 = convert_uint2(uv_f11);

	const uint2 uv_01 = (uint2)(uv_11.x, uv_00.y);
	const uint2 uv_10 = (uint2)(uv_00.x, uv_11.y);

	const float4 t00 = convert_float4(texture[uv_00.x * iTexSize.y + uv_00.y]) / 255.0f;
	const float4 t01 = convert_float4(texture[uv_01.x * iTexSize.y + uv_01.y]) / 255.0f;
	const float4 t10 = convert_float4(texture[uv_10.x * iTexSize.y + uv_10.y]) / 255.0f;
	const float4 t11 = convert_float4(texture[uv_11.x * iTexSize.y + uv_11.y]) / 255.0f;

	const float2 alpha = uv_f - uv_f00;

	return	mix
			(
				mix( t00, t01, (float4)(alpha.x) ),
				mix( t10, t11, (float4)(alpha.x) ),
				(float4)(alpha.y)
			);

    //return alpha.y * (alpha.x * t00 + (1.0f-alpha.x)*t01) + (1.0f-alpha.y) * (alpha.x * t10 + (1.0f-alpha.x) * t11);
}
__kernel
void clearBufferFloat4(__global float4* restrict bufferFloat4)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	//const uint sizeY = get_global_size(1);

	const uint currIndex = (idY * sizeX) + idX;

	bufferFloat4[currIndex] = (float4)(0.0f, 0.0f, 0.0f, 1.0f);
}

__kernel
void clearImageFloat4(__write_only image2d_t imageFloat4)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	//const uint sizeX = get_global_size(0);
	//const uint sizeY = get_global_size(1);

	//const uint currIndex = (idY * sizeX) + idX;

	write_imagef(imageFloat4, (int2)(idX, idY), (float4)(0.0f, 0.0f, 0.0f, 1.0f));
}

__kernel
void convertFloat4(__global float4* restrict bufferFloat4, __write_only image2d_t imagecompFloat4, const int tileOffsetX, const int tileOffsetY)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	//const uint sizeY = get_global_size(1);

	const uint currIndex = (idY * sizeX) + idX;

	float4 shadedPixel = min(bufferFloat4[currIndex], (float4)(1.0f, 1.0f, 1.0f, 1.0f));

	write_imagef(imagecompFloat4, (int2)(idX + tileOffsetX, idY + tileOffsetY), shadedPixel);
}
__kernel
void generatePrimaryRays(__global const CLCamera* restrict camera, __global CLRay* restrict rays, __global float* restrict rayWeights)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	const uint sizeY = get_global_size(1);

	const uint currIndex = (idY * sizeX) + idX;

	CLCamera cam = camera[0];

	CLRay primRay;
	primRay.org = cam.pos;
	primRay.dir = (sizeX - idX - 0.5f) * (sizeY - idY - 0.5f) * cam.dirTL +
				(idX + 0.5f) * (sizeY - idY - 0.5f) * cam.dirTR +
				(sizeX - idX - 0.5f) * (idY + 0.5f) * cam.dirBL +
				(idX + 0.5f) * (idY + 0.5f) * cam.dirBR;
	primRay.dir = normalize(primRay.dir);

	float weight = 1.0f;

	rays[currIndex] = primRay;
	rayWeights[currIndex] = weight;
}
//@ INT_MAX,FLT_MAX

__kernel
void intersectScene(__global const CLRay* restrict rays, __global const float* restrict rayWeights, __global const CLTriangle* restrict tris,
					__global const CLAABB2x4* restrict aabb, __global const CLKDNode* restrict kdnodePool, __global const int* restrict kdtriRegistry,
					__global CLHitRecord* restrict hitRecs)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	//const uint sizeY = get_global_size(1);

	const uint currIndex = (idY * sizeX) + idX;

	CLHitRecord hitrec;
	hitrec.triId = INT_MAX;
	hitrec.tHit = FLT_MAX;

	if( rayWeights[currIndex] != 0.0f )
	{
		CLRay currRay = rays[currIndex];
		intersectKDTree(&currRay, tris, aabb, kdnodePool, kdtriRegistry, &hitrec);
	}

	hitRecs[currIndex] = hitrec;
}
//@ INT_MAX,FLT_MAX

__kernel
void generateHitData(__global const CLHitRecord* restrict hitRecs, __global const CLRay* restrict rays, __global const float* restrict rayWeights,
					 __global const float4* restrict normals, __global const float2* restrict uvs, __global const int* restrict matIds, __global const CLMaterial* restrict materials, __global const uchar4* restrict textures,
					 __global CLRay* restrict raysReflect, __global float* restrict rayWeightsReflect,
					 __global CLRay* restrict raysRefract, __global float* restrict rayWeightsRefract,
					 __global CLRay* restrict raysShadow, __global float* restrict rayWeightsShadow,
					 __global CLHitData* restrict hitData)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	//const uint sizeY = get_global_size(1);

	const uint currIndex = (idY * sizeX) + idX;

	CLHitRecord hitrec = hitRecs[currIndex];

	if( hitrec.triId != INT_MAX )
	{
		CLRay currRay = rays[currIndex];

		float b0 = 1.0f - hitrec.b1 - hitrec.b2;

		float4 n = normalize
		(
			normals[ 3*hitrec.triId     ] * b0 +
			normals[ 3*hitrec.triId + 1 ] * hitrec.b1 +
			normals[ 3*hitrec.triId + 2 ] * hitrec.b2
		);

		n = dot(currRay.dir, n) > 0.0f ? -n : n;

		float2 uv =
		(
			uvs[ 3*hitrec.triId     ] * b0 +
			uvs[ 3*hitrec.triId + 1 ] * hitrec.b1 +
			uvs[ 3*hitrec.triId + 2 ] * hitrec.b2
		);

		int matId = matIds[ hitrec.triId ];

		CLMaterial _mat = materials[matId];
		float4 c = textureBilinearLookup(textures + _mat.texOffset, (int2)(_mat.texWidth, _mat.texHeight), uv.yx);

		float4 pp = currRay.org + currRay.dir * hitrec.tHit + n * 0.001f;
		float4 pn = currRay.org + currRay.dir * hitrec.tHit - n * 0.001f;

		(hitData+currIndex)->hitPosition = pp;
		(hitData+currIndex)->hitNormal = n;
		(hitData+currIndex)->hitColor = c;

		CLRay shadowRay;
		shadowRay.org = pp;
		shadowRay.dir = normalize((float4)(-5.25f, 47.0f, 11.0f, 0.0f));

		raysShadow[currIndex] = shadowRay;
		rayWeightsShadow[currIndex] = 1.0f;
		//rayWeightsShadow[currIndex] = 0.0f;

		float weight = rayWeights[currIndex];

		CLRay reflectRay;
		reflectRay.org = pp;
		reflectRay.dir = reflectDir(currRay.dir, n);

		raysReflect[currIndex] = reflectRay;
		rayWeightsReflect[currIndex] = weight * _mat.kr;
		//rayWeightsReflect[currIndex] = 0.0f;

		CLRay refractRay;
		refractRay.org = pn;
		refractRay.dir = currRay.dir;

		raysRefract[currIndex] = refractRay;
		rayWeightsRefract[currIndex] = weight * _mat.kt;
		//rayWeightsRefract[currIndex] = 0.0f;
	}
	else
	{
		rayWeightsShadow[currIndex] = 0.0f;
		rayWeightsReflect[currIndex] = 0.0f;
		rayWeightsRefract[currIndex] = 0.0f;
	}
}
//@ INT_MAX,FLT_MAX

__kernel
void generateHitDataCutOff(__global const CLHitRecord* restrict hitRecs, __global const CLRay* restrict rays,
						   __global const float4* restrict normals, __global const float2* restrict uvs, __global const int* restrict matIds, __global const CLMaterial* restrict materials, __global const uchar4* restrict textures,
						   __global CLRay* restrict raysShadow, __global float* restrict rayWeightsShadow,
						   __global CLHitData* restrict hitData)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	//const uint sizeY = get_global_size(1);

	const uint currIndex = (idY * sizeX) + idX;

	CLHitRecord hitrec = hitRecs[currIndex];

	if( hitrec.triId != INT_MAX )
	{
		CLRay currRay = rays[currIndex];

		float b0 = 1.0f - hitrec.b1 - hitrec.b2;

		float4 n = normalize
		(
			normals[ 3*hitrec.triId     ] * b0 +
			normals[ 3*hitrec.triId + 1 ] * hitrec.b1 +
			normals[ 3*hitrec.triId + 2 ] * hitrec.b2
		);

		n = dot(currRay.dir, n) > 0.0f ? -n : n;

		float2 uv =
		(
			uvs[ 3*hitrec.triId     ] * b0 +
			uvs[ 3*hitrec.triId + 1 ] * hitrec.b1 +
			uvs[ 3*hitrec.triId + 2 ] * hitrec.b2
		);

		int matId = matIds[ hitrec.triId ];

		CLMaterial _mat = materials[matId];
		float4 c = textureBilinearLookup(textures + _mat.texOffset, (int2)(_mat.texWidth, _mat.texHeight), uv.yx);

		float4 p = currRay.org + currRay.dir * hitrec.tHit + n * 0.001f;

		(hitData+currIndex)->hitPosition = p;
		(hitData+currIndex)->hitNormal = n;
		(hitData+currIndex)->hitColor = c;

		CLRay shadowRay;
		shadowRay.org = p;
		shadowRay.dir = normalize((float4)(-5.25f, 47.0f, 11.0f, 0.0f));

		raysShadow[currIndex] = shadowRay;
		rayWeightsShadow[currIndex] = 1.0f;
		//rayWeightsShadow[currIndex] = 0.0f;
	}
	else
	{
		rayWeightsShadow[currIndex] = 0.0f;
	}
}

//@ INT_MAX,FLT_MAX

__kernel
void shadeScene(__global const CLRay* restrict rays, __global const float* restrict rayWeights,
				__global const CLHitRecord* restrict hitRecs, __global const CLHitData* restrict hitData,
				__global const CLHitRecord* restrict hitRecsShadow,
				__global float4* restrict imageFloat4)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	//const uint sizeY = get_global_size(1);

	const uint currIndex = (idY * sizeX) + idX;

	float4 shadedPixel = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	int triId = (hitRecs+currIndex)->triId;
	float weight = rayWeights[currIndex];

	CLHitData hitdata = hitData[currIndex];

	if( triId != INT_MAX )
	{
		float diffFactor = fmax (0.0f, dot( hitdata.hitNormal, normalize((float4)(-5.25f, 47.0f, 11.0f, 0.0f)) ) );

		int shtriId = (hitRecsShadow+currIndex)->triId;
		float shFactor = shtriId == INT_MAX ? 1.0f : 0.0f;

		shadedPixel = weight * shFactor * diffFactor * hitdata.hitColor + 0.1f * hitdata.hitColor;
	}
	else
	{
		CLRay currRay = rays[currIndex];

		shadedPixel = weight * fmax( (float4)(0.75f, 0.75f, 0.75f, 1.0f) * (1.0f - currRay.dir.y) + (float4)(0.37f, 0.63f, 1.0f, 1.0f) * currRay.dir.y, (float4)(0.0f, 0.0f, 0.0f, 1.0f) );
	}

	imageFloat4[currIndex] += shadedPixel;
}

//@ INT_MAX,FLT_MAX

__kernel
void root(__global const CLCamera* restrict camera, __global const CLTriangle* restrict tris, __global const float4* restrict normals,
		__global const CLAABB2x4* restrict aabb, __global const CLKDNode* restrict kdnodePool, __global const int* restrict kdtriRegistry,
		__write_only image2d_t imagecompFloat4)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);

	const uint sizeX = get_global_size(0);
	const uint sizeY = get_global_size(1);

	float4 camDir = (camera->dirTL + camera->dirTR + camera->dirBL + camera->dirBR) * 0.25f;
	float4 camI = (camDir - ((camera->dirTL + camera->dirBL) * 0.5f)) / (sizeX*0.5f);
	float4 camJ = (camDir - ((camera->dirTL + camera->dirTR) * 0.5f)) / (sizeY*0.5f);

	CLRay currRay;
	currRay.org = camera->pos;
	currRay.dir = camera->dirTL + (idX) * camI + (idY) * camJ;
	currRay.dir = normalize(currRay.dir);

	CLHitRecord hitrec;
	hitrec.triId = INT_MAX;
	hitrec.tHit = FLT_MAX;

	intersectKDTree(&currRay, tris, aabb, kdnodePool, kdtriRegistry, &hitrec);

	float4 shadedPixel = (float4)(0.0f);

	if( hitrec.triId != INT_MAX )
	{
		float b0 = 1.0f - hitrec.b1 - hitrec.b2;

		float4 n = normalize(normals[3*hitrec.triId + 0] * b0 +
							 normals[3*hitrec.triId + 1] * hitrec.b1 +
							 normals[3*hitrec.triId + 2] * hitrec.b2);

		shadedPixel = fabs(n);
	}

	write_imagef(imagecompFloat4, (int2)(idX, idY), shadedPixel);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
