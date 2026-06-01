#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_amd_printf : enable

#define ALIGN_4(x)		(((x)+3)&~3)
#define ALIGN_16(x)		(((x)+3)&~3)
#define AVG(a, b)		((a+b+1)>>1)
#define MUL255(v)		(((v)<<8) - (v))
#define MUL24(x,y)		mul24(x,y)
#define MAD24(x,y,z)	mad24(x,y,z)
#define ABS_INT4(a)		convert_int4(abs(a));

#define CLAMP_BYTE(val) (clamp((int4)val, (int)0, (int)255))
#define CLAMP_BYTEU(val) (clamp((uint4)val, (uint)0, (uint)255))

#define CHECK_BORDER(bLeft, bRight, val)	val = bLeft * val.xxxx + (1 - bLeft) * ( bRight * val.wwww + (1-bRight) * val);
#define CHECK_BOUNDARY(bCheck, bNotCheck, bvalue, v2) ((bCheck&v2) + (bNotCheck&bvalue))
#define CHOOSE_1IN2(bCheck, v1, v2) (((bCheck)&(v1)) + ((~bCheck)&(v2)))

#define SUM_V4(val, sum) {(val).xy = (val).xy+(val).zw; sum = (val).x+(val).y; }

#define COMPUTE_SAD(p0, p1, sad) {uint a; uint4 diff = abs(p0-p1); SUM_V4(diff, a); sad += a;}
#define INT4_TO_VECTOR(x0,y0,z0,w0,v)	{v.x = x0; v.y = y0; v.z = z0; v.w = w0;}
#define VECTOR_TO_4INT(v,x0,y0,z0,w0)	{x0 = v.x; y0 = v.y; z0 = v.z; w0 = v.w;}

#define ATOMIC_INC_COMPRESS(pShareMem, data)\
{\
	uint4 v;\
	v.x = (data)&0xFF;\
	v.y = ((data)>>8)&0xFF;\
	v.z = ((data)>>16)&0xFF;\
	v.w = ((data)>>24)&0xFF;\
	atomic_inc(&pShareMem[v.x]);\
	atomic_inc(&pShareMem[v.y]);\
	atomic_inc(&pShareMem[v.z]);\
	atomic_inc(&pShareMem[v.w]);\
}

#define ATOMIC_INC_VECTOR(pShareMem, v)\
{\
	atomic_inc(&pShareMem[(v).x]);\
	atomic_inc(&pShareMem[(v).y]);\
	atomic_inc(&pShareMem[(v).z]);\
	atomic_inc(&pShareMem[(v).w]);\
}

#define LEFT_SHIFT_4(type4, v0, v1, v2)\
{\
	type4 tmp = v0;\
	v0.xyz = v0.yzw;	v0.w = v1.x;\
	v1.xyz = v1.yzw;	v1.w = v2.x;\
	v2.xyz = v2.yzw;	v2.w = tmp.x;\
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
//		Y = ( (  66 * R + 129 * G +  25 * B + 128) >> 8) +  16
//		U = ( ( -38 * R -  74 * G + 112 * B + 128) >> 8) + 128
//		V = ( ( 112 * R -  94 * G -  18 * B + 128) >> 8) + 128
#define CONVERT_ARGBToYUV(iB, iG, iR,iY, iV, iU)\
{\
	int4 bgr2y = {25,  129, 66,  16};\
	int4 bgr2u = {112, -74, -38, 128};\
	int4 bgr2v = {-18, -94, 112, 128};\
\
	iY = ((bgr2y.xxxx * (iB) + bgr2y.yyyy * (iG) + bgr2y.zzzz * (iR) + 128)>>8) + bgr2y.wwww;\
	iV = ((bgr2v.xxxx * (iB) + bgr2v.yyyy * (iG) + bgr2v.zzzz * (iR) + 128)>>8) + bgr2v.wwww;\
	iU = ((bgr2u.xxxx * (iB) + bgr2u.yyyy * (iG) + bgr2u.zzzz * (iR) + 128)>>8) + bgr2u.wwww;\
	iY = CLAMP_BYTE(iY);\
	iV = CLAMP_BYTE(iV);\
	iU = CLAMP_BYTE(iU);\
}

// 	R = clip(( 298 * (Y - 16)				    + 409 * (V - 128) + 128) >> 8)
// 	G = clip(( 298 * (Y - 16) - 100 * (U - 128) - 208 * (V - 128) + 128) >> 8)
// 	B = clip(( 298 * (Y - 16) + 516 * (U - 128)					  + 128) >> 8)
#define CONVERT_YUVToARGB(iYUV, iBGRA)\
{\
	iYUV.x = (iYUV.x-16) * 298 + 128;\
	iYUV.yz = iYUV.yz - 128;\
\
	iBGRA.z = (iYUV.x				 + 409 * iYUV.z )>>8;\
	iBGRA.y = (iYUV.x - 100 * iYUV.y - 208 * iYUV.z )>>8;\
	iBGRA.x = (iYUV.x + 516 * iYUV.y				)>>8;\
	iBGRA.w = 255;\
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

	CONVERT_ARGBToYUV(B, G, R, dstY, dstV, dstU);

	write_imageui(pDstY, opos, convert_uint4(dstY));
	write_imageui(pDstU, opos, convert_uint4(dstU));
	write_imageui(pDstV, opos, convert_uint4(dstV));
}

__kernel void KN_YUVToARGB(__write_only image2d_t pDst, __read_only image2d_t pY, __read_only image2d_t pV, __read_only image2d_t pU)
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

	iY = offset*iY;
	iU = offset*iU;
	iV = offset*iV;

	SUM_V4(iY, iYUV.x);
	SUM_V4(iU, iYUV.y);
	SUM_V4(iV, iYUV.z);

	iYUV.w = 1;

	CONVERT_YUVToARGB(iYUV, iBGRA);

	fBGRA = convert_float4(iBGRA)/255.0f;

	write_imagef(pDst, opos.xy, fBGRA);
}

/*
	Parameter: iSize: x: image width;
					  y: image height;
					  z: display mode - SimHD_Splitter
					  w: (Middle line width)/2
*/
__kernel void KN_YUVToARGB_split(__write_only image2d_t pDst, __read_only image2d_t pY, __read_only image2d_t pV, __read_only image2d_t pU,
								 __read_only image2d_t pSrc, int4 iSize)
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

		iY = offset*iY;
		iU = offset*iU;
		iV = offset*iV;

		SUM_V4(iY, iYUV.x);
		SUM_V4(iU, iYUV.y);
		SUM_V4(iV, iYUV.z);

		iYUV.w = 1;

		CONVERT_YUVToARGB(iYUV, iBGRA);

		fBGRA = convert_float4(iBGRA)/255.0f;
	}

	write_imagef(pDst, opos.xy, fBGRA);
}


__kernel void KN_ARGBToYV12(__read_only image2d_t pRGB, __write_only image2d_t pY, __write_only image2d_t pV, __write_only image2d_t pU)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int2 ipos1 = {opos.x<<2, opos.y};
	int4 ipos2 = {ipos1.x+1, ipos1.x+2, ipos1.x+3, ipos1.y};

	float4 f0 = read_imagef(pRGB, sampler, ipos1.xy);
	float4 f1 = read_imagef(pRGB, sampler, ipos2.xw);
	float4 f2 = read_imagef(pRGB, sampler, ipos2.yw);
	float4 f3 = read_imagef(pRGB, sampler, ipos2.zw);

	int4 r0 = convert_int4(f0 * 255.0f+0.5f);
	int4 r1 = convert_int4(f1 * 255.0f+0.5f);
	int4 r2 = convert_int4(f2 * 255.0f+0.5f);
	int4 r3 = convert_int4(f3 * 255.0f+0.5f);

	__local int4 lMem[256];
	__local int4 *plYUV = lMem + get_local_id(1) * get_local_size(0) + get_local_id(0);

	int4 B, G, R, A;
	int4 dstY, dstU, dstV;

	TRANSPOSE_4x4(int4, r0, r1, r2, r3, B, G, R, A);

	CONVERT_ARGBToYUV(B, G, R, dstY, dstV, dstU);

	dstV.xy = dstV.xz + dstV.yw;
	dstV.zw = dstU.xz + dstU.yw;

	plYUV[0] = dstV;

	barrier(CLK_LOCAL_MEM_FENCE);

	if((opos.x&1)==0 && (opos.y&1)==0)
	{
		int2 cpos = opos>>1;
		int s = get_local_size(0);
		int4 iV0 = plYUV[0];
		int4 iV1 = plYUV[1];
		int4 iU0 = plYUV[s];
		int4 iU1 = plYUV[s+1];

		iV0 = iV0 + iU0;
		iV1 = iV1 + iU1;
		iV0 = (iV0 + 2)>>2;
		iV1 = (iV1 + 2)>>2;
		iU0.xy = iV0.zw;
		iU0.zw = iV1.zw;
		iV0.zw = iV1.xy;

		write_imageui(pU, cpos, convert_uint4(iU0));
		write_imageui(pV, cpos, convert_uint4(iV0));
	}
	write_imageui(pY, opos, convert_uint4(dstY));
}

__kernel void KN_YV12ToARGB(__write_only image2d_t pDst, __read_only image2d_t pY, __read_only image2d_t pV, __read_only image2d_t pU)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int4 ipos = {opos.x>>2, opos.y, opos.x>>3, opos.y>>1};
	int4 offset = opos.xxxx&0x3;
	int4 offset_c = (opos.xxxx>>1)&0x3;
	int4 MASK = {0, 1, 2, 3};

	int4 iY = convert_int4(read_imageui(pY, sampler, ipos.xy));
	int4 iU = convert_int4(read_imageui(pU, sampler, ipos.zw));
	int4 iV = convert_int4(read_imageui(pV, sampler, ipos.zw));
	int4 iYUV = (int4)(0);

	float4 fBGRA;
	int4 iBGRA = {16, 128, 128, 255<<8};

	offset = -(offset==MASK);
	offset_c=-(offset_c==MASK);
	iY = iY * offset;
	iV = iV * offset_c;
	iU = iU * offset_c;

	SUM_V4(iY, iYUV.x);
	SUM_V4(iU, iYUV.y);
	SUM_V4(iV, iYUV.z);
	iYUV.w = 1;

	CONVERT_YUVToARGB(iYUV, iBGRA);

	fBGRA = convert_float4(iBGRA)/255.0f;

	write_imagef(pDst, opos.xy, fBGRA);
}

/*
	Parameter: iSize: x: image width;
					  y: image height;
					  z: display mode - SimHD_Splitter
					  w: (Middle line width)/2
*/
__kernel void KN_YV12ToARGB_split(__write_only image2d_t pDst, __read_only image2d_t pY, __read_only image2d_t pV, __read_only image2d_t pU,
								  __read_only image2d_t pSrc, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int w4 = ALIGN_4(iSize.x>>2);
	int4 ipos = {opos.x>>2, opos.y, opos.x>>3, opos.y>>1};
	//int4 ipos = {(opos.x-MUL24(w4, iSize.z))>>2, opos.y, (opos.x-MUL24(w4, iSize.z))>>3, opos.y>>1};
	int2 lpos = {(opos.x+MUL24(w4, iSize.z)), opos.y};

	float4 fBGRA;
	int4 iBGRA = {16, 128, 128, 255<<8};

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
		int4 offset = opos.xxxx&0x3;
		int4 offset_c = (opos.xxxx>>1)&0x3;
		int4 MASK = {0, 1, 2, 3};

		int4 iY = convert_int4(read_imageui(pY, sampler, ipos.xy));
		int4 iU = convert_int4(read_imageui(pU, sampler, ipos.zw));
		int4 iV = convert_int4(read_imageui(pV, sampler, ipos.zw));
		int4 iYUV = (int4)(0);

		offset = -(offset==MASK);
		offset_c=-(offset_c==MASK);
		iY = iY * offset;
		iV = iV * offset_c;
		iU = iU * offset_c;

		SUM_V4(iY, iYUV.x);
		SUM_V4(iU, iYUV.y);
		SUM_V4(iV, iYUV.z);
		iYUV.w = 1;

		CONVERT_YUVToARGB(iYUV, iBGRA);

		fBGRA = convert_float4(iBGRA)/255.0f;
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

__kernel void KN_YUVToARGB_split2(__write_only image2d_t pDst,
								  __read_only image2d_t pRightY, __read_only image2d_t pRightV, __read_only image2d_t pRightU,
								  __read_only image2d_t pLeftY, __read_only image2d_t pLeftV, __read_only image2d_t pLeftU,
								  int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int w4 = ALIGN_4(iSize.x>>2);
	int2 ipos = {(opos.x-MUL24(w4, iSize.z))>>2, opos.y};
	int2 lpos = {(opos.x+MUL24(w4, iSize.z))>>2, opos.y};
	int4 offset = opos.xxxx&0x3;
	int4 mask = {0, 1, 2, 3};

	float4 fBGRA;
	int4 iBlack = {0, 0, 0, 1};
	int2 middle = {(iSize.x>>1) - iSize.w, (iSize.x>>1)+1+iSize.w};
	int bLeft = opos.x<middle.x;
	int bRight = opos.x>middle.y;
	int bMid = !bLeft && !bRight;

	{
		int4 iYUV = (int4)(0), iLeftYUV=(int4)(0);
		int4 iBGRA, iLeftBGRA;
		int4 iY = convert_int4(read_imageui(pRightY, sampler, ipos));
		int4 iU = convert_int4(read_imageui(pRightU, sampler, ipos));
		int4 iV = convert_int4(read_imageui(pRightV, sampler, ipos));
		int4 iLeftY = convert_int4(read_imageui(pLeftY, sampler, lpos));
		int4 iLeftU = convert_int4(read_imageui(pLeftU, sampler, lpos));
		int4 iLeftV = convert_int4(read_imageui(pLeftV, sampler, lpos));
		offset = -(offset==mask);

		iY = offset*iY;
		iU = offset*iU;
		iV = offset*iV;
		iLeftY = offset*iLeftY;
		iLeftU = offset*iLeftU;
		iLeftV = offset*iLeftV;

		SUM_V4(iY, iYUV.x);
		SUM_V4(iU, iYUV.y);
		SUM_V4(iV, iYUV.z);
		SUM_V4(iLeftY, iLeftYUV.x);
		SUM_V4(iLeftU, iLeftYUV.y);
		SUM_V4(iLeftV, iLeftYUV.z);

		iYUV.w = 1;
		iLeftYUV.w = 1;

		CONVERT_YUVToARGB(iYUV, iBGRA);
		CONVERT_YUVToARGB(iLeftYUV, iLeftBGRA);

		iBGRA = bLeft*iLeftBGRA + bRight*iBGRA + bMid*iBlack;

		fBGRA = convert_float4(iBGRA)/255.0f;
	}

	write_imagef(pDst, opos.xy, fBGRA);
}

__kernel void KN_NV12ToYV12(__read_only image2d_t pSrcY, __read_only image2d_t pSrcUV, __write_only image2d_t pY, __write_only image2d_t pV, __write_only image2d_t pU)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 oposv = {get_global_id(0), get_global_id(1)};
    int2 opos = oposv*2;
	int2 ipos1 = {opos.x<<2, opos.y};
	int4 ipos2 = {ipos1.x+1, ipos1.x+2, ipos1.x+3, ipos1.y};
    int2 iposv1 = {oposv.x<<2, oposv.y};
    int4 iposv2 = {iposv1.x+1,iposv1.x+2, iposv1.x+3, iposv1.y};
    int4 ADD = {0, 4, 1, 0};

	float4 y0 = read_imagef(pSrcY, sampler, ipos1.xy);
	float4 y1 = read_imagef(pSrcY, sampler, ipos2.xw);
	float4 y2 = read_imagef(pSrcY, sampler, ipos2.yw);
	float4 y3 = read_imagef(pSrcY, sampler, ipos2.zw);
	float4 y4 = read_imagef(pSrcY, sampler, ipos1.xy+ADD.yx);
	float4 y5 = read_imagef(pSrcY, sampler, ipos2.xw+ADD.yx);
	float4 y6 = read_imagef(pSrcY, sampler, ipos2.yw+ADD.yx);
	float4 y7 = read_imagef(pSrcY, sampler, ipos2.zw+ADD.yx);
	float4 z0 = read_imagef(pSrcY, sampler, ipos1.xy+ADD.xz);
	float4 z1 = read_imagef(pSrcY, sampler, ipos2.xw+ADD.xz);
	float4 z2 = read_imagef(pSrcY, sampler, ipos2.yw+ADD.xz);
	float4 z3 = read_imagef(pSrcY, sampler, ipos2.zw+ADD.xz);
	float4 z4 = read_imagef(pSrcY, sampler, ipos1.xy+ADD.yz);
	float4 z5 = read_imagef(pSrcY, sampler, ipos2.xw+ADD.yz);
	float4 z6 = read_imagef(pSrcY, sampler, ipos2.yw+ADD.yz);
	float4 z7 = read_imagef(pSrcY, sampler, ipos2.zw+ADD.yz);
	float4 c0 = read_imagef(pSrcUV, sampler, iposv1.xy);
	float4 c1 = read_imagef(pSrcUV, sampler, iposv2.xw);
	float4 c2 = read_imagef(pSrcUV, sampler, iposv2.yw);
	float4 c3 = read_imagef(pSrcUV, sampler, iposv2.zw);
	float4 fdy, fdv, fdu;
    float4 fdy1, fdy2, fdy3;
    uint4 dy, dv, du;
    uint4 dy1, dy2, dy3;
    fdy.x = y0.x;
    fdy.y = y1.x;
    fdy.z = y2.x;
    fdy.w = y3.x;
    fdy1.x = y4.x;
    fdy1.y = y5.x;
    fdy1.z = y6.x;
    fdy1.w = y7.x;
    fdy2.x = z0.x;
    fdy2.y = z1.x;
    fdy2.z = z2.x;
    fdy2.w = z3.x;
    fdy3.x = z4.x;
    fdy3.y = z5.x;
    fdy3.z = z6.x;
    fdy3.w = z7.x;

    fdv.x = c0.x;
    fdv.y = c1.x;
    fdv.z = c2.x;
    fdv.w = c3.x;
    fdu.x = c0.y;
    fdu.y = c1.y;
    fdu.z = c2.y;
    fdu.w = c3.y;
    dy = convert_uint4((fdy)*255.0f+0.5f);
    dy1 = convert_uint4((fdy1)*255.0f+0.5f);
    dy2 = convert_uint4((fdy2)*255.0f+0.5f);
    dy3 = convert_uint4((fdy3)*255.0f+0.5f);
    dv = convert_uint4((fdv)*255.0f+0.5f);
    du = convert_uint4((fdu)*255.0f+0.5f);
    write_imageui(pY, opos, dy);
    write_imageui(pY, opos+ADD.zx, dy1);
    write_imageui(pY, opos+ADD.xz, dy2);
    write_imageui(pY, opos+ADD.zz, dy3);
    write_imageui(pV, oposv, dv);
    write_imageui(pU, oposv, du);

}

