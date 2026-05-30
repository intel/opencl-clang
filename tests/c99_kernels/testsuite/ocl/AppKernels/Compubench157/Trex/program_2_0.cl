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

typedef struct
{
	float4	rxOrg, ryOrg;
	float4	rxDir, ryDir;
} CLRayDifferential;

typedef struct
{
	float4 dpdu, dpdv;
} CLGeometryDifferential;

typedef struct
{
	//float4	dpdx, dpdy;
	float	dudx, dvdx, dudy, dvdy;
} CLIntersectionDifferential;

//typedef struct
//{
//	int	vertId0, vertId1, vertId2, matId;
//} CLTriangle;

typedef struct
{
	float4	p, ep20, ep01;
} CLTriangle;

typedef struct
{
	int		triId;					// if nohit - triId = INT_MAX
	float	tHit, b1, b2;
} CLHitRecord;

typedef struct
{
	int		matId;					// if nohit - matId = INT_MAX
	float   tHit;
	int		pad0, pad1;

	float4	hitPosition;
	float4	hitNormal;

	float4	hitKD;
	float4	hitKR;
} CLHitData;

typedef struct
{
	int		texOffset;
	int		texWidth;
	int		texHeight;
	int		texFlag;

	int		texMaskOffset;
	int		texMaskWidth;
	int		texMaskHeight;
	int		texMaskFlag;

	int		texLightOffset;
	int		texLightWidth;
	int		texLightHeight;
	int		texLightFlag;

	int		texNormalOffset;
	int		texNormalWidth;
	int		texNormalHeight;
	int		texNormalFlag;
} CLMaterial;

typedef struct
{
	float4	pos;
	float4	uLight, vLight, wLight;
} CLLight;

typedef struct
{
	float4	min, max;
} CLAABB;

typedef struct
{
	int nodeData0;	// parentNode
	int nodeData1;	// childLowerNode OR startTri
	int nodeData2;	// childUpperNode OR countTri
	int nodeData3;	// node ray mask - traversal order
} CLBVHNode;

typedef struct
{
	union
	{
		float kdSplitPosition;	// interior
	};
	union
	{
		unsigned int kdFlags;		// both: interior = axis - 0,1,2 | leaf = leaf indicator - 3
		unsigned int kdChildId;	// interior
		unsigned int kdTriId;		// leaf
	};
} CLKDNode;

typedef struct
{
	int filter;
	int iterative;
	int toneMapping;
	int depth;
	int iterationNum;
	int avgLuminance;
	int filterType;
	int DoF;

}CLParameters;

typedef struct
{
	float intensity;
	float size;
	float turbidity;
	float exposure;
	float2 xyYcolor;
}CLSun;

inline CLGeometryDifferential GetGeometryDifferential(const __global float4* restrict triverts, const __global float2* restrict triuvs)
{
	const float du01 = triuvs[1].x - triuvs[0].x;
	const float du02 = triuvs[2].x - triuvs[0].x;

	const float dv01 = triuvs[1].y - triuvs[0].y;
	const float dv02 = triuvs[2].y - triuvs[0].y;

	const float4 dp01 = triverts[1] - triverts[0];
	const float4 dp02 = triverts[2] - triverts[0];

	const float det = du01 * dv02 - dv01 * du02;

	CLGeometryDifferential geomdiff;

	if(det != 0.0f)
	{
		geomdiff.dpdu = ( dv02 * dp01 - dv01 * dp02 ) / det;
		geomdiff.dpdv = (-du02 * dp01 + du01 * dp02 ) / det;
	}
	else
	{
		const float4 N = normalize( cross(dp01, dp02) );
		const float4 dx0 = cross( (float4)(1.0f, 0.0f, 0.0f, 0.0f), N );
		const float4 dx1 = cross( (float4)(0.0f, 1.0f, 0.0f, 0.0f), N );

		geomdiff.dpdu = normalize( select( dx0, dx1, (int4)(dot(dx0,dx0) < dot(dx1,dx1)) ) );
		geomdiff.dpdv = normalize( cross(N,geomdiff.dpdu) );
	}

	return geomdiff;
}
/**/

inline void SolveLinearSystem2x2(const float A[2][2], const float B[2], float *x0, float *x1)
{
	const float det = A[0][0]*A[1][1] - A[0][1]*A[1][0];

	if( fabs(det) > 1e-10f )
	{
		*x0 = (A[1][1]*B[0] - A[0][1]*B[1]) / det;
		*x1 = (A[0][0]*B[1] - A[1][0]*B[0]) / det;
	}
	else
	{
		*x0 = 0.0f;
		*x1 = 0.0f;
	}
}
/**/

