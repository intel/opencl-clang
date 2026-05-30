__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSampler2 = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void ChinesePainting2_RGBtoGray(__read_only image2d_t src, __write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempDst.x = (tempSrc.x + tempSrc.y + tempSrc.z) / 3;

	write_imageui(dst, coord, tempDst);
}

__kernel void ChinesePainting2_Kernel(__read_only image2d_t src, __read_only image2d_t src2, __read_only image2d_t Original, __write_only image2d_t dst, int Threshold)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempSrc2;
	uint4 tempDst;

	float ramp = 0.025f;

	tempSrc = read_imageui(src, imageSampler, coord);
	tempSrc2 = read_imageui(src2, imageSampler2, coord);


	float tempResult = (float)tempSrc.x;

	tempSrc = read_imageui(Original, imageSampler, coord);

	if ((float)tempSrc2.x * (1.0f - ramp) >  tempResult || tempResult == 0.0f)
	{
		tempDst.x = (tempSrc.x + tempSrc.y + tempSrc.z) / 6;
		tempDst.y = tempDst.x;
		tempDst.z = tempDst.x;
	}
	else
	{
		tempResult = sqrt((float)(tempSrc.x * tempSrc.x + tempSrc.y * tempSrc.y + tempSrc.z * tempSrc.z));

		if(tempResult < (float)Threshold)
		{
			tempDst.x = (uint)(tempResult / (float)Threshold * 200.0f);
			tempDst.y = tempDst.x;
			tempDst.z = tempDst.x;
		}
		else
		{
			tempDst.x = 255;
			tempDst.y = 255;
			tempDst.z = 255;
		}

	}

	tempDst.w = 255;

	write_imageui(dst, coord, tempDst);
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