__kernel void KN_YV12ToNV12(__write_only image2d_t pDstY, __write_only image2d_t pDstUV, __read_only image2d_t pY, __read_only image2d_t pV, __read_only image2d_t pU)
{
    sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
    int2 oposy = opos*2;
    int4 ipos = {opos.x>>2, opos.y, opos.x>>1, opos.y*2};   //{vposx, vposy, yposx, yposy}
	int4 offset_c = opos.xxxx&0x3;
	int4 offset_y = opos.xxxx&0x1;
	int4 MASK_C = {0, 1, 2, 3};
    int4 MASK_Y = {0, 0, 1, 1};

	int4 iY = convert_int4(read_imageui(pY, sampler, ipos.zw));
	int4 iY1 = convert_int4(read_imageui(pY, sampler, ipos.zw+MASK_C.xy));
	int4 iU = convert_int4(read_imageui(pU, sampler, ipos.xy));
	int4 iV = convert_int4(read_imageui(pV, sampler, ipos.xy));
	int4 iYUV = (int4)(0);
    int4 dy = {0, 0, 0, 256}, dy1 = dy, dy2=dy, dy3=dy;
    int4 duv={0, 0, 0, 256};
    float4 fdy = {0.0f, 0.0f, 0.0f, 1.0f}, fduv={0.0f,0.0f, 0.0f, 1.0f};
    float4 fdy1=fdy, fdy2=fdy, fdy3=fdy;


   	offset_y = -(offset_y==MASK_Y);
	offset_c = -(offset_c==MASK_C);
	iY = iY * offset_y;
	iY1 = iY1 * offset_y;
	iV = iV * offset_c;
	iU = iU * offset_c;

    iY.xy = iY.xy + iY.zw;
    iY1.xy = iY1.xy + iY1.zw;
	SUM_V4(iV, iYUV.y);
	SUM_V4(iU, iYUV.z);
	iYUV.w = 1;

    dy.x = iY.x;
    dy1.x = iY.y;
    dy2.x = iY1.x;
    dy3.x = iY1.y;
    duv.x = iYUV.y;
    duv.y = iYUV.z;
    fdy = convert_float4(dy)/256.0f;
    fdy1 = convert_float4(dy1)/256.0f;
    fdy2 = convert_float4(dy2)/256.0f;
    fdy3 = convert_float4(dy3)/256.0f;
    fduv = convert_float4(duv)/256.0f;
    write_imagef(pDstY, oposy, fdy);
    write_imagef(pDstY, oposy+MASK_C.yx, fdy1);
    write_imagef(pDstY, oposy+MASK_C.xy, fdy2);
    write_imagef(pDstY, oposy+MASK_C.yy, fdy3);
    write_imagef(pDstUV, opos, fduv);
}

__kernel void KN_YV12ToNV12_Split(__write_only image2d_t pDstY, __write_only image2d_t pDstUV,
								  __read_only image2d_t pRightY, __read_only image2d_t pRightV, __read_only image2d_t pRightU,
								  __read_only image2d_t pLeftY, __read_only image2d_t pLeftUV
								  , int4 iSize)
{
    sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
    int2 oposy = opos*2;
	int w4 = ALIGN_4(iSize.x>>2);
    int start = w4*iSize.z;
	int2 ipos = {(opos.x-start)>>2, opos.y};
    int4 iposy= {(opos.x-start)>>1, ipos.y*2, ipos.x*2+1, ipos.y*2+1};
	int2 lpos = {(opos.x+start), opos.y};
    int4 lposy = {lpos.x*2, lpos.y*2, lpos.x*2+1, lpos.y*2+1};
	int4 offset_c = opos.xxxx&0x3;
	int4 offset_y = opos.xxxx&0x1;
	int4 MASK_C = {0, 1, 2, 3};
    int4 MASK_Y = {0, 0, 1, 1};

	float4 fBlack = {0.0f, 0.5f, 0.5f, 1};
    float4 fdY={0.0f,0.0f, 0.0f, 0.0f}, fdUV={0.0f,0.0f, 0.0f, 0.0f};
    float4 fdY0=fdY, fdY1=fdY, fdY2=fdY, fdY3=fdY;
	int2 middle = {(iSize.x>>1) - iSize.w, (iSize.x>>1)+1+iSize.w};
	int bLeft = opos.x<middle.x;
	int bRight = opos.x>middle.y;
	int bMid = !bLeft && !bRight;

 	if(bLeft||bMid)
	{
        float4 fY0 = read_imagef(pLeftY, sampler, lposy.xy);
        float4 fY1 = read_imagef(pLeftY, sampler, lposy.zy);
        float4 fY2 = read_imagef(pLeftY, sampler, lposy.xw);
        float4 fY3 = read_imagef(pLeftY, sampler, lposy.zw);
		float4 fV = read_imagef(pLeftUV, sampler, lpos);
        float bfLeft = (float)bLeft, bfMid = (float)bMid;
		fdY0 = fY0*bfLeft + fBlack*bfMid;
		fdY1 = fY1*bfLeft + fBlack*bfMid;
		fdY2 = fY2*bfLeft + fBlack*bfMid;
		fdY3 = fY3*bfLeft + fBlack*bfMid;
		fdUV = fV*bfLeft + fBlack*bfMid;
	}
	else
    {

        int4 iY0 = convert_int4(read_imageui(pRightY, sampler, iposy.xy));
        int4 iY1 = convert_int4(read_imageui(pRightY, sampler, iposy.xy+MASK_C.xy));
        int4 iV = convert_int4(read_imageui(pRightV, sampler, ipos));
        int4 iU = convert_int4(read_imageui(pRightU, sampler, ipos));
        int4 idY0={0, 0, 0, 0}, idY1={0, 0, 0, 0}, idY2={0, 0, 0, 0}, idY3={0, 0, 0, 0}, idUV={0, 0, 0, 1};

        offset_y = -(offset_y==MASK_Y);
        offset_c = -(offset_c==MASK_C);

		iY0 = offset_y*iY0;
		iY1 = offset_y*iY1;
		iU = offset_c*iU;
		iV = offset_c*iV;

        iY0.xy = iY0.xy + iY0.zw;
        iY1.xy = iY1.xy + iY1.zw;
        SUM_V4(iV, idUV.x);
        SUM_V4(iU, idUV.y);
        idY0.x = iY0.x;
        idY1.x = iY0.y;
        idY2.x = iY1.x;
        idY3.x = iY1.y;

        fdY0 = convert_float4(idY0)/256.0f;
        fdY1 = convert_float4(idY1)/256.0f;
        fdY2 = convert_float4(idY2)/256.0f;
        fdY3 = convert_float4(idY3)/256.0f;
        fdUV = convert_float4(idUV)/256.0f;
	}

	write_imagef(pDstY, oposy.xy, fdY0);
	write_imagef(pDstY, oposy.xy+MASK_C.yx, fdY1);
	write_imagef(pDstY, oposy.xy+MASK_C.xy, fdY2);
	write_imagef(pDstY, oposy.xy+MASK_C.yy, fdY3);
	write_imagef(pDstUV, opos.xy, fdUV);
}

__kernel void KN_YV12ToNV12_Split2(__write_only image2d_t pDstY,
								   __write_only image2d_t pDstUV, __read_only image2d_t pRightY,
								   __read_only image2d_t pRightV,__read_only image2d_t pRightU,
								   __read_only image2d_t pLeftY,__read_only image2d_t pLeftV,
								   __read_only image2d_t pLeftU,int4 iSize)
{

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int2 opos = {get_global_id(0), get_global_id(1)};
	int2 oposy = opos*2;
	int w4 = ALIGN_4(iSize.x>>2);
    int start = w4*iSize.z;
	int2 ipos = {(opos.x-start)>>2, opos.y};
	int4 iposy= {(opos.x-start)>>1, ipos.y*2, ipos.x*2+1, ipos.y*2+1};
	int2 lpos = {(opos.x+start)>>2, opos.y};
	int4 lposy= {(opos.x+start)>>1, lpos.y*2, lpos.x*2+1, lpos.y*2+1};

	int4 offset_c = opos.xxxx&0x3;
	int4 offset_y = opos.xxxx&0x1;
	int4 MASK_C = {0, 1, 2, 3};
    int4 MASK_Y = {0, 0, 1, 1};

	float4 fdY={0.0f,0.0f, 0.0f, 1.0f}, fdUV={0.0f,0.0f, 0.0f, 1.0f};
    float4 fdY0=fdY, fdY1=fdY, fdY2=fdY, fdY3=fdY;

	float4 fBlack = {0.0, 0.5, 0.5, 1.0};
	int4 iBlack = {0,128,128,1};
	int2 middle = {(iSize.x>>1) - iSize.w, (iSize.x>>1)+1+iSize.w};
	int bLeft = opos.x<middle.x;
	int bRight = opos.x>middle.y;
	int bMid = !bLeft && !bRight;

		int4 iYUV = (int4)(0);
		int4 iLeftYUV = (int4)(0);

		int4 iY0 = convert_int4(read_imageui(pRightY, sampler, iposy.xy));
        int4 iY1 = convert_int4(read_imageui(pRightY, sampler, iposy.xy+MASK_C.xy));
		int4 iV = convert_int4(read_imageui(pRightV, sampler, ipos.xy));
        int4 iU = convert_int4(read_imageui(pRightU, sampler, ipos.xy));

	    int4 iLeftY0 = convert_int4(read_imageui(pLeftY, sampler, lposy.xy));
		int4 iLeftY1 = convert_int4(read_imageui(pLeftY, sampler, lposy.xy+MASK_C.xy));
		int4 iLeftV = convert_int4(read_imageui(pLeftV, sampler, lpos.xy));
        int4 iLeftU = convert_int4(read_imageui(pLeftU, sampler, lpos.xy));

		int4 idY0={0, 0, 0, 0}, idY1={0, 0, 0, 0}, idY2={0, 0, 0,0}, idY3={0, 0, 0, 0}, idUV={0, 0, 0, 1};

		offset_y = -(offset_y==MASK_Y);
		offset_c = -(offset_c==MASK_C);
		iY0 = offset_y*iY0;
		iY1 = offset_y*iY1;
		iU = offset_c*iU;
		iV = offset_c*iV;

		iLeftY0 = offset_y*iLeftY0;
		iLeftY1 = offset_y*iLeftY1;
		iLeftU = offset_c*iLeftU;
		iLeftV = offset_c*iLeftV;

	    iY0.xy = iY0.xy + iY0.zw;
        iY1.xy = iY1.xy + iY1.zw;
	    SUM_V4(iV, iYUV.y);
        SUM_V4(iU, iYUV.z);

        iLeftY0.xy = iLeftY0.xy + iLeftY0.zw;
        iLeftY1.xy = iLeftY1.xy + iLeftY1.zw;
	    SUM_V4(iLeftV, iLeftYUV.y);
        SUM_V4(iLeftU, iLeftYUV.z);

		idY0.x = iY0.x*bRight + iLeftY0.x*bLeft;
        idY1.x = iY0.y*bRight + iLeftY0.y*bLeft;
        idY2.x = iY1.x*bRight + iLeftY1.x*bLeft;
        idY3.x = iY1.y*bRight + iLeftY1.y*bLeft;
		idUV.x = iYUV.y*bRight + iLeftYUV.y*bLeft;
		idUV.y = iYUV.z*bRight + iLeftYUV.z*bLeft;

		idY0 = idY0+bMid*iBlack;
		idY1 = idY1+bMid*iBlack;
		idY2 = idY2+bMid*iBlack;
		idY3 = idY3+bMid*iBlack;
		idUV = idUV+bMid*iBlack;

	    fdY0 = convert_float4(idY0)/256.0f;
        fdY1 = convert_float4(idY1)/256.0f;
        fdY2 = convert_float4(idY2)/256.0f;
        fdY3 = convert_float4(idY3)/256.0f;
        fdUV = convert_float4(idUV)/256.0f;

    write_imagef(pDstY, oposy.xy, fdY0);
    write_imagef(pDstY, oposy.xy+MASK_C.yx, fdY1);
    write_imagef(pDstY, oposy.xy+MASK_C.xy, fdY2);
    write_imagef(pDstY, oposy.xy+MASK_C.yy, fdY3);
    write_imagef(pDstUV, opos.xy, fdUV);

}
void parallel_memcpy(__local uchar *dst,  __global uchar *src,  uint count_uints)
{
	int init=get_local_id(0)+get_local_size(0)*get_local_id(1);
	int step=get_local_size(0)*get_local_size(1);
	for(int i=init;i<count_uints;i+=step)
	{
		dst[i]=src[i];
	}
}
//downsample and compress 16 uchar to 4 int
//pSrc: input frame
//pCompress: = (cl_mem)clCreateBuffer(context, CL_MEM_READ_WRITE, FrameWidth*FrameHeight/16*64, 0, &hr);
//iSize.x: FrameWidth/16
//iSize.y: FrameHeight/16
//iSize.z: FrameWidth/4
//iSize.w: FrameWidth/16
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
//pSrcY, pSrcU, pSrcV: the input frame
//pIntensityMap: Table_0
//pDstY, pDstU, pDstV: the output frame
__kernel void KN_DylightLookUpTable_YV12(__read_only image2d_t pSrcY, __read_only image2d_t pSrcU, __read_only image2d_t pSrcV,
										__global uchar *g_pIntensityMap,
										__write_only image2d_t pDstY, __write_only image2d_t pDstU, __write_only image2d_t pDstV,
										uint4 iSize)
{
	__local uchar pIntensityMap[1536];

	parallel_memcpy(pIntensityMap, g_pIntensityMap, 1536);

	barrier(CLK_LOCAL_MEM_FENCE);
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
	__local uint *pBezierMap = (__local uint*)pIntensityMap;
	__local uchar *pContrastMap = (__local uchar*)(pIntensityMap + 256*4);

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
//pSrc: pCompress of KN_DownSampleAndCompress
//pHist: = clCreateBuffer(context, CL_MEM_READ_WRITE, FrameHeight/16*256*sizeof(INT), 0, &hr);
//pLDS: = w*h*256*sizeof(cl_int), w = get_global_size(0)/get_local_size(0); h = get_global_size(1)/get_local_size(1)
//iSize.x = FrameWidth/16
//iSize.y = FrameHeight/16
//iSize.z = FrameWidth/16
//iSize.w = 0;
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

//pHistSum: pHist of KN_Histogram256_LDS
//pHist: = clCreateBuffer(context, CL_MEM_READ_WRITE, 256*sizeof(INT), 0, &hr);
//iSize.x = FrameWidth/16
//iSize.y = FrameHeight/16
//iSize.z = the width of local memory of KN_Histogram256_LDS
//iSize.w = the height of local memory of KN_Histogram256_LDS
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
//param:
//  pIn: input frame
//  pOut: output frame
//  iSize.x: FrameWidth/4
//  iSize.y: FrameHeight
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

//param:
//  pSrc:   the src frame, equal to the input frame of KN_SharpenUM_0
//  pIn:    input frame, the output frame of KN_SharpenUM_0
//  pOut:   output frame
//  iSize.x: FrameWidth/4
//  iSize.y: FrameHeight
//  iSharpen: >=0
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

//Param:
//  pIn: input frame
//  pOut: output frame
//  iSize.x: FrameWidth/4
//  iSize.y: FrameHeight
//  pLocalMemory: size=sizeof(cl_int)*2*localThreadsT[0]*localThreadsT[1]
__kernel void KN_Deblock(__read_only image2d_t pIn, __write_only image2d_t pOut, int4 iSize)
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

    int memStride = 32;
    __local int lMem[256*2];
	__local int *plCount = lMem;
	int CountIdx = ((lpos.y>>3)*memStride) + (lpos.x<<1);
	int CountIdx2 = ((get_local_size(1)>>3)*memStride) + CountIdx;
	int CountIdx3 = ((get_local_size(1)>>3)*memStride) + CountIdx2;
	int lMemIdx = lpos.y*memStride + lpos.x*2;

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
		lMemIdx = ((lpos.y>>3)*memStride*8) + (lpos.x<<1);

		d0.s0 = (lpos.y&7)>>2;
		d0.s1 = (lpos.y&3)<<3;

		p0.s0 = lMem[lMemIdx+d0.s0];
		p0.s1 = lMem[lMemIdx+d0.s0+memStride];
		p0.s2 = lMem[lMemIdx+d0.s0+memStride*2];
		p0.s3 = lMem[lMemIdx+d0.s0+memStride*3];
		p0.s4 = lMem[lMemIdx+d0.s0+memStride*4];
		p0.s5 = lMem[lMemIdx+d0.s0+memStride*5];
		p0.s6 = lMem[lMemIdx+d0.s0+memStride*6];
		p0.s7 = lMem[lMemIdx+d0.s0+memStride*7];

		p0 = (p0>>d0.s1)&0x000000FF;
	}
