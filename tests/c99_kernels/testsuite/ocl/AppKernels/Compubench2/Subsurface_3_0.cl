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

	float4  geoNormal;
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

typedef struct
{
	//float4 sigma_s;
	//float4 sigma_a;
	//float4 g;
	float4 sigma_t;
	//float4 sigma_sp;
	//float4 sigma_tp;
	//float4 albedo_p;
	float4 D;
	float4 sigma_tr;
	float4 de;
	float4 sigma_tm;
	float  Cp_norm;
	float  Cp;
	float  Ce;
	float  A;
	//float  min_sigma_tr;
	//float  eta;
	//float  pad0, pad1;

	int sampleOffset;
	int sampleCount;
	int meshTriOffset;
	int meshTriCount;



} CLSSSMaterial;

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
	float2 fractDummy;
	float2 _UV = fract(UV, &fractDummy) * iTexSize.y - 0.5f;
	uint2 uv_int = convert_uint2(clamp(floor(_UV), 0.0f, iTexSize.y-1.0f));
	float2 uv_ratio = _UV - (float2)(uv_int.x, uv_int.y);
	float2 uv_opposite = 1.0f - uv_ratio;

	const float4 t00 = convert_float4(texture[uv_int.x * iTexSize.y + uv_int.y]) / 255.0f;
	const float4 t01 = convert_float4(texture[uv_int.x * iTexSize.y + uv_int.y + 1]) / 255.0f;
	const float4 t10 = convert_float4(texture[(uv_int.x + 1) * iTexSize.y + uv_int.y]) / 255.0f;
	const float4 t11 = convert_float4(texture[(uv_int.x + 1) * iTexSize.y + uv_int.y + 1]) / 255.0f;

	return (t00*uv_opposite.x + t10*uv_ratio.x)*uv_opposite.y  + (t01*uv_opposite.x + t11*uv_ratio.x)*uv_ratio.y;
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

			uint2 t = convert_uint2( (float2)(u,v) * 512.0f );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( posx[t.x * 512 + t.y] ) / 255.0f;
		}
		else
		{
			float u = 1.0f - (ray->dir.y * 1.0f / ray->dir.x + 1.0f) * 0.5f;
			float v =		 (ray->dir.z * 1.0f / ray->dir.x + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * 512.0f );
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

			uint2 t = convert_uint2( (float2)(u,v) * 512.0f );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( posy[t.x * 512 + t.y] ) / 255.0f;
		}
		else
		{
			float u = (ray->dir.z * 1.0f / ray->dir.y + 1.0f) * 0.5f;
			float v = 1.0f - (ray->dir.x * 1.0f / ray->dir.y + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * 512.0f );
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

			uint2 t = convert_uint2( (float2)(u,v) * 512.0f );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( negz[t.x * 512 + t.y] ) / 255.0f;
		}
		else
		{
			float u = 1.0f - (ray->dir.y * 1.0f / ray->dir.z + 1.0f) * 0.5f;
			float v = 1.0f - (ray->dir.x * 1.0f / ray->dir.z + 1.0f) * 0.5f;

			uint2 t = convert_uint2( (float2)(u,v) * 512.0f );
            t = min( max(t, minval), maxval);
			cubemapColor = convert_float4( posz[t.x * 512 + t.y] ) / 255.0f;
		}
	}

	return cubemapColor;
}
/**/


__kernel
void generateHitDataRayCastNormal(__global const CLHitRecord* restrict hitrecs, __global const CLTriangle* restrict tris, __global const float* restrict rayweights, __global const CLRay* restrict rays,
								   __global const float4* restrict points, __global float4* restrict color)
{
	const uint currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	const CLHitRecord currHitRec = hitrecs[currIndex];
	float4 hitColor = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	if( currHitRec.triId != INT_MAX )
	{
		float4 v0 =  points[3*currHitRec.triId + 0] - points[3*currHitRec.triId + 1];
		float4 v1 =  points[3*currHitRec.triId + 0] - points[3*currHitRec.triId + 2];
		hitColor = fabs( normalize(cross(v0,v1)) );
	}

	color[currIndex] = hitColor;
}

