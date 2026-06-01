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

inline float rand_float(uint2* rvec){
	(*rvec).x = 36969 * (((*rvec).x) & 65535) + (((*rvec).x) >> 16);
	(*rvec).y = 18000 * (((*rvec).y) & 65535) + (((*rvec).y) >> 16);
	unsigned int ires = (((*rvec).x) << 16) + ((*rvec).y);
	unsigned int ui = (ires & 0x007fffff) | 0x40000000;
	return (as_float(ui) - 2.0f) / 2.0f;
}

float4 HDR (float4 rgb, float exposure, int mask){
	if (mask==0){
		float L = 0.2126f*rgb.x + 0.7152f*rgb.y + 0.0722f*rgb.z;
		float T = 1.0f - exp(-exposure*L);
		return rgb * (T/L);
	}
	return rgb;
}

inline float Luminance(float4 vec){
	return 0.2126f*vec.x + 0.7152f*vec.y + 0.0722f*vec.z;
}

float4 Fresnel (float4 n, float4 k, float theta){
	float4 F0 = ((n-1.0f)*(n-1.0f) + (k*k))/((n+1.0f)*(n+1.0f)+(k*k));
	return F0 + ( (F0*-1.0f) + 1.0f)*pown((1.0f-theta),5);

/*	float4 t1 = n*n - k*k - sin(theta)*sin(theta);
	float4 t2 = sqrt(t1*t1 + 4.0f*n*n*k*k);
	float4 a2 = 0.5f * (t2 +t1), a = sqrt(a2);
	float4 t3 = a2 + 0.5f*(t2-t1);
	float4 t4 = 2.0f * a * cos(theta);
	float4 fsd = (t3 + t4 + cos(theta)*cos(theta));
	float4 Fs = (fsd > 0.0001f) ? (t3-t4 + cos(theta)*cos(theta))/fsd : 0.0f;
	float4 t5 = 2.0f * a * sin(theta) * tan(theta);
	float4 t6 = t3 + sin(theta)*sin(theta)*tan(theta)*tan(theta);
	float4 Fp = (t6 + t5 > 0.0001f) ? Fs * (t6-t5)/(t6+t5) : 0.0f;
	return (Fp+Fs)/2.0f;*/
}

float4 Reflect(float4 v, float4 n){
	return v - (n*dot(n,v)*2);
}

float4 Specular (float4 V, float4 N, float4 L, float4 ks, int n){
	ks = ks*(n+2)/M_PI_F/2.0f;
	float cosdelta = dot(N, normalize(L+V));
	return cosdelta < 0.0f ? (float4)(0.0f) : ks * pow(cosdelta, n);
}

int Refract (float4 V, float4 N, float n, float4* refract){
	float theta = dot((N*-1.0f),V);
	float cn = n;
	if(theta<0) {theta = -theta; N=N*-1.0f; cn=1.0f/n;}
	float D = 1.0f-(1.0f-theta*theta)/(cn*cn);
	if (D<0) return 0;
	*refract = V/cn + N*(theta/cn - sqrt(D));
	return 1;
}

float4 refract(float4 inDir, float4 normal, float ior)
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

float16 MulMat4Mat4(const float16* mat1, const float16* mat2)
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

float4 MulMat4Vec4(const float16* mat, const float4* vec)
{
	float4 ret;

	ret.x = dot(*vec, (*mat).s048C);
	ret.y = dot(*vec, (*mat).s159D);
	ret.z = dot(*vec, (*mat).s26AE);
	ret.w = dot(*vec, (*mat).s37BF);

	return ret;
}
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
__kernel void clearBuffers(__global CLHitRecord* restrict hitrecs, __global float4* restrict pixelsFloat4)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	hitrecs[currIndex].triId = INT_MAX;
	hitrecs[currIndex].tHit = FLT_MAX;
	pixelsFloat4[currIndex] = (float4)(0.0f);
}

