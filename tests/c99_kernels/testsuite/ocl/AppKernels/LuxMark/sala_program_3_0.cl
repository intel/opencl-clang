/***************************************************************************
 *   Copyright (C) 1998-2011 by authors (see AUTHORS.txt )                 *
 *                                                                         *
 *   This file is part of LuxRays.                                         *
 *                                                                         *
 *   LuxRays is free software; you can redistribute it and/or modify       *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   LuxRays is distributed in the hope that it will be useful,            *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 *   LuxRays website: http://www.luxrender.net                             *
 ***************************************************************************/

// List of symbols defined at compile time:
//  PARAM_TASK_COUNT
//  PARAM_IMAGE_WIDTH
//  PARAM_IMAGE_HEIGHT
//  PARAM_RAY_EPSILON
//  PARAM_SEED
//  PARAM_MAX_PATH_DEPTH
//  PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT
//  PARAM_MAX_RR_DEPTH
//  PARAM_MAX_RR_CAP
//  PARAM_HAS_TEXTUREMAPS
//  PARAM_HAS_ALPHA_TEXTUREMAPS
//  PARAM_USE_PIXEL_ATOMICS
//  PARAM_HAS_BUMPMAPS
//  PARAM_ACCEL_BVH or PARAM_ACCEL_QBVH or PARAM_ACCEL_MQBVH

// To enable single material suopport (work around for ATI compiler problems)
//  PARAM_ENABLE_MAT_MATTE
//  PARAM_ENABLE_MAT_AREALIGHT
//  PARAM_ENABLE_MAT_MIRROR
//  PARAM_ENABLE_MAT_GLASS
//  PARAM_ENABLE_MAT_MATTEMIRROR
//  PARAM_ENABLE_MAT_METAL
//  PARAM_ENABLE_MAT_MATTEMETAL
//  PARAM_ENABLE_MAT_ALLOY
//  PARAM_ENABLE_MAT_ARCHGLASS

// (optional)
//  PARAM_DIRECT_LIGHT_SAMPLING
//  PARAM_DL_LIGHT_COUNT

// (optional)
//  PARAM_CAMERA_HAS_DOF

// (optional)
//  PARAM_HAS_INFINITELIGHT

// (optional, requires PARAM_DIRECT_LIGHT_SAMPLING)
//  PARAM_HAS_SUNLIGHT

// (optional)
//  PARAM_HAS_SKYLIGHT

// (optional)
//  PARAM_IMAGE_FILTER_TYPE (0 = No filter, 1 = Box, 2 = Gaussian, 3 = Mitchell, 4 = MitchellSS)
//  PARAM_IMAGE_FILTER_WIDTH_X
//  PARAM_IMAGE_FILTER_WIDTH_Y
// (Box filter)
// (Gaussian filter)
//  PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA
// (Mitchell filter) & (MitchellSS filter)
//  PARAM_IMAGE_FILTER_MITCHELL_B
//  PARAM_IMAGE_FILTER_MITCHELL_C

// (optional)
//  PARAM_SAMPLER_TYPE (0 = Inlined Random, 1 = Random, 2 = Metropolis, 3 = Stratified)
// (Metropolis)
//  PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE
//  PARAM_SAMPLER_METROPOLIS_MAX_CONSECUTIVE_REJECT
//  PARAM_SAMPLER_METROPOLIS_IMAGE_MUTATION_RANGE
//  PARAM_SAMPLER_METROPOLIS_DEBUG_SHOW_SAMPLE_DENSITY
// (Stratified)
//  PARAM_SAMPLER_STRATIFIED_X_SAMPLES
//  PARAM_SAMPLER_STRATIFIED_Y_SAMPLES

// TODO: IDX_BSDF_Z used only if needed

//#define PARAM_SAMPLER_METROPOLIS_DEBUG_SHOW_SAMPLE_DENSITY 1

//#pragma OPENCL EXTENSION cl_amd_printf : enable
#if defined(PARAM_USE_PIXEL_ATOMICS)
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#endif

#if defined(PARAM_HAS_SUNLIGHT) & !defined(PARAM_DIRECT_LIGHT_SAMPLING)
Error: PARAM_HAS_SUNLIGHT requires PARAM_DIRECT_LIGHT_SAMPLING !
#endif

#ifndef M_PI
#define M_PI 3.14159265358979323846f
#endif

#ifndef INV_PI
#define INV_PI  0.31830988618379067154f
#endif

#ifndef INV_TWOPI
#define INV_TWOPI  0.15915494309189533577f
#endif

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

//------------------------------------------------------------------------------
// Types
//------------------------------------------------------------------------------

typedef struct {
	float u, v;
} UV;

typedef struct {
	float r, g, b;
} Spectrum;

typedef struct {
	float x, y, z;
} Point;

typedef struct {
	float x, y, z;
} Vector;

typedef struct {
	uint v0, v1, v2;
} Triangle;

typedef struct {
	Point o;
	Vector d;
	float mint, maxt;
} Ray;

typedef struct {
	float t;
	float b1, b2; // Barycentric coordinates of the hit point
	uint index;
} RayHit;

//------------------------------------------------------------------------------

typedef struct {
	unsigned int s1, s2, s3;
} Seed;

// Indices of Sample.u[] array
#define IDX_SCREEN_X 0
#define IDX_SCREEN_Y 1
#if defined(PARAM_CAMERA_HAS_DOF)
#define IDX_DOF_X 2
#define IDX_DOF_Y 3
#define IDX_BSDF_OFFSET 4
#else
#define IDX_BSDF_OFFSET 2
#endif

// Relative to IDX_BSDF_OFFSET + PathDepth * SAMPLE_SIZE
#if defined(PARAM_HAS_ALPHA_TEXTUREMAPS) && defined(PARAM_DIRECT_LIGHT_SAMPLING)

#define IDX_TEX_ALPHA 0
#define IDX_BSDF_X 1
#define IDX_BSDF_Y 2
#define IDX_BSDF_Z 3
#define IDX_DIRECTLIGHT_X 4
#define IDX_DIRECTLIGHT_Y 5
#define IDX_DIRECTLIGHT_Z 6
#define IDX_RR 7

#define SAMPLE_SIZE 8

#elif defined(PARAM_HAS_ALPHA_TEXTUREMAPS)

#define IDX_TEX_ALPHA 0
#define IDX_BSDF_X 1
#define IDX_BSDF_Y 2
#define IDX_BSDF_Z 3
#define IDX_RR 4

#define SAMPLE_SIZE 5

#elif defined(PARAM_DIRECT_LIGHT_SAMPLING)

#define IDX_BSDF_X 0
#define IDX_BSDF_Y 1
#define IDX_BSDF_Z 2
#define IDX_DIRECTLIGHT_X 3
#define IDX_DIRECTLIGHT_Y 4
#define IDX_DIRECTLIGHT_Z 5
#define IDX_RR 6

#define SAMPLE_SIZE 7

#else

#define IDX_BSDF_X 0
#define IDX_BSDF_Y 1
#define IDX_BSDF_Z 2
#define IDX_RR 3

#define SAMPLE_SIZE 4

#endif

#define TOTAL_U_SIZE (IDX_BSDF_OFFSET + PARAM_MAX_PATH_DEPTH * SAMPLE_SIZE)

typedef struct {
	Spectrum radiance;

#if (PARAM_SAMPLER_TYPE == 0)
	uint pixelIndex;

	// Only IDX_SCREEN_X and IDX_SCREEN_Y need to be saved
	float u[2];
#elif (PARAM_SAMPLER_TYPE == 1)
	uint pixelIndex;

	float u[TOTAL_U_SIZE];
#elif (PARAM_SAMPLER_TYPE == 2)
	float totalI;

	// Using ushort here totally freeze the ATI driver
	uint largeMutationCount, smallMutationCount;
	uint current, proposed, consecutiveRejects;

	float weight;
	Spectrum currentRadiance;

	float u[2][TOTAL_U_SIZE];
#elif (PARAM_SAMPLER_TYPE == 3)
	uint pixelIndex;

	float stratifiedScreen2D[PARAM_SAMPLER_STRATIFIED_X_SAMPLES * PARAM_SAMPLER_STRATIFIED_Y_SAMPLES * 2];
#if defined(PARAM_CAMERA_HAS_DOF)
	float stratifiedDof2D[PARAM_SAMPLER_STRATIFIED_X_SAMPLES * PARAM_SAMPLER_STRATIFIED_Y_SAMPLES * 2];
#endif
#if defined(PARAM_HAS_ALPHA_TEXTUREMAPS)
	float stratifiedAlpha1D[PARAM_SAMPLER_STRATIFIED_X_SAMPLES];
#endif

	float stratifiedBSDF2D[PARAM_SAMPLER_STRATIFIED_X_SAMPLES * PARAM_SAMPLER_STRATIFIED_Y_SAMPLES * 2];
	float stratifiedBSDF1D[PARAM_SAMPLER_STRATIFIED_X_SAMPLES];

#if defined(PARAM_DIRECT_LIGHT_SAMPLING)
	float stratifiedLight2D[PARAM_SAMPLER_STRATIFIED_X_SAMPLES * PARAM_SAMPLER_STRATIFIED_Y_SAMPLES * 2];
	float stratifiedLight1D[PARAM_SAMPLER_STRATIFIED_X_SAMPLES];
#endif

	float u[TOTAL_U_SIZE];
#endif
} Sample;

#define PATH_STATE_GENERATE_EYE_RAY 0
#define PATH_STATE_DONE 1
#define PATH_STATE_NEXT_VERTEX 2
#define PATH_STATE_SAMPLE_LIGHT 3

typedef struct {
	uint state;
	uint depth;
 #if (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
	uint diffuseVertexCount;
#endif
	Spectrum throughput;

#if defined(PARAM_DIRECT_LIGHT_SAMPLING)
	float bouncePdf;
	int specularBounce;

	Ray nextPathRay;
	Spectrum nextThroughput;
	// Radiance to add to the result if light source is visible
	Spectrum lightRadiance;
#endif
} PathState;

// The memory layout of this structure is highly UNoptimized for GPUs !
typedef struct {
	// The task seed
	Seed seed;

	// The set of Samples assigned to this task
	Sample sample;

	// The state used to keep track of the rendered path
	PathState pathState;
} GPUTask;

typedef struct {
	uint sampleCount;
} GPUTaskStats;

typedef struct {
	Spectrum c;
	float count;
} Pixel;

//------------------------------------------------------------------------------

#define MAT_MATTE 0
#define MAT_AREALIGHT 1
#define MAT_MIRROR 2
#define MAT_GLASS 3
#define MAT_MATTEMIRROR 4
#define MAT_METAL 5
#define MAT_MATTEMETAL 6
#define MAT_ALLOY 7
#define MAT_ARCHGLASS 8
#define MAT_NULL 9

typedef struct {
    float r, g, b;
} MatteParam;

typedef struct {
    float gain_r, gain_g, gain_b;
} AreaLightParam;

typedef struct {
    float r, g, b;
    int specularBounce;
} MirrorParam;

typedef struct {
    float refl_r, refl_g, refl_b;
    float refrct_r, refrct_g, refrct_b;
    float ousideIor, ior;
    float R0;
    int reflectionSpecularBounce, transmitionSpecularBounce;
} GlassParam;

typedef struct {
	MatteParam matte;
	MirrorParam mirror;
	float matteFilter, totFilter, mattePdf, mirrorPdf;
} MatteMirrorParam;

typedef struct {
    float r, g, b;
    float exponent;
    int specularBounce;
} MetalParam;

typedef struct {
	MatteParam matte;
	MetalParam metal;
	float matteFilter, totFilter, mattePdf, metalPdf;
} MatteMetalParam;

typedef struct {
    float diff_r, diff_g, diff_b;
    float refl_r, refl_g, refl_b;
    float exponent;
    float R0;
    int specularBounce;
} AlloyParam;

typedef struct {
    float refl_r, refl_g, refl_b;
    float refrct_r, refrct_g, refrct_b;
	float transFilter, totFilter, reflPdf, transPdf;
	bool reflectionSpecularBounce, transmitionSpecularBounce;
} ArchGlassParam;

typedef struct {
	unsigned int type;
	union {
		MatteParam matte;
        AreaLightParam areaLight;
		MirrorParam mirror;
        GlassParam glass;
		MatteMirrorParam matteMirror;
        MetalParam metal;
        MatteMetalParam matteMetal;
        AlloyParam alloy;
        ArchGlassParam archGlass;
	} param;
} Material;

//------------------------------------------------------------------------------

typedef struct {
	Point v0, v1, v2;
	Vector normal;
	float area;
	float gain_r, gain_g, gain_b;
} TriangleLight;

typedef struct {
	float shiftU, shiftV;
	Spectrum gain;
	uint width, height;
} InfiniteLight;

typedef struct {
	Vector sundir;
	Spectrum gain;
	float turbidity;
	float relSize;
	// XY Vectors for cone sampling
	Vector x, y;
	float cosThetaMax;
	Spectrum suncolor;
} SunLight;

typedef struct {
	Spectrum gain;
	float thetaS;
	float phiS;
	float zenith_Y, zenith_x, zenith_y;
	float perez_Y[6], perez_x[6], perez_y[6];
} SkyLight;

//------------------------------------------------------------------------------

typedef struct {
	uint rgbOffset, alphaOffset;
	uint width, height;
} TexMap;

typedef struct {
	uint vertsOffset;
	uint trisOffset;

	float trans[4][4];
	float invTrans[4][4];
} Mesh;

typedef struct {
	float lensRadius;
	float focalDistance;
	float yon, hither;

	float rasterToCameraMatrix[4][4];
	float cameraToWorldMatrix[4][4];
} Camera;
/***************************************************************************
 *   Copyright (C) 1998-2010 by authors (see AUTHORS.txt )                 *
 *                                                                         *
 *   This file is part of LuxRays.                                         *
 *                                                                         *
 *   LuxRays is free software; you can redistribute it and/or modify       *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   LuxRays is distributed in the hope that it will be useful,            *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 *   LuxRays website: http://www.luxrender.net                             *
 ***************************************************************************/

// Line 451

//------------------------------------------------------------------------------
// Random number generator
// maximally equidistributed combined Tausworthe generator
//------------------------------------------------------------------------------

#define FLOATMASK 0x00ffffffu

uint TAUSWORTHE(const uint s, const uint a,
	const uint b, const uint c,
	const uint d) {
	return ((s&c)<<d) ^ (((s << a) ^ s) >> b);
}

uint LCG(const uint x) { return x * 69069; }

uint ValidSeed(const uint x, const uint m) {
	return (x < m) ? (x + m) : x;
}

void InitRandomGenerator(uint seed, Seed *s) {
	// Avoid 0 value
	seed = (seed == 0) ? (seed + 0xffffffu) : seed;

	s->s1 = ValidSeed(LCG(seed), 1);
	s->s2 = ValidSeed(LCG(s->s1), 7);
	s->s3 = ValidSeed(LCG(s->s2), 15);
}

unsigned long RndUintValue(Seed *s) {
	s->s1 = TAUSWORTHE(s->s1, 13, 19, 4294967294UL, 12);
	s->s2 = TAUSWORTHE(s->s2, 2, 25, 4294967288UL, 4);
	s->s3 = TAUSWORTHE(s->s3, 3, 11, 4294967280UL, 17);

	return ((s->s1) ^ (s->s2) ^ (s->s3));
}

float RndFloatValue(Seed *s) {
	return (RndUintValue(s) & FLOATMASK) * (1.f / (FLOATMASK + 1UL));
}

//------------------------------------------------------------------------------

float PowerHeuristic(const uint nf, const float fPdf, const uint ng, const float gPdf) {
	const float f = nf * fPdf;
	const float g = ng * gPdf;

	return (f * f) / (f * f + g * g);
}