__kernel
void generateHitDataRayCastTexture(__global const CLHitRecord* restrict hitrecs, __global const CLTriangle* restrict tris, __global const float4* restrict points, __global const float4* restrict normals, __global const float4* restrict tangents, __global const float2* restrict uvs,
								  __global const CLMaterial* restrict materials, __global const int* restrict matIds,
								  __global const uchar4* restrict texturesDiffuseMap, __global const uchar4* restrict texturesMaskMap, __global const uchar4* restrict texturesNormalMap,
								  __global const uchar4* restrict posx, __global const uchar4* restrict negx, __global const uchar4* restrict posy, __global const uchar4* restrict negy, __global const uchar4* restrict posz, __global const uchar4* restrict negz,
								  __global const float* restrict rayweights, __global const CLRay* restrict rays, __global const CLLight* restrict light,
								  __global float4* restrict color)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);
	const uint sizeX = get_global_size(0);
	const uint sizeY = get_global_size(1);

	const uint currIndex = idY * sizeX + idX;

	const CLHitRecord currHitRec = hitrecs[currIndex];
	float4 hitColor = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	float4 gn = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	if( currHitRec.triId != INT_MAX )
	{
		const int matId = matIds[currHitRec.triId];

		const float b0 = 1.0f - currHitRec.b1 - currHitRec.b2;

		float4 v0 =  points[3*currHitRec.triId + 0] - points[3*currHitRec.triId + 1];
		float4 v1 =  points[3*currHitRec.triId + 0] - points[3*currHitRec.triId + 2];
		gn = normalize(cross(v0,v1));

		const float2 uv = uvs[3*currHitRec.triId    ] * b0 +
						  uvs[3*currHitRec.triId + 1] * currHitRec.b1 +
						  uvs[3*currHitRec.triId + 2] * currHitRec.b2;

		float4 p = rays[currIndex].org + rays[currIndex].dir * currHitRec.tHit;

		float4 n = normalize(normals[3*currHitRec.triId    ] * b0 +
					 		 normals[3*currHitRec.triId + 1] * currHitRec.b1 +
							 normals[3*currHitRec.triId + 2] * currHitRec.b2);

		float4 t = normalize(tangents[3*currHitRec.triId    ] * b0 +
							 tangents[3*currHitRec.triId + 1] * currHitRec.b1 +
							 tangents[3*currHitRec.triId + 2] * currHitRec.b2);


		float4 texDiff = textureBilinearLookup(texturesDiffuseMap + (materials+matId)->texOffset, (int2)((materials+matId)->texWidth, (materials+matId)->texHeight), uv.yx);

		if((materials + matId)->texNormalFlag == 1)
		{
			const float16 tangenframeMAT = (float16)( t, cross(n, t), n, (float4)(0.0f,0.0f,0.0f,1.0f) );

			float4 texNorm = textureBilinearLookup(texturesNormalMap + (materials+matId)->texNormalOffset, (int2)((materials+matId)->texNormalWidth, (materials+matId)->texNormalHeight), uv.yx);

			texNorm = texNorm*2.0f - 1.0f;
			texNorm.s3 = 0.0f;
			texNorm = normalize( texNorm );

			n = MulMat4Vec4(&tangenframeMAT, &texNorm);
		}

		if (dot (gn,-1.0f * rays[currIndex].dir) < 0.0f)
			n*=-1.0f;

		float lightDot =  max(dot((float4)(0.0f, 1.0f, 0.0f, 0.0f), n), 0.0f);
		hitColor = texDiff * lightDot;
	}
	else
	{
		hitColor = sampleEnvMap(rays+currIndex, posx, negx, posy, negy, posz, negz);
	}

	color[currIndex] = hitColor;
}