__kernel
void generateHitDataPrim(__global const CLHitRecord* restrict hitrecs,
					     __global const CLTriangle* restrict tris, __global const float4* restrict points, __global const float4* restrict normals, __global const float4* restrict tangents, __global const float2* restrict uvs,
					     __global const CLMaterial* restrict materials, __global const int* restrict matIds,
					     __global const uchar4* restrict texturesDiffuseMap, __global const uchar4* restrict texturesMaskMap, __global const uchar4* restrict texturesNormalMap,
					     __global const float* restrict rayweights, __global const CLRay* restrict rays, __global const CLRayDifferential* restrict raydiffs,
					     const unsigned int gtime,
					     __global CLHitData* restrict hitdata)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	const CLHitRecord currHitRec = hitrecs[currIndex];
	CLHitData currHitData;

	if( currHitRec.triId != INT_MAX )
	{
		currHitData.matId = matIds[currHitRec.triId];
		currHitData.tHit = currHitRec.tHit;

		float b0 = 1.0f - currHitRec.b1 - currHitRec.b2;
		float2 uv = uvs[3*currHitRec.triId    ] * b0 +
						  uvs[3*currHitRec.triId + 1] * currHitRec.b1 +
						  uvs[3*currHitRec.triId + 2] * currHitRec.b2;

		float4 p = rays[currIndex].org + rays[currIndex].dir * currHitRec.tHit;

		float4 n = normalize(normals[3*currHitRec.triId    ] * b0 +
							 normals[3*currHitRec.triId + 1] * currHitRec.b1 +
							 normals[3*currHitRec.triId + 2] * currHitRec.b2);
		if (dot(n,-1.0f*rays[currIndex].dir) < -0.25f)
			n*=-1.0f;

		float4 t = normalize(tangents[3*currHitRec.triId    ] * b0 +
							 tangents[3*currHitRec.triId + 1] * currHitRec.b1 +
							 tangents[3*currHitRec.triId + 2] * currHitRec.b2);

		// mipmapping util
		CLRayDifferential raydiff = raydiffs[currIndex];
		CLGeometryDifferential geomdiff = GetGeometryDifferential(points+currHitRec.triId*3, uvs+currHitRec.triId*3);
		CLIntersectionDifferential isectdiff = GetIntersectionDifferential(&raydiff, &geomdiff, points+currHitRec.triId*3, &p);
		const float width = 1.0f * max( max(fabs(isectdiff.dudx), fabs(isectdiff.dvdx)), max(fabs(isectdiff.dudy), fabs(isectdiff.dvdy)) );

		if((materials + currHitData.matId)->texMaskFlag == 999)
		{
			uv += (float2)(-0.0001f, 0.0f) * gtime;
		}

		if((materials + currHitData.matId)->texNormalFlag != 0)
		{
			float4 b = cross(n, t);
			//float4 nTEX = textureBilinearLookup(texturesNormalMap + (materials+currHitData.matId)->texNormalOffset, (int2)((materials+currHitData.matId)->texNormalWidth, (materials+currHitData.matId)->texNormalHeight), uv.yx);
			float4 nTEX = textureBilinearLookupLevel(texturesNormalMap + (materials+currHitData.matId)->texNormalOffset, width, (int2)((materials+currHitData.matId)->texNormalWidth, (materials+currHitData.matId)->texNormalHeight), uv.yx);
			nTEX = nTEX*2.0f - 1.0f;
			nTEX.s3 = 0.0f;
			nTEX = normalize( nTEX );

			float16 tangenframeMAT;

			tangenframeMAT.s0123 = t;
			tangenframeMAT.s4567 = b;
			tangenframeMAT.s89AB = n;
			tangenframeMAT.sCDEF = (float4)(0.0f,0.0f,0.0f,1.0f);

			n = MulMat4Vec4(&tangenframeMAT, &nTEX);
		}

		currHitData.hitPosition = p;
		currHitData.hitNormal = n;

		//currHitData.hitKD = textureBilinearLookup(texturesDiffuseMap + (materials+currHitData.matId)->texOffset, (int2)((materials+currHitData.matId)->texWidth, (materials+currHitData.matId)->texHeight), uv.yx) / M_PI_F;
		currHitData.hitKD = textureBilinearLookupLevel(texturesDiffuseMap + (materials+currHitData.matId)->texOffset, width, (int2)((materials+currHitData.matId)->texWidth, (materials+currHitData.matId)->texHeight), uv.yx) / M_PI_F;

		if ((materials + currHitData.matId)->texMaskFlag != 0)
		{
			//currHitData.hitKR = textureBilinearLookup(texturesMaskMap + (materials+currHitData.matId)->texMaskOffset, (int2)((materials+currHitData.matId)->texMaskWidth, (materials+currHitData.matId)->texMaskHeight), uv.yx);
			currHitData.hitKR = textureBilinearLookupLevel(texturesMaskMap + (materials+currHitData.matId)->texMaskOffset, width, (int2)((materials+currHitData.matId)->texMaskWidth, (materials+currHitData.matId)->texMaskHeight), uv.yx);
			//currHitData.hitKR = (float4)(0.0f);
		}
	}
	else
	{
		currHitData.matId = INT_MAX;
		currHitData.hitKD = (float4)(1.0f);
	}

	hitdata[currIndex] = currHitData;
}

