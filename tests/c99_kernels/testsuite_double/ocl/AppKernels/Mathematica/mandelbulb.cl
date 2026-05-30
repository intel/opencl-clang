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
#define mint int
#define Real_t double
#define USING_DOUBLE_PRECISIONQ 1
#define MAX_ITERATIONS 100


#define GPU_KERNEL

#define BOUNDING_RADIUS_2 4.f

typedef struct {
	float x, y, z; // position, also color (r,g,b)
} Vec;

#define vinit(v, a, b, c) { (v).x = a; (v).y = b; (v).z = c; }
#define vclr(v) vinit(v, 0.f, 0.f, 0.f)
#define vadd(v, a, b) vinit(v, (a).x + (b).x, (a).y + (b).y, (a).z + (b).z)
#define vsub(v, a, b) vinit(v, (a).x - (b).x, (a).y - (b).y, (a).z - (b).z)
#define vsadd(v, a, b) { float k = (a); vinit(v, (b).x + k, (b).y + k, (b).z + k) }
#define vssub(v, a, b) { float k = (a); vinit(v, (b).x - k, (b).y - k, (b).z - k) }
#define vmul(v, a, b) vinit(v, (a).x * (b).x, (a).y * (b).y, (a).z * (b).z)
#define vsmul(v, a, b) { float k = (a); vinit(v, k * (b).x, k * (b).y, k * (b).z) }
#define vdot(a, b) ((a).x * (b).x + (a).y * (b).y + (a).z * (b).z)
#define vnorm(v) { float l = 1.f / sqrt(vdot(v, v)); vsmul(v, l, v); }
#define vxcross(v, a, b) vinit(v, (a).y * (b).z - (a).z * (b).y, (a).z * (b).x - (a).x * (b).z, (a).x * (b).y - (a).y * (b).x)
#define vfilter(v) ((v).x > (v).y && (v).x > (v).z ? (v).x : (v).y > (v).z ? (v).y : (v).z)
#define viszero(v) (((v).x == 0.f) && ((v).x == 0.f) && ((v).z == 0.f))

#ifndef GPU_KERNEL
#define clamp(x, a, b) ((x) < (a) ? (a) : ((x) > (b) ? (b) : (x)))
#define max(x, y) ( (x) > (y) ? (x) : (y))
#define min(x, y) ( (x) < (y) ? (x) : (y))
#endif

#define toInt(x) ((int)(clamp(x, 0.f, 1.f) * 255.f + .5f))

typedef struct {
	/* User defined values */
	Vec orig, target;
	/* Calculated values */
	Vec dir, x, y;
} Camera;

typedef struct {
	unsigned int width, height;
	int superSamplingSize;
	int actvateFastRendering;
	int enableShadow;

	unsigned int maxIterations;
	float epsilon;
	float mu[4];
	float light[3];
	Camera camera;
} RenderingConfig;

typedef struct {
	unsigned int width, height;
	unsigned int superSamplingSize;
	unsigned int actvateFastRendering;
	unsigned int enableShadow;
	unsigned int maxIterations;
} IntRenderingConfig;

typedef struct {
	float epsilon;
	float mu[4];
	float light[3];
	Camera camera;
} FloatRenderingConfig;

// Scalar derivative approach by Enforcer:
// http://www.fractalforums.com/mandelbulb-implementation/realtime-renderingoptimisations/
static float IterateIntersect(const float4 z0, const float4 c0, const unsigned mint maxIterations) {
	float4 z = z0;
	float4 c = z0;

	float dr = 1.0f;
	float r2 = dot(z, z);
	float r = sqrt(r2);
	for (int n = 0; (n < maxIterations) && (r < 2.f); ++n) {
		const float zo0 = asin(z.z / r);
		const float zi0 = atan2(z.y, z.x);
		float zr = r2 * r2 * r2 * r2;
		const float zo = zo0 * 8.f;
		const float zi = zi0 * 8.f;
		const float czo = cos(zo);

		dr = zr * dr * 8.f + 1.f;
		zr *= r;

		z = zr * (float4)(czo * cos(zi), czo * sin(zi), sin(zo), 0.f);
		z += c;

		r2 = dot(z, z);
		r = sqrt(r2);
	}

	return 0.5f * log(r) * r / dr;
}

static float IntersectBulb(const float4 eyeRayOrig, const float4 eyeRayDir,
		const float4 c, const unsigned mint maxIterations, const float epsilon,
		const float maxDist, float4 *hitPoint, unsigned mint *steps) {
	float dist;
	float4 r0 = eyeRayOrig;
	float distDone = 0.f;

	uint s = 0;
	do {
		dist = IterateIntersect(r0, c, maxIterations);
		distDone += dist;
		// We are inside
		if (dist <= 0.f)
			break;

		r0 += eyeRayDir * dist;
		s++;
	} while ((dist > epsilon) && (distDone < maxDist));

	*hitPoint = r0;
	*steps = s;
	return dist;
}