__kernel
void generateHitDataRayCastShadow(__global const CLHitRecord* restrict hitrecs,
					     __global const CLTriangle* restrict tris, __global const float4* restrict points, __global const float4* restrict normals, __global const float4* restrict tangents, __global const float2* restrict uvs,
					     __global const CLMaterial* restrict materials, __global const int* restrict matIds,
					     __global const uchar4* restrict texturesDiffuseMap, __global const uchar4* restrict texturesNormalMap, __global const uchar4* restrict texturesMaskMap,
						 __global const uchar4* restrict posx, __global const uchar4* restrict negx, __global const uchar4* restrict posy, __global const uchar4* restrict negy, __global const uchar4* restrict posz, __global const uchar4* restrict negz,
					     __global const CLRay* restrict rays, __global int2* restrict randomSeed, __global int2* restrict randomSeedTemp,
					     __global CLHitData* restrict hitdata, __global float4* restrict color)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);
	const uint sizeX = get_global_size(0);
	const uint sizeY = get_global_size(1);

	const uint currIndex = idY * sizeX + idX;

	const CLHitRecord currHitRec = hitrecs[currIndex];
	CLHitData currHitData;
	float4 gn = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	if( currHitRec.triId != INT_MAX )
	{
		currHitData.matId = matIds[currHitRec.triId];
		currHitData.tHit = currHitRec.tHit;

		float b0 = 1.0f - currHitRec.b1 - currHitRec.b2;

		float4 v0 =  points[3*currHitRec.triId + 0] - points[3*currHitRec.triId + 1];
		float4 v1 =  points[3*currHitRec.triId + 0] - points[3*currHitRec.triId + 2];
		gn = normalize(cross(v0,v1));

		float2 uv = uvs[3*currHitRec.triId    ] * b0 +
						  uvs[3*currHitRec.triId + 1] * currHitRec.b1 +
						  uvs[3*currHitRec.triId + 2] * currHitRec.b2;

		float4 p = rays[currIndex].org + rays[currIndex].dir * currHitRec.tHit;

		float4 n = normalize(normals[3*currHitRec.triId    ] * b0 +
							 normals[3*currHitRec.triId + 1] * currHitRec.b1 +
							 normals[3*currHitRec.triId + 2] * currHitRec.b2);
		//if (dot(n,-1.0f*rays[currIndex].dir) < -0.25f)
		//	n*=-1.0f;

		float4 t = normalize(tangents[3*currHitRec.triId    ] * b0 +
							 tangents[3*currHitRec.triId + 1] * currHitRec.b1 +
							 tangents[3*currHitRec.triId + 2] * currHitRec.b2);

		if((materials + currHitData.matId)->texNormalFlag != 0)
		{
			float4 b = cross(n, t);
			float4 nTEX = textureBilinearLookup(texturesNormalMap + (materials+currHitData.matId)->texNormalOffset, (int2)((materials+currHitData.matId)->texNormalWidth, (materials+currHitData.matId)->texNormalHeight), uv.yx);
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

		if (dot (gn,-1.0f * rays[currIndex].dir) < 0.0f)
		{
			n*=-1.0f;
			gn*=-1.0f;
		}

		currHitData.hitPosition = p;
		currHitData.hitNormal = n;
		currHitData.geoNormal = gn;

		currHitData.hitKD = textureBilinearLookup(texturesDiffuseMap + (materials+currHitData.matId)->texOffset, (int2)((materials+currHitData.matId)->texWidth, (materials+currHitData.matId)->texHeight), uv.yx);

		currHitData.hitKR = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
		if((materials + currHitData.matId)->texMaskFlag != 0)
		{
			currHitData.hitKR = textureBilinearLookup(texturesMaskMap + (materials+currHitData.matId)->texMaskOffset, (int2)((materials+currHitData.matId)->texMaskWidth, (materials+currHitData.matId)->texMaskHeight), uv.yx);

		}
	}
	else
	{
		currHitData.matId = INT_MAX;
		currHitData.hitKD = sampleEnvMap(rays+currIndex, posx, negx, posy, negy, posz, negz);
	}

	hitdata[currIndex] = currHitData;
	color[currIndex] = currHitData.hitKD;
	randomSeedTemp[2*currIndex] = randomSeed[2*currIndex];
	randomSeedTemp[2*currIndex+1] = randomSeed[2*currIndex+1];
}

