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
// Bicubic Resampling kernels
// in Photoshop 7, this is 14
#define RESAMPLE_WEIGHT_SHIFT		14
#define RESAMPLE_WEIGHT_MAX			(1<<RESAMPLE_WEIGHT_SHIFT)
#define RESAMPLE_WEIGHT_ROUND		(1<<(RESAMPLE_WEIGHT_SHIFT-1))
// in Photoshop 8, this is 7 for 128 bins
#define RESAMPLE_WEIGHT_BITS		7
#define RESAMPLE_WEIGHT_BINS		(1<<RESAMPLE_WEIGHT_BITS)
__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
//inline float proj (float value, float x0, float x1)
//{
//	return (value - x0) / (x1 - x0);
//}
//inline float invproj (float value, float x0, float x1)
//{
//	return value * (x1 - x0) + x0;
//}
inline int Round32 (float x)
{
return (int) ((x >= 0.0f) ? floor (x + 0.5f) : - floor (-x + 0.5f));
}
inline int Pin32 (int bottom, int target, int top)
{
return max(bottom, min(target, top));
}
// *********************************************************************
// Bicubic smoother opencl kernel
// Upsamples the input data horizontally.
//
// *********************************************************************

__kernel void BicubicUpsampleHorizontalKernel(
__read_only image2d_t srcImageRGBA32F,	// original input image tile (properly padded with size srcTilePadding
__write_only image2d_t usImageRGBA32F,	// output image where the upsampled data will be written
const int srcLeft,						// (block_x) x-cordinate of the source image tile provided in srcImageRGBA32F
const int srcTop,						// (block_y) y-cordinate of the source image tile provided in srcImageRGBA32F
const int srcImgWidth,					// width of the original input image (full width)
const int srcImgHeight,					// height of the original input image (full height)
const int srcTilePaddingX,				// size of horizontal padding in the original source image tile
const int srcTilePaddingY,				// size of vertical padding in the original source image tile
const int dstLeft,						// (tile_x) x-cordinate of the destination image tile
const int dstTop,						// (tile_y) y-cordinate of the destination image tile
const int dHeight,						// height of the destination image tile
const int dWidth,						// width of the destination image tile
const int dstImgWidth,					// width of the destination output image (full width)
const int dstImgHeight,					// height of the destination output image (full height)
__constant float* gResWeights)			// global resource weights for each fractional part
{
const int2 dstWritePos = {get_global_id(0), get_global_id(1)};
if (dstWritePos.x >= dWidth || dstWritePos.y >= dHeight) return;
// Resize horizontally
// Map the center point into the range 0..1 and then map that
// from destination01 coordinates to source01 coordinates.s
// This computation is based on full image width/height, but read/write on tile data only
const float u = (dstWritePos.x + dstLeft + 0.5f)/dstImgWidth; // proj (dstWritePos.x + 0.5f + 0, 0, dWidth);
// Project back from source01 coordinates to source coordinates,
// adjust back from being center sampled, and scale up to fixed point
// coordinates.
int y = Round32(((u*srcImgWidth)-0.5f)*RESAMPLE_WEIGHT_BINS); //Round32 ((invproj (u, 0, sWidth) - 0 - 0.5f) * RESAMPLE_WEIGHT_BINS);
y = Pin32 (0, y, (srcImgWidth-1) * RESAMPLE_WEIGHT_BINS);
const int Index = (y >> RESAMPLE_WEIGHT_BITS) - srcLeft;
const short Fract = (y & (RESAMPLE_WEIGHT_BINS -1))*6;
float4 sum = 0;
int2 sourceReadPos = {(Index-2)+srcTilePaddingX, dstWritePos.y+srcTilePaddingY}; // need to read the cordinate (Index -2, -1, 0, 1, 2, 3)
{
sum += read_imagef(srcImageRGBA32F, sampler, sourceReadPos) * (float4)gResWeights[Fract];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+1, sourceReadPos.y)) * (float4)gResWeights[Fract + 1];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+2, sourceReadPos.y)) * (float4)gResWeights[Fract + 2];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+3, sourceReadPos.y)) * (float4)gResWeights[Fract + 3];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+4, sourceReadPos.y)) * (float4)gResWeights[Fract + 4];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+5, sourceReadPos.y)) * (float4)gResWeights[Fract + 5];
write_imagef(usImageRGBA32F, dstWritePos, (sum * (float4)(1.0f/RESAMPLE_WEIGHT_MAX)));
}
}
// *********************************************************************
// Bicubic smoother opencl kernel
// Upsamples the input data vertically.
//
// *********************************************************************

