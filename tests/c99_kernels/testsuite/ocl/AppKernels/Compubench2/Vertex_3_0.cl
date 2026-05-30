
#define CL_MAXBOUNCES 7
#define CL_EPSILON  0.0001f

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

//VCM Releated

typedef enum
{
    CL_GLASS = 0,
    CL_MATTE = 1,
    CL_MIRROR = 2,
    CL_LIGHTMAT = 3,
    CL_RGLASS = 4,
    CL_GLOSSYMAT = 5,
    CL_METAL = 6
}CLVCMMaterialType;

typedef enum
{
    CL_REFLECTION = (1 << 0),
    CL_TRANSMISSION = (1 << 1),
    CL_DIFFUSE = (1 << 2),
    CL_GLOSSY = (1 << 3),
    CL_SPECULAR = (1 << 4),
    CL_ALL_TYPES = (CL_DIFFUSE | CL_GLOSSY | CL_SPECULAR),
    CL_ALL_REFLECTION = (CL_REFLECTION | CL_ALL_TYPES),
    CL_ALL_TRANSMISSION = (CL_TRANSMISSION | CL_ALL_TYPES),
    CL_ALL = (CL_ALL_REFLECTION | CL_ALL_TRANSMISSION)
}CLBSDFType;

typedef struct
{
    int		kdTexOffset;
    int		kdTexWidth;
    int		kdTexHeight;
}CLMatteParam;

typedef struct
{
    int lightID;
}CLLightMatParam;

typedef struct
{
    int		krTexOffset;
    int		krTexWidth;
    int		krTexHeight;
}CLMirrorParam;

typedef struct
{
    int		krTexOffset;
    int		krTexWidth;
    int		krTexHeight;
    int		ktTexOffset;
    int		ktTexWidth;
    int		ktTexHeight;
    float eta_i;
    float eta_t;
}CLGlassParam;

typedef struct
{
    int		krTexOffset;
    int		krTexWidth;
    int		krTexHeight;
    int		ktTexOffset;
    int		ktTexWidth;
    int		ktTexHeight;
    float eta_i;
    float eta_t;
    float alpha;
}CLRoughGlassParam;

typedef struct
{
    int		ksTexOffset;
    int		ksTexWidth;
    int		ksTexHeight;
    int		kdTexOffset;
    int		kdTexWidth;
    int		kdTexHeight;
    float eta_i;
    float eta_t;
    float alpha;
}CLGlossyParam;

typedef struct
{
    float k_r;
    float k_g;
    float k_b;
    float pad;

    float eta_r;
    float eta_g;
    float eta_b;
    float alpha;
}CLMetalParam;

typedef struct
{
    union
    {
        CLMetalParam metal;
        CLMatteParam matte;
        CLMirrorParam mirror;
        CLGlassParam glass;
        CLRoughGlassParam rglass;
        CLGlossyParam glossy;
        CLLightMatParam light;
    };
    CLVCMMaterialType type;
    int nTexOffset, hasNormalMap,
        nTexWidth, nTexHeight, pad1, pad2;
}CLVCMMaterial;

typedef enum
{
    CL_L_BACKGROUND = 0,
    CL_L_AREA = 1,
    CL_L_DIRECTIONAL = 2,
    CL_L_POINT = 3
}CLLightType;

typedef struct
{
    float4   emission;
    float    invArea;
    int     triStart;
    int     triCount;
    float pad;
} CLAreaLightParam;

typedef struct
{
    float4 emission_radius;
    float4 center;
}CLBacklightParam;

typedef struct
{
    float4 emission_radius;
    float4 center;
    float4 dir;
}CLDirLightParam;

typedef struct
{
    float4 emission;
    float4 pos;
}CLPointLightParam;

typedef struct
{
    float16 l2w;
    float16 w2l;
    union
    {
        CLAreaLightParam area;
        CLBacklightParam back;
        CLDirLightParam directional;
        CLPointLightParam point;
    };
    CLLightType type;
    float p1, p2, p3;
}CLVCMLight;


typedef struct
{
	float4	hitPosition;
	float4	hitNormal;
	float4  geoNormal;
	float2  uv;
    int		matId;					// if nohit - matId = INT_MAX
	float   tHit;
} CLVCMHitData;

typedef struct
{
    float4	hitPosition;
    float4	hitNormal;
	float4   geoNormal;
    float4   invRayDir;
    float4   pathThroughput;
	float2   uv;
    int        fromLight;
    float     dVCM, dVC, dVM;
    int        pathLength;
    int		matId;
} CLVCMPathVertex;

typedef struct
{
    float16  worldToRaster;
    float4   pos;
    float4   forward;
    float4   dirTL, dirTR, dirBL, dirBR;
    float    imgPlaneDist;
    float    lensRadius;
    float    focalDistance;
    float  pad;
}CLVCMCamera;

typedef struct
{
    float4 X, Y, Z;
} CLFrame;

typedef struct
{
    float4 contrib;
    int pixel;
    float dist;

    float2 pad;
} CLVCMConnectionData;

typedef struct
{
	float	minX, minY, minZ, minW;
    float	maxX, maxY, maxZ, maxW;
} CLVCMAABB;

inline float rand_float(uint2* rvec){
	(*rvec).x = 36969 * (((*rvec).x) & 65535) + (((*rvec).x) >> 16);
	(*rvec).y = 18000 * (((*rvec).y) & 65535) + (((*rvec).y) >> 16);
	unsigned int ires = (((*rvec).x) << 16) + ((*rvec).y);
	unsigned int ui = (ires & 0x007fffff) | 0x40000000;
	return (as_float(ui) - 2.0f) / 2.0f;
}

inline uint permute(uint i, uint l, uint p)
{
	uint w = l - 1;
    w |= w >> 1;
	w |= w >> 2;
	w |= w >> 4;
	w |= w >> 8;
	w |= w >> 16;
    do
    {
		i ^= p;
		i *= 0xe170893d;
		i ^= p >> 16;
		i ^= (i & w) >> 4;
		i ^= p >> 8;
		i *= 0x0929eb3f;
		i ^= p >> 23;
		i ^= (i & w) >> 1;
		i *= 1 | p >> 27;
		i *= 0x6935fa69;
		i ^= (i & w) >> 11;
		i *= 0x74dcb303;
		i ^= (i & w) >> 2;
		i *= 0x9e501cc3;
		i ^= (i & w) >> 2;
		i *= 0xc860a3df;
		i &= w;
		i ^= i >> 5;
    } while (i >= l);

    return (i + p) % l;
}

inline float randfloat( uint i, uint p)
{
    i ^= p;
    i ^= i >> 17;
    i ^= i >> 10;
    i *= 0xb36534e5;
    i ^= i >> 12;
    i ^= i >> 21;
    i *= 0x93fc4795;
    i ^= 0xdf6e307f;
    i ^= i >> 17;
    i *= 1 | p >> 18;

    return i * (1.0f / 4294967808.0f);
}

inline float cmj1D(int s, int N, int p)
{
	uint x = permute(s, N, p * 0x68bc21eb);
	float jx = randfloat(s, p * 0x967a889b);
	float invN = 1.0f/N;
	return (x + jx)*invN;
}

inline float2 cmj(int s, const int N, const int p, const float a)
{
    int m = (int)(sqrt((float)N * a));
    int n = (N + m - 1) / m;

    s = permute(s, N, p * 0x51633e2d);
    int sx = permute(s % m, m, p * 0x68bc21eb);
    int sy = permute(s / m, n, p * 0x02e5be93);
    float jx = randfloat(s, p * 0x967a889b);
    float jy = randfloat(s, p * 0x368cc8b7);
    float2 r = (float2)(((float)sx + ((float)sy + jx) / n) / m, ((float)s + jy) / N);

    return r;
}

//****************
//Luxrender ->
//****************

// Implementation of std::upper_bound()
const __global float *std_upper_bound(const __global float *first, const __global float *last, const float val)
 {
	__global float *it;
	uint count = last - first;
	uint step;

	while (count > 0)
    {
		it = first;
		step = count / 2;
		it += step;

		if (!(val < *it))
        {
			first = ++it;
			count -= step + 1;
		}
        else
			count = step;
	}

	return first;
}

float Distribution1D_SampleContinuous(const __global float *distribution1D, const float u,
		float *pdf, uint *off)
{
	const uint count = as_uint(distribution1D[0]);
	const __global float *func = &distribution1D[1];
	const __global float *cdf = &distribution1D[1 + count];

	// Find surrounding CDF segments and _offset_
	if (u <= cdf[0])
	{
		*pdf = func[0];
		if (off)
			*off = 0;
		return 0.0f;
	}
	if (u >= cdf[count])
	{
		*pdf = func[count - 1];
		if (off)
			*off = count - 1;
		return 1.0f;
	}

	const __global float *ptr = std_upper_bound(cdf, cdf + count + 1, u);
	const uint offset = ptr - cdf - 1;

	// Compute offset along CDF segment
	const float du = (u - cdf[offset]) /
			(cdf[offset + 1] - cdf[offset]);

	// Compute PDF for sampled offset
	*pdf = func[offset];

	// Save offset
	if (off)
		*off = offset;

	return (offset + du) / count;
}

int Distribution1D_SampleDiscrete(const __global float *distribution1D, const float u, float *pdf)
{
	const int count = as_uint(distribution1D[0]);
    const float invCount = 1.0f / count;
	const __global float *func = &distribution1D[1];
	const __global float *cdf = &distribution1D[1 + count];

	// Find surrounding CDF segments and _offset_
	if (u <= cdf[0])
    {
		*pdf = func[0] * invCount;
		return 0;
	}
	if (u >= cdf[count])
    {
		*pdf = func[count - 1] * invCount;
		return count - 1;
	}

	const __global float *ptr = std_upper_bound(cdf, cdf + count + 1, u);
	const uint offset = ptr - cdf - 1;

	// Compute PDF for sampled offset
	*pdf = func[offset] * invCount;

	return offset;
}

uint Distribution1D_Offset(const __global float *distribution1D, const float u)
{
	const uint count = as_uint(distribution1D[0]);

	return min(count - 1, (uint)floor(u * count));
}

void Distribution2D_SampleContinuous(const __global float *distribution2D,
		const float u0, const float u1, float2 *uv, float *pdf)
{
	const uint width = as_uint(distribution2D[0]);
	const uint height = as_uint(distribution2D[1]);
	const __global float *marginal = &distribution2D[2];
	// size of Distribution1D: size of counts + size of func + size of cdf
	const uint marginalSize = 1 + height + height + 1;
	// size of Distribution1D: size of counts + size of func + size of cdf
	const uint conditionalSize = 1 + width + width + 1;

	float pdf1;
	uint index;
	(*uv).s1 = Distribution1D_SampleContinuous(marginal, u1, &pdf1, &index);

	float pdf0;
	const __global float *conditional = &distribution2D[2 + marginalSize + index * conditionalSize];
	uint *off = 0;
	(*uv).s0 = Distribution1D_SampleContinuous(conditional, u0, &pdf0, off);

	*pdf = pdf0 * pdf1;
}

float Distribution1D_Pdf_FLOAT(const __global float *distribution1D, const float u)
{
	const uint count = as_uint(distribution1D[0]);
	const __global float *func = &distribution1D[1];

	return func[Distribution1D_Offset(distribution1D, u)];
}

float Distribution2D_Pdf(const __global float *distribution2D, const float2 uv)
 {
	const uint width = as_uint(distribution2D[0]);
	const uint height = as_uint(distribution2D[1]);
	const __global float *marginal = &distribution2D[2];
	// size of Distribution1D: size of counts + size of func + size of cdf
	const uint marginalSize = 1 + height + height + 1;
	// size of Distribution1D: size of counts + size of func + size of cdf
	const uint conditionalSize = 1 + width + width + 1;

	const uint index = Distribution1D_Offset(marginal, uv.y);
	const __global float *conditional = &distribution2D[2 + marginalSize + index * conditionalSize];

	return Distribution1D_Pdf_FLOAT(conditional, uv.x) * Distribution1D_Pdf_FLOAT(marginal, uv.y);
}

//*****************
// <- Luxrender
//*****************


inline void swap(float *a, float *b)
{
    float tmp = *a;
    *a = *b;
    *b = tmp;
}

inline void swap_local(__local float *a, __local float *b)
{
    float tmp = *a;
    *a = *b;
    *b = tmp;
}

inline void swapu(uint *a, uint *b)
{
    uint tmp = *a;
    *a = *b;
    *b = tmp;
}

// Mis power, we use power heuristic
inline float Mis(const float pdf)
{
    return pdf*pdf;
}

inline void uniformSampleTriangle(float u1, float u2, float *u, float *v)
 {
    float su1 = sqrt(u1);
    *u = 1.0f - su1;
    *v = u2 * su1;
}

#define PI_FOUR     0.78539816339744830962f
#define PI_TWO      1.57079632679489661923f
#define INV_PI        0.31830988618379067154f
#define INV_TWOPI 0.15915494309189533577f
#define INV_PI_F         0.31830988618379067154f
#define INV_FOURPI_F 0.07957747154594766788f

inline float4 sphericalDir(float sintheta, float costheta, float phi)
{
    return (float4)(sintheta * cos(phi), sintheta * sin(phi), costheta, 0.0f);
}

inline float2 concentricSampleDisk(float u1, float u2)
{
    float phi, r;
    float a = 2 * u1 - 1;
    float b = 2 * u2 - 1;
    if (a*a > b*b) // use squares instead of absolute values
    {
        r = a;
        phi = PI_FOUR*(b / a);
    }
    else
    {
        r = b;
        phi = PI_TWO - PI_FOUR*(a / b);
    }

    return (float2)(r * cos(phi), r * sin(phi));
}

inline float4 uniformSampleSphere(float u1, float u2)
 {
    float z = 1.0f - 2.0f * u1;
    float r = sqrt(max(0.0f, 1.0f - z*z));
    float phi = 2.0f * M_PI_F * u2;
    float x = r * cos(phi);
    float y = r * sin(phi);

    return (float4)(x, y, z, 0.0f);
}

inline float4 uniformSampleSpherePdf(float u1, float u2, float *pdfW)
 {
    float z = 1.0f - 2.0f * u1;
    float r = sqrt(max(0.0f, 1.0f - z*z));
    float phi = 2.0f * M_PI_F * u2;
    float x = r * cos(phi);
    float y = r * sin(phi);

    *pdfW = INV_FOURPI_F;

    return (float4)(x, y, z, 0.0f);
}

inline float4 uniformSampleHemisphere(float u1, float u2)
{
    float z = u1;
    float r = sqrt(max(0.0f, 1.0f - z*z));
    float phi = 2 * M_PI_F * u2;
    float x = r * cos(phi);
    float y = r * sin(phi);

    return (float4)(x, y, z, 0.0f);
}

inline float4 uniformSampleHemispherePdf(float u1, float u2, float *pdfW)
{
    float z = u1;
    float r = sqrt(max(0.0f, 1.0f - z*z));
    float phi = 2 * M_PI_F * u2;
    float x = r * cos(phi);
    float y = r * sin(phi);

    *pdfW = INV_TWOPI;

    return (float4)(x, y, z, 0.0f);
}

inline float4 cosineSampleHemisphere(const float u1, const float u2)
{
    float4 ret;
    ret.xy = concentricSampleDisk(u1, u2);
    ret.z = sqrt(max(0.0f, 1.0f - ret.x * ret.x - ret.y * ret.y));
    ret.w = 0.0f;

    return ret;
}

inline float4 cosineSampleHemispherePdf(const float u1, const float u2, float *pdfW)
{
    float4 ret;
    ret.xy = concentricSampleDisk(u1, u2);
    ret.z = sqrt(max(0.0f, 1.0f - ret.x * ret.x - ret.y * ret.y));
    ret.w = 0.0f;

    *pdfW = fabs(ret.z * INV_PI);

    return ret;
}