inline CLIntersectionDifferential GetIntersectionDifferential(const CLRayDifferential* raydiff, const CLGeometryDifferential* geomdiff, const __global float4* triverts, const float4* hitPos)
{
	const float4 e01 = triverts[1] - triverts[0];
	const float4 e02 = triverts[2] - triverts[0];
	float4 triplane = normalize( cross(e01, e02) );
	triplane.w = -dot(triplane, triverts[0]);

	const float tx = -dot(triplane, raydiff->rxOrg) / dot(triplane, raydiff->rxDir);
	const float ty = -dot(triplane, raydiff->ryOrg) / dot(triplane, raydiff->ryDir);

	const float4 px = raydiff->rxOrg + tx * raydiff->rxDir;
	const float4 py = raydiff->ryOrg + ty * raydiff->ryDir;

	float A[2][2], Bx[2], By[2];
	int axes[2];
	if (fabs(triplane.x) > fabs(triplane.y) && fabs(triplane.x) > fabs(triplane.z))
	{
		axes[0] = 1; axes[1] = 2;
    }
	else if (fabs(triplane.y) > fabs(triplane.z))
	{
		axes[0] = 0; axes[1] = 2;
	}
    else
	{
		axes[0] = 0; axes[1] = 1;
	}

	// Initialize matrices for chosen projection plane
	//A[0][0] = geomdiff->dpdu[axes[0]];
	//A[0][1] = geomdiff->dpdv[axes[0]];
	//A[1][0] = geomdiff->dpdu[axes[1]];
	//A[1][1] = geomdiff->dpdv[axes[1]];

	//Bx[0] = px[axes[0]] - p[axes[0]];
	//Bx[1] = px[axes[1]] - p[axes[1]];
	//By[0] = py[axes[0]] - p[axes[0]];
	//By[1] = py[axes[1]] - p[axes[1]];

	A[0][0] = select(A[0][0], geomdiff->dpdu.x, axes[0]==0);
	A[0][0] = select(A[0][0], geomdiff->dpdu.y, axes[0]==1);
	A[0][0] = select(A[0][0], geomdiff->dpdu.z, axes[0]==2);

	A[0][1] = select(A[0][1], geomdiff->dpdv.x, axes[0]==0);
	A[0][1] = select(A[0][1], geomdiff->dpdv.y, axes[0]==1);
	A[0][1] = select(A[0][1], geomdiff->dpdv.z, axes[0]==2);

	A[1][0] = select(A[1][0], geomdiff->dpdu.x, axes[1]==0);
	A[1][0] = select(A[1][0], geomdiff->dpdu.y, axes[1]==1);
	A[1][0] = select(A[1][0], geomdiff->dpdu.z, axes[1]==2);

	A[1][1] = select(A[1][1], geomdiff->dpdv.x, axes[1]==0);
	A[1][1] = select(A[1][1], geomdiff->dpdv.y, axes[1]==1);
	A[1][1] = select(A[1][1], geomdiff->dpdv.z, axes[1]==2);

	Bx[0] = select(Bx[0], px.x-(*hitPos).x, axes[0]==0);
	Bx[0] = select(Bx[0], px.y-(*hitPos).y, axes[0]==1);
	Bx[0] = select(Bx[0], px.z-(*hitPos).z, axes[0]==2);

	Bx[1] = select(Bx[1], px.x-(*hitPos).x, axes[1]==0);
	Bx[1] = select(Bx[1], px.y-(*hitPos).y, axes[1]==1);
	Bx[1] = select(Bx[1], px.z-(*hitPos).z, axes[1]==2);

	By[0] = select(By[0], py.x-(*hitPos).x, axes[0]==0);
	By[0] = select(By[0], py.y-(*hitPos).y, axes[0]==1);
	By[0] = select(By[0], py.z-(*hitPos).z, axes[0]==2);

	By[1] = select(By[0], py.x-(*hitPos).x, axes[1]==0);
	By[1] = select(By[0], py.y-(*hitPos).y, axes[1]==1);
	By[1] = select(By[0], py.z-(*hitPos).z, axes[1]==2);

	CLIntersectionDifferential interdiff;

	SolveLinearSystem2x2(A, Bx, &(interdiff.dudx), &(interdiff.dvdx));
	SolveLinearSystem2x2(A, By, &(interdiff.dudy), &(interdiff.dvdy));

	return interdiff;
}
/**/

