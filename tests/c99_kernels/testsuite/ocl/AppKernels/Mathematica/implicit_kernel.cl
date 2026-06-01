/*
Copyright (c) 2009 David Bucciarelli (davibu@interfree.it)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint long
#define Real_t float
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100


#ifndef __AFFINE_ARITHMETIC_H__
#include "affine_arithmetic.h"
#endif

#ifndef __COMMON_H__
#include "common.h"
#endif


// Can't pass a mixed int/float struct with OpenCLRun, so do this for now
#define AMBIENT		0.5f
#define DIRECTIONAL	1.5f
#define POINT		2.5f
#define SPOT		3.5f

#ifdef USING_OPENCL_FUNCTION
#define BOUNDING_RADIUS_2 25.0f
#define FLOOR_POSITION -100.0f

#define ENABLE_SHADOWS 1
#define ENABLE_FLOOR 1


raf evaluate_raf(raf rx, raf ry, raf rz, float w, float nan, float inf) {
	// w, nan, inf??
	// function: x^4 - 5x^2 + y^4 - 5y^2 + z^4 - 5z^2 + 11.8
	raf res;
	raf x2, y2, z2, a, b, c;
	x2 = raf_mul(rx, rx);
	a = raf_add(raf_mul(x2, x2), raf_mul_scalar(x2, -5.0f));
	y2 = raf_mul(ry, ry);
	b = raf_add(raf_mul(y2, y2), raf_mul_scalar(y2, -5.0f));
	z2 = raf_mul(rz, rz);
	c = raf_add(raf_mul(z2, z2), raf_mul_scalar(z2, -5.0f));
	res = raf_add(raf_add(a, b), raf_add_scalar(c, 11.8f));
	return res;
}

float4 EvaluateGradient(float4 pos, float w) {
	const float x = pos.x;
	const float y = pos.y;
	const float z = pos.z;

	const float gradX = 4.0f*x*x*x;
	const float gradY = 4.0f*y*y*y;
	const float gradZ = 4.0f*z*z*z;

	return (float4)(gradX, gradY, gradZ, 0.0f);
}

#endif /* USING_OPENCL_FUNCTION */

float TraverseIntersect(float4 penter, float4 pexit, float w, float max_depth,
	float eps, float nan, float inf)
{
	const float4 org = penter;
	const float4 dir = pexit - penter;
	interval t = (interval)(0.0f, 1.0f);
	raf F, it, ix, iy, iz;

	it = interval_to_raf(t);

	ix = raf_add_scalar(raf_mul_scalar(it, dir.x), org.x);
	iy = raf_add_scalar(raf_mul_scalar(it, dir.y), org.y);
	iz = raf_add_scalar(raf_mul_scalar(it, dir.z), org.z);

	F = evaluate_raf(ix, iy, iz, w, nan, inf);
	if(raf_contains(F, 0.0f)) {
		int d = 0;
		float tincr = 0.5f;
		const int dlast = log2(length(dir) / eps);
		float temp;

		for(;;) {
			t.y = t.x + tincr;
			it = interval_to_raf(t);
			ix = raf_add_scalar(raf_mul_scalar(it, dir.x), org.x);
			iy = raf_add_scalar(raf_mul_scalar(it, dir.y), org.y);
			iz = raf_add_scalar(raf_mul_scalar(it, dir.z), org.z);

			F = evaluate_raf(ix, iy, iz, w, nan, inf);
			if(raf_contains(F, 0.0f)) {
			//if(raf_contains_negative(F)) {
				if (d == dlast) return t.x;
				else { tincr *= 0.5f; d++; continue; }
			}
			t.x = t.y;

			float fp = fract(0.5f * t.x / tincr, &temp);
			if(fp < 1e-8f) {
				for(int j=0; j<24; j++) {
					tincr *= 2.0f;
					d--;
					fp = fract(0.5f*t.x/tincr, &temp);
					if(d==-1 || fp > 1e-8f) break;
				}
				if(d==-1) break;
			}
		}
	}
	return -1.0f;
}

mint IntersectBoundingSphere(const float4 eyeRayOrig, const float4 eyeRayDir, float *tmin, float *tmax) {
	const float4 op = -eyeRayOrig;
	const float b = dot(op, eyeRayDir);
	float det = b * b - dot(op, op) + BOUNDING_RADIUS_2;

	if(det < 0.0f) return 0;
	else det = sqrt(det);

	float t1 = b - det;
	float t2 = b + det;
	if(t1 > 0.0f) {
		*tmin = t1;
		*tmax = t2;
		return 1;
	}
	else {
		if(t2 > 0.0f) {
			*tmin = 0.0f;
			*tmax = t2;
			return 1;
		}
		else return 0;
	}
}