inline void coordinateSystem(const float4 v1, float4 *v2, float4 *v3)
{
    if (fabs(v1.x) > fabs(v1.y))
    {
        float invLen = 1.f / sqrt(v1.x * v1.x + v1.z * v1.z);
        (*v2).x = -v1.z * invLen;
        (*v2).y = 0.f;
        (*v2).z = v1.x * invLen;
        (*v2).w = 0.0f;
    }
    else
    {
        float invLen = 1.f / sqrt(v1.y * v1.y + v1.z * v1.z);
        (*v2).x = 0.f;
        (*v2).y = v1.z * invLen;
        (*v2).z = -v1.y * invLen;
        (*v2).w = 0.0f;
    }

    *v3 = cross(v1, *v2);
}

void setFromZ(CLFrame *frame, const float4 z)
{
    frame->Z = z;
    coordinateSystem(frame->Z, &frame->X, &frame->Y);
}

float4 toWorld(const CLFrame frame, const float4 a)
{
    return frame.X * a.x + frame.Y * a.y + frame.Z * a.z;
}

float4 toLocal(const CLFrame frame, const float4 a)
{
    return (float4)(dot(a, frame.X), dot(a, frame.Y), dot(a, frame.Z), 0);
}

inline float4 getHeatMapColor(float value, float maxVal)
{
	const int NUM_COLORS = 4;
	float color[4][3] = { { 0, 0, 1 }, { 0, 1, 0 }, { 1, 1, 0 }, { 1, 0, 0 } };
	// A static array of 4 colors:  (blue,   green,  yellow,  red) using {r,g,b} for each.

	int idx1;        // |-- Our desired color will be between these two indexes in "color".
	int idx2;        // |
	float fractBetween = 0;  // Fraction between "idx1" and "idx2" where our value is.

	if (value <= 0)      { idx1 = idx2 = 0; }    // accounts for an input <=0
	else if (value >= maxVal)  { idx1 = idx2 = NUM_COLORS - 1; }    // accounts for an input >=0
	else
	{
		value = value/maxVal * (NUM_COLORS - 1);        // Will multiply value by 3.
		idx1 = floor(value);                  // Our desired color will be after this index.
		idx2 = idx1 + 1;                        // ... and before this index (inclusive).
		fractBetween = value - (float)(idx1);    // Distance between the two indexes (0-1).
	}

	float4 rgb;
	rgb.x = (color[idx2][0] - color[idx1][0])*fractBetween + color[idx1][0];
	rgb.y = (color[idx2][1] - color[idx1][1])*fractBetween + color[idx1][1];
	rgb.z = (color[idx2][2] - color[idx1][2])*fractBetween + color[idx1][2];
	rgb.w = 1.0f;

	return rgb;
}

