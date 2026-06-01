// ((unsigned int)(-1)) >> 2
#define KDTRIEMPTY 1073741823

#define lightRad 1.25f

//#define USESTACK_VECTOR4
//#define USESTACK_ARRAY4
#define USESTACK_ARRAY2

typedef struct
{
	float4	pos;
	float4	dirTL, dirTR, dirBL, dirBR;
} CLCamera;

typedef struct
{
	float4	org;
	float4	dir;
} CLRay;

//typedef struct
//{
//	int	vertId0, vertId1, vertId2, matId;
//} CLTriangle;

typedef struct
{
	float4	plane, edgePlane20, edgePlane01;
} CLTriangle;

typedef struct
{
	int		triId;			// if nohit - triId = INT_MAX
	float	tHit, b1, b2;
} CLHitRecord;

typedef struct
{
	int		matId;			// if nohit - matId = INT_MAX
	float	weight;
	float2	uv;

	float4	hitPos;
	float4	u,v,w;
} CLHitData;

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

typedef struct
{
	float4	pos;
	float4	u, v, w;
} CLLight;

typedef struct
{
	float4	min, max;
} CLAABB2x4;

typedef struct
{
	float2	x, y, z;
} CLAABB3x2;

typedef struct
{
	float splitPosition;		// interior

	union
	{
		unsigned int flags;		// both: interior = axis - 0,1,2 | leaf = leaf indicator - 3
		unsigned int childId;	// interior
		unsigned int triId;		// leaf
	} data;
} CLKDNode;

// KD helpers
inline float KDGetSplitPosition(__global const CLKDNode* node)
{
	return node->splitPosition;
}
inline bool KDIsLeaf(__global const CLKDNode* node)
{
	return (node->data.flags & 3) == 3;
}
inline uint KDGetSplitAxis(__global const CLKDNode* node)
{
	return node->data.flags & 3;
}
inline uint KDGetChildId(__global const CLKDNode* node)
{
	return node->data.childId >> 2;
}
inline uint KDGetTriId(__global const CLKDNode* node)
{
	return node->data.triId >> 2;
}

inline float4 reflect(float4 inDir, float4 normal)
{
	return inDir - normal * 2.0f * dot(normal, inDir);
}

inline float4 refract(float4 inDir, float4 normal, float ior)
{
	// aligned normal
	float4 n = dot(inDir, normal) < 0.0f ? normal : -normal;
	float ddn = dot(inDir, n);

	// coming from from outside
	bool into = dot(normal, n) > 0.0f;
	float eta = into ? ior : 1.0f/ior;

	float cos2t = 1.0f - eta*eta * (1.0f - ddn*ddn);

	return cos2t < 0.0f ? inDir - n*2.0f*ddn : inDir*eta - n*(ddn*eta + sqrt(cos2t));
}

inline float16 MulMat4Mat4(const float16* mat1, const float16* mat2)
{
	float16 ret;

	ret.s0 = dot((*mat1).s0123, (*mat2).s048C);
	ret.s1 = dot((*mat1).s0123, (*mat2).s159D);
	ret.s2 = dot((*mat1).s0123, (*mat2).s26AE);
	ret.s3 = dot((*mat1).s0123, (*mat2).s37BF);

	ret.s4 = dot((*mat1).s4567, (*mat2).s048C);
	ret.s5 = dot((*mat1).s4567, (*mat2).s159D);
	ret.s6 = dot((*mat1).s4567, (*mat2).s26AE);
	ret.s7 = dot((*mat1).s4567, (*mat2).s37BF);

	ret.s8 = dot((*mat1).s89AB, (*mat2).s048C);
	ret.s9 = dot((*mat1).s89AB, (*mat2).s159D);
	ret.sA = dot((*mat1).s89AB, (*mat2).s26AE);
	ret.sB = dot((*mat1).s89AB, (*mat2).s37BF);

	ret.sC = dot((*mat1).sCDEF, (*mat2).s048C);
	ret.sD = dot((*mat1).sCDEF, (*mat2).s159D);
	ret.sE = dot((*mat1).sCDEF, (*mat2).s26AE);
	ret.sF = dot((*mat1).sCDEF, (*mat2).s37BF);

	return ret;
}
/**/

inline float4 MulMat4Vec4(const float16* mat, const float4* vec)
{
	float4 ret;

	ret.x = dot(*vec, (*mat).s048C);
	ret.y = dot(*vec, (*mat).s159D);
	ret.z = dot(*vec, (*mat).s26AE);
	ret.w = dot(*vec, (*mat).s37BF);

	return ret;
}
/**/

