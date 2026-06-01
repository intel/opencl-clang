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

#define GPU_KERNEL

#include "camera.h"
#include "geomfunc.h"

 void GenerateCameraRay(OCL_CONSTANT_BUFFER Camera *camera,
		unsigned int *seed0, unsigned int *seed1,
		const int width, const int height, const int x, const int y, Ray *ray) {
	const float invWidth = 1.f / width;
	const float invHeight = 1.f / height;
	const float r1 = GetRandom(seed0, seed1) - .5f;
	const float r2 = GetRandom(seed0, seed1) - .5f;
	const float kcx = (x + r1) * invWidth - .5f;
	const float kcy = (y + r2) * invHeight - .5f;

	Vec rdir;
	vinit(rdir,
			camera->x.x * kcx + camera->y.x * kcy + camera->dir.x,
			camera->x.y * kcx + camera->y.y * kcy + camera->dir.y,
			camera->x.z * kcx + camera->y.z * kcy + camera->dir.z);

	Vec rorig;
	vsmul(rorig, 0.1f, rdir);
	vadd(rorig, rorig, camera->orig)

	vnorm(rdir);
	rinit(*ray, rorig, rdir);
}

__kernel void RadianceGPU(
    __global Vec *colors, __global unsigned int *seedsInput,
	OCL_CONSTANT_BUFFER Sphere *sphere, OCL_CONSTANT_BUFFER Camera *camera,
	const unsigned int sphereCount,
	const int width, const int height,
	const int currentSample,
	__global int *pixels) {
    const int gid = get_global_id(0);
	const int gid2 = 2 * gid;
	const int x = gid % width;
	const int y = gid / width;

	/* Check if we have to do something */
	if (y >= height)
		return;

	/* LordCRC: move seed to local store */
	unsigned int seed0 = seedsInput[gid2];
	unsigned int seed1 = seedsInput[gid2 + 1];

	Ray ray;
	GenerateCameraRay(camera, &seed0, &seed1, width, height, x, y, &ray);

	Vec r;
	RadiancePathTracing(sphere, sphereCount, &ray, &seed0, &seed1, &r);

	const int i = (height - y - 1) * width + x;
	if (currentSample == 0) {
		// Jens's patch for MacOS
		vassign(colors[i], r);
	} else {
		const float k1 = currentSample;
		const float k2 = 1.f / (currentSample + 1.f);
		colors[i].x = (colors[i].x * k1  + r.x) * k2;
		colors[i].y = (colors[i].y * k1  + r.y) * k2;
		colors[i].z = (colors[i].z * k1  + r.z) * k2;
	}

	pixels[y * width + x] = toInt(colors[i].x) |
			(toInt(colors[i].y) << 8) |
			(toInt(colors[i].z) << 16);

	seedsInput[gid2] = seed0;
	seedsInput[gid2 + 1] = seed1;
}


// buildOptions=-Itestsuite/ocl/AppKernels/SmallptGPU
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -Itestsuite/ocl/AppKernels/SmallptGPU" %cfg_path --cl-device=%cl_device 2>&1