inline float Y(const float4 L)
{
	return 0.2126f*L.x + 0.7152f*L.y + 0.0722f*L.z;
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

//Function to perform the atomic max
 inline void AtomicMax(volatile __global float *source, const float operand)
 {
    union
	{
        unsigned int intVal;
        float floatVal;
    } newVal;

    union
	{
        unsigned int intVal;
        float floatVal;
    } prevVal;

    do
	{
        prevVal.floatVal = *source;
        newVal.floatVal = max(prevVal.floatVal,operand);
    }
	while (atomic_cmpxchg((volatile __global unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

 inline void AtomicMaxLocal(volatile __local float *source, const float operand)
 {
    union
	{
        unsigned int intVal;
        float floatVal;
    } newVal;

    union
	{
        unsigned int intVal;
        float floatVal;
    } prevVal;

    do
	{
        prevVal.floatVal = *source;
        newVal.floatVal = max(prevVal.floatVal,operand);
    }
	while (atomic_cmpxchg((volatile __local unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

 inline void AtomicMin(volatile __global float *source, const float operand)
 {
    union
	{
        unsigned int intVal;
        float floatVal;
    } newVal;

    union
	{
        unsigned int intVal;
        float floatVal;
    } prevVal;

    do
	{
        prevVal.floatVal = *source;
        newVal.floatVal = min(prevVal.floatVal,operand);
    }
	while (atomic_cmpxchg((volatile __global unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
}

 inline void AtomicMinLocal(volatile __local float *source, const float operand)
 {
    union
	{
        unsigned int intVal;
        float floatVal;
    } newVal;

    union
	{
        unsigned int intVal;
        float floatVal;
    } prevVal;

    do
	{
        prevVal.floatVal = *source;
        newVal.floatVal = min(prevVal.floatVal,operand);
    }
	while (atomic_cmpxchg((volatile __local unsigned int *)source, prevVal.intVal, newVal.intVal) != prevVal.intVal);
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
	float2 _UV = max(fract(UV, &fractDummy) * iTexSize.y - 1.0f,(float2)(0,0));
	uint2 uv_int = convert_uint2(clamp(floor(_UV), 0.0f, iTexSize.y-1.0f));
	float2 uv_ratio = _UV - (float2)(uv_int.x, uv_int.y);
	float2 uv_opposite = 1.0f - uv_ratio;

	const float scale = 1.0f / 255.0f;
	const float4 t00 = convert_float4(texture[uv_int.x * iTexSize.y + uv_int.y]) * scale;
	const float4 t01 = convert_float4(texture[uv_int.x * iTexSize.y + uv_int.y + 1]) * scale;
	const float4 t10 = convert_float4(texture[(uv_int.x + 1) * iTexSize.y + uv_int.y]) * scale;
	const float4 t11 = convert_float4(texture[(uv_int.x + 1) * iTexSize.y + uv_int.y + 1]) * scale;

	return (t00*uv_opposite.x + t10*uv_ratio.x)*uv_opposite.y  + (t01*uv_opposite.x + t11*uv_ratio.x)*uv_ratio.y;
}

float4 textureBilinearLookup2(__global const float4* restrict texture, int2 iTexSize, const float2 UV)
{
	float u = UV.x, v = UV.y;
	u = u * (iTexSize.x-1) - 0.5f;
    v = v * (iTexSize.y-1) - 0.5f;
    int x = floor(u);
    int y = floor(v);
    float u_ratio = u - x;
    float v_ratio = v - y;
    float u_opposite = 1.0f - u_ratio;
    float v_opposite = 1.0f - v_ratio;
    const int size = iTexSize.x * iTexSize.y - 1;
    float4 result =
    (texture[clamp(x + y*iTexSize.x,0,size)]   * u_opposite  +
     texture[clamp(x+1 + y*iTexSize.x,0,size)]   * u_ratio) * v_opposite +
    (texture[clamp(x + (y+1)*iTexSize.x,0,size)] * u_opposite  +
     texture[clamp(x+1 + (y+1)*iTexSize.x,0,size)] * u_ratio) * v_ratio;
    /*float Yr = 0.2126f*result.x + 0.7152f*result.y + 0.0722f*result.z;
    if(Yr < 0.0f || isnan(Yr) || isinf(Yr))
     	result = 0;*/
    return result;
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


#line 3 "rt_light.cl"

inline bool isFiniteLight(const CLLightType type)
{
    switch(type)
    {
        case CL_L_BACKGROUND: return false;
        case CL_L_AREA: return true;
        case CL_L_DIRECTIONAL : return false;
        case CL_L_POINT : return true;
        default: return false;
    }
}

inline bool isDeltaLight(const CLLightType type)
{
    switch(type)
    {
        case CL_L_BACKGROUND: return false;
        case CL_L_AREA: return false;
        case CL_L_DIRECTIONAL : return true;
        case CL_L_POINT : return true;
        default: return false;
    }
}

inline float4 GetRadiance_AreaLight(__global const CLVCMLight* light, __global const CLVCMPathVertex* pathVertex)
{
    float costIn = dot(pathVertex->invRayDir,pathVertex->hitNormal);

    if(costIn > 0.0f)
    {
        if(pathVertex->pathLength == 2)
            return light->area.emission;

        const float directPdfA = light->area.invArea;
        const float emissionPdfW = costIn * INV_PI * directPdfA;

        const float wCam = Mis(directPdfA) * pathVertex->dVCM + Mis(emissionPdfW) * pathVertex->dVC;
        const float misWeight = 1.0f / (1.0f + wCam);
        return light->area.emission * pathVertex->pathThroughput * misWeight;
    }

    return 0.0f;
}

inline float SphericalTheta(const float4 v)
{
    return acos(clamp(v.y, -1.f, 1.f));
}


inline float SphericalPhi(const float4 v)
{
    float p = atan2(v.z, v.x);
    return (p < 0.f) ? p + 2.0f*M_PI_F : p;
}

inline float4 GetRadiance_BackLight(__global const CLVCMLight* light, __global const CLVCMPathVertex* pathVertex,
                                    __global const float* restrict distribution2D,
                                    __global const float4* restrict envMap, const float4 dir)
{
    float4 ldir = dir;
    {const float16 w2l = light->w2l;
     ldir = normalize(MulMat4Vec4(&w2l,&ldir));}
    const float2 uv = (float2)(SphericalPhi(ldir) * INV_TWOPI, SphericalTheta(ldir) * INV_PI_F);
    int2 envMapSize = (int2)(as_int(envMap[0].w),as_int(envMap[1].w));
    if(pathVertex->pathLength == 1)
        return textureBilinearLookup2(envMap, envMapSize ,uv);

    const float distrPdf = Distribution2D_Pdf(distribution2D, uv);

    const float directPdfA = distrPdf * INV_FOURPI_F;
    const float4 emission = light->back.emission_radius;
    const float radius = emission.w;
    const float emissionPdfW = distrPdf / (4.0f * M_PI_F*M_PI_F * radius*radius);

    const float wCam = Mis(directPdfA) * pathVertex->dVCM + Mis(emissionPdfW) * pathVertex->dVC;
    const float misWeight = 1.0f / (1.0f + wCam);
    return textureBilinearLookup2(envMap, envMapSize ,uv) * pathVertex->pathThroughput * misWeight;
}


inline float4 Emit_AreaLight(const __global CLVCMLight *light, __global const float4* points, uint2 *seed, CLRay *ray, float *emissionPdfW, float *directPdfA, float *cosLight)
{
    float4 n, p, localDirOut;
    {
        int triOffset = (int)(light->area.triCount*rand_float(seed))*3 + light->area.triStart;

        // We sample lights uniformly
        float4 lightSamples = (float4)(rand_float(seed),rand_float(seed),rand_float(seed),rand_float(seed));
        //Sample4D((uint)currIndex,asd,&lightSamples);

        float b1, b2;
        uniformSampleTriangle(lightSamples.x, lightSamples.y, &b1, &b2);
        // Get triangle vertices in _p1_, _p2_, and _p3_
        const float4 p1 = points[triOffset + 0];
        const float4 p2 = points[triOffset + 1];
        const float4 p3 = points[triOffset + 2];
        p = b1 * p1 + b2 * p2 + (1.0f - b1 - b2) * p3;
        n = cross(p2-p1,p3-p1);
        float invTriArea = 2.0f / length(n);
        n = normalize(n);
        *directPdfA = invTriArea;

        localDirOut = cosineSampleHemispherePdf(lightSamples.z, lightSamples.w, emissionPdfW);

        // Cannot really not emit the particle, so just bias it to the correct angle
        *emissionPdfW = max(*emissionPdfW, CL_EPSILON);
        *emissionPdfW *= invTriArea;
        *cosLight = localDirOut.z;

    }
    {
        CLFrame frame;
        setFromZ(&frame,n);
        ray->dir = toWorld(frame, localDirOut);

        ray->org = p;
        ray->org += ray->dir * CL_EPSILON * 10;
        ray->org.w = 1.0f;
    }

    return light->area.emission * (*cosLight );
}

inline float4 Emit_BackLight(const __global CLVCMLight *light,
                            __global const float *distribution2D, __global const float4* restrict envMap,
                            const int sample, const int N, uint2 *seed, CLRay *ray, float *emissionPdfW, float *directPdfA, float *cosLight)
{
    float2 uv;
    float distrPdf = 1.0f;
    //uv.x = rand_float(seed); uv.y = rand_float(seed);
	int2 envMapSize = (int2)(as_int(envMap[0].w),as_int(envMap[1].w));
	float2 s = cmj(sample, envMapSize.x*envMapSize.y, as_int(rand_float(seed)), (float)envMapSize.x/envMapSize.y);
    Distribution2D_SampleContinuous(distribution2D,s.x,s.y,&uv,&distrPdf);

    const float phi = uv.x * 2.0f * M_PI_F;
    const float theta = uv.y * M_PI_F;
    const float costheta = cos(theta), sintheta = sin(theta);
    const float sinphi = sin(phi), cosphi = cos(phi);

   {const float16 l2w = light->l2w;
    float4 dir = -(float4)(sintheta * cosphi, costheta, sintheta * sinphi, 0.0f);
    dir = normalize(MulMat4Vec4(&l2w,&dir));
    ray->dir = dir;}

    const float radius = light->back.emission_radius.w;
    const float4 center = light->back.center;

	s = cmj(sample, envMapSize.x*envMapSize.y, as_int(rand_float(seed)), (float)envMapSize.x/envMapSize.y);
    const float4 point = center + radius * uniformSampleSphere(s.x,s.y);

    const float4 toCenter = center - point;
    const float centerDistance = dot(toCenter, toCenter);
    const float approach = dot(toCenter, -ray->dir);
    const float distance = approach + sqrt(max(0.f, radius * radius -
        centerDistance + approach * approach));

    ray->org = (point + (distance) * -ray->dir);
    const float4 emisNormal = (normalize(center - ray->org));

    *cosLight = dot(emisNormal,ray->dir);
    *emissionPdfW = distrPdf / (4.0f * M_PI_F*M_PI_F * radius*radius);
    *directPdfA = distrPdf / (4.0f * M_PI_F);

    return textureBilinearLookup2(envMap, envMapSize, uv);
}

inline float4 Emit_DirLight(const __global CLVCMLight *light, const int sample, const int N, uint2 *seed, CLRay *ray, float *emissionPdfW, float *directPdfA, float *cosLight)
{
    float2 xy = cmj(sample, N, as_int(rand_float(seed)), 1280.0f/720.0f);
    xy = concentricSampleDisk(xy.x,xy.y);
    CLFrame frame;
    setFromZ(&frame, light->directional.dir);

    ray->dir = frame.Z;
    const float4 emission = light->directional.emission_radius;
    const float radius = emission.w;
    ray->org = light->directional.center + radius * (frame.X * xy.x + frame.Y * xy.y - frame.Z);

    *emissionPdfW = INV_PI_F / (radius*radius);
    *directPdfA = 1.0f;
    *cosLight = 1.0f;

    return emission;
}

inline float4 Emit_PointLight(const __global CLVCMLight *light, const int sample, const int N, uint2 *seed, CLRay *ray, float *emissionPdfW, float *directPdfA, float *cosLight)
{
    ray->org = light->point.pos;
    float2 uv = cmj(sample, N, as_int(rand_float(seed)), 1280.0f/720.0f);
    ray->dir = uniformSampleSpherePdf(uv.x,uv.y,emissionPdfW);

    *directPdfA = 1.0f;
    *cosLight = 1.0f;

    return  light->point.emission;
}

inline float4 Emit(const __global CLVCMLight *light, const CLLightType type, __global const float4* points,
                 const int sample, const int N, uint2 *seed, CLRay *ray,
                 __global const float *distribution2D, __global const float4* restrict envMap,
                 float *emissionPdfW, float *directPdfA, float *cosLight)
{
    float4 R = 0.0f;
    *emissionPdfW = 0;
    *directPdfA = 0;
    switch(type)
    {
        case CL_L_BACKGROUND:
        {
            R = Emit_BackLight(light, distribution2D, envMap, sample, N, seed, ray, emissionPdfW, directPdfA, cosLight);
            break;
        }
        case CL_L_AREA:
        {
            R = Emit_AreaLight(light, points, seed, ray, emissionPdfW, directPdfA, cosLight);
            break;
        }
        case CL_L_DIRECTIONAL :
        {
            R = Emit_DirLight(light, sample, N, seed, ray, emissionPdfW, directPdfA, cosLight);
            break;
        }
        case CL_L_POINT :
        {
            R = Emit_PointLight(light, sample, N, seed, ray, emissionPdfW, directPdfA, cosLight);
            break;
        }
        default: break;
    }

    return R;
}



inline float4 Illuminate_AreaLight(const __global CLVCMLight *light, __global const float4* points, uint2 *seed, const float4 point, float4 *direction, float *distance, float *emissionPdfW, float *directPdfW, float *cosLight)
{
    const int triOffset = (int)(light->area.triCount*rand_float(seed))*3 + light->area.triStart;

    float b1, b2;
    const float2 lightSamples = (float2)(rand_float(seed),rand_float(seed));
    //Sample2D((uint)currIndex,asd,&lightSamples);
    uniformSampleTriangle(lightSamples.x,lightSamples.y, &b1, &b2);
    // Get triangle vertices in _p1_, _p2_, and _p3_
    const float4 p1 = points[triOffset + 0];
    const float4 p2 = points[triOffset + 1];
    const float4 p3 = points[triOffset + 2];
    const float4 p = b1 * p1 + b2 * p2 + (1.0f - b1 - b2) * p3;
    float4 n = cross(p2-p1,p3-p1);
    const float invTriArea = 2.0f / length(n);
    n = normalize(n);

    *direction = p - point;
    float dist2 = dot(*direction,*direction);
    *distance = sqrt(dist2);
    *direction /= *distance;
    *cosLight = dot(-(*direction), n);

    *directPdfW = invTriArea * dist2 / (*cosLight);
    *emissionPdfW = invTriArea * (*cosLight) * INV_PI;

    return light->area.emission;
}

inline float4 Illuminate_BackLight(const __global CLVCMLight *light, __global const float *distribution2D, __global const float4* restrict envMap,
                                   const int sample, const int N, uint2 *seed, const float4 point, float4 *direction, float *distance,
                                   float *emissionPdfW, float *directPdfW, float *cosLight)
{
    float2 uv;
    float distrPdf;
	int2 envMapSize = (int2)(as_int(envMap[0].w),as_int(envMap[1].w));
	float2 s = cmj(sample, envMapSize.x*envMapSize.y, as_int(rand_float(seed)), (float)envMapSize.x/envMapSize.y);
    Distribution2D_SampleContinuous(distribution2D,s.x,s.y,&uv,&distrPdf);
    const float phi = uv.x * 2.0f * M_PI_F;
    const float theta = uv.y * M_PI_F;
    const float costheta = cos(theta), sintheta = sin(theta);
    const float sinphi = sin(phi), cosphi = cos(phi);
    {const float16 l2w = light->l2w;
    float4 dir = (float4)(sintheta * cosphi, costheta, sintheta * sinphi, 0.0f);
    dir = normalize(MulMat4Vec4(&l2w,&dir));
    *direction = dir;}

    const float radius = light->back.emission_radius.w;
    const float4 center = light->back.center;

    const float4 toCenter = center - point;
    const float centerDistance = dot(toCenter, toCenter);
    const float approach = dot(toCenter, *direction);
    *distance = approach + sqrt(max(0.f, radius * radius -
        centerDistance + approach * approach));

    const float4 ePoint = (point + (*distance) * (*direction));
    const float4 eNormal = (normalize(center - ePoint));

    *cosLight = dot(eNormal,-*direction);

    *directPdfW = distrPdf * INV_FOURPI_F;
    *emissionPdfW = distrPdf / (4.0f * M_PI_F*M_PI_F * radius*radius);

    return textureBilinearLookup2(envMap, envMapSize, uv);
}

inline float4 Illuminate_DirLight(const __global CLVCMLight *light, uint2 *seed, const float4 point, float4 *direction, float *distance, float *emissionPdfW, float *directPdfW, float *cosLight)
{
    *direction = -light->directional.dir;
    *distance = FLT_MAX;
    const float4 emission = light->directional.emission_radius;
    const float radius = emission.w;
    *emissionPdfW = INV_PI_F / (radius*radius);
    *directPdfW = 1.0f;
    *cosLight = 1.0f;

    return emission;
}

inline float4 Illuminate_PointLight(const __global CLVCMLight *light, uint2 *seed, const float4 point, float4 *direction, float *distance, float *emissionPdfW, float *directPdfW, float *cosLight)
{
    *direction = light->point.pos - point;
    const float dist2 = dot(*direction,*direction);
    *directPdfW = dist2;
    *distance = sqrt(dist2);
    *direction /= *distance;

    *emissionPdfW = INV_FOURPI_F;
    *cosLight = 1.0f;

    return light->point.emission;
}

inline float4 Illuminate(const __global CLVCMLight *light, const CLLightType type, __global const float4* points,
                         const int sample, const int N, uint2 *seed, const float4 p, float4 *direction, float *distance,
                         __global const float *distribution2D, __global const float4* restrict envMap,
                         float *emissionPdfW, float *directPdfW, float *cosLight)
{
    float4 R = 0.0f;
    *emissionPdfW = 0;
    *directPdfW = 0;
    switch(type)
    {
        case CL_L_BACKGROUND:
        {
            R = Illuminate_BackLight(light, distribution2D, envMap, sample, N, seed, p, direction, distance, emissionPdfW, directPdfW, cosLight);
            break;
        }
        case CL_L_AREA:
        {
            R = Illuminate_AreaLight(light, points, seed, p, direction, distance, emissionPdfW, directPdfW, cosLight);
            break;
        }

        case CL_L_DIRECTIONAL :
        {
            R = Illuminate_DirLight(light, seed, p, direction, distance, emissionPdfW, directPdfW, cosLight);
            break;
        }
        case CL_L_POINT :
        {
            R = Illuminate_PointLight(light, seed, p, direction, distance, emissionPdfW, directPdfW, cosLight);
            break;
        }
        default: break;
    }

    return R;
}


#line 3 "rt_reflection.cl"

inline float fresnelDielectric(const float ni, const float nt, const float cosi, const float cost)
{
    float rPa;
    rPa = (nt*cosi - ni*cost) / (nt*cosi + ni*cost);

    float rPer;
    rPer = (ni*cosi - nt*cost) / (ni*cosi + nt*cost);

    return (rPa*rPa + rPer*rPer)*0.5f;
}

inline float evalFresnelDielectric(float cosi, float *eta_i, float *eta_t)
{
    // Compute Fresnel reflectance for dielectric
    cosi = clamp(cosi, -1.0f, 1.0f);

    // Compute indices of refraction for dielectric
    bool entering = cosi > 0.0f;
    if (!entering)
        swap(eta_i, eta_t);

    // Compute _sint_ using Snell's law
    const float eta = *eta_i / *eta_t;
    float sint2 = eta * eta * max(0.0f, 1.0f - cosi*cosi);
    if (sint2 >= 1.0f)
    {
        // Handle total internal reflection
        return 1.0f;
    }
    else
    {
        float cost = sqrt(max(0.f, 1.0f - sint2));
        return fresnelDielectric(fabs(cosi), cost, *eta_i, *eta_t);
    }
}

inline float evalFresnelDielectric_local(float cosi, __local float *eta_i, __local float *eta_t)
{
    // Compute Fresnel reflectance for dielectric
    cosi = clamp(cosi, -1.0f, 1.0f);

    // Compute indices of refraction for dielectric
    bool entering = cosi > 0.0f;
    if (!entering)
        swap_local(eta_i, eta_t);

    // Compute _sint_ using Snell's law
    const float eta = *eta_i / *eta_t;
    float sint2 = eta * eta * max(0.0f, 1.0f - cosi*cosi);
    if (sint2 >= 1.0f)
    {
        // Handle total internal reflection
        return 1.0f;
    }
    else
    {
        float cost = sqrt(max(0.f, 1.0f - sint2));
        return fresnelDielectric(fabs(cosi), cost, *eta_i, *eta_t);
    }
}

inline float4 evalFresnelConductor(float cosi, const  float4 eta, const float4 k)
{
    float4 tmp = (eta*eta + k*k) * cosi*cosi;
    float4 Rparl2 = (tmp - (2.0f * eta * cosi) + 1.0f) /
        (tmp + (2.0f * eta * cosi) + 1.0f);
    float4 tmp_f = eta*eta + k*k;
    float4 Rperp2 =
        (tmp_f - (2.0f * eta * cosi) + cosi*cosi) /
        (tmp_f + (2.0f * eta * cosi) + cosi*cosi);
    return (Rparl2 + Rperp2) * 0.5f;
}

inline float SampleDiffuse(const bool fromLight,
                            const float u1, const float u2,
                            const float4 localInvRayDir, float4 *localSampledDir,
                            float *directPdfW, float *reversePdfW)
{
    *localSampledDir = sign(localInvRayDir.z)*cosineSampleHemispherePdf(u1, u2, directPdfW);

    if (reversePdfW)
        *reversePdfW = (localInvRayDir.z * INV_PI);


    if(fromLight) return fabs(localInvRayDir.z/(*localSampledDir).z);
    else return 1.0f;
    //return INV_PI;
}

inline float EvaluateDiffuse(const bool fromLight,
                             const __global CLVCMPathVertex *pathVertex,
                             const float4 ns,
                             const float4 eyeDir, const float4 lightDir,
                             float *directPdfW, float *reversePdfW)
{
    const float absCosENS = fabs(dot(ns,eyeDir));
    const float absCosLNS = fabs(dot(ns,lightDir));
    if (directPdfW)
        *directPdfW = (fromLight ? absCosENS : absCosLNS)*INV_PI;

    if (reversePdfW)
        *reversePdfW = (fromLight ? absCosLNS : absCosENS)*INV_PI;

    return INV_PI;
}

inline float EvaluateDiffuseLocal(const bool fromLight,
                                  const __global CLVCMPathVertex *pathVertex,
                                  const float4 localEyeDir, const float4 localLightDir,
                                  float *directPdfW, float *reversePdfW)
{
    if (directPdfW)
        *directPdfW = fabs(fromLight ? localEyeDir.z : localLightDir.z)*INV_PI;

    if (reversePdfW)
        *reversePdfW = fabs(fromLight ? localLightDir.z : localEyeDir.z)*INV_PI;

    return INV_PI;
}


inline void SampleSpecularReflection(const float4 localInvRayDir, float4 *localSampledDir,
                                                             float *directPdfW, float *reversePdfW)
{
    *localSampledDir = (float4)(-localInvRayDir.x, -localInvRayDir.y, localInvRayDir.z, 0.0f);
    if (directPdfW)
        *directPdfW = 1.0f;
    if (reversePdfW)
        *reversePdfW = 1.0f;
}

inline float SampleSpecularTransmission(const bool fromLight, const float eta,
    const float4 localInvRayDir, float4 *localSampledDir,
    float *directPdfW, float *reversePdfW)
{
    const bool entering = localInvRayDir.z > 0.0f;
    // Compute transmitted ray direction
    const float sint2 = eta * eta * max(0.0f, 1.0f - localInvRayDir.z*localInvRayDir.z);

    // Handle total internal reflection for transmission
    if (sint2 >= 1.0f) return 0.0f;
    float cost = sqrt(max(0.0f, 1.0f - sint2));
    if (entering) cost = -cost;
    float sintOverSini = eta;
    *localSampledDir = (float4)(sintOverSini * -localInvRayDir.x, sintOverSini * -localInvRayDir.y, cost, 0);
    if (directPdfW)
        *directPdfW = 1.0f;
    if (reversePdfW)
        *reversePdfW = 1.0f;

    if(!fromLight)
        return 1.0f / (eta*eta);
    else
        return fabs(localInvRayDir.z/(*localSampledDir).z);

    //return 1.0f;
}

inline void SampleGGXH(const float u1, const float u2, const float roughness, float4 *halfVector, float *D)
{
    const float tanTH = sqrt(roughness*u1) / sqrt(1.0f-u1);
    const float thetaH = atan(tanTH);
    const float phiH = 2 * M_PI_F * u2;

    const float cosTH = cos(thetaH);
    const float cosTH4 = cosTH*cosTH*cosTH*cosTH;
    const float d = (roughness + tanTH*tanTH);

    *D = roughness * INV_PI / (cosTH4*d*d);
    *halfVector = (float4)(sin(thetaH) * cos(phiH), sin(thetaH) * sin(phiH), cosTH, 0.0f);
}

inline float GGX_D(const float cosTH, const float roughness)
{
    const float cosTH4 = cosTH*cosTH*cosTH*cosTH;
    const float sinTH = sqrt(1.0f - cosTH*cosTH);
    const float tanTH = sinTH / cosTH;
    const float d = (roughness + tanTH*tanTH);
    return roughness * INV_PI / (cosTH4*d*d);
}

inline float GGX_G1(const float cosTH, const float roughness)
{
    const float sinTH = sqrt(1.0f - cosTH*cosTH);
    const float tanTH = sinTH / cosTH;

    return 2.0f / (1.0f + sqrt(1.0f + roughness*tanTH*tanTH));
}

inline float GGX_G(const float4 localSampledDir, const float4 localInvRayDir, const float roughness)
{
    return GGX_G1(fabs(localSampledDir.z),roughness)*GGX_G1(fabs(localInvRayDir.z),roughness);
}

inline float4 EvaluateMicrofacetReflection2(const bool fromLight,
                                            const float roughness,
                                            const __global CLVCMPathVertex *pathVertex,
                                            const float4 localEyeDir, const float4 localLightDir,
                                            float *cosTEH, float *directPdfW, float *reversePdfW)
{
    const float cosTE = fabs(localEyeDir.z);
    const float cosTL = fabs(localLightDir.z);

    if(cosTE < CL_EPSILON || cosTL < CL_EPSILON)
        return 0.0f;

    float4 halfVector = localEyeDir + localLightDir;
    if(dot(halfVector,halfVector) < CL_EPSILON)
        return 0.0f;
    halfVector = normalize(halfVector);
    if(halfVector.z < 0.0f)
        halfVector = -halfVector;

    *cosTEH = dot(localEyeDir,halfVector);
    const float D = GGX_D(halfVector.z,roughness);
    const float G = GGX_G(localEyeDir,localLightDir,roughness);

    if(directPdfW)
        *directPdfW = D*fabs(halfVector.z) / (4.0f * fabs(dot(halfVector,localLightDir)));
    if(reversePdfW)
        *reversePdfW = D*fabs(halfVector.z) / (4.0f * fabs(dot(halfVector,localLightDir)));

    return D * G / (4.0f * cosTE * cosTL);
}

inline float4 SampleMicrofacetReflection2(const bool fromLight,
                                          const float u1, const float u2,
                                          const float roughness,
                                          const float4 localInvRayDir, float4 *localSampledDir,
                                          float *cosTRH, float *directPdfW, float *reversePdfW)
{
    float4 halfVector;
    float D;
    SampleGGXH(u1,u2,roughness,&halfVector,&D);

    if(halfVector.z < 0.0f)
        halfVector = -halfVector;
    *cosTRH = dot(halfVector, localInvRayDir);
    const float cosTR = fabs(localInvRayDir.z);

    if(directPdfW)
        *directPdfW = D*fabs(halfVector.z) / (4.0f * fabs(*cosTRH));
    if(reversePdfW)
        *reversePdfW = D*fabs(halfVector.z) / (4.0f * fabs(*cosTRH));

    *localSampledDir = 2.0f * (*cosTRH) * halfVector - localInvRayDir;
    const float cosTF = fabs((*localSampledDir).z);

    if(cosTF < CL_EPSILON || (*localSampledDir).z * localInvRayDir.z < 0.0f)
        return 0.0f;

    const float G = GGX_G(*localSampledDir, localInvRayDir, roughness);

    float4 R =  D * G / (4.0f * cosTR /* cosTF*/);
    if(fromLight) R *= fabs(localInvRayDir.z/(*localSampledDir).z);

    return R;
}

inline float4 EvaluateMicrofacetRefraction2(const bool fromLight,
                                            const float roughness,
                                            const float eta,
                                            const __global CLVCMPathVertex *pathVertex,
                                            const float4 localEyeDir, const float4 localLightDir,
                                            float *cosTLH, float *directPdfW, float *reversePdfW)
{
    float4 halfVector = localEyeDir + localLightDir*eta;
    const float lengthSq = dot(halfVector,halfVector);
    if(lengthSq < CL_EPSILON)
        return 0.0f;
    halfVector /= sqrt(lengthSq);
    if(halfVector.z < 0.0f)
        halfVector = -halfVector;

    const float cosTE = fabs(localEyeDir.z);
    const float cosTEH = fabs(dot(localEyeDir,halfVector));
    *cosTLH = dot(localLightDir,halfVector);

    const float D = GGX_D(halfVector.z, roughness);
    const float G = GGX_G(localEyeDir,localLightDir,roughness);

    if(directPdfW)
        *directPdfW =  D * fabs(halfVector.z) * (fromLight ? cosTEH : eta * eta * (*cosTLH)) / lengthSq;
    if(reversePdfW)
        *reversePdfW = D * fabs(halfVector.z) * (fromLight ? eta * eta * (*cosTLH) : cosTEH) / lengthSq;

    float4 R = fabs(*cosTLH)*cosTEH / (cosTE*fabs(localLightDir.z));

    R *= eta*eta*D * G / lengthSq;

    return R;
}


#line 3 "rt_material.cl"

#define AMBIENT (float4)(0.77f,0.58f,0.32f,0)

inline CLBSDFType GetMaterialFlags(const CLVCMMaterialType type)
{
    switch (type)
    {
    case CL_MIRROR:
        return (CLBSDFType)(CL_REFLECTION | CL_SPECULAR);
    case CL_GLASS:
        return (CLBSDFType)(CL_REFLECTION | CL_TRANSMISSION | CL_SPECULAR);
    case CL_RGLASS:
        return (CLBSDFType)(CL_REFLECTION | CL_GLOSSY);
    case CL_MATTE:
        return (CLBSDFType)(CL_REFLECTION | CL_DIFFUSE);
    case CL_GLOSSYMAT:
        return (CLBSDFType)(CL_REFLECTION | CL_GLOSSY | CL_DIFFUSE);
    case CL_METAL:
        return (CLBSDFType)(CL_REFLECTION | CL_GLOSSY);
    case CL_LIGHTMAT:
        return (CLBSDFType)(CL_SPECULAR);
    default:
        return (CLBSDFType)(0);
    }
}

inline float4 SampleMatte(const bool fromLight, __local CLVCMMaterial *mat, const float4 invRayDir, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict texturesKd, const float u1, const float u2,
    float4 *sampledDir, CLBSDFType *flags,
    float *costOut, float *directPdfW, float *reversePdfW)
{
    *flags = (CLBSDFType)(CL_DIFFUSE | CL_REFLECTION);
    float4 R = textureBilinearLookup(texturesKd + mat->matte.kdTexOffset, (int2)(mat->matte.kdTexWidth, mat->matte.kdTexHeight), pathVertex->uv.yx);
    CLFrame frame;
    setFromZ(&frame, pathVertex->hitNormal);
    const float4 locaInvRayDir = toLocal(frame, invRayDir);
    float4 localSampledDir;
    R *= SampleDiffuse(fromLight, u1, u2, locaInvRayDir, &localSampledDir, directPdfW, reversePdfW);
    *costOut = fabs(localSampledDir.z);
    *sampledDir = toWorld(frame, localSampledDir);
    return R;
}

inline float4 EvaluateMatte(const bool fromLight, __local CLVCMMaterial *mat, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict texturesKd, const float4 ns,
    const float4 eyeDir, const float4 lightDir,
    float *directPdfW, float *reversePdfW)
{
    float4 R = textureBilinearLookup(texturesKd + mat->matte.kdTexOffset, (int2)(mat->matte.kdTexWidth, mat->matte.kdTexHeight), pathVertex->uv.yx);
    R *= EvaluateDiffuse(fromLight, pathVertex,ns,eyeDir,lightDir,directPdfW,reversePdfW);
    return R;
}





inline float4 SampleGlass(bool fromLight, __local CLVCMMaterial *mat, const float4 invRayDir, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict texturesKr, __global const uchar4* restrict texturesKt, const float u,
    float4 *sampledDir, CLBSDFType *flags,
    float *costOut, float *directPdfW, float *reversePdfW)
{
    *flags = CL_SPECULAR;
    CLFrame frame;
    setFromZ(&frame, pathVertex->hitNormal);
    const float4 localInvRayDir = toLocal(frame, invRayDir);
    float4 localSampledDir;
    float4 R = 0;
    const float F = evalFresnelDielectric_local(localInvRayDir.z, &mat->glass.eta_i, &mat->glass.eta_t);
    const float threshold = F;//max(0.3f,F);
    if (u < threshold)
    {
        *flags = (CLBSDFType)(*flags | CL_REFLECTION);
        R = textureBilinearLookup(texturesKr + mat->glass.krTexOffset, (int2)(mat->glass.krTexWidth, mat->glass.krTexHeight), pathVertex->uv.yx);
        SampleSpecularReflection(localInvRayDir,&localSampledDir, directPdfW, reversePdfW);

        if (directPdfW)
            *directPdfW *= threshold;
        if (reversePdfW)
            *reversePdfW *= threshold;
    }
    else
    {
        *flags = (CLBSDFType)(*flags | CL_TRANSMISSION);
        R = textureBilinearLookup(texturesKt + mat->glass.ktTexOffset, (int2)(mat->glass.ktTexWidth, mat->glass.ktTexHeight), pathVertex->uv.yx);
        const float eta = mat->glass.eta_i / mat->glass.eta_t;
        R *= SampleSpecularTransmission(fromLight, eta, localInvRayDir, &localSampledDir, directPdfW, reversePdfW);

        if (directPdfW)
            *directPdfW *= 1.0f - threshold;
        if (reversePdfW)
            *reversePdfW *= 1.0f - threshold;
    }

    *sampledDir = toWorld(frame, localSampledDir);
    *costOut = fabs(localSampledDir.z);
    return R;
}





inline float4 EvaluateRoughGlass(const bool fromLight, __local CLVCMMaterial *mat, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict texturesKr, __global const uchar4* restrict texturesKt, const float4 ns,
    float4 eyeDir, float4 lightDir,
    float *directPdfW, float *reversePdfW)
{
    {CLFrame frame;
    setFromZ(&frame, ns);
    eyeDir = toLocal(frame,eyeDir);
    lightDir = toLocal(frame,lightDir);}

    float4 R = 0.0f;
    if(eyeDir.z * lightDir.z > 0.0f)
    {
        float cosTEH = 0;
        R = EvaluateMicrofacetReflection2(fromLight,mat->rglass.alpha,pathVertex,eyeDir,lightDir,&cosTEH,directPdfW,reversePdfW);
        const float F = evalFresnelDielectric_local(cosTEH,&mat->rglass.eta_i,&mat->rglass.eta_t);
        R *= F * textureBilinearLookup(texturesKr + mat->rglass.krTexOffset, (int2)(mat->rglass.krTexWidth, mat->rglass.krTexHeight), pathVertex->uv.yx);
        *directPdfW *= F;
        *reversePdfW *= F;
    }
    else
    {
        const float eta = lightDir.z > 0 ? mat->rglass.eta_i / mat->rglass.eta_t : mat->rglass.eta_t / mat->rglass.eta_i;
        float cosTLH = 0;
        R = EvaluateMicrofacetRefraction2(fromLight,mat->rglass.alpha,eta,pathVertex,eyeDir,lightDir,&cosTLH,directPdfW,reversePdfW);
        const float F = evalFresnelDielectric_local(cosTLH,&mat->rglass.eta_i,&mat->rglass.eta_t);
        R *= (1.0f-F) * textureBilinearLookup(texturesKt + mat->rglass.ktTexOffset, (int2)(mat->rglass.ktTexWidth, mat->rglass.ktTexHeight), pathVertex->uv.yx);
        *directPdfW *= 1.0f - F;
        *reversePdfW *= 1.0f - F;
    }

    return R;
}

inline float4 SampleRoughGlass(bool fromLight, __local CLVCMMaterial *mat, const float4 invRayDir, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict texturesKr, __global const uchar4* restrict texturesKt, const float u1, const float u2, const float u3,
    float4 *sampledDir, CLBSDFType *flags,
    float *costOut, float *directPdfW, float *reversePdfW)
{
    *flags = (CLBSDFType)(CL_REFLECTION | CL_GLOSSY);
    CLFrame frame;
    setFromZ(&frame, pathVertex->hitNormal);
    const float4 localInvRayDir = toLocal(frame, invRayDir);
    float4 localSampledDir;
    float4 R = 0;
    bool entering = localInvRayDir.z > 0.0f;

    float4 halfVector;
    float D;
    SampleGGXH(u1,u2,mat->rglass.alpha,&halfVector,&D);
    if(halfVector.z < 0.0f)
        halfVector = -halfVector;
    const float cosTRH = dot(halfVector, localInvRayDir);
    float cosTFH = 0;

    const float F = evalFresnelDielectric_local(cosTRH,&mat->rglass.eta_i,&mat->rglass.eta_t);
    float threshold = F;
    if (u1 < threshold)
    {
        *flags = (CLBSDFType)(*flags | CL_REFLECTION);
        R = textureBilinearLookup(texturesKr + mat->rglass.krTexOffset, (int2)(mat->rglass.krTexWidth, mat->rglass.krTexHeight), pathVertex->uv.yx);

        if(directPdfW)
            *directPdfW = threshold * D*fabs(halfVector.z) / (4.0f * fabs(cosTRH));
        if(reversePdfW)
            *reversePdfW = *directPdfW;

        localSampledDir = 2.0f * cosTRH * halfVector - localInvRayDir;
        cosTFH = dot(halfVector, localSampledDir);

        if(fabs(localSampledDir.z) < CL_EPSILON || localSampledDir.z * localInvRayDir.z < 0.0f)
            return 0.0f;
    }
    else
    {
        *flags = (CLBSDFType)(*flags | CL_TRANSMISSION);
        const float eta = mat->rglass.eta_i / mat->rglass.eta_t;
        R = textureBilinearLookup(texturesKt + mat->glass.ktTexOffset, (int2)(mat->glass.ktTexWidth, mat->glass.ktTexHeight), pathVertex->uv.yx)*(1-F);

        // Compute transmitted ray direction
        float sinTFH2 = eta * eta * max(0.0f, 1.0f - cosTRH*cosTRH);

        // Handle total internal reflection for transmission
        if (sinTFH2 >= 1.0f) return 0.0f;
        cosTFH = sqrt(1.0f - sinTFH2);
        if (entering) cosTFH = -cosTFH;

        const float length = eta * cosTRH + cosTFH;
        localSampledDir = normalize(length * halfVector - eta * localInvRayDir);

        const float lengthSq = length * length;
        *directPdfW = (1.0f - threshold) * D * fabs(halfVector.z) /* fabs(cosTFH) *// lengthSq;

        if (*directPdfW <= 0.0f)
            return 0.0f;

        if(reversePdfW)
            *reversePdfW = (1.0f - threshold) * D * fabs(halfVector.z) /* cosTRH *// lengthSq;

        if(!fromLight)
        {
            *directPdfW *= fabs(cosTFH);
            *reversePdfW *= fabs(cosTRH);
        }
        else
        {
            *directPdfW *= fabs(cosTRH);
            *reversePdfW *= fabs(cosTFH);
        }
    }

    *costOut = fabs(localSampledDir.z);
    if(fromLight) R *= fabs(localInvRayDir.z/(*costOut));
    const float G = GGX_G(localSampledDir, localInvRayDir, mat->rglass.alpha);
    if(fromLight)
        R *= fabs(cosTRH) * G / (fabs(localInvRayDir.z) * halfVector.z);
    else
        R *= fabs(cosTFH) * G / (*costOut * halfVector.z);

    *sampledDir = toWorld(frame, localSampledDir);

    return R;
}





inline float4 SampleMirror(__local CLVCMMaterial *mat, const float4 invRayDir, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict texturesKr,
    float4 *sampledDir, CLBSDFType *flags,
    float *costOut, float *directPdfW, float *reversePdfW)
{
    *flags = (CLBSDFType)(CL_SPECULAR | CL_REFLECTION);
    CLFrame frame;
    setFromZ(&frame, pathVertex->hitNormal);
    const float4 localInvRayDir = toLocal(frame, invRayDir);
    float4 localSampledDir;
    SampleSpecularReflection(localInvRayDir, &localSampledDir, directPdfW, reversePdfW);
    *sampledDir = toWorld(frame, localSampledDir);
    *costOut = fabs(localSampledDir.z);
    return textureBilinearLookup(texturesKr + mat->mirror.krTexOffset, (int2)(mat->mirror.krTexWidth, mat->mirror.krTexHeight), pathVertex->uv.yx);
}





inline float4 EvaluateGlossy(const bool fromLight, __local CLVCMMaterial *mat, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict texturesKd, __global const uchar4* restrict texturesKs, const float4 ns,
    float4 eyeDir, float4 lightDir,
    float *directPdfW, float *reversePdfW)
{
    {CLFrame frame;
    setFromZ(&frame, ns);
    eyeDir = toLocal(frame,eyeDir);
    lightDir = toLocal(frame,lightDir);}

    float cosTEH = 0;
    float4 R = EvaluateMicrofacetReflection2(fromLight,mat->glossy.alpha,pathVertex,eyeDir,lightDir,&cosTEH,directPdfW,reversePdfW);
    R *= evalFresnelDielectric_local(cosTEH,&mat->glossy.eta_i,&mat->glossy.eta_t);
    R *= textureBilinearLookup(texturesKs + mat->glossy.ksTexOffset, (int2)(mat->glossy.ksTexWidth, mat->glossy.ksTexHeight), pathVertex->uv.yx);

    float diffDirPdfW, diffRevPdfW;
    R += EvaluateDiffuseLocal(fromLight,pathVertex,eyeDir,lightDir,&diffDirPdfW,&diffRevPdfW) *
            textureBilinearLookup(texturesKd + mat->glossy.kdTexOffset, (int2)(mat->glossy.kdTexWidth, mat->glossy.kdTexHeight), pathVertex->uv.yx);
    *directPdfW += diffDirPdfW;
    *reversePdfW += diffRevPdfW;

    *directPdfW *= 0.5f;
    *reversePdfW *= 0.5f;

    return R;
}

inline float4 SampleGlossy(bool fromLight, __local CLVCMMaterial *mat, const float4 invRayDir, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict texturesKd, __global const uchar4* restrict texturesKs, const float u1, const float u2, const float u3,
    float4 *sampledDir, CLBSDFType *flags,
    float *costOut, float *directPdfW, float *reversePdfW)
{
    *flags = CL_REFLECTION;
    CLFrame frame;
    setFromZ(&frame, pathVertex->hitNormal);
    const float4 localInvRayDir = toLocal(frame, invRayDir);
    float4 localSampledDir;
    float4 R = 0;
    float threshold = 0.5f;
    if (u1 < threshold)
    {
        *flags = (CLBSDFType)(*flags | CL_GLOSSY);
        float cosTRH = 0;
        R = SampleMicrofacetReflection2(fromLight,u2,u3,mat->glossy.alpha,localInvRayDir,&localSampledDir, &cosTRH, directPdfW, reversePdfW);
        R *= evalFresnelDielectric_local(cosTRH,&mat->glossy.eta_i,&mat->glossy.eta_t);
        R *= textureBilinearLookup(texturesKs + mat->glossy.ksTexOffset, (int2)(mat->glossy.ksTexWidth, mat->glossy.ksTexHeight), pathVertex->uv.yx);

        if (directPdfW)
            *directPdfW *= threshold;
        if (reversePdfW)
            *reversePdfW *= threshold;

        R /= *directPdfW;
    }
    else
    {
        *flags = (CLBSDFType)(*flags | CL_DIFFUSE);
        R = textureBilinearLookup(texturesKd + mat->glossy.kdTexOffset, (int2)(mat->glossy.kdTexWidth, mat->glossy.kdTexHeight), pathVertex->uv.yx);
        R *= SampleDiffuse(fromLight,u2,u3,localInvRayDir,&localSampledDir, directPdfW, reversePdfW) / (1.0f - threshold);

        if (directPdfW)
            *directPdfW *= 1.0f - threshold;
        if (reversePdfW)
            *reversePdfW *= 1.0f - threshold;

    }

    *sampledDir = toWorld(frame, localSampledDir);
    *costOut = fabs(localSampledDir.z);

    return R;
}


inline float4 EvaluateMetal(const bool fromLight, __local CLVCMMaterial *mat, const __global CLVCMPathVertex *pathVertex,
    const float4 ns,
    float4 eyeDir, float4 lightDir,
    float *directPdfW, float *reversePdfW)
{
    {CLFrame frame;
    setFromZ(&frame, ns);
    eyeDir = toLocal(frame,eyeDir);
    lightDir = toLocal(frame,lightDir);}

    float cosTEH = 0;
    float4 R = EvaluateMicrofacetReflection2(fromLight,mat->metal.alpha,pathVertex,eyeDir,lightDir,&cosTEH,directPdfW,reversePdfW);
    const float4 k = (float4)(mat->metal.k_r, mat->metal.k_g, mat->metal.k_b,0),
                    eta = (float4)(mat->metal.eta_r, mat->metal.eta_g, mat->metal.eta_b,0);
    R *= evalFresnelConductor(fabs(cosTEH),eta,k);

    return R;
}

inline float4 SampleMetal(bool fromLight, __local CLVCMMaterial *mat, const float4 invRayDir, const __global CLVCMPathVertex *pathVertex,
    const float u1, const float u2, const float u3,
    float4 *sampledDir, CLBSDFType *flags,
    float *costOut, float *directPdfW, float *reversePdfW)
{
    *flags = (CLBSDFType)(CL_REFLECTION | CL_GLOSSY);
    CLFrame frame;
    setFromZ(&frame, pathVertex->hitNormal);
    const float4 localInvRayDir = toLocal(frame, invRayDir);
    float4 localSampledDir;

    float cosTRH = 0;
    float4 R = SampleMicrofacetReflection2(fromLight,u2,u3,mat->metal.alpha,localInvRayDir,&localSampledDir, &cosTRH ,directPdfW, reversePdfW);
    const float4 k = (float4)(mat->metal.k_r, mat->metal.k_g, mat->metal.k_b,0),
                    eta = (float4)(mat->metal.eta_r, mat->metal.eta_g, mat->metal.eta_b,0);
    R *= evalFresnelConductor(fabs(cosTRH),eta,k);
    *sampledDir = toWorld(frame, localSampledDir);
    *costOut = fabs(localSampledDir.z);

    return R / *directPdfW;
}


inline float4 SampleBSDF(const bool fromLight, const int sample, const int N, uint2* seed, __local CLVCMMaterial *mat, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict textureSet1, __global const uchar4* restrict textureSet2, float4 *sampledDir, CLBSDFType *flags,
    float *absCostOutNS, float *directPdfW, float *reversePdfW)
{
    float4 R = 0.0f;
    const float4 invRayDir = pathVertex->invRayDir;
    switch (mat->type)
    {
    case CL_MATTE:
    {
		const float u1 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
		const float u2 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
        R = SampleMatte(fromLight, mat, invRayDir, pathVertex, textureSet1, u1, u2, sampledDir, flags, absCostOutNS, directPdfW, reversePdfW);
        break;
    }
    case CL_MIRROR:
    {
        R = SampleMirror(mat, invRayDir, pathVertex, textureSet1, sampledDir, flags, absCostOutNS, directPdfW, reversePdfW);
        break;
    }

    case CL_GLASS:
    {
		const float u1 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
        R = SampleGlass(fromLight, mat, invRayDir, pathVertex, textureSet1, textureSet2, u1, sampledDir, flags, absCostOutNS, directPdfW, reversePdfW);
        break;
    }
    case CL_RGLASS:
    {
		const float u1 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
		const float u2 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
		const float u3 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
        //printf("\n%f %f %f",u1,u2,u3);
        R = SampleRoughGlass(fromLight, mat, invRayDir, pathVertex, textureSet1, textureSet2, u1, u2, u3, sampledDir, flags, absCostOutNS, directPdfW, reversePdfW);
        break;
    }
    case CL_GLOSSYMAT:
    {
		const float u1 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
		const float u2 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
		const float u3 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
        R = SampleGlossy(fromLight, mat, invRayDir, pathVertex, textureSet1, textureSet2, u1, u2, u3, sampledDir, flags, absCostOutNS, directPdfW, reversePdfW);
        break;
    }
    case CL_METAL:
    {

		const float u1 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
		const float u2 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
		const float u3 = //rand_float(seed);
                         cmj1D(sample, N, as_int(rand_float(seed)));
        R = SampleMetal(fromLight, mat, invRayDir, pathVertex, u1, u2, u3, sampledDir, flags, absCostOutNS, directPdfW, reversePdfW);
        break;
    }
    default:
        break;
    }

    if (fromLight)
    {
        const float4 gn = pathVertex->geoNormal;
        const float absCostInNG = fabs(dot(invRayDir, gn));
        const float absCostOutNG = fabs(dot(*sampledDir, gn));
        //const float absCostInNS = fabs(dot(invRayDir, n));
        const float factor = /*absCostInNS */ absCostOutNG / absCostInNG;
        return R * factor;
    }
    else
        return R /* (*absCostOutNS)*/;
}

inline float4 EvaluateBSDF( __local CLVCMMaterial *mat, const __global CLVCMPathVertex *pathVertex,
    __global const uchar4* restrict textureSet1, __global const uchar4* restrict textureSet2,
    const float4 ns, const float4 forwDir,
    float *directPdfW, float *reversePdfW)
{
    const bool fromLight = pathVertex->fromLight == 1;

    float4 eyeDir, lightDir;
    {
        const float4 invRayDir = pathVertex->invRayDir;
        eyeDir = fromLight ? forwDir : invRayDir;
        lightDir = fromLight ?  invRayDir : forwDir;
    }

    float costENG;
    float costLNG;
    {
        const float4 gn = pathVertex->geoNormal;
        costENG = dot(eyeDir, gn);
        costLNG = dot(lightDir, gn);
    }
    const float absCostENG = fabs(costENG);
    const float absCostLNG = fabs(costLNG);
    if ((absCostENG == 0.0f) ||
            (absCostLNG == 0.0f))
    {
        *directPdfW = *reversePdfW = 0.0f;
        return 0.0f;
    }

    const float sideTest = costENG * costLNG;
    const CLVCMMaterialType type = mat->type;
    CLBSDFType flags = GetMaterialFlags(type);
    if (((sideTest > 0.0f) && !(flags & CL_REFLECTION)) ||
        ((sideTest < 0.0f) && !(flags & CL_TRANSMISSION)))
    {
        *directPdfW = *reversePdfW = 0.0f;
        return 0.0f;
    }

    float4 R = 0.0f;
    switch (type)
    {
    case CL_MATTE:
    {
        R = EvaluateMatte(fromLight, mat, pathVertex, textureSet1, ns, eyeDir, lightDir, directPdfW, reversePdfW);
        break;
    }
    case CL_MIRROR:
    {
        *directPdfW = *reversePdfW = 0.0f;
        break;
    }

    case CL_GLASS:
    {
        *directPdfW = *reversePdfW = 0.0f;
        break;
    }
    case CL_RGLASS:
    {
        R = EvaluateRoughGlass(fromLight, mat, pathVertex, textureSet1, textureSet2, ns, eyeDir, lightDir, directPdfW,reversePdfW);
        break;
    }
    case CL_GLOSSYMAT:
    {
        R = EvaluateGlossy(fromLight, mat, pathVertex, textureSet1, textureSet2, ns, eyeDir, lightDir, directPdfW,reversePdfW);
        break;
    }
    case CL_METAL:
    {
        R = EvaluateMetal(fromLight, mat, pathVertex, ns, eyeDir, lightDir, directPdfW,reversePdfW);
        break;
    }
    default:
    {
        *directPdfW = *reversePdfW = 0.0f;
        break;
    }
    }

    const float absCostLNS = fabs(dot(lightDir, ns));
    if (fromLight)
    {
        return R * absCostLNS * absCostENG / absCostLNG;;
    }
    else
        return R * absCostLNS;
}


#line 3 "rt_hashgrid.cl"

inline int2 GetCellRange(const int cellIndex,  __global const int *cellEnds)
{
    if(cellIndex == 0) return (int2)(0, cellEnds[0]);
    return (int2)(cellEnds[cellIndex-1], cellEnds[cellIndex]);
}

inline int GetCellIndex_i(const int4 coord, const int cellCount)
{
    uint x = (uint)(coord.x);
    uint y = (uint)(coord.y);
    uint z = (uint)(coord.z);

    return (int)(((x * 73856093) ^ (y * 19349663) ^
        (z * 83492791)) % (uint)(cellCount));
}

inline int GetCellIndex_f(const float4 point, const float4 BBoxMin, const float invCellSize, const int cellCount)
{
    const float4 distMin = invCellSize*(point - BBoxMin);

    const int4 coordI  = (int4)((int)floor(distMin.x), (int)floor(distMin.y), (int)floor(distMin.z), 1);

    return GetCellIndex_i(coordI, cellCount);
}

__kernel
void buildWorldBox(__global CLVCMAABB* restrict worldBox,
                   __global const CLVCMPathVertex* restrict pathVertices,
                   __global int* restrict cellCount,
                        __global float4* restrict color,
                        __constant CLVCMCamera* restrict camera)
{
    const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);

    const int localIndex = get_local_id(1)*get_local_size(0) + get_local_id(0);
    const int currIndex = idY * sizeX + idX;

    /*if((pathVertices + vertIndex)->pathThroughput_length.w < 2.0f)
        return;*/

    __local CLVCMAABB bbox[256];
    bbox[localIndex].minX = bbox[localIndex].minY = bbox[localIndex].minZ = FLT_MAX;
    bbox[localIndex].maxX = bbox[localIndex].maxY = bbox[localIndex].maxZ = -FLT_MAX;
    bbox[localIndex].minW = bbox[localIndex].maxW = 1.0f;

    if((pathVertices + currIndex)->pathLength > 1)
    {
        float4 pos = (pathVertices + currIndex)->hitPosition;

        if( bbox[localIndex].maxX < pos.x)
            bbox[localIndex].maxX = pos.x;
        if( bbox[localIndex].maxY < pos.y)
            bbox[localIndex].maxY = pos.y;
        if( bbox[localIndex].maxZ < pos.z)
            bbox[localIndex].maxZ = pos.z;

        if( bbox[localIndex].minX > pos.x)
            bbox[localIndex].minX = pos.x;
        if( bbox[localIndex].minY > pos.y)
            bbox[localIndex].minY = pos.y;
        if( bbox[localIndex].minZ > pos.z)
            bbox[localIndex].minZ = pos.z;
        //atomic_inc(cellCount);
    }

    /*if(get_local_id(0) == 0)
        printf("\n %f %f %f",bbox.min.x,bbox.min.y,bbox.min.z);*/
    for(int stride = get_local_size(0)/2; stride > 0; stride >>= 1)
    {
        barrier(CLK_LOCAL_MEM_FENCE);

        if((int)localIndex < stride)
        {
            if( bbox[localIndex].maxX < bbox[localIndex+stride].maxX)
                bbox[localIndex].maxX = bbox[localIndex+stride].maxX;
            if( bbox[localIndex].maxY < bbox[localIndex+stride].maxY)
                bbox[localIndex].maxY = bbox[localIndex+stride].maxY;
            if( bbox[localIndex].maxZ < bbox[localIndex+stride].maxZ)
                bbox[localIndex].maxZ = bbox[localIndex+stride].maxZ;

            if( bbox[localIndex].minX > bbox[localIndex+stride].minX)
                bbox[localIndex].minX = bbox[localIndex+stride].minX;
            if( bbox[localIndex].minY > bbox[localIndex+stride].minY)
                bbox[localIndex].minY = bbox[localIndex+stride].minY;
            if( bbox[localIndex].minZ > bbox[localIndex+stride].minZ)
                bbox[localIndex].minZ = bbox[localIndex+stride].minZ;
        }
    }
    barrier(CLK_LOCAL_MEM_FENCE);

    if(localIndex == 0)
    {
        AtomicMax(&(worldBox->maxX),bbox[localIndex].maxX);
        AtomicMax(&(worldBox->maxY),bbox[localIndex].maxY);
        AtomicMax(&(worldBox->maxZ),bbox[localIndex].maxZ);

        AtomicMin(&(worldBox->minX),bbox[localIndex].minX);
        AtomicMin(&(worldBox->minY),bbox[localIndex].minY);
        AtomicMin(&(worldBox->minZ),bbox[localIndex].minZ);

        //barrier(CLK_GLOBAL_MEM_FENCE);
        //printf("\n %f %f %f\n",max.x,max.y,max.z);
    }
}

__kernel
void resetCellEnds(__global int* restrict cellEnds,
                               __global int* restrict cellEnds_scanned,
                               __global CLVCMPathVertex* restrict pathVertices,
                               __global int* restrict cellCount,
                               __global int* restrict errorCount)
{
    const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);

    const int currIndex = idY * sizeX + idX;

    if(currIndex == 0)
        *cellCount = *errorCount = 0;

    (pathVertices + currIndex)->pathLength = 0.0f;
    //(pathVertices + currIndex)->pathThroughput = 0.0f;
    cellEnds_scanned[currIndex] = cellEnds[currIndex] = 0;
}

__kernel
void setupCellEnds(__global int* restrict cellEnds,
                               __global const CLVCMPathVertex* restrict pathVertices,
                               __global const CLVCMAABB* restrict worldBox,
                               const float invCellSize,
                               __global const int* restrict cellCount)
{
    const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
    const int sizeY = get_global_size(1);
    const int cc = sizeX*sizeY;//cellCount;

    const int localIndex = get_local_id(1)*get_local_size(0) + get_local_id(0);
    const int currIndex = idY * sizeX + idX;

    /*if((pathVertices + vertIndex)->pathThroughput_length.w < 2.0f)
        return;*/

    const float4 boxMin = (float4)(worldBox->minX,worldBox->minY,worldBox->minZ,1.0f);

     /*if(currIndex == 0)
        printf("\n %d", cc);*/
    if((pathVertices + currIndex)->pathLength > 1)
    {
        const float4 pos = (pathVertices + currIndex)->hitPosition;
        atomic_inc(cellEnds + GetCellIndex_f(pos,boxMin,invCellSize,cc));
    }
}

__kernel
void finishCellEnds(__global int* restrict cellEnds,
                              __global int* restrict  indices,
                              __global CLVCMPathVertex* restrict pathVertices,
                              __global const CLVCMAABB* restrict worldBox,
                              const float invCellSize,
                              __global const int* restrict cellCount)
{
    const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
    const int sizeY = get_global_size(1);
    const int cc = sizeX*sizeY;//cellCount;

    const int currIndex = idY * sizeX + idX;

    /*if((pathVertices + vertIndex)->pathThroughput_length.w < 2.0f)
        return;*/

    const float4 boxMin = (float4)(worldBox->minX,worldBox->minY,worldBox->minZ,1.0f);
    float reservoirWeight = max(1.0f, (float)(*cellCount)/(sizeX*sizeY));

     if((pathVertices + currIndex)->pathLength > 1)
    {
        const float4 pos = (pathVertices + currIndex)->hitPosition;
        (pathVertices + currIndex)->pathThroughput *= reservoirWeight;
        const int targetIdx = atomic_inc(cellEnds + GetCellIndex_f(pos,boxMin,invCellSize,cc));
        indices[targetIdx] = currIndex;
        //atomic_inc(indices+targetIdx);
    }
}

__kernel
void debugCellEnds(__global const CLVCMPathVertex* restrict pathVertices,
                                __global int* restrict cellEnds,
                                __global const int* restrict  indices,
                                __global const CLVCMAABB* restrict worldBox,
                                const float invCellSize,
                                __global const int* restrict cellCount,
                                __global int* restrict errorCount)
{
    const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
    const int sizeY = get_global_size(1);
    const int cc = sizeX*sizeY;//cellCount;

    const int currIndex = idY * sizeX + idX;

    const float4 boxMin = (float4)(worldBox->minX,worldBox->minY,worldBox->minZ,1.0f);

    if((pathVertices + currIndex)->pathLength > 1)
    {
        const float4 pos = (pathVertices + currIndex)->hitPosition;
        int2 range = GetCellRange(GetCellIndex_f(pos,boxMin,invCellSize,cc),cellEnds);
        bool found = false;
        for(;range.x < range.y; range.x++)
        {
            if(indices[range.x] == currIndex)
                found = true;
        }
        if(!found)
            atomic_inc(errorCount);
    }
}

float4 queryProcess(const __global CLVCMPathVertex *lightVertex,
                           const __global CLVCMPathVertex *camVertex,
                           __local CLVCMMaterial* restrict mat,
                           __global const uchar4* restrict textureSet1,
                           __global const uchar4* restrict textureSet2,
                           const float misVcWeightFactor)
{
    // Reject if full path length below/above min/max path length
    if(lightVertex->pathLength < 2)
        return 0.0f;
   //if(lightVertex->pathLength + camVertex->pathLength > CL_MAXBOUNCES)
      //   return 0.0f;

    // Retrieve light incoming direction in world coordinates
    float cameraBsdfDirPdfW, cameraBsdfRevPdfW;
    float4 cameraBsdfFactor;
    {
        const float4 ns = camVertex->hitNormal;
        if(dot(ns,lightVertex->hitNormal) < 0.0f)
            return 0.0f;
        const float4 lightDir = lightVertex->invRayDir;
        cameraBsdfFactor= EvaluateBSDF(mat, camVertex, textureSet1, textureSet2,
                                       ns, lightDir, &cameraBsdfDirPdfW, &cameraBsdfRevPdfW);
        cameraBsdfFactor /= fabs(dot(ns,lightDir));
    }

    //Russian rulett
    //if(camVertex->pathLength > 4)
    {
        const float prob = clamp(Y(cameraBsdfFactor),0.5f,1.0f); //RR
        cameraBsdfDirPdfW *= prob;
        cameraBsdfRevPdfW *= prob;
    }

    // Partial light sub-path MIS weight [tech. rep. (38)]
    const float wLight = lightVertex->dVCM * misVcWeightFactor +
        lightVertex->dVM * Mis(cameraBsdfDirPdfW);

    // Partial eye sub-path MIS weight [tech. rep. (39)]
    const float wCamera = camVertex->dVCM * misVcWeightFactor +
        camVertex->dVM * Mis(cameraBsdfRevPdfW);

    // Full path MIS weight [tech. rep. (37)].
    const float misWeight = 1.0f / (wLight + 1.0f + wCamera);

    float4 L = misWeight * cameraBsdfFactor * lightVertex->pathThroughput;
    if(Y(L) > 0.0f)
        return L;
     return 0.0f;
}

__kernel
void processHashGrid(__global const CLVCMPathVertex* restrict lightVertices,
                                   __global const CLVCMPathVertex* restrict pathVertices,
                                   __global int* restrict cellEnds,
                                   __global const int* restrict  indices,
                                   __global const CLVCMAABB* restrict worldBox,
                                   __global const CLVCMMaterial* restrict materials,
                                   __global const uchar4* restrict textureSet1,
                                   __global const uchar4* restrict textureSet2,
                                   __global float4* restrict color,
                                   const float vmNormalization,
                                   const float misVcWeightFactor,
                                   const float radiusSqr,
                                   const float invCellSize,
                                   __global const int* restrict cellCount)
{
    // workitem/worksize info
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;

    int matId = (pathVertices + currIndex)->matId;
    __local CLVCMMaterial mat[SHMEMSIZE];
    if( matId != INT_MAX )
    {
        //CLVCMMaterial mat = materials[matId];
        mat[get_local_id(0)] = materials[matId];
        if(CL_SPECULAR & GetMaterialFlags(mat[get_local_id(0)].type))
        {
            //color[currIndex] = getHeatMapColor((float)((int)mat.type),3.0f);
            return;
        }
        int  px, py, pz, pxo, pyo, pzo;
        const float4 queryPos = (pathVertices + currIndex)->hitPosition;
        {
            const float4 distMin = queryPos - (float4)(worldBox->minX,worldBox->minY,worldBox->minZ,1.0f);
            const float4 distMax = (float4)(worldBox->maxX,worldBox->maxY,worldBox->maxZ,1.0f) - queryPos;

            {
                if (distMin.x < 0.0f || distMin.y < 0.0f || distMin.z < 0.0f) return;
                if (distMax.x < 0.0f || distMax.y < 0.0f || distMax.z < 0.0f) return;
            }

            const float4 cellPt = invCellSize * distMin;
            const float4 coordF = (float4)(floor(cellPt.x),
                                                           floor(cellPt.y),
                                                           floor(cellPt.z),1.0f);

            px = (int)(coordF.x);
            py = (int)(coordF.y);
            pz = (int)(coordF.z);

            const float4 fractCoord = cellPt - coordF;

            pxo = px + (fractCoord.x < 0.5f ? -1 : +1);
            pyo = py + (fractCoord.y < 0.5f ? -1 : +1);
            pzo = pz + (fractCoord.z < 0.5f ? -1 : +1);
        }

        const __global CLVCMPathVertex *camVertex = (pathVertices + currIndex);
        float4 contrib = 0.0f;
        const int cc = sizeX*sizeY;

#define MODIFY 1
#if MODIFY
        int2 activeRanges[] = {
                                   GetCellRange(GetCellIndex_i((int4)(px, py, pz,1),   cc), cellEnds),
                                   GetCellRange(GetCellIndex_i((int4)(px, py, pzo,1),  cc), cellEnds),
                                   GetCellRange(GetCellIndex_i((int4)(px, pyo, pz,1),  cc), cellEnds),
                                   GetCellRange(GetCellIndex_i((int4)(px, pyo, pzo,1), cc), cellEnds),
                                   GetCellRange(GetCellIndex_i((int4)(pxo, py, pz,1),  cc), cellEnds),
                                   GetCellRange(GetCellIndex_i((int4)(pxo, py, pzo,1), cc), cellEnds),
                                   GetCellRange(GetCellIndex_i((int4)(pxo, pyo, pz,1), cc), cellEnds),
                                   GetCellRange(GetCellIndex_i((int4)(pxo, pyo, pzo,1),cc), cellEnds)
                              };

        const int numActiveCellRanges = sizeof(activeRanges)/sizeof(activeRanges[0]);

        for(int i = 0; i < numActiveCellRanges; ++i)
        {
            int2 activeRange = activeRanges[i];

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
            }
        }
#else
        {
            int2 activeRange = GetCellRange(GetCellIndex_i((int4)(px, py, pz,1),cc), cellEnds);

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
                /*else
                    contrib += distSqr;*/
            }
        }
        {
            int2 activeRange = GetCellRange(GetCellIndex_i((int4)(px, py, pzo,1),cc), cellEnds);

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
            }
        }
        {
            int2 activeRange = GetCellRange(GetCellIndex_i((int4)(px, pyo, pz,1),cc), cellEnds);

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
            }
        }
        {
            int2 activeRange = GetCellRange(GetCellIndex_i((int4)(px, pyo, pzo,1),cc), cellEnds);

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
            }
        }
        {
           int2 activeRange = GetCellRange(GetCellIndex_i((int4)(pxo, py, pz,1),cc), cellEnds);

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
            }
        }
        {
            int2 activeRange = GetCellRange(GetCellIndex_i((int4)(pxo, py, pzo,1),cc), cellEnds);

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
            }
        }
        {
            int2 activeRange = GetCellRange(GetCellIndex_i((int4)(pxo, pyo, pz,1),cc), cellEnds);

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
            }
        }
        {
            int2 activeRange = GetCellRange(GetCellIndex_i((int4)(pxo, pyo, pzo,1),cc), cellEnds);

            for (; activeRange.x < activeRange.y; activeRange.x++)
            {
                const int particleIndex = indices[activeRange.x];
                const __global CLVCMPathVertex *lightVertex = (lightVertices+particleIndex);

                float4 distP = queryPos - lightVertex->hitPosition;
                const float distSqr = dot(distP,distP);

                if (distSqr <= radiusSqr)
                {
                    contrib += queryProcess(lightVertex, camVertex, &mat[get_local_id(0)], textureSet1, textureSet2, misVcWeightFactor);
                }
            }
        }
#endif

        color[currIndex] += contrib*vmNormalization*camVertex->pathThroughput;
    }
}

#line 3 "rt_vcm.cl"



//////////////////////////////////////////////////////////////////////////
// Utilities for converting PDF between Area (A) and Solid angle (W)
// WtoA = PdfW * cosine / distance_squared
// AtoW = PdfA * distance_squared / cosine

inline float PdfWtoA(
    const float pdfW,
    const float dist,
    const float cosThere)
{
    return pdfW * fabs(cosThere) / (dist*dist);
}

inline float PdfAtoW(
    const float pdfA,
    const float dist,
    const float cosThere)
{
    return pdfA * dist * dist / fabs(cosThere);
}

#define apert_shape 6
inline float2 sampleLens(const float u1, const float u2, const int shape)
{
    if (shape < 3)
		return concentricSampleDisk(u1, u2);

	const float halfAngle = (float)M_PI_F / shape;
	const float polyRadius = cos(halfAngle);

	const float theta = 2.0f * M_PI_F * u2;

	const uint sector = (uint)floor(theta / halfAngle);
	const float rho = (sector % 2 == 0) ? theta - sector * halfAngle :
		(sector + 1) * halfAngle - theta;

	float r = polyRadius / cos(rho);
	r *= sqrt(u1);

	return (float2)(r * cos(theta), r * sin(theta));
}

__kernel
void generatePrimaryRayVCM(__constant CLVCMCamera* restrict camera,
                                    __global uint2* restrict randomSeed,
									__global   CLRay* restrict rays,
                                    __global float* restrict rayweights,
                                    __global float2* restrict pixelCoords,
                                    const int pass,
                                    __global CLVCMPathVertex* pathVertices)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;

    const float4 dirBL = camera->dirBL;
	const float4 camI = (camera->dirBR - dirBL) / sizeX;
	const float4 camJ = (camera->dirTL - dirBL) / sizeY;

	CLRay primaryRay;
    uint2 seed = randomSeed[currIndex];
	primaryRay.org = camera->pos;
    float2 uv = cmj(pass, sizeX*sizeY, as_int(rand_float(&seed)), (float)sizeX/sizeY);
    float2 pixelCoord = (float2)((float)idX + 0.5f -uv.x,(float)idY + 0.5f - uv.y);
	primaryRay.dir = dirBL + camI*pixelCoord.x + camJ*pixelCoord.y;
	primaryRay.dir = normalize(primaryRay.dir);

    float lensRadius = camera->lensRadius;
    if (lensRadius > 0.0f)
    {
        // Sample point on lens
        uv = cmj(pass, sizeX*sizeY, as_int(rand_float(&seed)), (float)sizeX/sizeY);
        float2 lensUV = sampleLens(uv.x, uv.y,apert_shape);
        //sampleLens(rand_float(&seed), rand_float(&seed),apert_shape);
        //concentricSampleDisk(rand_float(&seed), rand_float(&seed));
        lensUV.x *= lensRadius;
        lensUV.y *= lensRadius;

        // Compute point on plane of focus
        float4 focusP = primaryRay.org + primaryRay.dir*camera->focalDistance;

        // Update ray for effect of lens
        primaryRay.org += camI*lensUV.x + camJ*lensUV.y;
        primaryRay.dir = normalize(focusP - primaryRay.org);
    }

    float4 camForw = camera->forward;
    // Compute pdf conversion factor from area on image plane to solid angle on ray
    const float cosAtCamera = dot(camForw, primaryRay.dir);
    const float imagePointToCameraDist = camera->imgPlaneDist / cosAtCamera;
    const float imageToSolidAngleFactor = imagePointToCameraDist * imagePointToCameraDist / cosAtCamera; //cameraPdf

    //(pathVertices + currIndex)->matId = INT_MAX;
    (pathVertices + currIndex)->pathThroughput = (float4)(1,1,1,1);
    (pathVertices + currIndex)->pathLength = 1;
    (pathVertices + currIndex)->dVCM = Mis((float)(sizeX*sizeY) / imageToSolidAngleFactor);
    (pathVertices + currIndex)->dVC = 0;
    (pathVertices + currIndex)->dVM = 0;
    (pathVertices + currIndex)->fromLight = 0;
    rayweights[currIndex] = 1.0f;
	rays[currIndex] = primaryRay;
    pixelCoords[currIndex] = pixelCoord;
    randomSeed[currIndex] = seed;
}

__kernel
void generateHitDataVCM(__global uint2* restrict randomSeed,
                        __global const CLHitRecord* restrict hitrecs,
                        __global const CLTriangle* restrict tris,
                        __global const float4* restrict points,
                        __global const float4* restrict normals,
                        __global const float* restrict maxAngles,
                        __global const float4* restrict tangents,
                        __global const float2* restrict uvs,
                        __global const CLVCMMaterial* restrict materials,
                        __global const int* restrict matIds,
                        __global const uchar4* restrict textureSet1,
                        __global const uchar4* restrict textureSet2,
                        __global const uchar4* restrict texturesNormalMap,
                        __global const float* restrict rayweights,
                        __global const CLRay* restrict rays,
                        const int backLightID,
                        __global const float4* restrict envMap,
                        __global const float* restrict envLightDistr,
                        __global const CLVCMLight* restrict lights,
                        __global CLVCMPathVertex* restrict lightVertices,
                        __global CLVCMPathVertex* restrict pathVertices,
                        __global int* restrict pathVertCount,
                        __global float4* restrict color,
                        const int fromLight)
{
	// workitem/worksize info
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;

	if( (hitrecs+currIndex)->triId != INT_MAX )
	{
        CLVCMPathVertex pathVertex = pathVertices[currIndex];
        float costIn, tHit;
        {
            const CLHitRecord currHitRec = hitrecs[currIndex];
            pathVertex.matId = matIds[currHitRec.triId];
            tHit = currHitRec.tHit;

            const float b0 = 1.0f - currHitRec.b1 - currHitRec.b2;
            if(isnan(b0))
            {
                pathVertex.pathLength = -1;
                pathVertex.matId = INT_MAX;
                return;
            }

            float4 v0 =  points[3*currHitRec.triId + 0] - points[3*currHitRec.triId + 1];
            float4 v1 =  points[3*currHitRec.triId + 0] - points[3*currHitRec.triId + 2];
            pathVertex.geoNormal = normalize(cross(v0,v1));

            pathVertex.uv  =  uvs[3*currHitRec.triId    ] * b0 +
                              uvs[3*currHitRec.triId + 1] * currHitRec.b1 +
                              uvs[3*currHitRec.triId + 2] * currHitRec.b2;

            const float4 rayDir = rays[currIndex].dir;
            pathVertex.hitPosition = rays[currIndex].org + rayDir * tHit;

            pathVertex.hitNormal = normalize(normals[3*currHitRec.triId    ] * b0 +
                                       normals[3*currHitRec.triId + 1] * currHitRec.b1 +
                                       normals[3*currHitRec.triId + 2] * currHitRec.b2);


            if((materials+pathVertex.matId)->hasNormalMap == 1)
            {
                float4 t = normalize(tangents[3*currHitRec.triId    ] * b0 +
                                     tangents[3*currHitRec.triId + 1] * currHitRec.b1 +
                                     tangents[3*currHitRec.triId + 2] * currHitRec.b2);
                float4 b = cross(pathVertex.hitNormal, t);
                float4 nTEX = textureBilinearLookup(texturesNormalMap + (materials+pathVertex.matId)->nTexOffset, (int2)((materials+pathVertex.matId)->nTexWidth, (materials+pathVertex.matId)->nTexHeight), pathVertex.uv.yx);
                nTEX = nTEX*2.0f - 1.0f;
                nTEX.s3 = 0.0f;
                nTEX = normalize( nTEX );

                float16 tangenframeMAT;

                tangenframeMAT.s0123 = t;
                tangenframeMAT.s4567 = b;
                tangenframeMAT.s89AB = pathVertex.hitNormal;
                tangenframeMAT.sCDEF = (float4)(0.0f,0.0f,0.0f,1.0f);

                pathVertex.hitNormal = MulMat4Vec4(&tangenframeMAT, &nTEX);
            }

            {
                float sgn = 1.0f;
                if(dot(rayDir,pathVertex.geoNormal) > 0) { pathVertex.geoNormal = -pathVertex.geoNormal; sgn = -1;}
                if(dot(pathVertex.hitNormal,pathVertex.geoNormal) < 0) pathVertex.hitNormal = -pathVertex.hitNormal;

                float af =   maxAngles[3*currHitRec.triId    ] * b0 +
                                       maxAngles[3*currHitRec.triId + 1] * currHitRec.b1 +
                                       maxAngles[3*currHitRec.triId + 2] * currHitRec.b2;

                float b = dot(rayDir, pathVertex.hitNormal);
                float q = (1.0f - (2.0f/M_PI_F)*af)*(1.0f - (2.0f/M_PI_F)*af) /
                           (1.0f + 2.0f*af*(1.0f - (2.0f/M_PI_F)));
                float g = 1.0f - q * (1.0f + b); // lerp
                float sinr = sqrt(q*(1 + g)/(1 - b));
                float4 reflection = (g - sinr * b) * pathVertex.hitNormal + sinr * rayDir;
                // compute consistent normal
                pathVertex.hitNormal = sgn*normalize(reflection - rayDir);
            }

            costIn = fabs(dot(pathVertex.hitNormal, -rayDir));
            pathVertex.invRayDir = -rayDir;
        }


        // Update the MIS quantities before storing them at the vertex [tech. rep. (31)-(33)]
        // or [tech. rep. (34)-(36)], respectively.
        // Infinite lights use MIS handled via solid angle integration,
        // so do not divide by the distance for such lights [tech. rep. Section 5.1]
        if ((fromLight == 0) || pathVertex.pathLength > 1 || pathVertex.pathThroughput.w > 1.0f)
            pathVertex.dVCM *= Mis(tHit*tHit);
       {const float invCosMis = 1.0f / Mis(costIn);
        pathVertex.dVCM *= invCosMis;
        pathVertex.dVC *= invCosMis;
        pathVertex.dVM *= invCosMis;}
        pathVertex.pathLength += 1;
        if(isnan(pathVertex.dVCM)||isnan(pathVertex.dVC)||isnan(pathVertex.dVM))
        {
            pathVertex.pathLength = -1;
            pathVertex.matId = INT_MAX;
            return;
        }
        bool specularBounce = (CL_SPECULAR) & GetMaterialFlags((materials+pathVertex.matId)->type);
        bool store = (fromLight == 1) && !specularBounce;
        if (store)
        {

            const int id = atomic_inc(pathVertCount);
            if (id < sizeX*sizeY)
            {
                lightVertices[id] = pathVertex;
            }
            else
            {
                uint2 seed = randomSeed[currIndex];
                int j = round(rand_float(&seed)*id);
                if( j < sizeX*sizeY )
                    lightVertices[j] = pathVertex;
                randomSeed[currIndex] = seed;
            }
        }
        pathVertices[currIndex] = pathVertex;
	}
	else
    {
        if(backLightID >= 0 && (fromLight == 0) && (pathVertices+currIndex)->pathLength > 0)
        {
            color[currIndex] += GetRadiance_BackLight((lights+backLightID),(pathVertices+currIndex),envLightDistr,envMap,(rays+currIndex)->dir);
            (pathVertices+currIndex)->pathLength = -1;
        }
		(pathVertices+currIndex)->matId = INT_MAX;
    }
}

__kernel
void generateLightSamplesVCM(__global uint2* restrict randomSeed,
                         //__global float2* restrict randomSeedTemp,
                         __global const CLVCMLight* restrict lights,
                         __global const float* restrict lightDistribution,
                        __global const float4* restrict envMap,
                        __global const float* restrict envLightDistr,
                         __global const CLTriangle* restrict tris,
                         __global const float4* restrict points,
                         __global CLRay* restrict rays,
                         __global float* restrict rayweights,
                         __global CLVCMPathVertex* restrict pathVertices,
                         __constant CLVCMCamera* restrict camera,
                         float lightCount,
                         float misVcWeightFactor,
                         const int pass,
                         __global float4* restrict color)
{
    if(lightCount == 0)
        return;

    // workitem/worksize info
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;

    CLRay ray;
    uint2 seed = randomSeed[currIndex];
    CLLightType type;
    float emissionPdfW, directPdfW, cosLight;
    {
        float lightPickProb = 0.0f;
        const int lightID = Distribution1D_SampleDiscrete(lightDistribution, cmj1D(pass, sizeX*sizeY, as_int(rand_float(&seed))), &lightPickProb);

        type = (lights+lightID)->type;
        float4 R = Emit((lights+lightID), type, points, pass, sizeX*sizeY, &seed, &ray, envLightDistr, envMap, &emissionPdfW, &directPdfW, &cosLight);

        emissionPdfW *= lightPickProb;
        directPdfW *= lightPickProb;

        R /= emissionPdfW;
        R.w = isFiniteLight(type) ? 2.0f : 0.0f;
        (pathVertices+currIndex)->pathThroughput = R;
    }

    (pathVertices+currIndex)->fromLight = 1;
    (pathVertices+currIndex)->pathLength = 1;

    // Light sub-path MIS quantities. Implements [tech. rep. (31)-(33)] partially.
    // The evaluation is completed after tracing the emission ray in the light sub-path loop.
    // Delta lights are handled as well [tech. rep. (48)-(50)].
    (pathVertices+currIndex)->dVCM = Mis(directPdfW / emissionPdfW);

    if (!isDeltaLight(type))
    {
        const float usedCosLight = isFiniteLight(type) ? cosLight : 1.0f;
        (pathVertices+currIndex)->dVC = Mis(usedCosLight / emissionPdfW);
    }
    else
        (pathVertices+currIndex)->dVC = 0.0f;

    (pathVertices+currIndex)->dVM = (pathVertices+currIndex)->dVC * misVcWeightFactor;

    randomSeed[currIndex] = seed;
    rays[currIndex] = ray;
    rayweights[currIndex] = Y((pathVertices+currIndex)->pathThroughput) > 0.0f ? 1.0f : 0.0f;
}

__kernel
void connectToCamera(__global uint2* restrict randomSeed,
                     __global CLRay* restrict rays,
                     __global float* restrict rayweights,
                     __global const CLVCMPathVertex* restrict pathVertices,
                     __global CLVCMConnectionData* restrict conData,
                     __constant CLVCMCamera* restrict camera,
                     __global const CLVCMMaterial* restrict materials,
                     __global const uchar4* restrict textureSet1,
                     __global const uchar4* restrict textureSet2,
                     const int lightSubPathCount,
                     const float misVmWeightFactor,
                     const int pass,
                         __global float4* restrict color)
{
    // workitem/worksize info
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;

    rayweights[currIndex] = 0.0f;
    (conData + currIndex)->pixel = -1;
    const __global CLVCMPathVertex *pathVertex = (pathVertices+currIndex);
    const int matId = pathVertex->matId;
    __local CLVCMMaterial mat[SHMEMSIZE];
    if(matId != INT_MAX )
    {
       if(CL_SPECULAR & GetMaterialFlags((materials+matId)->type))
            return;
        float4 camPos = camera->pos;
        float lensRadius = camera->lensRadius;
        if(lensRadius > 0.0f)
        {
            uint2 seed = randomSeed[currIndex];
            // Sample point on lens
            float2 uv = cmj(pass, sizeX*sizeY, as_int(rand_float(&seed)), (float)sizeX/sizeY);
            float2 lensUV = sampleLens(uv.x, uv.y,apert_shape);
							//concentricSampleDisk(rand_float(&seed), rand_float(&seed));
            lensUV.x *= lensRadius;
            lensUV.y *= lensRadius;

            const float4 camI = (camera->dirBR - camera->dirBL) / sizeX;
            const float4 camJ = (camera->dirTL - camera->dirBL) / sizeY;
            camPos += camI*lensUV.x + camJ*lensUV.y;
            randomSeed[currIndex] = seed;
        }

        const float4 camForw = camera->forward;
        const float4 hitPosition = pathVertex->hitPosition;

        // Check it projects to the screen (and where)
        float4 directionToCamera = camPos - hitPosition;
        directionToCamera.w = 0.0f;

        // Compute distance and normalize direction to camera
        const float distEye2 = dot(directionToCamera,directionToCamera);
        const float dist = sqrt(distEye2);
        directionToCamera /= dist;

        // Get the BSDF
        float cosToCamera, bsdfDirPdfW, bsdfRevPdfW;
        float4 bsdfFactor;
        {
            const float4 ns = pathVertex->hitNormal;
            mat[get_local_id(0)] = materials[matId];
            bsdfFactor =  EvaluateBSDF(&mat[get_local_id(0)], pathVertex, textureSet1, textureSet2, ns, directionToCamera, &bsdfDirPdfW, &bsdfRevPdfW);
            cosToCamera = dot(ns,directionToCamera);
        }

        //Russian rulett
        //if(pathVertex->pathLength > 4)
            bsdfRevPdfW *= clamp(Y(bsdfFactor),0.5f,1.0f); //RR

        const float cosAtCamera = dot(camForw, -directionToCamera);

        // Compute pdf conversion factor from image plane area to surface area
        const float imagePointToCameraDist = camera->imgPlaneDist / cosAtCamera;
        const float imageToSolidAngleFactor = imagePointToCameraDist * imagePointToCameraDist / cosAtCamera;
        const float imageToSurfaceFactor = imageToSolidAngleFactor * cosToCamera / distEye2;

        // We put the virtual image plane at such a distance from the camera origin
        // that the pixel area is one and thus the image plane sampling pdf is 1.
        // The area pdf of aHitpoint as sampled from the camera is then equal to
        // the conversion factor from image plane area density to surface area density
        const float cameraPdfA = imageToSurfaceFactor;

        // Partial light sub-path weight [tech. rep. (46)]. Note the division by
        // mLightPathCount, which is the number of samples this technique uses.
        // This division also appears a few lines below in the framebuffer accumulation.
        const float wLight = Mis(cameraPdfA / (lightSubPathCount)) * (
            misVmWeightFactor + pathVertex->dVCM + pathVertex->dVC * Mis(bsdfRevPdfW));
        //assert(wLight >= 0.0f);

        // Partial eye sub-path weight is 0 [tech. rep. (47)]

        // Full path MIS weight [tech. rep. (37)]. No MIS for traditional light tracing.
        const float misWeight = 1.0f / (wLight + 1.f);

        const float surfaceToImageFactor = 1.f / imageToSurfaceFactor;

        // We divide the contribution by surfaceToImageFactor to convert the (already
        // divided) pdf from surface area to image plane area, w.r.t. which the
        // pixel integral is actually defined. We also divide by the number of samples
        // this technique makes, which is equal to the number of light sub-paths
        const float4 contrib = misWeight * pathVertex->pathThroughput * bsdfFactor /
            ((float)lightSubPathCount * surfaceToImageFactor);

        int2 pixel;
        {
            const float16 matr = camera->worldToRaster;
            const float4 pos = camPos + (lensRadius > 0.0f ? -directionToCamera*camera->focalDistance / cosAtCamera : -directionToCamera);
            float4 imagePos = MulMat4Vec4(&matr,&pos);
            imagePos /= imagePos.w;
            pixel = (int2)((int)round(imagePos.x),(int)round(imagePos.y));
        }
        const float I = Y(contrib);

        if (I > 0.0f && pixel.x >= 0 && pixel.x < sizeX && pixel.y >= 0 && pixel.y < sizeY && cosAtCamera > 0.0f && cosToCamera > 0.0f)
        {
            CLVCMConnectionData result;
            result.pixel = pixel.x + pixel.y*sizeX;
            result.contrib = contrib;
            result.dist = dist - (float)CL_EPSILON*10.0f;
            CLRay ray;
            ray.org = hitPosition + directionToCamera*CL_EPSILON*10.0f;
            ray.org.w = 1.0f;
            ray.dir = directionToCamera;

            conData[currIndex] = result;
            rays[currIndex] = ray;
            rayweights[currIndex] = 1.0f;
        }
    }
}

__kernel
void finishConnection(__global const CLHitRecord* restrict hitrecs,
                      __global const CLVCMConnectionData* restrict conData,
                      __global float4* restrict colorBuffer)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);

	const int currIndex = idY * sizeX + idX;

    const CLHitRecord currHitRec = hitrecs[currIndex];
    const CLVCMConnectionData result = conData[currIndex];
    if( result.pixel >= 0 && (currHitRec.tHit == FLT_MAX || result.dist <= currHitRec.tHit))
    {
        colorBuffer[result.pixel] += result.contrib;
    }
}

