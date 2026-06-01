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

  /**
  * Original code is under
  * ${basedir}/ExtraComponents/Other/mandelbulbGPU-v1.0/rendering_kernel.cl
 **/

#define USING_OPENCL_FUNCTION 1
#define OPENCLLINK_USING_NVIDIA
#define mint int
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100


// This is necessary to make sure it compiles when not being run from OpenCLRun.
#ifndef __MANDELBULB_DEFINES_H__

#include "Mandelbulb_defines.h"

static float IterateIntersect(const float4 z0, const float4 c0, const unsigned mint maxIterations) {
	return IterateIntersectTriplex(z0, c0, maxIterations);
}

#endif /* __MANDELBULB_DEFINES_H__ */

// Basically ray marching, but isntead of a fixed step forward, we step forward by the distance estimate
static float IntersectFractal(const float4 eyeRayOrig, const float4 eyeRayDir, const float4 c, const unsigned mint maxIterations, const float epsilon, const float maxDist, float4 *hitPoint, unsigned mint *steps) {
	float dist;
	float4 r0 = eyeRayOrig;
	float distDone = 0.0f;

	uint s = 0;
	do {
		dist = IterateIntersect(r0, c, maxIterations);
		distDone += dist;
		if(dist <= 0.0f) break;
		r0 += eyeRayDir * dist;
		s++;
	} while((dist > epsilon) && (distDone < maxDist));

	*hitPoint = r0;
	*steps = s;
	return dist;
}

// Simple ray/sphere intersection
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

// Simple ray/plane intersection
mint IntersectFloor(const float4 eyeRayOrig, const float4 eyeRayDir, float* tint) {
	const float4 flooreq = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
	const float FdotO = dot(flooreq, eyeRayOrig);
	const float FdotD = dot(flooreq, eyeRayDir);
	*tint = (FLOOR_POSITION - FdotO)/FdotD;
	if(*tint > 0.0f) return 1;
	return 0;
}

