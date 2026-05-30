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
__kernel void clSample(__read_only image2d_t RGBDin, __read_only image2d_t NNNSin, __write_only image2d_t RGBDout)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_LINEAR | CLK_ADDRESS_CLAMP;

    const int gx = get_global_id(0);
    const int gy = get_global_id(1);
    const int gw = get_global_size(0);
    const int gh = get_global_size(1);

	float2 pixel = (float2)(gx+0.5,gy+0.5);

	float4 RGBD = read_imagef(RGBDin, sampler, pixel);
	float4 NNNS = read_imagef(NNNSin, sampler, pixel);

	float pixelDepth = RGBD.w;
	float result = 1.0;
	int count = 0;
	if (pixelDepth != 0)
	{
		for (int x=-2; x<3; x++)
		{
			for (int y=-2; y<3; y++)
			{
				if (NNNS.x*x + NNNS.y*y > 0)
				{
					float4 sample = read_imagef(RGBDin, sampler, pixel+(float2)(x,y));
					float sampleDepth = sample.w;

					float zd = clamp(fabs(pixelDepth-sampleDepth), 0.0f, pixelDepth*0.007f)/(pixelDepth*0.007f);
					result += 1.0f/(1.0f+zd*zd);
					count++;
				}
			}
		}
		result/=count;
	}

	RGBD.xyz *= result;
	RGBD.w = pixelDepth;

	write_imagef(RGBDout, (int2)(gx,gy), RGBD);
}

__kernel void clSlice(__read_only image2d_t RGBDin, __read_only image2d_t NNNSin, __write_only image2d_t RGBDout)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_LINEAR | CLK_ADDRESS_CLAMP;

    const int gx = get_global_id(0);
    const int gy = get_global_id(1);
    const int gw = get_global_size(0);
    const int gh = get_global_size(1);

	float2 pixel = (float2)(gx+0.5,gy+0.5);

	float4 RGBD = read_imagef(RGBDin, sampler, pixel);
	float4 NNNS = read_imagef(NNNSin, sampler, pixel);

	float pixelDepth = RGBD.w;
	float result = 1.0;
	int count = 0;
	if (pixelDepth != 0)
	{
		for (int x=-2; x<3; x++)
		{
			for (int y=-2; y<3; y++)
			{
				if (NNNS.x*x + NNNS.y*y > 0)
				{
					float4 sample = read_imagef(RGBDin, sampler, pixel+(float2)(x,y));
					float sampleDepth = sample.w;

					float zd = clamp(fabs(pixelDepth-sampleDepth), 0.0f, pixelDepth*0.007f)/(pixelDepth*0.007f);
					result += 1.0f/(1.0f+zd*zd);
					count++;
				}
			}
		}
		result/=count;
	}

	RGBD.xyz *= result;
	RGBD.w = pixelDepth;

	write_imagef(RGBDout, (int2)(gx,gy), RGBD);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
