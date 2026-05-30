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

__kernel void mandelGPU(
		__global int *pixels,
		const int width,
		const int height,
		const float scale,
		const float offsetX,
		const float offsetY,
		const int maxIterations
		) {
	const int gid = get_global_id(0);
	const int gid4 = 4 * gid;
	const int maxSize = max(width, height);
	const float kx = (scale / 2.f) * width;
	const float ky = (scale / 2.f) * height;

	int t;
	unsigned int iter[4];
	for (t = 0; t < 4; ++t) {
		const int tid = gid4 + t;

		const int screenX = tid % width;
		const int screenY = tid / width;

		// Check if we have something to do
		if (screenY >= height)
			return;

		const float x0 = ((screenX * scale) - kx) / maxSize + offsetX;
		const float y0 = ((screenY * scale) - ky) / maxSize + offsetY;

		float x = x0;
		float y = y0;
		float x2 = x * x;
		float y2 = y * y;
		for (iter[t] = 0; (x2 + y2 <= 4.f) && (iter[t] < maxIterations); ++iter[t]) {
			y = 2 * x * y + y0;
			x = x2 - y2 + x0;

			x2 = x * x;
			y2 = y * y;
		}

		if (iter[t] == maxIterations)
			iter[t] = 0;
		else {
			iter[t] = iter[t] % 512;
			if (iter[t] > 255)
				iter[t] = 511 - iter[t];
		}
	}

	pixels[gid] = iter[0] |
			(iter[1] << 8) |
			(iter[2] << 16) |
			(iter[3] << 24);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