inline float4 textureBilinearLookup(__global const uchar4* restrict texture, int2 iTexSize, const float2 UV)
{
	float2 fTexSize = convert_float2(iTexSize);

	const float2 uv_f = UV*fTexSize;
	fTexSize -= 1.0f;

	const float2 uv_f00 = clamp(floor(uv_f), (float2)(0.0f), fTexSize);
	const float2 uv_f11 = clamp(ceil(uv_f), (float2)(0.0f), fTexSize);
	const float2 uv_f01 = (float2)(uv_f11.x, uv_f00.y);
	const float2 uv_f10 = (float2)(uv_f00.x, uv_f11.y);
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
/**/

/*
bool intersectTriangle(__global const CLRay* ray, const float4 v0, const float4 v1, const float4 v2, float* rayT, float* b1, float* b2)
{
	const float4 e1 = v1 - v0;
	const float4 e2 = v2 - v0;

	const float4 s1 = cross(ray->dir, e2);
	const float divisor = dot(s1, e1);

	if(divisor == 0.0f)
		return false;

	const float inv_divisor = 1.0f / divisor;

	// 1st bary coord
	const float4 d = ray->org - v0;
	*b1 = dot(d, s1) * inv_divisor;
	if(0.0f <= *b1 && *b1 <= 1.0f)
	{
		// 2nd bary coord
		const float4 s2 = cross(d, e1);
		*b2 = dot(ray->dir, s2) * inv_divisor;
		if(0.0f <= *b2 && *b1 + *b2 <= 1.0f)
		{
			*rayT  = dot(e2, s2) * inv_divisor;

			return *rayT > 0.0f;
		}
	}

	return false;
}
*/

inline bool intersectTriangle(const CLRay* ray, const float4 plane, const float4 edgePlane20, const float4 edgePlane01, float* rayT, float* b1, float* b2)
{
	const float denom = dot(plane, ray->dir);
	//if(denom == 0.0f)
	//	return false;

	*rayT = (-1.0f * dot(plane, ray->org)) / denom;

	const float4 intPt = ray->org + (*rayT) * ray->dir;

	*b1 = dot(intPt, edgePlane20);
	*b2 = dot(intPt, edgePlane01);

	//if(*rayT < 0.0f || *b1 < 0.0f || *b2 < 0.0f || *b1 + *b2 > 1.0f)
	//	return false;
	//else
	//	return true;

	bool cond = *b1 >= 0.0f && *b2 >= 0.0f && *b1 + *b2 <= 1.0f && *rayT > 0.0f;
	return cond;
}
/**/

inline bool IntersectAABB2x4(__global const CLAABB2x4* aabb, const CLRay* ray, float* tnear, float* tfar)
{
	*tnear = -FLT_MAX;
	*tfar = FLT_MAX;

	float2 t;

	t = ((float2)(aabb->min.x, aabb->max.x) - ray->org.x) / ray->dir.x;
	*tnear = fmax(*tnear, fmin(t.s0, t.s1));
	*tfar = fmin(*tfar, fmax(t.s0, t.s1));

	t = ((float2)(aabb->min.y, aabb->max.y) - ray->org.y) / ray->dir.y;
	*tnear = fmax(*tnear, fmin(t.s0, t.s1));
	*tfar = fmin(*tfar, fmax(t.s0, t.s1));

	t = ((float2)(aabb->min.z, aabb->max.z) - ray->org.z) / ray->dir.z;
	*tnear = fmax(*tnear, fmin(t.s0, t.s1));
	*tfar = fmin(*tfar, fmax(t.s0, t.s1));

	return (*tfar >= 0.0f) && (*tfar >= *tnear);
}
/**/

inline bool IntersectAABB3x2(__global const CLAABB3x2* aabb, const CLRay* ray, float* tnear, float* tfar)
{
	*tnear = -FLT_MAX;
	*tfar = FLT_MAX;

	float2 tx = (aabb->x - ray->org.x) / ray->dir.x;
	float2 ty = (aabb->y - ray->org.y) / ray->dir.y;
	float2 tz = (aabb->z - ray->org.z) / ray->dir.z;

	// slightly better @ nv gpu
	//tx = (tx.s0 < tx.s1) ? tx : tx.s10;
	//ty = (ty.s0 < ty.s1) ? ty : ty.s10;
	//tz = (tz.s0 < tz.s1) ? tz : tz.s10;

	//*tnear = fmax(*tnear, tx.s0);
	//*tfar = fmin(*tfar, tx.s1);

	//*tnear = fmax(*tnear, ty.s0);
	//*tfar = fmin(*tfar, ty.s1);

	//*tnear = fmax(*tnear, tz.s0);
	//*tfar = fmin(*tfar, tz.s1);

	//*tnear = fmax(*tnear, fmin(tx.s0, tx.s1));
	//*tfar = fmin(*tfar, fmax(tx.s0, tx.s1));

	*tnear = min(tx.s0, tx.s1);
	*tfar = max(tx.s0, tx.s1);

	*tnear = max(*tnear, min(ty.s0, ty.s1));
	*tfar = min(*tfar, max(ty.s0, ty.s1));

	*tnear = max(*tnear, min(tz.s0, tz.s1));
	*tfar = min(*tfar, max(tz.s0, tz.s1));

	return (*tfar >= 0.0f) && (*tfar >= *tnear);
}
/**/

inline bool intersectKDTree(const CLRay* restrict ray, __global const CLTriangle* restrict tris,
					 __global const CLAABB3x2* restrict aabb, __global const CLKDNode* restrict kdnodePool, __global const int* restrict kdtriRegistry,
					 CLHitRecord* hitrec)
{
	bool hasHit = false;

	// find global range for the ray
	float gtNear, gtFar;

	if( !IntersectAABB3x2( aabb, ray, &gtNear, &gtFar ) )
		return false;

	uint offsetRoot = 0;
	bool pushDown;

	__global const CLKDNode* restrict node;
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

			dir_axis = select(dir_axis, ray->dir.x, splitAxis==0);
			org_axis = select(org_axis, ray->org.x, splitAxis==0);

			dir_axis = select(dir_axis, ray->dir.y, splitAxis==1);
			org_axis = select(org_axis, ray->org.y, splitAxis==1);

			dir_axis = select(dir_axis, ray->dir.z, splitAxis==2);
			org_axis = select(org_axis, ray->org.z, splitAxis==2);

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
/**/

__kernel void clearBuffers(__global float4* color, __global float* factor1, __global float4* factor4)
{
	// workitem/worksize info
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t offset = get_global_size(0)*get_global_size(1);

	for(unsigned int s = 0; s < CLPASS; ++s)
	{
		color[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

		factor1[currIndex + s*offset] = (float)(0.0f);
		factor4[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	}
}
/**/

__kernel void clearBuffersFilter(__global float4* colorP, __global float4* colorN, __global float4* colorT, __global float4* colorS,
								 __global float4 *pixelsFloat4Secondary, __global float4 *pixelsFloat4Gi,
								 __global float* factor1, __global float4* factor4)
{
	// workitem/worksize info
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t offset = get_global_size(0)*get_global_size(1);

	for(unsigned int s = 0; s < CLPASS; ++s)
	{
		colorP[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);;
		colorN[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);;
		colorT[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);;
		colorS[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);;

		pixelsFloat4Secondary[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
		pixelsFloat4Gi[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

		factor1[currIndex + s*offset] = (float)(0.0f);
		factor4[currIndex + s*offset] = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	}
}
/**/

__kernel void generatePrimaryRays(__global const CLCamera* restrict camera, __global CLRay* rays)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	CLRay primaryRay;
	primaryRay.org = camera->pos;
	primaryRay.dir = (sizeX - idX - 0.5f) * (sizeY - idY - 0.5f) * camera->dirTL +
					 (idX + 0.5f) * (sizeY - idY - 0.5f) * camera->dirTR +
					 (sizeX - idX - 0.5f) * (idY + 0.5f) * camera->dirBL +
					 (idX + 0.5f) * (idY + 0.5f) * camera->dirBR;
	primaryRay.dir = normalize(primaryRay.dir);

	rays[currIndex] = primaryRay;
}
/**/

__kernel
void generateGIllumRays(__global const CLHitData* restrict hitdata, __global const float2* restrict gillumsamples, const int numPass, __global CLRay* gillumrays)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	gillumrays[currIndex].org = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	if(hitdata[currIndex].matId != INT_MAX)
	{
		const int sampleIndex = currIndex + numPass * get_global_size(0)*get_global_size(1)*get_global_size(2);
		const float sample0 = gillumsamples[sampleIndex].s0;
		const float sample1 = gillumsamples[sampleIndex].s1;

		const float4 yUp = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
		float4 dir = (float4)(sample0, sqrt(max(0.0f, 1.0f - sample0*sample0 - sample1*sample1)), sample1, 0.0f);

		float4 rotDir = cross(yUp, hitdata[currIndex].v);
		float rotAngle = acos( dot(yUp, hitdata[currIndex].v) );
		float sinRAD = sin(rotAngle);
		float cosRAD = cos(rotAngle);

		float16 rotMat;
		rotMat.s0 = cosRAD * (1.0f - rotDir.x*rotDir.x) + rotDir.x*rotDir.x;
		rotMat.s1 = rotDir.x*rotDir.y * (1.0f - cosRAD) + sinRAD*rotDir.z;
		rotMat.s2 = rotDir.x*rotDir.z * (1.0f - cosRAD) - sinRAD*rotDir.y;
		rotMat.s3 = 0.0f;
		rotMat.s4 = rotDir.y*rotDir.x * (1.0f - cosRAD) - sinRAD*rotDir.z;
		rotMat.s5 = cosRAD * (1.0f - rotDir.y*rotDir.y) + rotDir.y*rotDir.y;
		rotMat.s6 = rotDir.y*rotDir.z * (1.0f - cosRAD) + sinRAD*rotDir.x;
		rotMat.s7 = 0.0f;
		rotMat.s8 = rotDir.z*rotDir.x * (1.0f - cosRAD) + sinRAD*rotDir.y;
		rotMat.s9 = rotDir.z*rotDir.y * (1.0f - cosRAD) - sinRAD*rotDir.x;
		rotMat.sA = cosRAD * (1.0f - rotDir.z*rotDir.z) + rotDir.z*rotDir.z;
		rotMat.sB = 0.0f;
		rotMat.sCDEF = (float4)(0.0f, 0.0f, 0.0f, 1.0f);

		dir = MulMat4Vec4(&rotMat, &dir);

		gillumrays[currIndex].org = hitdata[currIndex].hitPos + hitdata[currIndex].v * 0.0001f;
		gillumrays[currIndex].dir = dir;
	}
}
/**/

__kernel
void generateSamplingRays(__global const CLCamera* restrict camera, __global const float2* restrict raysamples, const int numPass, __global float* rayweights, __global CLRay* samplerays)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t idZ = get_global_id(2);

	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);
	const size_t sizeZ = get_global_size(2);

	const size_t currIndex = (idZ * sizeX * sizeY) + (idY * sizeX) + idX;

	float4 camDir = (camera->dirTL + camera->dirTR + camera->dirBL + camera->dirBR) * 0.25f;
	float4 camI = (camDir - ((camera->dirTL + camera->dirBL) * 0.5f)) / (sizeX*0.5f);
	float4 camJ = (camDir - ((camera->dirTL + camera->dirTR) * 0.5f)) / (sizeY*0.5f);

	CLRay primaryRay;
	primaryRay.org = camera->pos;
	primaryRay.dir = camera->dirTL + (idX+raysamples[idZ + numPass*sizeZ].s0) * camI + (idY+raysamples[idZ + numPass*sizeZ].s1) * camJ;
	//primaryRay.dir = camera->dirTL + (idX) * camI + (idY) * camJ;
	primaryRay.dir = normalize(primaryRay.dir);

	rayweights[currIndex] = 1.0f;
	samplerays[currIndex] = primaryRay;
}
/**/

__kernel
void generateHitData(__global const CLHitRecord* restrict hitrecs, __global const float* restrict rayweights, __global const CLRay* restrict rays, __global const float2* restrict shadowSamples, const int numPass,
					 __global const float4* restrict normals, __global const float2* restrict uvs, __global const int* restrict matIds, __global const CLMaterial* restrict materials, __global const CLLight* restrict light,
					 __global CLHitData* restrict hitdata, __global CLRay* restrict raysShadow,
					 __global float* restrict reflectweights, __global CLRay* restrict raysReflect,
					 __global float* restrict refractweights, __global CLRay* restrict raysRefract)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	float weight = rayweights[currIndex];

	const CLHitRecord hitrec = hitrecs[currIndex];
	if( hitrec.triId != INT_MAX )
	{
		const int matId = matIds[hitrec.triId];
		const float b0 = 1.0f - hitrec.b1 - hitrec.b2;

		float4 u = (float4)(0.0f);
		float4 v = normalize(normals[3*hitrec.triId    ] * b0 +
							 normals[3*hitrec.triId + 1] * hitrec.b1 +
							 normals[3*hitrec.triId + 2] * hitrec.b2);

		// ray hits 2sided backface -> flip
		v = dot(rays[currIndex].dir, v) > 0.0f ? -v : v;

		// translucent & backface -> flip + weight
		if( materials[matId].ior != 0.0f && (dot((light->pos - (float4)(0.0f, 0.0f, 0.0f, 1.0f)), v) < 0.0f) )
		{
			v = -v;
			weight *= materials[matId].ior;
		}

		const int i = fabs(v.x) > fabs(v.y) ? (fabs(v.x) > fabs(v.z) ? 0 : 2) : (fabs(v.y) > fabs(v.z) ? 1 : 2);

		u = select(u, (float4)(v.y, -v.x, v.z, 0.0f), (int4)(i==0));
		u = select(u, (float4)(v.z, -v.y, v.x, 0.0f), (int4)(i==1));
		u = select(u, (float4)(v.x, -v.z, v.y, 0.0f), (int4)(i==2));
		// or swizzle + mult with ( 1,-1, 1, 1)

		const float push = dot(rays[currIndex].dir, v) < 0.0f ? 1.0f : -1.0f;
		//const float4 pushVec = ((dot(rays[currIndex].dir, v) < 0.0f ? 1.0f : -1.0f) * 0.001f) * v;

		const int sampleIndex = currIndex + numPass * get_global_size(0)*get_global_size(1)*get_global_size(2);
		const float sample0 = shadowSamples[sampleIndex].s0;
		const float sample1 = shadowSamples[sampleIndex].s1;

		hitdata[currIndex].matId = matId;
		hitdata[currIndex].weight = weight;
		hitdata[currIndex].uv = uvs[3*hitrec.triId    ] * b0 +
								uvs[3*hitrec.triId + 1] * hitrec.b1 +
								uvs[3*hitrec.triId + 2] * hitrec.b2;
		hitdata[currIndex].hitPos = rays[currIndex].org + rays[currIndex].dir * hitrec.tHit;

		raysShadow[currIndex].org = hitdata[currIndex].hitPos + v * (0.0111f * push);
		raysShadow[currIndex].dir = normalize( (light->pos + lightRad * (light->u * sample0 + light->w * sample1)) - (float4)(0.0f, 0.0f, 0.0f, 1.0f) );
		//raysShadow[currIndex].dir = normalize( light->pos - (float4)(0.0f, 0.0f, 0.0f, 1.0f) );

		reflectweights[currIndex] = weight * materials[matId].kr;
		//reflectweights[currIndex] = 0.0f;
		raysReflect[currIndex].org = hitdata[currIndex].hitPos + v * (0.0001f * push);
		raysReflect[currIndex].dir = reflect(rays[currIndex].dir, v);

		refractweights[currIndex] = weight * materials[matId].kt;
		//refractweights[currIndex] = 0.0f;
		raysRefract[currIndex].org = hitdata[currIndex].hitPos - v * (0.0001f * push);
		raysRefract[currIndex].dir = rays[currIndex].dir;

		hitdata[currIndex].u = u;
		hitdata[currIndex].v = v;
		hitdata[currIndex].w = cross(u, v);
	}
	else
	{
		hitdata[currIndex].matId = INT_MAX;
		hitdata[currIndex].weight = weight;

		reflectweights[currIndex] = 0.0f;
		refractweights[currIndex] = 0.0f;
	}
}
/**/

__kernel
void generateHitDataCutOff(__global const CLHitRecord* restrict hitrecs, __global const float* restrict rayweights, __global const CLRay* restrict rays, __global const float2* restrict shadowSamples, const int numPass,
						   __global const float4* restrict normals, __global const float2* restrict uvs, __global const int* restrict matIds, __global const CLMaterial* restrict materials, __global const CLLight* restrict light,
						   __global CLHitData* restrict hitdata, __global CLRay* restrict raysShadow)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	float weight = rayweights[currIndex];

	const CLHitRecord hitrec = hitrecs[currIndex];
	if( hitrec.triId != INT_MAX )
	{
		const int matId = matIds[hitrec.triId];
		const float b0 = 1.0f - hitrec.b1 - hitrec.b2;

		float4 u = (float4)(0.0f);
		float4 v = normalize(normals[3*hitrec.triId    ] * b0 +
							 normals[3*hitrec.triId + 1] * hitrec.b1 +
							 normals[3*hitrec.triId + 2] * hitrec.b2);

		// ray hits 2sided backface -> flip
		v = dot(rays[currIndex].dir, v) > 0.0f ? -v : v;

		// translucent & backface -> flip + weight
		if( materials[matId].ior != 0.0f && (dot((light->pos - (float4)(0.0f, 0.0f, 0.0f, 1.0f)), v) < 0.0f) )
		{
			v = -v;
			weight *= materials[matId].ior;
		}

		const int i = fabs(v.x) > fabs(v.y) ? (fabs(v.x) > fabs(v.z) ? 0 : 2) : (fabs(v.y) > fabs(v.z) ? 1 : 2);

		u = select(u, (float4)(v.y, -v.x, v.z, 0.0f), (int4)(i==0));
		u = select(u, (float4)(v.z, -v.y, v.x, 0.0f), (int4)(i==1));
		u = select(u, (float4)(v.x, -v.z, v.y, 0.0f), (int4)(i==2));
		// or swizzle and mult with ( 1,-1, 1, 1)

		const float push = dot(rays[currIndex].dir, v) < 0.0f ? 1.0f : -1.0f;

		const int sampleIndex = currIndex + numPass * get_global_size(0)*get_global_size(1)*get_global_size(2);
		const float sample0 = shadowSamples[sampleIndex].s0;
		const float sample1 = shadowSamples[sampleIndex].s1;

		hitdata[currIndex].matId = matId;
		hitdata[currIndex].weight = weight;
		hitdata[currIndex].uv = uvs[3*hitrec.triId    ] * b0 +
								uvs[3*hitrec.triId + 1] * hitrec.b1 +
								uvs[3*hitrec.triId + 2] * hitrec.b2;
		hitdata[currIndex].hitPos = rays[currIndex].org + rays[currIndex].dir * hitrec.tHit;

		raysShadow[currIndex].org = hitdata[currIndex].hitPos + v * (0.0111f * push);
		raysShadow[currIndex].dir = normalize( (light->pos + lightRad * (light->u * sample0 + light->w * sample1)) - (float4)(0.0f, 0.0f, 0.0f, 1.0f) );
		//raysShadow[currIndex].dir = normalize( light->pos - (float4)(0.0f, 0.0f, 0.0f, 1.0f) );

		hitdata[currIndex].u = u;
		hitdata[currIndex].v = v;
		hitdata[currIndex].w = cross(u, v);
	}
	else
	{
		hitdata[currIndex].matId = INT_MAX;
		hitdata[currIndex].weight = weight;
	}
}
/**/

