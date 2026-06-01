__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

kernel void GaussianBlur_Clean(__write_only image2d_t dst)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	uint4 tempDst = {0, 0, 0, 0};
	write_imageui(dst, coord, tempDst);
}

kernel void GaussianBlur_X(__read_only image2d_t src, __write_only image2d_t dst, __global const int *Table, __global const int *SumWidth, int width, int height, int BlurRadius, int nRealWidth)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int index = get_global_id(0) + get_global_id(1) * nRealWidth;

	int h = index / nRealWidth;
	int w = index % nRealWidth;
	uint4 tempSrc;
	uint4 tempDst;
	int MaskValue = 0;
	int MaskWidth = 0;

	int4 sum = {0, 0, 0, 0};
	int4 tempMaskValue;
	int x;
	int y;
	int i = 0;

	x = w - BlurRadius;
	y = h;

	if(w >= BlurRadius && h >= BlurRadius && w < (width + BlurRadius) && h < (height + BlurRadius))
	{
		int nShiftIndex = index - BlurRadius;

		for(i=0; i < (BlurRadius * 2 + 1); ++i)
		{
		//	tempSrc = src[nShiftIndex];
			h = nShiftIndex / nRealWidth;
			w = nShiftIndex % nRealWidth;
			coord = (int2)(w, h);
			tempSrc = read_imageui(src, imageSampler, coord);

			MaskValue = Table[i];

			sum.x += tempSrc.x * MaskValue;
			sum.y += tempSrc.y * MaskValue;
			sum.z += tempSrc.z * MaskValue;

			nShiftIndex = nShiftIndex + 1;

		}


		MaskWidth = SumWidth[index % nRealWidth - BlurRadius];

		tempDst.x = sum.x / MaskWidth;
		tempDst.y = sum.y / MaskWidth;
		tempDst.z = sum.z / MaskWidth;


	}
	else
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
	}

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempDst);

}

kernel void GaussianBlur_Y(__read_only image2d_t src, __write_only image2d_t dst, __global const int *Table, __global const int *SumHeight, int width, int height, int BlurRadius, int nRealWidth)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int index = get_global_id(0) + get_global_id(1) * nRealWidth;

	int h = index / nRealWidth;
	int w = index % nRealWidth;
	uint4 tempSrc;
	uint4 tempDst;
	int MaskValue = 0;
	int MaskHeight = 0;

	int4 sum = {0, 0, 0, 0};
	int4 tempMaskValue;
	int x;
	int y;
	int i = 0;

	x = w;
	y = h - BlurRadius;

	if(w >= BlurRadius && h >= BlurRadius && w < (width + BlurRadius) && h < (height + BlurRadius))
	{
		int nShiftIndex = index - BlurRadius * nRealWidth;

		for(i=0; i < (BlurRadius * 2 + 1); ++i)
		{
		//	tempSrc = src[nShiftIndex];
			h = nShiftIndex / nRealWidth;
			w = nShiftIndex % nRealWidth;
			coord = (int2)(w, h);
			tempSrc = read_imageui(src, imageSampler, coord);

			MaskValue = Table[i];

			sum.x += tempSrc.x * MaskValue;
			sum.y += tempSrc.y * MaskValue;
			sum.z += tempSrc.z * MaskValue;

			nShiftIndex = nShiftIndex + nRealWidth;

		}

		MaskHeight = SumHeight[index / nRealWidth - BlurRadius];

		tempDst.x = sum.x / MaskHeight;
		tempDst.y = sum.y / MaskHeight;
		tempDst.z = sum.z / MaskHeight;
		tempDst.w = 255;
	}
	else
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
	}

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempDst);

}


#if 0
__constant sampler_t imageSamplerTable = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerWidth = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
__constant sampler_t imageSamplerHeight = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
kernel void GaussianBlur_X(__read_only image2d_t src, __write_only image2d_t dst, __read_only image2d_t Table, __read_only image2d_t SumWidth, int width, int height, int BlurRadius, int nRealWidth)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int index = get_global_id(0) + get_global_id(1) * nRealWidth;

	int h = index / nRealWidth;
	int w = index % nRealWidth;
	uint4 tempSrc;
	uint4 tempDst;
	int MaskValue = 0;
	int MaskWidth = 0;

	int4 sum = {0, 0, 0, 0};
	int4 tempMaskValue;
	int x;
	int y;
	int i = 0;

	x = w - BlurRadius;
	y = h;

	if(w >= BlurRadius && h >= BlurRadius && w < (width + BlurRadius) && h < (height + BlurRadius))
	{
		int nShiftIndex = index - BlurRadius;

		for(i=0; i < (BlurRadius * 2 + 1); ++i)
		{
		//	tempSrc = src[nShiftIndex];
			h = nShiftIndex / nRealWidth;
			w = nShiftIndex % nRealWidth;
			coord = (int2)(w, h);
			tempSrc = read_imageui(src, imageSampler, coord);

		//	MaskValue = Table[i];
			coord = (int2)(i, 0);
			MaskValue = read_imageui(Table, imageSamplerTable, coord).x;

			sum.x += tempSrc.x * MaskValue;
			sum.y += tempSrc.y * MaskValue;
			sum.z += tempSrc.z * MaskValue;

			nShiftIndex = nShiftIndex + 1;

		}

	//	MaskWidth = SumWidth[w - BlurRadius];

		coord = (int2)(index % nRealWidth - BlurRadius, 0);
		MaskWidth = read_imageui(SumWidth, imageSamplerWidth, coord).x;

		tempDst.x = sum.x / MaskWidth;
		tempDst.y = sum.y / MaskWidth;
		tempDst.z = sum.z / MaskWidth;


	}
	else
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
	}

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempDst);

}