float VanDerCorput(uint n, uint scramble) {
	// Reverse bits of n
	n = (n << 16) | (n >> 16);
	n = ((n & 0x00ff00ff) << 8) | ((n & 0xff00ff00) >> 8);
	n = ((n & 0x0f0f0f0f) << 4) | ((n & 0xf0f0f0f0) >> 4);
	n = ((n & 0x33333333) << 2) | ((n & 0xcccccccc) >> 2);
	n = ((n & 0x55555555) << 1) | ((n & 0xaaaaaaaa) >> 1);
	n ^= scramble;

	// 0.9999999403953552f = 1 - epsilon
	return min(((n >> 8) & 0xffffff) / (float)(1 << 24), 0.9999999403953552f);
}

#if defined(PARAM_USE_PIXEL_ATOMICS)
void AtomicAdd(__global float *val, const float delta) {
	union {
		float f;
		unsigned int i;
	} oldVal;
	union {
		float f;
		unsigned int i;
	} newVal;

	do {
		oldVal.f = *val;
		newVal.f = oldVal.f + delta;
	} while (atom_cmpxchg((__global unsigned int *)val, oldVal.i, newVal.i) != oldVal.i);
}
#endif

float Spectrum_Y(const Spectrum *s) {
	return 0.212671f * s->r + 0.715160f * s->g + 0.072169f * s->b;
}

float Dot(const Vector *v0, const Vector *v1) {
	return v0->x * v1->x + v0->y * v1->y + v0->z * v1->z;
}

void Normalize(Vector *v) {
	const float il = 1.f / sqrt(Dot(v, v));

	v->x *= il;
	v->y *= il;
	v->z *= il;
}

void TransformPoint(__global float (*m)[4], Point *v) {
	const float x = v->x;
	const float y = v->y;
	const float z = v->z;

	v->x = m[0][0] * x + m[0][1] * y + m[0][2] * z;
	v->y = m[1][0] * x + m[1][1] * y + m[1][2] * z;
	v->z = m[2][0] * x + m[2][1] * y + m[2][2] * z;

	const float wp = 1.f / (m[3][0] * x + m[3][1] * y + m[3][2] * z + m[3][3]);
	v->x *= wp;
	v->y *= wp;
	v->z *= wp;
}

void TransformVector(__global float (*m)[4], Vector *v) {
	const float x = v->x;
	const float y = v->y;
	const float z = v->z;

	v->x = m[0][0] * x + m[0][1] * y + m[0][2] * z;
	v->y = m[1][0] * x + m[1][1] * y + m[1][2] * z;
	v->z = m[2][0] * x + m[2][1] * y + m[2][2] * z;
}

// Matrix m must be the inverse and transpose of normal transformation
void TransformNormal(__global float (*m)[4], Vector *v) {
	const float x = v->x;
	const float y = v->y;
	const float z = v->z;

	v->x = m[0][0] * x + m[1][0] * y + m[2][0] * z;
	v->y = m[0][1] * x + m[1][1] * y + m[2][1] * z;
	v->z = m[0][2] * x + m[1][2] * y + m[2][2] * z;

	Normalize(v);
}

void Cross(Vector *v3, const Vector *v1, const Vector *v2) {
	v3->x = (v1->y * v2->z) - (v1->z * v2->y);
	v3->y = (v1->z * v2->x) - (v1->x * v2->z),
	v3->z = (v1->x * v2->y) - (v1->y * v2->x);
}

int Mod(int a, int b) {
	if (b == 0)
		b = 1;

	a %= b;
	if (a < 0)
		a += b;

	return a;
}

float Lerp(float t, float v1, float v2) {
	return (1.f - t) * v1 + t * v2;
}

void ConcentricSampleDisk(const float u1, const float u2, float *dx, float *dy) {
	float r, theta;
	// Map uniform random numbers to $[-1,1]^2$
	float sx = 2.f * u1 - 1.f;
	float sy = 2.f * u2 - 1.f;
	// Map square to $(r,	heta)$
	// Handle degeneracy at the origin
	if (sx == 0.f && sy == 0.f) {
		*dx = 0.f;
		*dy = 0.f;
		return;
	}
	if (sx >= -sy) {
		if (sx > sy) {
			// Handle first region of disk
			r = sx;
			if (sy > 0.f)
				theta = sy / r;
			else
				theta = 8.f + sy / r;
		} else {
			// Handle second region of disk
			r = sy;
			theta = 2.f - sx / r;
		}
	} else {
		if (sx <= sy) {
			// Handle third region of disk
			r = -sx;
			theta = 4.f - sy / r;
		} else {
			// Handle fourth region of disk
			r = -sy;
			theta = 6.f + sx / r;
		}
	}
	theta *= M_PI / 4.f;
	*dx = r * cos(theta);
	*dy = r * sin(theta);
}

void CosineSampleHemisphere(Vector *ret, const float u1, const float u2) {
	ConcentricSampleDisk(u1, u2, &ret->x, &ret->y);
	ret->z = sqrt(max(0.f, 1.f - ret->x * ret->x - ret->y * ret->y));
}

void UniformSampleCone(Vector *ret, const float u1, const float u2, const float costhetamax,
	const Vector *x, const Vector *y, const Vector *z) {
	const float costheta = Lerp(u1, costhetamax, 1.f);
	const float sintheta = sqrt(1.f - costheta * costheta);
	const float phi = u2 * 2.f * M_PI;

	const float kx = cos(phi) * sintheta;
	const float ky = sin(phi) * sintheta;
	const float kz = costheta;

	ret->x = kx * x->x + ky * y->x + kz * z->x;
	ret->y = kx * x->y + ky * y->y + kz * z->y;
	ret->z = kx * x->z + ky * y->z + kz * z->z;
}

float UniformConePdf(float costhetamax) {
	return 1.f / (2.f * M_PI * (1.f - costhetamax));
}

void CoordinateSystem(const Vector *v1, Vector *v2, Vector *v3) {
	if (fabs(v1->x) > fabs(v1->y)) {
		float invLen = 1.f / sqrt(v1->x * v1->x + v1->z * v1->z);
		v2->x = -v1->z * invLen;
		v2->y = 0.f;
		v2->z = v1->x * invLen;
	} else {
		float invLen = 1.f / sqrt(v1->y * v1->y + v1->z * v1->z);
		v2->x = 0.f;
		v2->y = v1->z * invLen;
		v2->z = -v1->y * invLen;
	}

	Cross(v3, v1, v2);
}

float SphericalTheta(const Vector *v) {
	return acos(clamp(v->z, -1.f, 1.f));
}

float SphericalPhi(const Vector *v) {
	float p = atan2(v->y, v->x);
	return (p < 0.f) ? p + 2.f * M_PI : p;
}
/***************************************************************************
 *   Copyright (C) 1998-2010 by authors (see AUTHORS.txt )                 *
 *                                                                         *
 *   This file is part of LuxRays.                                         *
 *                                                                         *
 *   LuxRays is free software; you can redistribute it and/or modify       *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   LuxRays is distributed in the hope that it will be useful,            *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 *   LuxRays website: http://www.luxrender.net                             *
 ***************************************************************************/

// Line 451 + 268 = 719

//------------------------------------------------------------------------------
// Pixel related functions
//------------------------------------------------------------------------------

void PixelIndex2XY(const uint index, uint *x, uint *y) {
	*y = index / PARAM_IMAGE_WIDTH;
	*x = index - (*y) * PARAM_IMAGE_WIDTH;
}

uint XY2PixelIndex(const uint x, const uint y) {
	return x + y * PARAM_IMAGE_WIDTH;
}

uint XY2FrameBufferIndex(const int x, const int y) {
	return x + 1 + (y + 1) * (PARAM_IMAGE_WIDTH + 2);
}

uint InitialPixelIndex(const size_t gid) {
	return gid % (PARAM_IMAGE_WIDTH * PARAM_IMAGE_HEIGHT);
}

uint NextPixelIndex(const uint i) {
	return (i + PARAM_TASK_COUNT) % (PARAM_IMAGE_WIDTH * PARAM_IMAGE_HEIGHT);
}

uint PixelIndexFloat(const float u) {
	const uint pixelCountPerTask = PARAM_IMAGE_WIDTH * PARAM_IMAGE_HEIGHT;
	const uint i = min((uint)floor(pixelCountPerTask * u), (uint)(pixelCountPerTask - 1));

	return i;
}

uint PixelIndexFloat2D(const float ux, const float uy) {
	const uint x = min((uint)floor(PARAM_IMAGE_WIDTH * ux), (uint)(PARAM_IMAGE_WIDTH - 1));
	const uint y = min((uint)floor(PARAM_IMAGE_HEIGHT * uy), (uint)(PARAM_IMAGE_HEIGHT - 1));

	return XY2PixelIndex(x, y);
}

uint PixelIndexFloat2DWithOffset(const float ux, const float uy, float *ox, float *oy) {
	const float px = PARAM_IMAGE_WIDTH * ux;
	const float py = PARAM_IMAGE_HEIGHT * uy;

	const uint x = min((uint)floor(px), (uint)(PARAM_IMAGE_WIDTH - 1));
	const uint y = min((uint)floor(py), (uint)(PARAM_IMAGE_HEIGHT - 1));

	*ox = px - (float)x;
	*oy = py - (float)y;

	return XY2PixelIndex(x, y);
}

bool IsValidPixelXY(const int x, const int y) {
	return (x >= 0) && (x < PARAM_IMAGE_WIDTH) && (y >= 0) && (y < PARAM_IMAGE_HEIGHT);
}

//------------------------------------------------------------------------------
// Image filtering related functions
//------------------------------------------------------------------------------

#if (PARAM_IMAGE_FILTER_TYPE == 0)

// Nothing

#elif (PARAM_IMAGE_FILTER_TYPE == 1)

// Box Filter
float ImageFilter_Evaluate(const float x, const float y) {
	return 1.f;
}

#elif (PARAM_IMAGE_FILTER_TYPE == 2)

float Gaussian(const float d, const float expv) {
	return max(0.f, exp(-PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA * d * d) - expv);
}

// Gaussian Filter
float ImageFilter_Evaluate(const float x, const float y) {
	return Gaussian(x,
			exp(-PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA * PARAM_IMAGE_FILTER_WIDTH_X * PARAM_IMAGE_FILTER_WIDTH_X)) *
		Gaussian(y,
			exp(-PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA * PARAM_IMAGE_FILTER_WIDTH_Y * PARAM_IMAGE_FILTER_WIDTH_Y));
}

#elif (PARAM_IMAGE_FILTER_TYPE == 3)

float Mitchell1D(float x) {
	const float B = PARAM_IMAGE_FILTER_MITCHELL_B;
	const float C = PARAM_IMAGE_FILTER_MITCHELL_C;

	if (x >= 1.f)
		return 0.f;
	x = fabs(2.f * x);

	if (x > 1.f)
		return (((-B / 6.f - C) * x + (B + 5.f * C)) * x +
			(-2.f * B - 8.f * C)) * x + (4.f / 3.f * B + 4.f * C);
	else
		return ((2.f - 1.5f * B - C) * x +
			(-3.f + 2.f * B + C)) * x * x +
			(1.f - B / 3.f);
}

// Mitchell Filter
float ImageFilter_Evaluate(const float x, const float y) {
	const float distance = native_sqrt(
			x * x * (1.f / (PARAM_IMAGE_FILTER_WIDTH_X * PARAM_IMAGE_FILTER_WIDTH_X)) +
			y * y * (1.f / (PARAM_IMAGE_FILTER_WIDTH_Y * PARAM_IMAGE_FILTER_WIDTH_Y)));

	return Mitchell1D(distance);
}

#else

Error: unknown image filter !!!

#endif

void Pixel_AddRadiance(__global Pixel *pixel, Spectrum *rad, const float weight) {
	/*if (isnan(rad->r) || isinf(rad->r) ||
			isnan(rad->g) || isinf(rad->g) ||
			isnan(rad->b) || isinf(rad->b) ||
			isnan(weight) || isinf(weight))
		printf("(NaN/Inf. error: (%f, %f, %f) [%f]\n", rad->r, rad->g, rad->b, weight);*/

#if defined(__APPLE_FIX__)

#if defined(PARAM_USE_PIXEL_ATOMICS)
	AtomicAdd(&pixel->c.r, weight * rad->r);
	AtomicAdd(&pixel->c.g, weight * rad->g);
	AtomicAdd(&pixel->c.b, weight * rad->b);
	AtomicAdd(&pixel->count, weight);
#else
	pixel->c.r += weight * rad->r;
	pixel->c.g += weight * rad->g;
	pixel->c.b += weight * rad->b;
	pixel->count += weight;
#endif

#else

	float4 s;
	s.x = rad->r;
	s.y = rad->g;
	s.z = rad->b;
	s.w = 1.f;
	s *= weight;

#if defined(PARAM_USE_PIXEL_ATOMICS)
	AtomicAdd(&pixel->c.r, s.x);
	AtomicAdd(&pixel->c.g, s.y);
	AtomicAdd(&pixel->c.b, s.z);
	AtomicAdd(&pixel->count, s.w);
#else
	float4 p = vload4(0, (__global float *)pixel);
	p += s;
	vstore4(p, 0, (__global float *)pixel);
#endif

#endif
}

#if (PARAM_IMAGE_FILTER_TYPE == 1) || (PARAM_IMAGE_FILTER_TYPE == 2) || (PARAM_IMAGE_FILTER_TYPE == 3)
void Pixel_AddFilteredRadiance(__global Pixel *pixel, Spectrum *rad,
	const float distX, const float distY, const float weight) {
	const float filterWeight = ImageFilter_Evaluate(distX, distY);

	Pixel_AddRadiance(pixel, rad, weight * filterWeight);
}
#endif

#if (PARAM_IMAGE_FILTER_TYPE == 0)

void SplatSample(__global Pixel *frameBuffer, const uint pixelIndex, Spectrum *radiance, const float weight) {
	uint ux, uy;
	PixelIndex2XY(pixelIndex, &ux, &uy);
	int x = (int)ux;
	int y = (int)uy;
	__global Pixel *pixel = &frameBuffer[XY2FrameBufferIndex(x, y)];

	Pixel_AddRadiance(pixel, radiance, weight);
}

#elif (PARAM_IMAGE_FILTER_TYPE == 1) || (PARAM_IMAGE_FILTER_TYPE == 2) || (PARAM_IMAGE_FILTER_TYPE == 3)

void SplatSample(__global Pixel *frameBuffer, const uint pixelIndex, const float sx, const float sy, Spectrum *radiance, const float weight) {
	uint ux, uy;
	PixelIndex2XY(pixelIndex, &ux, &uy);
	int x = (int)ux;
	int y = (int)uy;

	__global Pixel *pixel = &frameBuffer[XY2FrameBufferIndex(x - 1, y - 1)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx + 1.f, sy + 1.f, weight);
	pixel = &frameBuffer[XY2FrameBufferIndex(x, y - 1)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx, sy + 1.f, weight);
	pixel = &frameBuffer[XY2FrameBufferIndex(x + 1, y - 1)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx - 1.f, sy + 1.f, weight);

	pixel = &frameBuffer[XY2FrameBufferIndex(x - 1, y)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx + 1.f, sy, weight);
	pixel = &frameBuffer[XY2FrameBufferIndex(x, y)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx, sy, weight);
	pixel = &frameBuffer[XY2FrameBufferIndex(x + 1, y)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx - 1.f, sy, weight);

	pixel = &frameBuffer[XY2FrameBufferIndex(x - 1, y + 1)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx + 1.f, sy - 1.f, weight);
	pixel = &frameBuffer[XY2FrameBufferIndex(x, y + 1)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx, sy - 1.f, weight);
	pixel = &frameBuffer[XY2FrameBufferIndex(x + 1, y + 1)];
	Pixel_AddFilteredRadiance(pixel, radiance, sx - 1.f, sy - 1.f, weight);
}