__kernel void BicubicUpsampleVerticalKernel(
__read_only image2d_t srcImageRGBA32F,  // original input image tile (properly padded with size srcTilePadding
__write_only image2d_t usImageRGBA32F,  // output image where the upsampled data will be written
const int srcLeft,						// (block_x) x-cordinate of the source image tile provided in srcImageRGBA32F
const int srcTop,						// (block_y) y-cordinate of the source image tile provided in srcImageRGBA32F
const int srcImgWidth,					// width of the original input image (full width)
const int srcImgHeight,					// height of the original input image (full height)
const int srcTilePaddingX,				// size of horizontal padding in the original source image tile
const int srcTilePaddingY,				// size of vertical padding in the original source image tile
const int dstLeft,						// (tile_x) x-cordinate of the destination image tile
const int dstTop,						// (tile_y) y-cordinate of the destination image tile
const int dHeight,						// height of the destination image tile
const int dWidth,						// width of the destination image tile
const int dstImgWidth,					// width of the destination output image (full width)
const int dstImgHeight,					// height of the destination output image (full height)
__constant float* gResWeights)			// global resource weights for each fractional part
{
const int2 dstWritePos = {get_global_id(0), get_global_id(1)};
if (dstWritePos.x >= dWidth || dstWritePos.y >= dHeight) return;
// Resize vertically
const float u = (dstWritePos.y + dstTop + 0.5f) / dstImgHeight; // proj (dstWritePos.y + 0.5f + 0, 0, dHeight);
int y = Round32(((u*srcImgHeight)-0.5f)*RESAMPLE_WEIGHT_BINS); //Round32 ((invproj (u, 0, sHeight) - 0 - 0.5f) * RESAMPLE_WEIGHT_BINS);
y = Pin32 (0, y, (srcImgHeight-1) * RESAMPLE_WEIGHT_BINS);
const int Index = (y >> RESAMPLE_WEIGHT_BITS) - srcTop;
const int Fract = (y & (RESAMPLE_WEIGHT_BINS -1))*6;
float4 sum = 0;
int2 sourceReadPos = {dstWritePos.x+srcTilePaddingX, (Index-2)+srcTilePaddingY};// need to read the cordinate (Index -2, -1, 0, 1, 2, 3)
{
sum += read_imagef(srcImageRGBA32F, sampler, sourceReadPos) * (float4)gResWeights[Fract];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+1)) * (float4)gResWeights[Fract+1];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+2)) * (float4)gResWeights[Fract+2];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+3)) * (float4)gResWeights[Fract+3];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+4)) * (float4)gResWeights[Fract+4];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+5)) * (float4)gResWeights[Fract+5];
write_imagef(usImageRGBA32F, dstWritePos, (sum * (float4)(1.0f/RESAMPLE_WEIGHT_MAX)));
}
}
// ************************************************************************************
// Bicubic smoother opencl kernel
// Upsamples the input data horizontally.
// Ignores the first 5 and last 5 pixels in output.
// Why this ignore is needed - We need to generate the padded bicubic upscale data
// for egde preserve kernel and for edge preserve upscale algorithm there is limitation
// that we can provide pad size as 10 only.
//		This kernel is always used in upscaling by a factor of 1.5.
// We have 10 pad size in input and we do upscale it by 1.5x which results 15 pixels of
// padding. So we ignore the first and last 5 pixels to generate correct padded data.
// ************************************************************************************

