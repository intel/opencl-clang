__kernel void RGB32toYUV32(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{

	//Y  = ( 1053 * R + 2064 * G +  401 * B +  67584 ) >> 12;		// 65536 -> 16 x 2^12
	//Cb = ( -606 * R - 1192 * G + 1798 * B + 526336 ) >> 12;		// 524288 -> 128 x2^12
	//Cr = ( 1798 * R - 1507 * G -  291 * B + 526336 ) >> 12;
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w + h * DstStride;

	uchar4 tempSrc_RGB;
	uchar4 tempDst_YUV;
	tempSrc_RGB = src[SrcIndex];

	tempDst_YUV.z = ((1053 * (int)tempSrc_RGB.z + 2064 * (int)tempSrc_RGB.y +  401 * (int)tempSrc_RGB.x +  67584) >> 12);
	tempDst_YUV.y = ((-606 * (int)tempSrc_RGB.z - 1192 * (int)tempSrc_RGB.y + 1798 * (int)tempSrc_RGB.x + 526336) >> 12);
	tempDst_YUV.x = ((1798 * (int)tempSrc_RGB.z - 1507 * (int)tempSrc_RGB.y -  291 * (int)tempSrc_RGB.x + 526336) >> 12);
	tempDst_YUV.w = tempSrc_RGB.w;

	dst[DstIndex] = tempDst_YUV;

}

__kernel void YUV32toRGB32(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w + h * DstStride;

	uchar4 tempSrc_YUV;
	uchar4 tempDst_RGB;
	int4   tempResult;
	int4   tempDst;
	tempSrc_YUV = src[SrcIndex];

	tempResult.z = (int)tempSrc_YUV.z - 16;
	tempResult.y = (int)tempSrc_YUV.y - 128;
	tempResult.x = (int)tempSrc_YUV.x - 128;

	tempDst.z = (4768 * tempResult.z             + 6537 * tempResult.x + 2048 ) >> 12;
	tempDst.y = (4768 * tempResult.z - 1602 * tempResult.y - 3330 * tempResult.x + 2048 ) >> 12;
	tempDst.x = (4768 * tempResult.z + 8266 * tempResult.y             + 2048 ) >> 12;

	tempResult.x = max(min(tempDst.x, 255), 0);
	tempResult.y = max(min(tempDst.y, 255), 0);
	tempResult.z = max(min(tempDst.z, 255), 0);

	tempDst_RGB.x = tempResult.x;
	tempDst_RGB.y = tempResult.y;
	tempDst_RGB.z = tempResult.z;
	tempDst_RGB.w = tempSrc_YUV.w;

	dst[DstIndex] = tempDst_RGB;
}

__kernel void RGB32toYUY2(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	if(w%2 == 1)
		return;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w/2 + h * DstStride;

	uchar4 tempSrc_RGB;
	uchar4 tempSrc_RGB2;
	uchar4 tempDst_YUV;
	tempSrc_RGB = src[SrcIndex+1];
	tempSrc_RGB2 = src[SrcIndex];

	tempDst_YUV.z = (((short)0x083a * tempSrc_RGB.z                                 + (short)0x1020 * tempSrc_RGB.y                                  +  (short)0x0322 * tempSrc_RGB.x                                 +  0x00021000) >> 13);
	tempDst_YUV.y = (((short)0xfda2 * (tempSrc_RGB.z + tempSrc_RGB2.z) + (short)0xfb58 * (tempSrc_RGB.y + tempSrc_RGB2.y) + (short)0x0706 * (tempSrc_RGB.x + tempSrc_RGB2.x) + 0x00101000) >> 13);
	tempDst_YUV.x = (((short)0x083a * tempSrc_RGB2.z                                + (short)0x1020 * tempSrc_RGB2.y                                +  (short)0x0322 * tempSrc_RGB2.x                               +  0x00021000) >> 13);
	tempDst_YUV.w = (((short)0x0706 * (tempSrc_RGB.z + tempSrc_RGB2.z) + (short)0xfa1d * (tempSrc_RGB.y + tempSrc_RGB2.y) +  (short)0xfedd * (tempSrc_RGB.x + tempSrc_RGB2.x) + 0x00101000) >> 13);

	dst[DstIndex] = tempDst_YUV;
}

__kernel void YUY2toRGB32(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w * 2 + h * DstStride;

	uchar4 tempSrc_YUY2 = src[SrcIndex];
	uchar4 tempDst_RGB;
	uchar4 tempDst_RGB2;
	int4   tempResult;
	int4   tempResult2;
	int4   tempDst;
	int4   tempDst2;

	tempResult.z = (int)tempSrc_YUY2.z - 16;
	tempResult.y = (int)tempSrc_YUY2.y - 128;
	tempResult.x = (int)tempSrc_YUY2.w - 128;

	tempResult2.z = (int)tempSrc_YUY2.x - 16;
	tempResult2.y = (int)tempSrc_YUY2.y - 128;
	tempResult2.x = (int)tempSrc_YUY2.w - 128;

	tempDst.z = (4768 * tempResult.z                                     + 6537 * tempResult.x + 2048 ) >> 12;
	tempDst.y = (4768 * tempResult.z - 1602 * tempResult.y - 3330 * tempResult.x + 2048 ) >> 12;
	tempDst.x = (4768 * tempResult.z + 8266 * tempResult.y                                     + 2048 ) >> 12;

	tempDst2.z = (4768 * tempResult2.z                                       + 6537 * tempResult2.x + 2048 ) >> 12;
	tempDst2.y = (4768 * tempResult2.z - 1602 * tempResult2.y - 3330 * tempResult2.x + 2048 ) >> 12;
	tempDst2.x = (4768 * tempResult2.z + 8266 * tempResult2.y                                       + 2048 ) >> 12;

	tempResult.x = max(min(tempDst.x, 255), 0);
	tempResult.y = max(min(tempDst.y, 255), 0);
	tempResult.z = max(min(tempDst.z, 255), 0);

	tempResult2.x = max(min(tempDst2.x, 255), 0);
	tempResult2.y = max(min(tempDst2.y, 255), 0);
	tempResult2.z = max(min(tempDst2.z, 255), 0);

	tempDst_RGB.x = tempResult.x;
	tempDst_RGB.y = tempResult.y;
	tempDst_RGB.z = tempResult.z;
	tempDst_RGB.w = 255;

	tempDst_RGB2.x = tempResult2.x;
	tempDst_RGB2.y = tempResult2.y;
	tempDst_RGB2.z = tempResult2.z;
	tempDst_RGB2.w = 255;

	dst[DstIndex] = tempDst_RGB2;
	dst[DstIndex+1] = tempDst_RGB;
}

__kernel void YUV32toYUY2(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	if(w%2 == 1)
		return;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w/2 + h * DstStride;

	uchar4 tempSrc_YUV = src[SrcIndex+1];
	uchar4 tempSrc_YUV2 = src[SrcIndex];
	uchar4 tempDst_YUY2;

	tempDst_YUY2.z = tempSrc_YUV.z;
	tempDst_YUY2.y = (tempSrc_YUV.y + tempSrc_YUV2.y) / 2;
	tempDst_YUY2.x = tempSrc_YUV2.z;
	tempDst_YUY2.w = (tempSrc_YUV.x + tempSrc_YUV2.x) / 2;

	dst[DstIndex] = tempDst_YUY2;
}

__kernel void YUY2toYUV32(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w * 2 + h * DstStride;

	uchar4 tempSrc_YUY2 = src[SrcIndex];
	uchar4 tempDst_YUV;
	uchar4 tempDst_YUV2;

	tempDst_YUV.x = tempSrc_YUY2.w;
	tempDst_YUV.y = tempSrc_YUY2.y;
	tempDst_YUV.z = tempSrc_YUY2.z;
	tempDst_YUV.w = 255;

	tempDst_YUV2.x = tempSrc_YUY2.w;
	tempDst_YUV2.y = tempSrc_YUY2.y;
	tempDst_YUV2.z = tempSrc_YUY2.x;
	tempDst_YUV2.w = 255;

	dst[DstIndex] = tempDst_YUV2;
	dst[DstIndex+1] = tempDst_YUV;
}

__kernel void RGB32toYofYV12(__global const uchar4* src, __global uchar* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w + h * DstStride;

	uchar4 tempSrc = src[SrcIndex];
	uchar tempDst;

	tempDst = (( (short)0x083a * tempSrc.z + (short)0x1020 * tempSrc.y + (short)0x0322 * tempSrc.x + 0x00021000) >> 13);

	dst[DstIndex] = tempDst;
}

__kernel void RGB32toUofYV12(__global const uchar4* src, __global uchar* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	if(h%2 == 1)
		return;

	if(w%2 == 1)
		return;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w/2 + h/2 * DstStride;

	uchar4 tempSrcTL = src[SrcIndex];							// TL = top left
	uchar4 tempSrcTR = src[SrcIndex+1];						// TR = top right
	uchar4 tempSrcBL = src[SrcIndex+SrcStride];			// BL = bottom left
	uchar4 tempSrcBR = src[SrcIndex+SrcStride+1];		// BR = bottom right
	uchar tempDstTop;
	uchar tempDstBottom;
	uchar tempDst;

	tempDstTop = (( (short)0xfda2 * (tempSrcTL.z + tempSrcTR.z) + (short)0xfb58 * (tempSrcTL.y + tempSrcTR.y) + (short)0x0706 * (tempSrcTL.x + tempSrcTR.x) + 0x00101000) >> 13);
	tempDstBottom = (( (short)0xfda2 * (tempSrcBL.z + tempSrcBR.z) + (short)0xfb58 * (tempSrcBL.y + tempSrcBR.y) + (short)0x0706 * (tempSrcBL.x + tempSrcBR.x) + 0x00101000) >> 13);

	tempDst = (tempDstTop + tempDstBottom) / 2;

	dst[DstIndex] = tempDst;
}

__kernel void RGB32toVofYV12(__global const uchar4* src, __global uchar* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	if(h%2 == 1)
		return;

	if(w%2 == 1)
		return;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w/2 + h/2 * DstStride;

	uchar4 tempSrcTL = src[SrcIndex];							// TL = top left
	uchar4 tempSrcTR = src[SrcIndex+1];						// TR = top right
	uchar4 tempSrcBL = src[SrcIndex+SrcStride];			// BL = bottom left
	uchar4 tempSrcBR = src[SrcIndex+SrcStride+1];		// BR = bottom right
	uchar tempDstTop;
	uchar tempDstBottom;
	uchar tempDst;

	tempDstTop = (( (short)0x0706 * (tempSrcTL.z + tempSrcTR.z) + (short)0xfa1d * (tempSrcTL.y + tempSrcTR.y) + (short)0xfedd * (tempSrcTL.x + tempSrcTR.x) + 0x00101000) >> 13);
	tempDstBottom = (( (short)0x0706 * (tempSrcBL.z + tempSrcBR.z) + (short)0xfa1d * (tempSrcBL.y + tempSrcBR.y) + (short)0xfedd * (tempSrcBL.x + tempSrcBR.x) + 0x00101000) >> 13);

	tempDst = (tempDstTop + tempDstBottom) / 2;

	dst[DstIndex] = tempDst;
}

__kernel void YofYV12toYUV32(__global const uchar* oclY, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w + h * DstStride;

	uchar tempY = oclY[SrcIndex];

	dst[DstIndex].z = tempY;
	dst[DstIndex].w = 255;
}

__kernel void VofYV12toYUV32(__global const uchar* oclV, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w * 2 + h * DstStride * 2;

	uchar tempV = oclV[SrcIndex];

	dst[DstIndex].x = tempV;
	dst[DstIndex + 1].x = tempV;
	dst[DstIndex + DstStride].x = tempV;
	dst[DstIndex + DstStride + 1].x = tempV;
}

__kernel void UofYV12toYUV32(__global const uchar* oclU, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w * 2 + h * DstStride * 2;

	uchar tempU = oclU[SrcIndex];

	dst[DstIndex].y = tempU;
	dst[DstIndex + 1].y = tempU;
	dst[DstIndex + DstStride].y = tempU;
	dst[DstIndex + DstStride + 1].y = tempU;
}

__kernel void YUV32toYofYV12(__global const uchar4* src, __global uchar* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w + h * DstStride;

	uchar4 tempSrc = src[SrcIndex];

	dst[DstIndex] = tempSrc.z;
}

__kernel void YUV32toUofYV12(__global const uchar4* src, __global uchar* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	if(h%2 == 1)
		return;

	if(w%2 == 1)
		return;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w/2 + h/2 * DstStride;

	uchar4 tempSrcTL = src[SrcIndex];							// TL = top left
	uchar4 tempSrcTR = src[SrcIndex+1];						// TR = top right
	uchar4 tempSrcBL = src[SrcIndex+SrcStride];			// BL = bottom left
	uchar4 tempSrcBR = src[SrcIndex+SrcStride+1];		// BR = bottom right
	uchar tempDstTop;
	uchar tempDstBottom;
	uchar tempDst;

	tempDstTop = (tempSrcTL.y + tempSrcTR.y) / 2;
	tempDstBottom = (tempSrcBL.y + tempSrcBR.y) / 2;

	tempDst = (tempDstTop + tempDstBottom) / 2;

	dst[DstIndex] = tempDst;
}

__kernel void YUV32toVofYV12(__global const uchar4* src, __global uchar* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int index = get_global_id(0);

	int w = index % SrcWidth;
	int h = index / SrcWidth;

	if(h%2 == 1)
		return;

	if(w%2 == 1)
		return;

	int SrcIndex = w + h * SrcStride;
	int DstIndex = w/2 + h/2 * DstStride;

	uchar4 tempSrcTL = src[SrcIndex];							// TL = top left
	uchar4 tempSrcTR = src[SrcIndex+1];						// TR = top right
	uchar4 tempSrcBL = src[SrcIndex+SrcStride];			// BL = bottom left
	uchar4 tempSrcBR = src[SrcIndex+SrcStride+1];		// BR = bottom right
	uchar tempDstTop;
	uchar tempDstBottom;
	uchar tempDst;

	tempDstTop = (tempSrcTL.x + tempSrcTR.x) / 2;
	tempDstBottom = (tempSrcBL.x + tempSrcBR.x) / 2;

	tempDst = (tempDstTop + tempDstBottom) / 2;

	dst[DstIndex] = tempDst;
}

__kernel void RGB32toRGB24(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int IndexForSrc = get_global_id(0) * 4;
	int IndexForDst = get_global_id(0) * 3;

	int w = IndexForSrc % SrcWidth;
	int h = IndexForSrc / SrcWidth;
	int SrcIndex_1 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_1 = src[SrcIndex_1];

	w = (IndexForSrc + 1) % SrcWidth;
	h = (IndexForSrc + 1) / SrcWidth;
	int SrcIndex_2 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_2 = src[SrcIndex_2];

	w = (IndexForSrc + 2) % SrcWidth;
	h = (IndexForSrc + 2) / SrcWidth;
	int SrcIndex_3 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_3 = src[SrcIndex_3];

	w = (IndexForSrc + 3) % SrcWidth;
	h = (IndexForSrc + 3) / SrcWidth;
	int SrcIndex_4 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_4 = src[SrcIndex_4];

	w = IndexForDst % SrcWidth;
	h = IndexForDst / SrcWidth;
	int DstIndex_1 = w + h * DstStride;

	w = (IndexForDst + 1) % SrcWidth;
	h = (IndexForDst + 1) / SrcWidth;
	int DstIndex_2 = w + h * DstStride;

	w = (IndexForDst + 2) % SrcWidth;
	h = (IndexForDst + 2) / SrcWidth;
	int DstIndex_3 = w + h * DstStride;

	uchar4 tempDst_RGB32_24_1;
	uchar4 tempDst_RGB32_24_2;
	uchar4 tempDst_RGB32_24_3;

	tempDst_RGB32_24_1.x = tempSrc_RGB32_1.x;
	tempDst_RGB32_24_1.y = tempSrc_RGB32_1.y;
	tempDst_RGB32_24_1.z = tempSrc_RGB32_1.z;
	tempDst_RGB32_24_1.w = tempSrc_RGB32_2.x;

	tempDst_RGB32_24_2.x = tempSrc_RGB32_2.y;
	tempDst_RGB32_24_2.y = tempSrc_RGB32_2.z;
	tempDst_RGB32_24_2.z = tempSrc_RGB32_3.x;
	tempDst_RGB32_24_2.w = tempSrc_RGB32_3.y;

	tempDst_RGB32_24_3.x = tempSrc_RGB32_3.z;
	tempDst_RGB32_24_3.y = tempSrc_RGB32_4.x;
	tempDst_RGB32_24_3.z = tempSrc_RGB32_4.y;
	tempDst_RGB32_24_3.w = tempSrc_RGB32_4.z;

	dst[DstIndex_1] = tempDst_RGB32_24_1;
	dst[DstIndex_2] = tempDst_RGB32_24_2;
	dst[DstIndex_3] = tempDst_RGB32_24_3;
}

__kernel void RGB32toRGB24_Rest(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int IndexForSrc = SrcWidth * SrcHeight / 4 * 4;
	int IndexForDst = SrcWidth * SrcHeight / 4 * 3;

	int w = IndexForSrc % SrcWidth;
	int h = IndexForSrc / SrcWidth;
	int SrcIndex_1 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_1 = src[SrcIndex_1];

	w = (IndexForSrc + 1) % SrcWidth;
	h = (IndexForSrc + 1) / SrcWidth;
	int SrcIndex_2 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_2 = src[SrcIndex_2];

	w = IndexForDst % SrcWidth;
	h = IndexForDst / SrcWidth;
	int DstIndex_1 = w + h * DstStride;

	w = (IndexForDst + 1) % SrcWidth;
	h = (IndexForDst + 1) / SrcWidth;
	int DstIndex_2 = w + h * DstStride;

	uchar4 tempDst_RGB32_24_1;

	tempDst_RGB32_24_1.x = tempSrc_RGB32_1.x;
	tempDst_RGB32_24_1.y = tempSrc_RGB32_1.y;
	tempDst_RGB32_24_1.z = tempSrc_RGB32_1.z;
	tempDst_RGB32_24_1.w = tempSrc_RGB32_2.x;

	dst[DstIndex_1] = tempDst_RGB32_24_1;
	dst[DstIndex_2].x = tempSrc_RGB32_2.y;
	dst[DstIndex_2].y = tempSrc_RGB32_2.z;
}

__kernel void RGB24toRGB32(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int IndexForSrc = get_global_id(0) * 3;
	int IndexForDst = get_global_id(0) * 4;

	int w = IndexForSrc % SrcWidth;
	int h = IndexForSrc / SrcWidth;
	int SrcIndex_1 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_1 = src[SrcIndex_1];

	w = (IndexForSrc + 1) % SrcWidth;
	h = (IndexForSrc + 1) / SrcWidth;
	int SrcIndex_2 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_2 = src[SrcIndex_2];

	w = (IndexForSrc + 2) % SrcWidth;
	h = (IndexForSrc + 2) / SrcWidth;
	int SrcIndex_3 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_3 = src[SrcIndex_3];

	w = IndexForDst % SrcWidth;
	h = IndexForDst / SrcWidth;
	int DstIndex_1 = w + h * DstStride;

	w = (IndexForDst + 1) % SrcWidth;
	h = (IndexForDst + 1) / SrcWidth;
	int DstIndex_2 = w + h * DstStride;

	w = (IndexForDst + 2) % SrcWidth;
	h = (IndexForDst + 2) / SrcWidth;
	int DstIndex_3 = w + h * DstStride;

	w = (IndexForDst + 3) % SrcWidth;
	h = (IndexForDst + 3) / SrcWidth;
	int DstIndex_4 = w + h * DstStride;

	uchar4 tempDst_RGB24_32_1;
	uchar4 tempDst_RGB24_32_2;
	uchar4 tempDst_RGB24_32_3;
	uchar4 tempDst_RGB24_32_4;

	tempDst_RGB24_32_1.x = tempSrc_RGB32_1.x;
	tempDst_RGB24_32_1.y = tempSrc_RGB32_1.y;
	tempDst_RGB24_32_1.z = tempSrc_RGB32_1.z;
	tempDst_RGB24_32_1.w = 255;

	tempDst_RGB24_32_2.x = tempSrc_RGB32_1.w;
	tempDst_RGB24_32_2.y = tempSrc_RGB32_2.x;
	tempDst_RGB24_32_2.z = tempSrc_RGB32_2.y;
	tempDst_RGB24_32_2.w = 255;

	tempDst_RGB24_32_3.x = tempSrc_RGB32_2.z;
	tempDst_RGB24_32_3.y = tempSrc_RGB32_2.w;
	tempDst_RGB24_32_3.z = tempSrc_RGB32_3.x;
	tempDst_RGB24_32_3.w = 255;

	tempDst_RGB24_32_4.x = tempSrc_RGB32_3.y;
	tempDst_RGB24_32_4.y = tempSrc_RGB32_3.z;
	tempDst_RGB24_32_4.z = tempSrc_RGB32_3.w;
	tempDst_RGB24_32_4.w = 255;

	dst[DstIndex_1] = tempDst_RGB24_32_1;
	dst[DstIndex_2] = tempDst_RGB24_32_2;
	dst[DstIndex_3] = tempDst_RGB24_32_3;
	dst[DstIndex_4] = tempDst_RGB24_32_4;
}

__kernel void RGB24toRGB32_Rest(__global const uchar4* src, __global uchar4* dst, int SrcWidth, int SrcHeight, int SrcStride, int DstStride)
{
	int IndexForSrc = SrcWidth * SrcHeight / 4 * 3;
	int IndexForDst = SrcWidth * SrcHeight / 4 * 4;

	int w = IndexForSrc % SrcWidth;
	int h = IndexForSrc / SrcWidth;
	int SrcIndex_1 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_1 = src[SrcIndex_1];

	w = (IndexForSrc + 1) % SrcWidth;
	h = (IndexForSrc + 1) / SrcWidth;
	int SrcIndex_2 = w + h * SrcStride;
	uchar4 tempSrc_RGB32_2;
	tempSrc_RGB32_2.x = src[SrcIndex_2].x;
	tempSrc_RGB32_2.y = src[SrcIndex_2].y;

	w = IndexForDst % SrcWidth;
	h = IndexForDst / SrcWidth;
	int DstIndex_1 = w + h * DstStride;

	w = (IndexForDst + 1) % SrcWidth;
	h = (IndexForDst + 1) / SrcWidth;
	int DstIndex_2 = w + h * DstStride;

	uchar4 tempDst_RGB24_32_1;
	uchar4 tempDst_RGB24_32_2;

	tempDst_RGB24_32_1.x = tempSrc_RGB32_1.x;
	tempDst_RGB24_32_1.y = tempSrc_RGB32_1.y;
	tempDst_RGB24_32_1.z = tempSrc_RGB32_1.z;
	tempDst_RGB24_32_1.w = 255;

	tempDst_RGB24_32_2.x = tempSrc_RGB32_1.w;
	tempDst_RGB24_32_2.y = tempSrc_RGB32_2.x;
	tempDst_RGB24_32_2.z = tempSrc_RGB32_2.y;
	tempDst_RGB24_32_2.w = 255;

	dst[DstIndex_1] = tempDst_RGB24_32_1;
	dst[DstIndex_2] = tempDst_RGB24_32_2;
}

__kernel void FillColorToBuffer(__global uchar4* dst, int DstWidth, int DstHeight, int DstStride, int dwColor, int nOffset)
{
	int index = get_global_id(0);

	int w = index % DstWidth;
	int h = index / DstWidth;

	int DstIndex = w + h * DstStride + nOffset;

	uchar B = dwColor & 0x000000ff;
	uchar G = (dwColor & 0x0000ff00) >> 8;
	uchar R = (dwColor & 0x00ff0000) >> 16;
	uchar A = (dwColor & 0xff000000) >> 24;

	uchar4 tempDst;
	tempDst.z = R;
	tempDst.y = G;
	tempDst.x = B;
	tempDst.w = A;

	dst[DstIndex] = tempDst;
}

__kernel void FillColorToLine(__global uchar4* dst, int DstWidth, int dwColor)
{
	int index = get_global_id(0);

	uchar B = dwColor & 0x000000ff;
	uchar G = (dwColor & 0x0000ff00) >> 8;
	uchar R = (dwColor & 0x00ff0000) >> 16;
	uchar A = (dwColor & 0xff000000) >> 24;

	uchar4 tempDst;
	tempDst.z = R;
	tempDst.y = G;
	tempDst.x = B;
	tempDst.w = A;

	dst[index] = tempDst;
}

__kernel void RGB32_InterpolateSegment(__global uchar4* src1, __global uchar4* src2, __global uchar4* dst)
{
	int index = get_global_id(0);

	uchar4 tempSrc1 = src1[index];
	uchar4 tempSrc2 = src2[index];
	uchar4 tempDst;

	tempDst.z = (tempSrc1.z + tempSrc2.z) / 2;
	tempDst.y = (tempSrc1.y + tempSrc2.y) / 2;
	tempDst.x = (tempSrc1.x + tempSrc2.x) / 2;
	tempDst.w = (tempSrc1.w + tempSrc2.w) / 2;

	dst[index] = tempDst;
}

__kernel void Stretch_Nearest_RGB32(__global uchar4* Dst, int DstWidth, int DstHeight, int DstStride,
				    __global uchar4* Src, int SrcWidth, int SrcHeight, int SrcStride,
				    int fxSrcXStep, int fxSrcYStep,
				    int SrcMarginX, int SrcMarginY, int DstMarginX, int DstMarginY)
{
	int w = get_global_id(0);
	int h = get_global_id(1);

	int fxX = w * fxSrcXStep;
	int fxY = h * fxSrcYStep;

	int x = fxX >> 16;
	int y = fxY >> 16;

	int DstIndex = w + DstMarginX + (h + DstMarginY) * DstStride;
	int SrcIndex = x + SrcMarginX + (y + SrcMarginY) * SrcStride;

	Dst[DstIndex] = Src[SrcIndex];

}

__kernel void Stretch_Coverage_RGB32(__global uchar4* Dst, int DstWidth, int DstHeight, int DstStride,
				    __global uchar4* Src, int SrcWidth, int SrcHeight, int SrcStride,
				    int fxSrcXStep, int fxSrcYStep,
				    int SrcMarginX, int SrcMarginY, int DstMarginX, int DstMarginY,
				    int nInnerXStep, int nInnerYStep)
{
	int w = get_global_id(0);
	int h = get_global_id(1);

	int fxX = w * fxSrcXStep;
	int fxY = h * fxSrcYStep;

	int x_shift = 0;
	int y_shift = 0;


	int nSum_R = 0;
	int nSum_G = 0;
	int nSum_B = 0;
	int nSum_A = 0;

	uchar4 tempSrc;

	y_shift = fxY;
	for(int i = 0; i < 4; i++)
	{
		x_shift = fxX;
		for(int j = 0; j < 4; j++)
		{
			int x = x_shift >> 16;
			int y = y_shift >> 16;

			tempSrc = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];

			nSum_B += (int)tempSrc.x;
			nSum_G += (int)tempSrc.y;
			nSum_R += (int)tempSrc.z;
			nSum_A += (int)tempSrc.w;

			x_shift += nInnerXStep;
		}

		y_shift += nInnerYStep;
	}

	nSum_R = nSum_R >> 4;
	nSum_G = nSum_G >> 4;
	nSum_B = nSum_B >> 4;
	nSum_A = nSum_A >> 4;

	int DstIndex = w + DstMarginX + (h + DstMarginY) * DstStride;

	tempSrc.x = nSum_B;
	tempSrc.y = nSum_G;
	tempSrc.z = nSum_R;
	tempSrc.w = nSum_A;

	Dst[DstIndex] = tempSrc;

}

