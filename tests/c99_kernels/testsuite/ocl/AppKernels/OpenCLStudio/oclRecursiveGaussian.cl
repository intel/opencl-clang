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

__kernel void clRecursiveGaussian(__read_only image2d_t valIn,
								  __write_only image2d_t valOut,
								  uint iWidth, uint iHeight, uint2 dxy,
								  float a0, float a1,
								  float a2, float a3,
								  float b1, float b2,
								  float coefp, float coefn)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;

    unsigned int c = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
	if (c >= iWidth*dxy.y + iHeight*dxy.x)
	{
		return;
	}

	float4 lumOut[1024];

	uint limit = iWidth*dxy.x + iHeight*dxy.y;
	uint sx = c*dxy.y;
	uint sy = c*dxy.x;

    // forward filter pass
    float4 xp = read_imagef(valIn, sampler, (float2)(sx,sy));
    float4 yp = xp * coefp;
    float4 yb = yp;
    for (int i=0; i<limit; i++)
    {
		float4 xc = read_imagef(valIn, sampler, (int2)(sx,sy));
		float4 yc = (xc * a0) + (xp * a1) - (yp * b1) - (yb * b2);
		lumOut[i] = yc;
		xp = xc;
		yb = yp;
		yp = yc;
 		sx += dxy.x;
		sy += dxy.y;
   }

    // reverse filter pass
	sx -= dxy.x;
	sy -= dxy.y;
    float4 xn = read_imagef(valIn, sampler, (int2)(sx,sy));
    float4 xa = xn;
    float4 yn = xn * coefn;
    float4 ya = yn;
    for (int i=limit-1; i >= 0; i--)
    {
		float4 xc = read_imagef(valIn, sampler, (int2)(sx,sy));
        float4 yc = (xn * a2) + (xa * a3) - (yn * b1) - (ya * b2);
        xa = xn;
        xn = xc;
        ya = yn;
        yn = yc;
		lumOut[i] = lumOut[i] + yc;
		sx -= dxy.x;
		sy -= dxy.y;
    }


	sx = c*dxy.y;
	sy = c*dxy.x;
    for (int i=0; i<limit; i++)
    {
		write_imagef(valOut, (int2)(sx+i*dxy.x,sy+i*dxy.y), lumOut[i]);
	}

	write_imagef(valOut, (int2)(sx,sy), (float4)0);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
