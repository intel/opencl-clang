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

__kernel void clSobel(__read_only image2d_t imageIn, __write_only image2d_t dx, __write_only image2d_t dy, int w, int h)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP_TO_EDGE;
    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);

	float kx[3][3] = { { -1.0f, 0.0f,  1.0f},
					   { -2.0f, 0.0f,  2.0f},
					   { -1.0f, 0.0f,  1.0f}};
	float ky[3][3] = { { -1.0f, -2.0f, -1.0f},
					   {  0.0f, 0.0f,  0.0f},
					   {  1.0f, 2.0f,  1.0f}};

    if (x < w && y < h)
	{
		float4 rx = (float4)0;
		float4 ry = (float4)0;
		for(int i = -1; i <= 1; i++)
		{
			for(int j = -1; j <= 1; j++)
			{
				int lx = min(max(x+j, 0), w-1);
				int ly = min(max(y+i, 0), h-1);
				float4 dp = read_imagef(imageIn, sampler, (float2)(lx,ly));
				rx += dp*kx[i+1][j+1];
				ry += dp*ky[i+1][j+1];
			}
		}
		write_imagef(dx, (int2)(x,y), rx);
		write_imagef(dy, (int2)(x,y), ry);
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