//__kernel __attribute__((reqd_work_group_size(4,4,8)))
__kernel
void intersectScene_KDTree(__global const float* restrict rayweights, __global const CLRay* restrict rays, __global const CLTriangle* restrict tris,
						   __global const CLAABB3x2* restrict aabb, __global const CLKDNode* restrict kdnodePool, __global const int* restrict kdtriRegistry,
						   __global CLHitRecord* hitrecs)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	hitrecs[currIndex].triId = INT_MAX;
	if( rayweights[currIndex] == 0.0f )
		return;

	CLHitRecord hitrec;
	hitrec.triId = INT_MAX;
	hitrec.tHit = FLT_MAX;

	CLRay currRay = rays[currIndex];

	intersectKDTree(&currRay, tris, aabb, kdnodePool, kdtriRegistry, &hitrec);

	/*
	for(int i = 0; i < numTriangles; ++i)
	{
		float _tRay, _b1, _b2;
		bool hit = intersectTriangle( rays+currIndex, tris[i].plane, tris[i].edgePlane20, tris[i].edgePlane01, &_tRay, &_b1, &_b2 );

		if( hit && _tRay < tHit )
		{
			tHit = _tRay;
			b1 = _b1;
			b2 = _b2;

			triId = i;
		}
	}
	*/

	hitrecs[currIndex] = hitrec;
}
/**/

