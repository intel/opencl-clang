#define MUL24(x,y)		mul24(x,y)

#define CLAMP_BYTE(val) (clamp(val, 0, 255))
#define CHECK_BOUNDARY(bCheck, bNotCheck, bvalue, v2) ((bCheck&v2) + (bNotCheck&bvalue))
#define CHOOSE_1IN2(bCheck, v1, v2) (((bCheck)&(v1)) + ((~bCheck)&(v2)))
#define SUM_V4(val, sum) {(val).xy = (val).xy+(val).zw; sum = (val).x+(val).y; }


#define TRANSPOSE_8x8(s0, s1, s2, s3, s4, s5, s6, s7, d0, d1, d2, d3, d4, d5, d6, d7)\
{\
	int8 t0 = {1, 0, 0, 0, 0, 0, 0, 0};\
	\
	d0 = s0.s00000000 * t0.s01234567 + s1.s00000000 * t0.s10123456 + s2.s00000000 * t0.s11012345 + s3.s00000000 * t0.s11101234 + \
		 s4.s00000000 * t0.s11110123 + s5.s00000000 * t0.s11111012 + s6.s00000000 * t0.s11111101 + s7.s00000000 * t0.s11111110;\
	d1 = s0.s11111111 * t0.s01234567 + s1.s11111111 * t0.s10123456 + s2.s11111111 * t0.s11012345 + s3.s11111111 * t0.s11101234 + \
		 s4.s11111111 * t0.s11110123 + s5.s11111111 * t0.s11111012 + s6.s11111111 * t0.s11111101 + s7.s11111111 * t0.s11111110;\
	d2 = s0.s22222222 * t0.s01234567 + s1.s22222222 * t0.s10123456 + s2.s22222222 * t0.s11012345 + s3.s22222222 * t0.s11101234 + \
		 s4.s22222222 * t0.s11110123 + s5.s22222222 * t0.s11111012 + s6.s22222222 * t0.s11111101 + s7.s22222222 * t0.s11111110;\
	d3 = s0.s33333333 * t0.s01234567 + s1.s33333333 * t0.s10123456 + s2.s33333333 * t0.s11012345 + s3.s33333333 * t0.s11101234 + \
		 s4.s33333333 * t0.s11110123 + s5.s33333333 * t0.s11111012 + s6.s33333333 * t0.s11111101 + s7.s33333333 * t0.s11111110;\
	d4 = s0.s44444444 * t0.s01234567 + s1.s44444444 * t0.s10123456 + s2.s44444444 * t0.s11012345 + s3.s44444444 * t0.s11101234 + \
		 s4.s44444444 * t0.s11110123 + s5.s44444444 * t0.s11111012 + s6.s44444444 * t0.s11111101 + s7.s44444444 * t0.s11111110;\
	d5 = s0.s55555555 * t0.s01234567 + s1.s55555555 * t0.s10123456 + s2.s55555555 * t0.s11012345 + s3.s55555555 * t0.s11101234 + \
		 s4.s55555555 * t0.s11110123 + s5.s55555555 * t0.s11111012 + s6.s55555555 * t0.s11111101 + s7.s55555555 * t0.s11111110;\
	d6 = s0.s66666666 * t0.s01234567 + s1.s66666666 * t0.s10123456 + s2.s66666666 * t0.s11012345 + s3.s66666666 * t0.s11101234 + \
		 s4.s66666666 * t0.s11110123 + s5.s66666666 * t0.s11111012 + s6.s66666666 * t0.s11111101 + s7.s66666666 * t0.s11111110;\
	d7 = s0.s77777777 * t0.s01234567 + s1.s77777777 * t0.s10123456 + s2.s77777777 * t0.s11012345 + s3.s77777777 * t0.s11101234 + \
		 s4.s77777777 * t0.s11110123 + s5.s77777777 * t0.s11111012 + s6.s77777777 * t0.s11111101 + s7.s77777777 * t0.s11111110;\
}
//downsample and compress 16 uchar to 4 int
__kernel void KN_DownSampleAndCompress(__read_only image2d_t pSrc, __global uint4 *pCompress, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iW = iSize.x;
	int iH = iSize.y;

	int iOutStride = iSize.w;

	int2 coord;
	coord.x = gx*4;
	coord.y = gy*16;
	int4 offset = {1, 2, 3, 0};
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	uint4 c0 = read_imageui(pSrc, sampler, coord);
	uint4 c1 = read_imageui(pSrc, sampler, coord+offset.xw);
	uint4 c2 = read_imageui(pSrc, sampler, coord+offset.yw);
	uint4 c3 = read_imageui(pSrc, sampler, coord+offset.zw);
	uint4 Out;

	Out.x = c0.x | c0.y<<8 | c0.z<<16 | c0.w<<24;
	Out.y = c1.x | c1.y<<8 | c1.z<<16 | c1.w<<24;
	Out.z = c2.x | c2.y<<8 | c2.z<<16 | c2.w<<24;
	Out.w = c3.x | c3.y<<8 | c3.z<<16 | c3.w<<24;

	if(gx<iW && gy<iH)
	{
		int oPos = gy*iOutStride + gx;
		pCompress[oPos] = Out;
	}
}
__kernel void KN_DownSampleAndCompress_G(__global uchar4 *pSrc, __global uint4 *pCompress, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int iInStride = iSize.z;
	int iOutStride = iSize.w;

	int iPos = gy*16*iInStride + gx*4;
	uchar4 c0 = pSrc[iPos];
	uchar4 c1 = pSrc[iPos+1];
	uchar4 c2 = pSrc[iPos+2];
	uchar4 c3 = pSrc[iPos+3];
	uint4 Out;

	Out.x = c0.x | c0.y<<8 | c0.z<<16 | c0.w<<24;
	Out.y = c1.x | c1.y<<8 | c1.z<<16 | c1.w<<24;
	Out.z = c2.x | c2.y<<8 | c2.z<<16 | c2.w<<24;
	Out.w = c3.x | c3.y<<8 | c3.z<<16 | c3.w<<24;

	if(gx<iW && gy<iH)
	{
		int oPos = gy*iOutStride + gx;
		pCompress[oPos] = Out;
	}
}

__kernel void KN_DylightLookUpTable_YV12(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
										__global uint *pIntensityMap,
										__write_only image2d_t pDstY, __write_only image2d_t pDstU, __write_only image2d_t pDstV,
										uint4 iSize)
{
	int4 coord;
	int4 offset = {1, 2, 3, 0};

	coord.z = get_global_id(0);
	coord.w = get_global_id(1);
	coord.x = coord.z*2;
	coord.y = coord.w*2;

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int4 Y0 = convert_int4(read_imageui(pSrcY, sampler, coord.xy));
	int4 Y1 = convert_int4(read_imageui(pSrcY, sampler, coord.xy+offset.xw));
	int4 Y2 = convert_int4(read_imageui(pSrcY, sampler, coord.xy+offset.wx));
	int4 Y3 = convert_int4(read_imageui(pSrcY, sampler, coord.xy+offset.xx));
	int4 U = convert_int4(read_imageui(pSrcU, sampler, coord.zw)) - 128;
	int4 V = convert_int4(read_imageui(pSrcV, sampler, coord.zw)) - 128;
	int4 iScore = 0;
	int4 iScoreUV = 0;
	int4 outY0, outY1, outY2, outY3;
	int4 iSat = convert_int4(iSize.wwww);
	__global uint *pBezierMap = pIntensityMap;
	__global uchar *pContrastMap = (__global uchar*)(pIntensityMap + 256);

	outY0.x = pContrastMap[Y0.x];
	outY0.y = pContrastMap[Y0.y];
	outY0.z = pContrastMap[Y0.z];
	outY0.w = pContrastMap[Y0.w];

	outY1.x = pContrastMap[Y1.x];
	outY1.y = pContrastMap[Y1.y];
	outY1.z = pContrastMap[Y1.z];
	outY1.w = pContrastMap[Y1.w];
	outY2.x = pContrastMap[Y2.x];
	outY2.y = pContrastMap[Y2.y];
	outY2.z = pContrastMap[Y2.z];
	outY2.w = pContrastMap[Y2.w];
	outY3.x = pContrastMap[Y3.x];
	outY3.y = pContrastMap[Y3.y];
	outY3.z = pContrastMap[Y3.z];
	outY3.w = pContrastMap[Y3.w];

	iScore.x = pBezierMap[Y0.x];
	iScore.y = pBezierMap[Y0.z];
	iScore.z = pBezierMap[Y1.x];
	iScore.w = pBezierMap[Y1.z];

	iScore = iScore>>6;
	iScoreUV = (iScore*iSat)>>5;

	U = ((U*iScoreUV+128)>>8)+128;
	V = ((V*iScoreUV+128)>>8)+128;

	U = CLAMP_BYTE(U);
	V = CLAMP_BYTE(V);

	U.x = pContrastMap[256+U.x];
	U.y = pContrastMap[256+U.y];
	U.z = pContrastMap[256+U.z];
	U.w = pContrastMap[256+U.w];
	V.x = pContrastMap[256+V.x];
	V.y = pContrastMap[256+V.y];
	V.z = pContrastMap[256+V.z];
	V.w = pContrastMap[256+V.w];

	write_imageui(pDstY, coord.xy,			 convert_uint4(CLAMP_BYTE(outY0)));
	write_imageui(pDstY, coord.xy+offset.xw, convert_uint4(CLAMP_BYTE(outY1)));
	write_imageui(pDstY, coord.xy+offset.wx, convert_uint4(CLAMP_BYTE(outY2)));
	write_imageui(pDstY, coord.xy+offset.xx, convert_uint4(CLAMP_BYTE(outY3)));
	write_imageui(pDstU, coord.zw, convert_uint4(CLAMP_BYTE(U)));
	write_imageui(pDstV, coord.zw, convert_uint4(CLAMP_BYTE(V)));
}