__kernel void generateSkyRay (const float shadowParam, __global const CLHitData* restrict hitdata, __global int2* restrict randomSeed, __global const CLLight* restrict light, __global CLRay* restrict shadowRays)
{
	const uint currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);

	randomSeed[2*currIndex] = 36969 * (randomSeed[2*currIndex] & 65535) + (randomSeed[2*currIndex] >> 16);
	randomSeed[2*currIndex+1] = 18000 * (randomSeed[2*currIndex+1] & 65535) + (randomSeed[2*currIndex+1] >> 16);
	float rand1 = (float)((((randomSeed[2*currIndex].x) << 16) + (randomSeed[2*currIndex+1].x)) & 0x007fffff) * (1.0f / (float)(0x007fffff));
	float rand2 = (float)((((randomSeed[2*currIndex].y) << 16) + (randomSeed[2*currIndex+1].y)) & 0x007fffff) * (1.0f / (float)(0x007fffff));

	float4 lightDirection = (*light).vLight;

	float phi = 2.0f * M_PI_F * rand1;
	float theta =  asin(sqrt(rand2)/shadowParam);
	float4 normal = hitdata[currIndex].hitNormal;

	float4 dx0 = cross( (float4)(1.0f, 0.0f, 0.0f, 0.0f), lightDirection );
	float4 dx1 = cross( (float4)(0.0f, 1.0f, 0.0f, 0.0f), lightDirection );

	float4 dx = normalize(dot(dx0,dx0) > dot(dx1,dx1) ? dx0 : dx1);
	float4 dy = normalize(cross(lightDirection,dx));

	shadowRays[currIndex].org = hitdata[currIndex].hitPosition + 0.001f*hitdata[currIndex].geoNormal;
	shadowRays[currIndex].dir = normalize(dx*sin(theta)*cos(phi) + dy*sin(theta)*sin(phi) + lightDirection*cos(theta));
}

__kernel void clearIntBuffer(__global int* restrict inputBuffer)
{
	const uint currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);
	inputBuffer[currIndex] = 0;
}

__kernel void accumShadowHit(__global const CLHitRecord* restrict hitrecs, __global int* restrict shadowHit)
{
	const uint currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);

	if( hitrecs[currIndex].triId == INT_MAX )
		shadowHit[currIndex]++;
}

__kernel void shadowShader(__global const CLRay* restrict rays, __global CLHitData* restrict hitdata, __global int* restrict shadowHit, const uint maxShadowRay, const float ambient, __global const CLLight* restrict light, __global float4* restrict color)
{
	const uint currIndex = get_global_id(1)*get_global_size(0) + get_global_id(0);

	CLHitData currHitData = hitdata[currIndex];

	if(currHitData.tHit != FLT_MAX)
	{
		float lightDot =  max(dot((*light).vLight, currHitData.hitNormal), 0.0f);
		float4 halfDir = normalize((*light).vLight - rays[currIndex].dir);
		float specAngle = max(dot(halfDir, currHitData.hitNormal), 0.0f);
		float specular = pow(specAngle, 10.0f);

		float4 shadeColor = min(currHitData.hitKD*lightDot + currHitData.hitKR.y*specular, 1.0f);
		color[currIndex] = ambient*shadeColor + (shadowHit[currIndex]/(float)maxShadowRay) * (1.0f - ambient) * shadeColor;
	}
	else
	{
		color[currIndex] = currHitData.hitKD;
	}
}

void AtomicAdd(volatile __global float *val, const float delta)
{
	union
	{
		float f;
		unsigned int i;
	} oldVal;

	union
	{
		float f;
		unsigned int i;
	} newVal;

	do
	{
		oldVal.f = *val;
		newVal.f = oldVal.f + delta;
	}

	while (atomic_cmpxchg((volatile __global unsigned int *)val, oldVal.i, newVal.i) != oldVal.i);
}

inline float2 nextRandom(uint2* randomSeed1, uint2* randomSeed2)
{
	*randomSeed1 = 36969 * (*randomSeed1 & 65535) + (*randomSeed1 >> 16);
	*randomSeed2 = 18000 * (*randomSeed2 & 65535) + (*randomSeed2 >> 16);
	return (as_float2(((((*randomSeed1 << 16) + *randomSeed2) & 0x007fffff) | 0x40000000)) - 2.0f) / 2.0f;
}

inline float2 getNextRandomAndUpdate(__global uint2* restrict randomSeed, const int currIndex)
{
	uint2 randomSeed1 = randomSeed[2*currIndex];
	uint2 randomSeed2 = randomSeed[2*currIndex+1];
	float2 random = nextRandom(&randomSeed1, &randomSeed2);
	randomSeed[2*currIndex]   = randomSeed1;
	randomSeed[2*currIndex+1] = randomSeed2;

	return random;
}

inline float getIntensity(float4 posPoint, float4 posLight)
{
	return 20.0f / ( length( posLight - posPoint ) * length( posLight - posPoint ));
}

__kernel void clearAccum(__global float4* restrict accumColor0)
{
	const uint currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	float4 clearColor = (float4)(0.0f);

	accumColor0[currIndex] = clearColor;
}