__kernel void BicubicUpsampleHorizontalKernelIngore5Pix(
__read_only image2d_t srcImageRGBA32F,  // original input image tile (properly padded with size srcTilePadding
__write_only image2d_t usImageRGBA32F,  // output image where the upsampled data will be written
const int srcLeft,						// (block_x) x-cordinate of the source image tile provided in srcImageRGBA32F
const int srcTop,						// (block_y) y-cordinate of the source image tile provided in srcImageRGBA32F
const int srcImgWidth,					// width of the original input image (full width)
const int srcImgHeight,					// height of the original input image (full height)
const int srcTilePaddingX,				// size of horizontal padding in the original source image tile
const int srcTilePaddingY,				// size of vertical padding in the original source image tile
const int dstLeft,						// (tile_x) x-cordinate of the destination image tile
const int dstTop,						// (tile_y) y-cordinate of the destination image tile
const int dHeight,						// height of the destination image tile
const int dWidth,						// width of the destination image tile
const int dstImgWidth,					// width of the destination output image (full width)
const int dstImgHeight,					// height of the destination output image (full height)
__constant float* gResWeights)			// global resource weights for each fractional part
{
const int2 dstWritePos = {get_global_id(0), get_global_id(1)};
if (dstWritePos.x >= dWidth-5 || dstWritePos.y >= dHeight) return;
if (dstWritePos.x < 5 ) return;
// Resize horizontally
// Map the center point into the range 0..1 and then map that
// from destination01 coordinates to source01 coordinates.s
// This computation is based on full image width/height, but read/write on tile data only
const float u = (dstWritePos.x + dstLeft + 0.5f)/dstImgWidth; // proj (dstWritePos.x + 0.5f + 0, 0, dWidth);
// Project back from source01 coordinates to source coordinates,
// adjust back from being center sampled, and scale up to fixed point
// coordinates.
int y = Round32(((u*srcImgWidth)-0.5f)*RESAMPLE_WEIGHT_BINS); //Round32 ((invproj (u, 0, sWidth) - 0 - 0.5f) * RESAMPLE_WEIGHT_BINS);
y = Pin32 (0, y, (srcImgWidth-1) * RESAMPLE_WEIGHT_BINS);
const int Index = (y >> RESAMPLE_WEIGHT_BITS) - srcLeft;
const short Fract = (y & (RESAMPLE_WEIGHT_BINS -1))*6;
float4 sum = 0;
int2 sourceReadPos = {(Index-2)+srcTilePaddingX, dstWritePos.y+srcTilePaddingY}; // need to read the cordinate (Index -2, -1, 0, 1, 2, 3)
{
sum += read_imagef(srcImageRGBA32F, sampler, sourceReadPos) * (float4)gResWeights[Fract];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+1, sourceReadPos.y)) * (float4)gResWeights[Fract + 1];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+2, sourceReadPos.y)) * (float4)gResWeights[Fract + 2];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+3, sourceReadPos.y)) * (float4)gResWeights[Fract + 3];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+4, sourceReadPos.y)) * (float4)gResWeights[Fract + 4];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x+5, sourceReadPos.y)) * (float4)gResWeights[Fract + 5];
write_imagef(usImageRGBA32F, (int2)(dstWritePos.x - 5, dstWritePos.y), (sum * (float4)(1.0f/RESAMPLE_WEIGHT_MAX)));
}
}
// ************************************************************************************
// Bicubic smoother opencl kernel
// Upsamples the input data vertically.
// Ignores the first 5 and last 5 pixels in output.
// Why this ignore is needed - We need to generate the padded bicubic upscale data
// for egde preserve kernel and for edge preserve upscale algorithm there is limitation
// that we can provide pad size as 10 only.
//		This kernel is always used in upscaling by a factor of 1.5.
// We have 10 pad size in input and we do upscale it by 1.5x which results 15 pixels of
// padding. So we ignore the first and last 5 pixels to generate correct padded data.
// ************************************************************************************

