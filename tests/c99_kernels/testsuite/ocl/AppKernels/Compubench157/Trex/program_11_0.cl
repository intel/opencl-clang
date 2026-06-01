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
__kernel void generatePrimaryRays(global CLParameters* restrict parameters, global CLSun* restrict sun, __global const CLCamera* restrict camera, __global const float2* restrict randomNumbers, __global int* restrict rayNumbers,
								  __global float* restrict rayweights, __global CLRay* restrict rays, __global CLRay* restrict primaryRays,
								  __global CLRayDifferential* restrict rayDiffs)
{
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);
	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	const size_t currIndex = idY * sizeX + idX;

	rayNumbers[currIndex] = rayweights[currIndex] == 1.0f ? rayNumbers[currIndex] + 1 : rayNumbers[currIndex];

	float4 camDir = (camera->dirTL + camera->dirTR + camera->dirBL + camera->dirBR) * 0.25f;
	float4 camI = (camDir - ((camera->dirTL + camera->dirBL) * 0.5f)) / (sizeX*0.5f);
	float4 camJ = (camDir - ((camera->dirTL + camera->dirTR) * 0.5f)) / (sizeY*0.5f);

	CLRay primaryRay;
	primaryRay.org = camera->pos;
	primaryRay.dir = camera->dirTL + (idX) * camI + (idY) * camJ;
	//primaryRay.dir = camera->dirTL + (idX + (randomNumbers[currIndex].x)) * camI + (idY + (randomNumbers[currIndex].y)) * camJ;
	primaryRay.dir = normalize(primaryRay.dir);

	if ((*parameters).DoF){
		float focal = 3.0f + 1000.0f*((*sun).xyYcolor.x);
		float aperture = 1000.0f;
		float4 focalPoint = primaryRay.org + focal*primaryRay.dir;

		float x = sqrt(aperture*randomNumbers[currIndex].x) * cos(2.0f*M_PI_F*randomNumbers[currIndex].y);
		float y = sqrt(aperture*randomNumbers[currIndex].x) * sin(2.0f*M_PI_F*randomNumbers[currIndex].y);

		primaryRay.org += camI*x + camJ*y;
		primaryRay.dir = normalize(focalPoint - primaryRay.org) ;
	}


	CLRayDifferential raydiff;
	raydiff.rxOrg = camera->pos;
	raydiff.ryOrg = camera->pos;
	raydiff.rxDir = camera->dirTL + (idX+1) * camI + (idY  ) * camJ;
	raydiff.ryDir = camera->dirTL + (idX  ) * camI + (idY+1) * camJ;
	raydiff.rxDir = normalize(raydiff.rxDir);
	raydiff.ryDir = normalize(raydiff.ryDir);

	rays[currIndex] = primaryRay;
	primaryRays[currIndex] = primaryRay;
	rayDiffs[currIndex] = raydiff;
}

__kernel void generateRandomNumber (__global const float* restrict mask, __global uint2* restrict randomSeed, __global float2* restrict randomNumbers)
{
	const size_t currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);

	if (mask[currIndex] == 0.0f) return;
	randomSeed[2*currIndex] = 36969 * (randomSeed[2*currIndex] & 65535) + (randomSeed[2*currIndex] >> 16);
	randomSeed[2*currIndex+1] = 18000 * (randomSeed[2*currIndex+1] & 65535) + (randomSeed[2*currIndex+1] >> 16);
	uint2 ires = (randomSeed[2*currIndex] << 16) + randomSeed[2*currIndex+1];
	uint2 ui = (ires & 0x007fffff) | 0x40000000;
	randomNumbers[currIndex] = (as_float2(ui) - 2.0f) / 2.0f;
}

__kernel void generateCosRay(__global float2* restrict randomNumbers, __global CLRay* restrict ray,  __global CLRay* restrict primaryRay, __global const CLHitData* restrict hitdata, __global const CLMaterial* restrict materials, __global float* restrict prob, __global float* restrict clMRayWeights)
{
	const size_t currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);
	primaryRay[currIndex] = ray[currIndex];

	if (hitdata[currIndex].matId!= INT_MAX){
		float phi = 2.0f * M_PI_F * randomNumbers[currIndex].x;
		float theta =  asin(sqrt(randomNumbers[currIndex].y));
		float4 normal = hitdata[currIndex].hitNormal;

		float4 dx0 = cross( (float4)(1.0f, 0.0f, 0.0f, 0.0f),normal );
		float4 dx1 = cross( (float4)(0.0f, 1.0f, 0.0f, 0.0f),normal );

		float4 dx = normalize(dot(dx0,dx0) > dot(dx1,dx1) ? dx0 : dx1);
		float4 dy = normalize(cross(normal,dx));

		ray[currIndex].org = hitdata[currIndex].hitPosition + 0.001f*normal;
		if ((materials + hitdata[currIndex].matId)->texMaskFlag != 0 && hitdata[currIndex].hitKR.z > 0.3f){
			ray[currIndex].dir = Reflect(ray[currIndex].dir, normal);
			prob[currIndex] = 1.0f;
		}
		else{
			prob[currIndex] = cos(theta)/M_PI_F;
			ray[currIndex].dir = normalize(dx*sin(theta)*cos(phi) + dy*sin(theta)*sin(phi) + normal*cos(theta));
		}
	}

	clMRayWeights[currIndex] = hitdata[currIndex].matId == INT_MAX ? 0.0f : 1.0f;
}