__kernel
void le(__global const CLVCMLight* restrict lights,
        __global const CLVCMPathVertex* restrict pathVertices,
        __global const CLVCMMaterial* restrict materials,
        __global float4* restrict colorBuffer)
{
    // workitem/worksize info
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);

	const int currIndex = idY * sizeX + idX;

    int matId = (pathVertices + currIndex)->matId;
    float4 Le = 0.0f;
    if(matId != INT_MAX)
    {
        CLVCMMaterial mat = materials[matId];
        if(mat.type == CL_LIGHTMAT)
        {
            Le = GetRadiance_AreaLight((lights+mat.light.lightID),(pathVertices + currIndex));
            colorBuffer[currIndex] += Le;
        }
    }
}

__kernel
void uniformSampleLight(__global uint2* restrict randomSeed,
                         __global const CLVCMLight* restrict lights,
                        __global const float4* restrict envMap,
                        __global const float* restrict envLightDistr,
                         float lightCount,
                         __global const CLTriangle* restrict tris,
                         __global const float4* restrict points,
                         __global CLRay* restrict shRays,
                         __global float* restrict shRayweights,
                         __global const CLVCMPathVertex* restrict pathVertices,
                         __global const CLVCMMaterial* restrict materials,
                         __global const uchar4* restrict textureSet1,
                         __global const uchar4* restrict textureSet2,
                         __global float4* restrict colorBuffer,
                         __global CLVCMConnectionData* restrict conData,
                         const float misVmWeightFactor,
						 const int pass)
{
    if(lightCount == 0)
        return;

    // workitem/worksize info
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;

    float4 Ld = 0.0f;
    shRayweights[currIndex] = 0.0f;
    (conData+currIndex)->pixel = -1;
    const int matId = (pathVertices + currIndex)->matId;
    __local CLVCMMaterial mat[SHMEMSIZE];
    if(matId != INT_MAX)
    {
        const __global CLVCMPathVertex *pathVertex = (pathVertices+currIndex);
        if(CL_SPECULAR & GetMaterialFlags((materials+matId)->type))
            return;
        uint2 seed = randomSeed[currIndex];

        const int lightID = (int)(rand_float(&seed) * lightCount);
        float directPdfW, emissionPdfW, cosAtLight;
        CLRay shRay;
        shRay.org = pathVertex->hitPosition;
        float distance = FLT_MAX;
        const CLLightType type = (lights+lightID)->type;
        Ld = Illuminate((lights+lightID), type, points, pass, sizeX*sizeY, &seed, shRay.org, &shRay.dir, &distance, envLightDistr, envMap, &emissionPdfW, &directPdfW, &cosAtLight);
        shRay.org += shRay.dir * CL_EPSILON*20.0f;
        shRay.org.w = 1.0f;

        if (cosAtLight <= 0.0f)
            return;

        {
            const float lightPickProb = 1.0f / lightCount;
            directPdfW = directPdfW * lightPickProb + CL_EPSILON;
            emissionPdfW *= lightPickProb;
        }

        float bsdfDirPdfW = 0.0f;
        float bsdfRevPdfW = 0.0f;
        float cosToLight = 0.0f;
        float4 bsdfFactor = 0.0f;
        {
            const float4 ns = pathVertex->hitNormal;
            mat[get_local_id(0)] = materials[matId];
            bsdfFactor = EvaluateBSDF(&mat[get_local_id(0)], pathVertex, textureSet1, textureSet2,
                                                            ns, shRay.dir, &bsdfDirPdfW, &bsdfRevPdfW);
            cosToLight = fabs(dot(ns,shRay.dir));
        }

        bsdfDirPdfW *= isDeltaLight(type) ? 0.0f : 1.0f;

        //if (pathVertex->pathLength > 4)
        {
            const float prob = clamp(Y(bsdfFactor),0.5f,1.0f); //RR
            bsdfDirPdfW *= prob;
            bsdfRevPdfW *= prob;
        }

        const float wLight = Mis(bsdfDirPdfW / directPdfW);
        const float wCamera = Mis(emissionPdfW * cosToLight / (directPdfW * cosAtLight)) * (
            misVmWeightFactor + pathVertex->dVCM + pathVertex->dVC * Mis(bsdfRevPdfW));

        const float misWeight = 1.f / (wLight + 1.f + wCamera);

        Ld *= bsdfFactor * misWeight / directPdfW;
        const float I = Y(Ld);
        if(I > 0.0f)
        {
            shRayweights[currIndex] = 1.0f;
            shRays[currIndex] = shRay;
            (conData+currIndex)->pixel = currIndex;
            (conData+currIndex)->contrib = Ld*pathVertex->pathThroughput;
            (conData+currIndex)->dist = distance - CL_EPSILON*20.0f;
        }
    }
}

