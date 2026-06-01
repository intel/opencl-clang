#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_amd_printf : enable

#define DEBLOCK_SIZE 8

#define AVG(a, b)	((a+b+1)>>1)
#define ALIGN_4(x)	(((x)+3)&~3)
#define MUL_255(v)	(((v)<<8) - (v))
#define MUL24(x,y)		mul24(x,y)
#define MAD24(x,y,z)	mad24(x,y,z)

#define CHECK_BOUNDARY(bCheck, bNotCheck, bvalue, v2) ((bCheck&v2) + (bNotCheck&bvalue))
#define CHOOSE_1IN2(bCheck, v1, v2) (((bCheck)&(v1)) + (~(bCheck)&(v2)))

#define CLAMP_BYTE(val) (clamp(val, 0, 255))
#define VECTOR_SUM(val) ((val).x+(val).y+(val).z+(val).w)
#define CHECK_IN_IMAGERANGE(x, y, w, h) (x)>=0 && (x)<=(w) && (y)>=0 && (y)<=(h)
#define CHECK_IN_SEARCHRANGE(x, pmin, pmax) (x)>=(pmin) && (x)<=(pmax)

#define COMPUTE_SAD(p0, p1) VECTOR_SUM(abs(p0-p1))

#define CHECK_BORDER(bLeft, bRight, val)	val = bLeft * val.xxxx + (1 - bLeft) * ( bRight * val.wwww + (1-bRight) * val);
#define RESET_MV(mv) (mv) = (int4)(0); mv.z = -1;
#define MAX_IN_VECTOR(value) max(max((value).x, (value).y), max((value).z, (value).w))
#define LEFT_SHIFT_4(type4, v0, v1, v2)\
{\
	type4 tmp = v0;\
	v0.xyz = v0.yzw;\
	v0.w = v1.x;\
	v1.xyz = v1.yzw;\
	v1.w = v2.x;\
	v2.xyz = v2.yzw;\
	v2.w = tmp.x;\
}
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

#define TRANSPOSE_4x4(type, s0, s1, s2, s3, d0, d1, d2, d3)\
{\
	type t0 = {1, 0, 0, 0, };\
	\
	d0 = s0.xxxx*t0.xyyy + s1.xxxx*t0.yxyy + s2.xxxx*t0.yyxy + s3.xxxx*t0.yyyx;\
	d1 = s0.yyyy*t0.xyyy + s1.yyyy*t0.yxyy + s2.yyyy*t0.yyxy + s3.yyyy*t0.yyyx;\
	d2 = s0.zzzz*t0.xyyy + s1.zzzz*t0.yxyy + s2.zzzz*t0.yyxy + s3.zzzz*t0.yyyx;\
	d3 = s0.wwww*t0.xyyy + s1.wwww*t0.yxyy + s2.wwww*t0.yyxy + s3.wwww*t0.yyyx;\
}
/*
	RGB to YUV
	Y = ( (  66 * R + 129 * G +  25 * B + 128) >> 8) +  16
	U = ( ( -38 * R -  74 * G + 112 * B + 128) >> 8) + 128
	V = ( ( 112 * R -  94 * G -  18 * B + 128) >> 8) + 128

	YUV to RGB
	R = clip(( 298 * (Y - 16)				    + 409 * (V - 128) + 128) >> 8)
	G = clip(( 298 * (Y - 16) - 100 * (U - 128) - 208 * (V - 128) + 128) >> 8)
	B = clip(( 298 * (Y - 16) + 516 * (U - 128)					  + 128) >> 8)

	refer to http://msdn.microsoft.com/en-us/library/ms893078
*/
__kernel void KN_ARGB2YUV(__read_only image2d_t pSrc, __write_only image2d_t pDstY, __write_only image2d_t pDstV, __write_only image2d_t pDstU)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int2 ipos1 = {opos.x<<2, opos.y};
	int4 ipos2 = {ipos1.x+1, ipos1.x+2, ipos1.x+3, ipos1.y};

	float4 f0 = read_imagef(pSrc, sampler, ipos1.xy);
	float4 f1 = read_imagef(pSrc, sampler, ipos2.xw);
	float4 f2 = read_imagef(pSrc, sampler, ipos2.yw);
	float4 f3 = read_imagef(pSrc, sampler, ipos2.zw);

	int4 r0 = convert_int4(f0 * 255.0f+0.5f);
	int4 r1 = convert_int4(f1 * 255.0f+0.5f);
	int4 r2 = convert_int4(f2 * 255.0f+0.5f);
	int4 r3 = convert_int4(f3 * 255.0f+0.5f);

	int4 B, G, R, A;
	int4 dstY, dstU, dstV;

	TRANSPOSE_4x4(int4, r0, r1, r2, r3, B, G, R, A);
// 		Y = ( (  66 * R + 129 * G +  25 * B + 128) >> 8) +  16
// 		U = ( ( -38 * R -  74 * G + 112 * B + 128) >> 8) + 128
// 		V = ( ( 112 * R -  94 * G -  18 * B + 128) >> 8) + 128
	__const int4 bgr2y = {25,  129, 66,  16};
	__const int4 bgr2u = {112, -74, -38, 128};
	__const int4 bgr2v = {-18, -94, 112, 128};

	dstY = ((bgr2y.xxxx * B + bgr2y.yyyy * G + bgr2y.zzzz * R + 128)>>8) + bgr2y.wwww;
	dstV = ((bgr2v.xxxx * B + bgr2v.yyyy * G + bgr2v.zzzz * R + 128)>>8) + bgr2v.wwww;
	dstU = ((bgr2u.xxxx * B + bgr2u.yyyy * G + bgr2u.zzzz * R + 128)>>8) + bgr2u.wwww;
	dstY = CLAMP_BYTE(dstY);
	dstU = CLAMP_BYTE(dstU);
	dstV = CLAMP_BYTE(dstV);

	write_imageui(pDstY, opos, convert_uint4(dstY));
	write_imageui(pDstU, opos, convert_uint4(dstU));
	write_imageui(pDstV, opos, convert_uint4(dstV));
}

__kernel void KN_YUVToARGB(__read_only image2d_t pY, __read_only image2d_t pV, __read_only image2d_t pU, __write_only image2d_t pDst)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int2 ipos = {opos.x>>2, opos.y};
	int4 offset = opos.xxxx&0x3;
	int4 mask = {0, 1, 2, 3};

	int4 iY = convert_int4(read_imageui(pY, sampler, ipos));
	int4 iU = convert_int4(read_imageui(pU, sampler, ipos));
	int4 iV = convert_int4(read_imageui(pV, sampler, ipos));
	int4 iYUV = (int4)(0);

	int4 iBGRA;
	float4 fBGRA;

	offset = -(offset==mask);

	iYUV.x = VECTOR_SUM(offset*iY);
	iYUV.y = VECTOR_SUM(offset*iU);
	iYUV.z = VECTOR_SUM(offset*iV);

	iYUV.x = (iYUV.x-16) * 298 + 128;
	iYUV.yz = iYUV.yz - 128;

// 	R = clip(( 298 * (Y - 16)				    + 409 * (V - 128) + 128) >> 8)
// 	G = clip(( 298 * (Y - 16) - 100 * (U - 128) - 208 * (V - 128) + 128) >> 8)
// 	B = clip(( 298 * (Y - 16) + 516 * (U - 128)					  + 128) >> 8)

	iBGRA.z = (iYUV.x				 + 409 * iYUV.z )>>8;
	iBGRA.y = (iYUV.x - 100 * iYUV.y - 208 * iYUV.z )>>8;
	iBGRA.x = (iYUV.x + 516 * iYUV.y				)>>8;
	iBGRA.w = 255;

	fBGRA = convert_float4(iBGRA)/255.0f;

	write_imagef(pDst, opos.xy, fBGRA);
}

/*
	Parameter: iSize: x: image width;
					  y: image height;
					  z: display mode - SimHD_Splitter
					  w: (Middle line width)/2
*/
__kernel void KN_YUVToARGB_split(__read_only image2d_t pY, __read_only image2d_t pV, __read_only image2d_t pU,
								  __read_only image2d_t pSrc, __write_only image2d_t pDst, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int w4 = ALIGN_4(iSize.x>>2);
	int2 ipos = {(opos.x-MUL24(w4, iSize.z))>>2, opos.y};
	int2 lpos = {(opos.x+MUL24(w4, iSize.z)), opos.y};
	int4 offset = opos.xxxx&0x3;
	int4 mask = {0, 1, 2, 3};

	float4 fBGRA;
	float4 fBlack = {0.0f, 0.0f, 0.0f, 1.0f};
	int2 middle = {(iSize.x>>1) - iSize.w, (iSize.x>>1)+1+iSize.w};
	int bLeft = opos.x<middle.x;
	int bRight = opos.x>middle.y;
	int bMid = !bLeft && !bRight;

 	if(bLeft||bMid)
	{
		float4 fOrigin = read_imagef(pSrc, sampler, lpos);// {0.1f, 0.5f, 0.8f, 1.0f};//
		fBGRA = fOrigin*bLeft + fBlack*bMid;
	}
	else
	{
		int4 iYUV = (int4)(0);
		int4 iBGRA;
		int4 iY = convert_int4(read_imageui(pY, sampler, ipos));
		int4 iU = convert_int4(read_imageui(pU, sampler, ipos));
		int4 iV = convert_int4(read_imageui(pV, sampler, ipos));
		offset = -(offset==mask);

		iYUV.x = VECTOR_SUM(offset*iY);
		iYUV.y = VECTOR_SUM(offset*iU);
		iYUV.z = VECTOR_SUM(offset*iV);

		iYUV.x = (iYUV.x-16) * 298 + 128;
		iYUV.yz = iYUV.yz - 128;

		// 	R = clip(( 298 * (Y - 16)				    + 409 * (V - 128) + 128) >> 8)
		// 	G = clip(( 298 * (Y - 16) - 100 * (U - 128) - 208 * (V - 128) + 128) >> 8)
		// 	B = clip(( 298 * (Y - 16) + 516 * (U - 128)					  + 128) >> 8)

		iBGRA.z = (iYUV.x				 + 409 * iYUV.z )>>8;
		iBGRA.y = (iYUV.x - 100 * iYUV.y - 208 * iYUV.z )>>8;
		iBGRA.x = (iYUV.x + 516 * iYUV.y				)>>8;
		iBGRA.w = 255;

		fBGRA = convert_float4(iBGRA)/255.0f;

		//fBGRA = fOrigin.zyxw*bLeft + fBlack*bMid + bRight*convert_float4(iBGRA)/255.0f;

	}

	write_imagef(pDst, opos.xy, fBGRA);
}
__kernel void KN_YUVToYV12(__read_only image2d_t pV, __read_only image2d_t pU,
						   __write_only image2d_t pDstV, __write_only image2d_t pDstU)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int4 ipos;
	ipos.xy = opos<<1;
	ipos.zw = ipos.xy + 1;

	uint4 v0 = read_imageui(pV, sampler, ipos.xy);
	uint4 v1 = read_imageui(pV, sampler, ipos.zy);
	uint4 v2 = read_imageui(pV, sampler, ipos.xw);
	uint4 v3 = read_imageui(pV, sampler, ipos.zw);
	uint4 u0 = read_imageui(pU, sampler, ipos.xy);
	uint4 u1 = read_imageui(pU, sampler, ipos.zy);
	uint4 u2 = read_imageui(pU, sampler, ipos.xw);
	uint4 u3 = read_imageui(pU, sampler, ipos.zw);

	uint4 dv, du;
	dv.xy = v0.xz + v0.yw + v2.xz + v2.yw;
	dv.zw = v1.xz + v1.yw + v3.xz + v3.yw;
	du.xy = u0.xz + u0.yw + u2.xz + u2.yw;
	du.zw = u1.xz + u1.yw + u3.xz + u3.yw;

	dv = (dv+2)>>2;
	du = (du+2)>>2;

	write_imageui(pDstV, opos, dv);
	write_imageui(pDstU, opos, du);
}

