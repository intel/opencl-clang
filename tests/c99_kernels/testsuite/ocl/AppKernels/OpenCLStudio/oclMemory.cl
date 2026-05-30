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


__kernel void clMemSetImage(__write_only image2d_t dest, float4 value)
{
	int x = get_global_id(0);
	int y = get_global_id(1);
	write_imagef(dest, (int2)(x,y), value);
}

__kernel void clMemSetBuffer(__global float4* dest, float4 value)
{
	dest[get_global_id(0)] = value;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
