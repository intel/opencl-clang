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
/////////////////////////////////////////////////////////////////////////////////
__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
CLK_ADDRESS_CLAMP_TO_EDGE   |
CLK_FILTER_NEAREST;
// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Interleave8To32(__read_only image2d_t srcChan0,
__read_only image2d_t srcChan1,
__read_only image2d_t srcChan2,
__read_only image2d_t srcChan3,
__write_only image2d_t dstImage,
int originX, int originY,
int cols, int rows,
int numChannels,
int chanRowStep)
{
int col = get_global_id(0);
int row = get_global_id(1);
if (col >= cols || row >= rows)
return;
int2 chanReadPos = {col, row};
float4 pixel32;
if (numChannels == 3)
pixel32 = (float4)((float)read_imageui(srcChan0, sampler, chanReadPos).x, (float)read_imageui(srcChan1, sampler, chanReadPos).x,
(float)read_imageui(srcChan2, sampler, chanReadPos).x, 255.0f);
else
pixel32 = (float4)((float)read_imageui(srcChan0, sampler, chanReadPos).x, (float)read_imageui(srcChan1, sampler, chanReadPos).x,
(float)read_imageui(srcChan2, sampler, chanReadPos).x, (float)read_imageui(srcChan3, sampler, chanReadPos).x);
pixel32 /= 255.0f;
write_imagef(dstImage, (int2)(originX + col, originY + row), pixel32);
}

__kernel void Interleave16To32(__read_only image2d_t srcChan0,
__read_only image2d_t srcChan1,
__read_only image2d_t srcChan2,
__read_only image2d_t srcChan3,
__write_only image2d_t dstImage,
int originX, int originY,
int cols, int rows,
int numChannels,
int chanRowStep)
{
int col = get_global_id(0);
int row = get_global_id(1);
if (col >= cols || row >= rows)
return;
int2 chanReadPos = {col, row};
float4 pixel32;
if (numChannels == 3)
pixel32 = (float4)((float)read_imageui(srcChan0, sampler, chanReadPos).x, (float)read_imageui(srcChan1, sampler, chanReadPos).x,
(float)read_imageui(srcChan2, sampler, chanReadPos).x, 255.0f);
else
pixel32 = (float4)((float)read_imageui(srcChan0, sampler, chanReadPos).x, (float)read_imageui(srcChan1, sampler, chanReadPos).x,
(float)read_imageui(srcChan2, sampler, chanReadPos).x, (float)read_imageui(srcChan3, sampler, chanReadPos).x);
pixel32 /= 32768.0f;
write_imagef(dstImage, (int2)(originX + col, originY + row), pixel32);
}
// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Interleave32To32(__read_only image2d_t srcChan0,
__read_only image2d_t srcChan1,
__read_only image2d_t srcChan2,
__read_only image2d_t srcChan3,
__write_only image2d_t dstImage,
int originX, int originY,
int cols, int rows,
int numChannels,
int chanRowStep)
{
int col = get_global_id(0);
int row = get_global_id(1);
if (col >= cols || row >= rows)
return;
int2 chanReadPos = {col, row};
float4 pixel32;
if (numChannels == 3)
pixel32 = (float4)(read_imagef(srcChan0, sampler, chanReadPos).x, read_imagef(srcChan1, sampler, chanReadPos).x,
read_imagef(srcChan2, sampler, chanReadPos).x, 1.0f);
else
pixel32 = (float4)(read_imagef(srcChan0, sampler, chanReadPos).x, read_imagef(srcChan1, sampler, chanReadPos).x,
read_imagef(srcChan2, sampler, chanReadPos).x, read_imagef(srcChan3, sampler, chanReadPos).x);
write_imagef(dstImage, (int2)(originX + col, originY + row), pixel32);
}
// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Deinterleave32To8(__read_only image2d_t srcImage,
__write_only image2d_t dstChan0,
__write_only image2d_t dstChan1,
__write_only image2d_t dstChan2,
__write_only image2d_t dstChan3,
int originX, int originY,
int cols, int rows,
int numChannels,
int chanRowStep)
{
int col = get_global_id(0);
int row = get_global_id(1);
if(col >= cols || row >= rows)
return;
int2 chanWritePos = {col, row};
float4 pixel32 = (read_imagef(srcImage,sampler,(int2)(originX + col, originY + row)) * 255.0f) + 0.5f;
uchar4 pixel8 = convert_uchar4_sat(pixel32);
write_imageui(dstChan0, chanWritePos, (uint4)(pixel8.x, 0, 0, 255));
write_imageui(dstChan1, chanWritePos, (uint4)(pixel8.y, 0, 0, 255));
write_imageui(dstChan2, chanWritePos, (uint4)(pixel8.z, 0, 0, 255));
if (numChannels == 4)
write_imageui(dstChan3, chanWritePos, (uint4)(pixel8.w, 0, 0, 255));
}
// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Deinterleave32To16(__read_only image2d_t srcImage,
__write_only image2d_t dstChan0,
__write_only image2d_t dstChan1,
__write_only image2d_t dstChan2,
__write_only image2d_t dstChan3,
int originX, int originY,
int cols, int rows,
int numChannels,
int chanRowStep)
{
int col = get_global_id(0);
int row = get_global_id(1);
if(col >= cols || row >= rows)
return;
int2 chanWritePos = {col, row};
float4 pixel32 = read_imagef(srcImage,sampler,(int2)(originX + col, originY + row)) * 32768.0f;
pixel32 = clamp(pixel32, 0.f, 32768.0f);
ushort4 pixel16 = convert_ushort4(pixel32);
write_imageui(dstChan0, chanWritePos, (uint4)(pixel16.x, 0, 0, 32768));
write_imageui(dstChan1, chanWritePos, (uint4)(pixel16.y, 0, 0, 32768));
write_imageui(dstChan2, chanWritePos, (uint4)(pixel16.z, 0, 0, 32768));
if (numChannels == 4)
write_imageui(dstChan3, chanWritePos, (uint4)(pixel16.w, 0, 0, 32768));
}
// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Deinterleave32To32(__read_only image2d_t srcImage,
__write_only image2d_t dstChan0,
__write_only image2d_t dstChan1,
__write_only image2d_t dstChan2,
__write_only image2d_t dstChan3,
int originX, int originY,
int cols, int rows,
int numChannels,
int chanRowStep)
{
int col = get_global_id(0);
int row = get_global_id(1);
if(col >= cols || row >= rows)
return;
int2 chanWritePos = {col, row};
float4 pixel32 = read_imagef(srcImage,sampler,(int2)(originX + col, originY + row));
write_imagef(dstChan0, chanWritePos, (float4)(pixel32.x, 0.f, 0.f, 1.f));
write_imagef(dstChan1, chanWritePos, (float4)(pixel32.y, 0.f, 0.f, 1.f));
write_imagef(dstChan2, chanWritePos, (float4)(pixel32.z, 0.f, 0.f, 1.f));
if (numChannels == 4)
write_imagef(dstChan3, chanWritePos, (float4)(pixel32.w, 0.f, 0.f, 1.f));
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