//__kernel __attribute__((reqd_work_group_size(4,4,8)))
__kernel
void intersectScene_KDTree_Factor1(__global const CLTriangle*  tris,
								   __global const CLAABB3x2*  aabb, __global const CLKDNode*  kdnodePool, __global const int*  kdtriRegistry,
								   __global const float*  rayweights, __global const CLRay*  shrays, __global float* shColor)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	if( rayweights[currIndex] == 0.0f )
		return;

	CLHitRecord hitrec;
	hitrec.triId = INT_MAX;
	hitrec.tHit = FLT_MAX;

	CLRay currRay = shrays[currIndex];

	intersectKDTree(&currRay, tris, aabb, kdnodePool, kdtriRegistry, &hitrec);

	shColor[currIndex] = hitrec.triId == INT_MAX ? 0.0f : 1.0f;
}
/**/

//__kernel __attribute__((reqd_work_group_size(4,4,8)))
__kernel
void intersectScene_KDTree_Factor4(__global const CLTriangle*  tris,
								   __global const float2*  uvs, __global const int*  matIds, __global const CLMaterial*  materials, __global const uchar4*  textures,
								   __global const CLAABB3x2*  aabb, __global const CLKDNode*  kdnodePool, __global const int*  kdtriRegistry, __global const CLLight*  light,
								   __global const float*  rayweights, __global const CLRay* shrays, __global float4* shColor)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	if( rayweights[currIndex] == 0.0f )
		return;

	float4 retColor = (float4)(1.0f, 1.0f, 1.0f, 1.0f);

	CLHitRecord hitrec;
	hitrec.triId = INT_MAX;
	hitrec.tHit = FLT_MAX;

	int matId = INT_MAX;
	float kt = 0.0f;

	CLRay currRay = shrays[currIndex];

	while(true)
	{
		intersectKDTree(&currRay, tris, aabb, kdnodePool, kdtriRegistry, &hitrec);

		if(hitrec.triId != INT_MAX)
		{
			matId = matIds[hitrec.triId];
			kt = materials[matId].kt;

			if(kt < 0.0001f)
			{
				retColor = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
				retColor.w = hitrec.tHit;

				break;
			}
			else
			{
                float2 uv = uvs[3*hitrec.triId    ] * (1.0f - hitrec.b1 - hitrec.b2) +
							uvs[3*hitrec.triId + 1] * hitrec.b1 +
							uvs[3*hitrec.triId + 2] * hitrec.b2;
				retColor *= kt * textureBilinearLookup(textures + (materials+matId)->texOffset, (int2)((materials+matId)->texWidth, (materials+matId)->texHeight), uv.yx);
				retColor.w = hitrec.tHit;

				currRay.org += currRay.dir * (hitrec.tHit+0.0001f);

				hitrec.triId = INT_MAX;
				hitrec.tHit = FLT_MAX;
			}
		}
		else
		{
			break;
		}
	}

	shColor[currIndex] = retColor;
}
/**/