__kernel void Stretch_Bilinear_RGB32(__global uchar4* Dst, int DstWidth, int DstHeight, int DstStride,
				     __global uchar4* Src, int SrcWidth, int SrcHeight, int SrcStride,
				     int fxSrcXStep, int fxSrcYStep,
				     int SrcMarginX, int SrcMarginY, int DstMarginX, int DstMarginY)
{
	int w = get_global_id(0);
	int h = get_global_id(1);

	int fxX = w * fxSrcXStep;
	int fxY = h * fxSrcYStep;

	uchar4 Src_Iac;
	uchar4 Src_Ibc;
	uchar4 Src_Iad;
	uchar4 Src_Ibd;

	int x = fxX >> 16;
	int y = fxY >> 16;
	Src_Iac = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];


	x = (fxX + 65536) >> 16;
	y = fxY >> 16;
	Src_Ibc = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];

	x = fxX >> 16;
	y = (fxY + 65536) >> 16;
	Src_Iad = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];

	x = (fxX + 65536) >> 16;
	y = (fxY + 65536) >> 16;
	Src_Ibd = Src[x + SrcMarginX + (y + SrcMarginY) * SrcStride];

	int Weight_X = fxX & 0x0000FFFF;
	int Weight_Y = fxY & 0x0000FFFF;

	int h1_B = (int)(Src_Iac.x) + (((int)(Src_Ibc.x) - (int)(Src_Iac.x)) * Weight_X >> 16);
 	int h2_B = (int)(Src_Iad.x) + (((int)(Src_Ibd.x) - (int)(Src_Iad.x)) * Weight_X >> 16);

 	int h1_G = (int)(Src_Iac.y) + (((int)(Src_Ibc.y) - (int)(Src_Iac.y)) * Weight_X >> 16);
 	int h2_G = (int)(Src_Iad.y) + (((int)(Src_Ibd.y) - (int)(Src_Iad.y)) * Weight_X >> 16);

 	int h1_R = (int)(Src_Iac.z) + (((int)(Src_Ibc.z) - (int)(Src_Iac.z)) * Weight_X >> 16);
 	int h2_R = (int)(Src_Iad.z) + (((int)(Src_Ibd.z) - (int)(Src_Iad.z)) * Weight_X >> 16);

 	int h1_A = (int)(Src_Iac.w) + (((int)(Src_Ibc.w) - (int)(Src_Iac.w)) * Weight_X >> 16);
 	int h2_A = (int)(Src_Iad.w) + (((int)(Src_Ibd.w) - (int)(Src_Iad.w)) * Weight_X >> 16);

	h1_B = h1_B + ((h2_B - h1_B) * Weight_Y >> 16);
	h1_G = h1_G + ((h2_G - h1_G) * Weight_Y >> 16);
	h1_R = h1_R + ((h2_R - h1_R) * Weight_Y >> 16);
	h1_A = h1_A + ((h2_A - h1_A) * Weight_Y >> 16);

	Src_Iac.x = h1_B;
	Src_Iac.y = h1_G;
	Src_Iac.z = h1_R;
	Src_Iac.w = h1_A;

	int DstIndex = w + DstMarginX + (h + DstMarginY) * DstStride;
	Dst[DstIndex] = Src_Iac;

}