__kernel void clearAccumColorsIterative(__global float4* restrict accumLight0StackIterative, __global float4* restrict accumLight1StackIterative, __global float4* restrict accummMaterialIterative, __global float4* restrict accummColorIterative,
										__global float* restrict clMRayWeights, __global int* restrict rayNumbers, __global float4* restrict skyMask, __global float4* restrict filterKD, __global float4* restrict filterKDIterative)
{
	const size_t currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);

	accumLight0StackIterative[currIndex] = (float4)(0.0f);
	accumLight1StackIterative[currIndex] = (float4)(0.0f);
	accummMaterialIterative[currIndex] = (float4)(0.0f);
	accummColorIterative[currIndex]=(float4)(0.0f);

	clMRayWeights[currIndex] = 1.0f;
	rayNumbers[currIndex] = 0;
	skyMask[currIndex] = (float4)(0.0f);
	filterKD[currIndex]=(float4)(1.0f);
	filterKDIterative[currIndex]=(float4)(0.0f);
}

__kernel void clearAccumColors(__global float4* restrict accummColor, __global  float4* restrict accumLight0Stack, __global  float4* restrict accumLight1Stack, __global float4* restrict accumMaterial,
							   __global float4* restrict filterNormals)
{
	const size_t currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);

	accummColor[currIndex]= (float4)(0.0f);
	accumLight0Stack[currIndex] = (float4)(0.0f);
	accumLight1Stack[currIndex] = (float4)(0.0f);
	accumMaterial[currIndex] = (float4)(0.0f);

	filterNormals[currIndex] = (float4)(0.0f);
	filterNormals[currIndex].w = 10.0f;
}

__kernel void writeStack(const uint depth, const int actualIterNum, global CLParameters* restrict parameters, __global const CLHitData* restrict hitdata, __global const CLMaterial* restrict materials, __global CLRay* restrict ray,  __global CLRay* restrict primaryRay, __global float* restrict prob,
					     __global float4* restrict skyColor, __global float4* restrict skyMask, __global const CLLight* restrict light, __global float4* restrict filterNormals,  __global float4* restrict filterKD, __global float4* restrict filterKDIterative,
						 __global float4* restrict lightStack, __global float4* restrict materialStack)
{
	const size_t currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);
	const size_t offset = depth * get_global_size(0) * get_global_size(1);

	if (hitdata[currIndex].matId != INT_MAX){
		if ((materials + hitdata[currIndex].matId)->texMaskFlag != 0 && hitdata[currIndex].hitKR.z > 0.3f){
		//if ((materials + hitdata[currIndex].matId)->texMaskFlag != 0 && hitdata[currIndex].hitKR.x < 0.2f){
			lightStack[offset + currIndex] = (float4)(0.0f);
			materialStack[offset + currIndex] = (float4)(0.4f) + hitdata[currIndex].hitKD;

		}
		else
		if ((materials + hitdata[currIndex].matId)->texMaskFlag != 0 && hitdata[currIndex].hitKR.y > 0.01f && depth==0){
			lightStack[offset + currIndex] = (*parameters).filter == 1 && depth==0 ? skyColor[currIndex] : skyColor[currIndex] * hitdata[currIndex].hitKD;
			materialStack[offset + currIndex] = (dot(ray[currIndex].dir, hitdata[currIndex].hitNormal) * (hitdata[currIndex].hitKD + Specular(-1.0f*primaryRay[currIndex].dir, hitdata[currIndex].hitNormal, (*light).vLight, (float4)(hitdata[currIndex].hitKR.y), 10))) / prob[currIndex];
		}
		else{
			lightStack[offset + currIndex] = (*parameters).filter == 1 && depth==0 ? skyColor[currIndex] : skyColor[currIndex] * hitdata[currIndex].hitKD ;
			materialStack[offset + currIndex] = dot(ray[currIndex].dir, hitdata[currIndex].hitNormal) * hitdata[currIndex].hitKD / prob[currIndex];
		}
		if (depth==0 && actualIterNum==0){
			if ((*parameters).filter == 1){
				filterKD[currIndex] = hitdata[currIndex].hitKD;
				filterKDIterative[currIndex] +=filterKD[currIndex];

			}
			float4 normalTemp = hitdata[currIndex].hitNormal;
			normalTemp.w = hitdata[currIndex].tHit* 1.0f;

			filterNormals[currIndex] = normalTemp;
		}

	}
	else{
		lightStack[offset + currIndex] = skyColor[currIndex];
		materialStack[offset + currIndex] = (float4)(0.0f);
	}

	filterKDIterative[currIndex] = skyMask[currIndex].x !=0.0f ?  1.0f : filterKDIterative[currIndex];
}