__kernel void clearAccumThree(__global float4* restrict accumColor0, __global float4* restrict accumColor1, __global float4* restrict accumColor2)
{
	const uint currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	float4 clearColor = (float4)(0.0f);

	accumColor0[currIndex] = clearColor;
	accumColor1[currIndex] = clearColor;
	accumColor2[currIndex] = clearColor;
}

__kernel void trianglePreCompute(const int meshIndex, const int triCount, __global const float4* restrict points, __global float* restrict triWeights,
								 volatile __global float* triangleSum, __global const CLHitRecord* restrict hitrecs, __global const CLLight* restrict light,  __global const float4* restrict normals,
								 __global float* restrict irradiances)
{
	const uint currIndex = get_global_id(0);

	if(currIndex == 0)
	{
		triangleSum[meshIndex] = 0.0f;
	}

	float4 PointA = points[3*(currIndex) + 0];
	float4 PointB = points[3*(currIndex) + 1];
	float4 PointC = points[3*(currIndex) + 2];

	float4 NormalA = normals[3*(currIndex) + 0];
	float4 NormalB = normals[3*(currIndex) + 1];
	float4 NormalC = normals[3*(currIndex) + 2];

	float4 LightPos = light[0].pos;
	float4 sw0 = normalize(LightPos - PointA);
	float4 sw1 = normalize(LightPos - PointB);
	float4 sw2 = normalize(LightPos - PointC);

	float cos_wi_n0 = max(dot(NormalA,sw0), 0.0f);
	float cos_wi_n1 = max(dot(NormalB,sw1), 0.0f);
	float cos_wi_n2 = max(dot(NormalC,sw2), 0.0f);

	float intensity0 = getIntensity(PointA, LightPos) * cos_wi_n0;
	float intensity1 = getIntensity(PointB, LightPos) * cos_wi_n1;
	float intensity2 = getIntensity(PointC, LightPos) * cos_wi_n2;

	float irradiance = (intensity0+intensity1+intensity2)/3.0f;
	float triArea = (length(cross(PointB - PointA, PointC - PointA)) / 2.0f)  * irradiance;
	triWeights[meshIndex*triCount + currIndex] = triArea;
	irradiances[meshIndex*triCount + currIndex] = irradiance;

	barrier(CLK_GLOBAL_MEM_FENCE);
	AtomicAdd(&triangleSum[meshIndex], triArea);
}

__kernel void triangleWeightScan(const int meshIndex, const uint triCount, __global float* restrict triWeights, __global float* triangleSum)
{
	float incSum = 0.0f;
	for (int i=0; i < triCount; i++)
	{
		incSum += triWeights[meshIndex*triCount + i] / triangleSum[meshIndex];
		triWeights[meshIndex*triCount + i] = incSum;
	}
}

__kernel void generatePrimaryRaysAA(__global const CLCamera* restrict camera, __global float* restrict rayweights, __global CLRay* restrict rays,  __global uint2* restrict randomSeed)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);
	const uint sizeX = get_global_size(0);
	const uint sizeY = get_global_size(1);

	const uint currIndex = idY * sizeX + idX;

	//random number generation
	float2 random = getNextRandomAndUpdate(randomSeed, currIndex);

	const float4 camDir = (camera->dirTL + camera->dirTR + camera->dirBL + camera->dirBR) * 0.25f;
	const float4 camI = (camera->dirBR - camera->dirBL) / sizeX;
	const float4 camJ = (camera->dirTL - camera->dirBL) / sizeY;

	CLRay primaryRay;
	primaryRay.org = camera->pos;
	primaryRay.dir = camera->dirBL + (idX) * camI + camI*random.x + (idY) * camJ + camJ*random.y;
	//primaryRay.dir = camera->dirBL + (idX) * camI + (idY) * camJ;
	primaryRay.dir = normalize(primaryRay.dir);

	rayweights[currIndex] = 1.0f;
	rays[currIndex] = primaryRay;
}