#define WORLD_RADIUS 1000.f
#define WORLD_CENTER ((float4)(0.f, -WORLD_RADIUS - 2.f, 0.f, 0.f))
float IntersectFloorSphere(const float4 eyeRayOrig, const float4 eyeRayDir) {
	const float4 op = WORLD_CENTER - eyeRayOrig;
	const float b = dot(op, eyeRayDir);
	float det = b * b - dot(op, op) + WORLD_RADIUS * WORLD_RADIUS;

	if (det < 0.f)
		return -1.f;
	else
		det = sqrt(det);

	float t = b - det;
	if (t > 0.f)
		return t;
	else {
		// We are inside, avoid the hit
		return -1.f;
	}
}

int IntersectBoundingSphere(const float4 eyeRayOrig, const float4 eyeRayDir,
		float *tmin, float*tmax) {
	const float4 op = -eyeRayOrig;
	const float b = dot(op, eyeRayDir);
	float det = b * b - dot(op, op) + BOUNDING_RADIUS_2;

	if (det < 0.f)
		return 0;
	else
		det = sqrt(det);

	float t1 = b - det;
	float t2 = b + det;
	if (t1 > 0.f) {
		*tmin = t1;
		*tmax = t2;
		return 1;
	} else {
		if (t2 > 0.f) {
			// We are inside, start from the ray origin
			*tmin = 0.f;
			*tmax = t2;

			return 1;
		} else
			return 0;
	}
}

static float4 NormEstimate(const float4 p, const float4 c,
		const float delta, const unsigned mint maxIterations) {
	const float4 qP = p;
	const float4 gx1 = qP - (float4)(delta, 0.f, 0.f, 0.f);
	const float4 gx2 = qP + (float4)(delta, 0.f, 0.f, 0.f);
	const float4 gy1 = qP - (float4)(0.f, delta, 0.f, 0.f);
	const float4 gy2 = qP + (float4)(0.f, delta, 0.f, 0.f);
	const float4 gz1 = qP - (float4)(0.f, 0.f, delta, 0.f);
	const float4 gz2 = qP + (float4)(0.f, 0.f, delta, 0.f);

	const float gradX = length(IterateIntersect(gx2, c, maxIterations)) -
		length(IterateIntersect(gx1, c, maxIterations));
	const float gradY = length(IterateIntersect(gy2, c, maxIterations)) -
		length(IterateIntersect(gy1, c, maxIterations));
	const float gradZ = length(IterateIntersect(gz2, c, maxIterations)) -
		length(IterateIntersect(gz1, c, maxIterations));

	const float4 N = normalize((float4)(gradX, gradY, gradZ, 0.f));

	return N;
}

static float4 Phong(const float4 light, const float4 eye, const float4 pt,
		const float4 N, const float4 diffuse) {
	const float4 ambient = (float4) (0.05f, 0.05f, 0.05f, 0.f);
	float4 L = normalize(light - pt);
	float NdotL = dot(N, L);
	if (NdotL < 0.f)
		return diffuse * ambient;

	const float specularExponent = 30.f;
	const float specularity = 0.65f;

	float4 E = normalize(eye - pt);
	float4 H = (L + E) * (float)0.5f;

	return diffuse * NdotL +
			specularity * pow(dot(N, H), specularExponent) +
			diffuse * ambient;
}