kernel void GaussianBlur_Y(__read_only image2d_t src, __write_only image2d_t dst, __read_only image2d_t Table, __read_only image2d_t SumHeight, int width, int height, int BlurRadius, int nRealWidth)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int index = get_global_id(0) + get_global_id(1) * nRealWidth;

	int h = index / nRealWidth;
	int w = index % nRealWidth;
	uint4 tempSrc;
	uint4 tempDst;
	int MaskValue = 0;
	int MaskHeight = 0;

	int4 sum = {0, 0, 0, 0};
	int4 tempMaskValue;
	int x;
	int y;
	int i = 0;

	x = w;
	y = h - BlurRadius;

	if(w >= BlurRadius && h >= BlurRadius && w < (width + BlurRadius) && h < (height + BlurRadius))
	{
		int nShiftIndex = index - BlurRadius * nRealWidth;

		for(i=0; i < (BlurRadius * 2 + 1); ++i)
		{
		//	tempSrc = src[nShiftIndex];
			h = nShiftIndex / nRealWidth;
			w = nShiftIndex % nRealWidth;
			coord = (int2)(w, h);
			tempSrc = read_imageui(src, imageSampler, coord);

		//	MaskValue = Table[i];
			coord = (int2)(i, 0);
			MaskValue = read_imageui(Table, imageSamplerTable, coord).x;

			sum.x += tempSrc.x * MaskValue;
			sum.y += tempSrc.y * MaskValue;
			sum.z += tempSrc.z * MaskValue;

			nShiftIndex = nShiftIndex + nRealWidth;

		}

	//	MaskHeight = SumHeight[h - BlurRadius];
		coord = (int2)(index / nRealWidth - BlurRadius, 0);
		MaskHeight = read_imageui(SumHeight, imageSamplerHeight, coord).x;

		tempDst.x = sum.x / MaskHeight;
		tempDst.y = sum.y / MaskHeight;
		tempDst.z = sum.z / MaskHeight;
		tempDst.w = 255;
	}
	else
	{
		tempDst.x = 0;
		tempDst.y = 0;
		tempDst.z = 0;
	}

	coord = (int2)(get_global_id(0), get_global_id(1));
	write_imageui(dst, coord, tempDst);

}

#endif


#if 0
kernel void GaussianBlur_X(__global const uchar4* src, __global uchar4* dst, __global const int* Table, __global const int* SumWidth, int width, int height, int BlurRadius)
{

	int index = get_global_id(0);
	int nRealWidth = width + 2 * BlurRadius;

	int h = index / nRealWidth;
	int w = index % nRealWidth;
	uchar4 tempSrc;
	uchar4 tempDst;
	int MaskValue = 0;
	int MaskWidth = 0;

	int4 sum = {0, 0, 0, 0};
	int4 tempMaskValue;
	int x;
	int y;
	int i = 0;

	x = w - BlurRadius;
	y = h;


	if(w >= BlurRadius && h >= BlurRadius && w < (width + BlurRadius) && h < (height + BlurRadius))
	{
		int nShiftIndex = index - BlurRadius;

		for(i=0; i < (BlurRadius * 2 + 1); ++i)
		{
			tempSrc = src[nShiftIndex];

			MaskValue = Table[i];

			sum.x += tempSrc.x * MaskValue;
			sum.y += tempSrc.y * MaskValue;
			sum.z += tempSrc.z * MaskValue;

			nShiftIndex = nShiftIndex + 1;

		}

		MaskWidth = SumWidth[w - BlurRadius];

		tempDst.x = sum.x / MaskWidth;
		tempDst.y = sum.y / MaskWidth;
		tempDst.z = sum.z / MaskWidth;

		dst[index] = tempDst;

	}
	else
	{
		dst[index] = 0x00000000;
	}


}

kernel void GaussianBlur_Y(__global const uchar4* src, __global uchar4* dst, __global const int* Table, __global const int* SumHeight, int width, int height, int BlurRadius)
{
	int index = get_global_id(0);
	int nRealWidth = width + 2 * BlurRadius;

	int h = index / nRealWidth;
	int w = index % nRealWidth;
	uchar4 tempSrc;
	uchar4 tempDst;
	int MaskValue = 0;
	int MaskHeight = 0;

	int4 sum = {0, 0, 0, 0};
	int4 tempMaskValue;
	int x;
	int y;
	int i = 0;

	x = w;
	y = h - BlurRadius;


	if(w >= BlurRadius && h >= BlurRadius && w < (width + BlurRadius) && h < (height + BlurRadius))
	{
		int nShiftIndex = index - BlurRadius * nRealWidth;

		for(i=0; i < (BlurRadius * 2 + 1); ++i)
		{
			tempSrc = src[nShiftIndex];

			MaskValue = Table[i];

			sum.x += tempSrc.x * MaskValue;
			sum.y += tempSrc.y * MaskValue;
			sum.z += tempSrc.z * MaskValue;

			nShiftIndex = nShiftIndex + nRealWidth;

		}

		MaskHeight = SumHeight[h - BlurRadius];

		tempDst.x = sum.x / MaskHeight;
		tempDst.y = sum.y / MaskHeight;
		tempDst.z = sum.z / MaskHeight;

		dst[index] = tempDst;

	}
	else
	{
		dst[index] = 0x00000000;
	}

}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