__kernel void KN_DylightLookUpTable(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
									__global uchar *pIntensityMap,
									__write_only image2d_t pDstY, __write_only image2d_t pDstU, __write_only image2d_t pDstV,
									uint4 iSize)
{
	int4 coord;

	coord.z = get_global_id(0);
	coord.w = get_global_id(1);
	coord.x = coord.z;
	coord.y = coord.w;

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int4 Y = convert_int4(read_imageui(pSrcY, sampler, coord.xy));
	int4 U = convert_int4(read_imageui(pSrcU, sampler, coord.xy)) - 128;
	int4 V = convert_int4(read_imageui(pSrcV, sampler, coord.xy)) - 128;
	int4 iScore = 0;
	int4 iScoreUV = 0;
	int4 outY;
	int4 iSat = convert_int4(iSize.wwww);
	__global uint *pBezierMap = (__global uint*)(pIntensityMap);
	__global uchar *pContrastMap = (__global uchar*)(pIntensityMap + 256*4);


	outY.x = pContrastMap[Y.x];
	outY.y = pContrastMap[Y.y];
	outY.z = pContrastMap[Y.z];
	outY.w = pContrastMap[Y.w];


	iScore.x = pBezierMap[Y.x];
	iScore.y = pBezierMap[Y.y];
	iScore.z = pBezierMap[Y.z];
	iScore.w = pBezierMap[Y.w];

	iScore = iScore>>6;
	iScoreUV = (iScore*iSat)>>5;

	U = ((U*iScoreUV+128)>>8)+128;
	V = ((V*iScoreUV+128)>>8)+128;

	U = CLAMP_BYTE(U);
	V = CLAMP_BYTE(V);

	U.x = pContrastMap[256+U.x];
	U.y = pContrastMap[256+U.y];
	U.z = pContrastMap[256+U.z];
	U.w = pContrastMap[256+U.w];
	V.x = pContrastMap[256+V.x];
	V.y = pContrastMap[256+V.y];
	V.z = pContrastMap[256+V.z];
	V.w = pContrastMap[256+V.w];

	write_imageui(pDstY, coord.xy, convert_uint4(CLAMP_BYTE(outY)));
	write_imageui(pDstU, coord.zw, convert_uint4(CLAMP_BYTE(U)));
	write_imageui(pDstV, coord.zw, convert_uint4(CLAMP_BYTE(V)));
}

__kernel void KN_DylightLookUpTable_G_YV12(__global uchar4 *pSrcY, __global uchar4 *pSrcU, __global uchar4 *pSrcV,
											__global uchar *pIntensityMap,
											__global uchar4 *pDstY, __global uchar4 *pDstU, __global uchar4 *pDstV,
											uint4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iW = (iSize.x+1)/2;
	int iH = (iSize.y+1)/2;
	int iInStride = iSize.z;

	int iPos = gy*2*iInStride+gx*2;

	int4 Y0 = convert_int4(pSrcY[iPos]);
	int4 Y1 = convert_int4(pSrcY[iPos+1]);
	int4 Y2 = convert_int4(pSrcY[iPos+iInStride]);
	int4 Y3 = convert_int4(pSrcY[iPos+iInStride+1]);
	int4 U = convert_int4(pSrcU[gy*iInStride/2+gx]) - 128;
	int4 V = convert_int4(pSrcV[gy*iInStride/2+gx]) - 128;
	int4 iScore = 0;
	int4 iScoreUV = 0;
	int4 outY0, outY1, outY2, outY3;
	int4 iSat = convert_int4(iSize.wwww);
	__global uint *pBezierMap = (__global uint*)(pIntensityMap);
	__global uchar *pContrastMap = (__global uchar*)(pIntensityMap + 256*4);

	outY0.x = pContrastMap[Y0.x];
	outY0.y = pContrastMap[Y0.y];
	outY0.z = pContrastMap[Y0.z];
	outY0.w = pContrastMap[Y0.w];
	outY1.x = pContrastMap[Y1.x];
	outY1.y = pContrastMap[Y1.y];
	outY1.z = pContrastMap[Y1.z];
	outY1.w = pContrastMap[Y1.w];
	outY2.x = pContrastMap[Y2.x];
	outY2.y = pContrastMap[Y2.y];
	outY2.z = pContrastMap[Y2.z];
	outY2.w = pContrastMap[Y2.w];
	outY3.x = pContrastMap[Y3.x];
	outY3.y = pContrastMap[Y3.y];
	outY3.z = pContrastMap[Y3.z];
	outY3.w = pContrastMap[Y3.w];

	iScore.x = pBezierMap[Y0.x];
	iScore.y = pBezierMap[Y0.z];
	iScore.z = pBezierMap[Y1.x];
	iScore.w = pBezierMap[Y1.z];

	iScore = iScore/64;
	iScoreUV = (iScore*iSat)/32;

	U = (U*iScoreUV+128)/256+128;
	V = (V*iScoreUV+128)/256+128;

	U = CLAMP_BYTE(U);
	V = CLAMP_BYTE(V);

	U.x = pContrastMap[256+U.x];
	U.y = pContrastMap[256+U.y];
	U.z = pContrastMap[256+U.z];
	U.w = pContrastMap[256+U.w];
	V.x = pContrastMap[256+V.x];
	V.y = pContrastMap[256+V.y];
	V.z = pContrastMap[256+V.z];
	V.w = pContrastMap[256+V.w];

	if(gx<iW && gy<iH)
	{
		pDstY[iPos] = convert_uchar4_sat(outY0);
		pDstY[iPos+1] = convert_uchar4_sat(outY1);
		pDstY[iPos+iInStride] = convert_uchar4_sat(outY2);
		pDstY[iPos+iInStride+1] = convert_uchar4_sat(outY3);
		pDstU[gy*iInStride/2+gx] = convert_uchar4_sat(U);
		pDstV[gy*iInStride/2+gx] = convert_uchar4_sat(V);
	}
}

#define HISTOGRM_ADD_V4(d, h, c)\
{\
	uint4 v=0;\
	v.x = d&0xFF;\
	v.y = (d>>8)&0xFF;\
	v.z = (d>>16)&0xFF;\
	v.w = (d>>24)&0xFF;\
	c -= v.xyzw==h;\
	c -= v.yzwx==h;\
	c -= v.zwxy==h;\
	c -= v.wxyz==h;\
}
__kernel void KN_Histogram256_1(__global uint4 *pCompress, __global int4 *pHistSum, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int iInStride = iSize.z;
	int iOutStride = 64;

	int iPos = gy*iInStride;
	uint4 HistValue = {gx*4, gx*4+1, gx*4+2, gx*4+3};
	int4 Count = 0;

	for(int i = 0; i < iW; ++i)
    {
		uint4 data = pCompress[iPos+i];
		uint4 v=0;

		HISTOGRM_ADD_V4(data.x, HistValue, Count)
		HISTOGRM_ADD_V4(data.y, HistValue, Count)
		HISTOGRM_ADD_V4(data.z, HistValue, Count)
		HISTOGRM_ADD_V4(data.w, HistValue, Count)
	}

	int oPos = gy*iOutStride + gx;
	if(gy<iH)
		pHistSum[oPos] = Count;
}

__kernel void KN_Histogram256_2(__global uint4 *pHistSum, __global uint4 *pHist, int4 iSize)
{
	int gx = get_global_id(0);

	int iH = iSize.y;

	uint4 Count = 0;

	for(int i = 0; i < iH; ++i)
	{
		uint4 data = pHistSum[i*64+gx];
		Count += data;
	}

	pHist[gx] = Count;
}

__kernel void KN_Sharpen_G(__global uchar4* inputImage, __global uchar4 *outputImage, int4 iSize, float fLevel)
{
	// Global threads in x-direction = BufStride / 4
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iInStride = iSize.z;
	int iOutStride = iSize.w;

	int pos = gx + iInStride * gy;
	int opos = gx + iOutStride * gy;

// 	if(islessequal(gx, iW))
	{
		int pitch = iInStride;

		float4 p0 = convert_float4(inputImage[pos]);
		float4 p_1 = convert_float4(inputImage[pos-pitch]);
		float4 p_2 = convert_float4(inputImage[pos-pitch*2]);
		float4 p_3 = convert_float4(inputImage[pos-pitch*3]);
		float4 p_4 = convert_float4(inputImage[pos-pitch*4]);
		float4 p1 = convert_float4(inputImage[pos+pitch]);
		float4 p2 = convert_float4(inputImage[pos+pitch*2]);
		float4 p3 = convert_float4(inputImage[pos+pitch*3]);
		float4 p4 = convert_float4(inputImage[pos+pitch*4]);
		float4 v = {26.0f, 18.0f, 8.0f, 1.0f};
		float4 d1, d2;
		float4 v4 = (float4)(4.0f);
		int4 c1 = (int4)(0);
		float4 ty, tx;

		ty = (p_1 + p1) * v.x + (p_2 + p2) * v.y + (p_3 + p3) * v.z + (p_4 + p4);

		d1 = convert_float4(abs(convert_int4(p1 - p_1)));
		p_1 = convert_float4(inputImage[pos-1]);
		p_2.xyz = p_1.yzw;
		p_2.w = p0.x;
		p_3.xy = p_1.zw;
		p_3.zw = p0.xy;
		p_4.x = p_1.w;
		p_4.yzw = p0.xyz;
		p4 = convert_float4(inputImage[pos+1]);
		p3.x = p0.w;
		p3.yzw = p4.xyz;
		p2.xy = p0.zw;
		p2.zw = p4.xy;
		p1.xyz = p0.yzw;
		p1.w = p4.x;

		tx.x = dot(p_1, v.wzyx) + dot(p1, v);
		tx.y = dot(p_2, v.wzyx) + dot(p2, v);
		tx.z = dot(p_3, v.wzyx) + dot(p3, v);
		tx.w = dot(p_4, v.wzyx) + dot(p4, v);

		tx = (p0 * 212.0f - tx - ty) / 256.0f;
		tx = tx * fLevel + p0;

		d2 = convert_float4(abs(convert_int4(p1 - p_4)));
		c1 = (d1>v4) * (d2>v4);
		tx = select(tx, p0, c1);
		outputImage[opos] = convert_uchar4_sat(tx);
	}
}

