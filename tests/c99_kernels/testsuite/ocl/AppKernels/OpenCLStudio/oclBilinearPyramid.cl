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


__kernel void clDownsample(__read_only image2d_t imageIn, __write_only image2d_t imageOut, int imgw, int imgh)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_TRUE | CLK_FILTER_LINEAR | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);
    if (x < imgw && y < imgh)
	{
		float dw = 1.0/imgw;
		float dh = 1.0/imgh;
		float sx = x*dw+0.5*dw;
		float sy = y*dh+0.5*dh;
		float4 sample = read_imagef(imageIn, sampler, (float2)(sx,sy));
		write_imagef(imageOut, (int2)(x,y), sample);
	}
}

__kernel void clUpsample(__read_only image2d_t imageIn, __write_only image2d_t imageOut, int imgw, int imgh)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_TRUE | CLK_FILTER_LINEAR | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);
    if (x < imgw && y < imgh)
	{
		float dw = 1.0/imgw;
		float dh = 1.0/imgh;
		float sx = x*dw+0.5*dw;
		float sy = y*dh+0.5*dh;
		float4 sample = read_imagef(imageIn, sampler, (float2)(sx,sy));
		write_imagef(imageOut, (int2)(x,y), sample);
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