//	row
	barrier(CLK_LOCAL_MEM_FENCE);
	{
		lMemIdx = (lpos.y*memStride) + (lpos.x<<1);
		lMem[lMemIdx] = 0;
        lMem[lMemIdx+1] = 0;
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
		lMemIdx = ((lpos.y>>3)*memStride*8) + (lpos.x<<1);


		d0.s0 = (lpos.y&7)>>2;
		d0.s1 = (lpos.y&3)<<3;

		p0.s0 = lMem[lMemIdx+d0.s0];
		p0.s1 = lMem[lMemIdx+d0.s0+memStride];
		p0.s2 = lMem[lMemIdx+d0.s0+memStride*2];
		p0.s3 = lMem[lMemIdx+d0.s0+memStride*3];
		p0.s4 = lMem[lMemIdx+d0.s0+memStride*4];
		p0.s5 = lMem[lMemIdx+d0.s0+memStride*5];
		p0.s6 = lMem[lMemIdx+d0.s0+memStride*6];
		p0.s7 = lMem[lMemIdx+d0.s0+memStride*7];

		p0 = (p0>>d0.s1)&0x000000FF;
	}
	write_imageui(pOut, coord.xy, convert_uint4(p0.lo));
	write_imageui(pOut, coord.zy, convert_uint4(p0.hi));
}

__kernel void KN_Deblock_Intel(__read_only image2d_t pIn, __write_only image2d_t pOut, int4 iSize, __local int *pLocalMemory)
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

    int memStride = get_local_size(0)*2;
    __local int *lMem = pLocalMemory;
	__local int *plCount = lMem;
	int CountIdx = ((lpos.y>>3)*memStride) + (lpos.x<<1);
	int CountIdx2 = ((get_local_size(1)>>3)*memStride) + CountIdx;
	int CountIdx3 = ((get_local_size(1)>>3)*memStride) + CountIdx2;
	int lMemIdx = lpos.y*memStride + lpos.x*2;

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
		lMemIdx = ((lpos.y>>3)*memStride*8) + (lpos.x<<1);

		d0.s0 = (lpos.y&7)>>2;
		d0.s1 = (lpos.y&3)<<3;

		p0.s0 = lMem[lMemIdx+d0.s0];
		p0.s1 = lMem[lMemIdx+d0.s0+memStride];
		p0.s2 = lMem[lMemIdx+d0.s0+memStride*2];
		p0.s3 = lMem[lMemIdx+d0.s0+memStride*3];
		p0.s4 = lMem[lMemIdx+d0.s0+memStride*4];
		p0.s5 = lMem[lMemIdx+d0.s0+memStride*5];
		p0.s6 = lMem[lMemIdx+d0.s0+memStride*6];
		p0.s7 = lMem[lMemIdx+d0.s0+memStride*7];

		p0 = (p0>>d0.s1)&0x000000FF;
	}
//	row
	barrier(CLK_LOCAL_MEM_FENCE);
	{
		lMemIdx = (lpos.y*memStride) + (lpos.x<<1);
		lMem[lMemIdx] = 0;
        lMem[lMemIdx+1] = 0;
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
		lMemIdx = ((lpos.y>>3)*memStride*8) + (lpos.x<<1);


		d0.s0 = (lpos.y&7)>>2;
		d0.s1 = (lpos.y&3)<<3;

		p0.s0 = lMem[lMemIdx+d0.s0];
		p0.s1 = lMem[lMemIdx+d0.s0+memStride];
		p0.s2 = lMem[lMemIdx+d0.s0+memStride*2];
		p0.s3 = lMem[lMemIdx+d0.s0+memStride*3];
		p0.s4 = lMem[lMemIdx+d0.s0+memStride*4];
		p0.s5 = lMem[lMemIdx+d0.s0+memStride*5];
		p0.s6 = lMem[lMemIdx+d0.s0+memStride*6];
		p0.s7 = lMem[lMemIdx+d0.s0+memStride*7];

		p0 = (p0>>d0.s1)&0x000000FF;
	}
	write_imageui(pOut, coord.xy, convert_uint4(p0.lo));
	write_imageui(pOut, coord.zy, convert_uint4(p0.hi));
}

//Param:
//  pInput: input frame
//  pOutput: = clCreateBuffer(context, CL_MEM_READ_WRITE, FrameWidth*FrameHeight, 0, &hr)
//..pTable: table_1
//  iSize.x: FrameWidth/4
//  iSize.y: FrameHeight
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

		//index = (sx<<9) + sy;
		//
		//data.x = pTable[index.x];
		//data.y = pTable[index.y];
		//data.z = pTable[index.z];
		//data.w = pTable[index.w];
		data=(int4)0;

		int4 mask0,mask;
		mask0=(sy==(int4)255);
		mask0&=(sx==(int4)255);

		float4 dTheta=atan2(convert_float4(sy-(int4)255), convert_float4(sx-(int4)255))*180.0f / M_PI_F;
		mask=isless(dTheta,(float4)(0.0f));
		dTheta=select(dTheta,dTheta+(float4)(180.0f),mask);

		mask=isgreater(dTheta,(float4)(168.75f));
		data=select(data,(int4)(1),mask);

		mask=islessequal(dTheta,(float4)(168.75f));
		data=select(data,(int4)(128),mask);

		mask=islessequal(dTheta,(float4)(146.25f));
		data=select(data,(int4)(64),mask);

		mask=islessequal(dTheta,(float4)(123.75f));
		data=select(data,(int4)(32),mask);

		mask=islessequal(dTheta,(float4)(101.25f));
		data=select(data,(int4)(16),mask);

		mask=islessequal(dTheta,(float4)(78.75f));
		data=select(data,(int4)(8),mask);

		mask=islessequal(dTheta,(float4)(56.25f));
		data=select(data,(int4)(4),mask);

		mask=islessequal(dTheta,(float4)(33.75f));
		data=select(data,(int4)(2),mask);

		mask=islessequal(dTheta,(float4)(11.25f));
		data=select(data,(int4)(1),mask);

		data=select(data,(int4)(0),mask0);

		pOutput[opos] = convert_uchar4_sat(data);
	}
}

#define GET_LEVEL_NUM_1()\
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
#define GET_LEVEL_NUM()\
{\
	iNumInLevel = ((p00 & level)>>pos);\
	iNumInLevel += ((p01 & level)>>pos);\
	iNumInLevel += ((p02 & level)>>pos);\
	iNumInLevel += ((p10 & level)>>pos);\
	iNumInLevel += ((p11 & level)>>pos);\
	iNumInLevel += ((p12 & level)>>pos);\
	iNumInLevel += ((p20 & level)>>pos);\
	iNumInLevel += ((p21 & level)>>pos);\
	iNumInLevel += ((p22 & level)>>pos);\
	iTotalNum += iNumInLevel;\
	iBinNum -= (iNumInLevel != 0);\
	bLarger = iNumInLevel>iMaxNumInLevel;\
	iMaxNumInLevel = CHOOSE_1IN2(bLarger, iNumInLevel, iMaxNumInLevel);\
	iMaxLevel = CHOOSE_1IN2(bLarger, level, iMaxLevel);\
	level = level<<1;\
	pos++;\
}
//Param:
//  pLevel: pOutput of KN_GetEdgeInfo
//  pEdgeDir: = clCreateBuffer(context, CL_MEM_READ_WRITE, FrameWidth*FrameHeight, 0, &hr)
//..pNewLevel: = clCreateBuffer(context, CL_MEM_READ_WRITE, FrameWidth*FrameHeight, 0, &hr)
//  iSize.x: FrameWidth/4
//  iSize.y: FrameHeight
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
		int pos = 0;

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
	iData |= bSelected * val;	\
	iLevel = iLevel<<1;		\
}
//Param:
//  pEdgeDir: pEdgeDir of KN_EdgeAA_0
//  pLevel: the output of KN_GetEdgeInfo
//..pNewLevel: pNewLevel of KN_EdgeAA_0
//..pTable: Table_2
//  iSize.x: FrameWidth/4
//  iSize.y: FrameHeight
__kernel void KN_EdgeAA_1(__global uchar4 *pEdgeDir, __global uchar4 *pLevel, __global uchar4 *pNewLevel, __global uchar *g_pTable, int4 iSize)
{
	__local uchar pTable[256];
	parallel_memcpy(pTable, g_pTable, 256);
	barrier(CLK_LOCAL_MEM_FENCE);

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
//Param:
//  pInput: the input frame, pInput of KN_GetEdgeInfo
//  pLevel: the output of KN_GetEdgeInfo
//..pNewLevel: pNewLevel of KN_EdgeAA_0
//..pOutput: the output frame
//..pTable: Table_2
//  iSize.x: FrameWidth/4
//  iSize.y: FrameHeight
__kernel void KN_EdgeAA_2(__read_only image2d_t pInput, __global uchar4 *pLevel, __global uchar4 *pNewLevel, __write_only image2d_t pOutput, __global uchar *g_pTable, int4 iSize)
{
	__local uchar pTable[256];
	parallel_memcpy(pTable, g_pTable, 256);
	barrier(CLK_LOCAL_MEM_FENCE);

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

	SUM_V4(d0, e0.x);
	SUM_V4(d1, e0.y);
	SUM_V4(d2, e0.z);
	SUM_V4(d3, e0.w);
	return e0;
}

//param:
//  pSrc: the input frame
//..pDst: the frame after 4x4 downsample
//..param: (x,y): the size of the input frame, (z,w): the size of the dst frame
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

	write_imageui(pDst, coord.xy, CLAMP_BYTEU(e0));
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
	COMPUTE_SAD(r0.s0123, s0, sad);\
	COMPUTE_SAD(r1.s0123, s1, sad);\
	COMPUTE_SAD(r2.s0123, s2, sad);\
	COMPUTE_SAD(r3.s0123, s3, sad);\
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


//Function: search 4x8 pixels per thread
//Params	:
//..pSrc: the src frame
//..pRef: the reference frame
//..pMv: = clCreateImage2D(context, CL_MEM_READ_WRITE, &format, FrameWidth/16, FrameHeight/4, 0, NULL, &hr); format = {CL_RGBA, CL_SIGNED_INT32};
//..pLocalMv: = get_local_size(0)*get_local_size(1)*sizeof(cl_int4)
//..iRect: (x,y):	the size of frame
//         (z,w):	search_range, 16x16
__kernel __attribute__((reqd_work_group_size(16,16,1)))
void  KN_4x4FullSearchNxM_Intel(__read_only image2d_t pSrc, __read_only image2d_t pRef,  __write_only image2d_t pMV,
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

__kernel void  KN_4x4FullSearchNxM(__read_only image2d_t pSrc, __read_only image2d_t pRef,  __write_only image2d_t pMV,
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

//Function: get referenc mv for 16x16 motion search
//Params	:
//  pSrc: the pMV of KN_4x4FullSearchNxM
//  pMv: the output mv buffer, the same size as pSrc
//  iRect: (x,y):	the size of frame
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


//	refpos.xy:	pixel_pos
//		   zw:  global pos

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

//Work group size must be 4x16
//Params:
//  pSrc: uint8, current frame
//  pRef: uint8, reference frame
//  p4x4Mv: pMV of KN_Get4x4RefMv
//  pPreMv: the 16x16 mv of previous frame
//  Sad: pSad of KN_MBSAD
//  pSceneChange: can be zero, 16x16xint4
//  pMv: the output 16x16 mv of current frame
//	iRect: resolution of current frame
//  pLocalMem: = sizeof(cl_int4)*2*get_local_size(0)/4
__kernel void KN_16x16FastIntegerPixelSearch_Atomic(__read_only image2d_t pSrc, __read_only image2d_t pRef,
											__read_only image2d_t p4x4Mv, __read_only image2d_t pPreMv, __read_only image2d_t pSad,
											__global int4 *pSceneChange,
											__write_only image2d_t pMv, int4 iRect,
											__local int *pLocalMem)
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

	__local int *ShareMemory = pLocalMem;

	__local int *plSumSad = ShareMemory + ((lpos.x>>2)<<2);
	__local int4 *plSad4 = (__local int4*)plSumSad;

	int4 mvtmp[5], refpos[4], refpos2;
	uint4 Intersad, mbXY=0, bPred=0, bPred2=0;
	int4 s0;
	uint4 uSad1, uSad2;
	int4 ImageRange = 0;
	uint MaxXY = 0;

	__local int *pReset = ShareMemory + (lpos.x<<1);
	pReset[0] = 0;
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
	int4 bChange = pSceneChange[0];

	int4 SearchRange;
	SearchRange.xy = pixel_pos + mvstart.xy - (iRect.zw>>1);
	SearchRange.zw = pixel_pos + mvstart.xy + (iRect.zw>>1);

	bChange.x = bChange.x * bChange.y;
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

		if(bChange.x || mvbest.z == mvstart.z || mvbest.z<0x400)
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
		//mvbest.w = (loop<<8)+(a*2+1);
		mvbest.w = (a*2+1);

		mvbest.xy = mvbest.xy * (1-bChange.xx) + 255 * bChange.xx;
		//mvbest.z = bChange.x;
		write_imagei(pMv, gpos.zw, mvbest);
	}
}

__kernel __attribute__((reqd_work_group_size(4, 16, 1)))
void KN_16x16FastIntegerPixelSearch_Atomic_Intel(__read_only image2d_t pSrc, __read_only image2d_t pRef,
											__read_only image2d_t p4x4Mv, __read_only image2d_t pPreMv, __read_only image2d_t pSad,
											__global int4 *pSceneChange,
											__write_only image2d_t pMv, int4 iRect,
											__local int *pLocalMem)
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

	__local int *ShareMemory = pLocalMem;

	__local int *plSumSad = ShareMemory + ((lpos.x>>2)<<2);
	__local int4 *plSad4 = (__local int4*)plSumSad;

	int4 mvtmp[5], refpos[4], refpos2;
	uint4 Intersad, mbXY=0, bPred=0, bPred2=0;
	int4 s0;
	uint4 uSad1, uSad2;
	int4 ImageRange = 0;
	uint MaxXY = 0;

	__local int *pReset = ShareMemory + (lpos.x<<1);
	pReset[0] = 0;
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
	int4 bChange = pSceneChange[0];

	int4 SearchRange;
	SearchRange.xy = pixel_pos + mvstart.xy - (iRect.zw>>1);
	SearchRange.zw = pixel_pos + mvstart.xy + (iRect.zw>>1);

	bChange.x = bChange.x * bChange.y;
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

		if(bChange.x || mvbest.z == mvstart.z || mvbest.z<0x400)
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
		//mvbest.w = (loop<<8)+(a*2+1);
		mvbest.w = (a*2+1);

		mvbest.xy = mvbest.xy * (1-bChange.xx) + 255 * bChange.xx;
		//mvbest.z = bChange.x;
		write_imagei(pMv, gpos.zw, mvbest);
	}
}

#define READ_8PIXELS_FROM_IMAGE(p0, pSrc, sampler, pos, pos2)\
{\
	p0.lo = convert_int4(read_imageui(pSrc, sampler, pos));\
	p0.hi = convert_int4(read_imageui(pSrc, sampler, pos2));\
}


//Params	:
//  pSrc: intput frame
//	pDst: output frame
//	iRect: (x,y) resolution of current frame
//		   z is in range of [0, 4]
__kernel void KN_Denoise_AVG(__read_only image2d_t pSrc, __write_only image2d_t pDst, int4 iRect)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	__const int4 offset = {1, 2, 3, 0};
	__const int4 offset2= {1, 2, 3, -1};
	int2 gpos = {get_global_id(0), get_global_id(1)};

	int8 p0, p1, p2, p3, p4, p5;
	int4 q1, q2, q3;
	int4 param = iRect.zzzz * 12;

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
	int4 sad = 0, avg = 0;
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
	sad = convert_int4(CLAMP_BYTEU(tmp*3));

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

