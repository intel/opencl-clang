#ifndef __MANDELBULB_DEFINES_H__
#define __MANDELBULB_DEFINES_H__

// This file contains preprocessor defines and helper functions for OpenCLFractalRender3D. It's not actually used as a proper header at the moment,
// but instead the source of Mandelbulb_kernel.cl is concatenated to this file and the result is compiled.

#ifndef __COMMON_H__
#include <common.h>
#endif /* __COMMON_H__ */

// Parameters that can probably be done away with and/or made into options...


// Can't pass a mixed int/float struct with OpenCLRun, so do this for now
#define AMBIENT		0.5f
#define DIRECTIONAL	1.5f
#define POINT		2.5f
#define SPOT		3.5f


// set default parameters if not using OpenCLRun
#ifndef BOUNDING_RADIUS_2
#define BOUNDING_RADIUS_2 4.0f
#endif /* BOUNDING_RADIUS_2 */

#ifndef USING_OPENCL_FUNCTION
#define ENABLE_SHADOW 1
#define MAX_ITERATIONS 12
#define ENABLE_FLOOR 1
#define FLOOR_POSITION -2.0f
#define QUATERNION 0 // 1 = Use Quaternion fractals, 0 = use Triplex fractals.
#define JULIA 0 // 1 = Use Julia where available, 0 = use Mandelbrot. 
#define COLOR_R 1.0f
#define COLOR_G 0.35f
#define COLOR_B 0.15f
#define SPECULAR_EXP 30.0f
#define SPECULARITY 0.65f
#endif /* USING_OPENCL_FUNCTION */


#define ESCAPE_THRESHOLD 4.0f
#define DELTA 0.00001f


static float4 QuatMult(const float4 q1, const float4 q2) {
	float4 r;

	// a1a2 - b1b2 - c1c2 - d1d2
	r.x = q1.x * q2.x - q1.y * q2.y - q1.z * q2.z - q1.w * q2.w;
	// a1b2 + b1a2 + c1d2 - d1c2
	r.y = q1.x * q2.y + q1.y * q2.x + q1.z * q2.w - q1.w * q2.z;
	// a1c2 - b1d2 + c1a2 + d1b2
	r.z = q1.x * q2.z - q1.y * q2.w + q1.z * q2.x + q1.w * q2.y;
	// a1d2 + b1c2 - c1b2 + d1a2
	r.w = q1.x * q2.w + q1.y * q2.z - q1.z * q2.y + q1.w * q2.x;

	return r;
}

// Much more efficient than QuatMult(q,q)
static float4 QuatSqr(const float4 q) {
	float4 r;

	r.x = q.x * q.x - q.y * q.y - q.z * q.z - q.w * q.w;
	r.y = 2.f * q.x * q.y;
	r.z = 2.f * q.x * q.z;
	r.w = 2.f * q.x * q.w;

	return r;
}

// Not actually used (yet)
static float IterateIntersectIFS(const float4 q, const float4 c, const unsigned mint maxIterations) {
	float4 z = q;
	
	float r2 = dot(z,z);
	float temp;
	float4 scale = c; // c.xyz = center of scaling, c.w = magnitude of scaling.
	float invscale = 1.0f / scale.w;
	float div = 1.0f;
	
	for(uint n = 0; n < maxIterations; n++) {
		if(r2 > 10000.0f) break;
		
		div *= invscale;
		
		z.x = fabs(z.x);
		z.y = fabs(z.y);
		z.z = fabs(z.z);
		if(z.x - z.y < 0.0f) {temp = z.y; z.y = z.x; z.x = temp;}
		if(z.y - z.z < 0.0f) {temp = z.z; z.z = z.y; z.y = temp;}
		
		z.x = (z.x - scale.x) * scale.w + scale.x;
		z.y = (z.y - scale.y) * scale.w + scale.y;
		z.z = scale.w * z.z;
		if(z.z > 0.5f * (scale.w - 1.0f)) z.z -= (scale.w - 1.0f);
		
		r2 = dot(z,z);
	}
	
	return sqrt(r2) * div;
}

// Iterate a quaternion Julia or Mandelbrot equation and return a lower bound on the distance from q to the set.
static float IterateIntersectQuaternion(const float4 q, const float4 c, const unsigned mint maxIterations) {
	float4 q0 = q;
	float4 qp0 = (float4)(1.0f, 0.0f, 0.0f, 0.0f);
	
#if JULIA == 1
	const float4 c0 = c;
#else // Default to Mandelbrot? Probably a bad idea but it shouldn't be possible for QUATERNION & !JULIA to be defined right now.
	const float4 c0 = q0;
#endif
	
	for (uint i = 0; i < maxIterations; ++i) {
		qp0 = 2.f * QuatMult(q0, qp0);
		q0 = QuatSqr(q0) + c0;

		if (dot(q0, q0) > ESCAPE_THRESHOLD)
		{
			break;
		}
	}
	
	const float normZP = length(qp0);
	if(normZP == 0.0f) return 0.0f;  // We're inside

	const float normZ = length(q0);
	return 0.5f * normZ * log(normZ) / normZP;
}

// Same as above, but with Triplex numbers rather than quaternions
// Triplex numbers are just coordinates in R3 with exponentiation defined as a pseudo-extension
// of exponentiation in complex numbers. If (x,y,z) has spherical coordinates (r, theta, phi), then
// (x,y,z)^n = (r^n, n*theta, n*phi).
// Using only integer degrees would allow us to get rid of most/all trig calls, but would have to be
// hand coded for each integer.
static float IterateIntersectTriplex(const float4 z0, const float4 c0, const unsigned mint maxIterations) {
	float4 z = z0;
#if JULIA
	float4 c = (float4)(c0.x, c0.y, c0.z, 0.0f);
#else
	float4 c = z0;
#endif

	const float degree = c0.w;
	float dr = 1.0f;
	float r2 = dot(z,z);
	float r = sqrt(r2);
	for(int n=0; (n < maxIterations) && (r < 2.0f); ++n) {
		const float zo0 = asin(z.z/r);
		const float zi0 = atan2(z.y, z.x);
		float zr = pow(r, degree-1.0f); // should this be DEGREE or DEGREE-1.0f?
		const float zo = zo0 * degree;
		const float zi = zi0 * degree;
		const float czo = cos(zo);

		dr = zr * dr * degree + 1.0f;
		zr *= r;

		z = zr * (float4)(czo * cos(zi), czo * sin(zi), sin(zo), 0.0f);
		z += c;
		
		r2 = dot(z,z);
		r = sqrt(r2);
	}
	return 0.5f * log(r) * r / dr;
}


#endif /* __MANDELBULB_DEFINES_H__ */