__kernel void KN_SharpenUM_0(__read_only image2d_t pIn, __write_only image2d_t pOut, int4 iSize)
{
	int4 coord;
	int4 offset = {1, 0, -1, 0};

	coord.x = get_global_id(0);
	coord.y = get_global_id(1);
	coord.z = get_local_id(0);
	coord.w = get_local_id(1);

	int2 pos = coord.xy;

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	uint4 v0;

	int iW = iSize.x;
	int4 p00, p01, p02, p10, p11, p12, p20, p21, p22;
	int4 d00, d01, d02, d10, d11, d12, d20, d21, d22;
	int4 sum;
	int4 bLeft = (int4)(coord.x==0);
	int4 bRight = (int4)(coord.x==iW-1);

	p00 = convert_int4(read_imageui(pIn, sampler, pos-offset.xx));
	p01 = convert_int4(read_imageui(pIn, sampler, pos-offset.yx));
	p02 = convert_int4(read_imageui(pIn, sampler, pos-offset.zx));
	p10 = convert_int4(read_imageui(pIn, sampler, pos-offset.xy));
	p11 = convert_int4(read_imageui(pIn, sampler, pos));
	p12 = convert_int4(read_imageui(pIn, sampler, pos+offset.xy));
	p20 = convert_int4(read_imageui(pIn, sampler, pos+offset.zx));
	p21 = convert_int4(read_imageui(pIn, sampler, pos+offset.yx));
	p22 = convert_int4(read_imageui(pIn, sampler, pos+offset.xx));

	p00 = bLeft*p01.xxxx + (1-bLeft)*p00;
	p10 = bLeft*p11.xxxx + (1-bLeft)*p10;
	p20 = bLeft*p21.xxxx + (1-bLeft)*p20;
	p02 = bRight*p01.wwww + (1-bRight)*p02;
	p12 = bRight*p11.wwww + (1-bRight)*p12;
	p22 = bRight*p21.wwww + (1-bRight)*p22;

	d00.x = p00.w;
	d00.yzw = p01.xyz;
	d01 = p01;
	d02.w = p02.x;
	d02.xyz = p01.yzw;
	d10.x = p10.w;
	d10.yzw = p11.xyz;
	d11 = p11;
	d12.w = p12.x;
	d12.xyz = p11.yzw;
	d20.x = p20.w;
	d20.yzw = p21.xyz;
	d21 = p21;
	d22.w = p22.x;
	d22.xyz = p21.yzw;

	sum = d00 + d01*2 + d02 + 2*(d10 + d11*2 + d12) + d20 + d21*2 + d22 + 8;

	v0 = convert_uint4(CLAMP_BYTE(sum>>4));
	write_imageui(pOut, pos, v0);
}

__kernel void KN_SharpenUM_1(__read_only image2d_t pSrc, __read_only image2d_t pIn, __write_only image2d_t pOut, int4 iSize, int iSharpen)
{
	int4 coord;
	int4 offset = {1, 0, -1, 0};

	coord.x = get_global_id(0);
	coord.y = get_global_id(1);
	coord.z = get_local_id(0);
	coord.w = get_local_id(1);

	int2 pos = coord.xy;

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int iW = iSize.x;
	int4 bLeft = (int4)(coord.x==0);
	int4 bRight = (int4)(coord.x==iW-1);
	int4 v0, v1, h0, h1;
	int4 p1, p2;

// 	if(coord.x == iW-1)
//  		printf("KN_SharpenUM_1: coord %d, %d, %d, %d.\n", coord.x, bLeft.z, bRight.z, iW);


	v0 = convert_int4(read_imageui(pIn, sampler, coord.xy-offset.yx));
	v1 = convert_int4(read_imageui(pIn, sampler, coord.xy+offset.yx));
	h0 = convert_int4(read_imageui(pIn, sampler, coord.xy-offset.xy));
	h1 = convert_int4(read_imageui(pIn, sampler, coord.xy+offset.xy));
	p2 = convert_int4(read_imageui(pIn, sampler, coord.xy));
	p1 = convert_int4(read_imageui(pSrc, sampler, coord.xy));

	h0 = bLeft*p2.xxxx + (1-bLeft)*h0;
	h1 = bRight*p2.wwww + (1-bRight)*h1;

	h0.x = h0.w;
	h0.yzw = p2.xyz;
	h1.w = h1.x;
	h1.xyz = p2.yzw;
	v0 = convert_int4(abs(v0-v1));
	h0 = convert_int4(abs(h0-h1));
	v0 = convert_int4(abs(max(v0, h0) - (int4)16));
	v0 = (int4)16 - v0;
	v0 = max((int4)8, v0);
	v0 = v0 * iSharpen;

	v0 = p1 + (((p1 - p2) * v0+128)>>8);

	uint4 i0 = convert_uint4(CLAMP_BYTE(v0));

	write_imageui(pOut, pos, i0);
}
__kernel void KN_SharpenUM_0_G(__global uchar4 *pInput, __global uchar4 *pOutput, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int iInStride = iSize.z;
	int iOutStride = iSize.w;

	int ipos = gx + iInStride * gy;
	int opos = gx + iOutStride * gy;

	int4 p00, p01, p02, p10, p11, p12, p20, p21, p22;
	int4 d00, d01, d02, d10, d11, d12, d20, d21, d22;
	int4 sum;

	int bValid = (gx<iW) && (gy<iH);
	int4 bBorder;
	bBorder.x = gy==0;		//top
	bBorder.y = gy==iH-1;	///bottom;
	bBorder.z = gx==0;		//Left
	bBorder.w = gx==iW-1;	//right

	p00 = convert_int4(pInput[ipos-iInStride-1]);
	p01 = convert_int4(pInput[ipos-iInStride]);
	p02 = convert_int4(pInput[ipos-iInStride+1]);
	p10 = convert_int4(pInput[ipos-1]);
	p11 = convert_int4(pInput[ipos]);
	p12 = convert_int4(pInput[ipos+1]);
	p20 = convert_int4(pInput[ipos+iInStride-1]);
	p21 = convert_int4(pInput[ipos+iInStride]);
	p22 = convert_int4(pInput[ipos+iInStride+1]);

	p00 = bBorder.zzzz*p01.xxxx + (1-bBorder.zzzz)*p00;
	p10 = bBorder.zzzz*p11.xxxx + (1-bBorder.zzzz)*p10;
	p20 = bBorder.zzzz*p21.xxxx + (1-bBorder.zzzz)*p20;
	p02 = bBorder.wwww*p01.wwww + (1-bBorder.wwww)*p02;
	p12 = bBorder.wwww*p11.wwww + (1-bBorder.wwww)*p12;
	p22 = bBorder.wwww*p21.wwww + (1-bBorder.wwww)*p22;

	p00 = bBorder.xxxx*p10 + (1-bBorder.xxxx)*p00;
	p01 = bBorder.xxxx*p11 + (1-bBorder.xxxx)*p01;
	p02 = bBorder.xxxx*p12 + (1-bBorder.xxxx)*p02;
	p20 = bBorder.yyyy*p10 + (1-bBorder.yyyy)*p20;
	p21 = bBorder.yyyy*p11 + (1-bBorder.yyyy)*p21;
	p22 = bBorder.yyyy*p12 + (1-bBorder.yyyy)*p22;

	d00.x = p00.w;
	d00.yzw = p01.xyz;
	d01 = p01;
	d02.w = p02.x;
	d02.xyz = p01.yzw;
	d10.x = p10.w;
	d10.yzw = p11.xyz;
	d11 = p11;
	d12.w = p12.x;
	d12.xyz = p11.yzw;
	d20.x = p20.w;
	d20.yzw = p21.xyz;
	d21 = p21;
	d22.w = p22.x;
	d22.xyz = p21.yzw;

	sum = d00 + d01*2 + d02 + 2*(d10 + d11*2 + d12) + d20 + d21*2 + d22 + 8;
	if(bValid)
		pOutput[opos] = convert_uchar4_sat(sum/16);
}

__kernel void KN_SharpenUM_1_G(__global uchar4 *pSrc, __global uchar4 *pInput, __global uchar4 *pOutput, int4 iSize, int iSharpen)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);
	int lx = get_local_id(0);
	int ly = get_local_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int iInStride = iSize.z;
	int iOutStride = iSize.w;

	int ipos = gx + iInStride * gy;
	int opos = gx + iOutStride * gy;

	int4 v0, v1, h0, h1;
	int4 p1, p2;

	//int4 bTop = (int4)(gy==0);
	//int4 bBottom = (int4)(gy==iH-1);
	//int4 bLeft = (int4)(gx==0);
	//int4 bRight = (int4)(gx==iW-1);
	int4 bBorder;
	bBorder.x = gy==0;		//top
	bBorder.y = gy==iH-1;	///bottom;
	bBorder.z = gx==0;		//Left
	bBorder.w = gx==iW-1;	//right

	v0 = convert_int4(pInput[ipos-iInStride]);
	v1 = convert_int4(pInput[ipos+iInStride]);
	h0 = convert_int4(pInput[ipos-1]);
	h1 = convert_int4(pInput[ipos+1]);
	p2 = convert_int4(pInput[ipos]);
	p1 = convert_int4(pSrc[ipos]);

	v0 = bBorder.xxxx*p2 + (1-bBorder.xxxx)*v0;
	v1 = bBorder.yyyy*p2 + (1-bBorder.yyyy)*v1;

	h0 = bBorder.zzzz*p2.xxxx + (1-bBorder.zzzz)*h0;
	h1 = bBorder.wwww*p2.wwww + (1-bBorder.wwww)*h1;

	h0.x = h0.w;
	h0.yzw = p2.xyz;
	h1.w = h1.x;
	h1.xyz = p2.yzw;
	v0 = convert_int4(abs(v0-v1));
	h0 = convert_int4(abs(h0-h1));
	v0 = max(v0, h0) - (int4)16;
	v0 = convert_int4(abs(v0));
	v0 = (int4)16 - v0;
	v0 = max((int4)8, v0);
	v0 = v0 * iSharpen;

	v0 = p1 + ((p1 - p2) * v0+128)/256;
	if(gx<iW && gy<iH)
		pOutput[opos] = convert_uchar4_sat(v0);
}

