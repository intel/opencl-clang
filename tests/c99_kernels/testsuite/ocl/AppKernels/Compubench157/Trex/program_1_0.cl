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
// per vertex skinned
__kernel void skinVertsToWorld(const uint vertexStart, const uint normalStart, const uint skinnedIndex,
							   __global const float4* restrict verts, __global const float4* restrict norms, __global const float4* restrict tangs,
							   __global const float4* restrict bone_weights, __global const uint4* restrict bone_indices, __global const float16* restrict bone_matrices,
							   __global float4* restrict vertsW, __global float4* restrict normsW, __global float4* restrict tangsW)
{
	const int wiId = get_global_id(0);

	const float16 m0 = bone_weights[3*skinnedIndex + wiId].s0 * bone_matrices[ bone_indices[3*skinnedIndex + wiId].s0 ];
	const float16 m1 = bone_weights[3*skinnedIndex + wiId].s1 * bone_matrices[ bone_indices[3*skinnedIndex + wiId].s1 ];
	const float16 m2 = bone_weights[3*skinnedIndex + wiId].s2 * bone_matrices[ bone_indices[3*skinnedIndex + wiId].s2 ];
	const float16 m3 = bone_weights[3*skinnedIndex + wiId].s3 * bone_matrices[ bone_indices[3*skinnedIndex + wiId].s3 ];

	const float16 m = m0 + m1 + m2 + m3;

	float4 _vertsW = verts[3*vertexStart + wiId];
	float4 _normsW = norms[3*vertexStart + wiId];
	float4 _tangsW = tangs[3*vertexStart + wiId];

	_vertsW = MulMat4Vec4(&m, &_vertsW);
	_normsW = MulMat4Vec4(&m, &_normsW);
	_tangsW = MulMat4Vec4(&m, &_tangsW);

	vertsW[3*normalStart + wiId] = _vertsW;
	normsW[3*normalStart + wiId] = _normsW;
	tangsW[3*normalStart + wiId] = _tangsW;
}

// per vertex rigid
__kernel void rigidVertsToWorld(const uint vertexStart, const uint normalStart, const uint rigidIndex,
							   __global const float4* restrict verts, __global const float4* restrict norms, __global const float4* restrict tangs,
							   __global const float16* restrict rigid_matrices,
							   __global float4* restrict vertsW, __global float4* restrict normsW, __global float4* restrict tangsW)
{
	const int wiId = get_global_id(0);

	const float16 m = rigid_matrices[ rigidIndex ];

	float4 _vertsW = verts[3*vertexStart + wiId];
	float4 _normsW = norms[3*vertexStart + wiId];
	float4 _tangsW = tangs[3*vertexStart + wiId];

	_vertsW = MulMat4Vec4(&m, &_vertsW);
	_normsW = MulMat4Vec4(&m, &_normsW);
	_tangsW = MulMat4Vec4(&m, &_tangsW);

	vertsW[3*normalStart + wiId] = _vertsW;
	normsW[3*normalStart + wiId] = _normsW;
	tangsW[3*normalStart + wiId] = _tangsW;
}

// per triangle
__kernel void worldVertsToTris(const uint normalStart, __global const float4* restrict vertsW, __global CLAABB* restrict aabbs, __global float4* restrict morton)
{
	const int wiId = get_global_id(0);

	// load tri data
	const float4 vertexA = vertsW[3*normalStart + 3*wiId  ];
	const float4 vertexB = vertsW[3*normalStart + 3*wiId+1];
	const float4 vertexC = vertsW[3*normalStart + 3*wiId+2];

	// calculate tri aabb
	CLAABB triaabb;

	triaabb.min = min( vertexA, min( vertexB, vertexC ) );
	triaabb.max = max( vertexA, max( vertexB, vertexC ) );

	// calculate tri morton value - tri center
	// const float4 trimortonvalue = (vertexA + vertexB + vertexC) / 3.0f;

	// calculate tri morton value -  aabb center
	const float4 trimortonvalue = ( triaabb.min + triaabb.max ) * 0.5f;

	// save tri data
	aabbs[wiId] = triaabb;
	morton[wiId] = trimortonvalue;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