// 	avg = p0.lo + p0.hi + p1.lo + p1.hi + p2.lo + p2.hi + p3. lo + p3.hi + p4.lo + p4.hi + p5.lo + p5.hi + q1 + q2 + q3;
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


//Params	:
//  pSrc: intput frame
//	pRef: reference frame
//  pSad: output sad
//  pLds: sizeof(cl_int2)*get_local_size(0)*get_local_size(1)
//	iRect: (x,y) resolution of current frame
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


//Params	:
//  pSrcY, pSrcV, pSrcU: intput frame
//	pRefY, pRefV, pRefU: reference frame
//	pDstY, pDstV, pDstU: reference frame
//  pMv: pMv of KN_16x16FastIntegerPixelSearch_Atomic
//  pSad: pSad of KN_MBSAD
//	iRect: (x,y) resolution of current frame
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
	//sU = convert_int4(read_imageui(pSrcU, sampler, posC));
	//sV = convert_int4(read_imageui(pSrcV, sampler, posC));

	//{
		int4 a = (int4)(n1.w && (n2.x && !n1.y && !n1.z || n2.y && !n1.y || n2.z));
		int4 posY4 = posY * tmp.xyxy + (1-a)*mv.xyxy;
		int2 posC4 = posC.xy * tmp.xy + (1-a.xy)*mv.xy/2;
		rY0 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.xy);
		rY1 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.zy);
		rY2 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.xw);
		rY3 = _Read4PixelsFromAnyPos(pRefY, sampler, posY4.zw);
	//	rU = _Read4PixelsFromAnyPos(pRefU, sampler, posC4);
	//	rV = _Read4PixelsFromAnyPos(pRefV, sampler, posC4);
	//}

	//Y
	{
		m4 = -(!m1 && !m2 && !m3);
		//dY1 = _Denoise_Y_1(sY0, rY0, paramY);
		//dY2 = _Denoise_Y_2(sY0, rY0, paramY);
		//dY3 = _Denoise_Y_3(sY0, rY0, paramY);
		int4 diff = convert_int4(abs(sY0-rY0));
		int4 a1 = -(diff > 0x20);
		int4 b1 = (diff <=0x20);
		int4 c1 = (diff <= 8);
		int4 a = a1*sY0;
		int4 b = -(b1 && diff > 0x8);
		int4 c = -c1;
		int4 d = AVG(sY0, rY0);
		int4 ParamMin = sY0 - paramY;
		int4 ParamMax = sY0 + paramY;


		//dY1 = a * sY0 + b * ((sY0*3+rY0+2)>>2) + c * AVG(sY0, rY0);
		dY1 = a  + b * ((sY0*3+rY0+2)>>2) + c * d;
		dY1 = clamp(dY1, ParamMin, ParamMax);

		b = -(b1 && diff > 0x8 || diff<=0x8 && sY0<0x18);
		c = -(c1 && sY0 >= 0x18);

		//dY2 = a * sY0 + b * AVG(sY0, rY0) + c * ((sY0+rY0*3+2)>>2);
		dY2 = a  + b * d + c * ((sY0+rY0*3+2)>>2);
		dY2 = clamp(dY2, ParamMin, ParamMax);

		b = -(b1 && diff > 0x10 || diff<=0x10 && sY0<0x18);
		c = -(diff <=0x10 && sY0 >= 0x18);
		dY3 = a  + b * d + c * ((sY0+rY0*7+4)>>3);
		dY3 = clamp(dY3, ParamMin, ParamMax);

		ddY0 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY0;
		ddY0 = m0 * sY0 + (1-m0) * ddY0;

		write_imageui(pDstY, posY.xy, convert_uint4(ddY0));

		//dY1 = _Denoise_Y_1(sY1, rY1, paramY);
		//dY2 = _Denoise_Y_2(sY1, rY1, paramY);
		//dY3 = _Denoise_Y_3(sY1, rY1, paramY);
		diff = convert_int4(abs(sY1-rY1));
		a1 = -(diff > 0x20);
		b1 = (diff <=0x20);
		c1 = (diff <= 8);
		a = a1*sY1;
		b = -(b1 && diff > 0x8);
		c = -c1;
		d = AVG(sY1, rY1);
		ParamMin = sY1 - paramY;
		ParamMax = sY1 + paramY;


		//dY1 = a * sY1 + b * ((sY1*3+rY1+2)>>2) + c * AVG(sY1, rY1);
		dY1 = a  + b * ((sY1*3+rY1+2)>>2) + c * d;
		dY1 = clamp(dY1, ParamMin, ParamMax);

		b = -(b1 && diff > 0x8 || diff<=0x8 && sY1<0x18);
		c = -(c1 && sY1 >= 0x18);

		//dY2 = a * sY3 + b * AVG(sY1, rY1) + c * ((sY1+rY1*3+2)>>2);
		dY2 = a  + b * d + c * ((sY1+rY1*3+2)>>2);
		dY2 = clamp(dY2, ParamMin, ParamMax);

		b = -(b1 && diff > 0x10 || diff<=0x10 && sY1<0x18);
		c = -(diff <=0x10 && sY1 >= 0x18);
		dY3 = a  + b * d + c * ((sY1+rY1*7+4)>>3);
		dY3 = clamp(dY3, ParamMin, ParamMax);

		ddY1 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY1;
		ddY1 = m0 * sY1 + (1-m0) * ddY1;

		write_imageui(pDstY, posY.zy, convert_uint4(ddY1));

		//dY1 = _Denoise_Y_1(sY2, rY2, paramY);
		//dY2 = _Denoise_Y_2(sY2, rY2, paramY);
		//dY3 = _Denoise_Y_3(sY2, rY2, paramY);
		diff = convert_int4(abs(sY2-rY2));
		a1 = -(diff > 0x20);
		b1 = (diff <=0x20);
		c1 = (diff <= 8);
		a = a1*sY2;
		b = -(b1 && diff > 0x8);
		c = -c1;
		d = AVG(sY2, rY2);
		ParamMin = sY2 - paramY;
		ParamMax = sY2 + paramY;


		//dY1 = a * sY3 + b * ((sY2*3+rY2+2)>>2) + c * AVG(sY2, rY2);
		dY1 = a  + b * ((sY2*3+rY2+2)>>2) + c * d;
		dY1 = clamp(dY1, ParamMin, ParamMax);

		b = -(b1 && diff > 0x8 || diff<=0x8 && sY2<0x18);
		c = -(c1 && sY2 >= 0x18);

		//dY2 = a * sY3 + b * AVG(sY2, rY2) + c * ((sY2+rY2*3+2)>>2);
		dY2 = a  + b * d + c * ((sY2+rY2*3+2)>>2);
		dY2 = clamp(dY2, ParamMin, ParamMax);

		b = -(b1 && diff > 0x10 || diff<=0x10 && sY2<0x18);
		c = -(diff <=0x10 && sY2 >= 0x18);
		dY3 = a  + b * d + c * ((sY2+rY2*7+4)>>3);
		dY3 = clamp(dY3, ParamMin, ParamMax);
		ddY2 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY2;
		ddY2 = m0 * sY2 + (1-m0) * ddY2;

		write_imageui(pDstY, posY.xw, convert_uint4(ddY2));

		//dY1 = _Denoise_Y_1(sY3, rY3, paramY);
		//dY2 = _Denoise_Y_2(sY3, rY3, paramY);
		//dY3 = _Denoise_Y_3(sY3, rY3, paramY);
		diff = convert_int4(abs(sY3-rY3));
		a1 = -(diff > 0x20);
		b1 = (diff <=0x20);
		c1 = (diff <= 8);
		a = a1*sY3;
		b = -(b1 && diff > 0x8);
		c = -c1;
		d = AVG(sY3, rY3);
		ParamMin = sY3 - paramY;
		ParamMax = sY3 + paramY;


		dY1 = a  + b * ((sY3*3+rY3+2)>>2) + c * d;
		dY1 = clamp(dY1, ParamMin, ParamMax);

		b = -(b1 && diff > 0x8 || diff<=0x8 && sY3<0x18);
		c = -(c1 && sY3 >= 0x18);

		//dY2 = a * sY3 + b * AVG(sY3, rY3) + c * ((sY3+rY3*3+2)>>2);
		dY2 = a  + b * d + c * ((sY3+rY3*3+2)>>2);
		dY2 = clamp(dY2, ParamMin, ParamMax);

		b = -(b1 && diff > 0x10 || diff<=0x10 && sY3<0x18);
		c = -(diff <=0x10 && sY3 >= 0x18);
		dY3 = a  + b * d + c * ((sY3+rY3*7+4)>>3);
		dY3 = clamp(dY3, ParamMin, ParamMax);

		ddY3 = m1 * dY1 + m2 * dY2 + m3 * dY3 + m4 * sY3;
		ddY3 = m0 * sY3 + (1-m0) * ddY3;

		write_imageui(pDstY, posY.zw, convert_uint4(ddY3));
	}
	sU = convert_int4(read_imageui(pSrcU, sampler, posC));
	sV = convert_int4(read_imageui(pSrcV, sampler, posC));
	rU = _Read4PixelsFromAnyPos(pRefU, sampler, posC4);
	rV = _Read4PixelsFromAnyPos(pRefV, sampler, posC4);
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

		//dU1 = _Denoise_UV_1(sU, rU, paramC);
		//dU2 = _Denoise_UV_2(sU, rU, paramC);
		//dU3 = _Denoise_UV_3(sU, rU, paramC);
		//dU4 = _Denoise_UV_4(sU, rU, paramC);
		int4 diff = convert_int4(abs(sU-rU));
		int4 a = -(diff > 0x20);
		int4 b = -(diff <=0x20 && diff > 0x8);
		int4 c = -(diff <= 0x8);
		int4 d = AVG(sU, rU);
		int4 ParamMin = sU-paramC;
		int4 ParamMax = sU+paramC;

		a = a*sU;
		dU1 = a + b * ((sU*3+rU+2)>>2) + c * d;
		dU1 = clamp(dU1, ParamMin, ParamMax);

		dU2 = a + b * d + c * ((sU+rU*3+2)>>2);
		dU2 = clamp(dU2, ParamMin, ParamMax);

		dU3 = a + b * ((sU+rU*7+4)>>3) + c * ((sU+rU*15+8)>>4);
		dU3 = clamp(dU3, ParamMin, ParamMax);

		dU4 = a + b * ((sU+rU*3+2)>>2) + c * ((sU+rU*7+4)>>3);
		dU4 = clamp(dU4, ParamMin, ParamMax);

		//dV1 = _Denoise_UV_1(sV, rV, paramC);
		//dV2 = _Denoise_UV_2(sV, rV, paramC);
		//dV3 = _Denoise_UV_3(sV, rV, paramC);
		//dV4 = _Denoise_UV_4(sV, rV, paramC);
		diff = convert_int4(abs(sV-rV));
		a = -(diff > 0x20);
		b = -(diff <=0x20 && diff > 0x8);
		c = -(diff <= 0x8);
		d = AVG(sV, rV);
		ParamMin = sV-paramC;
		ParamMax = sV+paramC;

		a = a*sV;
		dV1 = a + b * ((sV*3+rV+2)>>2) + c * d;
		dV1 = clamp(dV1, ParamMin, ParamMax);

		dV2 = a + b * d + c * ((sV+rV*3+2)>>2);
		dV2 = clamp(dV2, ParamMin, ParamMax);

		dV3 = a + b * ((sV+rV*7+4)>>3) + c * ((sV+rV*15+8)>>4);
		dV3 = clamp(dV3, ParamMin, ParamMax);

		dV4 = a + b * ((sV+rV*3+2)>>2) + c * ((sV+rV*7+4)>>3);
		dV4 = clamp(dV4, ParamMin, ParamMax);

		dU = m1 * dU1 + m2 * dU2 + m3 * dU3 + m4 * dU4 + m5 * sU;
		dV = m1 * dV1 + m2 * dV2 + m3 * dV3 + m4 * dV4 + m5 * sV;
		dU = m0 * sU + (1-m0) * dU;
		dV = m0 * sV + (1-m0) * dV;
	}

	write_imageui(pDstU, posC, convert_uint4(dU));
	write_imageui(pDstV, posC, convert_uint4(dV));
}



//Params	:
//  pSrcY, pSrcV, pSrcU: intput frame
//	pRefY, pRefV, pRefU: reference frame
//	pDstY, pDstV, pDstU: output frame
//	iRect: (x,y) resolution of current frame
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

	dY0 = (max((sY0<<8)+(rY0-sY0)*iRect.z, (int4)0))>>8;
	dY1 = (max((sY1<<8)+(rY1-sY1)*iRect.z, (int4)0))>>8;
	dY2 = (max((sY2<<8)+(rY2-sY2)*iRect.z, (int4)0))>>8;
	dY3 = (max((sY3<<8)+(rY3-sY3)*iRect.z, (int4)0))>>8;
	dU = (max((sU<<8)+(rU-sU)*iRect.z, (int4)0))>>8;
	dV = (max((sV<<8)+(rV-sV)*iRect.z, (int4)0))>>8;

	write_imageui(pDstY, posY.xy, convert_uint4(dY0));
	write_imageui(pDstY, posY.zy, convert_uint4(dY1));
	write_imageui(pDstY, posY.xw, convert_uint4(dY2));
	write_imageui(pDstY, posY.zw, convert_uint4(dY3));
	write_imageui(pDstU, posC, convert_uint4(dU));
	write_imageui(pDstV, posC, convert_uint4(dV));
}

//This function is used to process frame which format is YUV444, parameters are the same as KN_Denoise_Main_YV12,
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

//This function is used to process frame which format is YUV444, parameters are the same as KN_Denoise_PostProc_YV12,
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

	dY = (max((sY<<8)+(rY-sY)*iRect.z, (int4)0))>>8;
	dU = (max((sU<<8)+(rU-sU)*iRect.z, (int4)0))>>8;
	dV = (max((sV<<8)+(rV-sV)*iRect.z, (int4)0))>>8;

	write_imageui(pDstY, pos, convert_uint4(dY));
	write_imageui(pDstU, pos, convert_uint4(dU));
	write_imageui(pDstV, pos, convert_uint4(dV));
}

//------------------------------------------------------------------------
//		DeShaky
//------------------------------------------------------------------------
__kernel void KN_Histogram_1x3(__read_only image2d_t pSrc, __global int* gHist, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int2 lpos = {get_local_id(0), get_local_id(1)};
	int2 bpos = {get_group_id(0), get_group_id(1)};
	int4 stride = {get_local_size(0), get_local_size(1), 0, 0};
	int2 spos1 = {bpos.x*stride.x+lpos.x, bpos.y*(stride.y<<2)+lpos.y};
	int4 spos2 = {spos1.x, spos1.y+stride.y, spos1.y+(stride.y<<1), spos1.y+stride.y*3};
	int level = (lpos.y<<4)+lpos.x;

	__local int lShareMem[257];
	__local int *plSrcHist = lShareMem;

	plSrcHist[level]=0;
	plSrcHist[level+1]=0;
	barrier(CLK_LOCAL_MEM_FENCE);

	int4 s0 = (convert_int4)(read_imageui(pSrc, sampler, spos1.xy));
	int4 s1 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xy));
	int4 s2 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xz));

	int4 bAvail=(int4)0;
	bAvail.x = spos1.x<iSize.x;

	bAvail.y = bAvail.x && spos2.y<iSize.y;
	bAvail.z = bAvail.x && spos2.z<iSize.y;
	bAvail.w = bAvail.x && spos2.w<iSize.y;
	bAvail.x = bAvail.x && spos1.y<iSize.y;
	bAvail = -bAvail;

	s0 = CHOOSE_1IN2(bAvail.xxxx, s0, 256);
	s1 = CHOOSE_1IN2(bAvail.yyyy, s1, 256);
	s2 = CHOOSE_1IN2(bAvail.zzzz, s2, 256);

	ATOMIC_INC_VECTOR(plSrcHist, s0);
	ATOMIC_INC_VECTOR(plSrcHist, s1);
	ATOMIC_INC_VECTOR(plSrcHist, s2);

	barrier(CLK_LOCAL_MEM_FENCE);

	int bidx = bpos.y*get_num_groups(0)+bpos.x;
	int hpos = (bidx<<8);

	gHist[hpos + level] = plSrcHist[level];

}

