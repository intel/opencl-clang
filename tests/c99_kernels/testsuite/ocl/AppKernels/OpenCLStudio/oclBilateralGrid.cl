// Copyright [2011] [Geist Software Labs Inc.]
// Copyright [2011] [Geist Software Labs Inc.]
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

__kernel void clSplit(__read_only image2d_t image, __global float4* grid, int sw, int sh, float4 mask)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
	int gx = get_global_id(0);
	int gy = get_global_id(1);
	int gz = get_global_id(2);
	int gw = get_global_size(0);
	int gh = get_global_size(1);
	int gd = get_global_size(2);

	float4 slice = (float4)0;
	for (int x=0; x<sw; x++)
	{
		for (int y=0; y<sh; y++)
		{
			float4 RGBA = read_imagef(image, sampler, (int2)(x+gx*sw,y+gy*sh));
			int z = dot(RGBA, mask)*(gd-1) + 0.5;
			if (z == gz)
			{
				RGBA.w = 1.0;
				slice += RGBA;
			}
		}
	}

	int index = gz*gw*gh+gy*gw+gx;
	grid[index] = slice;
}

//
//
//
__kernel void clSlice(__read_only image2d_t srce, float4 mask, __write_only image2d_t dest, __read_only image3d_t grid)
{
	const sampler_t srceSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);
	float4 RGBA = read_imagef(srce, srceSampler, (int2)(x,y));

	float w = get_global_size(0);
	float h = get_global_size(1);
	const sampler_t gridSampler = CLK_NORMALIZED_COORDS_TRUE | CLK_FILTER_LINEAR | CLK_ADDRESS_CLAMP;
	float4 GRID = read_imagef(grid, gridSampler, (float4)(x/w,y/h,dot(RGBA, mask),0));

	GRID.xyz /= GRID.w;
	GRID.w = 1.0;
	write_imagef(dest, (int2)(x,y), GRID);
}

//
//
//

__kernel void clEqualize(__global float4* grid, float4 mask0, int gd, __local float* lut, __local float4* hist)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int gw = get_global_size(0);
	int gh = get_global_size(1);

	float total;

	total = 0;
	for (int z=0; z<gd; z++)
	{
		hist[z] = grid[z*gw*gh+y*gw+x];
		total += hist[z].w;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	float4 mask1; // = as_float4(isequal(mask0, (float4)0.0f));
	mask1.x = mask0.x == 0.0f ? 1.0 : 0.0;
	mask1.y = mask0.y == 0.0f ? 1.0 : 0.0;
	mask1.z = mask0.z == 0.0f ? 1.0 : 0.0;
	mask1.w = mask0.w == 0.0f ? 1.0 : 0.0;

	if (total != 0.0f)
	{
		float sum = 0;
		for (int z=0; z<gd; z++)
		{
			sum += hist[z].w;
			lut[z] = sum/total;
		}

		// dstribution
		for (int z=0; z<gd; z++)
		{
			float4 color = hist[z];
			color = color*mask1 + mask0*(float4)(lut[z]*color.w);
			color.w = hist[z].w;
			grid[z*gw*gh+y*gw+x] = color;
		}
	}
}

//
// 3D Convolution
//

__kernel void clConvolute(__global float4* srce, __global float4* dest, int4 axis, __global float* filter, int size)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	int z = get_global_id(2);
	int sx = get_global_size(0);
	int sy = get_global_size(1);
	int sz = get_global_size(2);

	int limit = size/2;
	float4 DEST = (float4)0;
	for (int i=-limit; i<limit+1; i++)
	{
		int gx = min(max(x+i*axis.x,0),sx-1);
		int gy = min(max(y+i*axis.y,0),sy-1);
		int gz = min(max(z+i*axis.z,0),sz-1);
		float4 SRCE = srce[gz*sx*sy+gy*sx+gx];
		DEST += SRCE*filter[i+limit];
	}
	dest[z*sx*sy+y*sx+x] = DEST;
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