__kernel
void connectVertices(__global uint2* restrict randomSeed,
                                 __global CLRay* restrict crays,
                                 __global float* restrict crayweights,
                                 const __global CLVCMPathVertex* restrict lightVertices,
                                 const __global CLVCMPathVertex* restrict pathVertices,
                                 __global CLVCMConnectionData* restrict conData,
                                 __global const CLVCMMaterial* restrict materials,
                                 __global const uchar4* restrict textureSet1,
                                 __global const uchar4* restrict textureSet2,
                                 float misVmWeightFactor,
                                 __global const int* restrict cellCount,
                                 __global float4* restrict colorBuffer)
{
    // workitem/worksize info
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;

    crayweights[currIndex] = 0.0f;
    (conData + currIndex)->pixel = -1;
    int matId = (pathVertices + currIndex)->matId;
    __local CLVCMMaterial mat[SHMEMSIZE];
    if(matId != INT_MAX)
    {
        uint2 seed = randomSeed[currIndex];
        const uint vertIndex = (uint)currIndex + (seed.x % (uint)(sizeX*sizeY - currIndex));
        rand_float(&seed);

        if((lightVertices + vertIndex)->pathLength > 0
            /*&& ((lightVertices + currIndex)->pathLength + 1 + (pathVertices + currIndex)->pathLength <= CL_MAXBOUNCES)*/)
        {
            if((GetMaterialFlags((materials+matId)->type) & CL_SPECULAR))
                return;

            const __global CLVCMPathVertex *lightVertex = (lightVertices+vertIndex);
            const __global CLVCMPathVertex *cameraVertex = (pathVertices+currIndex);

            const float4 cPos = cameraVertex->hitPosition;
            float4 direction = lightVertex->hitPosition - cPos;
            const float dist2 = dot(direction,direction);
            const float dist = sqrt(dist2);
            direction /= dist;
            if(dist < CL_EPSILON || isnan(dist))
                return;

            // Get the cameravertex BSDF
            float cosCamera, cameraBsdfDirPdfW, cameraBsdfRevPdfW;
            float4 cameraBsdfFactor;
            {
                const float4 ns = cameraVertex->hitNormal;
                mat[get_local_id(0)] = materials[matId];
                cameraBsdfFactor =
                    EvaluateBSDF(/*(materials+matId)*/&mat[get_local_id(0)], cameraVertex, textureSet1, textureSet2, ns, direction,
                    &cameraBsdfDirPdfW, &cameraBsdfRevPdfW);
                    cosCamera = dot(ns, direction);
            }
            if(cosCamera <= 0.0f)
                return;
            //if (cameraVertex->pathLength > 4)
            {
                const float prob = clamp(Y(cameraBsdfFactor),0.5f,1.0f); //RR
                cameraBsdfDirPdfW *= prob; //RR
                cameraBsdfRevPdfW *= prob; //RR
            }

            // Get the lightvertex BSDF
            float cosLight, lightBsdfDirPdfW, lightBsdfRevPdfW;
            float4 lightBsdfFactor;
            {
                const float4 ns = lightVertex->hitNormal;
                mat[get_local_id(0)] = materials[lightVertex->matId];
                lightBsdfFactor =
                    EvaluateBSDF(&mat[get_local_id(0)], lightVertex, textureSet1, textureSet2, ns, -direction,
                    &lightBsdfDirPdfW, &lightBsdfRevPdfW);
                    cosLight = dot(ns, -direction);
            }
            if(cosLight <= 0.0f)
                return;
            //if (lightVertex->pathLength > 4)
            {
                const float prob = clamp(Y(lightBsdfFactor),0.5f,1.0f); //RR
                lightBsdfDirPdfW *= prob;
                lightBsdfRevPdfW *= prob;
            }
            // Compute geometry term
            const float geometryTerm = /*cosLight * cosCamera*/1.0f / dist2;

            // Convert pdfs to area pdf
            const float cameraBsdfDirPdfA = PdfWtoA(cameraBsdfDirPdfW, dist, cosLight);
            const float lightBsdfDirPdfA  = PdfWtoA(lightBsdfDirPdfW,  dist, cosCamera);

            // Partial light sub-path MIS weight [tech. rep. (40)]
            const float wLight = Mis(cameraBsdfDirPdfA) * (
                misVmWeightFactor + lightVertex->dVCM + lightVertex->dVC * Mis(lightBsdfRevPdfW));

            // Partial eye sub-path MIS weight [tech. rep. (41)]
            const float wCamera = Mis(lightBsdfDirPdfA) * (
                misVmWeightFactor + cameraVertex->dVCM + cameraVertex->dVC * Mis(cameraBsdfRevPdfW));

            // Full path MIS weight [tech. rep. (37)]
            const float misWeight = 1.0f / (wLight + 1.0f + wCamera);

            const float4 contrib = lightVertex->pathThroughput * cameraVertex->pathThroughput * (misWeight * geometryTerm) * cameraBsdfFactor * lightBsdfFactor;
            const float I = Y(contrib);
            if(I > 0.0f)
            {
                (crays + currIndex)->org = cPos + direction*CL_EPSILON*20.0f;
                (crays + currIndex)->org.w = 1.0f;
                (crays + currIndex)->dir = direction;
                crayweights[currIndex] = 1.0f;
                (conData+currIndex)->pixel = currIndex;
                (conData+currIndex)->contrib = contrib;
                (conData+currIndex)->dist = dist - CL_EPSILON*20.0f;
            }
        }
        randomSeed[currIndex] = seed;
    }
}