__kernel void KN_YV12ToYUV(__read_only image2d_t pV, __read_only image2d_t pU,
						   __write_only image2d_t pDstV, __write_only image2d_t pDstU)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int2 ipos = opos>>1;
	uint4 m = convert_uint4(opos.xxxx&1);

	uint4 v0 = read_imageui(pV, sampler, ipos.xy);
	uint4 u0 = read_imageui(pU, sampler, ipos.xy);
	uint4 v1 = v0.xxyy;
	uint4 u1 = u0.xxyy;
	v0 = v0.zzww;
	u0 = u0.zzww;
	v0 = v1*(1-m) + v0*m;
	u0 = u1*(1-m) + u0*m;

	write_imageui(pDstV, opos, v0);
	write_imageui(pDstU, opos, u0);
}
//downsample and compress 16 uchar to 4 int
__kernel void KN_Histogram256_Image_0(__read_only image2d_t pSrc, __global uint4 *pCompress, int4 iSize)
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
	uint4 out;

	out.x = c0.x | c0.y<<8 | c0.z<<16 | c0.w<<24;
	out.y = c1.x | c1.y<<8 | c1.z<<16 | c1.w<<24;
	out.z = c2.x | c2.y<<8 | c2.z<<16 | c2.w<<24;
	out.w = c3.x | c3.y<<8 | c3.z<<16 | c3.w<<24;

	if(gx<iW && gy<iH)
	{
		int oPos = gy*iOutStride + gx;
		pCompress[oPos] = out;
	}
}