#else

Error: unknown image filter !!!

#endif
/***************************************************************************
 *   Copyright (C) 1998-2010 by authors (see AUTHORS.txt )                 *
 *                                                                         *
 *   This file is part of LuxRays.                                         *
 *                                                                         *
 *   LuxRays is free software; you can redistribute it and/or modify       *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   LuxRays is distributed in the hope that it will be useful,            *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 *   LuxRays website: http://www.luxrender.net                             *
 ***************************************************************************/

// Line 451 + 268 + 242 = 961

void TexMap_GetTexel(__global Spectrum *pixels, const uint width, const uint height,
		const int s, const int t, Spectrum *col) {
	const uint u = Mod(s, width);
	const uint v = Mod(t, height);

	const unsigned index = v * width + u;

	col->r = pixels[index].r;
	col->g = pixels[index].g;
	col->b = pixels[index].b;
}

float TexMap_GetAlphaTexel(__global float *alphas, const uint width, const uint height,
		const int s, const int t) {
	const uint u = Mod(s, width);
	const uint v = Mod(t, height);

	const unsigned index = v * width + u;

	return alphas[index];
}

void TexMap_GetColor(__global Spectrum *pixels, const uint width, const uint height,
		const float u, const float v, Spectrum *col) {
	const float s = u * width - 0.5f;
	const float t = v * height - 0.5f;

	const int s0 = (int)floor(s);
	const int t0 = (int)floor(t);

	const float ds = s - s0;
	const float dt = t - t0;

	const float ids = 1.f - ds;
	const float idt = 1.f - dt;

	Spectrum c0, c1, c2, c3;
	TexMap_GetTexel(pixels, width, height, s0, t0, &c0);
	TexMap_GetTexel(pixels, width, height, s0, t0 + 1, &c1);
	TexMap_GetTexel(pixels, width, height, s0 + 1, t0, &c2);
	TexMap_GetTexel(pixels, width, height, s0 + 1, t0 + 1, &c3);

	const float k0 = ids * idt;
	const float k1 = ids * dt;
	const float k2 = ds * idt;
	const float k3 = ds * dt;

	col->r = k0 * c0.r + k1 * c1.r + k2 * c2.r + k3 * c3.r;
	col->g = k0 * c0.g + k1 * c1.g + k2 * c2.g + k3 * c3.g;
	col->b = k0 * c0.b + k1 * c1.b + k2 * c2.b + k3 * c3.b;
}

float TexMap_GetAlpha(__global float *alphas, const uint width, const uint height,
		const float u, const float v) {
	const float s = u * width - 0.5f;
	const float t = v * height - 0.5f;

	const int s0 = (int)floor(s);
	const int t0 = (int)floor(t);

	const float ds = s - s0;
	const float dt = t - t0;

	const float ids = 1.f - ds;
	const float idt = 1.f - dt;

	const float c0 = TexMap_GetAlphaTexel(alphas, width, height, s0, t0);
	const float c1 = TexMap_GetAlphaTexel(alphas, width, height, s0, t0 + 1);
	const float c2 = TexMap_GetAlphaTexel(alphas, width, height, s0 + 1, t0);
	const float c3 = TexMap_GetAlphaTexel(alphas, width, height, s0 + 1, t0 + 1);

	const float k0 = ids * idt;
	const float k1 = ids * dt;
	const float k2 = ds * idt;
	const float k3 = ds * dt;

	return k0 * c0 + k1 * c1 + k2 * c2 + k3 * c3;
}

#if defined(PARAM_HAS_INFINITELIGHT)
void InfiniteLight_Le(__global InfiniteLight *infiniteLight, __global Spectrum *infiniteLightMap, Spectrum *le, const Vector *dir) {
	const float u = 1.f - SphericalPhi(dir) * INV_TWOPI +  infiniteLight->shiftU;
	const float v = SphericalTheta(dir) * INV_PI + infiniteLight->shiftV;

	TexMap_GetColor(infiniteLightMap, infiniteLight->width, infiniteLight->height, u, v, le);

	le->r *= infiniteLight->gain.r;
	le->g *= infiniteLight->gain.g;
	le->b *= infiniteLight->gain.b;
}
#endif

#if defined(PARAM_HAS_SUNLIGHT)
void SunLight_Le(__global SunLight *sunLight, Spectrum *le, const Vector *dir) {
	const float cosThetaMax = sunLight->cosThetaMax;
	Vector sundir = sunLight->sundir;

	if((cosThetaMax < 1.f) && (Dot(dir, &sundir) > cosThetaMax))
		*le = sunLight->suncolor;
	else {
		le->r = 0.f;
		le->g = 0.f;
		le->b = 0.f;
	}
}

void SunLight_Sample_L(__global SunLight *sunLight,
		const Point *hitPoint,
		float *pdf, Spectrum *f, Ray *shadowRay,
		const float u0, const float u1) {
	const float cosThetaMax = sunLight->cosThetaMax;
	const Vector sundir = sunLight->sundir;
	const Vector x = sunLight->x;
	const Vector y = sunLight->y;

	Vector wi;
	UniformSampleCone(&wi, u0, u1, cosThetaMax, &x, &y, &sundir);

	shadowRay->o = *hitPoint;
	shadowRay->d = wi;
	shadowRay->mint = PARAM_RAY_EPSILON;
	shadowRay->maxt = FLT_MAX;

	*f = sunLight->suncolor;

	*pdf = UniformConePdf(cosThetaMax);
}
#endif

#if defined(PARAM_HAS_SKYLIGHT)
float RiAngleBetween(float thetav, float phiv, float theta, float phi) {
	const float cospsi = sin(thetav) * sin(theta) * cos(phi - phiv) + cos(thetav) * cos(theta);
	if (cospsi >= 1.f)
		return 0.f;
	if (cospsi <= -1.f)
		return M_PI;
	return acos(cospsi);
}

float SkyLight_PerezBase(__global float *lam, float theta, float gamma) {
	return (1.f + lam[1] * exp(lam[2] / cos(theta))) *
		(1.f + lam[3] * exp(lam[4] * gamma)  + lam[5] * cos(gamma) * cos(gamma));
}

void SkyLight_ChromaticityToSpectrum(const float Y, const float x, const float y, Spectrum *s) {
	float X, Z;

	if (y != 0.f)
		X = (x / y) * Y;
	else
		X = 0.f;

	if (y != 0.f && Y != 0.f)
		Z = (1.f - x - y) / y * Y;
	else
		Z = 0.f;

	// Assuming sRGB (D65 illuminant)
	s->r =  3.2410f * X - 1.5374f * Y - 0.4986f * Z;
	s->g = -0.9692f * X + 1.8760f * Y + 0.0416f * Z;
	s->b =  0.0556f * X - 0.2040f * Y + 1.0570f * Z;
}

void SkyLight_GetSkySpectralRadiance(__global SkyLight *skyLight,
		const float theta, const float phi, Spectrum *spect) {
	// add bottom half of hemisphere with horizon colour
	const float theta_fin = min(theta, (const float)((M_PI * 0.5f) - 0.001f));
	const float gamma = RiAngleBetween(theta, phi, skyLight->thetaS, skyLight->phiS);

	// Compute xyY values
	const float x = skyLight->zenith_x * SkyLight_PerezBase(skyLight->perez_x, theta_fin, gamma);
	const float y = skyLight->zenith_y * SkyLight_PerezBase(skyLight->perez_y, theta_fin, gamma);
	const float Y = skyLight->zenith_Y * SkyLight_PerezBase(skyLight->perez_Y, theta_fin, gamma);

	SkyLight_ChromaticityToSpectrum(Y, x, y, spect);
}

void SkyLight_Le(__global SkyLight *skyLight, Spectrum *f, const Vector *dir) {
	const float theta = SphericalTheta(dir);
	const float phi = SphericalPhi(dir);

	Spectrum s;
	SkyLight_GetSkySpectralRadiance(skyLight, theta, phi, &s);

	f->r = skyLight->gain.r * s.r;
	f->g = skyLight->gain.g * s.g;
	f->b = skyLight->gain.b * s.b;
}
#endif

void Mesh_InterpolateColor(__global Spectrum *colors, __global Triangle *triangles,
		const uint triIndex, const float b1, const float b2, Spectrum *C) {
	__global Triangle *tri = &triangles[triIndex];

	const float b0 = 1.f - b1 - b2;
	C->r = b0 * colors[tri->v0].r + b1 * colors[tri->v1].r + b2 * colors[tri->v2].r;
	C->g = b0 * colors[tri->v0].g + b1 * colors[tri->v1].g + b2 * colors[tri->v2].g;
	C->b = b0 * colors[tri->v0].b + b1 * colors[tri->v1].b + b2 * colors[tri->v2].b;
}

void Mesh_InterpolateNormal(__global Vector *normals, __global Triangle *triangles,
		const uint triIndex, const float b1, const float b2, Vector *N) {
	__global Triangle *tri = &triangles[triIndex];

	const float b0 = 1.f - b1 - b2;
	N->x = b0 * normals[tri->v0].x + b1 * normals[tri->v1].x + b2 * normals[tri->v2].x;
	N->y = b0 * normals[tri->v0].y + b1 * normals[tri->v1].y + b2 * normals[tri->v2].y;
	N->z = b0 * normals[tri->v0].z + b1 * normals[tri->v1].z + b2 * normals[tri->v2].z;

	Normalize(N);
}

void Mesh_InterpolateUV(__global UV *uvs, __global Triangle *triangles,
		const uint triIndex, const float b1, const float b2, UV *uv) {
	__global Triangle *tri = &triangles[triIndex];

	const float b0 = 1.f - b1 - b2;
	uv->u = b0 * uvs[tri->v0].u + b1 * uvs[tri->v1].u + b2 * uvs[tri->v2].u;
	uv->v = b0 * uvs[tri->v0].v + b1 * uvs[tri->v1].v + b2 * uvs[tri->v2].v;
}

float Mesh_Area(__global Point *verts, __global Triangle *triangles,
		const uint triIndex) {
	__global Triangle *tri = &triangles[triIndex];

	const __global Point *pp0 = &verts[tri->v0];
	const __global Point *pp1 = &verts[tri->v1];
	const __global Point *pp2 = &verts[tri->v2];

	const float4 p0 = (float4)(pp0->x, pp0->y, pp0->z, 0.f);
	const float4 p1 = (float4)(pp1->x, pp1->y, pp1->z, 0.f);
	const float4 p2 = (float4)(pp2->x, pp2->y, pp2->z, 0.f);

	return 0.5f * length(cross(p1 - p0, p2 - p0));
}

float InstanceMesh_Area(__global float (*m)[4], __global Point *verts,
		__global Triangle *triangles, const uint triIndex) {
	__global Triangle *tri = &triangles[triIndex];

	Point pp0 = verts[tri->v0];
	TransformPoint(m, &pp0);
	Point pp1 = verts[tri->v1];
	TransformPoint(m, &pp1);
	Point pp2 = verts[tri->v2];
	TransformPoint(m, &pp2);

	const float4 p0 = (float4)(pp0.x, pp0.y, pp0.z, 0.f);
	const float4 p1 = (float4)(pp1.x, pp1.y, pp1.z, 0.f);
	const float4 p2 = (float4)(pp2.x, pp2.y, pp2.z, 0.f);

	return 0.5f * length(cross(p1 - p0, p2 - p0));
}

//------------------------------------------------------------------------------
// Materials
//------------------------------------------------------------------------------

void Matte_Sample_f(__global MatteParam *mat, const Vector *wo, Vector *wi,
		float *pdf, Spectrum *f, const Vector *shadeN,
		const float u0, const float u1
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
		, int *specularBounce
#endif
		) {
	Vector dir;
	CosineSampleHemisphere(&dir, u0, u1);
	*pdf = dir.z * INV_PI;

	Vector v1, v2;
	CoordinateSystem(shadeN, &v1, &v2);

	wi->x = v1.x * dir.x + v2.x * dir.y + shadeN->x * dir.z;
	wi->y = v1.y * dir.x + v2.y * dir.y + shadeN->y * dir.z;
	wi->z = v1.z * dir.x + v2.z * dir.y + shadeN->z * dir.z;

	// Using 0.0001 instead of 0.0 to cut down fireflies
	if (dir.z <= 0.0001f)
		*pdf = 0.f;
	else {
		f->r = mat->r;
		f->g = mat->g;
		f->b = mat->b;
	}

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
	*specularBounce = FALSE;
#endif
}

void Mirror_Sample_f(__global MirrorParam *mat, const Vector *wo, Vector *wi,
		float *pdf, Spectrum *f, const Vector *shadeN
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
		, int *specularBounce
#endif
		) {
    const float k = 2.f * Dot(shadeN, wo);
	wi->x = k * shadeN->x - wo->x;
	wi->y = k * shadeN->y - wo->y;
	wi->z = k * shadeN->z - wo->z;

	*pdf = 1.f;

	f->r = mat->r;
	f->g = mat->g;
	f->b = mat->b;

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
	*specularBounce = mat->specularBounce;
#endif
}

void Glass_Sample_f(__global GlassParam *mat,
    const Vector *wo, Vector *wi, float *pdf, Spectrum *f, const Vector *N, const Vector *shadeN,
    const float u0
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
		, int *specularBounce
#endif
        ) {
    Vector reflDir;
    const float k = 2.f * Dot(N, wo);
    reflDir.x = k * N->x - wo->x;
    reflDir.y = k * N->y - wo->y;
    reflDir.z = k * N->z - wo->z;

    // Ray from outside going in ?
    const bool into = (Dot(N, shadeN) > 0.f);

    const float nc = mat->ousideIor;
    const float nt = mat->ior;
    const float nnt = into ? (nc / nt) : (nt / nc);
    const float ddn = -Dot(wo, shadeN);
    const float cos2t = 1.f - nnt * nnt * (1.f - ddn * ddn);

    // Total internal reflection
    if (cos2t < 0.f) {
        *wi = reflDir;
        *pdf = 1.f;

        f->r = mat->refl_r;
        f->g = mat->refl_g;
        f->b = mat->refl_b;
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
        *specularBounce = mat->reflectionSpecularBounce;
#endif
    } else {
        const float kk = (into ? 1.f : -1.f) * (ddn * nnt + sqrt(cos2t));
        Vector nkk = *N;
        nkk.x *= kk;
        nkk.y *= kk;
        nkk.z *= kk;

        Vector transDir;
        transDir.x = -nnt * wo->x - nkk.x;
        transDir.y = -nnt * wo->y - nkk.y;
        transDir.z = -nnt * wo->z - nkk.z;
        Normalize(&transDir);

        const float c = 1.f - (into ? -ddn : Dot(&transDir, N));

        const float R0 = mat->R0;
        const float Re = R0 + (1.f - R0) * c * c * c * c * c;
        const float Tr = 1.f - Re;
        const float P = .25f + .5f * Re;

        if (Tr == 0.f) {
            if (Re == 0.f)
                *pdf = 0.f;
            else {
                *wi = reflDir;
                *pdf = 1.f;

                f->r = mat->refl_r;
                f->g = mat->refl_g;
                f->b = mat->refl_b;
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
                *specularBounce = mat->reflectionSpecularBounce;
#endif
            }
        } else if (Re == 0.f) {
            *wi = transDir;
            *pdf = 1.f;

            f->r = mat->refrct_r;
            f->g = mat->refrct_g;
            f->b = mat->refrct_b;
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
            *specularBounce = mat->transmitionSpecularBounce;
#endif
        } else if (u0 < P) {
            *wi = reflDir;
            *pdf = P / Re;

            f->r = mat->refl_r / (*pdf);
            f->g = mat->refl_g / (*pdf);
            f->b = mat->refl_b / (*pdf);
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
            *specularBounce = mat->reflectionSpecularBounce;
#endif
        } else {
            *wi = transDir;
            *pdf = (1.f - P) / Tr;

            f->r = mat->refrct_r / (*pdf);
            f->g = mat->refrct_g / (*pdf);
            f->b = mat->refrct_b / (*pdf);
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
            *specularBounce = mat->transmitionSpecularBounce;
#endif
        }
    }
}