__kernel void upStack(const uint depth, __global float4* restrict lightStack, __global float4* restrict materialStack)
{
	const size_t currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);
	const size_t offset = depth * get_global_size(0) * get_global_size(1);
	const size_t offsetB = (depth-1) * get_global_size(0) * get_global_size(1);

	lightStack[offsetB + currIndex] += materialStack[offsetB + currIndex]*lightStack[offset + currIndex];
}

__kernel void accumColors(const int iterNum, __global float4* restrict skyMask, __global float* restrict rayWeights, __global float4* restrict lightStack, __global  float4* restrict materialStack,
						  __global  float4* restrict accumLight0Stack, __global  float4* restrict accumLight1Stack, __global  float4* restrict accummMaterial, __global float4* restrict accumColor, __global float4* restrict filterKD
						  )
{
	const size_t currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);
	const size_t offset = get_global_size(0) * get_global_size(1);

	accumColor[currIndex] += lightStack[currIndex];
	accumLight0Stack[currIndex] += lightStack[currIndex]/iterNum;
	accumLight1Stack[currIndex] += lightStack[offset + currIndex]/iterNum;
	accummMaterial[currIndex] += materialStack[currIndex]/iterNum;

	if ( skyMask[currIndex].x == 0.0f )
		rayWeights[currIndex] = 1.0f;
}

__kernel void composite(const uint iteration, global CLParameters* restrict parameters, __global int* restrict rayNumbers,
					    __global float4* restrict accummColor, __global float4* restrict accummMaterial, __global float4* restrict filterKD, __global float4* restrict filterLight0Stack, __global float4* restrict filterLight1Stack,
						__global float4* restrict accummColorIterative, __global float4* restrict accumLight0StackIterative, __global float4* restrict accumLight1StackIterative, __global float4* restrict accummMaterialIterative, __global float4* restrict finalColor, __global float* restrict filterShadow)
{
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	if ((*parameters).filter == 0){
		if ((*parameters).iterative == 1){
			accummColorIterative[currIndex] += accummColor[currIndex];
			finalColor[currIndex] = accummColorIterative[currIndex]/(float)rayNumbers[currIndex];
		}
		else{
			finalColor[currIndex] = accummColor[currIndex]/(float)rayNumbers[currIndex];
		}
	}

	if ((*parameters).filter == 1){
		if ((*parameters).iterative == 1){
			accumLight0StackIterative[currIndex] += filterLight0Stack[currIndex];
			accumLight1StackIterative[currIndex] += filterLight1Stack[currIndex];
			accummMaterialIterative[currIndex] += accummMaterial[currIndex];
			finalColor[currIndex] = (accumLight0StackIterative[currIndex]/(float)rayNumbers[currIndex])*(filterKD[currIndex]/(float)rayNumbers[currIndex]) + (accumLight1StackIterative[currIndex]/(float)rayNumbers[currIndex])*(accummMaterialIterative[currIndex]/(float)rayNumbers[currIndex]);
		}
		else{
			finalColor[currIndex] = (filterLight0Stack[currIndex])*filterKD[currIndex] + (filterLight1Stack[currIndex])*(accummMaterial[currIndex]);
		}
	}

}

__kernel void toneMapping(__global  float4* restrict normals, global CLParameters* restrict parameters, __global float4* restrict skyMask, __global uchar4* restrict pixelsUchar4, __global float4* restrict finalColor){
	const size_t currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	float exposure = 1.1f;

	if(skyMask[currIndex].x == 0.0f)
		finalColor[currIndex] = HDR(finalColor[currIndex], exposure, 0);
	else
		finalColor[currIndex] = skyMask[currIndex];

	//finalColor[currIndex]*= 1.0f - min(sqrt( max(normals[currIndex].w - 90.0f, 0.0f)*0.002f),0.8f) * (float4)(255.0f/141.0f, 255.0f/167.0f, 255.0f/255.0f, 1.0f);
	finalColor[currIndex] = mix (finalColor[currIndex], (float4)(112.0f/255.0f, 133.0f/255.0f, 224.0f/255.0f, 1.0f), min(sqrt( max(normals[currIndex].w - 90.0f, 0.0f)*0.005f), (float4)(1.0f)));
	//finalColor[currIndex]*= 1.0f - max(normals[currIndex].w-100.0f, 0.0f)*0.0025f * (float4)(255.0f/141.0f, 255.0f/167.0f, 255.0f/255.0f, 1.0f);
	//finalColor[currIndex]+= (float4)(0.0f, 0.0f, 1.0f, 1.0f)*sqrt( max(normals[currIndex].w - 100.0f, 0.0f)*0.001f);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