__kernel void GenericRGB32FieldToFrame(__global uchar4* src, __global uchar4* dst, int width, int height, int stride, int nCopyLine)
{
	int index = get_global_id(0);

	int x = index % width;
	int y = index / width;

	if(y%2 == nCopyLine)
	{
		dst[index] = src[index];
	}

}

__kernel void GenericRGB32FrameToField_LowQuality_Top(__global uchar4* src, __global uchar4* dst, int width, int height, int stride, int nCopyLine)
{
	int index = get_global_id(0);

	int x = index % width;
	int y = index / width;

	if(y%2 == nCopyLine)
	{
		dst[index] = src[index - stride];
	}
	else
	{
		dst[index] = src[index];
	}

}

__kernel void GenericRGB32FrameToField_LowQuality_Bottom(__global uchar4* src, __global uchar4* dst, int width, int height, int stride, int nCopyLine)
{
	int index = get_global_id(0);

	int x = index % width;
	int y = index / width;

	if(y%2 == nCopyLine)
	{
		dst[index] = src[index + stride];
	}
	else
	{
		dst[index] = src[index];
	}

}

__kernel void GenericRGB32MakeBottomField(__global uchar4* src, int width, int height, int stride)
{
	int index = get_global_id(0);

	int x = index % width;
	int y = index / width;

	if(y%2 == 1)
	{
		src[index] = src[index - stride];
	}

}