__kernel void KN_Deblock_Row(__read_only image2d_t pIn, __write_only image2d_t pOut, int4 iSize)
{
	int4 coord;
	__const int4 off = {0, 1, 2, 3};
	__const int4 off2 = {0, 1, 4, 0};

	coord.x = get_global_id(0)*2+1;
	coord.y = get_global_id(1)*8+4;
	coord.z = get_local_id(0);
	coord.w = get_local_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int8 bValid = coord.x<iW-1 && coord.y<iH-4 && coord.x>=0 && coord.y>=0;

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int8 p0, p1, p2, p3, p4, p5, p6, p7;
	int8 i0, i1, i2, i3, i4, i5, i6, i7;

	p0.lo = convert_int4(read_imageui(pIn, sampler, coord.xy));					p0.hi = convert_int4(read_imageui(pIn, sampler, coord.xy+off.yx));
	p1.lo = convert_int4(read_imageui(pIn, sampler, coord.xy+off.xy));			p1.hi = convert_int4(read_imageui(pIn, sampler, coord.xy+off.yy));
	p2.lo = convert_int4(read_imageui(pIn, sampler, coord.xy+off.xz));			p2.hi = convert_int4(read_imageui(pIn, sampler, coord.xy+off.yz));
	p3.lo = convert_int4(read_imageui(pIn, sampler, coord.xy+off.xw));			p3.hi = convert_int4(read_imageui(pIn, sampler, coord.xy+off.yw));
	p4.lo = convert_int4(read_imageui(pIn, sampler, coord.xy+off.xx + off2.xz));	p4.hi = convert_int4(read_imageui(pIn, sampler, coord.xy+off.yx + off2.xz));
	p5.lo = convert_int4(read_imageui(pIn, sampler, coord.xy+off.xy + off2.xz));	p5.hi = convert_int4(read_imageui(pIn, sampler, coord.xy+off.yy + off2.xz));
	p6.lo = convert_int4(read_imageui(pIn, sampler, coord.xy+off.xz + off2.xz));	p6.hi = convert_int4(read_imageui(pIn, sampler, coord.xy+off.yz + off2.xz));
	p7.lo = convert_int4(read_imageui(pIn, sampler, coord.xy+off.xw + off2.xz));	p7.hi = convert_int4(read_imageui(pIn, sampler, coord.xy+off.yw + off2.xz));

	i0 = p0; i1 = p1; i2 = p2; i3 = p3; i4 = p4; i5 = p5; i6 = p6; i7 = p7;

  	uint8 VAL_2 = (uint8)(2);
 	int count1, count2;
 	int8 d0, d1, d2, d3, d4, d5, d6;
 	int8 n0, n1, n2, n3, n4, n5, n6;
 	int8 flag, m0, param, sign;

	d0 = convert_int8(abs(p1-p0));	d1 = convert_int8(abs(p2-p1));	d2 = convert_int8(abs(p3-p2));
	d3 = convert_int8(abs(p4-p3));	d4 = convert_int8(abs(p5-p4));	d5 = convert_int8(abs(p6-p5));
	d6 = convert_int8(abs(p7-p6));

	n0 = -(d0 <= 2);	n1 = -(d1 <= 2);	n2 = -(d2 <= 2);
	n3 = -(d3 <= 2);	n4 = -(d4 <= 2);	n5 = -(d5 <= 2);
	n6 = -(d6 <= 2);

	n0 = n0 + n1 + n2 + n3 + n4 + n5 + n6;

	flag = -(n0 >= 6);

	count1 = flag.s0 + flag.s1 + flag.s2 + flag.s3 + flag.s4 + flag.s5 + flag.s6 + flag.s7;

	m0 = (int8)(count1>0);

//  if(count1>0)		//if-condition will reduce performance
	{
		int8 MaxValue, MinValue;
		MaxValue = max(max(max(max(max(max(max(p0, p1), p2), p3), p4), p5), p6), p7);
		MinValue = min(min(min(min(min(min(min(p0, p1), p2), p3), p4), p5), p6), p7);

		n2 = MaxValue - MinValue;
		n0 = -(n2>0);
		n1 = -(n2<20);

		flag = n0 * flag;
		count1 = flag.s0 + flag.s1 + flag.s2 + flag.s3 + flag.s4 + flag.s5 + flag.s6 + flag.s7;
		count1 = count1 > 0;

		flag = n1 * flag;
		count2 = flag.s0 + flag.s1 + flag.s2 + flag.s3 + flag.s4 + flag.s5 + flag.s6 + flag.s7;
		count2 = count2 > 0;

		m0 = m0 * count1 * count2;

//  	if(count1>0 && count2>0)
		{
			param = (int8)(8) - (MaxValue - MinValue) + (convert_int8(abs(p4 - p3)));
			sign = 1+signbit(convert_float8(param));
			param = param * sign * flag;

			n0 = p0 + p1 + p2 + p3;
			n1 = p4 + p5 + p6 + p7;

			i0 = (((((n0 + p0 * 4 + 4) * 2 - p3 + p4) / 16 - p0) * param + p0 * 8 + 4) / 8 + p0 + 1 ) / 2;
			i1 =  ((((n0 + p1 + p0 *2 + p4 + 4) * 2 - p4 + p5) / 16 - p1) * param + p1 * 8 + 4 ) / 8;
			i2 =  ((((n0 + p2 + p0 + p4 + p5 + 4) * 2 - p5 + p6) / 16 - p2) *param + p2 * 8 + 4 ) / 8;
			i3 =  ((((n0 + p3 + p4 + p5 + p6 + 4) * 2 - p6 + p7) / 16 - p3) * param + p3 * 8 + 4 ) / 8;
			i4 =  ((((n1 + p4 + p1 + p2 + p3 + 4) * 2 + p0 - p1) / 16 - p4) * param + p4 * 8 + 4) / 8;
			i5 =  ((((n1 + p5 + p2 + p3 + p7 + 4) * 2 + p1 - p2) / 16 - p5) * param + p5 * 8 + 4) / 8;
			i6 =  ((((n1 + p6 + p3 + p7 *2 + 4) * 2 + p2 - p3) / 16 - p6) * param + p6 * 8 + 4) / 8;
			i7 = (((((n1 + p7 * 4 + 4) * 2 + p3 - p4) / 16 - p7) * param + p7 * 8 + 4) / 8 + p7 + 1 ) / 2;

		}
	}

	//replace if-condition with below code to improve performance
	m0 = m0 * bValid;
	i0 = (1 - m0) * p0 + m0 * i0;
	i1 = (1 - m0) * p1 + m0 * i1;
	i2 = (1 - m0) * p2 + m0 * i2;
	i3 = (1 - m0) * p3 + m0 * i3;
	i4 = (1 - m0) * p4 + m0 * i4;
	i5 = (1 - m0) * p5 + m0 * i5;
	i6 = (1 - m0) * p6 + m0 * i6;
	i7 = (1 - m0) * p7 + m0 * i7;

//	transposition
	TRANSPOSE_8x8(i0, i1, i2, i3, i4, i5,i6, i7, p0, p1, p2, p3, p4, p5, p6, p7)

	write_imageui(pOut, coord.xy,				 convert_uint4(CLAMP_BYTE(p0.lo)));
	write_imageui(pOut, coord.xy+off.yx,		 convert_uint4(CLAMP_BYTE(p0.hi)));
	write_imageui(pOut, coord.xy+off.xy,		 convert_uint4(CLAMP_BYTE(p1.lo)));
	write_imageui(pOut, coord.xy+off.yy,		 convert_uint4(CLAMP_BYTE(p1.hi)));
	write_imageui(pOut, coord.xy+off.xz,		 convert_uint4(CLAMP_BYTE(p2.lo)));
	write_imageui(pOut, coord.xy+off.yz,		 convert_uint4(CLAMP_BYTE(p2.hi)));
	write_imageui(pOut, coord.xy+off.xw,		 convert_uint4(CLAMP_BYTE(p3.lo)));
	write_imageui(pOut, coord.xy+off.yw,		 convert_uint4(CLAMP_BYTE(p3.hi)));
	write_imageui(pOut, coord.xy+off.xx+off2.xz, convert_uint4(CLAMP_BYTE(p4.lo)));
	write_imageui(pOut, coord.xy+off.yx+off2.xz, convert_uint4(CLAMP_BYTE(p4.hi)));
	write_imageui(pOut, coord.xy+off.xy+off2.xz, convert_uint4(CLAMP_BYTE(p5.lo)));
	write_imageui(pOut, coord.xy+off.yy+off2.xz, convert_uint4(CLAMP_BYTE(p5.hi)));
	write_imageui(pOut, coord.xy+off.xz+off2.xz, convert_uint4(CLAMP_BYTE(p6.lo)));
	write_imageui(pOut, coord.xy+off.yz+off2.xz, convert_uint4(CLAMP_BYTE(p6.hi)));
	write_imageui(pOut, coord.xy+off.xw+off2.xz, convert_uint4(CLAMP_BYTE(p7.lo)));
	write_imageui(pOut, coord.xy+off.yw+off2.xz, convert_uint4(CLAMP_BYTE(p7.hi)));
}