__kernel
void generateHitData(__global const CLHitRecord* restrict hitrecs,
					 __global const CLTriangle* restrict tris, __global const float4* restrict points, __global const float4* restrict normals, __global const float4* restrict tangents, __global const float2* restrict uvs,
					 __global const CLMaterial* restrict materials, __global const int* restrict matIds,
					 __global const uchar4* restrict texturesDiffuseMap, __global const uchar4* restrict texturesMaskMap, __global const uchar4* restrict texturesNormalMap,
					 __global const float* restrict rayweights, __global const CLRay* restrict rays,
					const unsigned int gtime,
					 __global CLHitData* restrict hitdata)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	const CLHitRecord currHitRec = hitrecs[currIndex];
	CLHitData currHitData;

	if( currHitRec.triId != INT_MAX )
	{
		currHitData.matId = matIds[currHitRec.triId];
		currHitData.tHit = currHitRec.tHit;

		float b0 = 1.0f - currHitRec.b1 - currHitRec.b2;
		float2 uv = uvs[3*currHitRec.triId    ] * b0 +
						  uvs[3*currHitRec.triId + 1] * currHitRec.b1 +
						  uvs[3*currHitRec.triId + 2] * currHitRec.b2;

		float4 n = normalize(normals[3*currHitRec.triId    ] * b0 +
							 normals[3*currHitRec.triId + 1] * currHitRec.b1 +
							 normals[3*currHitRec.triId + 2] * currHitRec.b2);
		if (dot(n,-1.0f*rays[currIndex].dir) < -0.25f)
			n*=-1.0f;

		float4 t = normalize(tangents[3*currHitRec.triId    ] * b0 +
							 tangents[3*currHitRec.triId + 1] * currHitRec.b1 +
							 tangents[3*currHitRec.triId + 2] * currHitRec.b2);

		if((materials + currHitData.matId)->texMaskFlag == 999)
		{
			uv += (float2)(-0.0001f, 0.0f) * gtime;
		}

		if((materials + currHitData.matId)->texNormalFlag != 0)
		{
			float4 b = cross(n, t);
			float4 nTEX = textureBilinearLookup(texturesNormalMap + (materials+currHitData.matId)->texNormalOffset, (int2)((materials+currHitData.matId)->texNormalWidth, (materials+currHitData.matId)->texNormalHeight), uv.yx);
			//float4 nTEX = textureBilinearLookupLevel(texturesNormalMap + (materials+currHitData.matId)->texNormalOffset, width, (int2)((materials+currHitData.matId)->texNormalWidth, (materials+currHitData.matId)->texNormalHeight), uv.yx);
			nTEX = nTEX*2.0f - 1.0f;
			nTEX.s3 = 0.0f;
			nTEX = normalize( nTEX );

			float16 tangenframeMAT;

			tangenframeMAT.s0123 = t;
			tangenframeMAT.s4567 = b;
			tangenframeMAT.s89AB = n;
			tangenframeMAT.sCDEF = (float4)(0.0f,0.0f,0.0f,1.0f);

			n = MulMat4Vec4(&tangenframeMAT, &nTEX);
		}

		currHitData.hitPosition = rays[currIndex].org + rays[currIndex].dir * currHitRec.tHit;
		currHitData.hitNormal = n;

		currHitData.hitKD = textureBilinearLookup(texturesDiffuseMap + (materials+currHitData.matId)->texOffset, (int2)((materials+currHitData.matId)->texWidth, (materials+currHitData.matId)->texHeight), uv.yx) / M_PI_F;

		if ((materials + currHitData.matId)->texMaskFlag != 0)
			currHitData.hitKR = textureBilinearLookup(texturesMaskMap + (materials+currHitData.matId)->texMaskOffset, (int2)((materials+currHitData.matId)->texMaskWidth, (materials+currHitData.matId)->texMaskHeight), uv.yx);
		//currHitData.hitKR = (float4)(0.0f);
	}
	else
	{
		currHitData.matId = INT_MAX;
		currHitData.hitKD = (float4)(1.0f);
	}

	hitdata[currIndex] = currHitData;
}

__kernel void generateHitDataShadow(__global const CLHitRecord* restrict hitrecs, __global float* restrict filterShadow)
{
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	float shadowParameter = 10.0f;
	filterShadow[currIndex] = hitrecs[currIndex].triId == INT_MAX ? 0.0f : -(clamp(shadowParameter/hitrecs[currIndex].tHit, 0.0f, shadowParameter) );
}

__kernel void convertToUChar(__global const float4* restrict pixelsFloat4, __global uchar4* restrict pixelsUchar4)
{
	// workitem/worksize info
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	uchar4 pixelUchar4 = convert_uchar4_sat( pixelsFloat4[currIndex] * 255.0f + 0.5f );
	pixelUchar4.s3 = 255;

	pixelsUchar4[currIndex] = pixelUchar4;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