__kernel void BicubicUpsampleVerticalKernelIgnore5Pix(
__read_only image2d_t srcImageRGBA32F,  // original input image tile (properly padded with size srcTilePadding
__write_only image2d_t usImageRGBA32F,  // output image where the upsampled data will be written
const int srcLeft,						// (block_x) x-cordinate of the source image tile provided in srcImageRGBA32F
const int srcTop,						// (block_y) y-cordinate of the source image tile provided in srcImageRGBA32F
const int srcImgWidth,					// width of the original input image (full width)
const int srcImgHeight,					// height of the original input image (full height)
const int srcTilePaddingX,				// size of horizontal padding in the original source image tile
const int srcTilePaddingY,				// size of vertical padding in the original source image tile
const int dstLeft,						// (tile_x) x-cordinate of the destination image tile
const int dstTop,						// (tile_y) y-cordinate of the destination image tile
const int dHeight,						// height of the destination image tile
const int dWidth,						// width of the destination image tile
const int dstImgWidth,					// width of the destination output image (full width)
const int dstImgHeight,					// height of the destination output image (full height)
__constant float* gResWeights)			// global resource weights for each fractional part
{
const int2 dstWritePos = {get_global_id(0), get_global_id(1)};
if (dstWritePos.x >= dWidth || dstWritePos.y >= dHeight-5) return;
if (dstWritePos.y < 5) return;
// Resize vertically
const float u = (dstWritePos.y + dstTop + 0.5f) / dstImgHeight; // proj (dstWritePos.y + 0.5f + 0, 0, dHeight);
int y = Round32(((u*srcImgHeight)-0.5f)*RESAMPLE_WEIGHT_BINS); //Round32 ((invproj (u, 0, sHeight) - 0 - 0.5f) * RESAMPLE_WEIGHT_BINS);
y = Pin32 (0, y, (srcImgHeight-1) * RESAMPLE_WEIGHT_BINS);
const int Index = (y >> RESAMPLE_WEIGHT_BITS) - srcTop;
const int Fract = (y & (RESAMPLE_WEIGHT_BINS -1))*6;
float4 sum = 0;
int2 sourceReadPos = {dstWritePos.x+srcTilePaddingX, (Index-2)+srcTilePaddingY};// need to read the cordinate (Index -2, -1, 0, 1, 2, 3)
{
sum += read_imagef(srcImageRGBA32F, sampler, sourceReadPos) * (float4)gResWeights[Fract];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+1)) * (float4)gResWeights[Fract+1];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+2)) * (float4)gResWeights[Fract+2];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+3)) * (float4)gResWeights[Fract+3];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+4)) * (float4)gResWeights[Fract+4];
sum += read_imagef(srcImageRGBA32F, sampler, (int2)(sourceReadPos.x, sourceReadPos.y+5)) * (float4)gResWeights[Fract+5];
write_imagef(usImageRGBA32F, (int2)(dstWritePos.x, dstWritePos.y-5), (sum * (float4)(1.0f/RESAMPLE_WEIGHT_MAX)));
}
}

__kernel void BicubicDownsampleHorizontalKernel(
__read_only image2d_t srcImageRGBA32F,  // original input image tile (properly padded with size srcTilePadding
__write_only image2d_t usImageRGBA32F,  // output image where the upsampled data will be written
const int srcLeft,						// (block_x) x-cordinate of the source image tile provided in srcImageRGBA32F
const int srcTop,						// (block_y) y-cordinate of the source image tile provided in srcImageRGBA32F
const int srcTileWidth,
const int srcImgWidth,					// width of the original input image (full width)
const int srcImgHeight,					// height of the original input image (full height)
const int srcTilePadding,				// size of padding in the original source image tile
const int dstLeft,						// (tile_x) x-cordinate of the destination image tile
const int dstTop,						// (tile_y) y-cordinate of the destination image tile
const int dHeight,						// height of the destination image tile
const int dWidth,						// width of the destination image tile
const int dstImgWidth,					// width of the destination output image (full width)
const int dstImgHeight)					// height of the destination output image (full height)
{
const int2 dstWritePos = {get_global_id(0), get_global_id(1)};
int Index;
int Fract;
if (dstWritePos.x >= dWidth || dstWritePos.y >= dHeight) return;
{
// Resize horizontally
const float u = (dstWritePos.x + dstLeft + 0.5f)/dstImgWidth; // proj (dstWritePos.x + 0.5f + 0, 0, dWidth);
int y = Round32(((u*srcImgWidth)-0.5f)*RESAMPLE_WEIGHT_BINS); //Round32 ((invproj (u, 0, sWidth) - 0 - 0.5f) * RESAMPLE_WEIGHT_BINS);
y = Pin32 (0, y, (srcImgWidth-1) * RESAMPLE_WEIGHT_BINS);
Index = (y >> RESAMPLE_WEIGHT_BITS) - srcLeft;
Fract = (y & (RESAMPLE_WEIGHT_BINS -1));
}
Index = max(0, min(srcTileWidth-1, Index));
int2 bicubicResWeight;
// Calculate bin weights for Fract (bin)
bicubicResWeight.y = (RESAMPLE_WEIGHT_MAX*Fract)/RESAMPLE_WEIGHT_BINS;
bicubicResWeight.x = RESAMPLE_WEIGHT_MAX - bicubicResWeight.y;
int2 sourceReadPos = {Index+srcTilePadding, dstWritePos.y};
float4 s =  read_imagef(srcImageRGBA32F, sampler, sourceReadPos);
float4 sum = s * (float4)bicubicResWeight.x;
++sourceReadPos.x;
s =  read_imagef(srcImageRGBA32F, sampler, sourceReadPos);
sum += (s * (float4)bicubicResWeight.y);
write_imagef(usImageRGBA32F, dstWritePos, (sum * (float4)(1.0f/RESAMPLE_WEIGHT_MAX)));
}

