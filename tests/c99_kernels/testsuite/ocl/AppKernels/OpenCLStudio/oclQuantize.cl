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

__kernel void clQuantizeLAB(__read_only image2d_t srce, __write_only image2d_t dest, float binL, float binA, float binB, float sharpness)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);
	float4 LAB = read_imagef(srce, sampler, (int2)(x,y));

	float bL = LAB.x - fmod(LAB.x, binL) + binL/2.0;
	float bA = LAB.y - fmod(LAB.y, binA) + binA/2.0;
	float bB = LAB.z - fmod(LAB.z, binB) + binB/2.0;
	LAB.x = bL + binL/2.0f*tanh(sharpness*(LAB.x - bL));
	LAB.y = bA + binA/2.0f*tanh(sharpness*(LAB.y - bA));
	LAB.z = bB + binB/2.0f*tanh(sharpness*(LAB.z - bB));

	write_imagef(dest, (int2)(x,y), LAB);
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