__kernel void MandelbulbGPU(
	__global float *pixels,
	//const __global RenderingConfig *config,
	const __global FloatRenderingConfig *config,
	const __global IntRenderingConfig *iconfig,
	const int enableAccumulation,
	const float sampleX,
	const float sampleY) {
    const int gid = get_global_id(0);
	const unsigned width = iconfig->width;
	const unsigned height = iconfig->height;

	const unsigned int x = gid % width;
	const int y = gid / width;

	// Check if we have to do something
	if (y >= height)
		return;

	const float epsilon = iconfig->actvateFastRendering ? (config->epsilon * (1.5f / 0.75f)) : config->epsilon;
	const uint maxIterations = iconfig->actvateFastRendering ? (max(3u, iconfig->maxIterations) - 2u) : iconfig->maxIterations;

	const float4 mu = (float4)(config->mu[0], config->mu[1], config->mu[2], config->mu[3]);
	const float4 light = (float4)(config->light[0], config->light[1], config->light[2], 0.f);
	const __global Camera *camera = &config->camera;

	//--------------------------------------------------------------------------
	// Calculate eye ray
	//--------------------------------------------------------------------------

	const float invWidth = 1.f / width;
	const float invHeight = 1.f / height;
	const float kcx = (x + sampleX) * invWidth - .5f;
	const float4 kcx4 = (float4)kcx;
	const float kcy = (y + sampleY) * invHeight - .5f;
	const float4 kcy4 = (float4)kcy;

	const float4 cameraX = (float4)(camera->x.x, camera->x.y, camera->x.z, 0.f);
	const float4 cameraY = (float4)(camera->y.x, camera->y.y, camera->y.z, 0.f);
	const float4 cameraDir = (float4)(camera->dir.x, camera->dir.y, camera->dir.z, 0.f);
	const float4 cameraOrig = (float4)(camera->orig.x, camera->orig.y, camera->orig.z, 0.f);

	const float4 eyeRayDir =  normalize(cameraX * kcx4 + cameraY * kcy4 + cameraDir);
	const float4 eyeRayOrig = eyeRayDir * (float4)0.1f + cameraOrig;

	//--------------------------------------------------------------------------
	// Check if we hit the bounding sphere
	//--------------------------------------------------------------------------

	int useAO = 1;
	float4 diffuse, n, color;

	float4 hitPoint;
	float dist, tmin, tmax;
	if (IntersectBoundingSphere(eyeRayOrig, eyeRayDir, &tmin, &tmax)) {
		//--------------------------------------------------------------------------
		// Find the intersection with the set
		//--------------------------------------------------------------------------

		uint steps;
		float4 rayOrig = eyeRayOrig + eyeRayDir * (float4)tmin;
		dist = IntersectBulb(rayOrig, eyeRayDir, mu, maxIterations,
				epsilon, tmax - tmin, &hitPoint, &steps);

		if (dist <= epsilon) {
			// Set hit
			diffuse = (float4) (1.f, 0.35f, 0.15f, 0.f);
			n = NormEstimate(hitPoint, mu, dist, maxIterations);
		} else
			dist = -1.f;
	} else
		dist = -1.f;

	//--------------------------------------------------------------------------
	// Check if we hit the floor
	//--------------------------------------------------------------------------

	if (dist < 0.f) {
		dist = IntersectFloorSphere(eyeRayOrig, eyeRayDir);

		if (dist >= 0.f) {
			// Floor hit
			hitPoint = eyeRayOrig + eyeRayDir * (float4)dist;
			n = hitPoint - WORLD_CENTER;
			n = normalize(n);
			// The most important feature in a ray tracer: a checker texture !
			const int ix = (hitPoint.x > 0.f) ? hitPoint.x : (1.f - hitPoint.x);
			const int iz = (hitPoint.z > 0.f) ? hitPoint.z : (1.f - hitPoint.z);
			if ((ix + iz) % 2)
				diffuse = (float4) (0.75f, 0.75f, 0.75f, 0.f);
			else
				diffuse = (float4) (0.75f, 0.f, 0.f, 0.f);
			useAO = 0;
		} else {
			// Sky hit
			color = (float4)(0.f, 0.1f, 0.3f, 0.f);
		}
	} else {
		// Sky hit
		color = (float4)(0.f, 0.1f, 0.3f, 0.f);
	}

	//--------------------------------------------------------------------------
	// Select the shadow pass
	//--------------------------------------------------------------------------

	if (dist >= 0.f) {
		float shadowFactor = 1.f;
		if(iconfig->enableShadow) {
			float4 L = normalize(light -  hitPoint);
			float4 rO = hitPoint + n * 1e-2f;
			float4 shadowHitPoint;

			// Check bounding sphere
			if (IntersectBoundingSphere(rO, L, &tmin, &tmax)) {
				float shadowDistSet = tmin;
				uint steps;

				rO = rO + L * (float4)shadowDistSet;
				shadowDistSet = IntersectBulb(rO, L, mu, maxIterations, epsilon,
						tmax - tmin, &shadowHitPoint, &steps);
				if (shadowDistSet < epsilon) {
					if (useAO) {
						// Use steps count to simulate ambient occlusion
						shadowFactor = 0.6f - min(steps / 255.f, 0.5f);
					} else
						shadowFactor = 0.6f;
				}
			}
		}

		//--------------------------------------------------------------------------
		// Direct lighting of hit point
		//--------------------------------------------------------------------------

		color = Phong(light, eyeRayOrig, hitPoint, n, diffuse) * shadowFactor;
	}

	//--------------------------------------------------------------------------
	// Write pixel
	//--------------------------------------------------------------------------

	int offset = 3 * (x + (height - y - 1) * width);
	color = clamp(color, (float4)(0.f, 0.f ,0.f, 0.f), (float4)(1.f, 1.f ,1.f, 0.f));
	if (enableAccumulation) {
		pixels[offset++] += color.s0;
		pixels[offset++] += color.s1;
		pixels[offset] += color.s2;
	} else {
		pixels[offset++] = color.s0;
		pixels[offset++] = color.s1;
		pixels[offset] = color.s2;
	}
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