float4 textureBilinearLookup(__global const uchar4* restrict texture, int2 iTexSize, const float2 UV)
{
	float2 fTexSize = convert_float2(iTexSize);

	float2 fractDummy;
	float2 _UV = fract(UV, &fractDummy);

	const float2 uv_f = _UV*fTexSize;
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

float4 textureBilinearLookupLevel(__global const uchar4* restrict texture, float width, int2 texSize, float2 uv)
{
	float maxLevel = log2((float)texSize.x);

	float _level = maxLevel - 1 + log2( max(width, 1e-8f) );
	_level = clamp(_level, 0.0f, maxLevel-1);

	int iLevel = (int)(_level);
	float delta= _level-iLevel;

	int offset0 = (texSize.x*texSize.y * (pown(0.25f, iLevel) - 1.0f)) / -0.75f;
	int offset1 = (texSize.x*texSize.y * (pown(0.25f, iLevel+1) - 1.0f)) / -0.75f;

	return (1.0f - delta) * textureBilinearLookup(texture+offset0, texSize / (int2)(1 << iLevel), uv) +
				   delta  * textureBilinearLookup(texture+offset1, texSize / (int2)(1 << (iLevel+1)), uv);
}
/**/

float4 sampleEnvMap(__global const CLRay* restrict ray, __global const uchar4* restrict posx, __global const uchar4* restrict negx, __global const uchar4* restrict posy, __global const uchar4* restrict negy, __global const uchar4* restrict posz, __global const uchar4* restrict negz)
{
	float4 cubemapColor = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

    const uint2 minval = (uint2)(0);
    const uint2 maxval = (uint2)(511);

	if( (fabs(ray->dir.x) >= fabs(ray->dir.y)) && (fabs(ray->dir.x) >= fabs(ray->dir.z)) )
	{
		if (1.0f / ray->dir.x > 0.0f)
		{
			float u = (ray->dir.y * 1.0f / ray->dir.x + 1.0f) * 0.5f;
			float v = (ray->dir.z * 1.0f / ray->dir.x + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * (512.0f - 1.0f) );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( posx[t.x * 512 + t.y] ) / 255.0f;
		}
		else
		{
			float u = 1.0f - (ray->dir.y * 1.0f / ray->dir.x + 1.0f) * 0.5f;
			float v =		 (ray->dir.z * 1.0f / ray->dir.x + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * (512.0f - 1.0f) );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( negx[t.x * 512 + t.y] ) / 255.0f;
		}
	}
	else if( fabs(ray->dir.y) >= fabs(ray->dir.z) )
	{
		if (1.0f / ray->dir.y > 0.0f)
		{
			float u = (ray->dir.z * 1.0f / ray->dir.y + 1.0f) * 0.5f;
			float v = (ray->dir.x * 1.0f / ray->dir.y + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * (512.0f - 1.0f) );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( posy[t.x * 512 + t.y] ) / 255.0f;
		}
		else
		{
			float u = (ray->dir.z * 1.0f / ray->dir.y + 1.0f) * 0.5f;
			float v = 1.0f - (ray->dir.x * 1.0f / ray->dir.y + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * (512.0f - 1.0f) );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( negy[t.x * 512 + t.y] ) / 255.0f;
		}
	}
	else
	{
		if (1.0f / ray->dir.z > 0.0f)
		{
			float u = (ray->dir.y * 1.0f / ray->dir.z + 1.0f) * 0.5f;
			float v = 1.0f - (ray->dir.x * 1.0f / ray->dir.z + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * (512.0f - 1.0f) );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( negz[t.x * 512 + t.y] ) / 255.0f;
		}
		else
		{
			float u = 1.0f - (ray->dir.y * 1.0f / ray->dir.z + 1.0f) * 0.5f;
			float v = 1.0f - (ray->dir.x * 1.0f / ray->dir.z + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * (512.0f - 1.0f) );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( posz[t.x * 512 + t.y] ) / 255.0f;
		}
	}

	return cubemapColor;
}
/**/
// ((unsigned int)(-1)) >> 2
#define KDTRIEMPTY 1073741823

//#define USESTACK_SIZE 4
//#define USESTACK_LOCALARR
//#define USESTACK_REGVEC4

#define USESTACK_ARRAY2

// KD helpers
bool KDIsLeaf(__global const CLKDNode* node)
{
	return (node->kdFlags & 3) == 3;
}
float KDGetSplitPosition(__global const CLKDNode* node)
{
	return node->kdSplitPosition;
}
uint KDGetSplitAxis(__global const CLKDNode* node)
{
	return node->kdFlags & 3;
}
uint KDGetChildId(__global const CLKDNode* node)
{
	return node->kdChildId >> 2;
}
uint KDGetTriId(__global const CLKDNode* node)
{
	return node->kdTriId >> 2;
}

bool intersectTriangle(const CLTriangle* tri, const CLRay* ray, float* rayT, float* b1, float* b2)
{
	const float denom = dot(tri->p, ray->dir);

	*rayT = (-1.0f * dot(tri->p, ray->org)) / denom;

	const float4 intPt = ray->org + (*rayT) * ray->dir;

	*b1 = dot(intPt, tri->ep20);
	*b2 = dot(intPt, tri->ep01);

	return *b1 >= 0.0f && *b2 >= 0.0f && *b1 + *b2 <= 1.0f && *rayT > 0.0f;
}
/**/

bool intersectAABB(__global const CLAABB* aabb, const CLRay* ray, float* tnear, float* tfar)
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
/**/

inline void intersectKDTree(const CLRay* restrict ray, __global const CLTriangle* restrict tris,
							__global const CLAABB* restrict aabb, __global const CLKDNode* restrict kdnodePool, __global const int* restrict kdtriRegistry,
							__global const int* restrict kdnodetriIDs, __global const float* restrict kdnodeAABBpp, __global const int* restrict kdnodeRope,
							CLHitRecord* hitrec)
{

//#define PDandSS
#define ROPEPP

#ifdef ROPEPP
	float gtNear = 0.0f;
	int rope;
	__global const CLKDNode* restrict node = kdnodePool;

	int xSign = ray->dir.x >= 0.0f;
	int ySign = ray->dir.y >= 0.0f;
	int zSign = ray->dir.z >= 0.0f;

	bool hasHit = false;

	do
	{
		float4 Pentry = ray->org + ray->dir * gtNear;
		float org_axis, splitPos;
		uint splitAxis;

		while( !KDIsLeaf(node) )
		{
			splitAxis = KDGetSplitAxis(node);
			splitPos = KDGetSplitPosition(node);

			org_axis = Pentry.x;
			org_axis = select(org_axis, Pentry.y, splitAxis==1);
			org_axis = select(org_axis, Pentry.z, splitAxis==2);

			int nodeoffset = KDGetChildId(node);
			nodeoffset = (org_axis <= splitPos) ? nodeoffset : nodeoffset+1;
			node = kdnodePool + nodeoffset;
		}

		int currLeafIndex = KDGetTriId(node);

		float localFarX = (kdnodeAABBpp[6*currLeafIndex + xSign*3    ] - ray->org.x) / ray->dir.x;
		float localFarY = (kdnodeAABBpp[6*currLeafIndex + ySign*3 + 1] - ray->org.y) / ray->dir.y;
		float localFarZ = (kdnodeAABBpp[6*currLeafIndex + zSign*3 + 2] - ray->org.z) / ray->dir.z;
		gtNear = min(localFarX, min(localFarY, localFarZ));

		//int exit_plane = localFarX < localFarY ? (localFarX < localFarZ ? 0 : 2) : (localFarY < localFarZ ? 1 : 2);
		int exit_plane = 0;
		exit_plane = (gtNear == localFarY) ? 1 : exit_plane;
		exit_plane = (gtNear == localFarZ) ? 2 : exit_plane;

		int lu = xSign;
		lu = select(lu, ySign, exit_plane==1);
		lu = select(lu, zSign, exit_plane==2);

		rope = kdnodeRope[currLeafIndex*6 + (exit_plane << 1) + lu];
		node = kdnodePool + rope;

		float _tHit, _b1, _b2;

		int kdTri = kdnodetriIDs[currLeafIndex];
		int currTri = kdtriRegistry[kdTri];

		while(currTri != -1)
		{
			const CLTriangle myTri = tris[currTri];
			const bool hit = intersectTriangle( &myTri, ray, &_tHit, &_b1, &_b2 );

			if( hit && _tHit < hitrec->tHit && _tHit <= gtNear )
			{
				hitrec->triId = currTri;
				hitrec->tHit = _tHit;
				hitrec->b1 = _b1;
				hitrec->b2 = _b2;

				hasHit = true;
			}

			++kdTri;
			currTri = kdtriRegistry[kdTri];
		}

		if(hasHit)
			return;
	}
	while (rope != -1);
	return;
#endif


#ifdef PDandSS
	// find global range for the ray
	float gtNear, gtFar;
	bool hasHit = false;

	if( !intersectAABB( aabb, ray, &gtNear, &gtFar ) )
		return;

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

			dir_axis = ray->dir.x;
			org_axis = ray->org.x;

			dir_axis = splitAxis==1 ? ray->dir.y : dir_axis;
			org_axis = splitAxis==1 ? ray->org.y : org_axis;

			dir_axis = splitAxis==2 ? ray->dir.z : dir_axis;
			org_axis = splitAxis==2 ? ray->org.z : org_axis;

			//switch ( splitAxis )
			//{
			//	case 1:
			//		dir_axis = ray->dir.y;
			//		org_axis = ray->org.y;
			//		break;
			//
			//	case 2:
			//		dir_axis = ray->dir.z;
			//		org_axis = ray->org.z;
			//		break;
			//}

			//dir_axis = select(dir_axis, ray->dir.y, splitAxis==1);
			//org_axis = select(org_axis, ray->org.y, splitAxis==1);

			//dir_axis = select(dir_axis, ray->dir.z, splitAxis==2);
			//org_axis = select(org_axis, ray->org.z, splitAxis==2);

			//dir_axis = ((float*)&(ray->dir))[splitAxis];
			//org_axis = ((float*)&(ray->org))[splitAxis];

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

		float _tHit, _b1, _b2;

		//int kdTri = KDGetTriId(node);
		int kdTri = kdnodetriIDs[KDGetTriId(node)]; //rope indirection
		int currTri = kdtriRegistry[kdTri];

		while(currTri != -1)
		{
			const CLTriangle myTri = tris[currTri];
			const bool hit = intersectTriangle( &myTri, ray, &_tHit, &_b1, &_b2 );

			if( hit && _tHit < hitrec->tHit && _tHit <= (tFar + 0.0001f) )
			{
				hitrec->triId = currTri;
				hitrec->tHit = _tHit;
				hitrec->b1 = _b1;
				hitrec->b2 = _b2;

				hasHit = true;
			}

			++kdTri;
			currTri = kdtriRegistry[kdTri];
		}

		if(hasHit)
			return;
	}

#endif
}