__kernel void KN_Histogram_1x4(__read_only image2d_t pSrc, __global int* gHist, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int2 lpos = {get_local_id(0), get_local_id(1)};
	int2 bpos = {get_group_id(0), get_group_id(1)};
	int4 stride = {get_local_size(0), get_local_size(1), 0, 0};
	int2 spos1 = {bpos.x*stride.x+lpos.x, bpos.y*(stride.y<<2)+lpos.y};
	int4 spos2 = {spos1.x, spos1.y+stride.y, spos1.y+(stride.y<<1), spos1.y+stride.y*3};
	int level = (lpos.y<<4)+lpos.x;

	__local int lShareMem[257];
	__local int *plSrcHist = lShareMem;

	plSrcHist[level]=0;
	plSrcHist[level+1]=0;
	barrier(CLK_LOCAL_MEM_FENCE);

	int4 s0 = (convert_int4)(read_imageui(pSrc, sampler, spos1.xy));
	int4 s1 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xy));
	int4 s2 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xz));
	int4 s3 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xw));
	int4 bAvail=(int4)0;
	bAvail.x = spos1.x<iSize.x;

	bAvail.y = bAvail.x && spos2.y<iSize.y;
	bAvail.z = bAvail.x && spos2.z<iSize.y;
	bAvail.w = bAvail.x && spos2.w<iSize.y;
	bAvail.x = bAvail.x && spos1.y<iSize.y;
	bAvail = -bAvail;

	s0 = CHOOSE_1IN2(bAvail.xxxx, s0, 256);
	s1 = CHOOSE_1IN2(bAvail.yyyy, s1, 256);
	s2 = CHOOSE_1IN2(bAvail.zzzz, s2, 256);
	s3 = CHOOSE_1IN2(bAvail.wwww, s3, 256);

	ATOMIC_INC_VECTOR(plSrcHist, s0);
	ATOMIC_INC_VECTOR(plSrcHist, s1);
	ATOMIC_INC_VECTOR(plSrcHist, s2);
	ATOMIC_INC_VECTOR(plSrcHist, s3);

	barrier(CLK_LOCAL_MEM_FENCE);

	int bidx = bpos.y*get_num_groups(0)+bpos.x;
	int hpos = (bidx<<8);

	gHist[hpos + level] = plSrcHist[level];

}

__kernel void KN_Histogram_2x4(__read_only image2d_t pSrc, __global int* gHist, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int2 lpos = {get_local_id(0), get_local_id(1)};
	int2 bpos = {get_group_id(0), get_group_id(1)};
	int4 stride = {get_local_size(0), get_local_size(1), 0, 0};
	int2 gpos = {bpos.x*stride.x*2+lpos.x, bpos.y*(stride.y<<2)+lpos.y};
	int4 spos0 = {gpos.x, gpos.y, gpos.x+stride.x, gpos.y};
	int4 spos1 = {spos0.x, spos0.y+stride.y, spos0.y+(stride.y<<1), spos0.y+stride.y*3};
	int4 spos2 = {spos0.z, spos0.y+stride.y, spos0.y+(stride.y<<1), spos0.y+stride.y*3};
	int level = (lpos.y<<4)+lpos.x;

	__local int lShareMem[257];
	__local int *plSrcHist = lShareMem;

	plSrcHist[level]=0;
	plSrcHist[level+1]=0;
	barrier(CLK_LOCAL_MEM_FENCE);

	int4 s0 = (convert_int4)(read_imageui(pSrc, sampler, spos0.xy));
	int4 s1 = (convert_int4)(read_imageui(pSrc, sampler, spos1.xy));
	int4 s2 = (convert_int4)(read_imageui(pSrc, sampler, spos1.xz));
	int4 s3 = (convert_int4)(read_imageui(pSrc, sampler, spos1.xw));
	int4 t0 = (convert_int4)(read_imageui(pSrc, sampler, spos0.zw));
	int4 t1 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xy));
	int4 t2 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xz));
	int4 t3 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xw));

	int4 bAvail=(int4)0, bAvail2 = (int4)0;
	bAvail.x = spos0.x<iSize.x;
	bAvail2.x = spos0.z<iSize.x;

	bAvail.y = bAvail.x && spos1.y<iSize.y;
	bAvail.z = bAvail.x && spos1.z<iSize.y;
	bAvail.w = bAvail.x && spos1.w<iSize.y;
	bAvail.x = bAvail.x && spos0.y<iSize.y;
	bAvail2.y = bAvail2.x && spos2.y<iSize.y;
	bAvail2.z = bAvail2.x && spos2.z<iSize.y;
	bAvail2.w = bAvail2.x && spos2.w<iSize.y;
	bAvail2.x = bAvail2.x && spos0.y<iSize.y;
	bAvail = -bAvail;
	bAvail2 = -bAvail2;

	s0 = CHOOSE_1IN2(bAvail.xxxx, s0, 256);
	s1 = CHOOSE_1IN2(bAvail.yyyy, s1, 256);
	s2 = CHOOSE_1IN2(bAvail.zzzz, s2, 256);
	s3 = CHOOSE_1IN2(bAvail.wwww, s3, 256);
	t0 = CHOOSE_1IN2(bAvail2.xxxx, t0, 256);
	t1 = CHOOSE_1IN2(bAvail2.yyyy, t1, 256);
	t2 = CHOOSE_1IN2(bAvail2.zzzz, t2, 256);
	t3 = CHOOSE_1IN2(bAvail2.wwww, t3, 256);

	ATOMIC_INC_VECTOR(plSrcHist, s0);
	ATOMIC_INC_VECTOR(plSrcHist, s1);
	ATOMIC_INC_VECTOR(plSrcHist, s2);
	ATOMIC_INC_VECTOR(plSrcHist, s3);

	ATOMIC_INC_VECTOR(plSrcHist, t0);
	ATOMIC_INC_VECTOR(plSrcHist, t1);
	ATOMIC_INC_VECTOR(plSrcHist, t2);
	ATOMIC_INC_VECTOR(plSrcHist, t3);

	barrier(CLK_LOCAL_MEM_FENCE);

	int bidx = bpos.y*get_num_groups(0)+bpos.x;
	int hpos = (bidx<<8);

	gHist[hpos + level] = plSrcHist[level];

}

__kernel void KN_Histogram_2x5(__read_only image2d_t pSrc, __global int* gHist, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;

	int2 lpos = {get_local_id(0), get_local_id(1)};
	int2 bpos = {get_group_id(0), get_group_id(1)};
	int4 stride = {get_local_size(0), get_local_size(1), 0, 0};
	int2 gpos = {bpos.x*stride.x*2+lpos.x, bpos.y*(stride.y*5)+lpos.y};
	int4 spos0 = {gpos.x, gpos.y, gpos.x+stride.x, gpos.y+stride.y*4};
	int4 spos1 = {spos0.x, spos0.y+stride.y, spos0.y+(stride.y<<1), spos0.y+stride.y*3};
	int4 spos2 = {spos0.z, spos0.y+stride.y, spos0.y+(stride.y<<1), spos0.y+stride.y*3};
	int level = (lpos.y<<4)+lpos.x;

	__local int lShareMem[257];
	__local int *plSrcHist = lShareMem;

	plSrcHist[level]=0;
	plSrcHist[level+1]=0;
	barrier(CLK_LOCAL_MEM_FENCE);

	int4 s0 = (convert_int4)(read_imageui(pSrc, sampler, spos0.xy));
	int4 s1 = (convert_int4)(read_imageui(pSrc, sampler, spos1.xy));
	int4 s2 = (convert_int4)(read_imageui(pSrc, sampler, spos1.xz));
	int4 s3 = (convert_int4)(read_imageui(pSrc, sampler, spos1.xw));
	int4 s4 = (convert_int4)(read_imageui(pSrc, sampler, spos0.xw));
	int4 t0 = (convert_int4)(read_imageui(pSrc, sampler, spos0.zy));
	int4 t1 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xy));
	int4 t2 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xz));
	int4 t3 = (convert_int4)(read_imageui(pSrc, sampler, spos2.xw));
	int4 t4 = (convert_int4)(read_imageui(pSrc, sampler, spos0.zw));

	int4 bAvail=(int4)0, bAvail2 = (int4)0, bAvail3=(int4)0;
	bAvail.x = spos0.x<iSize.x;
	bAvail2.x = spos0.z<iSize.x;

	bAvail.y = bAvail.x && spos1.y<iSize.y;
	bAvail.z = bAvail.x && spos1.z<iSize.y;
	bAvail.w = bAvail.x && spos1.w<iSize.y;
	bAvail3.x = bAvail.x&& spos0.w<iSize.y;

	bAvail.x = bAvail.x && spos0.y<iSize.y;
	bAvail2.y = bAvail2.x && spos2.y<iSize.y;
	bAvail2.z = bAvail2.x && spos2.z<iSize.y;
	bAvail2.w = bAvail2.x && spos2.w<iSize.y;
	bAvail2.x = bAvail2.x && spos0.y<iSize.y;
	bAvail3.y = bAvail2.x && spos0.w<iSize.y;
	bAvail = - bAvail;
	bAvail2 = -bAvail2;
	bAvail3 = -bAvail3;

	s0 = CHOOSE_1IN2(bAvail.xxxx, s0, 256);
	s1 = CHOOSE_1IN2(bAvail.yyyy, s1, 256);
	s2 = CHOOSE_1IN2(bAvail.zzzz, s2, 256);
	s3 = CHOOSE_1IN2(bAvail.wwww, s3, 256);
	s4 = CHOOSE_1IN2(bAvail3.xxxx, s4, 256);
	t0 = CHOOSE_1IN2(bAvail2.xxxx, t0, 256);
	t1 = CHOOSE_1IN2(bAvail2.yyyy, t1, 256);
	t2 = CHOOSE_1IN2(bAvail2.zzzz, t2, 256);
	t3 = CHOOSE_1IN2(bAvail2.wwww, t3, 256);
	t4 = CHOOSE_1IN2(bAvail3.yyyy, t4, 256);

	ATOMIC_INC_VECTOR(plSrcHist, s0);
	ATOMIC_INC_VECTOR(plSrcHist, s1);
	ATOMIC_INC_VECTOR(plSrcHist, s2);
	ATOMIC_INC_VECTOR(plSrcHist, s3);
	ATOMIC_INC_VECTOR(plSrcHist, s4);

	ATOMIC_INC_VECTOR(plSrcHist, t0);
	ATOMIC_INC_VECTOR(plSrcHist, t1);
	ATOMIC_INC_VECTOR(plSrcHist, t2);
	ATOMIC_INC_VECTOR(plSrcHist, t3);
	ATOMIC_INC_VECTOR(plSrcHist, t4);

	barrier(CLK_LOCAL_MEM_FENCE);

	int bidx = bpos.y*get_num_groups(0)+bpos.x;
	int hpos = (bidx<<8);

	gHist[hpos + level] = plSrcHist[level];

}


// 	iSize.xy: (w, h)
// 	iSize.z: the number of elements need to be processed
//
// 	group size: 16x16
__kernel void KN_IsSceneChange_3x3(__read_only image2d_t pMBSad, __global int *pSrcHist, __global int *pRefHist,
								   __global int4 *pFlag, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR;

	int4 lStride = {get_local_size(0), get_local_size(1), 256, 0};
	int4 lpos1 = {get_local_id(0), get_local_id(0)+lStride.x, get_local_id(0)+lStride.x*2, get_local_id(1)};
	int4 lpos2=lpos1, lpos3=lpos1;
	int level = lpos1.w*lStride.y+lpos1.x;

	__local int lFrameSad[2];
	int4 sad=0;

	lpos2.w = lpos1.w + lStride.y;
	lpos3.w = lpos1.w + lStride.y*2;
	lFrameSad[level%2]=0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 hpos1 = {level, level+lStride.z, level+lStride.z*2, level+lStride.z*3};
	int4 hpos2 = hpos1 + lStride.z*4;
	int4 hpos3 = hpos2 + lStride.z*4;
	int4 sh0, sh1, rh0, rh1;
	int4 sad0, sad1, sad2, sad3, sad4, sad5, sad6, sad7, sad8;
	int sh2, rh2;
	int4 bA0, bA1, bA2;

	sad0 = read_imagei(pMBSad, sampler, lpos1.xw);
	sad1 = read_imagei(pMBSad, sampler, lpos1.yw);
	sad2 = read_imagei(pMBSad, sampler, lpos1.zw);
	sad3 = read_imagei(pMBSad, sampler, lpos2.xw);
	sad4 = read_imagei(pMBSad, sampler, lpos2.yw);
	sad5 = read_imagei(pMBSad, sampler, lpos2.zw);
	sad6 = read_imagei(pMBSad, sampler, lpos3.xw);
	sad7 = read_imagei(pMBSad, sampler, lpos3.yw);
	sad8 = read_imagei(pMBSad, sampler, lpos3.zw);


	sad0.x = sad0.x;
	sad0.y = sad1.x;
	sad0.z = sad2.x;
	sad1.x = sad3.x;
	sad1.y = sad4.x;
	sad1.z = sad5.x;
	sad2.x = sad6.x;
	sad2.y = sad7.x;
	sad2.z = sad8.x;

	sh0.x = pSrcHist[hpos1.x];
	sh0.y = pSrcHist[hpos1.y];
	sh0.z = pSrcHist[hpos1.z];
	sh0.w = pSrcHist[hpos1.w];
	rh0.x = pRefHist[hpos1.x];
	rh0.y = pRefHist[hpos1.y];
	rh0.z = pRefHist[hpos1.z];
	rh0.w = pRefHist[hpos1.w];
	sh1.x = pSrcHist[hpos2.x];
	sh1.y = pSrcHist[hpos2.y];
	sh1.z = pSrcHist[hpos2.z];
	sh1.w = pSrcHist[hpos2.w];
	rh1.x = pRefHist[hpos2.x];
	rh1.y = pRefHist[hpos2.y];
	rh1.z = pRefHist[hpos2.z];
	rh1.w = pRefHist[hpos2.w];

	sh2 = pSrcHist[hpos3.x];
	rh2 = pRefHist[hpos3.x];

	bA0.xyz = -(lpos1.xyz<iSize.xxx && lpos1.www<iSize.yyy);
	bA1.xyz = -(lpos2.xyz<iSize.xxx && lpos2.www<iSize.yyy);
	bA2.xyz = -(lpos3.xyz<iSize.xxx && lpos3.www<iSize.yyy);

	SUM_V4(sh0, sh0.x);
	SUM_V4(rh0, rh0.x);
	SUM_V4(sh1, sh1.x);
	SUM_V4(rh1, rh1.x);

	sad0.xyz = sad0.xyz * bA0.xyz;
	sad1.xyz = sad1.xyz * bA1.xyz;
	sad2.xyz = sad2.xyz * bA2.xyz;

	sh2 = sh2 + sh0.x + sh1.x;
	rh2 = rh2 + rh0.x + rh1.x;
	sad0 = sad0 + sad1 + sad2;

	sh2 = (int)abs(rh2-sh2);
	sad0.y = sad0.x + sad0.y + sad0.z;

	atomic_add(lFrameSad, sh2);
	atomic_add(lFrameSad+1, sad0.y);

	barrier(CLK_LOCAL_MEM_FENCE);

	int2 THRESHOLD = {0x23, 0x708};
	int4 flag = pFlag[level];

	sad.x = lFrameSad[0];	//Histogram diff
	sad.y = lFrameSad[1];	//Frame sad

	//Sad.z = HistDiff*16/(uiWidth*uiHeight)
	//Sad.w = FrameSad/(uiWidth*uiHeight);
	//if(FrameSad < 0x23) return 0
	//if(FrameSad*HistDiff*0x640/(uiWidth*uiHeight) <= 0x708) return 0;
	sad.x = (sad.x<<4);
	sad.zw = sad.xy/iSize.z;

	sad.x = sad.z*sad.w*100;

	sad.xy = sad.wx>THRESHOLD;
	sad.x = -(sad.x&sad.y);		//bSceneChange

	flag.x = sad.x*iSize.w + flag.x * (1-iSize.w);
	flag.y = (1-iSize.w)*sad.x;

	pFlag[level] = flag;
}