__kernel
void shadeSceneDS(__global const CLHitData* restrict hitdata, __global const float4* restrict shColor,
				  __global const CLRay* restrict rays, __global const CLMaterial* restrict materials, __global const uchar4* restrict textures, __global const CLLight* restrict light,
				  __global float4* restrict shadedPixels)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	int matId = hitdata[currIndex].matId;
	if(matId != INT_MAX)
	{
		//float4 d = rays[currIndex].dir;
		float4 n = hitdata[currIndex].v;
		//n = dot(light->v, n) < 0.0f ? -n : n;

		float diffFactor = max(0.0f, dot(n, light->v));
		float4 diffColor = textureBilinearLookup(textures + (materials+matId)->texOffset, (int2)((materials+matId)->texWidth, (materials+matId)->texHeight), hitdata[currIndex].uv.yx);

		// diffuse illumination
		shadedPixels[currIndex] += hitdata[currIndex].weight * shColor[currIndex] * diffFactor * diffColor + diffColor * 0.1f;

		//if(hitdata[currIndex].weight == 1.0f)
		//	shadedPixels[currIndex] += 2.0f;
	}
	else
	{
		// sky color based on ray dir y length
		shadedPixels[currIndex] += hitdata[currIndex].weight * max( ((float4)(0.75f, 0.75f, 0.75f, 1.0f) * (1.0f - (rays+currIndex)->dir.y) + (float4)(0.37f, 0.63f, 1.0f, 1.0f) * (rays+currIndex)->dir.y), (float4)(0.0f, 0.0f, 0.0f, 1.0f));

		//if(hitdata[currIndex].weight == 1.0f)
		//	shadedPixels[currIndex] += 1.0f;
	}
}
/**/
/*
__kernel
void shadeSceneDSFilter(__global const CLHitData* hitdata, __global const float4* shColor,
						__global const CLRay* rays, __global const CLMaterial* materials, __global const uchar4* textures, __global const CLLight* light,
						__global float4* shadedPixelsP, __global float4* shadedPixelsN, __global float4* shadedPixelsT, __global float4* shadedPixelsS)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	int matId = hitdata[currIndex].matId;
	if(matId != INT_MAX)
	{
		//float4 d = rays[currIndex].dir;
		float4 n = hitdata[currIndex].v;
		//n = dot(light->v, n) < 0.0f ? -n : n;

		//float diffFactor = max(0.0f, dot(n, light->v));
		float4 diffColor = textureBilinearLookup(textures + (materials+matId)->texOffset, (int2)((materials+matId)->texWidth, (materials+matId)->texHeight), hitdata[currIndex].uv.yx);

		// diffuse illumination
		//shadedPixels[currIndex] += hitdata[currIndex].weight * shColor[currIndex] * diffFactor * diffColor + diffColor * 0.1f;

		shadedPixelsP[currIndex] += length(hitdata[currIndex].hitPos - rays[currIndex].org) * 0.025f;
		shadedPixelsN[currIndex] += fabs(n);
		shadedPixelsT[currIndex] += diffColor;
		shadedPixelsS[currIndex] += shColor[currIndex];
	}
	else
	{
		// sky color based on ray dir y length
		//shadedPixels[currIndex] += hitdata[currIndex].weight * max( ((float4)(0.75f, 0.75f, 0.75f, 1.0f) * (1.0f - (rays+currIndex)->dir.y) + (float4)(0.37f, 0.63f, 1.0f, 1.0f) * (rays+currIndex)->dir.y), (float4)(0.0f, 0.0f, 0.0f, 1.0f));

		shadedPixelsP[currIndex] += (float4)(1.0f);
		//shadedPixelsN[currIndex] += (float4)(0.0f);
		shadedPixelsT[currIndex] += hitdata[currIndex].weight * max( ((float4)(0.75f, 0.75f, 0.75f, 1.0f) * (1.0f - (rays+currIndex)->dir.y) + (float4)(0.37f, 0.63f, 1.0f, 1.0f) * (rays+currIndex)->dir.y), (float4)(0.0f, 0.0f, 0.0f, 1.0f));
		shadedPixelsS[currIndex] += (float4)(1.0f);
	}
}
*/

