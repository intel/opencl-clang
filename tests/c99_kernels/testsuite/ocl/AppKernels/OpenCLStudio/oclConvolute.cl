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

//
// 2D Convolution
//

__kernel void clIso2D(__read_only image2d_t imageIn, __write_only image2d_t imageOut, __constant float* filter, int filterw, int filterh, int imgw, int imgh)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);
    if (x < imgw && y < imgh)
	{
		int rx = filterw/2;
		int ry = filterh/2;
		float4 ds = (float4)0;
		for (int i=-rx; i<=rx; i++)
		{
			for (int j=-ry; j<=ry; j++)
			{
				int lx = min(max(x+i,0),imgw-1);
				int ly = min(max(y+j,0),imgh-1);
				ds += read_imagef(imageIn, sampler, (float2)(lx,ly))*filter[(ry+j)*filterw+(rx+i)];
			}
		}
		write_imagef(imageOut, (int2)(x,y), ds);
	}
}

__kernel void clIso2Dsep(__read_only image2d_t imageIn, __write_only image2d_t imageOut, int2 axis, __constant float* filter, int size, int imgw, int imgh)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);
    if (x < imgw && y < imgh)
	{
		int r = size/2;
		float4 ds = (float4)0;
		for (int i=-r; i<=r; i++)
		{
			int lx = min(max(x+i*axis.x,0),imgw-1);
			int ly = min(max(y+i*axis.y,0),imgh-1);
			ds += read_imagef(imageIn, sampler, (float2)(lx,ly))*filter[i+r];
		}
		write_imagef(imageOut, (int2)(x,y),ds);
	}
}

__kernel void clAniso2Dtang(__read_only image2d_t imageIn, __write_only image2d_t imageOut, __read_only image2d_t vector, __constant float* filter, int size, int imgw, int imgh)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);

    if (x < imgw && y < imgh)
	{
		float2 lMin = (float2)(0,0);
		float2 lMax = (float2)(imgw-1, imgh-1);
		int radius = size/2;

		float2 p = (float2)(x,y);
		float4 dc = read_imagef(imageIn, sampler, p)*filter[radius];
		float4 vc = read_imagef(vector, sampler, p);

		// forward
		float4 dxy = vc;
		p = (float2)(x,y);
		for (int d=1; d<=radius; d++)
		{
			p = clamp(p+dxy.xy, lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			//dc += read_imagef(imageIn, sampler, p)*filter[radius-d];
		}

		// backward
		dxy = vc;
		p = (float2)(x,y);
		for (int d=1; d<=radius; d++)
		{
			p = clamp(p-dxy.xy, lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			//dc += read_imagef(imageIn, sampler, p)*filter[radius+d];
		}

		write_imagef(imageOut, (int2)(x,y), dc);
	}
}

__kernel void clAniso2Dorth(__read_only image2d_t imageIn, __write_only image2d_t imageOut, __read_only image2d_t vector, __constant float* filter, int size, int imgw, int imgh)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);

    if (x < imgw && y < imgh)
	{
		float2 lMin = (float2)(0,0);
		float2 lMax = (float2)(imgw-1, imgh-1);
		int radius = size/2;

		float2 p = (float2)(x,y);
		float4 dc = read_imagef(imageIn, sampler, p)*filter[radius];
		float4 vc = read_imagef(vector, sampler, p);

		// forward
		float4 dxy = vc;
		p = (float2)(x,y);
		for (int d=1; d<=radius; d++)
		{
			p = clamp(p+(float2)(-dxy.y, dxy.x), lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			dc += read_imagef(imageIn, sampler, p)*filter[radius-d];
		}

		// backward
		dxy = vc;
		p = (float2)(x,y);
		for (int d=1; d<=radius; d++)
		{
			p = clamp(p-(float2)(-dxy.y, dxy.x), lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			dc += read_imagef(imageIn, sampler, p)*filter[radius+d];
		}

		write_imagef(imageOut, (int2)(x,y), dc);
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