__kernel void KN_Deblock_Row_G(__global uchar4 *pInput, __global uchar4 *pOutput, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iInStride = iSize.z;
	int iOutStride = iSize.w;
	int iW = iSize.x;
	int iH = iSize.y;

	int start = (4) * iInStride + (1);
	int pos = 8*gy * iInStride + gx*2;
	int ax =2*gx+1;
	int ay = 8*gy+4;
	int bdimy = (iH+7)>>3;
	int bdimx = (iW+1)>>1;
	int bValid;

	ax = ax>>1;
	ay = ay>>3;

	ax = ax<(bdimx-1);
	ay = ay<(bdimy-1);
	bValid = ax * ay;

	int4 p00 = convert_int4(pInput[start+pos]);
	int4 p01 = convert_int4(pInput[start+pos+1]);
	int4 p10 = convert_int4(pInput[start+pos+iInStride]);
	int4 p11 = convert_int4(pInput[start+pos+iInStride+1]);
	int4 p20 = convert_int4(pInput[start+pos+2*iInStride]);
	int4 p21 = convert_int4(pInput[start+pos+2*iInStride+1]);
	int4 p30 = convert_int4(pInput[start+pos+3*iInStride]);
	int4 p31 = convert_int4(pInput[start+pos+3*iInStride+1]);
	int4 p40 = convert_int4(pInput[start+pos+4*iInStride]);
	int4 p41 = convert_int4(pInput[start+pos+4*iInStride+1]);
	int4 p50 = convert_int4(pInput[start+pos+5*iInStride]);
	int4 p51 = convert_int4(pInput[start+pos+5*iInStride+1]);
	int4 p60 = convert_int4(pInput[start+pos+6*iInStride]);
	int4 p61 = convert_int4(pInput[start+pos+6*iInStride+1]);
	int4 p70 = convert_int4(pInput[start+pos+7*iInStride]);
	int4 p71 = convert_int4(pInput[start+pos+7*iInStride+1]);
	int4 i00 = p00, i01=p01, i10=p10, i11=p11, i20=p20, i21=p21, i30=p30, i31=p31;
	int4 i40 = p40, i41=p41, i50=p50, i51=p51, i60=p60, i61=p61, i70=p70, i71=p71;
	int4 d0, d1;
	int4 b0, b1;
	int4 n0 = (int4)0, n1 = (int4)0;
	int4 flag0 = (int4)0, flag1 = (int4)0;
	int count1, count2;
	int4 f0, f1;
	int4 m0;
	int4 fP0, fP1;
	int4 s0, s1;
	d0 = convert_int4(abs(p10 - p00));
	d1 = convert_int4(abs(p11 - p01));
	n0 = -(d0<=2);
	n1 = -(d1<=2);

	d0 = convert_int4(abs(p20 - p10));
	d1 = convert_int4(abs(p21 - p11));
	n0 -= (d0<=2);
	n1 -= (d1<=2);

	d0 = convert_int4(abs((p30 - p20)));
	d1 = convert_int4(abs((p31 - p21)));
	n0 -= (d0<=2);
	n1 -= (d1<=2);

	d0 = convert_int4(abs((p40 - p30)));
	d1 = convert_int4(abs((p41 - p31)));
	n0 -= (d0<=2);
	n1 -= (d1<=2);

	d0 = convert_int4(abs((p50 - p40)));
	d1 = convert_int4(abs((p51 - p41)));
	n0 -= (d0<=2);
	n1 -= (d1<=2);

	d0 = convert_int4(abs((p60 - p50)));
	d1 = convert_int4(abs((p61 - p51)));
	n0 -= (d0<=2);
	n1 -= (d1<=2);

	d0 = convert_int4(abs((p70 - p60)));
	d1 = convert_int4(abs((p71 - p61)));
	n0 -= (d0<=2);
	n1 -= (d1<=2);

	flag0 = -((n0)>=6);
	flag1 = -((n1)>=6);
	f0 = flag0 + flag1;
	count1 = f0.x + f0.y + f0.z + f0.w;

	m0 = (int4)(count1>0);
//  if(count1>0)		//if-condition will reduce performance
	{
		int4 fMax0, fMax1, fMin0, fMin1;
		fMax0 = max(max(max(max(max(max(max(p00, p10), p20), p30), p40), p50), p60), p70);
		fMin0 = min(min(min(min(min(min(min(p00, p10), p20), p30), p40), p50), p60), p70);
		fMax1 = max(max(max(max(max(max(max(p01, p11), p21), p31), p41), p51), p61), p71);
		fMin1 = min(min(min(min(min(min(min(p01, p11), p21), p31), p41), p51), p61), p71);

		d0 = (fMax0 - fMin0);
		d1 = (fMax1 - fMin1);
		f0 = -(d0>0);
		f1 = -(d1>0);
		flag0 = f0 * flag0;
		flag1 = f1 * flag1;

		f0 = f0 + f1;
		count1 = f0.x + f0.y + f0.z + f0.w;
		count1 = count1 > 0;

		f0 = -(d0<20);
		f1 = -(d1<20);
		flag0 = f0 * flag0;
		flag1 = f1 * flag1;

		f0 = f0 + f1;
		count2 = f0.x + f0.y + f0.z + f0.w;
		count2 = count2 > 0;
		m0 = m0 * count1 * count2;

//  	if(count1>0 && count2>0)
		{
			fP0 = (int4)8 - (fMax0 - fMin0 - convert_int4(abs(p40 - p30)));
			fP1 = (int4)8 - (fMax1 - fMin1 - convert_int4(abs(p41 - p31)));

			s0 = 1+signbit(convert_float4(fP0));
			s1 = 1+signbit(convert_float4(fP1));

			fP0 = fP0 * s0 * flag0;
			fP1 = fP1 * s1 * flag1;

			b0 = p00 + p10 + p20 + p30;
			b1 = p40 + p50 + p60 + p70;

			i00 = (((((b0 + p00 * 4 + 4) * 2 - p30 + p40) / 16 - p00) * fP0 + p00 * 8 + 4) / 8 + p00 + 1 ) / 2;
			i10 = ((((b0 + p10 + p00 *2 + p40 + 4) * 2 - p40 + p50) / 16 - p10) * fP0 + p10 * 8 + 4 ) / 8;
			i20 = ((((b0 + p20 + p00 + p40 + p50 + 4) * 2 - p50 + p60) / 16 - p20) *fP0 + p20 * 8 + 4 ) / 8;
			i30 = ((((b0 + p30 + p40 + p50 + p60 + 4) * 2 - p60 + p70) / 16 - p30) * fP0 + p30 * 8 + 4 ) / 8;
			i40 = ((((b1 + p40 + p10 + p20 + p30 + 4) * 2 + p00 - p10) / 16 - p40) * fP0 + p40 * 8 + 4) / 8;
			i50 = ((((b1 + p50 + p20 + p30 + p70 + 4) * 2 + p10 - p20) / 16 - p50) * fP0 + p50 * 8 + 4) / 8;
			i60 = ((((b1 + p60 + p30 + p70 *2 + 4) * 2 + p20 - p30) / 16 - p60) * fP0 + p60 * 8 + 4) / 8;
			i70 = (((((b1 + p70 * 4 + 4) * 2 + p30 - p40) / 16 - p70) * fP0 + p70 * 8 + 4) / 8 + p70 + 1 ) / 2;

			b0 = p01 + p11 + p21 + p31;
			b1 = p41 + p51 + p61 + p71;

			i01 = (((((b0 + p01 * 4 + 4) * 2 - p31 + p41) / 16 - p01) * fP1 + p01 * 8 + 4) / 8 + p01 + 1) / 2;
			i11 = ((((b0 + p11 + p01 *   2 + p41 + 4) * 2 - p41 + p51) / 16 - p11) * fP1 + p11 * 8 + 4) / 8;
			i21 = ((((b0 + p21 + p01 + p41 + p51 + 4) * 2 - p51 + p61) / 16 - p21) * fP1 + p21 * 8 + 4) / 8;
			i31 = ((((b0 + p31 + p41 + p51 + p61 + 4) * 2 - p61 + p71) / 16 - p31) * fP1 + p31 * 8 + 4) / 8;
			i41 = ((((b1 + p41 + p11 + p21 + p31 + 4) * 2 + p01 - p11) / 16 - p41) * fP1 + p41 * 8 + 4) / 8;
			i51 = ((((b1 + p51 + p21 + p31 + p71 + 4) * 2 + p11 - p21) / 16 - p51) * fP1 + p51 * 8 + 4) / 8;
			i61 = ((((b1 + p61 + p31 + p71 *   2 + 4) * 2 + p21 - p31) / 16 - p61) * fP1 + p61 * 8 + 4) / 8;
			i71 = (((((b1 + p71 * 4 + 4) * 2 + p31 - p41) / 16 - p71) * fP1 + p71 * 8 + 4) / 8 + p71 + 1) / 2;
		}
	}

	//replace if-condition with below code to improve performance
	i00 = (1 - m0) * p00 + m0 * i00;
	i10 = (1 - m0) * p10 + m0 * i10;
	i20 = (1 - m0) * p20 + m0 * i20;
	i30 = (1 - m0) * p30 + m0 * i30;
	i40 = (1 - m0) * p40 + m0 * i40;
	i50 = (1 - m0) * p50 + m0 * i50;
	i60 = (1 - m0) * p60 + m0 * i60;
	i70 = (1 - m0) * p70 + m0 * i70;

	i01 = (1 - m0) * p01 + m0 * i01;
	i11 = (1 - m0) * p11 + m0 * i11;
	i21 = (1 - m0) * p21 + m0 * i21;
	i31 = (1 - m0) * p31 + m0 * i31;
	i41 = (1 - m0) * p41 + m0 * i41;
	i51 = (1 - m0) * p51 + m0 * i51;
	i61 = (1 - m0) * p61 + m0 * i61;
	i71 = (1 - m0) * p71 + m0 * i71;

//	transposition
// 	p00.x = dot((float4)(i00), one.xyzw);	p00.y = dot((float4)(i10), one.xyzw);	p00.z = dot((float4)(i20), one.xyzw); 	p00.w = dot((float4)(i30), one.xyzw);
// 	p10.x = dot((float4)(i00), one.yxzw);	p10.y = dot((float4)(i10), one.yxzw);	p10.z = dot((float4)(i20), one.yxzw);	p10.w = dot((float4)(i30), one.yxzw);
// 	p20.x = dot((float4)(i00), one.yzxw);	p20.y = dot((float4)(i10), one.yzxw);	p20.z = dot((float4)(i20), one.yzxw);	p20.w = dot((float4)(i30), one.yzxw);
// 	p30.x = dot((float4)(i00), one.yzwx);	p30.y = dot((float4)(i10), one.yzwx);	p30.z = dot((float4)(i20), one.yzwx);	p30.w = dot((float4)(i30), one.yzwx);
// 	p40.x = dot((float4)(i01), one.xyzw);	p40.y = dot((float4)(i11), one.xyzw);	p40.z = dot((float4)(i21), one.xyzw);	p40.w = dot((float4)(i31), one.xyzw);
// 	p50.x = dot((float4)(i01), one.yxzw);	p50.y = dot((float4)(i11), one.yxzw);	p50.z = dot((float4)(i21), one.yxzw);	p50.w = dot((float4)(i31), one.yxzw);
// 	p60.x = dot((float4)(i01), one.yzxw);	p60.y = dot((float4)(i11), one.yzxw);	p60.z = dot((float4)(i21), one.yzxw);	p60.w = dot((float4)(i31), one.yzxw);
// 	p70.x = dot((float4)(i01), one.yzwx);	p70.y = dot((float4)(i11), one.yzwx);	p70.z = dot((float4)(i21), one.yzwx);	p70.w = dot((float4)(i31), one.yzwx);
//
// 	p01.x = dot((float4)(i40), one.xyzw);	p01.y = dot((float4)(i50), one.xyzw);	p01.z = dot((float4)(i60), one.xyzw);	p01.w = dot((float4)(i70), one.xyzw);
// 	p11.x = dot((float4)(i40), one.yxzw);	p11.y = dot((float4)(i50), one.yxzw);	p11.z = dot((float4)(i60), one.yxzw);	p11.w = dot((float4)(i70), one.yxzw);
// 	p21.x = dot((float4)(i40), one.yzxw);	p21.y = dot((float4)(i50), one.yzxw);	p21.z = dot((float4)(i60), one.yzxw);	p21.w = dot((float4)(i70), one.yzxw);
// 	p31.x = dot((float4)(i40), one.yzwx);	p31.y = dot((float4)(i50), one.yzwx);	p31.z = dot((float4)(i60), one.yzwx);	p31.w = dot((float4)(i70), one.yzwx);
// 	p41.x = dot((float4)(i41), one.xyzw);	p41.y = dot((float4)(i51), one.xyzw);	p41.z = dot((float4)(i61), one.xyzw);	p41.w = dot((float4)(i71), one.xyzw);
// 	p51.x = dot((float4)(i41), one.yxzw);	p51.y = dot((float4)(i51), one.yxzw);	p51.z = dot((float4)(i61), one.yxzw);	p51.w = dot((float4)(i71), one.yxzw);
// 	p61.x = dot((float4)(i41), one.yzxw);	p61.y = dot((float4)(i51), one.yzxw);	p61.z = dot((float4)(i61), one.yzxw);	p61.w = dot((float4)(i71), one.yzxw);
// 	p71.x = dot((float4)(i41), one.yzwx);	p71.y = dot((float4)(i51), one.yzwx);	p71.z = dot((float4)(i61), one.yzwx);	p71.w = dot((float4)(i71), one.yzwx);

	p00.x = i00.x; p00.y = i10.x; p00.z = i20.x; p00.w = i30.x;
	p10.x = i00.y; p10.y = i10.y; p10.z = i20.y; p10.w = i30.y;
	p20.x = i00.z; p20.y = i10.z; p20.z = i20.z; p20.w = i30.z;
	p30.x = i00.w; p30.y = i10.w; p30.z = i20.w; p30.w = i30.w;
	p40.x = i01.x; p40.y = i11.x; p40.z = i21.x; p40.w = i31.x;
	p50.x = i01.y; p50.y = i11.y; p50.z = i21.y; p50.w = i31.y;
	p60.x = i01.z; p60.y = i11.z; p60.z = i21.z; p60.w = i31.z;
	p70.x = i01.w; p70.y = i11.w; p70.z = i21.w; p70.w = i31.w;

	p01.x = i40.x; p01.y = i50.x; p01.z = i60.x; p01.w = i70.x;
	p11.x = i40.y; p11.y = i50.y; p11.z = i60.y; p11.w = i70.y;
	p21.x = i40.z; p21.y = i50.z; p21.z = i60.z; p21.w = i70.z;
	p31.x = i40.w; p31.y = i50.w; p31.z = i60.w; p31.w = i70.w;
	p41.x = i41.x; p41.y = i51.x; p41.z = i61.x; p41.w = i71.x;
	p51.x = i41.y; p51.y = i51.y; p51.z = i61.y; p51.w = i71.y;
	p61.x = i41.z; p61.y = i51.z; p61.z = i61.z; p61.w = i71.z;
	p71.x = i41.w; p71.y = i51.w; p71.z = i61.w; p71.w = i71.w;

	start = (4) * iOutStride + (1);
	pos = 8*gy * iOutStride + gx*2;
	if(bValid != 0)
	{
		pOutput[start+pos]				= convert_uchar4_sat(p00);
		pOutput[start+pos+1]			= convert_uchar4_sat(p01);
		pOutput[start+pos+iOutStride]	= convert_uchar4_sat(p10);
		pOutput[start+pos+iOutStride+1]	= convert_uchar4_sat(p11);
		pOutput[start+pos+2*iOutStride]	= convert_uchar4_sat(p20);
		pOutput[start+pos+2*iOutStride+1] = convert_uchar4_sat(p21);
		pOutput[start+pos+3*iOutStride]	  = convert_uchar4_sat(p30);
		pOutput[start+pos+3*iOutStride+1] = convert_uchar4_sat(p31);
		pOutput[start+pos+4*iOutStride]	  = convert_uchar4_sat(p40);
		pOutput[start+pos+4*iOutStride+1] = convert_uchar4_sat(p41);
		pOutput[start+pos+5*iOutStride]   = convert_uchar4_sat(p50);
		pOutput[start+pos+5*iOutStride+1] = convert_uchar4_sat(p51);
		pOutput[start+pos+6*iOutStride]	  = convert_uchar4_sat(p60);
		pOutput[start+pos+6*iOutStride+1] = convert_uchar4_sat(p61);
		pOutput[start+pos+7*iOutStride]   = convert_uchar4_sat(p70);
		pOutput[start+pos+7*iOutStride+1] = convert_uchar4_sat(p71);
	}

}