__kernel void GenericRGB32MakeTopField(__global uchar4* src, int width, int height, int stride)
{
	int index = get_global_id(0);

	int x = index % width;
	int y = index / width;

	if(y%2 == 0)
	{
		src[index] = src[index + stride];
	}

}

__kernel void InterpolateFrameToField(__global uchar4* src, __global uchar4* dst, int width, int height, int stride, int nInterpolateLine)
{
	int index = get_global_id(0);

	int x = index % width;
	int y = index / width;

	if(y%2 == nInterpolateLine)
	{
		uchar4 tempSrc1 = src[index - stride];
		uchar4 tempSrc2 = src[index + stride];
		uchar4 tempDst;

		tempDst.z = (tempSrc1.z + tempSrc2.z) / 2;
		tempDst.y = (tempSrc1.y + tempSrc2.y) / 2;
		tempDst.x = (tempSrc1.x + tempSrc2.x) / 2;
		tempDst.w = (tempSrc1.w + tempSrc2.w) / 2;

		dst[index] = tempDst;
	}
	else
	{
		dst[index] = src[index];
	}

}

__kernel void InterpolateMakeBottomField(__global uchar4* src, int width, int height, int stride)
{
	int index = get_global_id(0);

	int x = index % width;
	int y = index / width;

	if(y%2 == 1)
	{
		if(y == height -1)
			return;

		uchar4 tempSrc1 = src[index - width];
		uchar4 tempSrc2 = src[index + width];
		uchar4 tempDst;

		tempDst.z = (tempSrc1.z + tempSrc2.z) / 2;
		tempDst.y = (tempSrc1.y + tempSrc2.y) / 2;
		tempDst.x = (tempSrc1.x + tempSrc2.x) / 2;
		tempDst.w = (tempSrc1.w + tempSrc2.w) / 2;

		src[index] = tempDst;
	}

}

__kernel void InterpolateMakeTopField(__global uchar4* src, int width, int height, int stride)
{
	int index = get_global_id(0);

	int x = index % width;
	int y = index / width;

	if(y%2 == 0)
	{
		if(y == 0)
			return;

		uchar4 tempSrc1 = src[index - width];
		uchar4 tempSrc2 = src[index + width];
		uchar4 tempDst;

		tempDst.z = (tempSrc1.z + tempSrc2.z) / 2;
		tempDst.y = (tempSrc1.y + tempSrc2.y) / 2;
		tempDst.x = (tempSrc1.x + tempSrc2.x) / 2;
		tempDst.w = (tempSrc1.w + tempSrc2.w) / 2;

		src[index] = tempDst;
	}

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