__kernel
void shadeSceneGI(__global const CLHitData* restrict hitdata, __global const CLHitData* restrict gihitdata, __global const float* restrict shColor,
				  __global const CLRay* restrict rays, __global const CLMaterial* restrict materials, __global const uchar4* restrict textures, __global const CLLight* restrict light,
				  __global float4* restrict shadedPixels)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	int matId = hitdata[currIndex].matId;
	int gimatId = gihitdata[currIndex].matId;

	if(matId != INT_MAX)
	{
		float4 hitNorm = hitdata[currIndex].v;
		float diffFactor = max(0.0f, dot(hitNorm, light->v));

		float4 diffColor = textureBilinearLookup(textures + (materials+matId)->texOffset, (int2)((materials+matId)->texWidth, (materials+matId)->texHeight), hitdata[currIndex].uv.yx);

		if(gimatId != INT_MAX)
		{
			float4 gisurfaceDir = normalize( gihitdata[currIndex].hitPos - hitdata[currIndex].hitPos );
			float gisurfaceFactor = max(0.0f, dot(gisurfaceDir, gihitdata[currIndex].v));

			float4 gidiffColor = textureBilinearLookup(textures + (materials+gimatId)->texOffset, (int2)((materials+gimatId)->texWidth, (materials+gimatId)->texHeight), gihitdata[currIndex].uv.yx);

			shadedPixels[currIndex] += hitdata[currIndex].weight * diffFactor * gisurfaceFactor * gidiffColor * diffColor;

			//if(hitdata[currIndex].weight != 0.0f)
			//	shadedPixels[currIndex] += 2.0f;
		}
		else
		{
			shadedPixels[currIndex] += hitdata[currIndex].weight * (float4)(0.8f, 0.8f, 1.0f, 0.0f) * diffColor;

			//if(hitdata[currIndex].weight != 0.0f)
			//	shadedPixels[currIndex] += 1.0f;
		}
	}
}
/**/

/*
__kernel
void shadeSceneGIFilter(__global const CLHitData* hitdata, __global const CLHitData* gihitdata, __global const float* shColor,
						__global const CLRay* rays, __global const CLMaterial* materials, __global const uchar4* textures, __global const CLLight* light,
						__global float4* shadedPixels)
{
	// workitem/worksize info
	const size_t currIndex = (get_global_id(2) * get_global_size(0) * get_global_size(1)) + (get_global_id(1) * get_global_size(0)) + get_global_id(0);

	int matId = hitdata[currIndex].matId;
	int gimatId = gihitdata[currIndex].matId;

	if(matId != INT_MAX)
	{
		float4 hitNorm = hitdata[currIndex].v;
		float diffFactor = max(0.0f, dot(hitNorm, light->v));

		float4 diffColor = textureBilinearLookup(textures + (materials+matId)->texOffset, (int2)((materials+matId)->texWidth, (materials+matId)->texHeight), hitdata[currIndex].uv.yx);

		if(gimatId != INT_MAX)
		{
			float4 gisurfaceDir = normalize( gihitdata[currIndex].hitPos - hitdata[currIndex].hitPos );
			float gisurfaceFactor = max(0.0f, dot(gisurfaceDir, gihitdata[currIndex].v));

			float4 gidiffColor = textureBilinearLookup(textures + (materials+gimatId)->texOffset, (int2)((materials+gimatId)->texWidth, (materials+gimatId)->texHeight), gihitdata[currIndex].uv.yx);

			shadedPixels[currIndex] += hitdata[currIndex].weight * gisurfaceFactor * gidiffColor * diffFactor;
		}
		else
		{
			shadedPixels[currIndex] += hitdata[currIndex].weight * (float4)(0.8f, 0.8f, 1.0f, 0.0f);
		}
	}
}
*/