__kernel void generateHitDataSSS(__global const CLHitRecord* restrict hitrecs, __global const float4* restrict normals, __global const CLRay* restrict rays,
								 __global CLHitData* restrict hitdata, __global const CLSSSMaterial* restrict sssMats, const int sssMatSize, __global int* restrict hitCount)
{
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);
	const uint sizeX = get_global_size(0);
	const uint sizeY = get_global_size(1);

	const uint currIndex = idY * sizeX + idX;

	const CLHitRecord currHitRec = hitrecs[currIndex];
	const CLRay currRay = rays[currIndex];
	CLHitData currHitData;

	if( currHitRec.triId != INT_MAX )
	{
		const float b0 = 1.0f - currHitRec.b1 - currHitRec.b2;

		float4 n = normalize(normals[3*currHitRec.triId    ] * b0 +
					 		 normals[3*currHitRec.triId + 1] * currHitRec.b1 +
							 normals[3*currHitRec.triId + 2] * currHitRec.b2);

		for (int i=0; i<sssMatSize; i++)
		{
			if (currHitRec.triId >= sssMats[i].meshTriOffset && currHitRec.triId < sssMats[i].meshTriOffset + sssMats[i].meshTriCount)
			{
				currHitData.matId = i;
				break;
			}
		}

		currHitData.hitPosition = currRay.org + currRay.dir * currHitRec.tHit;
	    currHitData.hitNormal = n;
	}
	else
	{
		currHitData.matId = INT_MAX;
		atomic_add(hitCount, 1);
	}

	hitdata[currIndex] = currHitData;
}

__kernel void sampleTriangleMesh( const uint triOffset, const uint sampleOffset, const uint triCount,
                                  __global uint2* restrict randomSeed, __global const float4* restrict points, __global const float4* restrict normals, __global float* restrict triangleWeights,
                                  __global CLRay* restrict samplePoints, __global float* restrict irradiances, __global CLRay* restrict shadowRays, __global const CLLight* restrict light, const uint index)
{
	const uint currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	//generate random numbers
	uint2 randomSeed1 = randomSeed[2*currIndex];
	uint2 randomSeed2 = randomSeed[2*currIndex+1];

	float2 randomNumbers = nextRandom(&randomSeed1, &randomSeed2);
	float2 randomNumbers1 = nextRandom(&randomSeed1, &randomSeed2);

	randomSeed[2*currIndex] = randomSeed1;
	randomSeed[2*currIndex+1] = randomSeed2;

	// triangle ID binary search
	int first = -1;
	int last = triCount;
	int middle = (first + last) / 2;

	while((last-first) > 1 )
	{
		if (triangleWeights[triCount*index + middle] > randomNumbers1.y)
			last = middle;
		else
			first = middle;
		middle = (first + last) / 2;
	}

	// barycentric sampling
	float tmp = sqrt(randomNumbers.x);
	float b1 = 1.0f - tmp;
	float b2 = randomNumbers.y * tmp;
	float b0 = 1.0f - b1 - b2;

	// interpolation, compute triangle area
	CLRay samplePoint;
	float4 PointA = points[3*(triOffset + last) + 0];
	float4 PointB = points[3*(triOffset + last) + 1];
	float4 PointC = points[3*(triOffset + last) + 2];
	samplePoint.org = PointA*b0 +  PointB*b1 +  PointC*b2;
	samplePoint.dir = normalize(normals[3*(triOffset + last)] * b0 + normals[3*(triOffset + last) + 1] * b1 + normals[3*(triOffset + last) + 2] * b2);

	//generate shadow rays
	shadowRays[sampleOffset + currIndex].org = samplePoint.org + samplePoint.dir*0.001f;
	shadowRays[sampleOffset + currIndex].dir = normalize(light[0].pos - samplePoint.org);

	//save sampling points, normals, irradiances
	samplePoint.dir.w = irradiances[triCount*index + last];
	samplePoints[sampleOffset + currIndex] = samplePoint;
}

__kernel void weightsInit(__global float* weights)
{
	const uint currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);
	weights[currIndex] = 1.0f;
}

//__constant float4 LightPos = (float4)(0.0f, 4.0f, 0.0f, 1.0f);

__constant float4 sigma_t = (float4)(7.72000027f, 10.50000000f, 14.89999962f, 0.00000000f);
__constant float4 D = (float4)(0.04317789f, 0.03174603f, 0.02237137f, 0.00000000f);
__constant float4 sigma_tr = (float4)(2.72235203f, 7.31778669f, 14.64786530f, 0.00000000f);
__constant float4 de = (float4)(0.09398048f, 0.07389691f, 0.05790398f, 0.00000000f);
__constant float4 sigma_tm = (float4)(7.72000027f, 10.50000000f, 14.89999962f, 0.00000000f);
__constant float Cp_norm = 1.06509399f;
__constant float Cp = 0.13867617f;
__constant float Ce = 0.35122681f;
__constant float A = 2.33916616f;
__constant float min_sigma_tr = 2.72235203f;
__constant float eta = 1.29999995f;