__kernel
void sampleScattering(__global uint2* restrict randomSeed,
                      __global CLRay* restrict rays,
                      __global float* restrict rayweights,
                      __global CLVCMPathVertex* restrict pathVertices,
                      __global const CLVCMMaterial* restrict materials,
                      __global const uchar4* restrict textureSet1,
                      __global const uchar4* restrict textureSet2,
                      const float misVcWeightFactor,
                      const float misVmWeightFactor,
                      const int fromLight,
					  const int pass,
                      __global float4* restrict colorBuffer)
{
    // workitem/worksize info
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
	const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;
    __global CLVCMPathVertex *pathVertex = (pathVertices+currIndex);
    const int matId = pathVertex->matId;
    __local CLVCMMaterial mat[SHMEMSIZE];
    if(matId != INT_MAX)
    {
        uint2 seed = randomSeed[currIndex];
        CLRay newRay;
        float4 f;

        CLBSDFType flags;
        float costOut;
        float bsdfDirPdfW = 0.0f;
        float bsdfRevPdfW = 0.0f;
        bool fl = fromLight == 1;
        mat[get_local_id(0)] = materials[matId];
        const int sample = pass;
        f = SampleBSDF(fl, sample, sizeX*sizeY, &seed, &mat[get_local_id(0)],pathVertex, textureSet1, textureSet2,
                                       &newRay.dir, &flags, &costOut, &bsdfDirPdfW, &bsdfRevPdfW);

        if (Y(f) <= 0.0f || bsdfDirPdfW <= 0.0f)
        {
            rayweights[currIndex] = 0.0f;
            pathVertex->pathLength = -1;
            return;
        }

        // Possibly terminate the path
        //if (pathVertex->pathLength > 4)
        {
            const float continueProbability = clamp(Y(pathVertex->pathThroughput),0.5f,1.0f);
            if (rand_float(&seed) > continueProbability)
            {
                rayweights[currIndex] = 0.0f;
                pathVertex->pathLength = -1;
                return;
            }
            f /= continueProbability;
            bsdfDirPdfW *= continueProbability;
            bsdfRevPdfW *= continueProbability;
        }

        pathVertex->pathThroughput.xyz *= f.xyz /* costOut* / / bsdfDirPdfW*/;

        bool specularBounce = CL_SPECULAR & flags;
        if (specularBounce)
        {
            pathVertex->dVCM = 0.0f;
            pathVertex->dVC *= Mis(costOut);
            pathVertex->dVM *= Mis(costOut);
        }
        else
        {
            // Implements [tech. rep. (34)-(36)] (partially, as noted above)
            const float dVCM = pathVertex->dVCM;
            pathVertex->dVC = Mis(costOut / bsdfDirPdfW) * (
                pathVertex->dVC * Mis(bsdfRevPdfW) +
                dVCM + misVmWeightFactor);

            pathVertex->dVM = Mis(costOut / bsdfDirPdfW) * (
                pathVertex->dVM * Mis(bsdfRevPdfW) +
                dVCM * misVcWeightFactor + 1.f);

            pathVertex->dVCM = Mis(1.f / bsdfDirPdfW);
        }
        // Find next vertex of path
        newRay.org = pathVertex->hitPosition + newRay.dir * CL_EPSILON*10;
        newRay.org.w = 1.0f;

        rayweights[currIndex] = 1.0f;
        rays[currIndex] = newRay;
        randomSeed[currIndex] = seed;
    }
    else
        rayweights[currIndex] = 0.0f;
}