void MatteMirror_Sample_f(__global MatteMirrorParam *mat, const Vector *wo, Vector *wi,
		float *pdf, Spectrum *f, const Vector *shadeN,
		const float u0, const float u1, const float u2
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
		, int *specularBounce
#endif
		) {
    const float totFilter = mat->totFilter;
    const float comp = u2 * totFilter;

	float mpdf;
    if (comp > mat->matteFilter) {
        Mirror_Sample_f(&mat->mirror, wo, wi, pdf, f, shadeN
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
            , specularBounce
#endif
            );
		mpdf = mat->mirrorPdf;
    } else {
        Matte_Sample_f(&mat->matte, wo, wi, pdf, f, shadeN, u0, u1
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
            , specularBounce
#endif
            );
		mpdf = mat->mattePdf;
    }

	*pdf *= mpdf;

	f->r /= mpdf;
	f->g /= mpdf;
	f->b /= mpdf;
}

void GlossyReflection(const Vector *wo, Vector *wi, const float exponent,
		const Vector *shadeN, const float u0, const float u1) {
    const float phi = 2.f * M_PI * u0;
    const float cosTheta = pow(1.f - u1, exponent);
    const float sinTheta = sqrt(1.f - cosTheta * cosTheta);
    const float x = cos(phi) * sinTheta;
    const float y = sin(phi) * sinTheta;
    const float z = cosTheta;

    Vector w;
    const float RdotShadeN = Dot(shadeN, wo);
	w.x = (2.f * RdotShadeN) * shadeN->x - wo->x;
	w.y = (2.f * RdotShadeN) * shadeN->y - wo->y;
	w.z = (2.f * RdotShadeN) * shadeN->z - wo->z;

    Vector u, a;
    if (fabs(shadeN->x) > .1f) {
        a.x = 0.f;
        a.y = 1.f;
    } else {
        a.x = 1.f;
        a.y = 0.f;
    }
    a.z = 0.f;
    Cross(&u, &a, &w);
    Normalize(&u);
    Vector v;
    Cross(&v, &w, &u);

    wi->x = x * u.x + y * v.x + z * w.x;
    wi->y = x * u.y + y * v.y + z * w.y;
    wi->z = x * u.z + y * v.z + z * w.z;
}

void Metal_Sample_f(__global MetalParam *mat, const Vector *wo, Vector *wi,
		float *pdf, Spectrum *f, const Vector *shadeN,
		const float u0, const float u1
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
		, int *specularBounce
#endif
		) {
        GlossyReflection(wo, wi, mat->exponent, shadeN, u0, u1);

		if (Dot(wi, shadeN) > 0.f) {
			*pdf = 1.f;

            f->r = mat->r;
            f->g = mat->g;
            f->b = mat->b;

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
            *specularBounce = mat->specularBounce;
#endif
		} else
			*pdf = 0.f;
}

void MatteMetal_Sample_f(__global MatteMetalParam *mat, const Vector *wo, Vector *wi,
		float *pdf, Spectrum *f, const Vector *shadeN,
		const float u0, const float u1, const float u2
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
		, int *specularBounce
#endif
		) {
	const float totFilter = mat->totFilter;
	const float comp = u2 * totFilter;

	float mpdf;
	if (comp > mat->matteFilter) {
		Metal_Sample_f(&mat->metal, wo, wi, pdf, f, shadeN, u0, u1
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
			, specularBounce
#endif
			);
		mpdf = mat->metalPdf;
	} else {
		Matte_Sample_f(&mat->matte, wo, wi, pdf, f, shadeN, u0, u1
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
			, specularBounce
#endif
			);
		mpdf = mat->mattePdf;
	}

	*pdf *= mpdf;

	f->r /= mpdf;
	f->g /= mpdf;
	f->b /= mpdf;
}

void Alloy_Sample_f(__global AlloyParam *mat, const Vector *wo, Vector *wi,
		float *pdf, Spectrum *f, const Vector *shadeN,
		const float u0, const float u1, const float u2
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
		, int *specularBounce
#endif
		) {
    // Schilick's approximation
    const float c = 1.f - Dot(wo, shadeN);
    const float R0 = mat->R0;
    const float Re = R0 + (1.f - R0) * c * c * c * c * c;

    const float P = .25f + .5f * Re;

    if (u2 <= P) {
        GlossyReflection(wo, wi, mat->exponent, shadeN, u0, u1);
        *pdf = P / Re;

        f->r = mat->refl_r / (*pdf);
        f->g = mat->refl_g / (*pdf);
        f->b = mat->refl_b / (*pdf);

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
        *specularBounce = mat->specularBounce;
#endif
    } else {
        Vector dir;
        CosineSampleHemisphere(&dir, u0, u1);
        *pdf = dir.z * INV_PI;

        Vector v1, v2;
        CoordinateSystem(shadeN, &v1, &v2);

        wi->x = v1.x * dir.x + v2.x * dir.y + shadeN->x * dir.z;
        wi->y = v1.y * dir.x + v2.y * dir.y + shadeN->y * dir.z;
        wi->z = v1.z * dir.x + v2.z * dir.y + shadeN->z * dir.z;

        // Using 0.0001 instead of 0.0 to cut down fireflies
        if (dir.z <= 0.0001f)
            *pdf = 0.f;
        else {
			const float iRe = 1.f - Re;
			const float k = (1.f - P) / iRe;
            *pdf *= k;

            f->r = mat->diff_r / k;
            f->g = mat->diff_g / k;
            f->b = mat->diff_b / k;

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
			*specularBounce = FALSE;
#endif
		}
	}
}

void ArchGlass_Sample_f(__global ArchGlassParam *mat,
    const Vector *wo, Vector *wi, float *pdf, Spectrum *f, const Vector *N, const Vector *shadeN,
    const float u0
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
		, int *specularBounce
#endif
        ) {
    // Ray from outside going in ?
    const bool into = (Dot(N, shadeN) > 0.f);

    if (!into) {
        // No internal reflections
        wi->x = -wo->x;
        wi->y = -wo->y;
        wi->z = -wo->z;
        *pdf = 1.f;

        f->r = mat->refrct_r;
        f->g = mat->refrct_g;
        f->b = mat->refrct_b;

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
        *specularBounce = mat->transmitionSpecularBounce;
#endif
    } else {
        // RR to choose if reflect the ray or go trough the glass
        const float comp = u0 * mat->totFilter;

        if (comp > mat->transFilter) {
            const float k = 2.f * Dot(N, wo);
            wi->x = k * N->x - wo->x;
            wi->y = k * N->y - wo->y;
            wi->z = k * N->z - wo->z;
            *pdf = mat->reflPdf;

            f->r = mat->refl_r / mat->reflPdf;
            f->g = mat->refl_g / mat->reflPdf;
            f->b = mat->refl_b / mat->reflPdf;

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
            *specularBounce = mat->reflectionSpecularBounce;
#endif
        } else {
            wi->x = -wo->x;
            wi->y = -wo->y;
            wi->z = -wo->z;
            *pdf = mat->transPdf;

            f->r = mat->refrct_r / mat->transPdf;
            f->g = mat->refrct_g / mat->transPdf;
            f->b = mat->refrct_b / mat->transPdf;

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
            *specularBounce = mat->transmitionSpecularBounce;
#endif
        }
    }
}

//------------------------------------------------------------------------------
// Lights
//------------------------------------------------------------------------------

#if (PARAM_DL_LIGHT_COUNT > 0)

void AreaLight_Le(__global AreaLightParam *mat, const Vector *wo, const Vector *lightN, Spectrum *Le) {
	const bool brightSide = (Dot(lightN, wo) > 0.f);

	Le->r = brightSide ? mat->gain_r : 0.f;
	Le->g = brightSide ? mat->gain_g : 0.f;
	Le->b = brightSide ? mat->gain_b : 0.f;
}

void SampleTriangleLight(__global TriangleLight *light,	const float u0, const float u1, Point *p) {
	Point v0, v1, v2;
	v0 = light->v0;
	v1 = light->v1;
	v2 = light->v2;

	// UniformSampleTriangle(u0, u1, b0, b1);
	const float su1 = sqrt(u0);
	const float b0 = 1.f - su1;
	const float b1 = u1 * su1;
	const float b2 = 1.f - b0 - b1;

	p->x = b0 * v0.x + b1 * v1.x + b2 * v2.x;
	p->y = b0 * v0.y + b1 * v1.y + b2 * v2.y;
	p->z = b0 * v0.z + b1 * v1.z + b2 * v2.z;
}

void TriangleLight_Sample_L(__global TriangleLight *l,
		const Point *hitPoint,
		float *pdf, Spectrum *f, Ray *shadowRay,
		const float u0, const float u1) {
	Point samplePoint;
	SampleTriangleLight(l, u0, u1, &samplePoint);

	shadowRay->d.x = samplePoint.x - hitPoint->x;
	shadowRay->d.y = samplePoint.y - hitPoint->y;
	shadowRay->d.z = samplePoint.z - hitPoint->z;
	const float distanceSquared = Dot(&shadowRay->d, &shadowRay->d);
	const float distance = sqrt(distanceSquared);
	const float invDistance = 1.f / distance;
	shadowRay->d.x *= invDistance;
	shadowRay->d.y *= invDistance;
	shadowRay->d.z *= invDistance;

	Vector sampleN = l->normal;
	const float sampleNdotMinusWi = -Dot(&sampleN, &shadowRay->d);
	if (sampleNdotMinusWi <= 0.f)
		*pdf = 0.f;
	else {
		*pdf = distanceSquared / (sampleNdotMinusWi * l->area);

		// Using 0.1 instead of 0.0 to cut down fireflies
		if (*pdf <= 0.1f)
			*pdf = 0.f;
		else {
			shadowRay->o = *hitPoint;
			shadowRay->mint = PARAM_RAY_EPSILON;
			shadowRay->maxt = distance - PARAM_RAY_EPSILON;

			f->r = l->gain_r;
			f->g = l->gain_g;
			f->b = l->gain_b;
		}
	}
}

#endif

//------------------------------------------------------------------------------
// GenerateCameraRay
//------------------------------------------------------------------------------

void GenerateCameraRay(
		__global Sample *sample,
		__global Ray *ray
#if (PARAM_SAMPLER_TYPE == 0)
		, Seed *seed
#endif
		, __global Camera *camera) {
#if (PARAM_SAMPLER_TYPE == 0) || (PARAM_SAMPLER_TYPE == 1) || (PARAM_SAMPLER_TYPE == 3)
	__global float *sampleData = &sample->u[0];
	const uint pixelIndex = sample->pixelIndex;

	const float scrSampleX = sampleData[IDX_SCREEN_X];
	const float scrSampleY = sampleData[IDX_SCREEN_Y];

	const float screenX = pixelIndex % PARAM_IMAGE_WIDTH + scrSampleX - .5f;
	const float screenY = pixelIndex / PARAM_IMAGE_WIDTH + scrSampleY - .5f;
#elif (PARAM_SAMPLER_TYPE == 2)
	__global float *sampleData = &sample->u[sample->proposed][0];
	const float screenX = min(sampleData[IDX_SCREEN_X] * PARAM_IMAGE_WIDTH, (float)(PARAM_IMAGE_WIDTH - 1));
	const float screenY = min(sampleData[IDX_SCREEN_Y] * PARAM_IMAGE_HEIGHT, (float)(PARAM_IMAGE_HEIGHT - 1));
#endif

	Point Pras;
	Pras.x = screenX;
	Pras.y = PARAM_IMAGE_HEIGHT - screenY - 1.f;
	Pras.z = 0;

	Point orig;
	// RasterToCamera(Pras, &orig);

	const float iw = 1.f / (camera->rasterToCameraMatrix[3][0] * Pras.x + camera->rasterToCameraMatrix[3][1] * Pras.y + camera->rasterToCameraMatrix[3][2] * Pras.z + camera->rasterToCameraMatrix[3][3]);
	orig.x = (camera->rasterToCameraMatrix[0][0] * Pras.x + camera->rasterToCameraMatrix[0][1] * Pras.y + camera->rasterToCameraMatrix[0][2] * Pras.z + camera->rasterToCameraMatrix[0][3]) * iw;
	orig.y = (camera->rasterToCameraMatrix[1][0] * Pras.x + camera->rasterToCameraMatrix[1][1] * Pras.y + camera->rasterToCameraMatrix[1][2] * Pras.z + camera->rasterToCameraMatrix[1][3]) * iw;
	orig.z = (camera->rasterToCameraMatrix[2][0] * Pras.x + camera->rasterToCameraMatrix[2][1] * Pras.y + camera->rasterToCameraMatrix[2][2] * Pras.z + camera->rasterToCameraMatrix[2][3]) * iw;

	Vector dir;
	dir.x = orig.x;
	dir.y = orig.y;
	dir.z = orig.z;

	const float hither = camera->hither;

#if defined(PARAM_CAMERA_HAS_DOF)

#if (PARAM_SAMPLER_TYPE == 0)
	const float dofSampleX = RndFloatValue(seed);
	const float dofSampleY = RndFloatValue(seed);
#elif (PARAM_SAMPLER_TYPE == 1) || (PARAM_SAMPLER_TYPE == 2) || (PARAM_SAMPLER_TYPE == 3)
	const float dofSampleX = sampleData[IDX_DOF_X];
	const float dofSampleY = sampleData[IDX_DOF_Y];
#endif

	// Sample point on lens
	float lensU, lensV;
	ConcentricSampleDisk(dofSampleX, dofSampleY, &lensU, &lensV);
	const float lensRadius = camera->lensRadius;
	lensU *= lensRadius;
	lensV *= lensRadius;

	// Compute point on plane of focus
	const float focalDistance = camera->focalDistance;
	const float dist = focalDistance - hither;
	const float ft = dist / dir.z;
	Point Pfocus;
	Pfocus.x = orig.x + dir.x * ft;
	Pfocus.y = orig.y + dir.y * ft;
	Pfocus.z = orig.z + dir.z * ft;

	// Update ray for effect of lens
	const float k = dist / focalDistance;
	orig.x += lensU * k;
	orig.y += lensV * k;

	dir.x = Pfocus.x - orig.x;
	dir.y = Pfocus.y - orig.y;
	dir.z = Pfocus.z - orig.z;
#endif

	Normalize(&dir);

	// CameraToWorld(*ray, ray);
	Point torig;
	const float iw2 = 1.f / (camera->cameraToWorldMatrix[3][0] * orig.x + camera->cameraToWorldMatrix[3][1] * orig.y + camera->cameraToWorldMatrix[3][2] * orig.z + camera->cameraToWorldMatrix[3][3]);
	torig.x = (camera->cameraToWorldMatrix[0][0] * orig.x + camera->cameraToWorldMatrix[0][1] * orig.y + camera->cameraToWorldMatrix[0][2] * orig.z + camera->cameraToWorldMatrix[0][3]) * iw2;
	torig.y = (camera->cameraToWorldMatrix[1][0] * orig.x + camera->cameraToWorldMatrix[1][1] * orig.y + camera->cameraToWorldMatrix[1][2] * orig.z + camera->cameraToWorldMatrix[1][3]) * iw2;
	torig.z = (camera->cameraToWorldMatrix[2][0] * orig.x + camera->cameraToWorldMatrix[2][1] * orig.y + camera->cameraToWorldMatrix[2][2] * orig.z + camera->cameraToWorldMatrix[2][3]) * iw2;

	Vector tdir;
	tdir.x = camera->cameraToWorldMatrix[0][0] * dir.x + camera->cameraToWorldMatrix[0][1] * dir.y + camera->cameraToWorldMatrix[0][2] * dir.z;
	tdir.y = camera->cameraToWorldMatrix[1][0] * dir.x + camera->cameraToWorldMatrix[1][1] * dir.y + camera->cameraToWorldMatrix[1][2] * dir.z;
	tdir.z = camera->cameraToWorldMatrix[2][0] * dir.x + camera->cameraToWorldMatrix[2][1] * dir.y + camera->cameraToWorldMatrix[2][2] * dir.z;

	ray->o = torig;
	ray->d = tdir;
	ray->mint = PARAM_RAY_EPSILON;
	ray->maxt = (camera->yon - hither) / dir.z;

	/*printf("(%f, %f, %f) (%f, %f, %f) [%f, %f]\n",
		ray->o.x, ray->o.y, ray->o.z, ray->d.x, ray->d.y, ray->d.z,
		ray->mint, ray->maxt);*/
}
/***************************************************************************
 *   Copyright (C) 1998-2010 by authors (see AUTHORS.txt )                 *
 *                                                                         *
 *   This file is part of LuxRays.                                         *
 *                                                                         *
 *   LuxRays is free software; you can redistribute it and/or modify       *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   LuxRays is distributed in the hope that it will be useful,            *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 *   LuxRays website: http://www.luxrender.net                             *
 ***************************************************************************/

