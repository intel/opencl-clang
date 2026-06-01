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

__kernel void clCombine(__read_only image2d_t imageIn, __read_only image2d_t resultIn, __read_only image2d_t level0, __read_only image2d_t level1, int level, __write_only image2d_t resultOut)
{
    const sampler_t sampler = CLK_NORMALIZED_COORDS_TRUE | CLK_FILTER_LINEAR | CLK_ADDRESS_CLAMP_TO_EDGE;

    const int x = get_global_id(0);
    const int y = get_global_id(1);
    const int w = get_global_size(0);
    const int h = get_global_size(1);

    float2 pixel = (float2)((x+0.5)/w,(y+0.5)/h);
	float4 l0 = read_imagef(level0, sampler, pixel);
	float4 l1 = read_imagef(level1, sampler, pixel);

	float lum0 = l0.x/100.0;
	float lum1 = l1.x/100.0;

	float scale = min(0.35f, 0.35f*1.6f*(level));
	float lumX = 0.18*pow(2.0f,8.0f)/scale;
	float activity = (lum0-lum1)/(lumX+lum0);

	if (fabs(activity) > 0.00005)
	{
		float4 result = read_imagef(resultIn, sampler, pixel);
		if (result.x == 0)
		{
			float4 image = read_imagef(imageIn, sampler, pixel);
			image.x = image.x/(100.0f*(1.0f+l0.x));
			write_imagef(resultOut, (int2)(x,y),image);
		}
	}

	/*
	if (l1.x-l0.x != 0)
	{
		write_imagef(resultOut, (int2)(x,y),(float4)(100,40,0,1));
	}
	else
	{
		write_imagef(resultOut, (int2)(x,y),(float4)(0,0,90,1));
	}
	*/

	//float4 image = read_imagef(imageIn, sampler, pixel);
	//write_imagef(resultOut, (int2)(x,y),fabs(l1-l0)*10000);

}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