// Give a "surface normal" for phong shading by estimating the gradient of the distance estimator
// Can take the gradient of the actual iterated function instead, but that seems to fall apart when maxIterations > ~10
static float4 NormEstimate(const float4 p, const float4 c, const float delta, const unsigned mint maxIterations) {
	const float4 qP = p;
	const float4 gx1 = qP - (float4)(delta, 0.0f, 0.0f, 0.0f);
	const float4 gx2 = qP + (float4)(delta, 0.0f, 0.0f, 0.0f);
	const float4 gy1 = qP - (float4)(0.0f, delta, 0.0f, 0.0f);
	const float4 gy2 = qP + (float4)(0.0f, delta, 0.0f, 0.0f);
	const float4 gz1 = qP - (float4)(0.0f, 0.0f, delta, 0.0f);
	const float4 gz2 = qP + (float4)(0.0f, 0.0f, delta, 0.0f);

	const float gradX = length(IterateIntersect(gx2, c, maxIterations)) - length(IterateIntersect(gx1, c, maxIterations));
	const float gradY = length(IterateIntersect(gy2, c, maxIterations)) - length(IterateIntersect(gy1, c, maxIterations));
	const float gradZ = length(IterateIntersect(gz2, c, maxIterations)) - length(IterateIntersect(gz1, c, maxIterations));

	const float4 N = normalize((float4)(gradX, gradY, gradZ, 0.0f));

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


__kernel void MandelbulbGPU(
	__global float *pixels,
	const __global float *config,
	const uint maxIterations,
	const int enableAccumulation,
	const float sampleX,
	const float sampleY,
	const unsigned int width,
	const unsigned int height,
	const unsigned int numLights)
{
	const int gid = get_global_id(0);

	const unsigned int x = gid % width;
	const int y = gid / width;

	if(y >= height) return;

	const float epsilon = config[0];

	const float4 mu = (float4)(config[1], config[2], config[3], config[4]);
	//const float4 light = (float4)(config[25], config[26], config[27], 0.0f);
	// col, pos, dir are obvious. Params is {half-angle, spotlight exponent, 0.0, 0.0}, Atten is {a, b, c, 0.0} for 1/(a + br + cr^2) attenuation.
	float4 lightCol, lightPos, lightDir, lightParams, lightAtten;

	// Calculate eye ray

	const float invWidth = 1.0f / width;
	const float invHeight = 1.0f / height;
	const float kcx = (x + sampleX) * invWidth - 0.5f;
	const float4 kcx4 = (float4)kcx;
	const float kcy = (y + sampleY) * invHeight - 0.5f;
	const float4 kcy4 = (float4)kcy;

	const float4 cameraX = (float4)(config[17], config[18], config[19], config[20]);
	const float4 cameraY = (float4)(config[21], config[22], config[23], config[24]);
	const float4 cameraDir = (float4)(config[13], config[14], config[15], config[16]);
	const float4 cameraOrig = (float4)(config[5], config[6], config[7], config[8]);

	const float4 eyeRayDir = normalize(cameraX * kcx4 + cameraY * kcy4 + cameraDir);
	const float4 eyeRayOrig = eyeRayDir * (float4)0.1f + cameraOrig;

	// Not much to see from here on out. Simply hard coded to ray trace the fractal and (if it misses) the floor plane and cast a shadow.

	int useAO = 1;
	float4 diffuse, n, color;

	float4 hitPoint;
	float dist, tmin, tmax;
	if(IntersectBoundingSphere(eyeRayOrig, eyeRayDir, &tmin, &tmax)) {
		unsigned int steps;
		float4 rayOrig = eyeRayOrig + eyeRayDir * (float4)tmin;

		dist = IntersectFractal(rayOrig, eyeRayDir, mu, maxIterations, epsilon, tmax - tmin, &hitPoint, &steps);

		if(dist <= epsilon) {
			diffuse = (float4)(COLOR_R, COLOR_G, COLOR_B, 0.0f);
			n = NormEstimate(hitPoint, mu, dist, maxIterations);
		}
		else dist = -1.0f;
	}
	else dist = -1.0f;

	if(dist < 0.0f) {
#if ENABLE_FLOOR
		if(IntersectFloor(eyeRayOrig, eyeRayDir, &dist)) {
			hitPoint = eyeRayOrig + dist * eyeRayDir;
			n = (float4)(0.0f, 1.0f, 0.0f, 0.0f);
			diffuse = (float4)(0.75f, 0.75f, 0.75f, 0.0f);
			useAO = 0;
		}
		else color = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
#else
		color = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
#endif
	}

	if(dist >= 0.0f) {
		float shadowFactor = 1.0f;
		/*if(ENABLE_SHADOW) {
			float4 L = normalize(light - hitPoint);
			float4 r0 = hitPoint + n * 1e-2f;
			float4 shadowHitPoint;

			if(IntersectBoundingSphere(r0, L, &tmin, &tmax)) {
				float shadowDistSet = tmin;
				unsigned int steps;

				r0 = r0 + L * (float4)shadowDistSet;
				shadowDistSet = IntersectFractal(r0, L, mu, maxIterations, epsilon, tmax - tmin, &shadowHitPoint, &steps);
				if(shadowDistSet < epsilon) {
					if(useAO) shadowFactor = 0.3f - min(steps / 255.0f, 0.2f);
					else shadowFactor = 0.2f;
				}
			}
		}*/
		for(int i=0; i<numLights; i++) {
			int j = 26 + 15*i;
			lightCol = (float4)(config[j], config[j+1], config[j+2], 0.0f);
			lightPos = (float4)(config[j+3], config[j+4], config[j+5], 0.0f);
			lightDir = (float4)(config[j+6], config[j+7], config[j+8], 0.0f);
			lightParams = (float4)(config[j+9], config[j+10], 0.0f, 0.0f);
			lightAtten = (float4)(config[j+11], config[j+12], config[j+13], 0.0f);

			if(ENABLE_SHADOW && config[j-1] > DIRECTIONAL) {
				float4 L = normalize(lightPos - hitPoint);
				float4 r0 = hitPoint + n * 1e-2f;
				float4 shadowHitPoint;

				if(IntersectBoundingSphere(r0, L, &tmin, &tmax)) {
					float shadowDistSet = tmin;
					unsigned int steps;

					r0 = r0 + L * (float4)shadowDistSet;
					shadowDistSet = IntersectFractal(r0, L, mu, maxIterations, epsilon, tmax - tmin, &shadowHitPoint, &steps);
					if(shadowDistSet < epsilon) {
						if(useAO) shadowFactor = 0.3f - min(steps / 255.0f, 0.2f);
						else shadowFactor = 0.2f;
					}
				}
			}

			color += Phong(config[j-1], lightPos, lightDir, lightParams, lightAtten, eyeRayOrig, hitPoint, n, diffuse) * lightCol * shadowFactor;
		}
	}
	int offset = 3 * (x + (height - y - 1) * width);
	color = clamp(color, (float4)(0.0f, 0.0f, 0.0f, 0.0f), (float4)(1.0f, 1.0f, 1.0f, 0.0f));
	if(enableAccumulation) {
		pixels[offset++] += color.s0;
		pixels[offset++] += color.s1;
		pixels[offset] += color.s2;
	}
	else {
		pixels[offset++] = color.s0;
		pixels[offset++] = color.s1;
		pixels[offset] = color.s2;
	}
}


// buildOptions=-Itestsuite/ocl/AppKernels/Mathematica -D FLOOR_POSITION=1 -D COLOR_R=100 -D COLOR_G=100 -D COLOR_B=100 -D ENABLE_SHADOW=1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -Itestsuite/ocl/AppKernels/Mathematica -D FLOOR_POSITION=1 -D COLOR_R=100 -D COLOR_G=100 -D COLOR_B=100 -D ENABLE_SHADOW=1" %cfg_path --cl-device=%cl_device 2>&1
