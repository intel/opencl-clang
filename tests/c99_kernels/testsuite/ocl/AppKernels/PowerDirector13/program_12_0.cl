__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

#define SATURATION_R	13926		// 65536 * 0.2125
#define SATURATION_G	46884		// 65536 * 0.7154
#define SATURATION_B	 4725		// 65536 * 0.0721

__kernel void ColorCrayon_Global(__read_only image2d_t input, __write_only image2d_t output, int width, int height)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int2 FinalCoord = (int2)(get_global_id(0), get_global_id(1));

	int h = get_global_id(1);
	int w = get_global_id(0);

	uint tempVector1;
	uint tempVector2;
	uint tempVector3;
	uint tempVector4;
	uint tempVector5;
	uint tempVector6;
	uint tempVector7;
	uint tempVector8;
	uint tempVector9;
	uint temp;

	uint4 tempSrc;

	if((w < 1) || (h < 1) || (w > (width - 2)) || (h > (height - 2)))
	{
		tempSrc = read_imageui(input, imageSampler, FinalCoord);
		write_imageui(output, FinalCoord, tempSrc);
	}
	else
	{
		coord = (int2)(w - 1, h - 1);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector1 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);

		coord = (int2)(w, h - 1);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector2 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);

		coord = (int2)(w + 1, h - 1);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector3 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);

		coord = (int2)(w - 1, h);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector4 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);

		coord = (int2)(w, h);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector5 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);

		coord = (int2)(w + 1, h);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector6 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);

		coord = (int2)(w - 1, h + 1);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector7 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);

		coord = (int2)(w, h + 1);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector8 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);

		coord = (int2)(w + 1, h + 1);
		tempSrc = read_imageui(input, imageSampler, coord);
		tempVector9 = ((int)tempSrc.w << 24) | ((int)tempSrc.z << 16) | ((int)tempSrc.y << 8) | ((int)tempSrc.x);


		/////mnmx6(tempVector1, tempVector2, tempVector3, tempVector4, tempVector5, tempVector6);
		/////mnmx6 start

		//s2(a, d);
		temp = tempVector1;
		tempVector1 = min(tempVector1, tempVector4);
		tempVector4 = max(temp, tempVector4);

		//s2(b, e);
		temp = tempVector2;
		tempVector2 = min(tempVector2, tempVector5);
		tempVector5 = max(temp, tempVector5);

	    //s2(c, f);
		temp = tempVector3;
		tempVector3 = min(tempVector3, tempVector6);
		tempVector6 = max(temp, tempVector6);

	    //mn3(a, b, c);  ==> s2(a, b); s2(a, c);
		temp = tempVector1;
		tempVector1 = min(tempVector1, tempVector2);
		tempVector2 = max(temp, tempVector2);

		temp = tempVector1;
		tempVector1 = min(tempVector1, tempVector3);
		tempVector3 = max(temp, tempVector3);

	    //mx3(d, e, f);  ==> s2(e, f); s2(d, f);
		temp = tempVector5;
		tempVector5 = min(tempVector5, tempVector6);
		tempVector6 = max(temp, tempVector6);

		temp = tempVector4;
		tempVector4 = min(tempVector4, tempVector6);
		tempVector6 = max(temp, tempVector6);
		/////mnmx6 end


		/////mnmx5(tempVector2, tempVector3, tempVector4, tempVector5, tempVector7) ==>
		/////s2(tempVector2, tempVector3); s2(tempVector4, tempVector5); mn3(tempVector2, tempVector4, tempVector7); mx3(tempVector3, tempVector5, tempVector7);

		/////mnmx5 start
		//s2(tempVector2, tempVector3);
		temp = tempVector2;
		tempVector2 = min(tempVector2, tempVector3);
		tempVector3 = max(temp, tempVector3);

		//s2(tempVector4, tempVector5);
		temp = tempVector4;
		tempVector4 = min(tempVector4, tempVector5);
		tempVector5 = max(temp, tempVector5);

		//mn3(tempVector2, tempVector4, tempVector7); ==> s2(tempVector2, tempVector4); s2(tempVector2, tempVector7);
		temp = tempVector2;
		tempVector2 = min(tempVector2, tempVector4);
		tempVector4 = max(temp, tempVector4);

		temp = tempVector2;
		tempVector2 = min(tempVector2, tempVector7);
		tempVector7 = max(temp, tempVector7);

		//mx3(tempVector3, tempVector5, tempVector7); ==> s2(tempVector5, tempVector7); s2(tempVector3, tempVector7);
		temp = tempVector5;
		tempVector5 = min(tempVector5, tempVector7);
		tempVector7 = max(temp, tempVector7);

		temp = tempVector3;
		tempVector3 = min(tempVector3, tempVector7);
		tempVector7 = max(temp, tempVector7);

		/////mnmx5 end


		/////mnmx4(tempVector3, tempVector4, tempVector5, tempVector8) ==>
		/////s2(tempVector3, tempVector4); s2(tempVector5, tempVector8); s2(tempVector3, tempVector5); s2(tempVector4, tempVector8);

		/////mnmx4 start
		//s2(tempVector3, tempVector4);
		temp = tempVector3;
		tempVector3 = min(tempVector3, tempVector4);
		tempVector4 = max(temp, tempVector4);

		//s2(tempVector5, tempVector8);
		temp = tempVector5;
		tempVector5 = min(tempVector5, tempVector8);
		tempVector8 = max(temp, tempVector8);

		//s2(tempVector3, tempVector5);
		temp = tempVector3;
		tempVector3 = min(tempVector3, tempVector5);
		tempVector5 = max(temp, tempVector5);

		//s2(tempVector4, tempVector8);
		temp = tempVector4;
		tempVector4 = min(tempVector4, tempVector8);
		tempVector8 = max(temp, tempVector8);

		/////mnmx4 end

		/////mnmx3(tempVector4, tempVector5, tempVector9) ==> mx3(tempVector4, tempVector5, tempVector9); s2(tempVector4, tempVector5);
		/////   ==> s2(tempVector5, tempVector9); s2(tempVector4, tempVector9); s2(tempVector4, tempVector5);
		/////mnmx3 start
		//s2(tempVector5, tempVector9);
		temp = tempVector5;
		tempVector5 = min(tempVector5, tempVector9);
		tempVector9 = max(temp, tempVector9);

		//s2(tempVector4, tempVector9);
		temp = tempVector4;
		tempVector4 = min(tempVector4, tempVector9);
		tempVector9 = max(temp, tempVector9);

		//s2(tempVector4, tempVector5);
		temp = tempVector4;
		tempVector4 = min(tempVector4, tempVector5);
		tempVector5 = max(temp, tempVector5);

		/////mnmx3 end


		tempSrc.x = (tempVector5 & 0x000000ff);
		tempSrc.y = ((tempVector5 & 0x0000ff00) >> 8);
		tempSrc.z = ((tempVector5 & 0x00ff0000) >> 16);
	//	tempSrc.w = ((tempVector5 & 0xff000000) >> 24);

		write_imageui(output, FinalCoord, tempSrc);


	}

}