inline void intersectBVH(const CLRay* restrict ray, __global const CLTriangle* restrict tris, __global const int2* restrict mortonPairs,
						__global const CLAABB* restrict bvhNodeAABBs, __global const CLBVHNode* restrict bvhNodeLinks, const int leafOffset, const int dynamicStart,
						 CLHitRecord* restrict hitrec)
{
	int levelIndex = 0;
	int currNode = 0;

	do
	{
		if( currNode < leafOffset )
		{
			const int childL = bvhNodeLinks[currNode].nodeData1;
			const int childU = bvhNodeLinks[currNode].nodeData2;

			float tnearL, tfarL;
			float tnearU, tfarU;

			intersectAABB( bvhNodeAABBs+childL, ray, &tnearL, &tfarL );
			intersectAABB( bvhNodeAABBs+childU, ray, &tnearU, &tfarU );

			const int wantLL = (tnearL <= tfarL) && (tnearL < hitrec->tHit) && (tfarL >= 0.0f);
			const int wantUU = (tnearU <= tfarU) && (tnearU < hitrec->tHit) && (tfarU >= 0.0f);

			if(wantLL | wantUU)
			{
				levelIndex <<= 1;

				if(wantLL ^ wantUU)
				{
					++levelIndex;
					currNode = wantLL * childL + wantUU * childU;
				}
				else
				{
					currNode = tnearL < tnearU ? childL : childU;
				}

				continue;
			}
		}
		else
		{
			// leaf node, intersect tris
			float _tHit, _b1, _b2;

			const int from = bvhNodeLinks[currNode].nodeData1;
			const int count = bvhNodeLinks[currNode].nodeData2;

			for(int currTri = from; currTri < from+count; ++currTri)
			{
				const CLTriangle myTri = tris[currTri + dynamicStart];
				const bool triHit = intersectTriangle( &myTri, ray, &_tHit, &_b1, &_b2 );

				if( triHit && _tHit < hitrec->tHit )
				{
					hitrec->triId = mortonPairs[currTri].s0 + dynamicStart;
					//hitrec->triId = currTri + dynamicStart;
					hitrec->tHit = _tHit;
					hitrec->b1 = _b1;
					hitrec->b2 = _b2;
				}
			}
		}

		++levelIndex;

		while( (levelIndex & 1) == 0 )
		{
			// get parent
			currNode = bvhNodeLinks[currNode].nodeData3;
			levelIndex >>= 1;
		}

		// get sibling
		currNode = bvhNodeLinks[currNode].nodeData0 >> 1;
	}
	while(currNode);
}