__kernel void convertToUChar(__global const float4* restrict pixelsFloat4, __global uchar4* restrict pixelsUchar4)
{
	// workitem/worksize info
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t offset = get_global_size(0)*get_global_size(1);

	float4 accumColor = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	for(unsigned int s = 0; s < CLPASS; ++s)
	{
		accumColor += pixelsFloat4[currIndex + s*offset];
	}

	uchar4 pixelUchar4 = convert_uchar4_sat( (accumColor / (float4)(SAMPLESIZE)) * 255.0f + 0.5f );
	pixelUchar4.s3 = 255;

	pixelsUchar4[currIndex] = pixelUchar4;
}
/**/
/*
__kernel void convertToUCharFilter0(__global float4 *pixelsFloat4P, __global float4 *pixelsFloat4N, __global float4 *pixelsFloat4T, __global float4 *pixelsFloat4S, __global float4 *pixelsFloat4Secondary, __global float4 *pixelsFloat4Gi)
{
	// workitem/worksize info
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t offset = get_global_size(0)*get_global_size(1);

	float4 accumColorP = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	float4 accumColorN = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	float4 accumColorT = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	float4 accumColorS = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	float4 accumColorSecondary = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	float4 accumColorGi = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	for(unsigned int s = 0; s < CLPASS; ++s)
	{
		accumColorP += pixelsFloat4P[currIndex + s*offset];
		accumColorN += pixelsFloat4N[currIndex + s*offset];
		accumColorT += pixelsFloat4T[currIndex + s*offset];
		accumColorS += pixelsFloat4S[currIndex + s*offset];

		accumColorSecondary += pixelsFloat4Secondary[currIndex + s*offset];
		accumColorGi += pixelsFloat4Gi[currIndex + s*offset];
	}

	pixelsFloat4P[currIndex] = accumColorP / SAMPLESIZE;
	pixelsFloat4N[currIndex] = accumColorN / SAMPLESIZE;
	pixelsFloat4T[currIndex] = accumColorT / SAMPLESIZE;
	pixelsFloat4S[currIndex] = accumColorS / SAMPLESIZE;

	pixelsFloat4Secondary[currIndex] = accumColorSecondary / SAMPLESIZE;
	pixelsFloat4Gi[currIndex] = accumColorGi / SAMPLESIZE;
}
*/