// Line 451 + 268 + 242 + 854 = 1815

void GenerateCameraPath(
		__global GPUTask *task,
		__global Ray *ray,
		Seed *seed,
		__global Camera *camera
		) {
	__global Sample *sample = &task->sample;

	GenerateCameraRay(sample, ray
#if (PARAM_SAMPLER_TYPE == 0)
			, seed
#endif
			, camera);

	sample->radiance.r = 0.f;
	sample->radiance.g = 0.f;
	sample->radiance.b = 0.f;

	// Initialize the path state
	task->pathState.depth = 0;
#if (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
	task->pathState.diffuseVertexCount = 0;
#endif
	task->pathState.throughput.r = 1.f;
	task->pathState.throughput.g = 1.f;
	task->pathState.throughput.b = 1.f;
#if defined(PARAM_DIRECT_LIGHT_SAMPLING)
	task->pathState.bouncePdf = 1.f;
	task->pathState.specularBounce = TRUE;
#endif
	task->pathState.state = PATH_STATE_NEXT_VERTEX;
}

//------------------------------------------------------------------------------
// Inlined Random Sampler Kernel
//------------------------------------------------------------------------------

#if (PARAM_SAMPLER_TYPE == 0)

void Sampler_Init(const size_t gid, Seed *seed, __global Sample *sample) {
#if (PARAM_IMAGE_FILTER_TYPE == 0)
	sample->pixelIndex = InitialPixelIndex(gid);
#else
	// To avoid patterns when not using atomics
	sample->pixelIndex = PixelIndexFloat2D(RndFloatValue(seed), RndFloatValue(seed));
#endif

	sample->u[IDX_SCREEN_X] = RndFloatValue(seed);
	sample->u[IDX_SCREEN_Y] = RndFloatValue(seed);
}

__kernel void Sampler(
		__global GPUTask *tasks,
		__global GPUTaskStats *taskStats,
		__global Ray *rays,
		__global Camera *camera
		) {
	const size_t gid = get_global_id(0);

	// Initialize the task
	__global GPUTask *task = &tasks[gid];

	if (task->pathState.state == PATH_STATE_DONE) {
		__global Sample *sample = &task->sample;

		// Read the seed
		Seed seed;
		seed.s1 = task->seed.s1;
		seed.s2 = task->seed.s2;
		seed.s3 = task->seed.s3;

		// Move to the next assigned pixel
		sample->pixelIndex = NextPixelIndex(sample->pixelIndex);

		sample->u[IDX_SCREEN_X] = RndFloatValue(&seed);
		sample->u[IDX_SCREEN_Y] = RndFloatValue(&seed);

		taskStats[gid].sampleCount += 1;

		GenerateCameraPath(task, &rays[gid], &seed, camera);

		// Save the seed
		task->seed.s1 = seed.s1;
		task->seed.s2 = seed.s2;
		task->seed.s3 = seed.s3;
	}
}

#endif

//------------------------------------------------------------------------------
// Random Sampler Kernel
//------------------------------------------------------------------------------

#if (PARAM_SAMPLER_TYPE == 1)

void Sampler_Init(const size_t gid, Seed *seed, __global Sample *sample) {
#if (PARAM_IMAGE_FILTER_TYPE == 0)
	sample->pixelIndex = InitialPixelIndex(gid);
#else
	// To avoid patterns when not using atomics
	sample->pixelIndex = PixelIndexFloat2D(RndFloatValue(seed), RndFloatValue(seed));
#endif

	for (int i = 0; i < TOTAL_U_SIZE; ++i)
		sample->u[i] = RndFloatValue(seed);
}

__kernel void Sampler(
		__global GPUTask *tasks,
		__global GPUTaskStats *taskStats,
		__global Ray *rays,
		__global Camera *camera) {
	const size_t gid = get_global_id(0);

	// Initialize the task
	__global GPUTask *task = &tasks[gid];

	if (task->pathState.state == PATH_STATE_DONE) {
		__global Sample *sample = &task->sample;

		// Read the seed
		Seed seed;
		seed.s1 = task->seed.s1;
		seed.s2 = task->seed.s2;
		seed.s3 = task->seed.s3;

		// Move to the next assigned pixel
		sample->pixelIndex = NextPixelIndex(sample->pixelIndex);

		for (int i = 0; i < TOTAL_U_SIZE; ++i)
			sample->u[i] = RndFloatValue(&seed);

		GenerateCameraPath(task, &rays[gid], &seed, camera);

		taskStats[gid].sampleCount += 1;

		// Save the seed
		task->seed.s1 = seed.s1;
		task->seed.s2 = seed.s2;
		task->seed.s3 = seed.s3;
	}
}

#endif

//------------------------------------------------------------------------------
// Metropolis Sampler Kernel
//------------------------------------------------------------------------------

#if (PARAM_SAMPLER_TYPE == 2)

void LargeStep(Seed *seed, const uint largeStepCount, __global float *proposedU) {
	for (int i = 0; i < TOTAL_U_SIZE; ++i)
		proposedU[i] = RndFloatValue(seed);
}

float Mutate(Seed *seed, const float x) {
	const float s1 = 1.f / 512.f;
	const float s2 = 1.f / 16.f;

	const float randomValue = RndFloatValue(seed);

	const float dx = s1 / (s1 / s2 + fabs(2.f * randomValue - 1.f)) -
		s1 / (s1 / s2 + 1.f);

	float mutatedX = x;
	if (randomValue < 0.5f) {
		mutatedX += dx;
		mutatedX = (mutatedX < 1.f) ? mutatedX : (mutatedX - 1.f);
	} else {
		mutatedX -= dx;
		mutatedX = (mutatedX < 0.f) ? (mutatedX + 1.f) : mutatedX;
	}

	return mutatedX;
}

float MutateScaled(Seed *seed, const float x, const float range) {
	const float s1 = 32.f;

	const float randomValue = RndFloatValue(seed);

	const float dx = range / (s1 / (1.f + s1) + (s1 * s1) / (1.f + s1) *
		fabs(2.f * randomValue - 1.f)) - range / s1;

	float mutatedX = x;
	if (randomValue < 0.5f) {
		mutatedX += dx;
		mutatedX = (mutatedX < 1.f) ? mutatedX : (mutatedX - 1.f);
	} else {
		mutatedX -= dx;
		mutatedX = (mutatedX < 0.f) ? (mutatedX + 1.f) : mutatedX;
	}

	return mutatedX;
}

void SmallStep(Seed *seed, __global float *currentU, __global float *proposedU) {
	proposedU[IDX_SCREEN_X] = MutateScaled(seed, currentU[IDX_SCREEN_X],
			PARAM_SAMPLER_METROPOLIS_IMAGE_MUTATION_RANGE);
	proposedU[IDX_SCREEN_Y] = MutateScaled(seed, currentU[IDX_SCREEN_Y],
			PARAM_SAMPLER_METROPOLIS_IMAGE_MUTATION_RANGE);

	for (int i = IDX_SCREEN_Y + 1; i < TOTAL_U_SIZE; ++i)
		proposedU[i] = Mutate(seed, currentU[i]);
}

void Sampler_Init(const size_t gid, Seed *seed, __global Sample *sample) {
	sample->totalI = 0.f;
	sample->largeMutationCount = 0.f;

	sample->current = 0xffffffffu;
	sample->proposed = 1;

	sample->smallMutationCount = 0;
	sample->consecutiveRejects = 0;

	sample->weight = 0.f;
	sample->currentRadiance.r = 0.f;
	sample->currentRadiance.g = 0.f;
	sample->currentRadiance.b = 0.f;

	LargeStep(seed, 0, &sample->u[1][0]);
}

__kernel void Sampler(
		__global GPUTask *tasks,
		__global GPUTaskStats *taskStats,
		__global Ray *rays,
		__global Camera *camera) {
	const size_t gid = get_global_id(0);

	// Initialize the task
	__global GPUTask *task = &tasks[gid];

	__global Sample *sample = &task->sample;
	const uint current = sample->current;

	// Check if it is a complete path and not the very first sample
	if ((current != 0xffffffffu) && (task->pathState.state == PATH_STATE_DONE)) {
		// Read the seed
		Seed seed;
		seed.s1 = task->seed.s1;
		seed.s2 = task->seed.s2;
		seed.s3 = task->seed.s3;

		const uint proposed = sample->proposed;
		__global float *proposedU = &sample->u[proposed][0];

		if (RndFloatValue(&seed) < PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE) {
			LargeStep(&seed, sample->largeMutationCount, proposedU);
			sample->smallMutationCount = 0;
		} else {
			__global float *currentU = &sample->u[current][0];

			SmallStep(&seed, currentU, proposedU);
			sample->smallMutationCount += 1;
		}

		taskStats[gid].sampleCount += 1;

		GenerateCameraPath(task, &rays[gid], &seed, camera);

		// Save the seed
		task->seed.s1 = seed.s1;
		task->seed.s2 = seed.s2;
		task->seed.s3 = seed.s3;
	}
}

void Sampler_MLT_SplatSample(__global Pixel *frameBuffer, Seed *seed, __global Sample *sample) {
	uint current = sample->current;
	uint proposed = sample->proposed;

	Spectrum radiance = sample->radiance;

	if (current == 0xffffffffu) {
		// It is the very first sample, I have still to initialize the current
		// sample

		sample->currentRadiance = radiance;
		sample->totalI = Spectrum_Y(&radiance);

		// The following 2 lines could be moved in the initialization code
		sample->largeMutationCount = 1;
		sample->weight = 0.f;

		current = proposed;
		proposed ^= 1;
	} else {
		const Spectrum currentL = sample->currentRadiance;
		const float currentI = Spectrum_Y(&currentL);

		const Spectrum proposedL = radiance;
		float proposedI = Spectrum_Y(&proposedL);
		proposedI = isinf(proposedI) ? 0.f : proposedI;

		float totalI = sample->totalI;
		uint largeMutationCount = sample->largeMutationCount;
		uint smallMutationCount = sample->smallMutationCount;
		if (smallMutationCount == 0) {
			// It is a large mutation
			totalI += Spectrum_Y(&proposedL);
			largeMutationCount += 1;

			sample->totalI = totalI;
			sample->largeMutationCount = largeMutationCount;
		}

		const float meanI = (totalI > 0.f) ? (totalI / largeMutationCount) : 1.f;

		// Calculate accept probability from old and new image sample
		uint consecutiveRejects = sample->consecutiveRejects;

		float accProb;
		if ((currentI > 0.f) && (consecutiveRejects < PARAM_SAMPLER_METROPOLIS_MAX_CONSECUTIVE_REJECT))
			accProb = min(1.f, proposedI / currentI);
		else
			accProb = 1.f;

		const float newWeight = accProb + ((smallMutationCount == 0) ? 1.f : 0.f);
		float weight = sample->weight;
		weight += 1.f - accProb;

		const float rndVal = RndFloatValue(seed);

		/*if (get_global_id(0) == 0)
			printf("[%d] Current: (%f, %f, %f) [%f] Proposed: (%f, %f, %f) [%f] accProb: %f <%f>\n",
					smallMutationCount,
					currentL.r, currentL.g, currentL.b, weight,
					proposedL.r, proposedL.g, proposedL.b, newWeight,
					accProb, rndVal);*/

		Spectrum contrib;
		float norm;
		float scrX, scrY;

		if ((accProb == 1.f) || (rndVal < accProb)) {
			/*if (get_global_id(0) == 0)
				printf("\t\tACCEPTED !\n");*/

			// Add accumulated contribution of previous reference sample
			norm = weight / (currentI / meanI + PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE);
			contrib = currentL;

			scrX = sample->u[current][IDX_SCREEN_X];
			scrY = sample->u[current][IDX_SCREEN_Y];

#if defined(PARAM_SAMPLER_METROPOLIS_DEBUG_SHOW_SAMPLE_DENSITY)
			// Debug code: to check sample distribution
			contrib.r = contrib.g = contrib.b = (consecutiveRejects + 1.f)  * .01f;
			const uint pixelIndex = PPixelIndexFloat2D(scrX, scrY);
			SplatSample(frameBuffer, pixelIndex, &contrib, 1.f);
#endif

			current ^= 1;
			proposed ^= 1;
			consecutiveRejects = 0;

			weight = newWeight;

			sample->currentRadiance = proposedL;
		} else {
			/*if (get_global_id(0) == 0)
				printf("\t\tREJECTED !\n");*/

			// Add contribution of new sample before rejecting it
			norm = newWeight / (proposedI / meanI + PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE);
			contrib = proposedL;

			scrX = sample->u[proposed][IDX_SCREEN_X];
			scrY = sample->u[proposed][IDX_SCREEN_Y];

			++consecutiveRejects;

#if defined(PARAM_SAMPLER_METROPOLIS_DEBUG_SHOW_SAMPLE_DENSITY)
			// Debug code: to check sample distribution
			contrib.r = contrib.g = contrib.b = 1.f * .01f;
			const uint pixelIndex = PixelIndexFloat2D(scrX, scrY);
			SplatSample(frameBuffer, pixelIndex, &contrib, 1.f);
#endif
		}

#if !defined(PARAM_SAMPLER_METROPOLIS_DEBUG_SHOW_SAMPLE_DENSITY)
		if (norm > 0.f) {
			/*if (get_global_id(0) == 0)
				printf("\t\tPixelIndex: %d Contrib: (%f, %f, %f) [%f] consecutiveRejects: %d\n",
						pixelIndex, contrib.r, contrib.g, contrib.b, norm, consecutiveRejects);*/

#if (PARAM_IMAGE_FILTER_TYPE == 0)
			const uint pixelIndex = PixelIndexFloat2D(scrX, scrY);
			SplatSample(frameBuffer, pixelIndex, &contrib, norm);
#else
			float sx, sy;
			const uint pixelIndex = PixelIndexFloat2DWithOffset(scrX, scrY, &sx, &sy);
			SplatSample(frameBuffer, pixelIndex, sx, sy, &contrib, norm);
#endif
		}
#endif

		sample->weight = weight;
		sample->consecutiveRejects = consecutiveRejects;
	}

	sample->current = current;
	sample->proposed = proposed;
}