/*
	iSize.xy: (w, h)
	iSize.z: the number of elements need to be processed

	group size: 16x16
	read 5x3 of sad and 3x3 of histogram per thread

*/
__kernel void KN_IsSceneChange_5x3(__read_only image2d_t pMBSad, __global int *pSrcHist, __global int *pRefHist,
								   __global int4 *pFlag, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR;

	int4 lStride = {get_local_size(0), get_local_size(1), 256, 0};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int level = lpos.y*lStride.x+lpos.x;
	int8 lpos8 = {lpos.x, lpos.x+lStride.x, lpos.x+lStride.x*2, lpos.x+lStride.x*3, lpos.x+lStride.x*4, lpos.y, lpos.y+lStride.y, lpos.y+lStride.y*2};

	__local int lFrameSad[2];
	int4 sad=0;

	lFrameSad[level%2]=0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 hpos1 = {level, level+lStride.z, level+lStride.z*2, level+lStride.z*3};
	int4 hpos2 = hpos1 + lStride.z*4;
	int4 hpos3 = hpos2 + lStride.z*4;
	int4 sh0, sh1, rh0, rh1;
	int4 sad0, sad1, sad2, sad3, sad4, sad5, sad6, sad7, sad8, sad9, sad10, sad11, sad12, sad13, sad14;
	int sh2, rh2;
	int16 sad16=(int16)0, bA16;

	sad0 = read_imagei(pMBSad, sampler, lpos8.s05);
	sad1 = read_imagei(pMBSad, sampler, lpos8.s15);
	sad2 = read_imagei(pMBSad, sampler, lpos8.s25);
	sad3 = read_imagei(pMBSad, sampler, lpos8.s35);
	sad4 = read_imagei(pMBSad, sampler, lpos8.s45);
	sad5 = read_imagei(pMBSad, sampler, lpos8.s06);
	sad6 = read_imagei(pMBSad, sampler, lpos8.s16);
	sad7 = read_imagei(pMBSad, sampler, lpos8.s26);
	sad8 = read_imagei(pMBSad, sampler, lpos8.s36);
	sad9 = read_imagei(pMBSad, sampler, lpos8.s46);
	sad10 = read_imagei(pMBSad, sampler, lpos8.s07);
	sad11 = read_imagei(pMBSad, sampler, lpos8.s17);
	sad12 = read_imagei(pMBSad, sampler, lpos8.s27);
	sad13 = read_imagei(pMBSad, sampler, lpos8.s37);
	sad14 = read_imagei(pMBSad, sampler, lpos8.s47);

	sad16.s0 = sad0.x;
	sad16.s1 = sad1.x;
	sad16.s2 = sad2.x;
	sad16.s3 = sad3.x;
	sad16.s4 = sad4.x;
	sad16.s5 = sad5.x;
	sad16.s6 = sad6.x;
	sad16.s7 = sad7.x;
	sad16.s8 = sad8.x;
	sad16.s9 = sad9.x;
	sad16.sa = sad10.x;
	sad16.sb = sad11.x;
	sad16.sc = sad12.x;
	sad16.sd = sad13.x;
	sad16.se = sad14.x;

	sh0.x = pSrcHist[hpos1.x];
	sh0.y = pSrcHist[hpos1.y];
	sh0.z = pSrcHist[hpos1.z];
	sh0.w = pSrcHist[hpos1.w];
	rh0.x = pRefHist[hpos1.x];
	rh0.y = pRefHist[hpos1.y];
	rh0.z = pRefHist[hpos1.z];
	rh0.w = pRefHist[hpos1.w];
	sh1.x = pSrcHist[hpos2.x];
	sh1.y = pSrcHist[hpos2.y];
	sh1.z = pSrcHist[hpos2.z];
	sh1.w = pSrcHist[hpos2.w];
	rh1.x = pRefHist[hpos2.x];
	rh1.y = pRefHist[hpos2.y];
	rh1.z = pRefHist[hpos2.z];
	rh1.w = pRefHist[hpos2.w];

	sh2 = pSrcHist[hpos3.x];
	rh2 = pRefHist[hpos3.x];

	bA16.s0123 = -(lpos8.s0123<iSize.xxxx & lpos8.s5555<iSize.yyyy);
	bA16.s4567 = -(lpos8.s4012<iSize.xxxx & lpos8.s5666<iSize.yyyy);
	bA16.s89ab = -(lpos8.s3401<iSize.xxxx & lpos8.s6677<iSize.yyyy);
	bA16.scdef = -(lpos8.s2344<iSize.xxxx & lpos8.s7777<iSize.yyyy);

	SUM_V4(sh0, sh0.x);
	SUM_V4(rh0, rh0.x);
	SUM_V4(sh1, sh1.x);
	SUM_V4(rh1, rh1.x);

	sad16 = sad16 * bA16;

	sh2 = sh2 + sh0.x + sh1.x;
	rh2 = rh2 + rh0.x + rh1.x;
	sad16.lo = sad16.lo+sad16.hi;

	sh2 = (int)abs(rh2-sh2);
	sad16.lo.lo = sad16.lo.lo + sad16.lo.hi;
	sad16.s0 = sad16.s0 + sad16.s1 + sad16.s2 + sad16.s3;

	atomic_add(lFrameSad, sh2);
	atomic_add(lFrameSad+1, sad16.s0);

	barrier(CLK_LOCAL_MEM_FENCE);

	int2 THRESHOLD = {0x23, 0x708};
	int4 flag = pFlag[level];

	sad.x = lFrameSad[0];	//Histogram diff
	sad.y = lFrameSad[1];	//Frame sad

	//Sad.z = HistDiff*16/(uiWidth*uiHeight)
	//Sad.w = FrameSad/(uiWidth*uiHeight);
	//if(FrameSad < 0x23) return 0
	//if(FrameSad*HistDiff*0x640/(uiWidth*uiHeight) <= 0x708) return 0;
	sad.x = (sad.x<<4);
	sad.zw = sad.xy/iSize.z;

	sad.x = sad.z*sad.w*100;

	sad.xy = sad.wx>THRESHOLD;
	sad.x = -(sad.x&sad.y);		//bSceneChange

	flag.x = sad.x*iSize.w + flag.x * (1-iSize.w);
	flag.y = (1-iSize.w)*sad.x;

#if 0	//for debug
	flag.z = lFrameSad[0]<<4;
	flag.w = lFrameSad[1];
#endif
	pFlag[level] = flag;
}

#define SCENECHANGE_6x1(s)\
{\
	sad0 = read_imagei(pMBSad, sampler, lpos8.s06);\
	sad1 = read_imagei(pMBSad, sampler, lpos8.s16);\
	sad2 = read_imagei(pMBSad, sampler, lpos8.s26);\
	sad3 = read_imagei(pMBSad, sampler, lpos8.s36);\
	sad4 = read_imagei(pMBSad, sampler, lpos8.s46);\
	sad5 = read_imagei(pMBSad, sampler, lpos8.s56);\
	s = sad0.x*bA8.s0 + sad1.x*bA8.s1 + sad2.x*bA8.s2 + sad3.x*bA8.s3 + sad4.x*bA8.s4 + sad5.x*bA8.s5;\
	lpos8.s6 += lStride.y;\
	lpos8.s7 += lStride.y;\
}


/*
	iSize.xy: (w, h)
	iSize.z: the number of elements need to be processed

	group size: 16x16
	read 6x4 of sad and 3x4 of histogram per thread
*/

__kernel void KN_IsSceneChange_6x5(__read_only image2d_t pMBSad, __global int *pSrcHist, __global int *pRefHist,
								   __global int4 *pFlag, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR;

	int4 lStride = {get_local_size(0), get_local_size(1), 256, 0};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int level = lpos.y*lStride.x+lpos.x;
	int8 lpos8 = {lpos.x, lpos.x+lStride.x, lpos.x+lStride.x*2, lpos.x+lStride.x*3, lpos.x+lStride.x*4, lpos.x+lStride.x*5,
				  lpos.y, lpos.y+lStride.y};

	__local int lFrameSad[2];
	int4 sad=0;

	lFrameSad[level%2]=0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 hpos1 = {level, level+lStride.z, level+lStride.z*2, level+lStride.z*3};
	int4 hpos2 = hpos1 + lStride.z*4;
	int4 hpos3 = hpos2 + lStride.z*4;
	int4 sh0, sh1, rh0, rh1;
	int4 sad0, sad1, sad2, sad3, sad4, sad5;
	int4 sh2, rh2;
	int8 bA8;
	int8 bA0;

	bA0.s0123 = -(lpos8.s0123<iSize.xxxx);
	bA0.s4567 = -(lpos8.s4567<iSize.xxyy);

	bA8 = bA0 & bA0.s66666666;
	SCENECHANGE_6x1(sad.x);

	bA8 = bA0 & bA0.s77777777;
	SCENECHANGE_6x1(sad.y);

	bA0.s67 = lpos8.s67<iSize.yy;
	bA8 = bA0 & bA0.s66666666;
	SCENECHANGE_6x1(sad.z);

	bA8 = bA0 & bA0.s77777777;
	SCENECHANGE_6x1(sad.w);
	sad.xy = sad.xy + sad.zw;

	bA0.s67 = lpos8.s67<iSize.yy;
	bA8 = bA0 & bA0.s66666666;
	SCENECHANGE_6x1(sad.w);

	sh0.x = pSrcHist[hpos1.x];	sh0.y = pSrcHist[hpos1.y];	sh0.z = pSrcHist[hpos1.z];	sh0.w = pSrcHist[hpos1.w];
	sh1.x = pSrcHist[hpos2.x];	sh1.y = pSrcHist[hpos2.y];	sh1.z = pSrcHist[hpos2.z];	sh1.w = pSrcHist[hpos2.w];
	sh2.x = pSrcHist[hpos3.x]; 	sh2.y = pSrcHist[hpos3.y]; 	sh2.z = pSrcHist[hpos3.z]; 	sh2.w = pSrcHist[hpos3.w];

	rh0.x = pRefHist[hpos1.x];	rh0.y = pRefHist[hpos1.y];	rh0.z = pRefHist[hpos1.z];	rh0.w = pRefHist[hpos1.w];
	rh1.x = pRefHist[hpos2.x];	rh1.y = pRefHist[hpos2.y];	rh1.z = pRefHist[hpos2.z];	rh1.w = pRefHist[hpos2.w];
	rh2.x = pRefHist[hpos3.x];	rh2.y = pRefHist[hpos3.y];	rh2.z = pRefHist[hpos3.z];	rh2.w = pRefHist[hpos3.w];

	SUM_V4(sh0, sh0.x);
	SUM_V4(rh0, rh0.x);
	SUM_V4(sh1, sh1.x);
	SUM_V4(rh1, rh1.x);
	SUM_V4(sh2, sh2.x);
	SUM_V4(rh2, rh2.x);

	sh2.x = sh2.x + sh0.x + sh1.x;
	rh2.x = rh2.x + rh0.x + rh1.x;

	sh2.x = (int)abs(rh2.x-sh2.x);
	sad.x = sad.x + sad.y + sad.w;

	atomic_add(lFrameSad, sh2.x);
	atomic_add(lFrameSad+1, sad.x);

	barrier(CLK_LOCAL_MEM_FENCE);

	int2 THRESHOLD = {0x23, 0x708};
	int4 flag = pFlag[level];

	sad.x = lFrameSad[0];	//Histogram diff
	sad.y = lFrameSad[1];	//Frame sad

	//Sad.z = HistDiff*16/(uiWidth*uiHeight)
	//Sad.w = FrameSad/(uiWidth*uiHeight);
	//if(FrameSad < 0x23) return 0
	//if(FrameSad*HistDiff*0x640/(uiWidth*uiHeight) <= 0x708) return 0;
	sad.x = (sad.x<<4);
	sad.zw = sad.xy/iSize.z;

	sad.x = sad.z*sad.w*100;

	sad.xy = sad.wx>THRESHOLD;
	sad.x = -(sad.x&sad.y);		//bSceneChange

	flag.x = sad.x*iSize.w + flag.x * (1-iSize.w);
	flag.y = (1-iSize.w)*sad.x;

#if 0	//for debug
	flag.z = lFrameSad[0]<<4;
	flag.w = lFrameSad[1];
#endif
	pFlag[level] = flag;
}

#define SCENECHANGE_8x1(s)\
{\
	sad0 = read_imagei(pMBSad, sampler, lpos.xy);\
	sad1 = read_imagei(pMBSad, sampler, lpos8.s07);\
	sad2 = read_imagei(pMBSad, sampler, lpos8.s17);\
	sad3 = read_imagei(pMBSad, sampler, lpos8.s27);\
	sad4 = read_imagei(pMBSad, sampler, lpos8.s37);\
	sad5 = read_imagei(pMBSad, sampler, lpos8.s47);\
	sad6 = read_imagei(pMBSad, sampler, lpos8.s57);\
	sad7 = read_imagei(pMBSad, sampler, lpos8.s67);\
\
	s = sad0.x*bA8.s0 + sad1.x*bA8.s1 + sad2.x*bA8.s2 + sad3.x*bA8.s3 + sad4.x*bA8.s4 + sad5.x*bA8.s5 + sad6.x*bA8.s6 + sad7.x*bA8.s7;\
	lpos8.s7 += lStride.y;\
	lpos.y += lStride.y;\
}

/*
	iSize.xy: (w, h)
	iSize.z: the number of elements need to be processed

	group size: 16x16
	read 8x5 of sad and 4x4 of histogram per thread

*/
__kernel void KN_IsSceneChange_8x5(__read_only image2d_t pMBSad, __global int *pSrcHist, __global int *pRefHist,
								   __global int4 *pFlag, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR;

	int4 lStride = {get_local_size(0), get_local_size(1), 256, 0};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int level = lpos.y*lStride.x+lpos.x;
	int8 lpos8 = {lpos.x+lStride.x  , lpos.x+lStride.x*2, lpos.x+lStride.x*3, lpos.x+lStride.x*4, lpos.x+lStride.x*5,
				  lpos.x+lStride.x*6, lpos.x+lStride.x*7, lpos.y};

	__local int lFrameSad[2];
	int4 sad=0;

	lFrameSad[level%2]=0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 hpos1 = {level, level+lStride.z, level+lStride.z*2, level+lStride.z*3};
	int4 hpos2 = hpos1 + lStride.z*4;
	int4 hpos3 = hpos2 + lStride.z*4;
	int4 hpos4 = hpos3 + lStride.z*4;
	int4 sh0, sh1, rh0, rh1;
	int4 sh2, rh2, sh3, rh3;
	int4 sad0, sad1, sad2, sad3, sad4, sad5, sad6, sad7;
	int8 bA8;
	int8 bA0, bA1;

	bA0.s0 = lpos.x<iSize.x;
	bA0.s1234 = -(lpos8.s0123<iSize.xxxx);
	bA0.s567 = -(lpos8.s456<iSize.xxx);

	bA1.s0 = lpos.y<iSize.y;
	bA8 = bA0 & bA1.s00000000;
	SCENECHANGE_8x1(sad.x);

	bA1.s0 = lpos.y<iSize.y;
	bA8 = bA0 & bA1.s00000000;
	SCENECHANGE_8x1(sad.y);

	bA1.s0 = lpos.y<iSize.y;
	bA8 = bA0 & bA1.s00000000;
	SCENECHANGE_8x1(sad.z);

	bA1.s0 = lpos.y<iSize.y;
	bA8 = bA0 & bA1.s00000000;
	SCENECHANGE_8x1(sad.w);
	sad.x = sad.x + sad.y + sad.z + sad.w;

	bA1.s0 = lpos.y<iSize.y;
	bA8 = bA0 & bA1.s00000000;
	SCENECHANGE_8x1(sad.w);

	sh0.x = pSrcHist[hpos1.x];	sh0.y = pSrcHist[hpos1.y];	sh0.z = pSrcHist[hpos1.z];	sh0.w = pSrcHist[hpos1.w];
	sh1.x = pSrcHist[hpos2.x];	sh1.y = pSrcHist[hpos2.y];	sh1.z = pSrcHist[hpos2.z];	sh1.w = pSrcHist[hpos2.w];
	sh2.x = pSrcHist[hpos3.x]; 	sh2.y = pSrcHist[hpos3.y]; 	sh2.z = pSrcHist[hpos3.z]; 	sh2.w = pSrcHist[hpos3.w];
	sh3.x = pSrcHist[hpos4.x]; 	sh3.y = pSrcHist[hpos4.y]; 	sh3.z = pSrcHist[hpos4.z]; 	sh3.w = pSrcHist[hpos4.w];

	rh0.x = pRefHist[hpos1.x];	rh0.y = pRefHist[hpos1.y];	rh0.z = pRefHist[hpos1.z];	rh0.w = pRefHist[hpos1.w];
	rh1.x = pRefHist[hpos2.x];	rh1.y = pRefHist[hpos2.y];	rh1.z = pRefHist[hpos2.z];	rh1.w = pRefHist[hpos2.w];
	rh2.x = pRefHist[hpos3.x];	rh2.y = pRefHist[hpos3.y];	rh2.z = pRefHist[hpos3.z];	rh2.w = pRefHist[hpos3.w];
	rh3.x = pRefHist[hpos4.x];	rh3.y = pRefHist[hpos4.y];	rh3.z = pRefHist[hpos4.z];	rh3.w = pRefHist[hpos4.w];

	SUM_V4(sh0, sh0.x);
	SUM_V4(rh0, rh0.x);
	SUM_V4(sh1, sh1.x);
	SUM_V4(rh1, rh1.x);
	SUM_V4(sh2, sh2.x);
	SUM_V4(rh2, rh2.x);
	SUM_V4(sh3, sh3.x);
	SUM_V4(rh3, rh3.x);

	sh2.x = sh2.x + sh0.x + sh1.x + sh3.x;
	rh2.x = rh2.x + rh0.x + rh1.x + rh3.x;

	sad.x = sad.x + sad.w;
	sh2.x = (int)abs(rh2.x-sh2.x);

	atomic_add(lFrameSad, sh2.x);
	atomic_add(lFrameSad+1, sad.x);

	barrier(CLK_LOCAL_MEM_FENCE);

	int2 THRESHOLD = {0x23, 0x708};
	int4 flag = pFlag[level];

	sad.x = lFrameSad[0];	//Histogram diff
	sad.y = lFrameSad[1];	//Frame sad

	//Sad.z = HistDiff*16/(uiWidth*uiHeight)
	//Sad.w = FrameSad/(uiWidth*uiHeight);
	//if(FrameSad < 0x23) return 0
	//if(FrameSad*HistDiff*0x640/(uiWidth*uiHeight) <= 0x708) return 0;
	sad.x = (sad.x<<4);
	sad.zw = sad.xy/iSize.z;

	sad.x = sad.z*sad.w*100;

	sad.xy = sad.wx>THRESHOLD;
	sad.x = -(sad.x&sad.y);		//bSceneChange

	flag.x = sad.x*iSize.w + flag.x * (1-iSize.w);
	flag.y = (1-iSize.w)*sad.x;

#if 0	//for debug
	flag.z = lFrameSad[0]<<4;
	flag.w = lFrameSad[1];
#endif
	pFlag[level] = flag;
}