__kernel void KN_GetEdgeInfo(__read_only image2d_t pInput, __global uchar4 *pOutput, __global uchar *pTable, int4 iSize)
{
	int4 coord;
	const int4 offset = {0, 1, -1, 3};

	coord.x = get_global_id(0);
	coord.y = get_global_id(1);
	coord.z = get_local_id(0);
	coord.w = get_local_id(1);

	int iW = iSize.x;
	int iOutStride = iSize.w;

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int4 bBorder;
	bBorder.xy = coord.xx==(int2)0;
	bBorder.zw = coord.xx==(int2)(iW-1);

	int opos = coord.x + iOutStride * coord.y;

	{
		int4 p00 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.zz));
		int4 p01 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.xz));
		int4 p02 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.yz));
		int4 p10 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.zx));
		int4 p11 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.xx));
		int4 p12 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.yx));
		int4 p20 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.zy));
		int4 p21 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.xy));
		int4 p22 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.yy));
		int4 sx, sy;
		int4 data;
		int4 index;

		//boudary protection
		bBorder.yw = bBorder.xz^(int2)(UINT_MAX);

		p00 = CHECK_BOUNDARY(bBorder.xxxx, bBorder.yyyy, p00, p01.xxxx);
		p10 = CHECK_BOUNDARY(bBorder.xxxx, bBorder.yyyy, p10, p11.xxxx);
		p20 = CHECK_BOUNDARY(bBorder.xxxx, bBorder.yyyy, p20, p21.xxxx);
		p02 = CHECK_BOUNDARY(bBorder.zzzz, bBorder.wwww, p02, p01.wwww);
		p12 = CHECK_BOUNDARY(bBorder.zzzz, bBorder.wwww, p12, p11.wwww);
		p22 = CHECK_BOUNDARY(bBorder.zzzz, bBorder.wwww, p22, p21.wwww);

		p00.x = p00.w;
		p00.yzw = p01.xyz;
		p02.w = p02.x;
		p02.xyz = p01.yzw;
		p10.x = p10.w;
		p10.yzw = p11.xyz;
		p12.w = p12.x;
		p12.xyz = p11.yzw;
		p20.x = p20.w;
		p20.yzw = p21.xyz;
		p22.w = p22.x;
		p22.xyz = p21.yzw;

		sx = (p00 + (p01<<1) + p02) - (p20 + (p21<<1) + p22);
		sy = (p00 - p02) + ((p10 - p12)<<1) + (p20 - p22);

		data = MUL24(sx, sx) + MUL24(sy, sy);
		sx = (sx + 1022)>>2;
		data = data>3600;
		sy = (sy + 1022)>>2;
		sx = (data&sx) + (~data&255);
		sy = (data&sy) + (~data&255);

		index = (sx<<9) + sy;

		data.x = pTable[index.x];
		data.y = pTable[index.y];
		data.z = pTable[index.z];
		data.w = pTable[index.w];

		pOutput[opos] = convert_uchar4_sat(data);
	}
}

__kernel void KN_GetEdgeInfo_G(__global uchar4 *pInput, __global uchar4 *pOutput, __global uchar *pTable, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);
	int lx = get_local_id(0);
	int ly = get_local_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int iInStride = iSize.z;
	int iOutStride = iSize.w;

	int ipos = gx + iInStride * gy;
	int opos = gx + iOutStride * gy;
	int4 bTop = (int4)(gy==0);
	int4 bBottom = (int4)(gy==iH-1);
	int4 bLeft = (int4)(gx==0);
	int4 bRight = (int4)(gx==iW-1);