#endif

//------------------------------------------------------------------------------
// Stratified Sampler Kernel
//------------------------------------------------------------------------------

#if (PARAM_SAMPLER_TYPE == 3)

void StratifiedSample1D(__local float *buff, Seed *seed) {
	const float dx = 1.f / PARAM_SAMPLER_STRATIFIED_X_SAMPLES;

	for (uint x = 0; x < PARAM_SAMPLER_STRATIFIED_X_SAMPLES; ++x) {
		*buff++ = (x + RndFloatValue(seed)) * dx;
	}
}

void Shuffle1D(__local float *buff, Seed *seed) {
	const uint count = PARAM_SAMPLER_STRATIFIED_X_SAMPLES;

	for (uint i = 0; i < count; ++i) {
		const uint other = RndUintValue(seed) % (count - i);

		const float u0 = buff[other];
		buff[other] = buff[i];
		buff[i] = u0;
	}
}

void StratifiedSample2D(__local float *buff, Seed *seed) {
	const float dx = 1.f / PARAM_SAMPLER_STRATIFIED_X_SAMPLES;
	const float dy = 1.f / PARAM_SAMPLER_STRATIFIED_Y_SAMPLES;

	for (uint y = 0; y < PARAM_SAMPLER_STRATIFIED_Y_SAMPLES; ++y) {
		for (uint x = 0; x < PARAM_SAMPLER_STRATIFIED_X_SAMPLES; ++x) {
			*buff++ = (x + RndFloatValue(seed)) * dx;
			*buff++ = (y + RndFloatValue(seed)) * dy;
		}
	}
}

void Shuffle2D(__local float *buff, Seed *seed) {
	const uint count = PARAM_SAMPLER_STRATIFIED_X_SAMPLES *  PARAM_SAMPLER_STRATIFIED_Y_SAMPLES;

	for (uint i = 0; i < count; ++i) {
		const uint other = RndUintValue(seed) % (count - i);

		uint otherIdx = 2 * other;
		uint iIdx = 2 * i;

		const float u0 = buff[otherIdx];
		buff[otherIdx] = buff[iIdx];
		buff[iIdx] = u0;

		++otherIdx;
		++iIdx;
		const float u1 = buff[otherIdx];
		buff[otherIdx] = buff[iIdx];
		buff[iIdx] = u1;
	}
}

void Copy2D(__local float *src, __global float *dest) {
	for (uint i = 0; i < PARAM_SAMPLER_STRATIFIED_X_SAMPLES *  PARAM_SAMPLER_STRATIFIED_Y_SAMPLES; ++i) {
		*dest++ = *src++;
		*dest++ = *src++;
	}
}

void Copy1D(__local float *src, __global float *dest) {
	for (uint i = 0; i < PARAM_SAMPLER_STRATIFIED_X_SAMPLES *  PARAM_SAMPLER_STRATIFIED_Y_SAMPLES; ++i)
		*dest++ = *src++;
}

void Sampler_StratifiedBufferInit(__local float *localMemTempBuff,
		Seed *seed, __global Sample *sample) {
	__local float *tempBuff = &localMemTempBuff[get_local_id(0) * PARAM_SAMPLER_STRATIFIED_X_SAMPLES * PARAM_SAMPLER_STRATIFIED_Y_SAMPLES * 2];

	StratifiedSample2D(tempBuff, seed);
	Copy2D(tempBuff, &sample->stratifiedScreen2D[0]);

#if defined(PARAM_CAMERA_HAS_DOF)
	StratifiedSample2D(tempBuff, seed);
	Shuffle2D(tempBuff, seed);
	Copy2D(tempBuff, &sample->stratifiedDof2D[0]);
#endif

#if defined(PARAM_HAS_ALPHA_TEXTUREMAPS)
	StratifiedSample1D(tempBuff, seed);
	Shuffle1D(tempBuff, seed);
	Copy1D(tempBuff, &sample->stratifiedAlpha1D[0]);
#endif

	StratifiedSample2D(tempBuff, seed);
	Shuffle2D(tempBuff, seed);
	Copy2D(tempBuff, &sample->stratifiedBSDF2D[0]);

	StratifiedSample1D(tempBuff, seed);
	Shuffle1D(tempBuff, seed);
	Copy1D(tempBuff, &sample->stratifiedBSDF1D[0]);

#if defined(PARAM_DIRECT_LIGHT_SAMPLING)
	StratifiedSample2D(tempBuff, seed);
	Shuffle2D(tempBuff, seed);
	Copy2D(tempBuff, &sample->stratifiedLight2D[0]);

	StratifiedSample1D(tempBuff, seed);
	Shuffle1D(tempBuff, seed);
	Copy1D(tempBuff, &sample->stratifiedLight1D[0]);
#endif
}

void Sampler_CopyFromStratifiedBuffer(Seed *seed, __global Sample *sample, const uint index) {
	const uint i0 = index * 2;
	const uint i1 = i0 + 1;

	sample->u[IDX_SCREEN_X] = sample->stratifiedScreen2D[i0];
	sample->u[IDX_SCREEN_Y] = sample->stratifiedScreen2D[i1];

#if defined(PARAM_CAMERA_HAS_DOF)
	sample->u[IDX_DOF_X] = sample->stratifiedDof2D[i0];
	sample->u[IDX_DOF_Y] = sample->stratifiedDof2D[i1];
#endif

#if defined(PARAM_HAS_ALPHA_TEXTUREMAPS)
	sample->u[IDX_BSDF_OFFSET + IDX_TEX_ALPHA] = sample->stratifiedAlpha1D[index];
#endif

	sample->u[IDX_BSDF_OFFSET + IDX_BSDF_X] = sample->stratifiedBSDF2D[i0];
	sample->u[IDX_BSDF_OFFSET + IDX_BSDF_Y] = sample->stratifiedBSDF2D[i1];
	sample->u[IDX_BSDF_OFFSET + IDX_BSDF_Z] = sample->stratifiedBSDF1D[index];

#if defined(PARAM_DIRECT_LIGHT_SAMPLING)
	sample->u[IDX_BSDF_OFFSET + IDX_DIRECTLIGHT_X] = sample->stratifiedLight2D[i0];
	sample->u[IDX_BSDF_OFFSET + IDX_DIRECTLIGHT_Y] = sample->stratifiedLight2D[i1];
	sample->u[IDX_BSDF_OFFSET + IDX_DIRECTLIGHT_Z] = sample->stratifiedLight1D[index];
#endif

	for (int i = IDX_BSDF_OFFSET + IDX_RR; i < TOTAL_U_SIZE; ++i)
		sample->u[i] = RndFloatValue(seed);
}

void Sampler_Init(const size_t gid, __local float *localMemTempBuff,
		Seed *seed, __global Sample *sample) {
#if (PARAM_IMAGE_FILTER_TYPE == 0)
	sample->pixelIndex = InitialPixelIndex(gid);
#else
	// To avoid patterns when not using atomics
	sample->pixelIndex = PixelIndexFloat2D(RndFloatValue(seed), RndFloatValue(seed));
#endif

	Sampler_StratifiedBufferInit(localMemTempBuff, seed, sample);

	Sampler_CopyFromStratifiedBuffer(seed, sample, 0);
}

__kernel void Sampler(
		__global GPUTask *tasks,
		__global GPUTaskStats *taskStats,
		__global Ray *rays,
		__global Camera *camera,
		__local float *localMemTempBuff
		) {
	const size_t gid = get_global_id(0);

	// Initialize the task
	__global GPUTask *task = &tasks[gid];

	if (task->pathState.state == PATH_STATE_DONE) {
		__global Sample *sample = &task->sample;

		// Read the seed
		Seed seed;
		seed.s1 = task->seed.s1;
		seed.s2 = task->seed.s2;
		seed.s3 = task->seed.s3;

		// Check if I have used all the stratified samples
		const uint sampleNewCount = taskStats[gid].sampleCount + 1;
		const uint sampleNewIndex = sampleNewCount % (PARAM_SAMPLER_STRATIFIED_X_SAMPLES * PARAM_SAMPLER_STRATIFIED_Y_SAMPLES);

		if (sampleNewIndex == 0) {
			// Move to the next assigned pixel
			sample->pixelIndex = NextPixelIndex(sample->pixelIndex);

			// Initialize the stratified buffer
			Sampler_StratifiedBufferInit(localMemTempBuff, &seed, sample);
		}

		Sampler_CopyFromStratifiedBuffer(&seed, sample, sampleNewIndex);

		GenerateCameraPath(task, &rays[gid], &seed, camera);

		taskStats[gid].sampleCount = sampleNewCount;

		// Save the seed
		task->seed.s1 = seed.s1;
		task->seed.s2 = seed.s2;
		task->seed.s3 = seed.s3;
	}
}

#endif
/***************************************************************************
 *   Copyright (C) 1998-2010 by authors (see AUTHORS.txt )                 *
 *                                                                         *
 *   This file is part of LuxRays.                                         *
 *                                                                         *
 *   LuxRays is free software; you can redistribute it and/or modify       *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   LuxRays is distributed in the hope that it will be useful,            *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 *   LuxRays website: http://www.luxrender.net                             *
 ***************************************************************************/

//------------------------------------------------------------------------------
// Init Kernel
//------------------------------------------------------------------------------

__kernel void Init(
		__global GPUTask *tasks,
		__global GPUTaskStats *taskStats,
		__global Ray *rays,
		__global Camera *camera
#if (PARAM_SAMPLER_TYPE == 3)
		, __local float *localMemTempBuff
#endif
		) {
	const size_t gid = get_global_id(0);

	//if (gid == 0)
	//	printf("GPUTask: %d\n", sizeof(GPUTask));

	// Initialize the task
	__global GPUTask *task = &tasks[gid];

	// Initialize random number generator
	Seed seed;
	InitRandomGenerator(PARAM_SEED + gid, &seed);

	// Initialize the sample
	Sampler_Init(gid,
#if (PARAM_SAMPLER_TYPE == 3)
			localMemTempBuff,
#endif
			&seed, &task->sample);

	// Initialize the path
	GenerateCameraPath(task, &rays[gid], &seed, camera);

	// Save the seed
	task->seed.s1 = seed.s1;
	task->seed.s2 = seed.s2;
	task->seed.s3 = seed.s3;

	__global GPUTaskStats *taskStat = &taskStats[gid];
	taskStat->sampleCount = 0;
}

//------------------------------------------------------------------------------
// InitFrameBuffer Kernel
//------------------------------------------------------------------------------

__kernel void InitFrameBuffer(
		__global Pixel *frameBuffer
		) {
	const size_t gid = get_global_id(0);
	if (gid >= (PARAM_IMAGE_WIDTH + 2) * (PARAM_IMAGE_HEIGHT + 2))
		return;

	__global Pixel *p = &frameBuffer[gid];
	p->c.r = 0.f;
	p->c.g = 0.f;
	p->c.b = 0.f;
	p->count = 0.f;
}

//------------------------------------------------------------------------------
// AdvancePaths Kernel
//------------------------------------------------------------------------------