__kernel void KN_Histogram256_Image_3_YV12(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
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

	U = max(min(U, 255), 0);
	V = max(min(V, 255), 0);

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

__kernel void KN_Histogram256_Image_3(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
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

	U = max(min(U, 255), 0);
	V = max(min(V, 255), 0);

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


__attribute__((always_inline)) void _Atomic_Inc_Vector(__local uint *pShareMem, uint data)
{
	uint4 v;
	v.x = data&0xFF;
	v.y = (data>>8)&0xFF;
	v.z = (data>>16)&0xFF;
	v.w = (data>>24)&0xFF;
	atomic_inc(&pShareMem[v.x]);
	atomic_inc(&pShareMem[v.y]);
	atomic_inc(&pShareMem[v.z]);
	atomic_inc(&pShareMem[v.w]);
}

__kernel void KN_Histogram256_LDS(__global uint4* pSrc, __global uint *pHist, __local uint *pLDS, int4 iSize)
{
	int gx = get_global_id(0);
	int bx = get_group_id(0);
	int by = get_group_id(1);
	int bdimx = get_num_groups(0);
	int bdimy = get_num_groups(1);
	int lx = get_local_id(0);
	int ly = get_local_id(1);
	int ldimx = get_local_size(0);
	int ldimy = get_local_size(1);

	int lPos = (by*bdimx+bx)*256;
	int iW = iSize.x;
	int iH = iSize.y;
	int iStride = iSize.z;

	__local uint *pShareArray = pLDS + lPos;

	pLDS[lPos + ly*ldimx+lx]=0;
	barrier(CLK_LOCAL_MEM_FENCE);

	int iPosX = bx*ldimx + lx;
	int iPosY = (by*ldimy + ly)*4;
	uint4 data = 0;

	if((iPosX<iW) && (iPosY<iH))
	{
		data = pSrc[iPosY*iStride+iPosX];
		_Atomic_Inc_Vector(pShareArray, data.x);
		_Atomic_Inc_Vector(pShareArray, data.y);
		_Atomic_Inc_Vector(pShareArray, data.z);
		_Atomic_Inc_Vector(pShareArray, data.w);
	}

	iPosY += 1;
	if((iPosX<iW) && (iPosY<iH))
	{
		data = pSrc[iPosY*iStride+iPosX];
		_Atomic_Inc_Vector(pShareArray, data.x);
		_Atomic_Inc_Vector(pShareArray, data.y);
		_Atomic_Inc_Vector(pShareArray, data.z);
		_Atomic_Inc_Vector(pShareArray, data.w);
	}

	iPosY += 1;
	if((iPosX<iW) && (iPosY<iH))
	{
		data = pSrc[iPosY*iStride+iPosX];
		_Atomic_Inc_Vector(pShareArray, data.x);
		_Atomic_Inc_Vector(pShareArray, data.y);
		_Atomic_Inc_Vector(pShareArray, data.z);
		_Atomic_Inc_Vector(pShareArray, data.w);
	}

	iPosY += 1;
	if((iPosX<iW) && (iPosY<iH))
	{
		data = pSrc[iPosY*iStride+iPosX];
		_Atomic_Inc_Vector(pShareArray, data.x);
		_Atomic_Inc_Vector(pShareArray, data.y);
		_Atomic_Inc_Vector(pShareArray, data.z);
		_Atomic_Inc_Vector(pShareArray, data.w);
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	pHist[lPos+ly*ldimx+lx] = pLDS[lPos + ly*ldimx+lx];
}

__kernel void KN_Histogram256_LDS_1(__global uint *pHistSum, __global uint *pHist, int4 iSize)
{
	int gx = get_global_id(0);
	int gy = get_global_id(1);
	int iPos = gy*16+gx;
	int num = iSize.z*iSize.w;
	uint uiCount = 0;
	for(int i=0; i<num; i++)
	{
		uiCount += pHistSum[i*256+iPos];
	}
	pHist[iPos] = uiCount;
}

__kernel void KN_SharpenUM_Image_0(__read_only image2d_t pIn, __write_only image2d_t pOut, int4 iSize)
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

__kernel void KN_SharpenUM_Image_1(__read_only image2d_t pSrc, __read_only image2d_t pIn, __write_only image2d_t pOut, int4 iSize, int iSharpen)
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
//  		printf("KN_SharpenUM_Image_1: coord %d, %d, %d, %d.\n", coord.x, bLeft.z, bRight.z, iW);


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

/*
	Function: deblock for row
	Params	:
		pIn:  uint8, src frame
		pOut: uint8, dst frame
		iRect: resolution of current frame

	performance:
		[2010/11/19, cml] on HD5600, 0.14ms for 720x480, 0.61ms for 1920x1088
*/

__attribute__((always_inline)) int _GetMaxMinDiff(int8 s)
{
	int4 maxv = max(s.lo, s.hi);
	int4 minv = min(s.lo, s.hi);
	maxv.xy = max(maxv.xy, maxv.zw);
	minv.xy = min(minv.xy, minv.zw);
	maxv.x = max(maxv.x, maxv.y);
	minv.x = min(minv.x, minv.y);
	return (int)(maxv.x - minv.x);
}


__kernel void KN_Deblock_Image(__read_only image2d_t pIn, __write_only image2d_t pOut, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int2 gpos = {get_global_id(0), get_global_id(1)};
	int4 coord = {(gpos.x<<1)+1, gpos.y+4, 0, 0};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int4 opos = {(gpos.x<<1), (gpos.x<<1)+1, gpos.y, gpos.y};

	uint4 u0 = read_imageui(pIn, sampler, opos.xz);
	uint4 u1 = read_imageui(pIn, sampler, opos.yw);

	write_imageui(pOut, opos.xz, u0);
	write_imageui(pOut, opos.yw, u1);
	barrier(CLK_GLOBAL_MEM_FENCE);

	coord.z = coord.x + 1;
	int iW = iSize.x;
	int iH = iSize.y;
	int bValid = coord.x<iW-1 && coord.y<iH-4 && coord.x>=1 && coord.y>=4;
	int8 p0;

	p0.lo = convert_int4(read_imageui(pIn, sampler, coord.xy));
	p0.hi = convert_int4(read_imageui(pIn, sampler, coord.zy));
	int8 i0=p0;

	__local int lMem[256*2];
	__local int *plCount = lMem;
	int CountIdx = ((lpos.y>>3)<<5) + (lpos.x<<1);
	int CountIdx2 = ((get_local_size(1)>>3)<<5) + CountIdx;
	int CountIdx3 = ((get_local_size(1)>>3)<<5) + CountIdx2;
	int lMemIdx = lpos.y*32 + lpos.x*2;

	lMem[lMemIdx] = 0;
	lMem[lMemIdx+1]=0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int8 d0 = convert_int8(abs(p0.s12345670 - p0.s01234560));
	int bFlag = 0;
	int max_min_diff;
	int m;

	{
		max_min_diff = _GetMaxMinDiff(p0);
		d0 = -(d0 <= 2);
		d0.s7 = 0;
		d0.lo = d0.lo + d0.hi;
		d0.lo.xy = d0.lo.xy + d0.lo.zw;
		d0.lo.x = d0.lo.x + d0.lo.y;
		bFlag = d0.lo.x>=6;
	}

	atomic_add(plCount + CountIdx, bFlag);

	{
		d0.s0 = max_min_diff>0;
		d0.s1 = max_min_diff<20;

		bFlag = bFlag * d0.s0 * d0.s1;
	}

	atomic_add(plCount + CountIdx2, d0.s0);
	atomic_add(plCount + CountIdx3, d0.s1);

	barrier(CLK_LOCAL_MEM_FENCE);

	{
		m = plCount[CountIdx] * plCount[CountIdx2] * plCount[CountIdx3];
		m = m>0;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

		int nParam = 8 - (max_min_diff - (int)(abs(p0.s4 - p0.s3)));
	{
		d0.s0 = nParam>0;
		nParam = bFlag * d0.s0 * nParam;

		d0 = p0.s45670123 - p0.s34561234;
		i0 = p0.s00001234 + p0.s00012345 + p0.s00123456 + p0*2 + p0.s12345677 + p0.s23456777 + p0.s34567777;
		i0 = (i0 + 4)<<1;
		i0 = (i0 + d0)>>4;
		i0 = ((i0 - p0)*nParam + (p0<<3) + 4)>>3;
		i0.s07 = (i0.s07 + p0.s07 + 1)>>1;

		m = m*bValid;
		i0 = i0 * m + p0 * (1-m);

		i0.lo = clamp(i0.lo, 0, 255);
		i0.hi = clamp(i0.hi, 0, 255);

		i0.s0 = i0.lo.x | i0.lo.y<<8 | i0.lo.z<<16 | i0.lo.w<<24;
		i0.s1 = i0.hi.x | i0.hi.y<<8 | i0.hi.z<<16 | i0.hi.w<<24;
		lMem[lMemIdx] = i0.s0;
		lMem[lMemIdx+1] = i0.s1;
	}

	barrier(CLK_LOCAL_MEM_FENCE);
	{
		lMemIdx = ((lpos.y>>3)<<8) + (lpos.x<<1);

		d0.s0 = (lpos.y&7)>>2;
		d0.s1 = (lpos.y&3)<<3;

		p0.s0 = lMem[lMemIdx+d0.s0];
		p0.s1 = lMem[lMemIdx+d0.s0+32];
		p0.s2 = lMem[lMemIdx+d0.s0+32*2];
		p0.s3 = lMem[lMemIdx+d0.s0+32*3];
		p0.s4 = lMem[lMemIdx+d0.s0+32*4];
		p0.s5 = lMem[lMemIdx+d0.s0+32*5];
		p0.s6 = lMem[lMemIdx+d0.s0+32*6];
		p0.s7 = lMem[lMemIdx+d0.s0+32*7];

		p0 = (p0>>d0.s1)&0x000000FF;
	}
//	row
	barrier(CLK_LOCAL_MEM_FENCE);
	{
		lMemIdx = (lpos.y<<5) + (lpos.x<<1);
		lMem[lMemIdx] = 0;
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	{
		d0 = convert_int8(abs(p0.s12345670 - p0.s01234560));

		max_min_diff = _GetMaxMinDiff(p0);
		d0 = -(d0 <= 2);
		d0.s7 = 0;
		d0.lo = d0.lo + d0.hi;
		d0.lo.xy = d0.lo.xy + d0.lo.zw;
		d0.lo.x = d0.lo.x + d0.lo.y;
		bFlag = d0.lo.x>=6;

		atomic_add(plCount + CountIdx, bFlag);

		d0.s0 = max_min_diff>0;
		d0.s1 = max_min_diff<20;

		bFlag = bFlag * d0.s0 * d0.s1;

		atomic_add(plCount + CountIdx2, d0.s0);
		atomic_add(plCount + CountIdx3, d0.s1);
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	{
		m = plCount[CountIdx] * plCount[CountIdx2] * plCount[CountIdx3];
		m = m>0;
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	{
		nParam = 8 - (max_min_diff - (int)(abs(p0.s4 - p0.s3)));
		d0.s0 = nParam>0;
		nParam = bFlag * d0.s0 * nParam;

		d0 = p0.s45670123 - p0.s34561234;
		i0 = p0.s00001234 + p0.s00012345 + p0.s00123456 + p0*2 + p0.s12345677 + p0.s23456777 + p0.s34567777;
		i0 = (i0 + 4)<<1;
		i0 = (i0 + d0)>>4;
		i0 = ((i0 - p0)*nParam + (p0<<3) + 4)>>3;
		i0.s07 = (i0.s07 + p0.s07 + 1)>>1;

		m = m*bValid;
		i0 = i0 * m + p0 * (1-m);

		i0.lo = clamp(i0.lo, 0, 255);
		i0.hi = clamp(i0.hi, 0, 255);

		i0.s0 = i0.lo.x | i0.lo.y<<8 | i0.lo.z<<16 | i0.lo.w<<24;
		i0.s1 = i0.hi.x | i0.hi.y<<8 | i0.hi.z<<16 | i0.hi.w<<24;
		lMem[lMemIdx] = i0.s0;
		lMem[lMemIdx+1] = i0.s1;
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	{
		lMemIdx = ((lpos.y>>3)<<8) + (lpos.x<<1);

		d0.s0 = (lpos.y&7)>>2;
		d0.s1 = (lpos.y&3)<<3;

		p0.s0 = lMem[lMemIdx+d0.s0];
		p0.s1 = lMem[lMemIdx+d0.s0+32];
		p0.s2 = lMem[lMemIdx+d0.s0+32*2];
		p0.s3 = lMem[lMemIdx+d0.s0+32*3];
		p0.s4 = lMem[lMemIdx+d0.s0+32*4];
		p0.s5 = lMem[lMemIdx+d0.s0+32*5];
		p0.s6 = lMem[lMemIdx+d0.s0+32*6];
		p0.s7 = lMem[lMemIdx+d0.s0+32*7];

		p0 = (p0>>d0.s1)&0x000000FF;
	}
	write_imageui(pOut, coord.xy, convert_uint4(p0.lo));
	write_imageui(pOut, coord.zy, convert_uint4(p0.hi));
}

__kernel void KN_GetEdgeInfo_Image(__read_only image2d_t pInput, __global uchar4 *pOutput, __global uchar *pTable, int4 iSize)
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

// 	if(isgreaterequal(gx, 0) && isless(gx, iW) && isgreaterequal(gy, 0) && isless(gy, iH))
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
__kernel void KN_EdgeAA_Image_0(__global uchar4 *pLevel, __global uchar4 *pEdgeDir, __global uchar4 *pNewLevel, int4 iSize)
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

		pEdgeDir[opos] = convert_uchar4_sat(~bZero&(bZero|iBinNum)&iMaxLevel);
		pNewLevel[opos] = convert_uchar4_sat((-level)<<1);
	}
}

#define SELECT_LEVEL(val)\
{\
	iTemp1 = iTemp & iLevel;	\
	bSelected = -(iTemp1 != 0);	\
	iData |= MUL24(bSelected, val);	\
	iLevel = iLevel<<1;		\
}
__kernel void KN_EdgeAA_Image_1(__global uchar4 *pEdgeDir, __global uchar4 *pLevel, __global uchar4 *pNewLevel, __global uchar *pTable, int4 iSize)
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

	//if(isgreaterequal(gx, 0) && isless(gx, iW) && isgreaterequal(gy, 0) && isless(gy, iH))
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
__kernel void KN_EdgeAA_Image_2(__read_only image2d_t pInput, __global uchar4 *pLevel, __global uchar4 *pNewLevel, __write_only image2d_t pOutput, __global uchar *pTable, int4 iSize)
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

__attribute__((always_inline)) uint4 _Read16PixelsFromImageAndSum(__read_only image2d_t pSrc, sampler_t sampler, int2 pos)
{
	__const int4 offset = {1, 2, 3, 0};
	uint4 d0 = read_imageui(pSrc, sampler, pos);
	uint4 d1 = read_imageui(pSrc, sampler, pos+offset.xw);
	uint4 d2 = read_imageui(pSrc, sampler, pos+offset.yw);
	uint4 d3 = read_imageui(pSrc, sampler, pos+offset.zw);
	uint4 e0;

// 	printf("input data %x, %x, %x, %x\n", d0.x, d1.x, d2.x, d3.x);

	e0.x = VECTOR_SUM(d0);
	e0.y = VECTOR_SUM(d1);
	e0.z = VECTOR_SUM(d2);
	e0.w = VECTOR_SUM(d3);
	return e0;
}

//pLDS: bdimx*uint4*bdimy*4
//param: (x,y): original resolution
__kernel void KN_4x4DownSample(__read_only image2d_t pSrc, __write_only image2d_t pDst, int4 param)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int4 coord = {get_global_id(0), get_global_id(1), 0, 0};
	coord.zw = coord.xy*4;

	__const int4 offset = {1,2,3,0};
	int2 gpos = {get_group_id(0), get_group_id(1)};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int2 bdim = {get_num_groups(0), get_num_groups(1)};
	uint4 e0=0, e1=0, e2=0, e3=0;

	e0 = _Read16PixelsFromImageAndSum(pSrc, sampler, coord.zw);
	e1 = _Read16PixelsFromImageAndSum(pSrc, sampler, coord.zw+offset.wx);
	e2 = _Read16PixelsFromImageAndSum(pSrc, sampler, coord.zw+offset.wy);
	e3 = _Read16PixelsFromImageAndSum(pSrc, sampler, coord.zw+offset.wz);

	e0 = (e0 + e1 + e2 + e3 + 8)>>4;

	write_imageui(pDst, coord.xy, CLAMP_BYTE(e0));
}

__kernel void KN_ResetMv(__write_only image2d_t pMv)
{
	int2 pos = {get_global_id(0), get_global_id(1)};
	int4 mv = {0, 0, -1, 2};
	write_imagei(pMv, pos, mv);
}

#define CHECK_4x4BLK_SAD(ix)\
{\
	uint sad = 0;\
	sad  = COMPUTE_SAD(r0.s0123, s0);\
	sad += COMPUTE_SAD(r1.s0123, s1);\
	sad += COMPUTE_SAD(r2.s0123, s2);\
	sad += COMPUTE_SAD(r3.s0123, s3);\
\
	if(sad<min_sad) \
	{\
		mv.xy = mvstart+idx;\
		mv.z = sad;\
		min_sad = sad;\
	}\
\
	r0.s01234567 = r0.s12345670;\
	r1.s01234567 = r1.s12345670;\
	r2.s01234567 = r2.s12345670;\
	r3.s01234567 = r3.s12345670;\
	(ix)++;\
}

#define SEARCH_4x4BLK_IN4x8(idx)\
{\
	(idx).x=0;\
	CHECK_4x4BLK_SAD((idx).x);\
	CHECK_4x4BLK_SAD((idx).x);\
	CHECK_4x4BLK_SAD((idx).x);\
	CHECK_4x4BLK_SAD((idx).x);\
\
	r0 = r1.s45670123;\
	r1 = r2.s45670123;\
	r2 = r3.s45670123;\
\
	refpos.y += 1;\
	r3.s0123 = convert_int4(read_imageui(pRef, sampler, refpos+offset.wz));\
	r3.s4567 = convert_int4(read_imageui(pRef, sampler, refpos+offset.xz));\
\
	r3.s0123 = CHECK_BORDER(bBorder.x, bBorder.y, r3.s0123);\
	r3.s4567 = CHECK_BORDER(bBorder.z, bBorder.w, r3.s4567);\
	(idx).y++;\
}

/*
	Function: search 4x8 pixels per thread
	Params	:
		iRect: (x,y):	the size of frame
			   (z,w):	search_range, should be multiple of 8
	performance:
		[2010/11/19, cml] on HD5600, 0.30ms for 720x480, 2.0ms for 1920x1088
*/
__kernel void KN_4x4FullSearchNxM(__read_only image2d_t pSrc, __read_only image2d_t pRef,  __write_only image2d_t pMV,
									__local int4 *pLocalMv, int4 iRect)
{
	__const int4 offset = {1, 2, 3, 0};
	__const int2 search_range = iRect.zw>>1;
	__const int2 blkThreads = iRect.zw>>offset.yz;	//threads to complete ME of a 4x4 block

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 gpos = {get_group_id(0), get_group_id(1)};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int2 bdim = {get_num_groups(0),get_num_groups(1)};
	int4 blkpos = {get_global_id(0), get_global_id(1), 0, 0};	//(x,y): pos in 4x4block unit
	int4 stride = {get_global_size(0), get_local_size(0), 0, 0};
 	int4 blkid;
 	blkid.xy = lpos/blkThreads;			//which 4x4 block is processed
 	blkid.zw = lpos%blkThreads;			//which thread in a 4x4 block

	stride.zw = stride.xy/blkThreads;					//global and local stride in 4x4block unit
	blkpos.zw = (blkpos.xy/blkThreads)<<offset.wy;		//pos in pixel unit


	__const int4 s0 = convert_int4(read_imageui(pSrc, sampler, blkpos.zw));
	__const int4 s1 = convert_int4(read_imageui(pSrc, sampler, blkpos.zw+offset.wx));
	__const int4 s2 = convert_int4(read_imageui(pSrc, sampler, blkpos.zw+offset.wy));
	__const int4 s3 = convert_int4(read_imageui(pSrc, sampler, blkpos.zw+offset.wz));

// 	int ldsoffset = (blkid.y*blkThreads.x*blkThreads.y + blkid.w*blkThreads.x + blkid.z)*stride.w + blkid.x;
	int ldsoffset = lpos.y * stride.y + lpos.x;
	__local int4 *pCurrMv = pLocalMv + ldsoffset;

	int2 mvstart = -search_range + (blkid.zw<<offset.yz);		//the start point of me in this thread

	int2 refpos = blkpos.zw + (mvstart>>offset.yw);
	int4 mv = {0, 0, -1, -1};
	uint min_sad = 0xFFFFFFFF;
	int4 bBorder;
	int8 r0, r1, r2, r3;

	r0.s0123 = convert_int4(read_imageui(pRef, sampler, refpos));
	r0.s4567 = convert_int4(read_imageui(pRef, sampler, refpos+offset.xw));
	r1.s0123 = convert_int4(read_imageui(pRef, sampler, refpos+offset.wx));
	r1.s4567 = convert_int4(read_imageui(pRef, sampler, refpos+offset.xx));
	r2.s0123 = convert_int4(read_imageui(pRef, sampler, refpos+offset.wy));
	r2.s4567 = convert_int4(read_imageui(pRef, sampler, refpos+offset.xy));
	r3.s0123 = convert_int4(read_imageui(pRef, sampler, refpos+offset.wz));
	r3.s4567 = convert_int4(read_imageui(pRef, sampler, refpos+offset.xz));

	bBorder.x = refpos.x < 0;
	bBorder.y = refpos.x > iRect.x-1;
	bBorder.z = refpos.x+1 < 0;
	bBorder.w = refpos.x+1 > iRect.x-1;

	r0.s0123 = CHECK_BORDER(bBorder.x, bBorder.y, r0.s0123);	r0.s4567 = CHECK_BORDER(bBorder.z, bBorder.w, r0.s4567);
	r1.s0123 = CHECK_BORDER(bBorder.x, bBorder.y, r1.s0123);	r1.s4567 = CHECK_BORDER(bBorder.z, bBorder.w, r1.s4567);
	r2.s0123 = CHECK_BORDER(bBorder.x, bBorder.y, r2.s0123);	r2.s4567 = CHECK_BORDER(bBorder.z, bBorder.w, r2.s4567);
	r3.s0123 = CHECK_BORDER(bBorder.x, bBorder.y, r3.s0123);	r3.s4567 = CHECK_BORDER(bBorder.z, bBorder.w, r3.s4567);

// 	int bPrint = blkpos.w == 54*4 && blkpos.z == 0;

	int2 idx = {0, 0};
	SEARCH_4x4BLK_IN4x8(idx);
	SEARCH_4x4BLK_IN4x8(idx);
	SEARCH_4x4BLK_IN4x8(idx);
	SEARCH_4x4BLK_IN4x8(idx);
	SEARCH_4x4BLK_IN4x8(idx);
	SEARCH_4x4BLK_IN4x8(idx);
	SEARCH_4x4BLK_IN4x8(idx);
	SEARCH_4x4BLK_IN4x8(idx);


// for debug
// 	for(idx.y=0; idx.y<8; idx.y++)
// 	{
// 		uint sad=0;
// 		for(idx.x= 0; idx.x<4; idx.x++)
// 		{
// 			sad  = COMPUTE_SAD(r0.s0123, s0);
// 			sad += COMPUTE_SAD(r1.s0123, s1);
// 			sad += COMPUTE_SAD(r2.s0123, s2);
// 			sad += COMPUTE_SAD(r3.s0123, s3);
//
// 			if(sad<min_sad) {mv.xy = mvstart+idx; mv.z = sad; min_sad = sad;}
//
// #if 0
// 			if(bPrint && mvstart.x+idx.x==4 && mvstart.y+idx.y==7)
// 			{
// 				printf("(%d, %d), sad %d, min_sad %d.\n", mvstart.x+idx.x, mvstart.y+idx.y, sad, min_sad);
// 				printf("src %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d.\n",
// 						s0.x, s0.y, s0.z, s0.w, s1.x, s1.y, s1.z, s1.w, s2.x, s2.y, s2.z, s2.w, s3.x, s3.y, s3.z, s3.w);
// 				printf("ref %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d.\n\n",
// 						r00.x, r00.y, r00.z, r00.w, r10.x, r10.y, r10.z, r10.w, r20.x, r20.y, r20.z, r20.w, r30.x, r30.y, r30.z, r30.w);
// 			}
// #endif
//
// 			r0.s01234567 = r0.s12345670;
// 			r1.s01234567 = r1.s12345670;
// 			r2.s01234567 = r2.s12345670;
// 			r3.s01234567 = r3.s12345670;
//
// 		}
//
// 		r0 = r1.s45670123;
// 		r1 = r2.s45670123;
// 		r2 = r3.s45670123;
//
// 		refpos.y += 1;
// 		r3.s0123 = (int4)(read_imageui(pRef, sampler, refpos+offset.wz));
// 		r3.s4567 = (int4)(read_imageui(pRef, sampler, refpos+offset.xz));
//
// 		r3.s0123 = CHECK_BORDER(bBorder.x, bBorder.y, r3.s0123);
// 		r3.s4567 = CHECK_BORDER(bBorder.z, bBorder.w, r3.s4567);
//
// 	}

	pCurrMv[0] = mv;

	barrier(CLK_LOCAL_MEM_FENCE);

#if 0
	if(bPrint)
	{
		printf("pos (%d, %d), mv (%d, %d), sad %d.\n", blkpos.z, blkpos.w, mv.x, mv.y, mv.z);
	}
#endif

	if(blkid.z==0 && blkid.w==0)
	{
		mv = pCurrMv[0*stride.y+0];	//start with (0,0) point

 		for(int i=0; i<blkThreads.x*blkThreads.y; i++)
		{
			int j = i%blkThreads.x;
			int k = i/blkThreads.x;
			int4 mv1 = pCurrMv[k*stride.y+j];
			if((uint)(mv1.z) < (uint)(mv.z))
			{
				mv = mv1;
			}
		}

		blkpos.xy = blkpos.xy/blkThreads;
		mv.xy = mv.xy<<2;
		write_imagei(pMV, blkpos.xy, mv);
	}
}

/*
	Function: get referenc mv for 16x16 motion search
	Params	:
		iRect: (x,y):	the size of frame
			   (z,w):	search_range, should be multiple of 8
	performance:
		[2010/11/19, cml] on HD5600, 0.30ms for 720x480, 2.0ms for 1920x1088
*/
__kernel void KN_Get4x4RefMv(__read_only image2d_t pSrc, __write_only image2d_t pMV, int4 iRect)
{
	__const int4 offset = {0, 1, -1, 0};
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 gpos = {get_global_id(0), get_global_id(1)};
	int4 mvsum = 0;
	int4 mv0, mv1, mv2;
	mv0 = read_imagei(pSrc, sampler, gpos+offset.zz);
	mv1 = read_imagei(pSrc, sampler, gpos+offset.xz);
	mv2 = read_imagei(pSrc, sampler, gpos+offset.yz);
	mvsum += mv0 + mv1 + mv2;
	mv0 = read_imagei(pSrc, sampler, gpos+offset.zx);
	mv1 = read_imagei(pSrc, sampler, gpos+offset.xx);
	mv2 = read_imagei(pSrc, sampler, gpos+offset.yx);
	mvsum += mv0 + mv1 + mv2;
	mv0 = read_imagei(pSrc, sampler, gpos+offset.zy);
	mv1 = read_imagei(pSrc, sampler, gpos+offset.xy);
	mv2 = read_imagei(pSrc, sampler, gpos+offset.yy);
	mvsum += mv0 + mv1 + mv2;
	mvsum = (mvsum + 4)/9;
	write_imagei(pMV, gpos, mvsum);

}

//read 16 pixel from a position which might not be multiple of 4
__attribute__((always_inline)) int16 _Read16PixelsFromPosAlign4(__read_only image2d_t pSrc, sampler_t sampler, int2 pos)
{
	int4 offset = {1, 2, 3, 0};
	int16 s0;

	s0.s0123 = convert_int4(read_imageui(pSrc, sampler, pos.xy));
	s0.s4567 = convert_int4(read_imageui(pSrc, sampler, pos.xy+offset.xw));
	s0.s89ab = convert_int4(read_imageui(pSrc, sampler, pos.xy+offset.yw));
	s0.scdef = convert_int4(read_imageui(pSrc, sampler, pos.xy+offset.zw));

	return s0;
}

__attribute__((always_inline)) uint _ComputeSAD16(int16 src, int16 ref)
{
	uint sad;
	uint8 s0;
	uint16 diff = abs(src-ref);
	s0 = diff.hi + diff.lo;
	s0.lo = s0.hi + s0.lo;
	sad = s0.s0 + s0.s1 + s0.s2 + s0.s3;
	return sad;
}

__attribute__((always_inline)) int4 _CheckFourMVs(uint4 uSad, uint4 bAvail, int4 startmv, int4 checkmvs[4])
{
	uint4 uSad1 = (uSad&bAvail) + (~bAvail&INT_MAX);

	checkmvs[0].z = uSad1.x;
	checkmvs[1].z = uSad1.y;
	checkmvs[2].z = uSad1.z;
	checkmvs[3].z = uSad1.w;

	startmv.xyzw = checkmvs[0].z < startmv.z ? checkmvs[0] : startmv;
	startmv.xyzw = checkmvs[1].z < startmv.z ? checkmvs[1] : startmv;
	startmv.xyzw = checkmvs[2].z < startmv.z ? checkmvs[2] : startmv;
	startmv.xyzw = checkmvs[3].z < startmv.z ? checkmvs[3] : startmv;
	return startmv;
}

__attribute__((always_inline)) uint4 _CheckPixelPos4(int4 RefPos[4], int4 Range)
{
	int4 iFlag1, iFlag2;
	int4 pos[4];

	pos[0].xy = (RefPos[0].xy>>4)<<4;
	pos[1].xy = (RefPos[1].xy>>4)<<4;
	pos[2].xy = (RefPos[2].xy>>4)<<4;
	pos[3].xy = (RefPos[3].xy>>4)<<4;

	iFlag1.xy = (pos[0].xy>=Range.xy) & (pos[0].xy<=Range.zw);
	iFlag1.zw = (pos[1].xy>=Range.xy) & (pos[1].xy<=Range.zw);
	iFlag2.xy = (pos[2].xy>=Range.xy) & (pos[2].xy<=Range.zw);
	iFlag2.zw = (pos[3].xy>=Range.xy) & (pos[3].xy<=Range.zw);
	iFlag1.xy = iFlag1.xz & iFlag1.yw;
	iFlag1.zw = iFlag2.xz & iFlag2.yw;

	return convert_uint4(iFlag1);
}

/*
	refpos.xy:	pixel_pos
		   zw:  global pos
*/
__attribute__((always_inline)) uint4 _ComputeSad0(__read_only image2d_t pRef, sampler_t sampler, int4 src, int4 refpos[4])
{
	int4 offset = {1, 2, 3, 0};
	int4 c0, c1, c2, c3;
	int8 r0, r1, r2, r3;

	refpos[0].xy = refpos[0].xy & offset.zw;
	refpos[1].xy = refpos[1].xy & offset.zw;
	refpos[2].xy = refpos[2].xy & offset.zw;
	refpos[3].xy = refpos[3].xy & offset.zw;

	c0 = (refpos[0].xxxx == offset.wxyz);
	c1 = (refpos[1].xxxx == offset.wxyz);
	c2 = (refpos[2].xxxx == offset.wxyz);
	c3 = (refpos[3].xxxx == offset.wxyz);

	r0.lo = convert_int4(read_imageui(pRef, sampler, refpos[0].zw));
	r0.hi = convert_int4(read_imageui(pRef, sampler, refpos[0].zw + offset.xw));
	r1.lo = convert_int4(read_imageui(pRef, sampler, refpos[1].zw));
	r1.hi = convert_int4(read_imageui(pRef, sampler, refpos[1].zw + offset.xw));
	r2.lo = convert_int4(read_imageui(pRef, sampler, refpos[2].zw));
	r2.hi = convert_int4(read_imageui(pRef, sampler, refpos[2].zw + offset.xw));
	r3.lo = convert_int4(read_imageui(pRef, sampler, refpos[3].zw));
	r3.hi = convert_int4(read_imageui(pRef, sampler, refpos[3].zw + offset.xw));

	r0.lo = (r0.lo&c0.xxxx) + (r0.s1234&c0.yyyy) + (r0.s2345&c0.zzzz) + (r0.s3456&c0.wwww);
	r1.lo = (r1.lo&c1.xxxx) + (r1.s1234&c1.yyyy) + (r1.s2345&c1.zzzz) + (r1.s3456&c1.wwww);
	r2.lo = (r2.lo&c2.xxxx) + (r2.s1234&c2.yyyy) + (r2.s2345&c2.zzzz) + (r2.s3456&c2.wwww);
	r3.lo = (r3.lo&c3.xxxx) + (r3.s1234&c3.yyyy) + (r3.s2345&c3.zzzz) + (r3.s3456&c3.wwww);

	c0 = convert_int4(abs(r0.lo-src));
	c1 = convert_int4(abs(r1.lo-src));
	c2 = convert_int4(abs(r2.lo-src));
	c3 = convert_int4(abs(r3.lo-src));
	c0.xy = c0.xy + c0.zw;
	c1.xy = c1.xy + c1.zw;
	c2.xy = c2.xy + c2.zw;
	c3.xy = c3.xy + c3.zw;
	c0.x = c0.x + c0.y;
	c0.y = c1.x + c1.y;
	c0.z = c2.x + c2.y;
	c0.w = c3.x + c3.y;
	return convert_uint4(c0);
}

/*
	Function: compute SAD of 4 pixels per thread
	WorkItem:
	Params	:
		pSrc: uint8, current frame
		pRef: uint8, reference frame
		pRefMv: int32, reference mv, [mvx, mvy, sad]
		pMv: final mv
		iRect: resolutiono of current frame

	performance:
		[2010/11/26, cml] on HD5500, 1.7ms for 720x480(knock_the_door), 14-17ms for 1920x1088, depends on test sequence
*/
__kernel void KN_16x16FastIntegerPixelSearch_Atomic(__read_only image2d_t pSrc, __read_only image2d_t pRef,
											__read_only image2d_t p4x4Mv, __read_only image2d_t pPreMv, __read_only image2d_t pSad,
											__write_only image2d_t pMv, int4 iRect)
{
	int2 search_range = iRect.zw>>1;
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int4 offset = {1, 2, 3, 0};
	int4 lpos = {get_local_id(0), get_local_id(1), get_group_id(0), get_group_id(1)};
	int4 gpos = {get_global_id(0), get_global_id(1), get_global_id(0)>>2, get_global_id(1)/16};
	int4 stride = {get_global_size(0), get_num_groups(0), get_local_size(0), get_local_size(1)};	//y: lds stride
	int bMbStart = ((lpos.x&3)==0) && ((lpos.y&15)==0);
	int2 pixel_pos = gpos.xy<<offset.yw;
	int2 sStride = {(stride.z>>2)<<2, stride.z>>2};

	__local int ShareMemory[32];

	__local int *plSumSad = ShareMemory + ((lpos.x>>2)<<2);
	__local int4 *plSad4 = (__local int4*)plSumSad;

	int4 mvtmp[5], refpos[4], refpos2;
	uint4 Intersad, mbXY=0, bPred=0, bPred2=0;
	int4 s0;
	uint4 uSad1, uSad2;
	int4 ImageRange = 0;
	uint MaxXY = 0;

	__local int *pReset = ShareMemory + ((lpos.y*stride.z + lpos.x)<<1);
	pReset[0] = pReset[1] = 0;
	barrier(CLK_LOCAL_MEM_FENCE);
	{

		Intersad = read_imageui(pSad, sampler, gpos.zw);
		mvtmp[3] = read_imagei(p4x4Mv, sampler, gpos.zw);
		mvtmp[0] = read_imagei(p4x4Mv, sampler, gpos.zw-offset.xw);
		mvtmp[1] = read_imagei(p4x4Mv, sampler, gpos.zw-offset.wx);
		mvtmp[2] = read_imagei(p4x4Mv, sampler, gpos.zw-offset.wx+offset.xw);
		mvtmp[4] = read_imagei(pPreMv, sampler, gpos.zw);
		s0 = convert_int4(read_imageui(pSrc, sampler, gpos.xy));

		refpos[0].xy = pixel_pos + mvtmp[0].xy;
		refpos[1].xy = pixel_pos + mvtmp[1].xy;
		refpos[2].xy = pixel_pos + mvtmp[2].xy;
		refpos[3].xy = pixel_pos + mvtmp[3].xy;
		refpos2.xy	 = pixel_pos + mvtmp[4].xy;

		refpos[0].zw = refpos[0].xy>>offset.yw;
		refpos[1].zw = refpos[1].xy>>offset.yw;
		refpos[2].zw = refpos[2].xy>>offset.yw;
		refpos[3].zw = refpos[3].xy>>offset.yw;
		refpos2.zw   = refpos2.xy>>offset.yw;

		ImageRange.zw = iRect.xy - 16;
		bPred = _CheckPixelPos4(refpos, ImageRange);
		bPred2.xy = convert_uint2((refpos2.xy>=0) & (refpos2.xy<=ImageRange.zw));
		bPred2.x = (bPred2.x&bPred2.y);
		bPred2.y = !(mvtmp[4].w&2);
		bPred2.x = (-bPred2.y) & bPred2.x;

		uSad1 = _ComputeSad0(pRef, sampler, s0, refpos);

		mbXY.x = abs(mvtmp[0].x) + abs(mvtmp[0].y);
		mbXY.y = abs(mvtmp[1].x) + abs(mvtmp[1].y);
		mbXY.z = abs(mvtmp[2].x) + abs(mvtmp[2].y);
		mbXY.w = abs(mvtmp[3].x) + abs(mvtmp[3].y);

		mbXY = MUL24(mbXY, (-bPred));
		mbXY.xy = max(mbXY.xy, mbXY.zw);
		MaxXY = max(mbXY.x, mbXY.y);

		mbXY.x = MUL24(abs(mvtmp[4].x) + abs(mvtmp[4].y), -bPred2.x);
		MaxXY = max(MaxXY, mbXY.x);
		MaxXY = MaxXY<=0 && Intersad.x<0x400;

		{
			int8 r1;
			int4 c;
			r1.lo = convert_int4(read_imageui(pRef, sampler, refpos2.zw));
			r1.hi = convert_int4(read_imageui(pRef, sampler, refpos2.zw+offset.xw));
			refpos2.x = refpos2.x&3;
			c.xyzw = refpos2.xxxx == offset.wxyz;
			r1.lo = (r1.s0123&c.xxxx) + (r1.s1234&c.yyyy) + (r1.s2345&c.zzzz) + (r1.s3456&c.wwww);
			r1.lo = (convert_int4)(abs(s0-r1.lo));
			r1.s01 = r1.s01 + r1.s23;
			uSad2.x = (uint)(r1.s0 + r1.s1);
		}

		atomic_add(plSumSad,		(int)(uSad1.x));
		atomic_add(plSumSad+1,		(int)(uSad1.y));
		atomic_add(plSumSad+2,		(int)(uSad1.z));
		atomic_add(plSumSad+3,		(int)(uSad1.w));
		atomic_add(plSumSad+sStride.x,(int)(uSad2.x));
	}

	barrier(CLK_LOCAL_MEM_FENCE);
	{
		if(bMbStart)
		{
			int4 mv = {0, 0, Intersad.x, 0};		//pixel(0,0)
			uSad1 = (convert_uint4)(plSad4[0]);
			uSad2 = (convert_uint4)(plSad4[sStride.y]);

			mv = _CheckFourMVs(uSad1, bPred, mv, mvtmp);

 			uSad2 = (uSad2&bPred2) + (~bPred2&INT_MAX);
 			mvtmp[4].z = uSad2.x;
 			mv = mvtmp[4].z < mv.z ? mvtmp[4] : mv;

			plSad4[0] = mv;
			plSad4[sStride.y] = 0;
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 mvstart = plSad4[0];
	int4 mvbest = mvstart;
	int4 mvoffset = {1, -1, 0, 0};
	int loop = 0;

	int4 SearchRange;
	SearchRange.xy = pixel_pos + mvstart.xy - (iRect.zw>>1);
	SearchRange.zw = pixel_pos + mvstart.xy + (iRect.zw>>1);

#if 1
	do
	{
		{
 			mvtmp[0].xy = mvstart.xy+mvoffset.yz;
 			mvtmp[1].xy = mvstart.xy+mvoffset.xz;
 			mvtmp[2].xy = mvstart.xy+mvoffset.zy;
 			mvtmp[3].xy = mvstart.xy+mvoffset.zx;

			refpos[0].xy = pixel_pos + mvtmp[0].xy;
			refpos[1].xy = pixel_pos + mvtmp[1].xy;
			refpos[2].xy = pixel_pos + mvtmp[2].xy;
			refpos[3].xy = pixel_pos + mvtmp[3].xy;

			refpos[0].zw = refpos[0].xy>>offset.yw;
			refpos[1].zw = refpos[1].xy>>offset.yw;
			refpos[2].zw = refpos[2].xy>>offset.yw;
			refpos[3].zw = refpos[3].xy>>offset.yw;
			bPred = _CheckPixelPos4(refpos, ImageRange);
			bPred &= _CheckPixelPos4(refpos, SearchRange);

			uSad1 = _ComputeSad0(pRef, sampler, s0, refpos);

			atomic_add(plSumSad+sStride.x,	(int)(uSad1.x));
			atomic_add(plSumSad+sStride.x+1,  (int)(uSad1.y));
			atomic_add(plSumSad+sStride.x+2,  (int)(uSad1.z));
			atomic_add(plSumSad+sStride.x+3,  (int)(uSad1.w));
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		if(bMbStart)
		{
			uSad1 = (convert_uint4)(plSad4[sStride.y]);

			mvbest = _CheckFourMVs(uSad1, bPred, mvbest, mvtmp);

			plSad4[0] = mvbest;
			plSad4[sStride.y] = 0;
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		mvbest = plSad4[0];

		if(mvbest.z == mvstart.z || mvbest.z<0x400)
		{
			break;
		}
		else
		{
			mvstart = mvbest;
		}
		loop ++;
	}while(1);

	barrier(CLK_LOCAL_MEM_FENCE);
#endif
	if(bMbStart)
	{
		int4 zeromv = {0, 0, Intersad.x, 0};		//pixel(0,0)
		mvbest = (int4)(MaxXY) * zeromv + (1-(int4)(MaxXY)) * mvbest;
		int a = (uint)(mvbest.z)>0x800;
		mvbest.w = (loop<<8)+(a*2+1);
		write_imagei(pMv, gpos.zw, mvbest);
	}
}


#define READ_8PIXELS_FROM_IMAGE(p0, pSrc, sampler, pos, pos2)\
{\
	p0.lo = convert_int4(read_imageui(pSrc, sampler, pos));\
	p0.hi = convert_int4(read_imageui(pSrc, sampler, pos2));\
}

/*
	Function: compute SAD of 16 pixels per thread
	Params	:
		pSrc: uint8, current frame
		pRef: uint8, reference frame
		pRefMv: int32, reference mv, [mvx, mvy, sad]
		pMv: final mv
		iRect: (x,y) resolutiono of current frame
			   z, nParam

	performance:
		[2010/11/16, cml] on HD5500, 2.0ms for 1920x1088
*/
__kernel void KN_Denoise_AVG(__read_only image2d_t pSrc, __write_only image2d_t pDst, int4 iRect)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	__const int4 offset = {1, 2, 3, 0};
	__const int4 offset2= {1, 2, 3, -1};
	int2 gpos = {get_global_id(0), get_global_id(1)};

	int8 p0, p1, p2, p3, p4, p5;
	int4 q1, q2, q3;
	int4 param = iRect.zzzz * 12;
	int4 avg = 0;

	//[2010/11/26, cml]takes about 0.62 to read data on HD5500 for 1920x1080 sequences
	READ_8PIXELS_FROM_IMAGE(p0, pSrc, sampler, gpos-offset.xy, gpos-offset.wy);
	READ_8PIXELS_FROM_IMAGE(p1, pSrc, sampler, gpos-offset.xx, gpos-offset.wx);
	READ_8PIXELS_FROM_IMAGE(p2, pSrc, sampler, gpos-offset.xw, gpos);
	READ_8PIXELS_FROM_IMAGE(p3, pSrc, sampler, gpos+offset2.wx, gpos+offset.wx);
	READ_8PIXELS_FROM_IMAGE(p4, pSrc, sampler, gpos+offset2.wy, gpos+offset.wy);
	READ_8PIXELS_FROM_IMAGE(p5, pSrc, sampler, gpos+offset2.wz, gpos+offset.wz);

	q1 = convert_int4(read_imageui(pSrc, sampler, gpos-offset2.wx));
	q2 = convert_int4(read_imageui(pSrc, sampler, gpos+offset.xw));
	q3 = convert_int4(read_imageui(pSrc, sampler, gpos+offset.xx));


	int4 t1, t2;
	int8 d8 = p2 - p5;
	int4 sad = 0;
	uint4 tmp;

	tmp = abs(d8.s3456) + abs(d8.s4567);
	tmp.x += abs(p1.s4 - p1.s7);		//tmp.yzw += abs(p1.s567 - q1.xyz);
	tmp.y += abs(p1.s5 - q1.x);
	tmp.z += abs(p1.s6 - q1.y);
	tmp.w += abs(p1.s7 - q1.z);
	tmp.x += abs(p2.s4 - p2.s7);		//tmp.yzw += abs(p2.s567 - q2.xyz);
	tmp.y += abs(p2.s5 - q2.x);
	tmp.z += abs(p2.s6 - q2.y);
	tmp.w += abs(p2.s7 - q2.z);

	sad = convert_int4(CLAMP_BYTE(tmp*3));


	t1 = AVG(p0.hi, p4.hi);
	t2.xy = AVG(p2.s23, p2.s67);	t2.zw = AVG(p2.s45, q2.xy);
	t1 = AVG(t1, t2);
	t2 = AVG(p1.hi, p3.hi);
	avg = CLAMP_BYTE(AVG(t1, t2)-1);


	d8.s0 = AVG(p1.s3, p1.s5);
	d8.s1 = AVG(p1.s4, p1.s6);
	d8.s2 = AVG(p1.s5, p1.s7);
	d8.s3 = AVG(p1.s6, q1.x);
	d8.s4 = AVG(p3.s3, p3.s5);
	d8.s5 = AVG(p3.s4, p3.s6);
	d8.s6 = AVG(p3.s5, p3.s7);
	d8.s7 = AVG(p3.s6, q3.x);
	t1.x  = AVG(p2.s3, p2.s5);
	t1.y  = AVG(p2.s4, p2.s6);
	t1.z  = AVG(p2.s5, p2.s7);
	t1.w  = AVG(p2.s6, q2.x);
	t2 = AVG(d8.lo, d8.hi);
	t1 = CLAMP_BYTE(AVG(t2, t1)-1);
	avg = AVG(avg, t1);

	//new pixel: (*(pCur+i)*nSAD+nAvg*(256-nSAD)+128)>>8;
	avg = CLAMP_BYTE((p2.hi * sad + avg * (256 - sad) + 128)>>8);

	t1 = -(param>sad);
 	avg = t1 * avg + (1-t1)*p2.hi;

 	int4 bTopOrBottom = gpos.y<2 || gpos.y>iRect.y-4;
 	avg = bTopOrBottom * p2.hi + (1-bTopOrBottom) * avg;

	//avg = p0.lo + p0.hi + p1.lo + p1.hi + p2.lo + p2.hi + p3. lo + p3.hi + p4.lo + p4.hi + p5.lo + p5.hi + q1 + q2 + q3;
	write_imageui(pDst, gpos, convert_uint4(avg));

}

#define COMPUTE_INTERINTRA_SAD()\
{\
	mbpos.y++; \
	mbpos2.y++; \
	s0 = _Read16PixelsFromPosAlign4(pSrc, sampler, mbpos);\
	r0 = _Read16PixelsFromPosAlign4(pRef, sampler, mbpos);\
	s1 = convert_int4(read_imageui(pSrc, sampler, mbpos2));\
	i0 = s0.s123456789abcdeff;		i0.sf = s1.x;\
	InterSad += _ComputeSAD16(s0, r0);\
	IntraSad += _ComputeSAD16(s0, i0);\
	IntraSad += _ComputeSAD16(s0, i1);\
	i1 = s0;\
}

__kernel void KN_MBSAD(__read_only image2d_t pSrc,__read_only image2d_t pRef, __write_only image2d_t pSad, __local int2 *pLds, int4 iRect)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 gpos = {get_global_id(0), get_global_id(1)/16};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int2 mbpos = {get_global_id(0)*4, get_global_id(1)};
	int2 mbpos2 = {mbpos.x+4, mbpos.y};

	int stride = get_local_size(0);
	__local int2 *pLdsSad = pLds + lpos.y*stride + lpos.x;

	int4 s1;
	int16 s0, r0, i0, i1;
	uint InterSad=0, IntraSad=0;

	s0 = _Read16PixelsFromPosAlign4(pSrc, sampler, mbpos);
	r0 = _Read16PixelsFromPosAlign4(pRef, sampler, mbpos);
	mbpos.y += 1;
	i1 = _Read16PixelsFromPosAlign4(pSrc, sampler, mbpos);
	s1 = convert_int4(read_imageui(pSrc, sampler, mbpos2));
	i0 = s0.s123456789abcdeff;		i0.sf = s1.x;

	InterSad += _ComputeSAD16(s0, r0);
	IntraSad += _ComputeSAD16(s0, i0);
	IntraSad += _ComputeSAD16(s0, i1);
	pLdsSad[0].x = InterSad;
	pLdsSad[0].y = IntraSad;

	barrier(CLK_LOCAL_MEM_FENCE);

	if(lpos.y == 0)
	{
		int4 sad = 0;
		sad.xy += pLdsSad[0];
		sad.xy += pLdsSad[stride*1];
		sad.xy += pLdsSad[stride*2];
		sad.xy += pLdsSad[stride*3];
		sad.xy += pLdsSad[stride*4];
		sad.xy += pLdsSad[stride*5];
		sad.xy += pLdsSad[stride*6];
		sad.xy += pLdsSad[stride*7];
		sad.xy += pLdsSad[stride*8];
		sad.xy += pLdsSad[stride*9];
		sad.xy += pLdsSad[stride*10];
		sad.xy += pLdsSad[stride*11];
		sad.xy += pLdsSad[stride*12];
		sad.xy += pLdsSad[stride*13];
		sad.xy += pLdsSad[stride*14];
		sad.x += pLdsSad[stride*15].x;

		write_imageui(pSad, gpos, convert_uint4(sad));
	}
}

__attribute__((always_inline)) int4 _Denoise_Y_1(int4 src, int4 ref, int param)
{
// 	if (abs(nSrc-nRef) > 0x20)
// 		nTemp = nSrc;
// 	else if (abs(nSrc-nRef) <= 0x20 && abs(nSrc-nRef) > 0x8)
// 		nTemp = (nSrc*3+nRef+2)/4;
// 	else
// 		nTemp = (nSrc+nRef+1)/2;

	int4 diff = convert_int4(abs(src-ref));
	int4 dst = src;
	int4 a = -(diff > 0x20);
	int4 b = -(diff <=0x20 && diff > 0x8);
	int4 c = -(diff <= 8);

	dst = a * src + b * ((src*3+ref+2)>>2) + c * AVG(src, ref);
	dst = clamp(dst, src-param, src+param);
	return dst;
}

__attribute__((always_inline)) int4 _Denoise_Y_2(int4 src, int4 ref, int param)
{
// 	if (abs(nSrc-nRef) > 0x20)
// 		nTemp = nSrc;
// 	else if ((abs(nSrc-nRef) <= 0x20 && abs(nSrc-nRef) > 0x8) || (abs(nSrc-nRef) <= 0x8 && nSrc < 0x18))
// 		nTemp = (nSrc+nRef)/2;
// 	else
// 		nTemp = (nSrc+nRef*3+2)/4;

	int4 diff = convert_int4(abs(src-ref));
	int4 dst = src;
	int4 a = -(diff > 0x20);
	int4 b = -(diff <=0x20 && diff > 0x8 || diff<=0x8 && src<0x18);
	int4 c = -(diff <= 0x8 && src >= 0x18);

	dst = a * src + b * AVG(src, ref) + c * ((src+ref*3+2)>>2);
	dst = clamp(dst, src-param, src+param);
	return dst;
}

__attribute__((always_inline)) int4 _Denoise_Y_3(int4 src, int4 ref, int param)
{
// 	if (abs(nSrc-nRef) > 0x20)
// 		nTemp = nSrc;
// 	else if ((abs(nSrc-nRef) <= 0x20 && abs(nSrc-nRef) > 0x10) || (abs(nSrc-nRef) <= 0x10 && nSrc < 0x18))
// 		nTemp = (nSrc+nRef+1)/2;
// 	else
// 		nTemp = (nSrc+nRef*7+4)/8;

	int4 diff = convert_int4(abs(src-ref));
	int4 dst = src;
	int4 a = -(diff > 0x20);
	int4 b = -(diff <=0x20 && diff > 0x10 || diff<=0x10 && src<0x18);
	int4 c = -(diff <=0x10 && src >= 0x18);

	dst = a * src + b * AVG(src, ref) + c * ((src+ref*7+4)>>3);
	dst = clamp(dst, src-param, src+param);
	return dst;
}


__attribute__((always_inline)) int4 _Denoise_UV_1(int4 src, int4 ref, int param)
{
// 	if (abs(nSrc-nRef) > 0x20)
// 		nTemp = nSrc;
// 	else if (abs(nSrc-nRef) <= 0x20 && abs(nSrc-nRef) > 0x8)
// 		nTemp = (nSrc*3+nRef+2)/4;
// 	else
// 		nTemp = (nSrc+nRef+1)/2;

	int4 diff = convert_int4(abs(src-ref));
	int4 dst = src;
	int4 a = -(diff > 0x20);
	int4 b = -(diff <=0x20 && diff > 0x8);
	int4 c = -(diff <= 0x8);

	dst = a * src + b * ((src*3+ref+2)>>2) + c * AVG(src, ref);
	dst = clamp(dst, src-param, src+param);
	return dst;
}
__attribute__((always_inline)) int4 _Denoise_UV_2(int4 src, int4 ref, int param)
{
// 	if (abs(nSrc-nRef) > 0x20)
// 		nTemp = nSrc;
// 	else if (abs(nSrc-nRef) <= 0x20 && abs(nSrc-nRef) > 0x8)
// 		nTemp = (nSrc+nRef+1)/2;
// 	else
// 		nTemp = (nSrc+nRef*3+2)/4;

	int4 diff = convert_int4(abs(src-ref));
	int4 dst = src;
	int4 a = -(diff > 0x20);
	int4 b = -(diff <=0x20 && diff > 0x8);
	int4 c = -(diff <= 0x8);

	dst = a * src + b * AVG(src, ref) + c * ((src+ref*3+2)>>2);
	dst = clamp(dst, src-param, src+param);
	return dst;
}

__attribute__((always_inline)) int4 _Denoise_UV_3(int4 src, int4 ref, int param)
{
// 	if (abs(nSrc-nRef) > 0x20)
// 		nTemp = nSrc;
// 	else if (abs(nSrc-nRef) <= 0x20 && abs(nSrc-nRef) > 0x10)
// 		nTemp = (nSrc+nRef*7+4)/8;
// 	else
// 		nTemp = (nSrc+nRef*15+8)/16;

	int4 diff = convert_int4(abs(src-ref));
	int4 dst = src;
	int4 a = -(diff > 0x20);
	int4 b = -(diff <=0x20 && diff > 0x10);
	int4 c = -(diff <= 0x10);

	dst = a * src + b * ((src+ref*7+4)>>3) + c * ((src+ref*15+8)>>4);
	dst = clamp(dst, src-param, src+param);
	return dst;
}

__attribute__((always_inline)) int4 _Denoise_UV_4(int4 src, int4 ref, int param)
{
// 	if (abs(nSrc-nRef) > 0x20)
// 		nTemp = nSrc;
// 	else if (abs(nSrc-nRef) <= 0x20 && abs(nSrc-nRef) > 0x8)
// 		nTemp = (nSrc+nRef*3+2)/4;
// 	else
// 		nTemp = (nSrc+nRef*7+4)/8;

	int4 diff = convert_int4(abs(src-ref));
	int4 dst = src;
	int4 a = -(diff > 0x20);
	int4 b = -(diff <=0x20 && diff > 0x8);
	int4 c = -(diff <= 0x8);

	dst = a * src + b * ((src+ref*3+2)>>2) + c * ((src+ref*7+4)>>3);
	dst = clamp(dst, src-param, src+param);
	return dst;
}

__attribute__((always_inline)) int4 _Read4PixelsFromAnyPos(__read_only image2d_t pSrc, sampler_t sampler, int2 pos)
{
	int4 offset = {0, 1, 2, 3};
	int4 pos4;
	int4 s0, s4;
	int8 s8;


	pos4.xy = pos>>offset.zx;	//pos in 4-pixel unit
	pos4.zw = pos&offset.ww;	//offset

	s8.lo = convert_int4(read_imageui(pSrc, sampler, pos4.xy));
	s8.hi = convert_int4(read_imageui(pSrc, sampler, pos4.xy+offset.yx));

	s4 = -(pos4.zzzz == offset);

	s0 = s8.s0123 * s4.xxxx + s8.s1234 * s4.yyyy + s8.s2345 * s4.zzzz + s8.s3456 * s4.wwww;

	return s0;
}

/*
	Description: process data according to mv and sad result
	Work Item:	 8x2 pixels
	Paremeters:
*/
__kernel void KN_Denoise_Main_YV12(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
							__read_only image2d_t pRefY, __read_only image2d_t pRefU, __read_only image2d_t pRefV,
							__write_only image2d_t pDstY, __write_only image2d_t pDstU, __write_only image2d_t pDstV,
							__read_only image2d_t pMv, __read_only image2d_t pSad,
							int4 iRect)
{
	__const int2 tmp = {4, 1};
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 posC = {get_global_id(0), get_global_id(1)};
	int4 posY = {posC.x*2, posC.y*2, posC.x*2+1, posC.y*2+1};
	int2 mbpos = {posY.x/4, posY.y/16};

	int4 sad = read_imagei(pSad, sampler, mbpos);
	int4 mv = read_imagei(pMv, sampler, mbpos);
	int4 sY0, sY1, sY2, sY3, sU, sV;
	int4 rY0, rY1, rY2, rY3, rU, rV;
	int4 dY1, dY2, dY3;
	int4 dU1, dU2, dU3, dU4;
	int4 dV1, dV2, dV3, dV4;
	int4 ddY1, ddY2, ddY3, ddY0, dU, dV;
	int4 m0, m1, m2, m3, m4, m5;
	int4 n0, n1, n2;
	int mbOffset = mv.x*mv.x + mv.y*mv.y;
	int mbXY = (int)(abs(mv.x) + abs(mv.y));
	int paramY = clamp(min(iRect.z, sad.y/64), 2, 255);
	int paramC = clamp(min(iRect.z*3/2, sad.y/64), 2, 255);

	n1.x = mbXY == 0;
	n1.y = mbXY <= 1;
	n1.z = mv.z < 0x180;
	n1.w = sad.x < 0x300;

	n2.x = mv.z<0x2a0;
	n2.y = !n2.x && mv.z<0x480;
	n2.z = mv.z>=0x480;
	n2.w = mv.z<0xc00;

	m0 = (int4)(mbOffset>=0x100);
	m3 = (int4)(n2.x && n1.x);

	n0.x = n2.x && !n1.x && (n1.y || n1.z || n1.w);
	n0.y = n2.y && (n1.y || n1.w);
	n0.z = n2.z && n2.w && n1.w;

	m2 = (int4)(n0.x || n0.y || n0.z);

	n0.x = n2.x && !n1.x && !n1.y && !n1.z && !n1.w;
	n0.y = n2.y && !n1.y && !n1.w;
	n0.z = n2.z && n2.w && !n1.w;

	m1 = (int4)(n0.x || !n0.x && n0.y || !n0.x && !n0.y && n0.z);

	sY0 = convert_int4(read_imageui(pSrcY, sampler, posY.xy));
	sY1 = convert_int4(read_imageui(pSrcY, sampler, posY.zy));
	sY2 = convert_int4(read_imageui(pSrcY, sampler, posY.xw));
	sY3 = convert_int4(read_imageui(pSrcY, sampler, posY.zw));
	sU = convert_int4(read_imageui(pSrcU, sampler, posC));
	sV = convert_int4(read_imageui(pSrcV, sampler, posC));

	{
		int4 a = (int4)(n1.w && (n2.x && !n1.y && !n1.z || n2.y && !n1.y || n2.z));
		int4 posY4 = posY * tmp.xyxy + (1-a)*mv.xyxy;
		int2 posC4 = posC.xy * tmp.xy + (1-a.xy)*mv.xy/2;
		rY0 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.xy);
		rY1 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.zy);
		rY2 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.xw);
		rY3 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.zw);
		rU = _Read4PixelsFromAnyPos(pRefU, sampler, posC4);
		rV = _Read4PixelsFromAnyPos(pRefV, sampler, posC4);
	}

	//Y
	{
		m4 = -(!m1 && !m2 && !m3);
		dY1 = _Denoise_Y_1(sY0, rY0, paramY);
		dY2 = _Denoise_Y_2(sY0, rY0, paramY);
		dY3 = _Denoise_Y_3(sY0, rY0, paramY);
		ddY0 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY0;
		ddY0 = m0 * sY0 + (1-m0) * ddY0;

		dY1 = _Denoise_Y_1(sY1, rY1, paramY);
		dY2 = _Denoise_Y_2(sY1, rY1, paramY);
		dY3 = _Denoise_Y_3(sY1, rY1, paramY);
		ddY1 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY1;
		ddY1 = m0 * sY1 + (1-m0) * ddY1;

		dY1 = _Denoise_Y_1(sY2, rY2, paramY);
		dY2 = _Denoise_Y_2(sY2, rY2, paramY);
		dY3 = _Denoise_Y_3(sY2, rY2, paramY);
		ddY2 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY2;
		ddY2 = m0 * sY2 + (1-m0) * ddY2;


		dY1 = _Denoise_Y_1(sY3, rY3, paramY);
		dY2 = _Denoise_Y_2(sY3, rY3, paramY);
		dY3 = _Denoise_Y_3(sY3, rY3, paramY);
		ddY3 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY3;
		ddY3 = m0 * sY3 + (1-m0) * ddY3;

	}
	//U,V
	{
		n0.x = n2.x && !n1.y && (n1.z || n1.w);
		n0.y = n2.y && !n1.y && n1.w;
		n0.z = n2.z && n1.w;
		m2 = (int4)(n0.x || n0.y || n0.z);

		n0.x = n2.x && !n1.x && n1.y;
		n0.y = n2.y && n1.y;
		m4 = (int4)(n0.x || n0.y);
		m5 = -(!m1 && !m2 && !m3 && !m4);

		dU1 = _Denoise_UV_1(sU, rU, paramC);
		dU2 = _Denoise_UV_2(sU, rU, paramC);
		dU3 = _Denoise_UV_3(sU, rU, paramC);
		dU4 = _Denoise_UV_4(sU, rU, paramC);
		dV1 = _Denoise_UV_1(sV, rV, paramC);
		dV2 = _Denoise_UV_2(sV, rV, paramC);
		dV3 = _Denoise_UV_3(sV, rV, paramC);
		dV4 = _Denoise_UV_4(sV, rV, paramC);
		dU = m1 * dU1 + m2 * dU2 + m3 * dU3 + m4 * dU4 + m5 * sU;
		dV = m1 * dV1 + m2 * dV2 + m3 * dV3 + m4 * dV4 + m5 * sV;
		dU = m0 * sU + (1-m0) * dU;
		dV = m0 * sV + (1-m0) * dV;
	}

	write_imageui(pDstY, posY.xy, convert_uint4(ddY0));
	write_imageui(pDstY, posY.zy, convert_uint4(ddY1));
	write_imageui(pDstY, posY.xw, convert_uint4(ddY2));
	write_imageui(pDstY, posY.zw, convert_uint4(ddY3));
	write_imageui(pDstU, posC, convert_uint4(dU));
	write_imageui(pDstV, posC, convert_uint4(dV));
}


/*
	Description: process data according to mv and sad result
	Work Item:	 8x2 pixels
	Paremeters:
*/

__kernel void KN_Denoise_PostProc_YV12(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
								  __read_only image2d_t pRefY, __read_only image2d_t pRefU, __read_only image2d_t pRefV,
								  __write_only image2d_t pDstY, __write_only image2d_t pDstU, __write_only image2d_t pDstV,
								  int4 iRect)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 posC = {get_global_id(0), get_global_id(1)};
	int4 posY = {posC.x*2, posC.y*2, posC.x*2+1, posC.y*2+1};

	int4 sY0, sY1, sY2, sY3, sU, sV;
	int4 rY0, rY1, rY2, rY3, rU, rV;
	int4 dY0, dY1, dY2, dY3, dU, dV;

	sY0 = convert_int4(read_imageui(pSrcY, sampler, posY.xy));
	sY1 = convert_int4(read_imageui(pSrcY, sampler, posY.zy));
	sY2 = convert_int4(read_imageui(pSrcY, sampler, posY.xw));
	sY3 = convert_int4(read_imageui(pSrcY, sampler, posY.zw));
	sU = convert_int4(read_imageui(pSrcU, sampler, posC));
	sV = convert_int4(read_imageui(pSrcV, sampler, posC));
	rY0 = convert_int4(read_imageui(pRefY, sampler, posY.xy));
	rY1 = convert_int4(read_imageui(pRefY, sampler, posY.zy));
	rY2 = convert_int4(read_imageui(pRefY, sampler, posY.xw));
	rY3 = convert_int4(read_imageui(pRefY, sampler, posY.zw));
	rU = convert_int4(read_imageui(pRefU, sampler, posC));
	rV = convert_int4(read_imageui(pRefV, sampler, posC));

	dY0 = (max((sY0<<8)+(rY0-sY0)*iRect.z, 0))>>8;
	dY1 = (max((sY1<<8)+(rY1-sY1)*iRect.z, 0))>>8;
	dY2 = (max((sY2<<8)+(rY2-sY2)*iRect.z, 0))>>8;
	dY3 = (max((sY3<<8)+(rY3-sY3)*iRect.z, 0))>>8;
	dU = (max((sU<<8)+(rU-sU)*iRect.z, 0))>>8;
	dV = (max((sV<<8)+(rV-sV)*iRect.z, 0))>>8;

	write_imageui(pDstY, posY.xy, convert_uint4(dY0));
	write_imageui(pDstY, posY.zy, convert_uint4(dY1));
	write_imageui(pDstY, posY.xw, convert_uint4(dY2));
	write_imageui(pDstY, posY.zw, convert_uint4(dY3));
	write_imageui(pDstU, posC, convert_uint4(dU));
	write_imageui(pDstV, posC, convert_uint4(dV));
}
/*
	Description: process data according to mv and sad result
	Work Item:	 8x2 pixels
	Paremeters:
*/
__kernel void KN_Denoise_Main(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
							__read_only image2d_t pRefY, __read_only image2d_t pRefU, __read_only image2d_t pRefV,
							__write_only image2d_t pDstY, __write_only image2d_t pDstU, __write_only image2d_t pDstV,
							__read_only image2d_t pMv, __read_only image2d_t pSad,
							int4 iRect)
{
	__const int2 tmp = {4, 1};
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 posC = {get_global_id(0), get_global_id(1)};
	int4 posY = {posC.x, posC.y, posC.x, posC.y};
	int2 mbpos = {posY.x/4, posY.y/16};

	int4 sad = read_imagei(pSad, sampler, mbpos);
	int4 mv = read_imagei(pMv, sampler, mbpos);

	int4 sY0, sU, sV;
	int4 rY0, rU, rV;
	int4 dY1, dY2, dY3;
	int4 dU1, dU2, dU3, dU4;
	int4 dV1, dV2, dV3, dV4;
	int4 ddY0, dU, dV;
	int4 m0, m1, m2, m3, m4, m5;
	int4 n0, n1, n2;
	int mbOffset = mv.x*mv.x + mv.y*mv.y;
	int mbXY = (int)(abs(mv.x) + abs(mv.y));
	int paramY = clamp(min(iRect.z, sad.y/64), 2, 255);
	int paramC = clamp(min(iRect.z*3/2, sad.y/64), 2, 255);

	n1.x = mbXY == 0;
	n1.y = mbXY <= 1;
	n1.z = mv.z < 0x180;
	n1.w = sad.x < 0x300;

	n2.x = mv.z<0x2a0;
	n2.y = !n2.x && mv.z<0x480;
	n2.z = mv.z>=0x480;
	n2.w = mv.z<0xc00;

	m0 = (int4)(mbOffset>=0x100);
	m3 = (int4)(n2.x && n1.x);

	n0.x = n2.x && !n1.x && (n1.y || n1.z || n1.w);
	n0.y = n2.y && (n1.y || n1.w);
	n0.z = n2.z && n2.w && n1.w;

	m2 = (int4)(n0.x || n0.y || n0.z);

	n0.x = n2.x && !n1.x && !n1.y && !n1.z && !n1.w;
	n0.y = n2.y && !n1.y && !n1.w;
	n0.z = n2.z && n2.w && !n1.w;

	m1 = (int4)(n0.x || !n0.x && n0.y || !n0.x && !n0.y && n0.z);

	sY0 = convert_int4(read_imageui(pSrcY, sampler, posY.xy));
	sU = convert_int4(read_imageui(pSrcU, sampler, posC));
	sV = convert_int4(read_imageui(pSrcV, sampler, posC));

	{
		int4 a = (int4)(n1.w && (n2.x && !n1.y && !n1.z || n2.y && !n1.y || n2.z));
		int4 posY4 = posY * tmp.xyxy + (1-a)*mv.xyxy;
		int2 posC4 = posC.xy * tmp.xy + (1-a.xy)*mv.xy/2;
		rY0 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.xy);
		rU = _Read4PixelsFromAnyPos(pRefU, sampler, posC4);
		rV = _Read4PixelsFromAnyPos(pRefV, sampler, posC4);
	}


	//Y
	{
		m4 = -(!m1 && !m2 && !m3);
		dY1 = _Denoise_Y_1(sY0, rY0, paramY);
		dY2 = _Denoise_Y_2(sY0, rY0, paramY);
		dY3 = _Denoise_Y_3(sY0, rY0, paramY);
		ddY0 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY0;
		ddY0 = m0 * sY0 + (1-m0) * ddY0;
	}
	//U,V
	{
		n0.x = n2.x && !n1.y && (n1.z || n1.w);
		n0.y = n2.y && !n1.y && n1.w;
		n0.z = n2.z && n1.w;
		m2 = (int4)(n0.x || n0.y || n0.z);

		n0.x = n2.x && !n1.x && n1.y;
		n0.y = n2.y && n1.y;
		m4 = (int4)(n0.x || n0.y);
		m5 = -(!m1 && !m2 && !m3 && !m4);

		dU1 = _Denoise_UV_1(sU, rU, paramC);
		dU2 = _Denoise_UV_2(sU, rU, paramC);
		dU3 = _Denoise_UV_3(sU, rU, paramC);
		dU4 = _Denoise_UV_4(sU, rU, paramC);
		dV1 = _Denoise_UV_1(sV, rV, paramC);
		dV2 = _Denoise_UV_2(sV, rV, paramC);
		dV3 = _Denoise_UV_3(sV, rV, paramC);
		dV4 = _Denoise_UV_4(sV, rV, paramC);
		dU = m1 * dU1 + m2 * dU2 + m3 * dU3 + m4 * dU4 + m5 * sU;
		dV = m1 * dV1 + m2 * dV2 + m3 * dV3 + m4 * dV4 + m5 * sV;
		dU = m0 * sU + (1-m0) * dU;
		dV = m0 * sV + (1-m0) * dV;
	}

	write_imageui(pDstY, posY.xy, convert_uint4(ddY0));
	write_imageui(pDstU, posC, convert_uint4(dU));
	write_imageui(pDstV, posC, convert_uint4(dV));
}

__kernel void KN_Denoise_PostProc(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
								  __read_only image2d_t pRefY, __read_only image2d_t pRefU, __read_only image2d_t pRefV,
								  __write_only image2d_t pDstY, __write_only image2d_t pDstU, __write_only image2d_t pDstV,
								  int4 iRect)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 pos = {get_global_id(0), get_global_id(1)};

	int4 sY, sU, sV;
	int4 rY, rU, rV;
	int4 dY, dU, dV;

	sY = convert_int4(read_imageui(pSrcY, sampler, pos));
	sU = convert_int4(read_imageui(pSrcU, sampler, pos));
	sV = convert_int4(read_imageui(pSrcV, sampler, pos));
	rY = convert_int4(read_imageui(pRefY, sampler, pos));
	rU = convert_int4(read_imageui(pRefU, sampler, pos));
	rV = convert_int4(read_imageui(pRefV, sampler, pos));

	dY = (max((sY<<8)+(rY-sY)*iRect.z, 0))>>8;
	dU = (max((sU<<8)+(rU-sU)*iRect.z, 0))>>8;
	dV = (max((sV<<8)+(rV-sV)*iRect.z, 0))>>8;

	write_imageui(pDstY, pos, convert_uint4(dY));
	write_imageui(pDstU, pos, convert_uint4(dU));
	write_imageui(pDstV, pos, convert_uint4(dV));
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
