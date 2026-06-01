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

__kernel void clFilter(__read_only image2d_t RGBAin, __write_only image2d_t RGBAout, float threshold)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_LINEAR | CLK_ADDRESS_CLAMP;

    const int gx = get_global_id(0);
    const int gy = get_global_id(1);

	float2 pixel = (float2)(gx+0.5,gy+0.5);

	float4 RGBA = read_imagef(RGBAin, sampler, pixel);
	//float luminance = dot(vec4(0.27,0.67,0.06,0.0),RGB);
	float luminance = dot((float4)(0.2126,0.7152,0.0722,0.0),RGBA);

	if (luminance <= threshold)
	{
		RGBA = (float4)(0.0,0.0,0.0,0.0);
	}

	write_imagef(RGBAout, (int2)(gx,gy), RGBA);
}

__kernel void clCombine(__read_only image2d_t RGBAin, __read_only image2d_t Bloom, __write_only image2d_t RGBAout, float intensity)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;

    const int gx = get_global_id(0);
    const int gy = get_global_id(1);
    const float gw = get_global_size(0);
    const float gh = get_global_size(1);

	float2 pixel = (float2)(gx,gy);

	float4 RGBA = read_imagef(RGBAin, sampler, pixel);
	float4 BLOOM = read_imagef(Bloom, sampler, pixel)*exp(intensity*dot((float4)(0.2126,0.7152,0.0722,0.0),RGBA));

	write_imagef(RGBAout, (int2)(gx,gy), RGBA + BLOOM);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