mint IntersectFloor(const float4 eyeRayOrig, const float4 eyeRayDir, float* tint) {
	const float4 flooreq = (float4)(0.0f, 1.0f, 0.0f, -FLOOR_POSITION);
	const float4 eyeRayOrigFixed = (float4)(eyeRayOrig.x, eyeRayOrig.y, eyeRayOrig.z, 1.0f);
	const float FdotO = dot(flooreq, eyeRayOrigFixed);
	const float FdotD = dot(flooreq, eyeRayDir);
	*tint = -FdotO/FdotD;
	if(*tint > 0.0f) return 1;
	return 0;
}

static float4 NormEstimate(const float4 p, const float w) {
	/*const float4 qP = p;
	const float4 gx1 = qP - (float4)(delta, 0.0f, 0.0f, 0.0f);
	const float4 gx2 = qP + (float4)(delta, 0.0f, 0.0f, 0.0f);
	const float4 gy1 = qP - (float4)(0.0f, delta, 0.0f, 0.0f);
	const float4 gy2 = qP + (float4)(0.0f, delta, 0.0f, 0.0f);
	const float4 gz1 = qP - (float4)(0.0f, 0.0f, delta, 0.0f);
	const float4 gz2 = qP + (float4)(0.0f, 0.0f, delta, 0.0f);

	const float gradX = EvaluateFunction(gx2) - EvaluateFunction(gx1);
	const float gradY = EvaluateFunction(gy2) - EvaluateFunction(gy1);
	const float gradZ = EvaluateFunction(gz2) - EvaluateFunction(gz1);

	const float4 N = normalize((float4)(gradX, gradY, gradZ, 0.0f));

	return N;*/

	const float4 gradient = EvaluateGradient(p, w);

	const float4 N = normalize(gradient);

	return N;
}

static float4 Phong(const float lightType, const float4 lightPos, const float4 lightDir, const float4 lightParams, const float4 lightAtten, const float4 eye, const float4 pt,
	const float4 N, const float4 diffuse)
{
	/*float orientation = dot(N, pt - eye);
	float4 L = normalize(lightPos - pt);
	float NdotL = dot(N, L);
	if(orientation > 0.0f) NdotL = -NdotL;
	if(NdotL < 0.0f) return (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	const float specularExponent = 30.0f;
	const float specularity = 0.65f;

	float4 E = normalize(eye - pt);
	float4 H = (L + E) * (float)0.5f;

	return diffuse * NdotL + specularity * pow(dot(N, H), specularExponent);*/
	if(lightType < AMBIENT) {
		return diffuse;
	}
	else if(lightType < DIRECTIONAL) {
		float NdotL = -dot(N, normalize(lightDir));
		float orientation = dot(N, pt - eye);
		if(orientation > 0.0f) NdotL = -NdotL;
		if(NdotL < 0.0f) return (float4)(0.0f, 0.0f, 0.0f, 0.0f);

		const float specularExponent = 30.0f;
		const float specularity = 0.65f;

		float4 E = normalize(eye - pt);
		float4 H = (normalize(lightDir) + E) * (float)0.5f;

		return diffuse * NdotL + specularity * pow(dot(N,H), specularExponent);
	}
	else if(lightType < POINT) {
		float4 L = normalize(lightPos - pt);
		float NdotL = dot(N, L);
		float orientation = dot(N, pt - eye);
		if(orientation > 0.0f) NdotL = -NdotL;
		if(NdotL < 0.0f) return (float4)(0.0f, 0.0f, 0.0f, 0.0f);

		const float specularExponent = 30.0f;
		const float specularity = 0.65f;
		float atten = 1.0f;

		float4 E = normalize(eye - pt);
		float4 H = (L + E) * (float)0.5f;


		if(lightAtten.x > 0.001f || lightAtten.y > 0.001f || lightAtten.z > 0.001f) {
			const float dist = length(pt - lightPos);
			//NdotL *= 1.0f / (lightAtten.x + lightAtten.y*dist + lightAtten.z*dist*dist);
			atten = 1.0f / (lightAtten.x + lightAtten.y*dist + lightAtten.z*dist*dist);
		}

		return atten * diffuse * NdotL + atten * specularity * pow(dot(N,H), specularExponent);
	}
	else {
		// spotlight stuff at some point
		// return (float4)(0.0f, 0.0f, 0.0f, 0.0f);
		float4 L = normalize(lightPos - pt);
		float NdotL = dot(N, L);
		float orientation = dot(N, pt - eye);
		if(orientation > 0.0f) NdotL = -NdotL;
		if(NdotL < 0.0f) return (float4)(0.0f, 0.0f, 0.0f, 0.0f);

		const float specularExponent = 30.0f;
		const float specularity = 0.65f;
		float atten = 1.0f;;

		float4 E = normalize(eye - pt);
		float4 H = (L + E) * (float)0.5f;

		const float cosha = cos(lightParams.x);
		if(NdotL < cosha && lightParams.y < 0.001f) return (float4)(0.0f, 0.0f, 0.0f, 0.0f);

		const float spotexp = pow(NdotL, lightParams.y);

		if(lightAtten.x > 0.001f || lightAtten.y > 0.001f || lightAtten.z > 0.001f) {
			const float dist = length(pt - lightPos);
			atten = 1.0f / (lightAtten.x + lightAtten.y*dist + lightAtten.z*dist*dist);
		}

		return atten * diffuse * spotexp * NdotL + atten * specularity * spotexp * pow(dot(N,H), specularExponent);
	}
}