__kernel void KN_ResetFlag(__global int4 *pFlag)
{
	int pos = get_global_id(1) * get_global_size(0) + get_global_id(0);
	pFlag[pos] = (int4)0;
}

/*
	group size :	16x16
	group number:	1

	Parameters:
		iSize.x = MBW
		iSize.y = MBH
*/
__kernel void KN_SelectMvs_3x3(__read_only image2d_t pMv, __read_only image2d_t pMbSad, __write_only image2d_t pFavoriteMv, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;
	int2 lStride = {get_local_size(0), get_local_size(1)};
	int4 ipos0 = {get_local_id(0), get_local_id(1), get_local_id(1)+lStride.y, get_local_id(1)+lStride.y*2};
	int4 ipos1 = {ipos0.x+lStride.x, ipos0.y, ipos0.z, ipos0.w};
	int4 ipos2 = {ipos1.x+lStride.x, ipos0.y, ipos0.z, ipos0.w};

	__local int lSadMem[2];

	if(ipos0.x==0 && ipos0.y==0)
		lSadMem[0] = lSadMem[1] = 0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 v0 = read_imagei(pMv, sampler, ipos0.xy);
	int4 v1 = read_imagei(pMv, sampler, ipos0.xz);
	int4 v2 = read_imagei(pMv, sampler, ipos0.xw);
	int4 v3 = read_imagei(pMv, sampler, ipos1.xy);
	int4 v4 = read_imagei(pMv, sampler, ipos1.xz);
	int4 v5 = read_imagei(pMv, sampler, ipos1.xw);
	int4 v6 = read_imagei(pMv, sampler, ipos2.xy);
	int4 v7 = read_imagei(pMv, sampler, ipos2.xz);
	int4 v8 = read_imagei(pMv, sampler, ipos2.xw);
	int4 s0 = read_imagei(pMbSad, sampler, ipos0.xy);
	int4 s1 = read_imagei(pMbSad, sampler, ipos0.xz);
	int4 s2 = read_imagei(pMbSad, sampler, ipos0.xw);
	int4 s3 = read_imagei(pMbSad, sampler, ipos1.xy);
	int4 s4 = read_imagei(pMbSad, sampler, ipos1.xz);
	int4 s5 = read_imagei(pMbSad, sampler, ipos1.xw);
	int4 s6 = read_imagei(pMbSad, sampler, ipos2.xy);
	int4 s7 = read_imagei(pMbSad, sampler, ipos2.xz);
	int4 s8 = read_imagei(pMbSad, sampler, ipos2.xw);

	int sadsum=0;
	int sadnum=0;
	int4 bA0 = -(ipos0 >= 2 & ipos0 <(iSize.xyyy-2));
	int4 bA1 = -(ipos1 >= 2 & ipos1 <(iSize.xyyy-2));
	int4 bA2 = -(ipos2 >= 2 & ipos2 <(iSize.xyyy-2));
	int4 bF0, bF1, bF2=(int4)0;
	int4 sad0, sad1, sad2;

	INT4_TO_VECTOR(v0.w, v1.w, v2.w, v3.w, bF0);
	bA0.xyz = bA0.xxx & bA2.yzw;
	bA0.w = bA1.x & bA2.y;
	bF0 = -((bF0&2)==0);

	INT4_TO_VECTOR(v4.w, v5.w, v6.w, v7.w, bF1);
	bA1.xy = bA1.xx & bA2.zw;
	bA1.zw = bA2.xx & bA2.yz;
	bF1 = -((bF1&2)==0);
	//INT4_TO_VECTOR((v4.w&2)==0, (v5.w&2)==0, (v6.w&2)==0, (v7.w&2)==0, bF1);

	bA2.x = bA2.x & bA2.w;
	bF2.x = (v8.w&2)==0;

	bF0 = bF0 * bA0;
	bF1 = bF1 * bA1;
	bF2 = bF2 * bA2;

	INT4_TO_VECTOR(s0.y, s1.y, s2.y, s3.y, sad0);
	INT4_TO_VECTOR(s4.y, s5.y, s6.y, s7.y, sad1);
	sad2.x = s8.y;

	bA0 = bF0 + bF1 + bF2;

	bA1 = sad0 * bF0;
	bA2 = sad1 * bF1;
	sad2.w = sad2.x * bF2.x;

	SUM_V4(bA1, sad2.y);
	SUM_V4(bA2, sad2.z);

	SUM_V4(bA0, sadnum);

	sadsum = sad2.w + sad2.y + sad2.z;

	atomic_add(lSadMem, sadnum);
	atomic_add(lSadMem+1, sadsum);

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 sadavg;
	sadnum = lSadMem[0];
	sadsum = lSadMem[1];
	sadavg = (int4)(sadsum/sadnum);
	bA0 = -(sadavg<=sad0);
	bA1 = -(sadavg<=sad1);
	bA2.x = sadavg.x<=sad2.x;

	bF0 = bF0 * bA0;
	bF1 = bF1 * bA1;
	bF2 = bF2 * bA2;

	VECTOR_TO_4INT(bF0, v0.w, v1.w, v2.w, v3.w);
	VECTOR_TO_4INT(bF1, v4.w, v5.w, v6.w, v7.w);
	v8.w = bF2.x;

	write_imagei(pFavoriteMv, ipos0.xy, v0);
	write_imagei(pFavoriteMv, ipos0.xz, v1);
	write_imagei(pFavoriteMv, ipos0.xw, v2);
	write_imagei(pFavoriteMv, ipos1.xy, v3);
	write_imagei(pFavoriteMv, ipos1.xz, v4);
	write_imagei(pFavoriteMv, ipos1.xw, v5);
	write_imagei(pFavoriteMv, ipos2.xy, v6);
	write_imagei(pFavoriteMv, ipos2.xz, v7);
	write_imagei(pFavoriteMv, ipos2.xw, v8);
}

__kernel void KN_SelectMvs_5x3(__read_only image2d_t pMv, __read_only image2d_t pMbSad, __write_only image2d_t pFavoriteMv, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;
	int2 lStride = {get_local_size(0), get_local_size(1)};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int8 ipos = {lpos.x, lpos.x+lStride.x, lpos.x+lStride.x*2, lpos.x+lStride.x*3, lpos.x+lStride.x*4,
				 lpos.y, lpos.y+lStride.y, lpos.y+lStride.y*2};

	__local int lSadMem[2];

	if(lpos.x==0 && lpos.y==0)
		lSadMem[0] = lSadMem[1] = 0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 v0 = read_imagei(pMv, sampler, ipos.s05);
	int4 v1 = read_imagei(pMv, sampler, ipos.s15);
	int4 v2 = read_imagei(pMv, sampler, ipos.s25);
	int4 v3 = read_imagei(pMv, sampler, ipos.s35);
	int4 v4 = read_imagei(pMv, sampler, ipos.s45);
	int4 v5 = read_imagei(pMv, sampler, ipos.s06);
	int4 v6 = read_imagei(pMv, sampler, ipos.s16);
	int4 v7 = read_imagei(pMv, sampler, ipos.s26);
	int4 v8 = read_imagei(pMv, sampler, ipos.s36);
	int4 v9 = read_imagei(pMv, sampler, ipos.s46);
	int4 va = read_imagei(pMv, sampler, ipos.s07);
	int4 vb = read_imagei(pMv, sampler, ipos.s17);
	int4 vc = read_imagei(pMv, sampler, ipos.s27);
	int4 vd = read_imagei(pMv, sampler, ipos.s37);
	int4 ve = read_imagei(pMv, sampler, ipos.s47);
	int4 s0 = read_imagei(pMbSad, sampler, ipos.s05);
	int4 s1 = read_imagei(pMbSad, sampler, ipos.s15);
	int4 s2 = read_imagei(pMbSad, sampler, ipos.s25);
	int4 s3 = read_imagei(pMbSad, sampler, ipos.s35);
	int4 s4 = read_imagei(pMbSad, sampler, ipos.s45);
	int4 s5 = read_imagei(pMbSad, sampler, ipos.s06);
	int4 s6 = read_imagei(pMbSad, sampler, ipos.s16);
	int4 s7 = read_imagei(pMbSad, sampler, ipos.s26);
	int4 s8 = read_imagei(pMbSad, sampler, ipos.s36);
	int4 s9 = read_imagei(pMbSad, sampler, ipos.s46);
	int4 sa = read_imagei(pMbSad, sampler, ipos.s07);
	int4 sb = read_imagei(pMbSad, sampler, ipos.s17);
	int4 sc = read_imagei(pMbSad, sampler, ipos.s27);
	int4 sd = read_imagei(pMbSad, sampler, ipos.s37);
	int4 se = read_imagei(pMbSad, sampler, ipos.s47);

	int sadsum=0;
	int sadnum=0;
	int8 iXY = {iSize.x-2, iSize.y-2, 0, 0, 0, 0, 0, 0};
	int8 bXY = -(ipos>=2&ipos<iXY.s00000111);
	int16 bA=0, bFlag=0, sad=0;

	bA.s0123 = bXY.s0123 & bXY.s5555;
	bA.s4567 = bXY.s4012 & bXY.s5666;
	bA.s89ab = bXY.s3401 & bXY.s6677;
	bA.scdef = bXY.s2340 & bXY.s7777;

	INT4_TO_VECTOR(v0.w, v1.w, v2.w, v3.w, bFlag.lo.lo);
	INT4_TO_VECTOR(v4.w, v5.w, v6.w, v7.w, bFlag.lo.hi);
	INT4_TO_VECTOR(v8.w, v9.w, va.w, vb.w, bFlag.hi.lo);
	INT4_TO_VECTOR(vc.w, vd.w, ve.w, 2   , bFlag.hi.hi);


	bFlag = -((bFlag&2)==0);
	bFlag = bFlag * bA;

	INT4_TO_VECTOR(s0.y, s1.y, s2.y, s3.y, sad.lo.lo);
	INT4_TO_VECTOR(s4.y, s5.y, s6.y, s7.y, sad.lo.hi);
	INT4_TO_VECTOR(s8.y, s9.y, sa.y, sb.y, sad.hi.lo);
	INT4_TO_VECTOR(sc.y, sd.y, se.y, 0   , sad.hi.hi);

	bA = sad * bFlag;

	iXY.s0123 = bFlag.lo.lo + bFlag.lo.hi + bFlag.hi.lo + bFlag.hi.hi;
	bA.s0123 = bA.lo.lo + bA.lo.hi + bA.hi.lo + bA.hi.hi;

	SUM_V4(iXY.s0123, sadnum);
	SUM_V4(bA.s0123, sadsum);

	atomic_add(lSadMem, sadnum);
	atomic_add(lSadMem+1, sadsum);

	barrier(CLK_LOCAL_MEM_FENCE);

	int16 sadavg;
	sadnum = lSadMem[0];
	sadsum = lSadMem[1];
	sadavg = (int16)(sadsum/sadnum);
	bA = -(sadavg<=sad);

	bFlag = bFlag * bA;

	VECTOR_TO_4INT(bFlag.lo.lo, v0.w, v1.w, v2.w, v3.w);
	VECTOR_TO_4INT(bFlag.lo.hi, v4.w, v5.w, v6.w, v7.w);
	VECTOR_TO_4INT(bFlag.hi.lo, v8.w, v9.w, va.w, vb.w);
	VECTOR_TO_4INT(bFlag.hi.hi, vc.w, vd.w, ve.w, iXY.s0);

	write_imagei(pFavoriteMv, ipos.s05, v0);
	write_imagei(pFavoriteMv, ipos.s15, v1);
	write_imagei(pFavoriteMv, ipos.s25, v2);
	write_imagei(pFavoriteMv, ipos.s35, v3);
	write_imagei(pFavoriteMv, ipos.s45, v4);
	write_imagei(pFavoriteMv, ipos.s06, v5);
	write_imagei(pFavoriteMv, ipos.s16, v6);
	write_imagei(pFavoriteMv, ipos.s26, v7);
	write_imagei(pFavoriteMv, ipos.s36, v8);
	write_imagei(pFavoriteMv, ipos.s46, v9);
	write_imagei(pFavoriteMv, ipos.s07, va);
	write_imagei(pFavoriteMv, ipos.s17, vb);
	write_imagei(pFavoriteMv, ipos.s27, vc);
	write_imagei(pFavoriteMv, ipos.s37, vd);
	write_imagei(pFavoriteMv, ipos.s47, ve);
}


#define SELECTMV_6x2(_flag, _sad)\
{\
	v0 = read_imagei(pMv, sampler, ipos.s06);\
	v1 = read_imagei(pMv, sampler, ipos.s16);\
	v2 = read_imagei(pMv, sampler, ipos.s26);\
	v3 = read_imagei(pMv, sampler, ipos.s36);\
	v4 = read_imagei(pMv, sampler, ipos.s46);\
	v5 = read_imagei(pMv, sampler, ipos.s56);\
	v6 = read_imagei(pMv, sampler, ipos.s07);\
	v7 = read_imagei(pMv, sampler, ipos.s17);\
	v8 = read_imagei(pMv, sampler, ipos.s27);\
	v9 = read_imagei(pMv, sampler, ipos.s37);\
	va = read_imagei(pMv, sampler, ipos.s47);\
	vb = read_imagei(pMv, sampler, ipos.s57);\
\
	s0 = read_imagei(pMbSad, sampler, ipos.s06);\
	s1 = read_imagei(pMbSad, sampler, ipos.s16);\
	s2 = read_imagei(pMbSad, sampler, ipos.s26);\
	s3 = read_imagei(pMbSad, sampler, ipos.s36);\
	s4 = read_imagei(pMbSad, sampler, ipos.s46);\
	s5 = read_imagei(pMbSad, sampler, ipos.s56);\
	s6 = read_imagei(pMbSad, sampler, ipos.s07);\
	s7 = read_imagei(pMbSad, sampler, ipos.s17);\
	s8 = read_imagei(pMbSad, sampler, ipos.s27);\
	s9 = read_imagei(pMbSad, sampler, ipos.s37);\
	sa = read_imagei(pMbSad, sampler, ipos.s47);\
	sb = read_imagei(pMbSad, sampler, ipos.s57);\
\
	bA.s0123 = bXY.s0123 & bXY.s6666;\
	bA.s4567 = bXY.s4501 & bXY.s6677;\
	bA.s89ab = bXY.s2345 & bXY.s7777;\
\
	INT4_TO_VECTOR(v0.w, v1.w, v2.w, v3.w, bFlag.lo.lo);\
	INT4_TO_VECTOR(v4.w, v5.w, v6.w, v7.w, bFlag.lo.hi);\
	INT4_TO_VECTOR(v8.w, v9.w, va.w, vb.w, bFlag.hi.lo);\
\
	INT4_TO_VECTOR(s0.y, s1.y, s2.y, s3.y, sad.lo.lo);\
	INT4_TO_VECTOR(s4.y, s5.y, s6.y, s7.y, sad.lo.hi);\
	INT4_TO_VECTOR(s8.y, s9.y, sa.y, sb.y, sad.hi.lo);\
\
	bFlag = -((bFlag&2)==0);\
	bFlag = bFlag * bA;\
\
	iXY.s0123 = bFlag.lo.lo + bFlag.lo.hi + bFlag.hi.lo;\
	bA = sad * bFlag;\
\
	bA.s0123 = bA.lo.lo + bA.lo.hi + bA.hi.lo;\
\
	SUM_V4(iXY.s0123, iXY.s4);\
	SUM_V4(bA.s0123, iXY.s5);\
\
	sadnum += iXY.s4;\
	sadsum += iXY.s5;\
	ipos.s67 += lStride.yy*2;\
	bXY.s67 = -(ipos.s67>=2&ipos.s67<iXY.s67);\
\
	_flag = bFlag;\
	_sad = sad;\
}

#define WRITE_MV_6x2(_flag)\
{\
	v0 = read_imagei(pMv, sampler, ipos.s06);\
	v1 = read_imagei(pMv, sampler, ipos.s16);\
	v2 = read_imagei(pMv, sampler, ipos.s26);\
	v3 = read_imagei(pMv, sampler, ipos.s36);\
	v4 = read_imagei(pMv, sampler, ipos.s46);\
	v5 = read_imagei(pMv, sampler, ipos.s56);\
	v6 = read_imagei(pMv, sampler, ipos.s07);\
	v7 = read_imagei(pMv, sampler, ipos.s17);\
	v8 = read_imagei(pMv, sampler, ipos.s27);\
	v9 = read_imagei(pMv, sampler, ipos.s37);\
	va = read_imagei(pMv, sampler, ipos.s47);\
	vb = read_imagei(pMv, sampler, ipos.s57);\
\
	VECTOR_TO_4INT(_flag.lo.lo, v0.w, v1.w, v2.w, v3.w);\
	VECTOR_TO_4INT(_flag.lo.hi, v4.w, v5.w, v6.w, v7.w);\
	VECTOR_TO_4INT(_flag.hi.lo, v8.w, v9.w, va.w, vb.w);\
\
	write_imagei(pFavoriteMv, ipos.s06, v0);\
	write_imagei(pFavoriteMv, ipos.s16, v1);\
	write_imagei(pFavoriteMv, ipos.s26, v2);\
	write_imagei(pFavoriteMv, ipos.s36, v3);\
	write_imagei(pFavoriteMv, ipos.s46, v4);\
	write_imagei(pFavoriteMv, ipos.s56, v5);\
	write_imagei(pFavoriteMv, ipos.s07, v6);\
	write_imagei(pFavoriteMv, ipos.s17, v7);\
	write_imagei(pFavoriteMv, ipos.s27, v8);\
	write_imagei(pFavoriteMv, ipos.s37, v9);\
	write_imagei(pFavoriteMv, ipos.s47, va);\
	write_imagei(pFavoriteMv, ipos.s57, vb);\
}