__kernel void BicubicDownsampleVerticalKernel(
__read_only image2d_t srcImageRGBA32F,  // original input image tile (properly padded with size srcTilePadding
__write_only image2d_t usImageRGBA32F,  // output image where the upsampled data will be written
const int srcLeft,						// (block_x) x-cordinate of the source image tile provided in srcImageRGBA32F
const int srcTop,						// (block_y) y-cordinate of the source image tile provided in srcImageRGBA32F
const int srcTileHeight,
const int srcImgWidth,					// width of the original input image (full width)
const int srcImgHeight,					// height of the original input image (full height)
const int srcTilePadding,				// size of padding in the original source image tile
const int dstLeft,						// (tile_x) x-cordinate of the destination image tile
const int dstTop,						// (tile_y) y-cordinate of the destination image tile
const int dHeight,						// height of the destination image tile
const int dWidth,						// width of the destination image tile
const int dstImgWidth,					// width of the destination output image (full width)
const int dstImgHeight)					// height of the destination output image (full height)
{
const int2 dstWritePos = {get_global_id(0), get_global_id(1)};
if (dstWritePos.x >= dWidth || dstWritePos.y >= dHeight) return;
// Resize vertically
const float u = (dstWritePos.y + dstTop + 0.5f) / dstImgHeight; // proj (dstWritePos.y + 0.5f + 0, 0, dHeight);
int y = Round32(((u*srcImgHeight)-0.5f)*RESAMPLE_WEIGHT_BINS); //Round32 ((invproj (u, 0, sHeight) - 0 - 0.5f) * RESAMPLE_WEIGHT_BINS);
y = Pin32 (0, y, (srcImgHeight-1) * RESAMPLE_WEIGHT_BINS);
int Index = (y >> RESAMPLE_WEIGHT_BITS) - srcTop;
const int Fract = (y & (RESAMPLE_WEIGHT_BINS -1));
Index = max(0, min(srcTileHeight-1, Index));
int2 bicubicResWeight;
// Calculate bin weights for Fract (bin)
bicubicResWeight.y = (RESAMPLE_WEIGHT_MAX*Fract)/RESAMPLE_WEIGHT_BINS;
bicubicResWeight.x = RESAMPLE_WEIGHT_MAX - bicubicResWeight.y;
int2 sourceReadPos = {dstWritePos.x, Index + srcTilePadding};
float4 s =  read_imagef(srcImageRGBA32F, sampler, sourceReadPos);
float4 sum = s * (float4)bicubicResWeight.x;
++sourceReadPos.y;
s =  read_imagef(srcImageRGBA32F, sampler, sourceReadPos);
sum += (s * (float4)bicubicResWeight.y);
write_imagef(usImageRGBA32F, dstWritePos, (sum * (float4)(1.0f/RESAMPLE_WEIGHT_MAX)));
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