__kernel void ColorCrayon_Gray(__read_only image2d_t src, __write_only image2d_t dst)
{

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;

	tempSrc = read_imageui(src, imageSampler, coord);

	tempSrc.w = (13926 * (int)tempSrc.z + 46885 * (int)tempSrc.y + 4725 * (int)tempSrc.x) >> 16;

	write_imageui(dst, coord, tempSrc);

}

__kernel void ColorCrayon_Sharpness(__read_only image2d_t input, __read_only image2d_t TextureFile, __read_only image2d_t src, __write_only image2d_t output, int width, int height)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int2 FinalCoord = (int2)(get_global_id(0), get_global_id(1));

	uint4 tempSrc;
	uint4 tempDst;
	float SharpValue = (float)width / (float)352;

	uint4 tempAlpha;
	tempAlpha = read_imageui(src, imageSampler, FinalCoord);

	int w = get_global_id(0);
	int h = get_global_id(1);

	float fAdjust1 = 1.2f;
	float fAdjust2 = 1.5f;


	float4 SharpnessValue = {0.0f, 0.0f, 0.0f, 0.0f};

	if((w < 1) || (h < 1) || (w > (width - 2)) || (h > (height - 2)))
	{
		tempSrc = read_imageui(input, imageSampler, FinalCoord);
	}
	else
	{
		coord = (int2)(w, h - 1);
		tempSrc = read_imageui(input, imageSampler, coord);
		SharpnessValue.x += (float)tempSrc.x * -SharpValue;
		SharpnessValue.y += (float)tempSrc.y * -SharpValue;
		SharpnessValue.z += (float)tempSrc.z * -SharpValue;

		coord = (int2)(w - 1, h);
		tempSrc = read_imageui(input, imageSampler, coord);
		SharpnessValue.x += (float)tempSrc.x * -SharpValue;
		SharpnessValue.y += (float)tempSrc.y * -SharpValue;
		SharpnessValue.z += (float)tempSrc.z * -SharpValue;

		coord = (int2)(w, h);
		tempSrc = read_imageui(input, imageSampler, coord);
		SharpnessValue.x += (float)tempSrc.x * (SharpValue * 4.0f + 1.0f);
		SharpnessValue.y += (float)tempSrc.y * (SharpValue * 4.0f + 1.0f);
		SharpnessValue.z += (float)tempSrc.z * (SharpValue * 4.0f + 1.0f);

		coord = (int2)(w + 1, h);
		tempSrc = read_imageui(input, imageSampler, coord);
		SharpnessValue.x += (float)tempSrc.x * -SharpValue;
		SharpnessValue.y += (float)tempSrc.y * -SharpValue;
		SharpnessValue.z += (float)tempSrc.z * -SharpValue;

		coord = (int2)(w, h + 1);
		tempSrc = read_imageui(input, imageSampler, coord);
		SharpnessValue.x += (float)tempSrc.x * -SharpValue;
		SharpnessValue.y += (float)tempSrc.y * -SharpValue;
		SharpnessValue.z += (float)tempSrc.z * -SharpValue;

		tempSrc.x = (uint)SharpnessValue.x;
		tempSrc.y = (uint)SharpnessValue.y;
		tempSrc.z = (uint)SharpnessValue.z;

	}

	float fTemp = 0.5f + fAdjust1 * ((float)tempSrc.x - 0.5f);
	tempSrc.x = (uint)(fTemp >= 255 ? 255 : fTemp);
	fTemp = 0.5f + fAdjust1 * ((float)tempSrc.y - 0.5f);
	tempSrc.y = (uint)(fTemp >= 255 ? 255 : fTemp);
	fTemp = 0.5f + fAdjust1 * ((float)tempSrc.z - 0.5f);
	tempSrc.z = (uint)(fTemp >= 255 ? 255 : fTemp);

	// Set saturation:
	float fGrey = (float)(((int)tempSrc.z * SATURATION_R + (int)tempSrc.y * SATURATION_G + (int)tempSrc.x * SATURATION_B) >> 16);
	fTemp = fGrey + fAdjust2 * ((float)tempSrc.x - fGrey);
	tempSrc.x = (uint)(fTemp >= 255 ? 255 : (fTemp <0? 0:fTemp) );
	fTemp = fGrey + fAdjust2 * ((float)tempSrc.y - fGrey);
	tempSrc.y = (uint)(fTemp >= 255 ? 255 : (fTemp <0? 0:fTemp) );
	fTemp = fGrey + fAdjust2 * ((float)tempSrc.z - fGrey);
	tempSrc.z = (uint)(fTemp >= 255 ? 255 : (fTemp <0? 0:fTemp) );


	float ratio = (float)352/(float)width;
	int iRatio = (int)(ratio * 65536.0f);

	int TextureW = (((w * iRatio) >> 16) - (((w * iRatio) >> 24) << 8));
	int TextureH = (((h * iRatio) >> 16) - (((h * iRatio) >> 24) << 8));

	coord = (int2)(TextureW, TextureH);
	tempDst = read_imageui(TextureFile, imageSampler, coord);

	tempSrc.x = ( ((int)tempSrc.x << 5) + ((int)tempSrc.x << 6) + ((int)tempDst.x << 5) ) >> 7;
	tempSrc.y = ( ((int)tempSrc.y << 5) + ((int)tempSrc.y << 6) + ((int)tempDst.x << 5) ) >> 7;
	tempSrc.z = ( ((int)tempSrc.z << 5) + ((int)tempSrc.z << 6) + ((int)tempDst.x << 5) ) >> 7;
	tempSrc.w = tempAlpha.w;

	write_imageui(output, FinalCoord, tempSrc);


}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
