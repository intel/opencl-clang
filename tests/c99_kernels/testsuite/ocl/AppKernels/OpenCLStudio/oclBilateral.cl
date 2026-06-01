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

float gaussian(float4 center, float4 sample, float4 mask, float scalar)
{
	float sRange = dot(sample,mask);
	float cRange = dot(center,mask);

	// range domain
	float r2 = scalar*(cRange-sRange);
	float gr = exp(-r2*r2);

	// spatial domain
	float s2 = sRange*sRange;
	float gs = exp(-s2);

	return gs*gr;
}

__kernel void clIso2D(__read_only image2d_t imageIn, __write_only image2d_t imageOut, int r, float range, float4 mask, int w, int h)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);

    if (x < w && y < h)
	{
        float4 nom = 0.0f;
        float4 den = 0.0f;
		float scalar = 0.5/(range*range);

        float4 dc = read_imagef(imageIn, sampler, (float2)(x,y));
		for(int i = -r; i <= r; i++)
		{
			for(int j = -r; j <= r; j++)
			{
				int lx = min(max(x+j, 0), w-1);
				int ly = min(max(y+i, 0), h-1);
				float4 dp = read_imagef(imageIn, sampler, (float2)(lx,ly));

				float factor = gaussian(dc,dp,mask,scalar);
				nom += dp * factor;
				den += factor;
			}
		}

		write_imagef(imageOut, (int2)(x,y), (float4)(nom/den));
	}
}

__kernel void clAniso2Dtang(__read_only image2d_t imageIn, __write_only image2d_t imageOut, int radius, float range, __read_only image2d_t vector, float4 mask, int w, int h)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);

    if (x < w && y < h)
	{
		float2 lMin = (float2)(0,0);
		float2 lMax = (float2)(w-1, h-1);
		float scalar = 0.5/(range*range);

		float2 p = (float2)(x,y);
		float4 dc = read_imagef(imageIn, sampler, p);
        float4 nom = dc;
        float4 den = 1.0;

		float4 c = read_imagef(vector, sampler, p);

		// forward
		float4 dxy = c;
		p = (float2)(x,y);
		for (int d=1; d<radius; d++)
		{
			p = clamp(p+dxy.xy, lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			float4 dp = read_imagef(imageIn, sampler, p);
			float factor = gaussian(dc,dp,mask,scalar);
			nom += dp * factor;
			den += factor;
		}

		// backward
		dxy = c;
		p = (float2)(x,y);
		for (int d=1; d<radius; d++)
		{
			p = clamp(p-dxy.xy, lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			float4 dp = read_imagef(imageIn, sampler, p);
			float factor = gaussian(dc,dp,mask,scalar);
			nom += dp * factor;
			den += factor;
		}

		write_imagef(imageOut, (int2)(x,y), (float4)(nom/den));
	}
}

__kernel void clAniso2Dorth(__read_only image2d_t imageIn, __write_only image2d_t imageOut, int radius, float range, __read_only image2d_t vector, float4 mask, int w, int h)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);

    if (x < w && y < h)
	{
		float2 lMin = (float2)(0,0);
		float2 lMax = (float2)(w-1, h-1);
		float scalar = 0.5/(range*range);

		float2 p = (float2)(x,y);
		float4 dc = read_imagef(imageIn, sampler, p);
        float4 nom = dc;
        float4 den = 1.0;

		float4 c = read_imagef(vector, sampler, p);

		// forward
		float4 dxy = c;
		p = (float2)(x,y);
		for (int d=1; d<=radius; d++)
		{
			p = clamp(p+(float2)(-dxy.y, dxy.x), lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			float4 dp = read_imagef(imageIn, sampler, p);
			float factor = gaussian(dc,dp,mask,scalar);
			nom += dp * factor;
			den += factor;
		}

		// backward
		dxy = c;
		p = (float2)(x,y);
		for (int d=1; d<=radius; d++)
		{
			p = clamp(p-(float2)(-dxy.y, dxy.x), lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			float4 dp = read_imagef(imageIn, sampler, p);
			float factor = gaussian(dc,dp,mask,scalar);
			nom += dp * factor;
			den += factor;
		}

		write_imagef(imageOut, (int2)(x,y), (float4)(nom/den));
	}
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