#define FILTER_WIDTH_X 2.0f
#define FILTER_WIDTH_Y 2.0f

float BlackmanHarris1D(float x)
{
	if (x < -1.0f || x > 1.0f)
		return 0.0f;
	x = (x + 1.0f) * 0.5f;
	x *= M_PI_F;
	const float A0 =  0.35875f;
	const float A1 = -0.48829f;
	const float A2 =  0.14128f;
	const float A3 = -0.01168f;
	return A0 + A1 * cos(2.0f * x) + A2 * cos(4.0f * x) + A3 * cos(6.0f * x);
}

// Blackman-Harris Filter
float evalFilter(const float x, const float y)
{
	return BlackmanHarris1D(x * (1.0f / FILTER_WIDTH_X)) *
			BlackmanHarris1D(y *  (1.0f / FILTER_WIDTH_Y));
}

__kernel
void filterImage(__global float4* restrict colorBuffer,
                              __global float2* restrict pixelCoords,
                              __global float* restrict film)
{
	const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);
    const int sizeY = get_global_size(1);

	const int currIndex = idY * sizeX + idX;

    const float2 pixelCoord = pixelCoords[currIndex];
    const uint x = max(0u, min((uint)round(pixelCoord.x), (uint)(sizeX - 1)));
	const uint y = max(0u, min((uint)round(pixelCoord.y), (uint)(sizeY - 1)));
    const uint p = x + y*sizeX;

	const float sx = pixelCoord.x - (float)x;
	const float sy = pixelCoord.y - (float)y;

    float4 c = colorBuffer[p];

	for (int dy = -FILTER_WIDTH_X; dy <= FILTER_WIDTH_X; ++dy)
    {
		for (int dx = -FILTER_WIDTH_Y; dx <= FILTER_WIDTH_Y; ++dx)
        {
            const int xx = x + dx, yy = y + dy;
            if( xx >= 0 && xx < sizeX && yy >= 0 && yy < sizeY )
            {
                const int id = xx + yy*sizeX;
                const float fw = evalFilter(sx-dx, sy-dy);
                float I = Y(c);
                if(!isnan(I) && !isinf(I) && I > 0.0f)
                {
                    //fc += c  * fw;
                    AtomicAdd(film+id*4, c.x*fw);
                    AtomicAdd(film+id*4+1, c.y*fw);
                    AtomicAdd(film+id*4+2, c.z*fw);
                    AtomicAdd(film+id*4+3, fw);
                }
            }
        }
    }
}