// 	if(isgreaterequal(gx, 0) && isless(gx, iW) && isgreaterequal(gy, 0) && isless(gy, iH))
	{
		int4 p00 = convert_int4(pInput[ipos-iInStride-1]);
		int4 p01 = convert_int4(pInput[ipos-iInStride]);
		int4 p02 = convert_int4(pInput[ipos-iInStride+1]);
		int4 p10 = convert_int4(pInput[ipos-1]);
		int4 p11 = convert_int4(pInput[ipos]);
		int4 p12 = convert_int4(pInput[ipos+1]);
		int4 p20 = convert_int4(pInput[ipos+iInStride-1]);
		int4 p21 = convert_int4(pInput[ipos+iInStride]);
		int4 p22 = convert_int4(pInput[ipos+iInStride+1]);
		int4 sx, sy;
		int4 data;
		int4 index;

		//boudary protection
		p00 = bTop*p10 + (1-bTop)*p00;
		p01 = bTop*p11 + (1-bTop)*p01;
		p02 = bTop*p12 + (1-bTop)*p02;

		p20 = bBottom*p10 + (1-bBottom)*p20;
		p21 = bBottom*p11 + (1-bBottom)*p21;
		p22 = bBottom*p12 + (1-bBottom)*p22;

		p00 = bLeft*p01.xxxx + (1-bLeft)*p00;
		p10 = bLeft*p11.xxxx + (1-bLeft)*p10;
		p20 = bLeft*p21.xxxx + (1-bLeft)*p20;

		p02 = bRight*p01.wwww + (1-bRight)*p02;
		p12 = bRight*p11.wwww + (1-bRight)*p12;
		p22 = bRight*p21.wwww + (1-bRight)*p22;

		p00.x = p00.w;
		p00.yzw = p01.xyz;
		p02.w = p02.x;
		p02.xyz = p01.yzw;
		p10.x = p10.w;
		p10.yzw = p11.xyz;
		p12.w = p12.x;
		p12.xyz = p11.yzw;
		p20.x = p20.w;
		p20.yzw = p21.xyz;
		p22.w = p22.x;
		p22.xyz = p21.yzw;

		sx = (p00 + p01*2 + p02) - (p20 + p21*2 + p22);
		sy = (p00 - p02) + (p10 - p12)*2 + (p20 - p22);

		data = sx*sx + sy*sy;
		data = -(data>3600);
		sx = data * (sx + 1022)/4 + (1-data)*255;
		sy = data * (sy + 1022)/4 + (1-data)*255;

		index = sx*512 + sy;


		data.x = pTable[index.x];
		data.y = pTable[index.y];
		data.z = pTable[index.z];
		data.w = pTable[index.w];

		pOutput[opos] = convert_uchar4_sat(data);
	}
}

#define GET_LEVEL_NUM()\
{\
	iNumInLevel = -(p00 == level);\
	iNumInLevel -= (p01 == level);\
	iNumInLevel -= (p02 == level);\
	iNumInLevel -= (p10 == level);\
	iNumInLevel -= (p11 == level);\
	iNumInLevel -= (p12 == level);\
	iNumInLevel -= (p20 == level);\
	iNumInLevel -= (p21 == level);\
	iNumInLevel -= (p22 == level);\
	iTotalNum += iNumInLevel;\
	iBinNum -= (iNumInLevel != 0);\
	bLarger = iNumInLevel>iMaxNumInLevel;\
	iMaxNumInLevel = CHOOSE_1IN2(bLarger, iNumInLevel, iMaxNumInLevel);\
	iMaxLevel = CHOOSE_1IN2(bLarger, level, iMaxLevel);\
	level = level<<1;\
}
__kernel void KN_EdgeAA_0(__global uchar4 *pLevel, __global uchar4 *pEdgeDir, __global uchar4 *pNewLevel, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int iInStride = iSize.z;
	int iOutStride = iSize.w;

	int ipos = gx + iInStride * gy;
	int opos = gx + iOutStride * gy;

	int4 bBorder;
	bBorder.x = -(gy==0);	//top;
	bBorder.y = -(gy==iH-1);	//bottom
	bBorder.z = -(gx==0);	//left;
	bBorder.w = -(gx==iW-1);	//Right;

	{
		int4 p00 = convert_int4(pLevel[ipos-iInStride-1]);
		int4 p01 = convert_int4(pLevel[ipos-iInStride]);
		int4 p02 = convert_int4(pLevel[ipos-iInStride+1]);
		int4 p10 = convert_int4(pLevel[ipos-1]);
		int4 p11 = convert_int4(pLevel[ipos]);
		int4 p12 = convert_int4(pLevel[ipos+1]);
		int4 p20 = convert_int4(pLevel[ipos+iInStride-1]);
		int4 p21 = convert_int4(pLevel[ipos+iInStride]);
		int4 p22 = convert_int4(pLevel[ipos+iInStride+1]);
		int4 level = (int4)1;
		int4 iMaxLevel = level;
		int4 iTotalNum = (int4)0;
		int4 iBinNum = (int4)0;
		int4 iNumInLevel = (int4)0;
		int4 iMaxNumInLevel = (int4)0;
		int4 bLarger = (int4)0;
		int4 bZero = (p11==0);

		p00 = CHECK_BOUNDARY(bBorder.xxxx, ~bBorder.xxxx, p00, p10);
		p01 = CHECK_BOUNDARY(bBorder.xxxx, ~bBorder.xxxx, p01, p11);
		p02 = CHECK_BOUNDARY(bBorder.xxxx, ~bBorder.xxxx, p02, p12);

		p20 = CHECK_BOUNDARY(bBorder.yyyy, ~bBorder.yyyy, p20, p10);
		p21 = CHECK_BOUNDARY(bBorder.yyyy, ~bBorder.yyyy, p21, p11);
		p22 = CHECK_BOUNDARY(bBorder.yyyy, ~bBorder.yyyy, p22, p12);

		p00 = CHECK_BOUNDARY(bBorder.zzzz, ~bBorder.zzzz, p00, p01.xxxx);
		p10 = CHECK_BOUNDARY(bBorder.zzzz, ~bBorder.zzzz, p10, p11.xxxx);
		p20 = CHECK_BOUNDARY(bBorder.zzzz, ~bBorder.zzzz, p20, p21.xxxx);

		p02 = CHECK_BOUNDARY(bBorder.wwww, ~bBorder.wwww, p02, p01.wwww);
		p12 = CHECK_BOUNDARY(bBorder.wwww, ~bBorder.wwww, p12, p11.wwww);
		p22 = CHECK_BOUNDARY(bBorder.wwww, ~bBorder.wwww, p22, p21.wwww);


		p00.x = p00.w;
		p00.yzw = p01.xyz;
		p02.w = p02.x;
		p02.xyz = p01.yzw;
		p10.x = p10.w;
		p10.yzw = p11.xyz;
		p12.w = p12.x;
		p12.xyz = p11.yzw;
		p20.x = p20.w;
		p20.yzw = p21.xyz;
		p22.w = p22.x;
		p22.xyz = p21.yzw;

		GET_LEVEL_NUM();	//level 1
		GET_LEVEL_NUM();	//level 2
		GET_LEVEL_NUM();	//level 4
		GET_LEVEL_NUM();	//level 8
		GET_LEVEL_NUM();	//level 16
		GET_LEVEL_NUM();	//level 32
		GET_LEVEL_NUM();	//level 64
		GET_LEVEL_NUM();	//level 128

		bLarger = (iTotalNum > (iMaxNumInLevel<<1));
		iBinNum = iBinNum <= 3;
		iMaxLevel = CHOOSE_1IN2(bLarger, p11, iMaxLevel);
		level = bZero|iBinNum;

		if(gx<iW && gy<iH)
		{
			pEdgeDir[opos] = convert_uchar4_sat(~bZero&(bZero|iBinNum)&iMaxLevel);
			pNewLevel[opos] = convert_uchar4_sat((-level)<<1);
		}
	}
}

#define SELECT_LEVEL(val)\
{\
	iTemp1 = iTemp & iLevel;	\
	bSelected = -(iTemp1 != 0);	\
	iData |= bSelected * val;	\
	iLevel = iLevel<<1;		\
}
__kernel void KN_EdgeAA_1(__global uchar4 *pEdgeDir, __global uchar4 *pLevel, __global uchar4 *pNewLevel, __global uchar *pTable, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);
	int lx = get_local_id(0);
	int ly = get_local_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int iInStride = iSize.z;
	int iOutStride = iSize.w;

	int ipos = gx + iInStride * gy;
	int opos = gx + iOutStride * gy;

	int4 bBorder;
	bBorder.x = -(gy==0);	//top;
	bBorder.y = -(gy==iH-1);	//bottom
	bBorder.z = -(gx==0);	//left;
	bBorder.w = -(gx==iW-1);	//Right;

	{
		int4 p00 = convert_int4(pEdgeDir[ipos-iInStride-1]);
		int4 p01 = convert_int4(pEdgeDir[ipos-iInStride]);
		int4 p02 = convert_int4(pEdgeDir[ipos-iInStride+1]);
		int4 p10 = convert_int4(pEdgeDir[ipos-1]);
		int4 p11 = convert_int4(pEdgeDir[ipos]);
		int4 p12 = convert_int4(pEdgeDir[ipos+1]);
		int4 p20 = convert_int4(pEdgeDir[ipos+iInStride-1]);
		int4 p21 = convert_int4(pEdgeDir[ipos+iInStride]);
		int4 p22 = convert_int4(pEdgeDir[ipos+iInStride+1]);
		int4 iOldLevel = convert_int4(pLevel[ipos]);
		int4 iNewLevel = convert_int4(pNewLevel[ipos]);
		int4 iTemp, iTemp1;
		int4 iLevel = (int4)1;
		int4 bSelected = (int4)0;
		int4 iData = (int4)0;
		int4 bLevel0 = (p11==0);

		p00 = CHOOSE_1IN2(bBorder.xxxx, p10, p00);
		p01 = CHOOSE_1IN2(bBorder.xxxx, p11, p01);
		p02 = CHOOSE_1IN2(bBorder.xxxx, p12, p02);

		p20 = CHOOSE_1IN2(bBorder.yyyy, p10, p20);
		p21 = CHOOSE_1IN2(bBorder.yyyy, p11, p21);
		p22 = CHOOSE_1IN2(bBorder.yyyy, p12, p22);

		p00 = CHOOSE_1IN2(bBorder.zzzz, p01.xxxx, p00);
		p10 = CHOOSE_1IN2(bBorder.zzzz, p11.xxxx, p10);
		p20 = CHOOSE_1IN2(bBorder.zzzz, p21.xxxx, p20);

		p02 = CHOOSE_1IN2(bBorder.wwww, p01.wwww, p02);
		p12 = CHOOSE_1IN2(bBorder.wwww, p11.wwww, p12);
		p22 = CHOOSE_1IN2(bBorder.wwww, p21.wwww, p22);

		p00.x = p00.w;
		p00.yzw = p01.xyz;
		p02.w = p02.x;
		p02.xyz = p01.yzw;
		p10.x = p10.w;
		p10.yzw = p11.xyz;
		p12.w = p12.x;
		p12.xyz = p11.yzw;
		p20.x = p20.w;
		p20.yzw = p21.xyz;
		p22.w = p22.x;
		p22.xyz = p21.yzw;

		iTemp.x = (int)(pTable[p11.x]);
		iTemp.y = (int)(pTable[p11.y]);
		iTemp.z = (int)(pTable[p11.z]);
		iTemp.w = (int)(pTable[p11.w]);

		SELECT_LEVEL(p22);	//level 1
		SELECT_LEVEL(p21);	//level 2
		SELECT_LEVEL(p20);	//level 4
		SELECT_LEVEL(p12);	//lelel 8
		SELECT_LEVEL(p10);	//level 16
		SELECT_LEVEL(p02);	//level 32
		SELECT_LEVEL(p01);	//level 64
		SELECT_LEVEL(p00);	//level 128

		iData = (iData!=0);
		iTemp1 = (iOldLevel == 0);

		pLevel[opos] = convert_uchar4_sat(CHOOSE_1IN2((bLevel0|~iData), 255, p11));
		pNewLevel[opos] = convert_uchar4_sat((iData|iTemp1)&iNewLevel);
	}
}