//Helper
inline float C1( float n) {
	float r;
	if (n > 1.0f) {
		r = -9.23372f + n * (22.2272f + n * (-20.9292f + n * (10.2291f + n * (-2.54396f + 0.254913f * n))));
	} else {
		r = 0.919317f + n * (-3.4793f + n * (6.75335f + n *  (-7.80989f + n *(4.98554f - 1.36881f * n))));
	}
	return r / 2.0f;
}
inline float C2( float n) {
	float r = -1641.1f + n * (1213.67f + n * (-568.556f + n * (164.798f + n * (-27.0181f + 1.91826f * n))));
	r += (((135.926f / n) - 656.175f) / n + 1376.53f) / n;
	return r / 3.0f;
}

inline float fresnel( float cos_theta,  float eta) {
	float sin_theta_t_sqr = 1.0f / (eta * eta) * (1.0f - cos_theta * cos_theta);
	if (sin_theta_t_sqr >= 1.0f)
		return 1.0f;
	float cos_theta_t = sqrt(1.0f - sin_theta_t_sqr);
	float r_s = (cos_theta - eta * cos_theta_t) / (cos_theta + eta * cos_theta_t);
	float r_p = (eta * cos_theta - cos_theta_t) / (eta * cos_theta + cos_theta_t);
	return (r_s * r_s + r_p * r_p) * 0.5f;
}

inline float4 Sp_d(float4 x, float4 w, float4 r, float4 n, float4 D, float4 sigma_tr, float Cp_norm, float Cp, float Ce) {
	//evaluate the profile
	float4 s_tr_r_one = 1.0f + sigma_tr * r;
	float x_dot_w = dot(x,w);

	float4 t0 = Cp_norm * (1.0f / (4.0f * M_PI_F * M_PI_F)) * exp(-sigma_tr * r) / (r * r * r);
	float4 t1 = (r * r) / D + 3.0f * s_tr_r_one * x_dot_w;
	float4 t2 = 3.0f * D * s_tr_r_one * dot(w,n);
	float4 t3 = (s_tr_r_one + 3.0f * D * (3.0f * s_tr_r_one + sigma_tr * r * sigma_tr * r) / r * r * x_dot_w) * dot(x,n);

	return t0 * (Cp * t1 - Ce * (t2 - t3));
}

inline float4 bssrdf(float4 sp, float4 sn, float4 sw, float4 xo, float4 no/*, float4 de, float4 D, float4 sigma_t, float A, float4 sigma_tr, float Cp_norm, float Cp, float Ce, float eta*/)
{
	// distance
	float4 xoxi = xo - sp;
	float r = length(xoxi);

	// modified normal
	float4 ni_s = cross( normalize(xoxi), normalize(cross(sn, xoxi)) );

	// directions of ray sources
	float nnt = 1.0f / eta, ddn = dot(-sw,sn);
	float4 wr = normalize(sw * -nnt - sn * (ddn * nnt + sqrt(max(1.0f - nnt * nnt * (1.0f - ddn * ddn), 0.0f))));
	float4 wv = wr - ni_s * (2.0f * dot(wr,ni_s));

	// distance to real sources
	float4 cos_beta = -sqrt(max((r * r - dot(xoxi,wr) * dot(xoxi,wr)) / (r * r + de * de), 0.0f));
	float mu0 = dot(-no,wr);
	float4 dr = (mu0 > 0.0f) ? sqrt(max((D * mu0) * ((D * mu0) - de * cos_beta * 2.0f) + r * r, 0.0f)) : sqrt(1.0f / (3.0f * sigma_t * 3.0f * sigma_t) + r * r);

	// distance to virtual source
	float4 xoxv = xo - (sp + ni_s * (2.0f * A * de));
	float dv = length(xoxv);

	// BSSRDF
	float4 result = Sp_d(xoxi, wr, dr, no, D, sigma_tr, Cp_norm, Cp, Ce);
	result -= Sp_d(xoxv, wv, dv, no, D, sigma_tr, Cp_norm, Cp, Ce);

	// clamping to zero
	return max (result, 0.0f);
}