__kernel void IsosurfaceGPU(
	__global float *pixels,
	const __global float *config, // config = {epsilon, camera, w, lights}. Each light is 17 floats. Type is specified by first element, other 16 are parameters (some may be unused).
	const int numLights,
	const unsigned int width,
	const unsigned int height
	)
{
	const int gid = get_global_id(0);
	const unsigned int x = gid % width;
	const int y = gid / width;

	if(y >= height) return;

	const float epsilon = config[0];//0.01f;

	//const float4 light = (float4)(config[17], config[18], config[19], 0.0f);
	// col, pos, dir are obvious. Params is {half-angle, spotlight exponent, 0.0, 0.0}, Atten is {a, b, c, 0.0} for 1/(a + br + cr^2) attenuation.
	float4 lightCol, lightPos, lightDir, lightParams, lightAtten;


	const float w = config[16];

	const float invWidth = 1.0f / width;
	const float invHeight = 1.0f / height;
	const float kcx = x * invWidth - 0.5f;
	const float4 kcx4 = (float4)kcx;
	const float kcy = y * invHeight - 0.5f;
	const float4 kcy4 = (float4)kcy;

	const float4 cameraX = (float4)(config[10], config[11], config[12], 0.0f);
	const float4 cameraY = (float4)(config[13], config[14], config[15], 0.0f);
	const float4 cameraDir = (float4)(config[7], config[8], config[9], 0.0f);
	const float4 cameraOrig = (float4)(config[1], config[2], config[3], 0.0f);

	const float4 eyeRayDir = normalize(cameraX * kcx4 + cameraY * kcy4 + cameraDir);
	const float4 eyeRayOrig = eyeRayDir * (float4)0.1f + cameraOrig;

	// Check bounding sphere

	float4 diffuse, n, color = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	float4 hitPoint;
	float dist, tmin, tmax;
	if(IntersectBoundingSphere(eyeRayOrig, eyeRayDir, &tmin, &tmax)) {
		float4 rayOrig = eyeRayOrig + eyeRayDir * (float4)tmin;
		float4 rayExit = eyeRayOrig + eyeRayDir * (float4)tmax;

		dist = TraverseIntersect(rayOrig, rayExit, w, 0.0f, epsilon, 0.0f, 0.0f);

		if(dist > 0.0f) {
			//diffuse = (float4)(1.0f, 0.35f, 0.15f, 0.0f);
			diffuse = (float4)(1.0f, 1.0f, 1.0f, 0.0f);
			hitPoint = rayOrig + dist * (rayExit - rayOrig);
			n = NormEstimate(hitPoint, w);
		}
		else dist = -1.0f;
	}
	else dist = -1.0f;

	if(dist < 0.0f) {
#if ENABLE_FLOOR
		if(IntersectFloor(eyeRayOrig, eyeRayDir, &dist)) {
			hitPoint = eyeRayOrig + dist * eyeRayDir;
			n = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
			//diffuse = (float4)(0.75f, 0.75f, 0.75f, 0.0f);
			diffuse = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
		}
		else
#endif
			color = (float4)(1.0f, 1.0f, 1.0f, 0.0f);
	}

	if(dist >= 0.0f) {
		for(int i=0; i<numLights; i++) {
			int j = 18+15*i;
			lightCol = (float4)(config[j], config[j+1], config[j+2], 0.0f);
			lightPos = (float4)(config[j+3], config[j+4], config[j+5], 0.0f);
			lightDir = (float4)(config[j+6], config[j+7], config[j+8], 0.0f);
			lightParams = (float4)(config[j+9], config[j+10], 0.0f, 0.0f);
			lightAtten = (float4)(config[j+11], config[j+12], config[j+13], 0.0f);
			color += Phong(config[j-1], lightPos, lightDir, lightParams, lightAtten, eyeRayOrig, hitPoint, n, diffuse) * lightCol;
		}
	}

	int offset = 3 * (x + (height - y - 1) * width);
	color = clamp(color, (float4)(0.0f, 0.0f, 0.0f, 0.0f), (float4)(1.0f, 1.0f, 1.0f, 0.0f));

	pixels[offset++] = color.s0;
	pixels[offset++] = color.s1;
	pixels[offset] = color.s2;
}


// buildOptions=-Itestsuite/ocl/AppKernels/Mathematica -D FLOOR_POSITION=1 -D BOUNDING_RADIUS_2=0.3
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -Itestsuite/ocl/AppKernels/Mathematica -D FLOOR_POSITION=1 -D BOUNDING_RADIUS_2=0.3" %cfg_path --cl-device=%cl_device 2>&1