#define SELECT_LEVEL_SUM(val)\
{\
	iTemp1 = iTemp & iLevel;\
	bSelected = -(iTemp1 != 0);\
	iCount += bSelected;\
	iSum += bSelected * val;\
\
	iLevel = iLevel<<1;\
}
__kernel void KN_EdgeAA_2(__read_only image2d_t pInput, __global uchar4 *pLevel, __global uchar4 *pNewLevel, __write_only image2d_t pOutput, __global uchar *pTable, int4 iSize)
{
	int4 coord;
	const int4 offset = {0, 1, -1, 0};

	coord.x = get_global_id(0);
	coord.y = get_global_id(1);
	coord.z = get_local_id(0);
	coord.w = get_local_id(1);

	int iW = iSize.x;
	int iInStride = iSize.z;

	int4 iBorder;
	iBorder.x = -(coord.x==0);
	iBorder.y = -(coord.x==iW-1);

	int ipos = coord.x + iInStride * coord.y;

	{
		sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

		int4 p00 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.zz));
		int4 p01 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.xz));
		int4 p02 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.yz));
		int4 p10 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.zx));
		int4 p11 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.xx));
		int4 p12 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.yx));
		int4 p20 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.zy));
		int4 p21 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.xy));
		int4 p22 = convert_int4(read_imageui(pInput, sampler, coord.xy + offset.yy));


		int4 iLevel = convert_int4(pLevel[ipos]);
		int4 iNewLevel = convert_int4(pNewLevel[ipos]);
		int4 bSelected = 0;
		int4 iCount = 0;
		int4 iSum = 0;
		int4 bLevel255 = (iLevel==255);
		int4 iTemp, iTemp1;


		p00 = CHOOSE_1IN2(iBorder.xxxx, p01.xxxx, p00);
		p10 = CHOOSE_1IN2(iBorder.xxxx, p11.xxxx, p10);
		p20 = CHOOSE_1IN2(iBorder.xxxx, p21.xxxx, p20);
		p02 = CHOOSE_1IN2(iBorder.yyyy, p01.wwww, p02);
		p12 = CHOOSE_1IN2(iBorder.yyyy, p11.wwww, p12);
		p22 = CHOOSE_1IN2(iBorder.yyyy, p21.wwww, p22);

		p00.x = p00.w;
		p00.yzw = p01.xyz;
		p02.w = p02.x;
		p02.xyz = p01.yzw;
		p10.x = p10.w;
		p10.yzw = p11.xyz;
		p12.w = p12.x;
		p12.xyz = p11.yzw;
		p20.x = p20.w;
		p20.yzw = p21.xyz;
		p22.w = p22.x;
		p22.xyz = p21.yzw;

		iTemp.x = (int)(pTable[iLevel.x]);
		iTemp.y = (int)(pTable[iLevel.y]);
		iTemp.z = (int)(pTable[iLevel.z]);
		iTemp.w = (int)(pTable[iLevel.w]);

		iLevel = (int4)1;
		SELECT_LEVEL_SUM(p22);	//level 1
		SELECT_LEVEL_SUM(p21);	//level 2
		SELECT_LEVEL_SUM(p20);	//level 4
		SELECT_LEVEL_SUM(p12);	//level 8
		SELECT_LEVEL_SUM(p10);	//level 16
		SELECT_LEVEL_SUM(p02);	//level 32
		SELECT_LEVEL_SUM(p01);	//level 64
		SELECT_LEVEL_SUM(p00);	//level 128

		bSelected = -(iCount != 2) + 1;
		iSum = (iSum + bSelected)>>bSelected;

		iCount = convert_int4(abs(iSum-p11));
		bSelected = iCount>50;

		p00 = CHOOSE_1IN2((bLevel255|bSelected), p11, ((iNewLevel*(iSum-p11)+(p11<<2)+2)>>2));


		write_imageui(pOutput, coord.xy, convert_uint4(CLAMP_BYTE(p00)));
	}
}

__kernel void KN_EdgeAA_2_G(__global uchar4 *pInput, __global uchar4 *pLevel, __global uchar4 *pNewLevel, __global uchar4 *pOutput, __global uchar *pTable, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);

	int iW = iSize.x;
	int iH = iSize.y;
	int iInStride = iSize.z;
	int iOutStride = iSize.w;

	int ipos = gx + iInStride * gy;
	int opos = gx + iOutStride * gy;

	int bRight = (gx==iW-1);
	int bLeft = (gx==0);
	int bTop = (gy==0);
	int bBottom = (gy==iH-1);

	if(gx<iW && gy<iH)
	{
		int4 p00 = convert_int4(pInput[ipos-iInStride-1]);
		int4 p01 = convert_int4(pInput[ipos-iInStride]);
		int4 p02 = convert_int4(pInput[ipos-iInStride+1]);
		int4 p10 = convert_int4(pInput[ipos-1]);
		int4 p11 = convert_int4(pInput[ipos]);
		int4 p12 = convert_int4(pInput[ipos+1]);
		int4 p20 = convert_int4(pInput[ipos+iInStride-1]);
		int4 p21 = convert_int4(pInput[ipos+iInStride]);
		int4 p22 = convert_int4(pInput[ipos+iInStride+1]);
		int4 iLevel = convert_int4(pLevel[ipos]);
		int4 iNewLevel = convert_int4(pNewLevel[ipos]);
		int4 bSelected = 0;
		int4 iCount = 0;
		int4 iSum = 0;
		int4 bLevel255 = -(iLevel==255);
		int4 iTemp, iTemp1;

		p00 = (1 - bTop) * p00 + bTop * p10;
		p01 = (1 - bTop) * p01 + bTop * p11;
		p02 = (1 - bTop) * p02 + bTop * p12;
		p20 = (1-bBottom)* p20 +bBottom*p10;
		p21 = (1-bBottom)* p21 +bBottom*p11;
		p22 = (1-bBottom)* p22 +bBottom*p12;

		p00 = (1-bLeft) * p00 + bLeft * p01.xxxx;
		p10 = (1-bLeft) * p10 + bLeft * p11.xxxx;
		p20 = (1-bLeft) * p20 + bLeft * p21.xxxx;
		p02 = (1-bRight)* p02 + bRight * p01.wwww;
		p12 = (1-bRight)* p12 + bRight * p11.wwww;
		p22 = (1-bRight)* p22 + bRight * p21.wwww;

		p00.x = p00.w;
		p00.yzw = p01.xyz;
		p02.w = p02.x;
		p02.xyz = p01.yzw;
		p10.x = p10.w;
		p10.yzw = p11.xyz;
		p12.w = p12.x;
		p12.xyz = p11.yzw;
		p20.x = p20.w;
		p20.yzw = p21.xyz;
		p22.w = p22.x;
		p22.xyz = p21.yzw;

		iTemp.x = (int)(pTable[iLevel.x]);
		iTemp.y = (int)(pTable[iLevel.y]);
		iTemp.z = (int)(pTable[iLevel.z]);
		iTemp.w = (int)(pTable[iLevel.w]);

		iLevel = (int4)1;
		SELECT_LEVEL_SUM(p22);	//level 1
		SELECT_LEVEL_SUM(p21);	//level 2
		SELECT_LEVEL_SUM(p20);	//level 4
		SELECT_LEVEL_SUM(p12);	//level 8
		SELECT_LEVEL_SUM(p10);	//level 16
		SELECT_LEVEL_SUM(p02);	//level 32
		SELECT_LEVEL_SUM(p01);	//level 64
		SELECT_LEVEL_SUM(p00);	//level 128

		bSelected = -(iCount == 2);
		iSum = bSelected*(iSum+1)/2 + (1-bSelected)*(iSum+2)/4;

		iCount = convert_int4(abs(iSum - p11));
		iCount = iCount - 50;
		bSelected = -(iCount <= 0);

		pOutput[opos] = convert_uchar4_sat(bLevel255*p11 + (1-bLevel255)*((1-bSelected)*p11 + bSelected*(iNewLevel*(iSum-p11)+p11*4+2)/4));
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
