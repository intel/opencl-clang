#define CHAR2( X , Y )  (char2)( X ,Y)
#define CHAR4( X , Y , Z , W)  (char4)( X ,Y, Z, W)
#define CHAR8( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7 )  (char8)( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)
#define UCHAR2( X , Y )  (uchar2)( X ,Y)
#define UCHAR4( X , Y , Z , W)  (uchar4)( X ,Y, Z, W)
#define UCHAR8( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)  (uchar8)( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)
#define SHORT2( X , Y )  (short2)( X ,Y)
#define SHORT4( X , Y , Z , W)  (short4)( X ,Y, Z, W)
#define SHORT8(s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)  (short8)( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)
#define USHORT2( X , Y )  (ushort2)( X ,Y)
#define USHORT4( X , Y , Z , W)  (ushort4)( X ,Y, Z, W)
#define USHORT8( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)  (ushort8)( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)
#define INT2( X , Y )  (int2)( X ,Y)
#define INT4( X , Y , Z , W)  (int4)( X ,Y, Z , W)
#define INT8( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)  (int8)( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)
#define UINT2( X , Y )  (uint2)( X ,Y)
#define UINT4( X , Y , Z , W)  (uint4)( X ,Y, Z , W)
#define UINT8( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)  (uint8)( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)
#define FLOAT2( X , Y )  (float2)( X ,Y)
#define FLOAT4( X , Y , Z , W)  (float4)( X ,Y, Z , W)
#define FLOAT8( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)  (float8)( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)
#define DOUBLE2( X , Y )  (double2)( X ,Y)
#define DOUBLE4( X , Y , Z , W)  (double4)( X ,Y, Z , W)
#define DOUBLE8(s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)  (double8)( s0 , s1 , s2 , s3, s4 , s5 , s6 , s7)
// Copyright (c) 2013 Adobe Systems Inc. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////
// Gaussian Convolution filter - Gaussian smoothing
////////////////////////////////////////////////////////////////////////////////
//#define k1devide256 0.00390625
__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
//Convolution kernel is fixed gSigma = 0.35, kernel radius=1, c_Kernel={44,168,44} - As we have in PS
#if 1

__kernel void GaussianFilterKernel(
__write_only image2d_t dstImageRGBA32F,
__read_only image2d_t srcImageRGBA32F,
const int srcPadding,
const int imageW,
const int imageH,
__local float4* _localT,
const int localTWidth
)
{
int2 writePos = {get_global_id(0), get_global_id(1)};
int2 readPos = {writePos.x+srcPadding - 1, writePos.y+srcPadding-1}; // 1 is kernel radius applying horizontal first
float4 sum;
const float4 weight0 = 44.f;
const float4 weight1 = 168.f;
const float4 k1devide256 = 0.00390625;
int2 lid = (int2)(get_local_id(0), get_local_id(1));
// Fill local memory
if (lid.y >= (get_local_size(1)) - 2) {
int2 readPos1 = (int2)(readPos.x, readPos.y + 2);
sum = read_imagef(srcImageRGBA32F, sampler, readPos1) * weight0;
++readPos1.x;
sum += read_imagef(srcImageRGBA32F, sampler, readPos1) * weight1;
++readPos1.x;
sum += read_imagef(srcImageRGBA32F, sampler, readPos1) * weight0;
_localT[(lid.y+2)*localTWidth + lid.x] = sum * k1devide256;
}
{
sum = read_imagef(srcImageRGBA32F, sampler, readPos) * weight0;
++readPos.x;
sum += read_imagef(srcImageRGBA32F, sampler, readPos) * weight1;
++readPos.x;
sum += read_imagef(srcImageRGBA32F, sampler, readPos) * weight0;
_localT[lid.y*localTWidth + lid.x] = sum * k1devide256;
}
barrier(CLK_LOCAL_MEM_FENCE);
// Now apply convolution on columns using local memory
if (writePos.x < imageW && writePos.y < imageH)
{
//sum = _localT[(lid.y-1)*localTWidth + lid.x] * weight0;
sum = _localT[(lid.y)*localTWidth + lid.x] * weight0;
sum += _localT[(lid.y+1)*localTWidth + lid.x] * weight1;
sum += _localT[(lid.y+2)*localTWidth + lid.x] * weight0;
write_imagef(dstImageRGBA32F, writePos, sum * k1devide256);
}
}
#endif
inline int2 MapReadPosXForPaddedOutput(	const int2 tileCord,
const int2 imageSize,
const int2 centerPos,
const int padding)
{
int2 absoluteReadPos = (centerPos + tileCord) - padding;
int2 mappedReadPos;
mappedReadPos.x = ((absoluteReadPos.x < 0) ? padding : (absoluteReadPos.x >= imageSize.x-1) ? (imageSize.x - tileCord.x - 1) + padding : centerPos.x);
mappedReadPos.y = ((absoluteReadPos.y < 0) ? padding : (absoluteReadPos.y >= imageSize.y-1) ? (imageSize.y - tileCord.y - 1) + padding: centerPos.y);
return mappedReadPos;
}
// **********************************************************************************************
// Gaussian filter kernel for radius 1 only with fixed weight. Generate padded output similar to
// CPU after tiling.
// To compute on convolution around center with weights w0 & w1
//	p1	p2	p3							p10 = (p1*w1 + p2*w0 + p3*w1)*k1Divide256
//  p4	p5	p6  => horizontal conv =>	p11 = (p4*w1 + p5*w0 + p6*w1)*k1Divide256
//  p7	p8	p9							p12 = (p7*w1 + p8*w0 + p9*w1)*k1Divide256
//
//	p10
//	p11 => vertical conv => p13 = (p10*w1 + p11*w0 + p12*w1)*k1Divide256
//	p12
//
//	p13 = (p1*w11 + p2*w10 + p3*w11 + p4*w10 + p5*w00 + p6*w10 + p7*w11 + p8*w10 + p9*w11) * k1devide256_p2
//		= ((p1 + p3 + p7 + p9)*w11 + (p2 + p4 + p6 + p8)*w10 + p5*w00) * k1devide256_p2
// **********************************************************************************************

__kernel void GaussianFilterKernelPadded(
__write_only image2d_t dstImageRGBA32F,
__read_only image2d_t srcImageRGBA32F,
const int padding,
const int srcLeft,
const int srcTop,
const int imageWidth,
const int imageHeight,
const int tileWidth,
const int tileHeight
)
{
int2 writePos = {get_global_id(0), get_global_id(1)};
if (writePos.x >= tileWidth || writePos.y >= tileHeight) return;
int2 centerPos = MapReadPosXForPaddedOutput((int2)(srcLeft, srcTop), (int2)(imageWidth, imageHeight), writePos, padding);
float4 sum = 0;
const float4 w11 = 1936.f; // 44.f*44.f;
const float4 w01 = 7392.f;  //	44.f*168.f;
const float4 w00 = 28224.f; //	168.f*168f;
//const float4 k1devide256 = 0.00390625f;
const float4 k256_p2 = 65536.f;
sum += (read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x-1, centerPos.y-1))	// p1
+ read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x+1, centerPos.y-1)) // p3
+ read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x-1, centerPos.y+1)) // p7
+ read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x+1, centerPos.y+1)) // p9
) * w11;
sum += (read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x, centerPos.y-1))		// p2
+ read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x-1, centerPos.y))	// p4
+ read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x+1, centerPos.y))	// p6
+ read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x, centerPos.y+1))	// p8
) * w01;
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(centerPos.x, centerPos.y)) * w00; // p5
write_imagef(dstImageRGBA32F, writePos, sum/k256_p2);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
