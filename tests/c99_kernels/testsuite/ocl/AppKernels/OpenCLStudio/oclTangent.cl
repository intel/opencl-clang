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


//Kyprianidis, J. E., & Döllner, J. (2008). Image Abstraction by Structure Adaptive Filtering. In: Proc.
//EG UK Theory and Practice of Computer Graphics, pp. 51–58.
__kernel void clTangent(__read_only image2d_t dx, __read_only image2d_t dy, __write_only image2d_t dt, int w, int h)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);
    if (x < w && y < h)
	{
		float4 dFx = read_imagef(dx, sampler, (float2)(x,y));
		float4 dFy = read_imagef(dy, sampler, (float2)(x,y));

		float E = dot(dFx,dFx);
		float F = dot(dFx,dFy);
		float G = dot(dFy,dFy);

		float Lambda2 = 0.5*(E+G-sqrt((E-G)*(E-G)+4*F*F));
		write_imagef(dt, (int2)(x,y), (float4)(Lambda2-G, F, 0, 0));
	}
}

__kernel void clLineConv(__read_only image2d_t vector, __read_only image2d_t srce, __write_only image2d_t dest, int depth, int w, int h)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_LINEAR | CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);
    if (x < w && y < h)
	{
		float2 lMin = (float2)(0,0);
		float2 lMax = (float2)(get_global_size(0)-1, get_global_size(1)-1);

		float2 p = (float2)(x,y);
		float4 c = read_imagef(vector, sampler, p);
		float4 result = read_imagef(srce, sampler, p);

		// forward
		float n = 0.25;
		float4 dxy = c;
		p = (float2)(x,y);
		for (int d=0; d<depth; d++)
		{
			p = clamp(p+dxy.xy, lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			result += read_imagef(srce, sampler, p);//*0.5*n;
			n*=0.5;
		}

		// backward
		n = 0.25;
		dxy = c;
		p = (float2)(x,y);
		for (int d=0; d<depth; d++)
		{
			p = clamp(p-dxy.xy, lMin, lMax);
			dxy = read_imagef(vector, sampler, p);
			result += read_imagef(srce, sampler, p);//*0.5*n;
			n*=0.5;
		}

		write_imagef(dest, (int2)(x,y), result/(2*depth+1));
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