__kernel void AdvancePaths(
		__global GPUTask *tasks,
		__global Ray *rays,
		__global RayHit *rayHits,
		__global Pixel *frameBuffer,
		__global Material *mats,
		__global uint *meshMats,
		__global uint *meshIDs,
#if defined(PARAM_ACCEL_MQBVH)
		__global uint *meshFirstTriangleOffset,
		__global Mesh *meshDescs,
#endif
		__global Vector *vertNormals,
		__global Point *vertices,
		__global Triangle *triangles,
		__global Camera *camera
#if defined(PARAM_HAS_INFINITELIGHT)
		, __global InfiniteLight *infiniteLight
		, __global Spectrum *infiniteLightMap
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		, __global SunLight *sunLight
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		, __global SkyLight *skyLight
#endif
#if (PARAM_DL_LIGHT_COUNT > 0)
		, __global TriangleLight *triLights
#endif
#if defined(PARAM_HAS_TEXTUREMAPS)
        , __global Spectrum *texMapRGBBuff
#if defined(PARAM_HAS_ALPHA_TEXTUREMAPS)
		, __global float *texMapAlphaBuff
#endif
        , __global TexMap *texMapDescBuff
        , __global unsigned int *meshTexsBuff
#if defined(PARAM_HAS_BUMPMAPS)
        , __global unsigned int *meshBumpsBuff
		, __global float *meshBumpsScaleBuff
#endif
#if defined(PARAM_HAS_NORMALMAPS)
        , __global unsigned int *meshNormalMapsBuff
#endif
		, __global UV *vertUVs
#endif
		) {
	const size_t gid = get_global_id(0);

	__global GPUTask *task = &tasks[gid];
	uint pathState = task->pathState.state;

#if (PARAM_SAMPLER_TYPE == 0)
	// Read the seed
	Seed seed;
	seed.s1 = task->seed.s1;
	seed.s2 = task->seed.s2;
	seed.s3 = task->seed.s3;
#endif

	__global Sample *sample = &task->sample;

	__global Ray *ray = &rays[gid];
	__global RayHit *rayHit = &rayHits[gid];
	const uint currentTriangleIndex = rayHit->index;

	const float hitPointT = rayHit->t;
    const float hitPointB1 = rayHit->b1;
    const float hitPointB2 = rayHit->b2;

    Vector rayDir = ray->d;

	Point hitPoint;
    hitPoint.x = ray->o.x + rayDir.x * hitPointT;
    hitPoint.y = ray->o.y + rayDir.y * hitPointT;
    hitPoint.z = ray->o.z + rayDir.z * hitPointT;

	Spectrum throughput = task->pathState.throughput;
	const Spectrum prevThroughput = throughput;

	switch (pathState) {
		case PATH_STATE_NEXT_VERTEX: {
			if (currentTriangleIndex != 0xffffffffu) {
				// Something was hit

				uint pathDepth = task->pathState.depth;
#if (PARAM_SAMPLER_TYPE == 1) || (PARAM_SAMPLER_TYPE == 3)
				__global float *sampleData = &sample->u[IDX_BSDF_OFFSET + SAMPLE_SIZE * pathDepth];
#elif (PARAM_SAMPLER_TYPE == 2)
				__global float *sampleData = &sample->u[sample->proposed][IDX_BSDF_OFFSET + SAMPLE_SIZE * pathDepth];
#endif

				const uint meshIndex = meshIDs[currentTriangleIndex];
#if defined(PARAM_ACCEL_MQBVH)
				__global Mesh *meshDesc = &meshDescs[meshIndex];
				__global Point *iVertices = &vertices[meshDesc->vertsOffset];
				__global Vector *iVertNormals = &vertNormals[meshDesc->vertsOffset];
#if defined(PARAM_HAS_TEXTUREMAPS)
				__global UV *iVertUVs = &vertUVs[meshDesc->vertsOffset];
#endif
				__global Triangle *iTriangles = &triangles[meshDesc->trisOffset];
				const uint triangleID = currentTriangleIndex - meshFirstTriangleOffset[meshIndex];
#endif
				__global Material *hitPointMat = &mats[meshMats[meshIndex]];
				uint matType = hitPointMat->type;

#if defined(PARAM_HAS_TEXTUREMAPS)
				Spectrum shadeColor;

				// Interpolate UV coordinates
				UV uv;
#if defined(PARAM_ACCEL_MQBVH)
				Mesh_InterpolateUV(iVertUVs, iTriangles, triangleID, hitPointB1, hitPointB2, &uv);
#else
				Mesh_InterpolateUV(vertUVs, triangles, currentTriangleIndex, hitPointB1, hitPointB2, &uv);
#endif
				// Check it the mesh has a texture map
				unsigned int texIndex = meshTexsBuff[meshIndex];
				if (texIndex != 0xffffffffu) {
					__global TexMap *texMap = &texMapDescBuff[texIndex];

#if defined(PARAM_HAS_ALPHA_TEXTUREMAPS)
					// Check if it has an alpha channel
					if (texMap->alphaOffset != 0xffffffffu) {
						const float alpha = TexMap_GetAlpha(&texMapAlphaBuff[texMap->alphaOffset], texMap->width, texMap->height, uv.u, uv.v);

#if (PARAM_SAMPLER_TYPE == 0)
						const float texAlphaSample = RndFloatValue(&seed);
#elif (PARAM_SAMPLER_TYPE == 1) || (PARAM_SAMPLER_TYPE == 2) || (PARAM_SAMPLER_TYPE == 3)
						const float texAlphaSample = sampleData[IDX_TEX_ALPHA];
#endif

						if ((alpha == 0.0f) || ((alpha < 1.f) && (texAlphaSample > alpha))) {
							// Continue to trace the ray
							matType = MAT_NULL;
						}
					}
#endif

					Spectrum texColor;
					TexMap_GetColor(&texMapRGBBuff[texMap->rgbOffset], texMap->width, texMap->height, uv.u, uv.v, &texColor);

					shadeColor.r = texColor.r;
					shadeColor.g = texColor.g;
					shadeColor.b = texColor.b;
				} else {
					shadeColor.r = 1.f;
					shadeColor.g = 1.f;
					shadeColor.b = 1.f;
				}

				throughput.r *= shadeColor.r;
				throughput.g *= shadeColor.g;
				throughput.b *= shadeColor.b;
#endif

				// Interpolate the normal
				Vector N;
#if defined(PARAM_ACCEL_MQBVH)
				Mesh_InterpolateNormal(iVertNormals, iTriangles, triangleID, hitPointB1, hitPointB2, &N);
				TransformNormal(meshDesc->invTrans, &N);
#else
				Mesh_InterpolateNormal(vertNormals, triangles, currentTriangleIndex, hitPointB1, hitPointB2, &N);
#endif

#if defined(PARAM_HAS_NORMALMAPS)
				// Check it the mesh has a bump map
				unsigned int normalMapIndex = meshNormalMapsBuff[meshIndex];
				if (normalMapIndex != 0xffffffffu) {
					// Apply normal mapping
					__global TexMap *texMap = &texMapDescBuff[normalMapIndex];
					const uint texWidth = texMap->width;
					const uint texHeight = texMap->height;

					Spectrum texColor;
					TexMap_GetColor(&texMapRGBBuff[texMap->rgbOffset], texWidth, texHeight, uv.u, uv.v, &texColor);
					const float x = 2.f * (texColor.r - 0.5f);
					const float y = 2.f * (texColor.g - 0.5f);
					const float z = 2.f * (texColor.b - 0.5f);

					Vector v1, v2;
					CoordinateSystem(&N, &v1, &v2);
					N.x = v1.x * x + v2.x * y + N.x * z;
					N.y = v1.y * x + v2.y * y + N.y * z;
					N.z = v1.z * x + v2.z * y + N.z * z;
					Normalize(&N);
				}
#endif

#if defined(PARAM_HAS_BUMPMAPS)
				// Check it the mesh has a bump map
				unsigned int bumpIndex = meshBumpsBuff[meshIndex];
				if (bumpIndex != 0xffffffffu) {
					// Apply bump mapping
					__global TexMap *texMap = &texMapDescBuff[bumpIndex];
					const uint texWidth = texMap->width;
					const uint texHeight = texMap->height;

					UV dudv;
					dudv.u = 1.f / texWidth;
					dudv.v = 1.f / texHeight;

					Spectrum texColor;
					TexMap_GetColor(&texMapRGBBuff[texMap->rgbOffset], texWidth, texHeight, uv.u, uv.v, &texColor);
					const float b0 = Spectrum_Y(&texColor);

					TexMap_GetColor(&texMapRGBBuff[texMap->rgbOffset], texWidth, texHeight, uv.u + dudv.u, uv.v, &texColor);
					const float bu = Spectrum_Y(&texColor);

					TexMap_GetColor(&texMapRGBBuff[texMap->rgbOffset], texWidth, texHeight, uv.u, uv.v + dudv.v, &texColor);
					const float bv = Spectrum_Y(&texColor);

					const float scale = meshBumpsScaleBuff[meshIndex];
					Vector bump;
					bump.x = scale * (bu - b0);
					bump.y = scale * (bv - b0);
					bump.z = 1.f;

					Vector v1, v2;
					CoordinateSystem(&N, &v1, &v2);
					N.x = v1.x * bump.x + v2.x * bump.y + N.x * bump.z;
					N.y = v1.y * bump.x + v2.y * bump.y + N.y * bump.z;
					N.z = v1.z * bump.x + v2.z * bump.y + N.z * bump.z;
					Normalize(&N);
				}
#endif

				// Flip the normal if required
				Vector shadeN;
				const float nFlip = (Dot(&rayDir, &N) > 0.f) ? -1.f : 1.f;
				shadeN.x = nFlip * N.x;
				shadeN.y = nFlip * N.y;
				shadeN.z = nFlip * N.z;

#if (PARAM_SAMPLER_TYPE == 0)
				const float u0 = RndFloatValue(&seed);
				const float u1 = RndFloatValue(&seed);
#elif (PARAM_SAMPLER_TYPE == 1) ||(PARAM_SAMPLER_TYPE == 2) || (PARAM_SAMPLER_TYPE == 3)
				const float u0 = sampleData[IDX_BSDF_X];
				const float u1 = sampleData[IDX_BSDF_Y];
#endif

#if defined(PARAM_ENABLE_MAT_MATTEMIRROR) || defined(PARAM_ENABLE_MAT_MATTEMETAL) || defined(PARAM_ENABLE_MAT_ALLOY)
#if (PARAM_SAMPLER_TYPE == 0)
				const float u2 = RndFloatValue(&seed);
#elif (PARAM_SAMPLER_TYPE == 1) ||(PARAM_SAMPLER_TYPE == 2) || (PARAM_SAMPLER_TYPE == 3)
				const float u2 = sampleData[IDX_BSDF_Z];
#endif
#endif

				Vector wo;
				wo.x = -rayDir.x;
				wo.y = -rayDir.y;
				wo.z = -rayDir.z;

				Vector wi;
				Spectrum f;
				f.r = 1.f;
				f.g = 1.f;
				f.b = 1.f;
				float materialPdf;
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
				int specularMaterial;
#endif

				switch (matType) {

#if defined(PARAM_ENABLE_MAT_MATTE)
					case MAT_MATTE:
						Matte_Sample_f(&hitPointMat->param.matte, &wo, &wi, &materialPdf, &f, &shadeN, u0, u1
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
								, &specularMaterial
#endif
								);
						break;
#endif

#if (PARAM_DL_LIGHT_COUNT > 0)
					case MAT_AREALIGHT: {
						Spectrum Le;
						AreaLight_Le(&hitPointMat->param.areaLight, &wo, &N, &Le);

#if defined(PARAM_DIRECT_LIGHT_SAMPLING)
						if (!task->pathState.specularBounce) {
#if defined(PARAM_HAS_SUNLIGHT)
							const uint lightSourceCount = PARAM_DL_LIGHT_COUNT + 1;
#else
							const uint lightSourceCount = PARAM_DL_LIGHT_COUNT;
#endif
#if defined(PARAM_ACCEL_MQBVH)
							const float area = InstanceMesh_Area(meshDesc->trans, iVertices, iTriangles, triangleID);
#else
							const float area = Mesh_Area(vertices, triangles, currentTriangleIndex);
#endif
							const float lpdf = lightSourceCount / area;
							const float ph = PowerHeuristic(1, task->pathState.bouncePdf, 1, lpdf);

							Le.r *= ph;
							Le.g *= ph;
							Le.b *= ph;
						}
#endif

						sample->radiance.r += throughput.r * Le.r;
						sample->radiance.g += throughput.g * Le.g;
						sample->radiance.b += throughput.b * Le.b;

#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
						specularMaterial = 0;
#endif
						materialPdf = 0.f;
						break;
					}
#endif

#if defined(PARAM_ENABLE_MAT_MIRROR)
					case MAT_MIRROR:
						Mirror_Sample_f(&hitPointMat->param.mirror, &wo, &wi, &materialPdf, &f, &shadeN
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
								, &specularMaterial
#endif
								);
						break;
#endif

#if defined(PARAM_ENABLE_MAT_GLASS)
					case MAT_GLASS:
						Glass_Sample_f(&hitPointMat->param.glass, &wo, &wi, &materialPdf, &f, &N, &shadeN, u0
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
								, &specularMaterial
#endif
								);
						break;
#endif

#if defined(PARAM_ENABLE_MAT_MATTEMIRROR)
					case MAT_MATTEMIRROR:
						MatteMirror_Sample_f(&hitPointMat->param.matteMirror, &wo, &wi, &materialPdf, &f, &shadeN, u0, u1, u2
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
								, &specularMaterial
#endif
								);
						break;
#endif

#if defined(PARAM_ENABLE_MAT_METAL)
					case MAT_METAL:
						Metal_Sample_f(&hitPointMat->param.metal, &wo, &wi, &materialPdf, &f, &shadeN, u0, u1
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
								, &specularMaterial
#endif
								);
						break;
#endif

#if defined(PARAM_ENABLE_MAT_MATTEMETAL)
					case MAT_MATTEMETAL:
						MatteMetal_Sample_f(&hitPointMat->param.matteMetal, &wo, &wi, &materialPdf, &f, &shadeN, u0, u1, u2
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
								, &specularMaterial
#endif
								);
						break;
#endif

#if defined(PARAM_ENABLE_MAT_ALLOY)
					case MAT_ALLOY:
						Alloy_Sample_f(&hitPointMat->param.alloy, &wo, &wi, &materialPdf, &f, &shadeN, u0, u1, u2
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
								, &specularMaterial
#endif
								);
						break;
#endif

#if defined(PARAM_ENABLE_MAT_ARCHGLASS)
					case MAT_ARCHGLASS:
						ArchGlass_Sample_f(&hitPointMat->param.archGlass, &wo, &wi, &materialPdf, &f, &N, &shadeN, u0
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
								, &specularMaterial
#endif
								);
						break;
#endif

					case MAT_NULL:
						wi = rayDir;
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
						specularMaterial = 1;
#endif
						materialPdf = 1.f;

						// I have also to restore the original throughput
						throughput = prevThroughput;
						break;

					default:
						// Huston, we have a problem...
#if defined(PARAM_DIRECT_LIGHT_SAMPLING) || (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
						specularMaterial = 1;
#endif
						materialPdf = 0.f;
						break;
				}

				// Russian roulette

#if (PARAM_SAMPLER_TYPE == 0)
				const float rrSample = RndFloatValue(&seed);
#elif (PARAM_SAMPLER_TYPE == 1) || (PARAM_SAMPLER_TYPE == 2) || (PARAM_SAMPLER_TYPE == 3)
				const float rrSample = sampleData[IDX_RR];
#endif

				const float rrProb = max(max(throughput.r, max(throughput.g, throughput.b)), (float) PARAM_RR_CAP);
				pathDepth += 1;
				float invRRProb = (pathDepth > PARAM_RR_DEPTH) ? ((rrProb < rrSample) ? 0.f : (1.f / rrProb)) : 1.f;
#if (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
				const uint diffuseVertexCount = task->pathState.diffuseVertexCount + (specularMaterial ? 0 : 1);
#endif
				invRRProb = ((materialPdf <= 0.f) || (pathDepth >= PARAM_MAX_PATH_DEPTH)
#if (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
						|| (diffuseVertexCount > PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT)
#endif
						) ? 0.f : invRRProb;

				throughput.r *= f.r * invRRProb;
				throughput.g *= f.g * invRRProb;
				throughput.b *= f.b * invRRProb;

				//if (pathDepth > 2)
				//	printf("Depth: %d Throughput: (%f, %f, %f)\n", pathDepth, throughput.r, throughput.g, throughput.b);

#if defined(PARAM_DIRECT_LIGHT_SAMPLING)
				float directLightPdf;
				switch (matType) {
					case MAT_MATTE:
						directLightPdf = 1.f;
						break;
					case MAT_MATTEMIRROR:
						directLightPdf = hitPointMat->param.matteMirror.mattePdf;
						break;
					case MAT_MATTEMETAL:
						directLightPdf = hitPointMat->param.matteMetal.mattePdf;
						break;
					case MAT_ALLOY: {
						// Schilick's approximation
						const float c = 1.f + Dot(&rayDir, &shadeN);
						const float R0 = hitPointMat->param.alloy.R0;
						const float Re = R0 + (1.f - R0) * c * c * c * c * c;

						const float P = .25f + .5f * Re;

						directLightPdf = 1.f - P;
						break;
					}
					default:
						directLightPdf = 0.f;
						break;
				}

				if (directLightPdf > 0.f) {
#if (PARAM_SAMPLER_TYPE == 0)
					const float ul0 = RndFloatValue(&seed);
					const float ul1 = RndFloatValue(&seed);
					const float ul2 = RndFloatValue(&seed);
#elif (PARAM_SAMPLER_TYPE == 1) || (PARAM_SAMPLER_TYPE == 2) || (PARAM_SAMPLER_TYPE == 3)
					const float ul1 = sampleData[IDX_DIRECTLIGHT_X];
					const float ul2 = sampleData[IDX_DIRECTLIGHT_Y];
					const float ul0 = sampleData[IDX_DIRECTLIGHT_Z];
#endif

					// Select a light source to sample

					// Setup the shadow ray
					Spectrum Le;
					uint lightSourceCount;
					float lightPdf;
					float lPdf; // pdf used for MIS
					Ray shadowRay;

#if defined(PARAM_HAS_SUNLIGHT) && (PARAM_DL_LIGHT_COUNT == 0)
					//----------------------------------------------------------
					// This is the case with only the sun light
					//----------------------------------------------------------

					SunLight_Sample_L(sunLight, &hitPoint, &lightPdf, &Le, &shadowRay, ul1, ul2);
					lPdf = lightPdf;
					lightSourceCount = 1;

					//----------------------------------------------------------
#elif defined(PARAM_HAS_SUNLIGHT) && (PARAM_DL_LIGHT_COUNT > 0)
					//----------------------------------------------------------
					// This is the case with sun light and area lights
					//----------------------------------------------------------

					// Select one of the lights
					const uint lightIndex = min((uint)floor((PARAM_DL_LIGHT_COUNT + 1)* ul0), (uint)(PARAM_DL_LIGHT_COUNT));
					lightSourceCount = PARAM_DL_LIGHT_COUNT + 1;

					if (lightIndex == PARAM_DL_LIGHT_COUNT) {
						// The sun light was selected

						SunLight_Sample_L(sunLight, &hitPoint, &lightPdf, &Le, &shadowRay, ul1, ul2);
						lPdf = lightPdf;
					} else {
						// An area light was selected

						__global TriangleLight *l = &triLights[lightIndex];
						TriangleLight_Sample_L(l, &hitPoint, &lightPdf, &Le, &shadowRay, ul1, ul2);
						lPdf = PARAM_DL_LIGHT_COUNT / l->area;
					}

					//----------------------------------------------------------
#elif !defined(PARAM_HAS_SUNLIGHT) && (PARAM_DL_LIGHT_COUNT > 0)
					//----------------------------------------------------------
					// This is the case without sun light and with area lights
					//----------------------------------------------------------

					// Select one of the area lights
					const uint lightIndex = min((uint)floor(PARAM_DL_LIGHT_COUNT * ul0), (uint)(PARAM_DL_LIGHT_COUNT - 1));
					__global TriangleLight *l = &triLights[lightIndex];

					TriangleLight_Sample_L(l, &hitPoint, &lightPdf, &Le, &shadowRay, ul1, ul2);
					lPdf = PARAM_DL_LIGHT_COUNT / l->area;
					lightSourceCount = PARAM_DL_LIGHT_COUNT;

					//----------------------------------------------------------
#else
Error: Huston, we have a problem !
#endif

					const float dp = Dot(&shadeN, &shadowRay.d);
					const float matPdf = M_PI;

					const float mPdf = directLightPdf * dp * INV_PI;
					const float pdf = (dp <= 0.f) ? 0.f :
						(PowerHeuristic(1, lPdf, 1, mPdf) * lightPdf * directLightPdf * matPdf / (dp * lightSourceCount));
					if (pdf > 0.f) {
						Spectrum throughputLightDir = prevThroughput;
#if defined(PARAM_HAS_TEXTUREMAPS)
						throughputLightDir.r *= shadeColor.r;
						throughputLightDir.g *= shadeColor.g;
						throughputLightDir.b *= shadeColor.b;
#endif

						const float k = 1.f / pdf;
						// NOTE: I assume all matte mixed material have a MatteParam as first field
						task->pathState.lightRadiance.r = throughputLightDir.r * hitPointMat->param.matte.r * Le.r * k;
						task->pathState.lightRadiance.g = throughputLightDir.g * hitPointMat->param.matte.g * Le.g * k;
						task->pathState.lightRadiance.b = throughputLightDir.b * hitPointMat->param.matte.b * Le.b * k;

						*ray = shadowRay;

						// Save data for next path vertex
						task->pathState.nextPathRay.o = hitPoint;
						task->pathState.nextPathRay.d = wi;
						task->pathState.nextPathRay.mint = PARAM_RAY_EPSILON;
						task->pathState.nextPathRay.maxt = FLT_MAX;

						task->pathState.bouncePdf = materialPdf;
						task->pathState.specularBounce = specularMaterial;
						task->pathState.nextThroughput = throughput;

						pathState = PATH_STATE_SAMPLE_LIGHT;
					} else {
						// Skip the shadow ray tracing step

						if ((throughput.r <= 0.f) && (throughput.g <= 0.f) && (throughput.b <= 0.f))
							pathState = PATH_STATE_DONE;
						else {
							ray->o = hitPoint;
							ray->d = wi;
							ray->mint = PARAM_RAY_EPSILON;
							ray->maxt = FLT_MAX;

							task->pathState.bouncePdf = materialPdf;
							task->pathState.specularBounce = specularMaterial;
							task->pathState.throughput = throughput;
							task->pathState.depth = pathDepth;
#if (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
							task->pathState.diffuseVertexCount = diffuseVertexCount;
#endif

							pathState = PATH_STATE_NEXT_VERTEX;
						}
					}
				} else {
					// Skip the shadow ray tracing step

					if ((throughput.r <= 0.f) && (throughput.g <= 0.f) && (throughput.b <= 0.f))
						pathState = PATH_STATE_DONE;
					else {
						ray->o = hitPoint;
						ray->d = wi;
						ray->mint = PARAM_RAY_EPSILON;
						ray->maxt = FLT_MAX;

						task->pathState.bouncePdf = materialPdf;
						task->pathState.specularBounce = specularMaterial;
						task->pathState.throughput = throughput;
						task->pathState.depth = pathDepth;
#if (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
						task->pathState.diffuseVertexCount = diffuseVertexCount;
#endif

						pathState = PATH_STATE_NEXT_VERTEX;
					}
				}

#else

				if ((throughput.r <= 0.f) && (throughput.g <= 0.f) && (throughput.b <= 0.f))
					pathState = PATH_STATE_DONE;
				else {
					// Setup next ray
					ray->o = hitPoint;
					ray->d = wi;
					ray->mint = PARAM_RAY_EPSILON;
					ray->maxt = FLT_MAX;

					task->pathState.throughput = throughput;
					task->pathState.depth = pathDepth;
#if (PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT < PARAM_MAX_PATH_DEPTH)
					task->pathState.diffuseVertexCount = diffuseVertexCount;
#endif

					pathState = PATH_STATE_NEXT_VERTEX;
				}
#endif

			} else {
#if defined(PARAM_HAS_INFINITELIGHT)
				Spectrum iLe;
				InfiniteLight_Le(infiniteLight, infiniteLightMap, &iLe, &rayDir);

				sample->radiance.r += throughput.r * iLe.r;
				sample->radiance.g += throughput.g * iLe.g;
				sample->radiance.b += throughput.b * iLe.b;
#endif

#if defined(PARAM_HAS_SUNLIGHT)
				// Make the sun visible only if relsize has been changed (in order
				// to avoid fireflies).
				if (sunLight->relSize > 5.f) {
					Spectrum sLe;
					SunLight_Le(sunLight, &sLe, &rayDir);

					if (!task->pathState.specularBounce) {
						const float lpdf = UniformConePdf(sunLight->cosThetaMax);
						const float ph = PowerHeuristic(1, task->pathState.bouncePdf, 1, lpdf);

						sLe.r *= ph;
						sLe.g *= ph;
						sLe.b *= ph;
					}

					sample->radiance.r += throughput.r * sLe.r;
					sample->radiance.g += throughput.g * sLe.g;
					sample->radiance.b += throughput.b * sLe.b;
				}
#endif

#if defined(PARAM_HAS_SKYLIGHT)
				Spectrum skLe;
				SkyLight_Le(skyLight, &skLe, &rayDir);

				sample->radiance.r += throughput.r * skLe.r;
				sample->radiance.g += throughput.g * skLe.g;
				sample->radiance.b += throughput.b * skLe.b;
#endif

				pathState = PATH_STATE_DONE;
			}
			break;
		}

#if defined(PARAM_DIRECT_LIGHT_SAMPLING)
		case PATH_STATE_SAMPLE_LIGHT: {
			if (currentTriangleIndex != 0xffffffffu) {
				// The shadow ray has hit something

#if defined(PARAM_HAS_TEXTUREMAPS) && defined(PARAM_HAS_ALPHA_TEXTUREMAPS)
				// Check if I have to continue to trace the shadow ray

				const uint pathDepth = task->pathState.depth;
#if (PARAM_SAMPLER_TYPE == 1) || (PARAM_SAMPLER_TYPE == 3)
				__global float *sampleData = &sample->u[IDX_BSDF_OFFSET + SAMPLE_SIZE * pathDepth];
#elif (PARAM_SAMPLER_TYPE == 2)
				__global float *sampleData = &sample->u[sample->proposed][IDX_BSDF_OFFSET + SAMPLE_SIZE * pathDepth];
#endif

				const uint meshIndex = meshIDs[currentTriangleIndex];
				__global Material *hitPointMat = &mats[meshMats[meshIndex]];
				uint matType = hitPointMat->type;

				// Interpolate UV coordinates
				UV uv;
#if defined(PARAM_ACCEL_MQBVH)
				__global Mesh *meshDesc = &meshDescs[meshIndex];
				__global UV *iVertUVs = &vertUVs[meshDesc->vertsOffset];
				__global Triangle *iTriangles = &triangles[meshDesc->trisOffset];
				const uint triangleID = currentTriangleIndex - meshFirstTriangleOffset[meshIndex];
				Mesh_InterpolateUV(iVertUVs, iTriangles, triangleID, hitPointB1, hitPointB2, &uv);
#else
				Mesh_InterpolateUV(vertUVs, triangles, currentTriangleIndex, hitPointB1, hitPointB2, &uv);
#endif

				// Check it the mesh has a texture map
				unsigned int texIndex = meshTexsBuff[meshIndex];
				if (texIndex != 0xffffffffu) {
					__global TexMap *texMap = &texMapDescBuff[texIndex];

					// Check if it has an alpha channel
					if (texMap->alphaOffset != 0xffffffffu) {
						const float alpha = TexMap_GetAlpha(&texMapAlphaBuff[texMap->alphaOffset], texMap->width, texMap->height, uv.u, uv.v);

#if (PARAM_SAMPLER_TYPE == 0)
						const float texAlphaSample = RndFloatValue(&seed);
#elif (PARAM_SAMPLER_TYPE == 1) || (PARAM_SAMPLER_TYPE == 2) || (PARAM_SAMPLER_TYPE == 3)
						const float texAlphaSample = sampleData[IDX_TEX_ALPHA];
#endif

						if ((alpha == 0.0f) || ((alpha < 1.f) && (texAlphaSample > alpha))) {
							// Continue to trace the ray
							matType = MAT_NULL;
						}
					}
				}

				if (matType == MAT_ARCHGLASS) {
					task->pathState.lightRadiance.r *= hitPointMat->param.archGlass.refrct_r;
					task->pathState.lightRadiance.g *= hitPointMat->param.archGlass.refrct_g;
					task->pathState.lightRadiance.b *= hitPointMat->param.archGlass.refrct_b;
				}

				if ((matType == MAT_ARCHGLASS) || (matType == MAT_NULL)) {
					const float hitPointT = rayHit->t;

					Point hitPoint;
					hitPoint.x = ray->o.x + rayDir.x * hitPointT;
					hitPoint.y = ray->o.y + rayDir.y * hitPointT;
					hitPoint.z = ray->o.z + rayDir.z * hitPointT;

					// Continue to trace the ray
					ray->o = hitPoint;
					ray->maxt -= hitPointT;
				} else
					pathState = PATH_STATE_NEXT_VERTEX;

#else
				// The light is source is not visible

				pathState = PATH_STATE_NEXT_VERTEX;
#endif

			} else {
				// The light source is visible

				sample->radiance.r += task->pathState.lightRadiance.r;
				sample->radiance.g += task->pathState.lightRadiance.g;
				sample->radiance.b += task->pathState.lightRadiance.b;

				pathState = PATH_STATE_NEXT_VERTEX;
			}


			if (pathState == PATH_STATE_NEXT_VERTEX) {
				Spectrum throughput = task->pathState.nextThroughput;
				if ((throughput.r <= 0.f) && (throughput.g <= 0.f) && (throughput.b <= 0.f))
					pathState = PATH_STATE_DONE;
				else {
					// Restore the ray for the next path vertex
					*ray = task->pathState.nextPathRay;

					task->pathState.throughput = throughput;

					// Increase path depth
					task->pathState.depth += 1;
				}
			}
			break;
		}
#endif
	}

	if (pathState == PATH_STATE_DONE) {
#if (PARAM_SAMPLER_TYPE == 2)

		// Read the seed
		Seed seed;
		seed.s1 = task->seed.s1;
		seed.s2 = task->seed.s2;
		seed.s3 = task->seed.s3;

		Sampler_MLT_SplatSample(frameBuffer, &seed, sample);

		// Save the seed
		task->seed.s1 = seed.s1;
		task->seed.s2 = seed.s2;
		task->seed.s3 = seed.s3;

#else

#if (PARAM_IMAGE_FILTER_TYPE == 0)
		Spectrum radiance = sample->radiance;
		SplatSample(frameBuffer, sample->pixelIndex, &radiance, 1.f);
#else
		__global float *sampleData = &sample->u[0];
		const float sx = sampleData[IDX_SCREEN_X] - .5f;
		const float sy = sampleData[IDX_SCREEN_Y] - .5f;

		Spectrum radiance = sample->radiance;
		SplatSample(frameBuffer, sample->pixelIndex, sx, sy, &radiance, 1.f);
#endif

#endif
	}

	task->pathState.state = pathState;

#if (PARAM_SAMPLER_TYPE == 0)
	// Save the seed
	task->seed.s1 = seed.s1;
	task->seed.s2 = seed.s2;
	task->seed.s3 = seed.s3;
#endif
}