inline float4 Uncharted2Tonemap(float4 x)
{
    const float A = 0.15f;
    const float B = 0.50f;
    const float C = 0.10f;
    const float D = 0.20f;
    const float E = 0.02f;
    const float F = 0.30f;
    return ((x*(A*x+C*B)+D*E)/(x*(A*x+B)+D*F))-E/F;
}

__kernel
void updateImage(__global float4* restrict colorBuffer,
                              __global float4* restrict film,
                              __write_only image2d_t image)
{
    const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);

    const int currIndex = idY * sizeX + idX;
    const float scale = 1.0f / film[currIndex].w;
    const float exposureBias = 0.8f;

    float4 color = Uncharted2Tonemap(16.0f*exposureBias*film[currIndex]*scale);
    float4 whiteScale = 1.0f/Uncharted2Tonemap(11.2f);
    color *= whiteScale;
    colorBuffer[currIndex] = 0.0f;

	write_imagef(image, (int2)(idX, idY), clamp(powr(color, 1.0f/2.2f), 0.0f, 1.0f));
    //image[currIndex] = clamp(pow(color, 1.0f/2.2f), 0.0f, 1.0f);
}

__kernel
void resetImage(__global float4* restrict image, __write_only image2d_t film, __global float4* restrict colorBuffer)
{
    const int idX = get_global_id(0);
	const int idY = get_global_id(1);
	const int sizeX = get_global_size(0);

	const int currIndex = idY * sizeX + idX;
    image[currIndex] = colorBuffer[currIndex] = 0.0f;
	write_imagef(film, (int2)(idX, idY), (float4)(0.0f));
}


// buildOptions=-cl-fast-relaxed-math -D SHMEMSIZE=64
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math -D SHMEMSIZE=64" %cfg_path --cl-device=%cl_device 2>&1
