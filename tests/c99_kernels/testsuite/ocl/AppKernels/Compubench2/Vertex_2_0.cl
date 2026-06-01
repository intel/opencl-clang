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
__kernel void clearHitRecords(__global CLHitRecord* restrict hitrecs)
{
	const uint currIndex = get_global_id(1) * get_global_size(0) + get_global_id(0);

	hitrecs[currIndex].triId = INT_MAX;
	hitrecs[currIndex].tHit = FLT_MAX;
}

__kernel void generatePrimaryRays(__global const CLCamera* restrict camera, __global float* restrict rayweights, __global CLRay* restrict rays)
{
	// workitem/worksize info
	const uint idX = get_global_id(0);
	const uint idY = get_global_id(1);
	const uint sizeX = get_global_size(0);
	const uint sizeY = get_global_size(1);

	const uint currIndex = idY * sizeX + idX;

	const float4 camDir = (camera->dirTL + camera->dirTR + camera->dirBL + camera->dirBR) * 0.25f;
	const float4 camI = (camera->dirBR - camera->dirBL) / sizeX;
	const float4 camJ = (camera->dirTL - camera->dirBL) / sizeY;

	CLRay primaryRay;
	primaryRay.org = camera->pos;
	primaryRay.dir = camera->dirBL + (idX) * camI + camI*0.5f + (idY) * camJ + camJ*0.5f;
	primaryRay.dir = normalize(primaryRay.dir);

	rayweights[currIndex] = 1.0f;
	rays[currIndex] = primaryRay;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