__kernel void KN_SelectMvs_6x5(__read_only image2d_t pMv, __read_only image2d_t pMbSad, __write_only image2d_t pFavoriteMv, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;
	int2 lStride = {get_local_size(0), get_local_size(1)};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int8 ipos = {lpos.x, lpos.x+lStride.x, lpos.x+lStride.x*2, lpos.x+lStride.x*3, lpos.x+lStride.x*4, lpos.x+lStride.x*5,
				 lpos.y, lpos.y+lStride.y};

	__local int lSadMem[2];

	if(lpos.x==0 && lpos.y==0)
		lSadMem[0] = lSadMem[1] = 0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, va, vb;
	int4 s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sa, sb;

	int sadsum=0;
	int sadnum=0;
	int8 iXY = {iSize.x-2, iSize.x-2, iSize.x-2, iSize.x-2, iSize.x-2, iSize.x-2, iSize.y-2, iSize.y-2};
	int8 bXY = -(ipos>=2&ipos<iXY);
	int16 bA=0, bFlag=0, sad=0;
	int16 bF0, bF1, bF2;
	int16 sad0, sad1, sad2;

	SELECTMV_6x2(bF0, sad0);
	SELECTMV_6x2(bF1, sad1);
	ipos.s7 = 0;
	SELECTMV_6x2(bF2, sad2);

	atomic_add(lSadMem, sadnum);
	atomic_add(lSadMem+1, sadsum);

	barrier(CLK_LOCAL_MEM_FENCE);

	int16 sadavg;
	sadnum = lSadMem[0];
	sadsum = lSadMem[1];
	sadavg = (int16)(sadsum/sadnum);

	sad0 = -(sadavg<=sad0);
	sad1 = -(sadavg<=sad1);
	sad2 = -(sadavg<=sad2);
	bF0 = bF0 * sad0;
	bF1 = bF1 * sad1;
	bF2 = bF2 * sad2;

	ipos.s6 = lpos.y;
	ipos.s7 = lpos.y + lStride.y;
	WRITE_MV_6x2(bF0);

	ipos.s67 += lStride.y*2;
	WRITE_MV_6x2(bF1);

	ipos.s67 += lStride.y*2;

	v0 = read_imagei(pMv, sampler, ipos.s06);
	v1 = read_imagei(pMv, sampler, ipos.s16);
	v2 = read_imagei(pMv, sampler, ipos.s26);
	v3 = read_imagei(pMv, sampler, ipos.s36);
	v4 = read_imagei(pMv, sampler, ipos.s46);
	v5 = read_imagei(pMv, sampler, ipos.s56);

	VECTOR_TO_4INT(bF2.lo.lo, v0.w, v1.w, v2.w, v3.w);
	VECTOR_TO_4INT(bF2.lo.hi, v4.w, v5.w, v6.w, v7.w);

	write_imagei(pFavoriteMv, ipos.s06, v0);
	write_imagei(pFavoriteMv, ipos.s16, v1);
	write_imagei(pFavoriteMv, ipos.s26, v2);
	write_imagei(pFavoriteMv, ipos.s36, v3);
	write_imagei(pFavoriteMv, ipos.s46, v4);
	write_imagei(pFavoriteMv, ipos.s56, v5);
}

#define SELECTMV_8x1(_flag, _sad)\
{\
	v0 = read_imagei(pMv, sampler, ipos0.xw);\
	v1 = read_imagei(pMv, sampler, ipos0.yw);\
	v2 = read_imagei(pMv, sampler, ipos0.zw);\
	v3 = read_imagei(pMv, sampler, ipos1.xw);\
	v4 = read_imagei(pMv, sampler, ipos1.yw);\
	v5 = read_imagei(pMv, sampler, ipos1.zw);\
	v6 = read_imagei(pMv, sampler, ipos2.xw);\
	v7 = read_imagei(pMv, sampler, ipos2.yw);\
\
	s0 = read_imagei(pMbSad, sampler, ipos0.xw);\
	s1 = read_imagei(pMbSad, sampler, ipos0.yw);\
	s2 = read_imagei(pMbSad, sampler, ipos0.zw);\
	s3 = read_imagei(pMbSad, sampler, ipos1.xw);\
	s4 = read_imagei(pMbSad, sampler, ipos1.yw);\
	s5 = read_imagei(pMbSad, sampler, ipos1.zw);\
	s6 = read_imagei(pMbSad, sampler, ipos2.xw);\
	s7 = read_imagei(pMbSad, sampler, ipos2.yw);\
\
	bA.lo = bX0 & bX2.wwww;\
	bA.hi = bX1 & bX2.wwww;\
\
	INT4_TO_VECTOR(v0.w, v1.w, v2.w, v3.w, _flag.lo);\
	INT4_TO_VECTOR(v4.w, v5.w, v6.w, v7.w, _flag.hi);\
\
	INT4_TO_VECTOR(s0.y, s1.y, s2.y, s3.y, _sad.lo);\
	INT4_TO_VECTOR(s4.y, s5.y, s6.y, s7.y, _sad.hi);\
\
	_flag = -((_flag&2)==0);\
	_flag = _flag * bA;\
\
	bA = _sad * _flag;\
	bX2 = _flag.lo + _flag.hi;\
\
	bA.lo = bA.lo + bA.hi;\
\
	SUM_V4(bX2, bX2.x);\
	SUM_V4(bA.lo, bX2.y);\
\
	sadnum += bX2.x;\
	sadsum += bX2.y;\
	ipos0.w += lStride.y;\
	ipos1.w += lStride.y;\
	ipos2.w += lStride.y;\
	bX2.w = (ipos0.w>=2 && ipos0.w<iSize.y-2);\
}

#define WRITE_MV_8x1(_flag)\
{\
	v0 = read_imagei(pMv, sampler, ipos0.xw);\
	v1 = read_imagei(pMv, sampler, ipos0.yw);\
	v2 = read_imagei(pMv, sampler, ipos0.zw);\
	v3 = read_imagei(pMv, sampler, ipos1.xw);\
	v4 = read_imagei(pMv, sampler, ipos1.yw);\
	v5 = read_imagei(pMv, sampler, ipos1.zw);\
	v6 = read_imagei(pMv, sampler, ipos2.xw);\
	v7 = read_imagei(pMv, sampler, ipos2.yw);\
\
	VECTOR_TO_4INT(_flag.lo, v0.w, v1.w, v2.w, v3.w);\
	VECTOR_TO_4INT(_flag.hi, v4.w, v5.w, v6.w, v7.w);\
\
	write_imagei(pFavoriteMv, ipos0.xw, v0);\
	write_imagei(pFavoriteMv, ipos0.yw, v1);\
	write_imagei(pFavoriteMv, ipos0.zw, v2);\
	write_imagei(pFavoriteMv, ipos1.xw, v3);\
	write_imagei(pFavoriteMv, ipos1.yw, v4);\
	write_imagei(pFavoriteMv, ipos1.zw, v5);\
	write_imagei(pFavoriteMv, ipos2.xw, v6);\
	write_imagei(pFavoriteMv, ipos2.yw, v7);\
	ipos0.w += lStride.y;\
	ipos1.w += lStride.y;\
	ipos2.w += lStride.y;\
}

__kernel void KN_SelectMvs_8x5(__read_only image2d_t pMv, __read_only image2d_t pMbSad, __write_only image2d_t pFavoriteMv, int4 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;
	int2 lStride = {get_local_size(0), get_local_size(1)};
	int2 lpos = {get_local_id(0), get_local_id(1)};
	int4 ipos0 = {lpos.x, lpos.x+lStride.x, lpos.x+lStride.x*2, lpos.y};
	int4 ipos1 = {lpos.x+lStride.x*3, lpos.x+lStride.x*4, lpos.x+lStride.x*5, lpos.y};
	int4 ipos2 = {lpos.x+lStride.x*6, lpos.x+lStride.x*7, lpos.x+lStride.x*8, lpos.y};

	__local int lSadMem[2];

	if(lpos.x==0 && lpos.y==0)
		lSadMem[0] = lSadMem[1] = 0;

	barrier(CLK_LOCAL_MEM_FENCE);

	int4 v0, v1, v2, v3, v4, v5, v6, v7;
	int4 s0, s1, s2, s3, s4, s5, s6, s7;

	int sadsum=0;
	int sadnum=0;
	int4 bX0 = -(ipos0>=2 & ipos0<iSize.xxxy-2);
	int4 bX1 = -(ipos1>=2 & ipos1<iSize.xxxy-2);
	int4 bX2 = -(ipos2>=2 & ipos2<iSize.xxxy-2);

	int8 bA=0;
	int8 bF0, bF1, bF2, bF3, bF4;
	int8 sad0, sad1, sad2, sad3, sad4;

	bX0.w = bX1.x;
	bX1.xy = bX1.yz;
	bX1.zw = bX2.xy;
// 	bA.lo = bX0 & bX2.wwww;
// 	bA.hi = bX1 & bX2.wwww;

	SELECTMV_8x1(bF0, sad0);
	SELECTMV_8x1(bF1, sad1);
	SELECTMV_8x1(bF2, sad2);
	SELECTMV_8x1(bF3, sad3);
	SELECTMV_8x1(bF4, sad4);
// 	bF0 = bA;
// 	bF1.lo = bX0;
// 	bF0.s0 = bX2.w;

	atomic_add(lSadMem, sadnum);
	atomic_add(lSadMem+1, sadsum);

	barrier(CLK_LOCAL_MEM_FENCE);

	int8 sadavg;
	sadnum = lSadMem[0];
	sadsum = lSadMem[1];
	sadavg = (int8)(sadsum/sadnum);

	sad0 = -(sadavg<=sad0);
	sad1 = -(sadavg<=sad1);
	sad2 = -(sadavg<=sad2);
	sad3 = -(sadavg<=sad3);
	sad4 = -(sadavg<=sad4);

	bF0 = bF0 * sad0;
	bF1 = bF1 * sad1;
	bF2 = bF2 * sad2;
	bF3 = bF3 * sad3;
	bF4 = bF4 * sad4;

	ipos0.w = ipos1.w = ipos2.w = lpos.y;

	WRITE_MV_8x1(bF0);
//  	ipos0.w -= lStride.y;\
//  	v0.w = sadnum;
//  	v1.w = sadsum;
//  	write_imagei(pFavoriteMv, ipos0.xw, v0);
//  	write_imagei(pFavoriteMv, ipos0.yw, v1);
//  	ipos0.w -= lStride.y;\

	WRITE_MV_8x1(bF1);
	WRITE_MV_8x1(bF2);
	WRITE_MV_8x1(bF3);
	WRITE_MV_8x1(bF4);
}


// 	pFlag: 16x16 int4
// 	fOffset = {fOffsetX, fOffsetY, (FLOAT)m_uiCropX, (FLOAT)m_uiCropY};
// 	iSize = {m_SrcRect.Width(), m_SrcRect.Height()}
__kernel void KN_FrameAlign(__read_only image2d_t pSrc, __write_only image2d_t pDst, __global int4 *pFlag,
							__constant float *pfPos, float4 fOffset, int2 iSize)
{
	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int4 SHIFT = {2, 0, 3, -1};
	int4 ADD = {0, 1, 2, 3};

	int4 bAlign = pFlag[0]*pFlag[0];
	int2 iOffset = convert_int2(fOffset.xy) * (1-bAlign.xy*bAlign.yx);
	int4 iCrop = {(int)(fOffset.z), (int)(fOffset.w), iSize.x-(int)(fOffset.z)-1, iSize.y-(int)(fOffset.w)-1};
	int2 iStart = {-1, -1};//iOffset + iCrop.xy;
	int2 iEnd = {-1, -1};  //iOffset + iCrop.zw;
	int2 opos = {get_global_id(0)<<2 , get_global_id(1)};
	int2 ipos = opos+iOffset;

	iStart = ipos & SHIFT.zw;
	opos = opos >> SHIFT.xy;
	ipos = ipos >> SHIFT.xy;
	iEnd = ipos + ADD.yx;

	SHIFT = (int4)(iStart.xx==ADD.xy,iStart.xx==ADD.zw);

	int8 s0 ;
	s0.lo = convert_int4(read_imageui(pSrc, sampler, ipos));
	s0.hi = convert_int4(read_imageui(pSrc, sampler, iEnd));

	s0.lo = (s0.s0123 & SHIFT.xxxx) + (s0.s1234 & SHIFT.yyyy) + (s0.s2345 & SHIFT.zzzz) + (s0.s3456 & SHIFT.wwww);

	write_imageui(pDst, opos, convert_uint4(s0.lo));
}

#define GET_SRCDATA(posx, posy, d1, d2, d3, d4)\
{\
	int4 t0, t1, t2, t3;\
	int4 s0, s1, s2, s3;\
	ipos = (int4)(posx>>2, (posx>>2)+1, posy, posy+1);\
	idx1 = posx&3;\
	idx2 = idx1==ADD;\
	s0 = convert_int4(read_imageui(pSrc, sampler, ipos.xz));\
	s1 = convert_int4(read_imageui(pSrc, sampler, ipos.yz));\
	s2 = convert_int4(read_imageui(pSrc, sampler, ipos.xw));\
	s3 = convert_int4(read_imageui(pSrc, sampler, ipos.yw));\
	t1 = s0.yzww;	t1.w = s1.x;\
	t3 = s2.yzww;	t3.w = s3.x;\
	t0 = s0&idx2;\
	t2 = s2&idx2;\
	t1 = t1&idx2;\
	t3 = t3&idx2;\
	SUM_V4(t0, d1);\
	SUM_V4(t1, d2);\
	SUM_V4(t2, d3);\
	SUM_V4(t3, d4);\
}
	//t0.x   = (p0).x  *(1-idx1.x)	+ (p1).x  * idx1.x;
__kernel void KN_FrameAlign_Bilinear(__read_only image2d_t pSrc, __write_only image2d_t pDst, __global int4 *pFlag,
									 __constant float *pfPos, float4 fOffset, int2 iSize)
{

	sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
	int4 ADD = {0, 1, 2, 3};

	float2 bAlign = convert_float2(pFlag[0].xx*pFlag[0].xx);
	float2 fTemp = fOffset.xy*(1.0f-bAlign.xy*bAlign.yx);

	int2 opos = {get_global_id(0), get_global_id(1)};
	int4 oposX;
	int4 iposX, idx1, idx2, iposY, ipos;
	float4 fposX, fposY, fposX2;

	int4 v0, v1, v2, v3;
	int4 done =  {1024,1024,1024,1024};
	float4 f0, f1, f2, f3;
	uint4 d0;
	int s = max(iSize.x, iSize.y);

	__constant float *pfCoeffX = pfPos;
	__constant float *pfCoeffY = pfPos + s;

	oposX = (opos.xxxx<<2) + ADD;
	fposX.x = pfCoeffX[oposX.x];
	fposX.y = pfCoeffX[oposX.y];
	fposX.z = pfCoeffX[oposX.z];
	fposX.w = pfCoeffX[oposX.w];
	fposY.x = pfCoeffY[opos.y];
	fposX = fposX + fTemp.xxxx + fOffset.zzzz;
	fposY = fposY.xxxx + fTemp.yyyy + fOffset.wwww;
	iposX = convert_int4(fposX);
	iposY = convert_int4(fposY);
	fposX = fposX-convert_float4(iposX);
	fposY = fposY-convert_float4(iposY);

	int4 iiposX = convert_int4(fposX*1024.0f);
	int4 iiposY = convert_int4(fposY*1024.0f);

	GET_SRCDATA(iposX.x, iposY.x, v0.x, v1.x, v2.x, v3.x);
	GET_SRCDATA(iposX.y, iposY.x, v0.y, v1.y, v2.y, v3.y);
	GET_SRCDATA(iposX.z, iposY.x, v0.z, v1.z, v2.z, v3.z);
	GET_SRCDATA(iposX.w, iposY.x, v0.w, v1.w, v2.w, v3.w);

	d0 = convert_uint4((v0*(done-iiposX)*(done-iiposY) + v1*iiposX*(done-iiposY) + v2*(done-iiposX)*iiposY + v3*iiposX*iiposY)>>20);

	write_imageui(pDst, opos, d0);
}

// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