//__kernel __attribute__((reqd_work_group_size(8,8,1)))
__kernel
void intersectScene_KDTree(__global const float* restrict rayweights, __global const CLRay* restrict rays,
						   __global const CLTriangle*  restrict tris, __global const CLAABB* restrict aabb, __global const CLKDNode* restrict kdnodePool, __global const int* restrict kdtriRegistry,
						   __global const int* restrict kdnodetriIDs, __global const float* restrict kdnodeAABBpp, __global const int* restrict kdnodeRope,
						   __global CLHitRecord* restrict hitrecs)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	if( rayweights[currIndex] == 0.0f )
		return;

	CLHitRecord currHitRec = hitrecs[currIndex];

	const CLRay currRay = rays[currIndex];

	intersectKDTree(&currRay, tris, aabb, kdnodePool, kdtriRegistry, kdnodetriIDs, kdnodeAABBpp, kdnodeRope, &currHitRec);

	hitrecs[currIndex] = currHitRec;
}

//__kernel __attribute__((reqd_work_group_size(8,8,1)))
__kernel
void intersectScene_KDTreeEX(__global const float* restrict rayweights, __global const CLRay* restrict rays,
							 __global const CLTriangle* restrict tris, __global const float2*  restrict uvs, __global const int*  restrict matIds, __global const CLMaterial*  restrict materials, __global const uchar4* restrict texturesMaskMap,
							 __global const CLAABB* restrict aabb, __global const CLKDNode* restrict kdnodePool, __global const int* restrict kdtriRegistry,
							 __global const int* restrict kdnodetriIDs, __global const float* restrict kdnodeAABBpp, __global const int* restrict kdnodeRope,
							 __global CLHitRecord* restrict hitrecs)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	if( rayweights[currIndex] == 0.0f )
		return;

	CLHitRecord currHitRec = hitrecs[currIndex];

	CLRay currRay = rays[currIndex];
	float rayOrgX = currRay.org.x;

	while(true)
	{
		currHitRec.triId = INT_MAX;
		currHitRec.tHit = FLT_MAX;

		intersectKDTree(&currRay, tris, aabb, kdnodePool, kdtriRegistry, kdnodetriIDs, kdnodeAABBpp, kdnodeRope, &currHitRec);

		if(currHitRec.triId != INT_MAX)
		{
			int matId = matIds[currHitRec.triId];

			float2 uv = uvs[3*currHitRec.triId    ] * (1.0f - currHitRec.b1 - currHitRec.b2) +
						uvs[3*currHitRec.triId + 1] * currHitRec.b1 +
						uvs[3*currHitRec.triId + 2] * currHitRec.b2;

			float4 maskColor = (float4)(1.0f, 0.0f, 0.0f, 9999.0f);

			if((materials+matId)->texMaskFlag == 1)
			{
				maskColor = textureBilinearLookup(texturesMaskMap + (materials+matId)->texMaskOffset, (int2)((materials+matId)->texMaskWidth, (materials+matId)->texMaskHeight), uv.yx);
			}

			currHitRec.tHit += 0.0001f;
            currRay.org += currRay.dir * currHitRec.tHit;

			currHitRec.tHit = (currRay.org.x - rayOrgX) / currRay.dir.x;

			if(maskColor.x >= 0.3f)
			{
				break;
			}
		}
		else
		{
			break;
		}
	}

	hitrecs[currIndex] = currHitRec;
}
/**/

//__kernel __attribute__((reqd_work_group_size(8,8,1)))
__kernel
void intersectScene_BVH(__global const float* restrict rayweights, __global const CLRay* restrict rays,  __global const CLTriangle* restrict tris, __global const int2* restrict mortonPairs,
						__global const CLAABB* restrict bvhNodeAABBs, __global const CLBVHNode* restrict bvhNodeLinks, const int leafOffset, const int dynamicStart,
						__global CLHitRecord* restrict hitrecs)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	if( rayweights[currIndex] == 0.0f )
		return;

	CLHitRecord currHitRec = hitrecs[currIndex];

	const CLRay currRay = rays[currIndex];

	intersectBVH(&currRay, tris, mortonPairs, bvhNodeAABBs, bvhNodeLinks, leafOffset, dynamicStart, &currHitRec);

	hitrecs[currIndex] = currHitRec;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