//__constant  unsigned int sampleCount = 256;
__kernel void subsurfaceScattering(__global const CLRay* restrict rays, __global const CLHitData* restrict hitdata,  __global const CLRay* restrict samplePoints,
								   __global const CLHitRecord* restrict hitrecs, __global const CLSSSMaterial* restrict sssMats, __global uint2* restrict randomSeed,
								   __global const float* triangleSum, __global float4* restrict accumColor, __global const CLLight* restrict light, const uint lightIndex,
								   __global int* restrict sampleCount)
{
	const uint currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	CLHitData currHitData = hitdata[currIndex];
	int sampleCountLocal = 0;

	if( currHitData.matId != INT_MAX)
	{
		CLRay currRays = rays[currIndex];
		float4 LightPos = light[0].pos;
		uint2 randomSeed1 = randomSeed[2*currIndex];
		uint2 randomSeed2 = randomSeed[2*currIndex+1];

		float4 result = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
		float2 randomNumbers;

		//CLSSSMaterial currSSSMat = sssMats[currHitData.matId];
		//float min_sigma_tr = min(min(currSSSMat.sigma_tr.x, currSSSMat.sigma_tr.y), currSSSMat.sigma_tr.z);
		//float eta = currSSSMat.de.w;
		//currSSSMat.de.w = 0.0f;

		for (int i =0; i<SAMPLE_COUNT; i++)
		{
			randomNumbers = nextRandom(&randomSeed1, &randomSeed2);

			int index = randomNumbers.y * /*currSSSMat.sampleCount*/ 8192;
			float4 sp = samplePoints[/*currSSSMat.sampleOffset*/ + index].org;
			float4 sn = samplePoints[/*currSSSMat.sampleOffset*/ + index].dir;
			float irradiance = sn.w;
			sn.w = 0.0f;

			float4 sw = normalize(LightPos - sp);
			float cos_wi_n = dot(sn,sw);

			if (cos_wi_n > 0.0f )
			{
				float accept_prob = exp( - length(sp - currHitData.hitPosition) * min_sigma_tr );
				float T12 = 1.0f - fresnel(cos_wi_n, eta);
				float T21 = 1.0f - fresnel(max(dot(-currRays.dir, currHitData.hitNormal), 0.1f), eta);
				//if ((randomNumbers.x) < accept_prob)
				{
					float intensity = getIntensity(sp, LightPos) * (int)(hitrecs[/*currSSSMat.sampleOffset +*/ index].triId / INT_MAX) * cos_wi_n;

					float4 Sd = bssrdf(sp, sn, sw, currHitData.hitPosition, currHitData.hitNormal/*, currSSSMat.de, currSSSMat.D, currSSSMat.sigma_t, currSSSMat.A, currSSSMat.sigma_tr, currSSSMat.Cp_norm, currSSSMat.Cp, currSSSMat.Ce, eta*/);
					Sd *= intensity /  (  irradiance * (1.0f / triangleSum[lightIndex]));
					result += T21 * (Sd ) * (4.0f * M_PI_F) * T12;

					sampleCountLocal++;
				}
			}
		}

		accumColor[currIndex] += result / SAMPLE_COUNT;
		randomSeed[2*currIndex]   = randomSeed1;
		randomSeed[2*currIndex+1] = randomSeed2;
		atomic_add(sampleCount, sampleCountLocal);
	}
	else
	{
		accumColor[currIndex] = (float4)(0.0f);
	}
}

__kernel void display(const int offsetX, const int offsetY, const uint iterCount, __global float4* restrict accumColor, __write_only image2d_t output)
{
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);
	const uint sizeX = get_global_size(0);
	const uint sizeY = get_global_size(1);
	const uint currIndex = idY * sizeX + idX;

	//float4 color = clamp(accumColor[currIndex]/iterCount, 0.0f, 1.0f);

	float4 color = accumColor[currIndex]/iterCount;
	float L = dot(color, (float4)(0.2126729f, 0.7151522f, 0.0721750f, 0.0f));
	float T = 1.0f - exp(-2.0f*L);
	color *= T/L;

	//color = powr(accumColor[currIndex]/iterCount, 1.0f/3.0f);
	color = powr(color, 1.0f/2.2f);

	write_imagef(output, (int2)(offsetX+idX, offsetY+idY), color);
}


// buildOptions=-cl-fast-relaxed-math -D SAMPLE_COUNT=256
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D SAMPLE_COUNT=256" %cfg_path --cl-device=%cl_device 2>&1