//__kernel void convertToUCharFilter1(__global const float4 *pixelsFloat4P, __global const float4 *pixelsFloat4N, __global const float4 *pixelsFloat4T,
//								    __global const float4 *pixelsFloat4Whitted, __global const float4 *pixelsFloat4Gi,
//									__global uchar4* pixelsUchar4)
//{
//	// workitem/worksize info
//	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
//
//	const int filterRad = 15;
//	const float filterPTreshold = 0.6666f;
//	const float filterNTreshold = 0.3333f;
//
//	const float4 currP = pixelsFloat4P[currIndex];
//	const float4 currN = pixelsFloat4N[currIndex];
//
//	float weightAccum = 0.0f;
//	float4 result = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
//
//	for(int i = -filterRad; i <= filterRad; ++i)
//	{
//		for(int j = -filterRad; j <= filterRad; j++)
//		{
//			float pixelWeight = 1.0f;
//
//			int sampleIndex = (get_global_id(1)+i)*get_global_size(0) + (get_global_id(0) + j);
//
//			sampleIndex = max( min(sampleIndex, (int)(get_global_size(0)*get_global_size(1)-1)), 0);
//
//			float4 pVec = currP - pixelsFloat4P[sampleIndex];
//			float pDist = sqrt( dot(pVec, pVec) );
//
//			pixelWeight *= max( 1.0f - (pDist/filterPTreshold), 0.0f );
//
//			float4 nVec = currN - pixelsFloat4N[sampleIndex];
//			float nDist = sqrt( dot(nVec, nVec) );
//
//			pixelWeight *= max( 1.0f - (nDist/filterNTreshold), 0.0f );
//
//			weightAccum += pixelWeight;
//
//			result += pixelsFloat4Gi[sampleIndex] * pixelWeight;
//		}
//	}
//
//	result = pixelsFloat4Whitted[currIndex] + result / weightAccum * pixelsFloat4T[currIndex];
//
//	//uchar4 pixelUchar4 = convert_uchar4( clamp(result, colorBlack, colorWhite) * 255.0f + 0.5f );
//	uchar4 pixelUchar4 = convert_uchar4_sat( result * 255.0f + 0.5f );
//	pixelUchar4.s3 = 255;
//
//	pixelsUchar4[currIndex] = pixelUchar4;
//}
/*
__kernel void convertToUCharFilter1(__read_only image2d_t pixelsFloat4P, __read_only image2d_t pixelsFloat4N, __global const float4 *pixelsFloat4T,
								    __global const float4 *pixelsFloat4Whitted, __read_only image2d_t pixelsFloat4Gi,
									__global uchar4* pixelsUchar4)
{
	// workitem/worksize info
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t x = get_global_id(0);
	const size_t y = get_global_id(1);

	const sampler_t imageSampler =	CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	const int filterRad = 15;
	const float filterPTreshold = 0.6666f;
	const float filterNTreshold = 0.3333f;

	const float4 currP = read_imagef( pixelsFloat4P, imageSampler, (int2)(x, y) );
	const float4 currN = read_imagef( pixelsFloat4N, imageSampler, (int2)(x, y) );

	float weightAccum = 0.0f;
	float4 result = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	for(int i = -filterRad; i <= filterRad; ++i)
	{
		for(int j = -filterRad; j <= filterRad; j++)
		{
			const int2 offset = (int2)(x+j, y+i);
			const float4 p4P = read_imagef( pixelsFloat4P, imageSampler, offset );
			const float4 p4N = read_imagef( pixelsFloat4N, imageSampler, offset );
			const float4 p4Gi = read_imagef( pixelsFloat4Gi, imageSampler, offset );

			float pixelWeight = 1.0f;
			const float4 pVec = currP - p4P;
			const float4 nVec = currN - p4N;

			const float pDist = sqrt( dot(pVec, pVec) );
			const float nDist = sqrt( dot(nVec, nVec) );

			pixelWeight *= max( 1.0f - (pDist/filterPTreshold), 0.0f );
			pixelWeight *= max( 1.0f - (nDist/filterNTreshold), 0.0f );

			weightAccum += pixelWeight;
			result += p4Gi * pixelWeight;
		}
	}

	result = pixelsFloat4Whitted[currIndex] + result / weightAccum * pixelsFloat4T[currIndex];

	uchar4 pixelUchar4 = convert_uchar4_sat( result * 255.0f + 0.5f );
	pixelUchar4.s3 = 255;

	pixelsUchar4[currIndex] = pixelUchar4;
}

__kernel void magicFilterHorizontal(__read_only image2d_t pixelsFloat4P, __read_only image2d_t pixelsFloat4N, __read_only image2d_t pixelsFloat4Gi, __write_only image2d_t giPass)
{
	// workitem/worksize info
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t x = get_global_id(0);
	const size_t y = get_global_id(1);

	const sampler_t imageSampler =	CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	const int filterRad = 15;
	const float filterPTreshold = 0.6666f;
	const float filterNTreshold = 0.3333f;

	const int2 currCoord = (int2)(x, y);
	const float4 currP = read_imagef( pixelsFloat4P, imageSampler, currCoord );
	const float4 currN = read_imagef( pixelsFloat4N, imageSampler, currCoord );

	float weightAccum = 0.0f;
	float4 resultGi = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	int i = 0;
	for(int j = -filterRad; j <= filterRad; j++)
	{
		const int2 offset = (int2)(x+j, y+i);

		const float4 p4P = read_imagef( pixelsFloat4P, imageSampler, offset );
		const float4 p4N = read_imagef( pixelsFloat4N, imageSampler, offset );

		const float4 p4Gi = read_imagef( pixelsFloat4Gi, imageSampler, offset );

		const float pixelWeight = max( 1.0f - (length(currP - p4P)/filterPTreshold), 0.0f ) * max( 1.0f - (length(currN - p4N)/filterNTreshold), 0.0f );

		weightAccum += pixelWeight;
		resultGi += p4Gi * pixelWeight;
	}

	resultGi /= weightAccum;

	write_imagef(giPass, (int2)(x, y), resultGi);
}

__kernel void magicFilterVertical(__read_only image2d_t pixelsFloat4T, __read_only image2d_t pixelsFloat4P, __read_only image2d_t pixelsFloat4N,
								  __read_only image2d_t shadowPass, __read_only image2d_t giPass, __read_only image2d_t pixelsFloat4Secondary,
								  __global const CLLight* light, __global uchar4* pixelsUchar4)
{
	// workitem/worksize info
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	const size_t x = get_global_id(0) + FILTERPADDING_H;
	const size_t y = get_global_id(1) + FILTERPADDING_V;

	const sampler_t imageSampler =	CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	const int filterRad = 15;
	const float filterPTreshold = 0.6666f;
	const float filterNTreshold = 0.3333f;

	const int2 currCoord = (int2)(x, y);
	const float4 currP = read_imagef( pixelsFloat4P, imageSampler, currCoord );
	const float4 currN = read_imagef( pixelsFloat4N, imageSampler, currCoord );
	const float4 currT = read_imagef( pixelsFloat4T, imageSampler, currCoord );

	const float4 currSecondary = read_imagef( pixelsFloat4Secondary, imageSampler, currCoord );

	float weightAccum = 0.0f;
	float4 resultShadow = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	float4 resultGi = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	for(int i = -filterRad; i <= filterRad; ++i)
	{
		int j = 0;

		const int2 offset = (int2)(x+j, y+i);
		const float4 p4P = read_imagef( pixelsFloat4P, imageSampler, offset );
		const float4 p4N = read_imagef( pixelsFloat4N, imageSampler, offset );

		const float4 p4Gi = read_imagef( giPass, imageSampler, offset );

		const float pixelWeight = max( 1.0f - (length(currP - p4P)/filterPTreshold), 0.0f ) * max( 1.0f - (length(currN - p4N)/filterNTreshold), 0.0f );

		weightAccum += pixelWeight;
		resultGi += p4Gi * pixelWeight;
	}

	float4 result;
	if(currN.x < 0.1f && currN.y < 0.1f && currN.z < 0.1f)
	{
		result = currT;
	}
	else
	{
		resultShadow = read_imagef( shadowPass, imageSampler, currCoord );
		resultShadow += read_imagef( shadowPass, imageSampler, currCoord + (int2)( 0, 1) );
		resultShadow += read_imagef( shadowPass, imageSampler, currCoord + (int2)( 1, 0) );
		resultShadow += read_imagef( shadowPass, imageSampler, currCoord + (int2)( 0,-1) );
		resultShadow += read_imagef( shadowPass, imageSampler, currCoord + (int2)(-1, 0) );

		//if(resultShadow.w < 7.5f)
		//{
		//	resultShadow /= 5.0f;
		//}
		//else
		{
			const int bilatRad = resultShadow.w / 2.25f;
			const float bilatSigma = resultShadow.w / 1.25f;

			float4 centerPix = read_imagef( shadowPass, imageSampler, currCoord );
			resultShadow = (float4)(0.0f);
			float sum = 0.0f;

			for(int i = -bilatRad; i <= bilatRad; ++i)
			{
				for(int j = -bilatRad; j <= bilatRad; ++j)
				{
					float4 currPix = read_imagef( shadowPass, imageSampler, currCoord + (int2)(i, j) );
					const float4 p4P = read_imagef( pixelsFloat4P, imageSampler, currCoord + (int2)(i, j) );

					float factor = exp(-(i * i) / (2.0f * bilatSigma * bilatSigma)) * exp(-(j * j) / (2.0f * bilatSigma * bilatSigma));
					factor *= max( 1.0f - (length(currP - p4P)/filterPTreshold), 0.0f);

					resultShadow += factor * currPix;
					sum += factor;
				}
			}

			resultShadow = resultShadow / sum;
		}

		result = (resultShadow) * max(0.0f, dot(currN, light->v)) * currT + currT * 0.1f + currSecondary + (resultGi / weightAccum) * currT;
	}

	uchar4 pixelUchar4 = convert_uchar4_sat( result * 255.0f + 0.5f );
	pixelUchar4.s3 = 255;

	pixelsUchar4[currIndex] = pixelUchar4;
}
*/


// buildOptions=-D numTriangles=600281 -D CLPASS=8 -D SAMPLESIZE=16 -D FILTERPADDING_H=0 -D FILTERPADDING_V=0
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D numTriangles=600281 -D CLPASS=8 -D SAMPLESIZE=16 -D FILTERPADDING_H=0 -D FILTERPADDING_V=0" %cfg_path --cl-device=%cl_device 2>&1