// buildOptions= -D PARAM_TASK_COUNT=65536 -D PARAM_IMAGE_WIDTH=600 -D PARAM_IMAGE_HEIGHT=600 -D PARAM_RAY_EPSILON=1.000000e-004f -D PARAM_SEED=412 -D PARAM_MAX_PATH_DEPTH=10 -D PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT=5 -D PARAM_RR_DEPTH=10 -D PARAM_RR_CAP=2.500000e-001f -D PARAM_ACCEL_QBVH -D PARAM_ENABLE_MAT_MATTE -D PARAM_ENABLE_MAT_GLASS -D PARAM_ENABLE_MAT_MATTEMIRROR -D PARAM_ENABLE_MAT_ALLOY -D PARAM_ENABLE_MAT_ARCHGLASS -D PARAM_CAMERA_HAS_DOF -D PARAM_HAS_SKYLIGHT -D PARAM_HAS_SUNLIGHT -D PARAM_DIRECT_LIGHT_SAMPLING -D PARAM_DL_LIGHT_COUNT=0 -D PARAM_HAS_TEXTUREMAPS -D PARAM_HAS_ALPHA_TEXTUREMAPS -D PARAM_HAS_BUMPMAPS -D PARAM_IMAGE_FILTER_TYPE=2 -D PARAM_IMAGE_FILTER_WIDTH_X=1.500000e+000f -D PARAM_IMAGE_FILTER_WIDTH_Y=1.500000e+000f -D PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA=2.000000e+000f -D PARAM_SAMPLER_TYPE=2 -D PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE=4.000000e-001f -D PARAM_SAMPLER_METROPOLIS_MAX_CONSECUTIVE_REJECT=512 -D PARAM_SAMPLER_METROPOLIS_IMAGE_MUTATION_RANGE=1.000000e-001f
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D PARAM_TASK_COUNT=65536 -D PARAM_IMAGE_WIDTH=600 -D PARAM_IMAGE_HEIGHT=600 -D PARAM_RAY_EPSILON=1.000000e-004f -D PARAM_SEED=412 -D PARAM_MAX_PATH_DEPTH=10 -D PARAM_MAX_DIFFUSE_PATH_VERTEX_COUNT=5 -D PARAM_RR_DEPTH=10 -D PARAM_RR_CAP=2.500000e-001f -D PARAM_ACCEL_QBVH -D PARAM_ENABLE_MAT_MATTE -D PARAM_ENABLE_MAT_GLASS -D PARAM_ENABLE_MAT_MATTEMIRROR -D PARAM_ENABLE_MAT_ALLOY -D PARAM_ENABLE_MAT_ARCHGLASS -D PARAM_CAMERA_HAS_DOF -D PARAM_HAS_SKYLIGHT -D PARAM_HAS_SUNLIGHT -D PARAM_DIRECT_LIGHT_SAMPLING -D PARAM_DL_LIGHT_COUNT=0 -D PARAM_HAS_TEXTUREMAPS -D PARAM_HAS_ALPHA_TEXTUREMAPS -D PARAM_HAS_BUMPMAPS -D PARAM_IMAGE_FILTER_TYPE=2 -D PARAM_IMAGE_FILTER_WIDTH_X=1.500000e+000f -D PARAM_IMAGE_FILTER_WIDTH_Y=1.500000e+000f -D PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA=2.000000e+000f -D PARAM_SAMPLER_TYPE=2 -D PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE=4.000000e-001f -D PARAM_SAMPLER_METROPOLIS_MAX_CONSECUTIVE_REJECT=512 -D PARAM_SAMPLER_METROPOLIS_IMAGE_MUTATION_RANGE=1.000000e-001f" %cfg_path --cl-device=%cl_device 2>&1
