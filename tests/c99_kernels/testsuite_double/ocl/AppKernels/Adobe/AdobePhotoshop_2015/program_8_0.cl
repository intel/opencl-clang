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
////////////////////////////////////////////////////////////////////////////////
#define Nrec 0.11111111f
#define Srec 0.16666667f
#define Frec 0.25000000f
#define UpscaleFactorRecip 0.66666667f
// ~~~ DEBUG ~~~
//#define DO_FAKE_SEARCH
//#define USE_PS_R
#define USE_PS_STAGE1_REF_CODE
#define GLOBAL_CLOSEST_PATCH_BUF
//#define USE_PS_STAGE1
////////////////////////////////////////////////////////////////////////////////
__constant sampler_t sampler =
CLK_NORMALIZED_COORDS_FALSE |
CLK_ADDRESS_CLAMP_TO_EDGE   |
CLK_FILTER_NEAREST;
__constant sampler_t sampler_L =
CLK_NORMALIZED_COORDS_FALSE |
CLK_ADDRESS_CLAMP_TO_EDGE   |
CLK_FILTER_LINEAR;
// Cal QR - Kernel author: I-Ming Pao
__constant int pixT[2] = { 0,-1};
__constant int pixB[2] = { 0, 1};
__constant int pixL[2] = {-1, 0};
__constant int pixR[2] = { 1 ,0};
// Implementation using image2d as the memory object.
// * Should add the read the padded input image capability
// Later, inputImageRGBA32F should be padded, outputImage32F is the original size (without padding).
// For shapen part, both need to be padded.
// Note:
// clEnqueueWriteImage is slower than elEnqueueWriteBuffer (p.115 heterogeneous computing OpenCL 1st edition)
//
// work-item size should be the same size as the output image (without padding).
// inputImageRGBA32F: normalized padded RGBA image ranging from 0.0f ~ 1.0f. global_id(0, 0) should point to the beginning
// outputImage32F: calcQR, calculate R, range 0.0f ~ 1.0f.
// inputImageRGBA32F should be properly padded.

__kernel void cal_QR_RGBA32f(
__read_only image2d_t inputImageRGBA32F,
__write_only image2d_t outputImage32F,
const int patchRadius,
const int padSize,	// (padSize, padSize) is the absolute coordinate of where tile_usC1 points to. (UpscalePS.cpp)
__local float* gx2RowTable,
__local float* gy2RowTable,
__local float* grdRowTable,
const int grdRowTableWidth,
const int grdRowTableHeight,
const int nStep	// param.nStep, patch is sampled every nStep: patch center coordinate is (0, 0), (nStep, 0), (2*nStep, 0), ... for example
)
{
const int2 gid = {get_global_id(0), get_global_id(1)};
// nStep 1: three extra patches-> shift -4 pixels, for nStep == 2, do two extra patches for overcompute -> shift -5 pixels, prepared for upscale kernel.
// For nStep == 3, do one extra patches->shift -3 pixels.
const int2 globalPos = gid + padSize - (nStep == 3 ? 3 : nStep + 3);	// nStep 1: (gid + padSize - 4), nStep 2: (gid + padSize - 5), nStep 3: (gid + padSize - 3).
//	if ((gid.x > get_image_width(outputImage32F)) | (gid.y > get_image_height(outputImage32F)))
//		return;
// fill the grdRowTable
const float4 dot4xyz = {1.0f, 1.0f, 1.0f, 0.0f};
const float JYEPS = 1e-9f;
const int patchSize = patchRadius*2 + 1;
int2 centerPatchReadPos;
float4 srcValueL, srcValueR, srcValueT, srcValueB;
float gx1,gy1;
float gx2 = 0.0f;
float gy2 = 0.0f;
float gxy = 0.0f;
//float ssd = 0.0f;
//float3 gx2gy2gxy = {0.0f,0.0f,0.0f};;
float A, D, B;
if (patchSize == 5)
{
const int grpW = get_local_size(0);
const int grpH = get_local_size(1);
const int lidX = get_local_id(0);
const int lidY = get_local_id(1);
const int2 lid = (int2)(lidX, lidY);
//const int localBufSize = grdRowTableWidth * grdRowTableHeight;
centerPatchReadPos = globalPos - patchRadius;
//int2 upperleft_globalPos = centerPatchReadPos - lid;
// fill the first 4 columns
if (lid.x < 4)
{
srcValueL = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixL[0], centerPatchReadPos.y+pixL[1]));
srcValueT = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixT[0], centerPatchReadPos.y+pixT[1]));
srcValueR = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixR[0], centerPatchReadPos.y+pixR[1]));
srcValueB = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixB[0], centerPatchReadPos.y+pixB[1]));
gx1 = dot(srcValueR - srcValueL, dot4xyz);
gy1 = dot(srcValueB - srcValueT, dot4xyz);
gx2RowTable[lid.y*grdRowTableWidth + lid.x] = gx1 * gx1;
gy2RowTable[lid.y*grdRowTableWidth + lid.x] = gy1 * gy1;
grdRowTable[lid.y*grdRowTableWidth + lid.x] = gx1 * gy1;
//grdRowTable[lid.y*grdRowTableWidth + lid.x] = (float3){gx1 * gx1, gy1 * gy1, gx1 * gy1};
}
// fill the rest
srcValueL = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixL[0]+4, centerPatchReadPos.y+pixL[1]));
srcValueT = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixT[0]+4, centerPatchReadPos.y+pixT[1]));
srcValueR = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixR[0]+4, centerPatchReadPos.y+pixR[1]));
srcValueB = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixB[0]+4, centerPatchReadPos.y+pixB[1]));
gx1 = dot(srcValueR - srcValueL, dot4xyz);
gy1 = dot(srcValueB - srcValueT, dot4xyz);
gx2RowTable[lid.y*grdRowTableWidth + lid.x + 4] = gx1 * gx1;
gy2RowTable[lid.y*grdRowTableWidth + lid.x + 4] = gy1 * gy1;
grdRowTable[lid.y*grdRowTableWidth + lid.x + 4] = gx1 * gy1;
//grdRowTable[lid.y*grdRowTableWidth + lid.x + 4] = (float3){gx1 * gx1, gy1 * gy1, gx1 * gy1};
if (lid.y > get_local_size(1) - 5)
{
if (lid.x < 4)
{
srcValueL = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixL[0], centerPatchReadPos.y+pixL[1]+4));
srcValueT = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixT[0], centerPatchReadPos.y+pixT[1]+4));
srcValueR = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixR[0], centerPatchReadPos.y+pixR[1]+4));
srcValueB = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixB[0], centerPatchReadPos.y+pixB[1]+4));
gx1 = dot(srcValueR - srcValueL, dot4xyz);
gy1 = dot(srcValueB - srcValueT, dot4xyz);
gx2RowTable[(lid.y + 4)*grdRowTableWidth + lid.x] = gx1 * gx1;
gy2RowTable[(lid.y + 4)*grdRowTableWidth + lid.x] = gy1 * gy1;
grdRowTable[(lid.y + 4)*grdRowTableWidth + lid.x] = gx1 * gy1;
}
// fill the rest
srcValueL = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixL[0]+4, centerPatchReadPos.y+pixL[1]+4));
srcValueT = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixT[0]+4, centerPatchReadPos.y+pixT[1]+4));
srcValueR = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixR[0]+4, centerPatchReadPos.y+pixR[1]+4));
srcValueB = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixB[0]+4, centerPatchReadPos.y+pixB[1]+4));
gx1 = dot(srcValueR - srcValueL, dot4xyz);
gy1 = dot(srcValueB - srcValueT, dot4xyz);
gx2RowTable[(lid.y + 4)*grdRowTableWidth + lid.x + 4] = gx1 * gx1;
gy2RowTable[(lid.y + 4)*grdRowTableWidth + lid.x + 4] = gy1 * gy1;
grdRowTable[(lid.y + 4)*grdRowTableWidth + lid.x + 4] = gx1 * gy1;
}
barrier(CLK_LOCAL_MEM_FENCE);
// Done with the grdRowTable
// R is for each patch
if ((gid.x % nStep) | (gid.y % nStep) | (gid.x >= get_image_width(outputImage32F)) | (gid.y >= get_image_height(outputImage32F)))
return;
int gdTableIdx = lid.y*grdRowTableWidth + lid.x;
for (int row = 0; row < 5; ++row)
{
gx2 += gx2RowTable[gdTableIdx]
+ gx2RowTable[gdTableIdx + 1]
+ gx2RowTable[gdTableIdx + 2]
+ gx2RowTable[gdTableIdx + 3]
+ gx2RowTable[gdTableIdx + 4];
gy2 += gy2RowTable[gdTableIdx]
+ gy2RowTable[gdTableIdx + 1]
+ gy2RowTable[gdTableIdx + 2]
+ gy2RowTable[gdTableIdx + 3]
+ gy2RowTable[gdTableIdx + 4];
gxy += grdRowTable[gdTableIdx]
+ grdRowTable[gdTableIdx + 1]
+ grdRowTable[gdTableIdx + 2]
+ grdRowTable[gdTableIdx + 3]
+ grdRowTable[gdTableIdx + 4];
gdTableIdx += grdRowTableWidth;
}
A = gx2;
B = gxy;
D = gy2;
}
else
{
// R is for each patch
if ((gid.x % nStep) | (gid.y % nStep) | (gid.x >= get_image_width(outputImage32F)) | (gid.y >= get_image_height(outputImage32F)))
return;
for (int patchRow = 0; patchRow < patchSize; ++patchRow)
{
centerPatchReadPos.y =  globalPos.y - patchRadius + patchRow;
for (int patchCol = 0; patchCol < patchSize; ++patchCol)	// will do manual unrolling (4 at a time for example) later for upscale
{
centerPatchReadPos.x =  globalPos.x - patchRadius + patchCol;
srcValueL = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixL[0], centerPatchReadPos.y+pixL[1]));
srcValueR = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixR[0], centerPatchReadPos.y+pixR[1]));
srcValueT = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixT[0], centerPatchReadPos.y+pixT[1]));
srcValueB = read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x+pixB[0], centerPatchReadPos.y+pixB[1]));
gx1 = dot(srcValueR - srcValueL, dot4xyz);
gy1 = dot(srcValueB - srcValueT, dot4xyz);
gxy += gx1 * gy1 ;
gx2 += gx1 * gx1 ;
gy2 += gy1 * gy1 ;
}
A = gx2;
B = gxy;
D = gy2;
}
}
float ad, lambda1, lambda2, s1, s2;
float R;
ad = A - D;
ad = ad*ad + 4*B*B;
ad = sqrt(ad);
lambda1 = A+D+ad;
lambda2 = A+D-ad;
// if(lambda1 < 0 || lambda2 < 0)
// TBB version has no lambda1, mathamatically lambda1 >= 0
if(lambda2 < 0)
{
R = 0;
//Q = 0;
} else
{
s1 = sqrt(lambda1);
s2 = sqrt(lambda2);
R = (s1-s2)/(s1+s2+JYEPS);
//Q = R*s1;
}
// odd work items already return
// /nStep because R is for each patch
write_imagef(outputImage32F, gid/nStep, R);
}
// End calQR
// check CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE
__constant int2 XYsCStage1[5] = {
(int2)(0,  1), (int2)(1,  0), (int2)(0, -1), (int2)(-1,  0), (int2)(0, 0)
};
// Relative coordinate in one 5x5 patch
// (0, 0), (1, 0), ... (4, 0)
// (0, 1), (1, 1), ... (4, 1)
// ...
// (0, 4), (1, 4), ... (4, 4)
// Lookup table for high fequency image generation, stores the relative patch location from the center patch.  Patches are selected for every two pixels.
__constant int2 lutPatchShiftNStep1[25] =
{
(int2)(-2, -2), (int2)(-1, -2), (int2)( 0, -2), (int2)( 1, -2), (int2)( 2, -2),
(int2)(-2, -1), (int2)(-1, -1), (int2)( 0, -1), (int2)( 1, -1), (int2)( 2, -1),
(int2)(-2,  0), (int2)(-1,  0), (int2)( 0,  0), (int2)( 1,  0), (int2)( 2,  0),
(int2)(-2,  1), (int2)(-1,  1), (int2)( 0,  1), (int2)( 1,  1), (int2)( 2,  1),
(int2)(-2,  2), (int2)(-1,  2), (int2)( 0,  2), (int2)( 1,  2), (int2)( 2,  2),
// pixel (3, 3) contributed by 25 patches
};
// Accumulation
// 9  6  9  6  9
// 6  4  6  4  6
// 9  6  9  6  9
// 6  4  6  4* 6*
// 9  6  9  6* 9*
// Relative coordinate in one 5x5 patch
// (0, 0), (1, 0), ... (4, 0)
// (0, 1), (1, 1), ... (4, 1)
// ...
// (0, 4), (1, 4), ... (4, 4)
// Lookup table for high fequency image generation, stores the relative patch location from the center patch.  Patches are selected for every two pixels.
__constant int2 lutPatchShiftNStep2[4][9] = {
{(int2)( 0,  0), (int2)( 2,  0), (int2)( 0,  2), (int2)( 2,  2)},	// pixel (3, 3) contributed by 4 patches
{(int2)( 0,  0), (int2)( 2,  0), (int2)( 4,  0), (int2)( 0,  2), (int2)( 2,  2), (int2)( 4,  2)}, // pixel (4, 3) contributed by 6 patches
{(int2)( 0,  0), (int2)( 0,  2), (int2)( 0,  4), (int2)( 2,  0), (int2)( 2,  2), (int2)( 2,  4)}, // pixel (3, 4) contributed by 6 patches
{(int2)( 0,  0), (int2)( 2,  0), (int2)( 4,  0), (int2)( 0,  2), (int2)( 2,  2), (int2)( 4,  2), (int2)( 0,  4), (int2)( 2,  4), (int2)( 4,  4)} // pixel (4, 4) contributed by 9 patches
};
// Accumulation
// 4  4  2  4  4
// 4  4  2  4  4
// 2  2  1* 2* 2*
// 4  4  2* 4* 4*
// 4  4  2* 4* 4*
// Lookup table for high frequency image generation.  Patches are seleced for every three pixels.
__constant int2 lutPatchShiftNStep3[9][4] = {
{(int2)(0, 0)},	// (2, 2)
{(int2)(0, 0), (int2)(3, 0)},	// (3, 2)
{(int2)(0, 0), (int2)(3, 0)},	// (4, 2)
{(int2)(0, 0), (int2)(0, 3)},	// (2, 3)
{(int2)(0, 0), (int2)(3, 0), (int2)(0, 3), (int2)(3, 3)},	// (3, 3)
{(int2)(0, 0), (int2)(3, 0), (int2)(0, 3), (int2)(3, 3)},	// (4, 3)
{(int2)(0, 0), (int2)(0, 3)},	// (2, 4)
{(int2)(0, 0), (int2)(3, 0), (int2)(0, 3), (int2)(3, 3)},	// (3, 4)
{(int2)(0, 0), (int2)(3, 0), (int2)(0, 3), (int2)(3, 3)}	// (4, 4)
};
// Reference code
void closestPatchSearchNStep1Ref (
const int2 gid,
const int2 lid,
const int2 grpSize,
const int padSizeTile,						// (padSizeTile, padSizeTile) on I_us32FC4 maps to where tile_dstC1, ... point to.
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) on I_sm32FC4 and I_sr32FC4 map to where block_srC1, block_smC1, ... point to.
__read_only image2d_t I_sm32FC4,
__read_only image2d_t I_us32FC4,
const int tile_x,							// dstTile.left: absolute upper left x coordinate for this tile (maps to (padSizeTile, padSizetile)).  sint32 ux = tile_x + cx;
const int tile_y,							// dstTile.top
const int block_x,							// refRect.left, dx = sint32(std::floor((ux+0.5f)/1.5f)) - block_x; (may not maps to (padSizeBlock, padSizeBlock)).
const int block_y,							// refRect.top
__local int2* closestPatchShiftBuf
) {
float4 tmpValue;
// Search for left, top, right, bottom, and center
// fill 16x8
float ssdOld = MAXFLOAT;
const int cShift = -4;	// for overcompute purpose...
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = gid.x + cShift;	// relative patch center location based on tile_x for I_us
int cy = gid.y + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 8)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 8)] = 0;
}
}
}
// fill 8x8 (
if (lid.x < 8)
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = gid.x + grpSize.x + cShift;	// relative patch center location based on tile_x
int cy = gid.y + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 24 x 16, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 8)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 8)] = 0;
}
}
}
}
// fill 16x8
//if (lid.y < 8)
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = gid.x + cShift;	// relative patch center location based on tile_x
int cy = gid.y + grpSize.y + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 24 x 16, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 8)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 8)] = 0;
}
}
}
}
// fill 8x8
if ((lid.x < 8) & (lid.y < 8))
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = gid.x + grpSize.x + cShift;	// relative patch center location based on tile_x
int cy = gid.y + grpSize.y + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 24 x 16, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 8)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 8)] = 0;
}
}
}
}
}
// Reference code
void closestPatchSearchNStep2Ref (
const int2 gid,
const int2 lid,
const int2 grpSize,
const int padSizeTile,						// (padSizeTile, padSizeTile) on I_us32FC4 maps to where tile_dstC1, ... point to.
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) on I_sm32FC4 and I_sr32FC4 map to where block_srC1, block_smC1, ... point to.
__read_only image2d_t I_sm32FC4,
__read_only image2d_t I_us32FC4,
const int tile_x,							// dstTile.left: absolute upper left x coordinate for this tile (maps to (padSizeTile, padSizetile)).  sint32 ux = tile_x + cx;
const int tile_y,							// dstTile.top
const int block_x,							// refRect.left, dx = sint32(std::floor((ux+0.5f)/1.5f)) - block_x; (may not maps to (padSizeBlock, padSizeBlock)).
const int block_y,							// refRect.top
__local int2* closestPatchShiftBuf
) {
float4 tmpValue;
// Search for left, top, right, bottom, and center
// fill 16x8
float ssdOld = MAXFLOAT;
const int cShift = -1 - 4;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = (gid.x << 1) + cShift;	// relative patch center location based on tile_x for I_us
int cy = (gid.y << 1) + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 4)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 4)] = 0;
}
}
}
// fill 4x8
if (lid.x < 4)
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = (gid.x << 1) + (grpSize.x << 1) + cShift;	// relative patch center location based on tile_x
int cy = (gid.y << 1) + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 4)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 4)] = 0;
}
}
}
}
// fill 16x4
if (lid.y < 4)
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = (gid.x << 1) + cShift;	// relative patch center location based on tile_x
int cy = (gid.y << 1) + (grpSize.y << 1) + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 4)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = 0;
}
}
}
}
// fill 4x4
if ((lid.x < 4) & (lid.y < 4))
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = (gid.x << 1) + (grpSize.x << 1) + cShift;	// relative patch center location based on tile_x
int cy = (gid.y << 1) + (grpSize.y << 1) + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 4)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = 0;
}
}
}
}
}
// Reference Code for param.nStep = 3
void closestPatchSearchNStep3Ref (
const int2 gid,
const int2 lid,
const int2 grpSize,
const int padSizeTile,						// (padSizeTile, padSizeTile) on I_us32FC4 maps to where tile_usC1, ... point to.
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) on I_sm32FC4 and I_sr32FC4 map to where block_srC1, block_smC1, ... point to.
__read_only image2d_t I_sm32FC4,
__read_only image2d_t I_us32FC4,
const int tile_x,							// dstTile.left: absolute upper left x coordinate for this tile (maps to (padSizeTile, padSizetile)).  sint32 ux = tile_x + cx;
const int tile_y,							// dstTile.top
const int block_x,							// refRect.left, dx = sint32(std::floor((ux+0.5f)*UpscaleFactorRecip)) - block_x; (may not maps to (padSizeBlock, padSizeBlock)).
const int block_y,							// refRect.top
__local int2* closestPatchShiftBuf
) {
float4 tmpValue;
// Search for left, top, right, bottom, and center
// fill 16x8
float ssdOld = MAXFLOAT;
const int cShift = -3;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = gid.x*3 + cShift;	// relative patch center location based on tile_usC1
int cy = gid.y*3 + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if ((searchIdx < 4))
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// fill 16x8 into 18 x 10 virtual buf size, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 2)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 2)] = 0;
}
}
}
// fill 2x8
if (lid.x < 2)
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = (gid.x + grpSize.x)*3 + cShift;	// relative patch center location based on tile_x
int cy = gid.y*3 + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 18 x 10, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 2)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 2)] = 0;
}
}
}
}
// fill 16x2
if (lid.y < 2)
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = gid.x*3 + cShift;	// relative patch center location based on tile_x
int cy = (gid.y + grpSize.y)*3 + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 18 x 10, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 2)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 2)] = 0;
}
}
}
}
// fill 2x2
if (lid.x < 2 && lid.y < 2)
{
ssdOld = MAXFLOAT;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
int cx = (gid.x + grpSize.x)*3 + cShift;	// relative patch center location based on tile_x
int cy = (gid.y + grpSize.y)*3 + cShift;
int dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = (int)((tile_y + cy + 0.5f)*UpscaleFactorRecip) - block_y + XYsCStage1[searchIdx].y;
for (int row = 0; row < 5; ++row)
{
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx - 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx - 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 1, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 1, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(padSizeTile + cx + 2, padSizeTile + cy - 2 + row))
- read_imagef(I_sm32FC4, sampler, (int2)(padSizeBlock + dx + 2, padSizeBlock + dy - 2 + row));
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 18 x 10, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 2)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 2)] = 0;
}
}
}
}
}
// For a 16x8 workgroup size, each workgroup is responsible for 16x8 patches.
// Here, we do "divided and conquer": In reality, to generate 16x8 patches, each workgroup needs to handle 20x12 patches.
// For each workgroup, closestPatchSearch() will generate 20x12 elements for closestPatchShiftBuf.
// Each closestPatchSearch() call handles 7x3 patches using all 16x8 work-items.
// (dx, dy) on smC1, ... maps to (cx, cy) on usC1, ..., where (cx, cy) is the center of patches on usC1, ...
// (dx, dy) is determined by dx = sint32(std::floor((ux+0.5f)*UpscaleFactorRecip)) - block_x;
// (ux, uy) is determined by sint32 ux = tile_x + cx;
void closestPatchSearch (
const int2 offset,							// offset of upper left corner for each 7x3 patches sub-group (0, 0), (14, 0), (28, 0), etc.
const int2 patchSubGrpSize,					// 7x3 or 6x3 patches
const int2 gid,
const int2 lid,
const int2 grpSize,
const int padSizeTile,						// (padSizeTile, padSizeTile) on I_us32FC4 maps to where tile_dstC1, ... point to.
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) on I_sm32FC4 and I_sr32FC4 map to where block_srC1, block_smC1, ... point to.
__read_only image2d_t I_sm32FC4,
__read_only image2d_t I_us32FC4,
__local float* I_us32FP4LBuf,				// sizeof(cl_float)*(workgroupSize[0] + 1)*(workgroupSize[1] + 1)*4
const int I_us32FP4LBufP1WidthStep,			// The width step (in pixel) of each one of the planar image in I_us32FP4Buf.
const int I_us32FP4LBufP1Height,			// The height (in pixel) of each one of the planar image in I_us32FP4LBuf.
__local float* I_sm32FP4LBuf,				// sizeof(cl_float)*(workgroupSize[0] + 1)*((workgroupSize[1] + 1 + 0.75f)*UpscaleFactorRecip)*4
const int I_sm32FP4LBufP1WidthStep,			// The width step (in pixel) of each one of the planar image in I_sm32FP4Buf
const int I_sm32FP4LBufP1Height,			// The height (in pixel) of each one of the planar image in I_sm32FP4Buf
__local int2* closestPatchShiftBuf,
const int tile_x,							// dstTile.left: absolute upper left x coordinate for this tile (maps to (padSizeTile, padSizetile)).  sint32 ux = tile_x + cx;
const int tile_y,							// dstTile.top
const int block_x,							// refRect.left, dx = sint32(std::floor((ux+0.5f)*UpscaleFactorRecip)) - block_x; (may not maps to (padSizeBlock, padSizeBlock)).
const int block_y							// refRect.top
) {
// Center coordinate of each patch: gid*2 + padSize.
// gSubWorkGroupULPos: global absolute coordinate of the upper left corner pixel of the sub 7x3 patches region in the workgroup
const int2 gSubWorkGroupULPos = (padSizeTile - 1) + (gid << 1) - (lid << 1) - 2 - 4 + offset;  // - 4 to shift to over-compute area.
// Fill I_us32FP4LBuf: (grpW + 1) x (grpH + 1) x 4.
{
// Fill grpW x grpH area
const float4 tmpValue = read_imagef(I_us32FC4, sampler, gSubWorkGroupULPos + lid);	// each work-item handles one pixel for now.
const int bufWritePos = lid.x + lid.y*I_us32FP4LBufP1WidthStep;
const int planarStep = I_us32FP4LBufP1WidthStep*I_us32FP4LBufP1Height;
I_us32FP4LBuf[bufWritePos] = tmpValue.s0;
I_us32FP4LBuf[bufWritePos + planarStep] = tmpValue.s1;
I_us32FP4LBuf[bufWritePos + 2*planarStep] = tmpValue.s2;
I_us32FP4LBuf[bufWritePos + 3*planarStep] = tmpValue.s3;
}
if (lid.x == 0)  // Fill the last col (at column grpSize.x) (size of 1 x grpSize.y)
{
const float4 tmpValue = read_imagef(I_us32FC4, sampler, (int2)(gSubWorkGroupULPos.x + grpSize.x, gSubWorkGroupULPos.y + lid.y));
const int bufWritePos = grpSize.x + lid.y*I_us32FP4LBufP1WidthStep;
const int planarStep = I_us32FP4LBufP1WidthStep*I_us32FP4LBufP1Height;
I_us32FP4LBuf[bufWritePos] = tmpValue.s0;
I_us32FP4LBuf[bufWritePos + planarStep] = tmpValue.s1;
I_us32FP4LBuf[bufWritePos + 2*planarStep] = tmpValue.s2;
I_us32FP4LBuf[bufWritePos + 3*planarStep] = tmpValue.s3;
}
if (lid.y == 0) // last row (row grpH)	16x1
{
const float4 tmpValue = read_imagef(I_us32FC4, sampler, (int2)(gSubWorkGroupULPos.x + lid.x, gSubWorkGroupULPos.y + grpSize.y));
const int bufWritePos = lid.x + grpSize.y*I_us32FP4LBufP1WidthStep;
const int planarStep = I_us32FP4LBufP1WidthStep*I_us32FP4LBufP1Height;
I_us32FP4LBuf[bufWritePos] = tmpValue.s0;
I_us32FP4LBuf[bufWritePos + planarStep] = tmpValue.s1;
I_us32FP4LBuf[bufWritePos + 2*planarStep] = tmpValue.s2;
I_us32FP4LBuf[bufWritePos + 3*planarStep] = tmpValue.s3;
}
if (!(lid.x + lid.y))
{
const float4 tmpValue = read_imagef(I_us32FC4, sampler, gSubWorkGroupULPos + grpSize);
const int bufWritePos = grpSize.x + grpSize.y*I_us32FP4LBufP1WidthStep;
const int planarStep = I_us32FP4LBufP1WidthStep*I_us32FP4LBufP1Height;
I_us32FP4LBuf[bufWritePos] = tmpValue.s0;
I_us32FP4LBuf[bufWritePos + planarStep] = tmpValue.s1;
I_us32FP4LBuf[bufWritePos + 2*planarStep] = tmpValue.s2;
I_us32FP4LBuf[bufWritePos + 3*planarStep] = tmpValue.s3;
}
// I_us32FP4Buf is filled ......
// Fill I_sm32FP4LBuf: I_sm32FP4LBufP1WidthStep x I_sm32FP4LBufP1Height x 4
// From (patch center coordinate of I_us + 0.5f)*UpscaleFactorRecip,
// the following will store the coresponding part of I_sm into I_sm32FP4Buf.
// Due to the uncertainty, we need to calculate the caching range here.
{
// Fill grpSize.x*grpSize.y
// upper left corner:
// cx = - 3 - 2 + offset.x + (gid.x << 1) - (lid.x << 1)
// dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x;
// I_sm32FP4BufULPatchCenterPos = padSizeBlock + dx.
const int2 I_sm32FP4BufULPatchCenterPos = padSizeBlock + (const int2)(
(int)((tile_x + (-5 + (gid.x << 1) - (lid.x << 1) + offset.x) + 0.5f)*UpscaleFactorRecip) - block_x,
(int)((tile_y + (-5 + (gid.y << 1) - (lid.y << 1) + offset.y) + 0.5f)*UpscaleFactorRecip) - block_y);	// -4 for over compute area
// cx = -3 - 2 + offset.x + (gid.x << 1) - (lid.x << 1) + grpSize - 4
const int2 I_sm32FP4BufLRPatchCenterPos = padSizeBlock + (const int2)(
(int)((tile_x + (- 5 + (gid.x << 1) - (lid.x << 1) + grpSize.x - 4 + offset.x) + 0.5f)*UpscaleFactorRecip) - block_x,
(int)((tile_y + (- 5 + (gid.y << 1) - (lid.y << 1) + grpSize.y - 4 + offset.y) + 0.5f)*UpscaleFactorRecip) - block_y);
// need to add extra one row and col on each side of the cache (we need to shift to the left/right/bottom/top to search for closest patch)
// adding extra two rows and two cols for patch search offsets
// (I_sm32FP4BufLRPatchCenterPos.x - I_sm32FP4BufULPatchCenterPos.x + 1) + 4 + 2(extra two rows/cols for search purpose)
if ((lid.x < I_sm32FP4BufLRPatchCenterPos.x - I_sm32FP4BufULPatchCenterPos.x + 7) & (lid.y < I_sm32FP4BufLRPatchCenterPos.y - I_sm32FP4BufULPatchCenterPos.y + 7))
{
const float4 tmpValue = read_imagef(I_sm32FC4, sampler, I_sm32FP4BufULPatchCenterPos - 3 + lid);	// -2 - 1 for extra row and col.
const int bufWritePos = lid.x + lid.y*I_sm32FP4LBufP1WidthStep;
const int planarStep = I_sm32FP4LBufP1WidthStep*I_sm32FP4LBufP1Height;
I_sm32FP4LBuf[bufWritePos] = tmpValue.s0;
I_sm32FP4LBuf[bufWritePos + planarStep] = tmpValue.s1;
I_sm32FP4LBuf[bufWritePos + 2*planarStep] = tmpValue.s2;
I_sm32FP4LBuf[bufWritePos + 3*planarStep] = tmpValue.s3;
}
}
// I_sm32FP4Buf is filled ......
barrier(CLK_LOCAL_MEM_FENCE);
// find the closest patch for this sub workgroup...... // may be improved later
// add the for loop for top, bottom, right, left.
//
// We only use 7x3 or 6x3 work-items for now... (not efficient yet), each work-item handles one patch only.
if ((lid.x < patchSubGrpSize.x) & (lid.y < patchSubGrpSize.y))
{
int2 I_usPatchAccessPos = lid << 1;	// upper left corner of each patch.
// upper left corner:
// cx = - 3 - 2 + offset.x + (gid.x << 1) - (lid.x << 1)
// dx = (int)((tile_x + cx + 0.5f)*UpscaleFactorRecip) - block_x;
// I_sm32FP4BufULPatchCenterPos = padSizeBlock + dx.
const int2 I_sm32FP4BufULPatchCenterPos = padSizeBlock + (const int2)(
(int)((tile_x + (-5 + (gid.x << 1) - (lid.x << 1) + offset.x) + 0.5f)*UpscaleFactorRecip) - block_x,
(int)((tile_y + (-5 + (gid.y << 1) - (lid.y << 1) + offset.y) + 0.5f)*UpscaleFactorRecip) - block_y);	// -4 for over compute area
const int2 I_sm32FP4BufPatchCenterPos = padSizeBlock + (const int2)(
(int)((tile_x + (-5 + (gid.x << 1) + offset.x) + 0.5f)*UpscaleFactorRecip) - block_x,
(int)((tile_y + (-5 + (gid.y << 1) + offset.y) + 0.5f)*UpscaleFactorRecip) - block_y);	// -4 for over compute area
const int I_usPlanarStep = I_us32FP4LBufP1WidthStep*I_us32FP4LBufP1Height;
const int I_smPlanarStep = I_sm32FP4LBufP1WidthStep*I_sm32FP4LBufP1Height;
float4 tmpValue;
float ssdOld = MAXFLOAT;
// Search for left, top, right, bottom, and center
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
float ssd = 0.0f;
// + 1 is due to the offset for extra row and col.  So + 1 is the center patch search.
int2 I_smPatchAccessPos = I_sm32FP4BufPatchCenterPos - I_sm32FP4BufULPatchCenterPos + 1 + XYsCStage1[searchIdx];
for (int row = 0; row < 5; ++row)
{
//tmpValue.s0 = I_us32FP4LBuf[I_usPatchAccessPos.x + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep]
//	- I_sm32FP4LBuf[I_smPatchAccessPos.x + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep];
//tmpValue.s1 = I_us32FP4LBuf[I_usPatchAccessPos.x + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + I_usPlanarStep]
//	- I_sm32FP4LBuf[I_smPatchAccessPos.x + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + I_smPlanarStep];
//tmpValue.s2 = I_us32FP4LBuf[I_usPatchAccessPos.x + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1)]
//	- I_sm32FP4LBuf[I_smPatchAccessPos.x + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1)];
//tmpValue.s3 = I_us32FP4LBuf[I_usPatchAccessPos.x + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1) + I_usPlanarStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1) + I_smPlanarStep];
int I_usAccessIdx = I_usPatchAccessPos.x + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep;
int I_smAccessIdx = I_smPatchAccessPos.x + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep;
tmpValue = (float4)(
I_us32FP4LBuf[I_usAccessIdx] - I_sm32FP4LBuf[I_smAccessIdx],
I_us32FP4LBuf[I_usAccessIdx + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + I_smPlanarStep],
I_us32FP4LBuf[I_usAccessIdx + (I_usPlanarStep << 1)] - I_sm32FP4LBuf[I_smAccessIdx + (I_smPlanarStep << 1)],
I_us32FP4LBuf[I_usAccessIdx + (I_usPlanarStep << 1) + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + (I_smPlanarStep << 1) + I_smPlanarStep]
);
ssd += dot(tmpValue, tmpValue);
//tmpValue.s0 = I_us32FP4LBuf[I_usPatchAccessPos.x + 1 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep]
//	- I_sm32FP4LBuf[I_smPatchAccessPos.x + 1 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep];
//tmpValue.s1 = I_us32FP4LBuf[I_usPatchAccessPos.x + 1 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + I_usPlanarStep]
//	- I_sm32FP4LBuf[I_smPatchAccessPos.x + 1 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + I_smPlanarStep];
//tmpValue.s2 = I_us32FP4LBuf[I_usPatchAccessPos.x + 1 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1)]
//	- I_sm32FP4LBuf[I_smPatchAccessPos.x + 1 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1)];
//tmpValue.s3 = I_us32FP4LBuf[I_usPatchAccessPos.x + 1 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1) + I_usPlanarStep]
//	- I_sm32FP4LBuf[I_smPatchAccessPos.x + 1 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1) + I_smPlanarStep];
tmpValue = (float4)(
I_us32FP4LBuf[I_usAccessIdx + 1] - I_sm32FP4LBuf[I_smAccessIdx + 1],
I_us32FP4LBuf[I_usAccessIdx + I_usPlanarStep + 1] - I_sm32FP4LBuf[I_smAccessIdx + 1 + I_smPlanarStep],
I_us32FP4LBuf[I_usAccessIdx + 1 + (I_usPlanarStep << 1)] - I_sm32FP4LBuf[I_smAccessIdx + 1 + (I_smPlanarStep << 1)],
I_us32FP4LBuf[I_usAccessIdx + 1 + (I_usPlanarStep << 1) + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + 1 + (I_smPlanarStep << 1) + I_smPlanarStep]
);
ssd += dot(tmpValue, tmpValue);
//tmpValue.s0 = I_us32FP4LBuf[I_usPatchAccessPos.x + 2 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 2 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep];
//tmpValue.s1 = I_us32FP4LBuf[I_usPatchAccessPos.x + 2 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + I_usPlanarStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 2 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + I_smPlanarStep];
//tmpValue.s2 = I_us32FP4LBuf[I_usPatchAccessPos.x + 2 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1)]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 2 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1)];
//tmpValue.s3 = I_us32FP4LBuf[I_usPatchAccessPos.x + 2 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1) + I_usPlanarStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 2 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1) + I_smPlanarStep];
tmpValue = (float4)(
I_us32FP4LBuf[I_usAccessIdx + 2] - I_sm32FP4LBuf[I_smAccessIdx + 2],
I_us32FP4LBuf[I_usAccessIdx + 2 + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + 2 + I_smPlanarStep],
I_us32FP4LBuf[I_usAccessIdx + 2 + (I_usPlanarStep << 1)] - I_sm32FP4LBuf[I_smAccessIdx + 2 + (I_smPlanarStep << 1)],
I_us32FP4LBuf[I_usAccessIdx + 2 + (I_usPlanarStep << 1) + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + 2 + (I_smPlanarStep << 1) + I_smPlanarStep]
);
ssd += dot(tmpValue, tmpValue);
//tmpValue.s0 = I_us32FP4LBuf[I_usPatchAccessPos.x + 3 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 3 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep];
//tmpValue.s1 = I_us32FP4LBuf[I_usPatchAccessPos.x + 3 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + I_usPlanarStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 3 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + I_smPlanarStep];
//tmpValue.s2 = I_us32FP4LBuf[I_usPatchAccessPos.x + 3 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1)]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 3 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1)];
//tmpValue.s3 = I_us32FP4LBuf[I_usPatchAccessPos.x + 3 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1) + I_usPlanarStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 3 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1) + I_smPlanarStep];
tmpValue = (float4)(
I_us32FP4LBuf[I_usAccessIdx + 3] - I_sm32FP4LBuf[I_smAccessIdx + 3],
I_us32FP4LBuf[I_usAccessIdx + 3 + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + 3 + I_smPlanarStep],
I_us32FP4LBuf[I_usAccessIdx + 3 + (I_usPlanarStep << 1)] - I_sm32FP4LBuf[I_smAccessIdx + 3 + (I_smPlanarStep << 1)],
I_us32FP4LBuf[I_usAccessIdx + 3 + (I_usPlanarStep << 1) + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + 3 + (I_smPlanarStep << 1) + I_smPlanarStep]
);
ssd += dot(tmpValue, tmpValue);
//tmpValue.s0 = I_us32FP4LBuf[I_usPatchAccessPos.x + 4 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 4 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep];
//tmpValue.s1 = I_us32FP4LBuf[I_usPatchAccessPos.x + 4 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + I_usPlanarStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 4 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + I_smPlanarStep];
//tmpValue.s2 = I_us32FP4LBuf[I_usPatchAccessPos.x + 4 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1)]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 4 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1)];
//tmpValue.s3 = I_us32FP4LBuf[I_usPatchAccessPos.x + 4 + (I_usPatchAccessPos.y + row)*I_us32FP4LBufP1WidthStep + (I_usPlanarStep << 1) + I_usPlanarStep]
//- I_sm32FP4LBuf[I_smPatchAccessPos.x + 4 + (I_smPatchAccessPos.y + row)*I_sm32FP4LBufP1WidthStep + (I_smPlanarStep << 1) + I_smPlanarStep];
tmpValue = (float4)(
I_us32FP4LBuf[I_usAccessIdx + 4] - I_sm32FP4LBuf[I_smAccessIdx + 4],
I_us32FP4LBuf[I_usAccessIdx + 4 + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + 4 + I_smPlanarStep],
I_us32FP4LBuf[I_usAccessIdx + 4 + (I_usPlanarStep << 1)] - I_sm32FP4LBuf[I_smAccessIdx + 4 + (I_smPlanarStep << 1)],
I_us32FP4LBuf[I_usAccessIdx + 4 + (I_usPlanarStep << 1) + I_usPlanarStep] - I_sm32FP4LBuf[I_smAccessIdx + 4 + (I_smPlanarStep << 1) + I_smPlanarStep]
);
ssd += dot(tmpValue, tmpValue);
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
closestPatchShiftBuf[lid.x + (offset.x >> 1) + (lid.y + (offset.y >> 1))*(grpSize.x + 4)] =  XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftBuf[lid.x + (offset.x >> 1) + (lid.y + (offset.y >> 1))*(grpSize.x + 4)] = 0;
}
}
}
}
}
////////////////////////////////////////////////////////////////////////////////
// When output image size is {w, h}, work-item dimentions should be {roundUp(w/2), roundUp(h/w)} (without padding).
// Each work-item is responsible for one 5x5 patch
// Note:
// In UpscalePS.cpp CPU code, AdaptUpscaleParam(...) adjusts param.nStep (patches are selected by every nStep pixels).
//
// inputImageRGBA32F: normalized padded RGBA image ranging from 0.0f ~ 1.0f.
// outputImage32FC4: denoised RGBA image ranging from 0.0f ~ 1.0f.
// http://developer.download.nvidia.com/compute/cuda/1.1-betaBuf/x86_website/projects/scan/doc/scan.pdf can be implemented later.
//
////////////////////////////////////////////////////////////////////////////////
// Safeguard design of EdgeEnlargeUPSNStep?Image2dRGBA32f(...) for write_imagef(...)
// Consider the upper left corner as relative coordinate of each 5x5 patch as (0, 0), so you have
// (0, 0), (1, 0), (2, 0), (3, 0), (4, 0)
// (0, 1), (1, 1), (2, 1), (3, 1), (4, 1)
// (0, 2), (1, 2), (2, 2), (3, 2), (4, 2)
// (0, 3), (1, 3), (2, 3), (3, 3), (4, 3)
// (0, 4), (1, 4), (2, 4), (3, 4), (4, 4)
//
// For nStep == 1, each work-item generates an output which is the final result at patch center (2, 2) itself.
// (2, 2)
//
// For nStep == 2, each work-item will generate the output of one patch which is
// (3, 3), (4, 3),
// (3, 4), (4, 4).
//
// For nStep == 3, each work-item will generate the output of one patch which is
// (2, 2), (3, 2), (4, 2);
// (2, 3), (3, 3), (4, 3);
// (2, 4), (3, 4), (4, 4).
//
// Output Safeguard:
//
// P: paddings, X: the place to put the final output (the width of X X X X X area is outputImageW).
//
//                                                                  Should be the last work-item that can perform the output operation.
//                                                                  |
//                                                                  V
// P P P P P P P P P P X X X X ... <---- outputImageW ----> ... X X X X X P P P P P P P P P P
////////////////////////////////////////////////////////////////////////////////
__constant int2 grpSize = (__constant int2)(16, 8);
//////////////////////////////////////////////////////////////////////////////////////////////////
// Upscale Stage 1 (Closest Patch Searches) Optimization Strategies Version 1:
// * Do not do overcompute, use the global buffer to pass the closest patch information to stage 2
//   instead of using local memory to store the closest patch location (which required overcompute.
//   (for nStep == 1, or others, the overcompute is too harmful for the overall performance,
//   that means, use the global memory to store the closest patch location may not be that bad.).
//
// * Reload the global memory into the local memory in Stage 2.
//
// I_sr32FC4: original input image (properly padded).  362 x 362
// I_us32FC4: bicubic upscaled image, size: 1.5 x I_sr (properly padded). 532 x 532
// I_sm32FC4: blurred image, size: 1.0 x I_sr (properly padded).  362 x 362
//
// Each image: 32-bit floating point/channel, 4-Channels image => 128 bits per pixels for 4 channels.
//////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef GLOBAL_CLOSEST_PATCH_BUF

__kernel /*__attribute__((reqd_work_group_size(16, 8, 1)))*/
void EdgeEnlargeUPSNStep1Image2dRGBA32fStage1 (
__read_only image2d_t I_sr32FC4,            // original input image (properly padded).
__read_only image2d_t I_us32FC4,            // bicubic upscaled image, size: 1.5 x I_sr (properly padded)
__read_only image2d_t I_sm32FC4,			// blurred image, size: 1.0 x I_sr (properly padded)
const int outputImageW,						// width of non-padded I_us: tile_cols of UpscaleC3() in UpscalePS.cpp. => 512
const int outputImageH,						// height of non-padded I_us: tile_rows of UpscaleC3() in UpscalePS.cpp. => 512
const int padSizeTile,						// (padSizeTile, padSizeTile) coordinate on image2D points to the (tile_x, tile_y) global coordinate for I_us. => 10
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) coordinate on image2D points to the (block_x, block_y) global coordinate for I_sm, I_sr. => 10
__local float4* SLM_us32FP4,				// SLM for I_us32FC4
const int widthStep_SLM_us,			        // The width Step (in pixel) of SLM for I_us32FC4. => 2 extra on each side to make 5 x 5 patch around localWorkSize => localWorkSize[0] + 4;
const int height_SLM_us,			        // The height (in pixel) of SLM for I_us32FC4. => 2 extra on each side to make 5 x 5 patch around localWorkSize => localWorkSize[1] + 4;
__local float4* SLM_sm32FP4,				// SLM for I_sm32FC4
const int widthStep_SLM_sm,			        // The width Step (in pixel) of SLM for I_sm32FC4. => 3 extra on each side to make 7 x 7 patch around localWorkSize => localWorkSize[0] + 6;
const int height_SLM_sm,			        // The height (in pixel) of SLM for I_us32FC4. => 3 extra on each side to make 7 x 7 patch around localWorkSize => localWorkSize[1] + 6;
__global int2* closestPatchShiftGlobalBuf,	// sizeof(cl_int)*2*(outputImageW + 8)*(outputImageH + 8) => 8*520*520 = 2163200
const int closestPatchShiftGlobalBufStep,	// The width Step (in pixel). => 520
const int tile_x,							// Absolute global tile begin coordinate for tile_usC1, ... pointer in the CPU code. Passing from Upscale CPU function. 1536
const int tile_y,                           // 1024
const int block_x,                          // 1024
const int block_y                           // 682
) {
const int2 grpSize = (int2)(get_local_size(0), get_local_size(1));
const int2 lid = (const int2)(get_local_id(0), get_local_id(1));
// Each gId handles one patch.
const int2 gid = (const int2)(get_global_id(0), get_global_id(1));
float ssdOld = MAXFLOAT;
float ssd = 0.0f;
float4 tmpValue;
int i_us = 0; // usBuffer index
int i_sm = 0; // smBuffer index
int row, col;
int2 indexAdjust;
const int cShift = -4;	                // shift 4 to overcomputed area prepared for stage 2.
const int cShiftedX = gid.x + cShift;	// relative patch center location based on tile_x for I_us
const int cShiftedY = gid.y + cShift;
// usX, usY: origin to read widthStep_SLM_us x height_SLM_us patch from I_us32FC4 into SLM
int usX = padSizeTile + cShiftedX - 2;
int usY = padSizeTile + cShiftedY - 2;
//Initialize Shared local memory: widthStep_SLM_us x height_SLM_us region from I_us32FC4
for (row = lid.y, indexAdjust.y = 0; row < height_SLM_us; row += grpSize.y, indexAdjust.y += grpSize.y)
{
for (col = lid.x, indexAdjust.x = 0; col < widthStep_SLM_us; col += grpSize.x, indexAdjust.x += grpSize.x)
{
int index = row * widthStep_SLM_us + col;
SLM_us32FP4[index] = read_imagef(I_us32FC4, sampler, (int2)(usX + indexAdjust.x, usY + indexAdjust.y));
}
}
// smCenterX, smCenterY : Center of the spiral search to read from I_sm32FC4
const int csmCenterX = (int)((tile_x + cShiftedX + 0.5f)*UpscaleFactorRecip) - block_x + padSizeBlock - 2;
const int csmCenterY = (int)((tile_y + cShiftedY + 0.5f)*UpscaleFactorRecip) - block_y + padSizeBlock - 2;
// smX, smY: starting coordinate to read widthStep_SLM_sm x height_SLM_sm patch from I_sm32FC4
int smX = (int)((tile_x + gid.x - lid.x + cShift + 0.5f)*UpscaleFactorRecip) - block_x + padSizeBlock + lid.x - 3;
int smY = ((tile_y + gid.y - lid.y + cShift + 0.5f)*UpscaleFactorRecip) - block_y + padSizeBlock - 2 + lid.y - 1;
//Initialize Shared local memory: widthStep_SLM_sm x height_SLM_sm region from I_sm32FC4
for (row = lid.y, indexAdjust.y = 0; row < height_SLM_sm; row += grpSize.y, indexAdjust.y += grpSize.y)
{
for (col = lid.x, indexAdjust.x = 0; col < widthStep_SLM_sm; col += grpSize.x, indexAdjust.x += grpSize.x)
{
int index = col + row * widthStep_SLM_sm;
SLM_sm32FP4[index] = read_imagef(I_sm32FC4, sampler, (int2)(smX + indexAdjust.x, smY + indexAdjust.y));
}
}
barrier(CLK_LOCAL_MEM_FENCE); // Done with the SLM_us32FP4 and SLM_sm32FP4
// Every work item in the workgroup handles one patch.  For each workgroup, the two patches near the top, bottom, left, and right boundaries are for overcompute.
// Need extra 8 work-items to fill the whole closestPatchPos
// Actually, for nStep == 1, we only need extra 4 (2 at each side)), since in stage 2, each gid only output the center pixel for each patch.
if ((gid.x > outputImageW + 7) | (gid.y > outputImageH + 7))
return;
//int2 XYsCStage1[5] = { (0,  1), (1,  0), (0, -1), (-1,  0), (0, 0) };
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
// dx, dy: Top-Center coordinate to read 5x5 patch from I_sm32FC4
// For each search, dx, dy shifts from smCenterX,Y to bottom, right, top, left, center respectively in spiral fashion
int dx = csmCenterX + XYsCStage1[searchIdx].x;	 // relative patch center location based on smC
int dy = csmCenterY + XYsCStage1[searchIdx].y;
i_us = lid.y * widthStep_SLM_us + lid.x; // Reset usBuffer index to the correct start origin
i_sm = (dy + lid.y - smY)*widthStep_SLM_sm + (dx + lid.x - smX); // Reset smBuffer index to the correct start origin
for (row = 0; row < 5; row++)
{
for (col = 0; col < 5; col++)
{
tmpValue = SLM_us32FP4[i_us + col] - SLM_sm32FP4[i_sm + col];
ssd += dot(tmpValue, tmpValue);
}
i_us += widthStep_SLM_us;
i_sm += widthStep_SLM_sm;
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
closestPatchShiftGlobalBuf[gid.x + gid.y*closestPatchShiftGlobalBufStep] = XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftGlobalBuf[gid.x + gid.y*closestPatchShiftGlobalBufStep] = 0;
}
}
ssd = 0.0f;
}
}
#endif

__kernel /*__attribute__((reqd_work_group_size(16, 8, 1)))*/
void EdgeEnlargeUPSNStep1Image2dRGBA32f (
__read_only image2d_t I_sr32FC4,			// original input image (properly padded).
__read_only image2d_t I_us32FC4,			// bicubic upscaled image, size: 1.5 x I_sr (properly padded)
__read_only image2d_t I_sm32FC4,			// blurred image, size: 1.0 x I_sr (properly padded)
__read_only image2d_t I_R32FC4,				// R component: each pixel in I_R32FC4 represents a patch in I_us.  I_R32FC4 size should be as (ecols, erows) in UpscaleC3 in UpscalePS.cpp.
const int outputImageW,						// width of non-padded I_us: tile_cols of UpscaleC3() in UpscalePS.cpp.
const int outputImageH,						// height of non-padded I_us: tile_rows of UpscaleC3() in UpscalePS.cpp.
__write_only image2d_t I_upscaled32FC4,		// The same size as I_us32FC4 (padded).
// !!! It has to be at least (number of patches in X dim * 2)*(number of patches in Y dim * 2) so that we do not need to have branch condition at the end.
// !!!!!! CPU should only copy the the ROI area (without the padding back from the image2d memory object).
const int padSizeTile,						// (padSizeTile, padSizeTile) coordinate on image2D points to the (tile_x, tile_y) global coordinate for I_us.
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) coordinate on image2D points to the (block_x, block_y) global coordinate for I_sm, I_sr
__local float* I_us32FP4LBuf,				// Preserved for future optimization
const int I_us32FP4LBufP1WidthStep,			// The width Step (in pixel) of each one of the planar image in I_us32FP4Buf.
const int I_us32FP4LBufP1Height,			// The height (in pixel) of each one of the planar image in I_us32FP4LBuf.
__local float* I_sm32FP4LBuf,				// Preserved for future optimization
const int I_sm32FP4LBufP1WidthStep,			// The width (in pixel) of each one of the planar image in I_sm32FP4Buf
const int I_sm32FP4LBufP1Height,			// The height (in pixel) of each one of the planar image in I_sm32FP4Buf
#ifdef GLOBAL_CLOSEST_PATCH_BUF
__global int2* closestPatchShiftGlobalBuf,	// sizeof(cl_int)*2*(outputImageW + 8)*(outputImageH + 8)
const int closestPatchShiftGlobalBufStep,	// The width Step (in pixel).
#endif
__local int2* closestPatchShiftBuf,			// sizeof(cl_int2)*(workgroupSize[0] + 8)*(workgroupSize[1] + 8)
const int tile_x,							// Absolute global tile begin coordinate for tile_usC1, ... pointer in the CPU code. Passing from Upscale CPU function
const int tile_y,
const int block_x,
const int block_y
#ifdef USE_PS_STAGE1
,
__read_only image2d_t I_closestPatchShiftX,
__read_only image2d_t I_closestPatchShiftY
#endif
) {
//const int2 grpSize = (int2)(get_local_size(0), get_local_size(1));
const int2 lid= (const int2)(get_local_id(0), get_local_id(1));
// Each gId handles one patch.
const int2 gid = (const int2)(get_global_id(0), get_global_id(1));
// Every work item in the workgroup handles one patch.  For each workgroup, the two patches near the top, bottom, left, and right boundaries are for overcompute.
// globalOutputPos: center of a patch.
const int2 gOutputPos = gid + padSizeTile;	// Patch center coordinate
// gOutputPos is the center of the patches.
{
//////////////////////////////////////////////////////////////////////////////////////
// Stage 1: find the closest patch in I_sm with respect to each of the patch in I_us
//////////////////////////////////////////////////////////////////////////////////////
// 1. Each work-item handles one 5x5 patch.
// 2. Every other pixel is the center of a patch.
// 3. Uses multiple passes to save the local memory usage.
// o o x x x ... x x x o o -> o: overcompute patches, x: the patches that generate the results (including I_hf).
// search five patches
#ifdef USE_PS_STAGE1_REF_CODE
#ifndef GLOBAL_CLOSEST_PATCH_BUF
closestPatchSearchNStep1Ref (gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, tile_x, tile_y, block_x, block_y, closestPatchShiftBuf);
#endif
#else
// Offset (0, 0): 7x3 patches
closestPatchSearch (
(int2)(0, 0), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (14, 0): 7x3 patches
closestPatchSearch (
(int2)(14, 0), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (28, 0): 6x3 patches
closestPatchSearch (
(int2)(28, 0), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (0, 6): 7x3
closestPatchSearch (
(int2)(0, 6), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 6): 7x3
closestPatchSearch (
(int2)(14, 6), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 6): 6x3
closestPatchSearch (
(int2)(28, 6), (int2)(6, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (0, 12): 7x3 patches
closestPatchSearch (
(int2)(0, 12), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 12): 7x3 patches
closestPatchSearch (
(int2)(14, 12), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 12): 6x3 patches
closestPatchSearch (
(int2)(28, 12), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (0, 18): 7x3
closestPatchSearch (
(int2)(0, 18), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 18): 7x3
closestPatchSearch (
(int2)(14, 18), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 18): 6x3
closestPatchSearch (
(int2)(28, 18), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
#endif
}
#ifdef USE_PS_STAGE1 // Stage2/3 Verified Correct.
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 8)].x = read_imagei(I_closestPatchShiftX, sampler, gid - 1).x;
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 8)].y = read_imagei(I_closestPatchShiftY, sampler, gid - 1).x;
if (lid.x < 8)
{
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 8)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x - 1 + grpSize.x, gid.y - 1)).x;
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 8)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x - 1 + grpSize.x, gid.y - 1)).x;
}
if (lid.y < 8)
{
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 8)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x - 1, gid.y - 1 + grpSize.y)).x;
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 8)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x - 1, gid.y - 1 + grpSize.y)).x;
}
if (lid.x < 8 && lid.y < 8)
{
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 8)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x - 1 + grpSize.x, gid.y - 1 + grpSize.y)).x;
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 8)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x - 1 + grpSize.x, gid.y - 1 + grpSize.y)).x;
}
#endif
// got the closest patch position...
// 9 6 9 6 9
// 6 4 6 4 6
// 9 6 9 6 9
// 6 4 6 4 6
// 9 6 9 6 9
///////////////////////////////////////////////////////////
// Stage 2: Calculate the High Frequency Image and Stage 3
///////////////////////////////////////////////////////////
// every work-item handles lower right including the center 2x2 area
// 9 6
// 6 4
// can handle extra one padding for each dimension.
// reuse I_us32FP4LBuf
__local float* betaBuf = I_us32FP4LBuf;
// fill the betaBuf buffer (grpW + 6) x (grpH + 6) within the workgroup (with the overlapped area)
#ifndef USE_PS_R	// Not using Photoshop groundtruth R for debug purpose.
if ((gid.x < outputImageW + 8) & (gid.y < outputImageH + 8))
{
// get the first 16x8
float R = read_imagef(I_R32FC4, sampler, gid ).x; // I_R32FC4 is padded by 3 extra patches on each one the boundary.
//R = 0.0f; //!!!!!!!!
// betaBuf: 24x16 (padded from 16x8, 4 patches at eatch side)
betaBuf[lid.x + lid.y*(grpSize.x + 8)] = fmin( (R + 0.2f)*(R + 0.2f), 1.0f);
// fill the rest of the right columns: 8x8
if (lid.x < 8)
{
R = read_imagef(I_R32FC4, sampler, (int2)((gid.x + grpSize.x), gid.y)).x;
betaBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 8)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
// fill the rest of the bottom rows: 8x16
if (lid.y < 8)
{
R = read_imagef(I_R32FC4, sampler, (int2)(gid.x, (gid.y + grpSize.y))).x;
betaBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 8)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
// fill the rest 8x8
if ((lid.x < 8) & (lid.y < 8))
{
R = read_imagef(I_R32FC4, sampler, (gid + grpSize)).x;
betaBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 8)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
}
#ifdef GLOBAL_CLOSEST_PATCH_BUF
// closestPatchShiftBuf: 24x16 (padded from 16x8, 4 patches at eatch side)
// Fill 16x8
if (gid.x < outputImageW + 8 & gid.y < outputImageH + 8)
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 8)] = closestPatchShiftGlobalBuf[gid.x + gid.y *closestPatchShiftGlobalBufStep];
// fill the rest of the right columns: 8x8
if (lid.x < 8 & gid.x + grpSize.x < outputImageW + 8 & gid.y < outputImageH + 8)
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 8)] = closestPatchShiftGlobalBuf[gid.x + grpSize.x + gid.y*closestPatchShiftGlobalBufStep];
// fill the rest of the bottom rows: 16x8
if (lid.y < 8 & gid.x < outputImageW + 8 & gid.y + grpSize.y < outputImageH + 8)
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 8)] = closestPatchShiftGlobalBuf[gid.x + (gid.y + grpSize.y)*closestPatchShiftGlobalBufStep];
// fill the rest 8x8
if ((lid.x < 8) & (lid.y < 8) & gid.x + grpSize.x < outputImageW + 8 & gid.y + grpSize.y < outputImageH + 8)
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 8)] = closestPatchShiftGlobalBuf[gid.x + grpSize.x + (gid.y + grpSize.y)*closestPatchShiftGlobalBufStep];
#endif
#else
{
float R = read_imagef(I_R32FC4, sampler, gid - 1).x; // I_R32FC4 is padded by 4 extra patches on each one the boundary.
//R = 0.0f; //!!!!!!!!
// betaBuf: 24x16 (padded from 16x8)
betaBuf[lid.x + lid.y*(grpSize.x + 8)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
// fill the rest of the right columns: 4x8
if (lid.x < 8)
{
R = read_imagef(I_R32FC4, sampler, (int2)((gid.x + grpSize.x) - 1, gid.y - 1)).x;
betaBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 8)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
// fill the rest of the bottom rows: 16*4
if (lid.y < 8)
{
R = read_imagef(I_R32FC4, sampler, (int2)(gid.x - 1, gid.y + grpSize.y - 1)).x;
betaBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 8)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
if ((lid.x < 8) & (lid.y < 8))
{
R = read_imagef(I_R32FC4, sampler, gid + grpSize - 1).x;
betaBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 8)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
}
#endif
barrier(CLK_LOCAL_MEM_FENCE);	// betaBuf and closestPatchShiftBuf are done.
// gOutputPos is the center of the patches.
if ((gOutputPos.x > outputImageW + padSizeTile - 1) | (gOutputPos.y > outputImageH + padSizeTile - 1))
return;
{
// (2, 2) -> relative location in each one of the patch, contributed by 25 patches
float4 IhfValue = 0.0f, sr_sm, beta_sr_sm;
int2 accessPos1, accessPos2, oldAccessPos = (int2){0, 0};
int2 locShift;
int2 readLocShift = 0;
float beta = 0.0f;
for (int idx = 0; idx < 25; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep1[idx];
int bufIndex = lid.x + 4 + locShift.x + (lid.y + 4 + locShift.y)*(grpSize.x + 8);
readLocShift = closestPatchShiftBuf[bufIndex];
beta = betaBuf[bufIndex];
// patch center + relative patch shift location: relative shifted patch center.
// cx = gOutputPos.x + lutPatchShiftNStep2[0][idx].x // relative shift from tile_x
// dx = (int)(((gOutputPos.x + lutPatchShiftNStep2[0][idx].x + tile_x) + 0.5f)/1.5f) - block_x
// + readLocShift.x: move to the closest patch on I_sm
// - lutPatchShiftNStep2[0][idx].x: consider the patch contributes to this pixel
// + 1: since the pixel is at (3, 3)
accessPos1.x = (int)((gOutputPos.x - padSizeTile + locShift.x + tile_x + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - locShift.x + padSizeBlock;
accessPos1.y = (int)((gOutputPos.y - padSizeTile + locShift.y + tile_y + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - locShift.y + padSizeBlock;
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
beta_sr_sm = beta*sr_sm;
IhfValue += beta_sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (sr_sm - beta_sr_sm); //(1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!!!!
readLocShift = closestPatchShiftBuf[(lid.x + 1) + (lid.y + 1)*(grpSize.x + 2)];
// patch center + relative patch shift location: relative shifted patch center.
accessPos.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[0][0].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[0][0].x + padSizeBlock;
accessPos.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[0][0].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[0][0].y + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
IhfValue += beta*(read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos));
accessPos -= readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos));
#endif
}
IhfValue *= 0.04f;	// 1.0f/25.0f
write_imagef (I_upscaled32FC4, gOutputPos, read_imagef(I_us32FC4, sampler, gOutputPos) + IhfValue);
}
}
////////////////////////////////////////////////////////////////////////////////
// STEP2
////////////////////////////////////////////////////////////////////////////////
#ifdef GLOBAL_CLOSEST_PATCH_BUF

__kernel /*__attribute__((reqd_work_group_size(16, 8, 1)))*/
void EdgeEnlargeUPSNStep2Image2dRGBA32fStage1 (
__read_only image2d_t I_sr32FC4,			// original input image (properly padded).
__read_only image2d_t I_us32FC4,			// bicubic upscaled image, size: 1.5 x I_sr (properly padded)
__read_only image2d_t I_sm32FC4,			// blurred image, size: 1.0 x I_sr (properly padded)
const int outputImageW,						// width of non-padded I_us: tile_cols of UpscaleC3() in UpscalePS.cpp.
const int outputImageH,						// height of non-padded I_us: tile_rows of UpscaleC3() in UpscalePS.cpp.
const int padSizeTile,						// (padSizeTile, padSizeTile) coordinate on image2D points to the (tile_x, tile_y) global coordinate for I_us.
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) coordinate on image2D points to the (block_x, block_y) global coordinate for I_sm, I_sr
__local float4* SLM_us32FP4,				// SLM for I_us32FC4. Size = sizeof(cl_float4)*widthStep_SLM_us*height_SLM_us
const int widthStep_SLM_us,			        // The width Step (in pixel) of SLM for I_us32FC4. => 2 extra on each side to make 5 x 5 patch around localWorkSize => localWorkSize[0] + 4;
const int height_SLM_us,			        // The height (in pixel) of SLM for I_us32FC4. => 2 extra on each side to make 5 x 5 patch around localWorkSize => localWorkSize[1] + 4;
__local float4* SLM_sm32FP4,				// SLM for I_sm32FC4. Size = sizeof(cl_float4)*widthStep_SLM_sm*height_SLM_sm
const int widthStep_SLM_sm,			        // The width Step (in pixel) of SLM for I_sm32FC4. => 3 extra on each side to make 7 x 7 patch around localWorkSize => localWorkSize[0] + 6;
const int height_SLM_sm,			        // The height (in pixel) of SLM for I_us32FC4. => 3 extra on each side to make 7 x 7 patch around localWorkSize => localWorkSize[1] + 6;
__global int2* closestPatchShiftGlobalBuf,	// sizeof(cl_int)*2*(outputImageW + 8)*(outputImageH + 8)
const int closestPatchShiftGlobalBufStep,	// The width Step (in pixel).
const int tile_x,							// Absolute global tile begin coordinate for tile_usC1, ... pointer in the CPU code. Passing from Upscale CPU function
const int tile_y,
const int block_x,
const int block_y
) {
const int2 grpSize = (int2)(get_local_size(0), get_local_size(1));
const int2 lid = (const int2)(get_local_id(0), get_local_id(1));
const int2 grpid = (const int2)(get_group_id(0), get_group_id(1));
// Each gId handles one patch.
const int2 gid = (const int2)(get_global_id(0), get_global_id(1));
float ssdOld = MAXFLOAT;
float ssd = 0.0f;
float4 tmpValue;
//int i_us = 0; // usBuffer index //Disabled for direct read
int i_sm = 0; // smBuffer index
int row, col;
int2 indexAdjust;
const int cShift = -1 - 4;	// No overcompute is necessary
const int cShiftedX = (gid.x << 1) + cShift;	// relative patch center location based on tile_x for I_us
const int cShiftedY = (gid.y << 1) + cShift;
// Disabled for direct read
// usX, usY: origin to read widthStep_SLM_us x height_SLM_us patch from I_us32FC4 into SLM
/*int usX = padSizeTile + ((gid.x - lid.x) << 1) + cShift + lid.x - 2;
int usY = padSizeTile + ((gid.y - lid.y) << 1) + cShift + lid.y - 2;
//Initialize Shared local memory: widthStep_SLM_us x height_SLM_us region from I_us32FC4
for (row = lid.y, indexAdjust.y = 0; row < height_SLM_us; row += grpSize.y, indexAdjust.y += grpSize.y)
{
for (col = lid.x, indexAdjust.x = 0; col < widthStep_SLM_us; col += grpSize.x, indexAdjust.x += grpSize.x)
{
int index = row * widthStep_SLM_us + col;
SLM_us32FP4[index] = read_imagef(I_us32FC4, sampler, (int2)(usX + indexAdjust.x, usY + indexAdjust.y));
}
}*/
// csmCenterX, csmCenterY : Center point of the spiral for traversing I_sm32FC4
const int csmCenterX = (int)((tile_x + cShiftedX + 0.5f)*UpscaleFactorRecip) - block_x + padSizeBlock - 2;
const int csmCenterY = (int)((tile_y + cShiftedY + 0.5f)*UpscaleFactorRecip) - block_y + padSizeBlock - 2;
// smX, smY: Coordinate to read widthStep_SLM_sm x height_SLM_sm patch from I_sm32FC4
int smX = (int)((tile_x + ((gid.x - lid.x) << 1) + cShift + 0.5f)*UpscaleFactorRecip) - block_x + padSizeBlock + lid.x - 3;
int smY = (int)((tile_y + ((gid.y - lid.y) << 1) + cShift + 0.5f)*UpscaleFactorRecip) - block_y + padSizeBlock - 2 + lid.y - 1;
//Initialize Shared local memory: widthStep_SLM_sm x height_SLM_sm region from I_sm32FC4
for (row = lid.y, indexAdjust.y = 0; row < height_SLM_sm; row += grpSize.y, indexAdjust.y += grpSize.y)
{
for (col = lid.x, indexAdjust.x = 0; col < widthStep_SLM_sm; col += grpSize.x, indexAdjust.x += grpSize.x)
{
int index = row * widthStep_SLM_sm + col;
SLM_sm32FP4[index] = read_imagef(I_sm32FC4, sampler, (int2)(smX + indexAdjust.x, smY + indexAdjust.y));
}
}
barrier(CLK_LOCAL_MEM_FENCE); // Done with the SLM_us32FP4 and SLM_sm32FP4
// upscale handles patches by every other pixel
if ((gid.x > outputImageW + 3) | (gid.y > outputImageH + 3))
return;
// Setup for direct read
int cx = padSizeTile + cShiftedX - 2;
int cy = padSizeTile + cShiftedY - 2;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
// dx, dy: Top-Center coordinate to read 5x5 patch from I_sm32FC4
// For each search, dx, dy shifts from smCenterX,Y to bottom, right, top, left, center respectively in spiral fashion
int dx =  csmCenterX + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy =  csmCenterY + XYsCStage1[searchIdx].y;
//i_us = (lid.y*2)*widthStep_SLM_us + lid.x*2; // Reset usBuffer index to the correct start origin //Disabled for direct read
i_sm = (dy + lid.y - smY)*widthStep_SLM_sm + dx + lid.x - smX; // Reset smBuffer index to the correct start origin
for (row = 0; row < 5; row++)
{
for (col = 0; col < 5; col++)
{
//tmpValue = SLM_us32FP4[i_us + col] - SLM_sm32FP4[i_sm + col]; //Disabled for direct read
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(cx + col, cy + row)) - SLM_sm32FP4[i_sm + col];
ssd += dot(tmpValue, tmpValue);
}
//i_us += widthStep_SLM_us; //Disabled for direct read
i_sm += widthStep_SLM_sm;
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
closestPatchShiftGlobalBuf[gid.x + gid.y*closestPatchShiftGlobalBufStep] = XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
closestPatchShiftGlobalBuf[gid.x + gid.y*closestPatchShiftGlobalBufStep] = 0;
}
}
ssd = 0.0f;
}
}
#endif

__kernel /*__attribute__((reqd_work_group_size(16, 8, 1)))*/
void EdgeEnlargeUPSNStep2Image2dRGBA32f (
__read_only image2d_t I_sr32FC4,			// original input image.
__read_only image2d_t I_us32FC4,			// bicubic upscaled image, size: 1.5 x I_sr
__read_only image2d_t I_sm32FC4,			// blurred image, size: 1.0 x I_sr)
__read_only image2d_t I_R32FC4,				// R component: each pixel in I_R32FC4 represents a patch in I_us.  I_R32FC4 size should be as (ecols, erows) in UpscaleC3 in UpscalePS.cpp.
const int outputImageW,						// width of I_us, I_upscaled.
const int outputImageH,						// height of I_us, I_upscaled.
__write_only image2d_t I_upscaled32FC4,		// The same size as I_us32FC4 (padded).  !!! It has to be at least (number of patches in X dim * 2)*(number of patches in Y dim * 2) so that we do not need to have branch condition at the end.
const int padSizeTile,						// (padSizeTile, padSizeTile) coordinate on image2D points to the (tile_x, tile_y) global coordinate for I_us.
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) coordinate on image2D points to the (block_x, block_y) global coordinate for I_sm, I_sr
__local float* I_us32FP4LBuf,				// sizeof(cl_float)*(workgroupSize[0] + 1)*(workgroupSize[1] + 1)*4
const int I_us32FP4LBufP1WidthStep,			// The width Step (in pixel) of each one of the planar image in I_us32FP4Buf.
const int I_us32FP4LBufP1Height,			// The height (in pixel) of each one of the planar image in I_us32FP4LBuf.
__local float* I_sm32FP4LBuf,				// sizeof(cl_float)*(workgroupSize[0] + 1)*((workgroupSize[1] + 1 + 0.75f)/1.5f)*4
const int I_sm32FP4LBufP1WidthStep,			// The width (in pixel) of each one of the planar image in I_sm32FP4Buf
const int I_sm32FP4LBufP1Height,			// The height (in pixel) of each one of the planar image in I_sm32FP4Buf
#ifdef GLOBAL_CLOSEST_PATCH_BUF
__global int2* closestPatchShiftGlobalBuf,	// sizeof(cl_int)*2*(outputImageW + 8)*(outputImageH + 8)
const int closestPatchShiftGlobalBufStep,	// The width Step (in pixel).
#endif
__local int2* closestPatchShiftBuf,			// sizeof(cl_int2)*(workgroupSize[0] + 4)*(workgroupSize[1] + 4)
const int tile_x,							// Absolute global tile begin coordinate for tile_usC1, ... pointer in the CPU code. Passing from Upscale CPU function
const int tile_y,
const int block_x,
const int block_y
#ifdef USE_PS_STAGE1
,
__read_only image2d_t I_closestPatchShiftX,
__read_only image2d_t I_closestPatchShiftY
#endif
) {
//const int2 grpSize = (int2)(get_local_size(0), get_local_size(1));
const int2 lid= (const int2)(get_local_id(0), get_local_id(1));
// Each gId handles one patch.
const int2 gid = (const int2)(get_global_id(0), get_global_id(1));
// upscale handles patches by every other pixel
// o o o o o ... o o o o o
// o o o o o ... o o o o o
// o o x x x ... x x x o o
// o o x x x ... x x x o o
//     ...............
// o o x x x ... x x x o o
// o o o o o ... o o o o o
// o o o o o ... o o o o o
// o: overcomputed patches, x: actual useful patches.
// Every work item in the workgroup handles one patch.  For each workgroup, the two patches near the top, bottom, left, and right boundaries are for overcompute.
// globalOutputPos: center of a patch.
const int2 gOutputPos = (gid << 1) + padSizeTile - 1;	// Patch center coordinate
{
//////////////////////////////////////////////////////////////////////////////////////
// Stage 1: find the closest patch in I_sm with respect to each of the patch in I_us
//////////////////////////////////////////////////////////////////////////////////////
// 1. Each work-item handles one 5x5 patch.
// 2. Every other pixel is the center of a patch.
// 3. Uses multiple passes to save the local memory usage.
// o o x x x ... x x x o o -> o: overcompute patches, x: the patches that generate the results (including I_hf).
// search five patches
#ifdef USE_PS_STAGE1_REF_CODE
#ifndef GLOBAL_CLOSEST_PATCH_BUF
closestPatchSearchNStep2Ref (gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, tile_x, tile_y, block_x, block_y, closestPatchShiftBuf);
#endif
#else
// Offset (0, 0): 7x3 patches
closestPatchSearch (
(int2)(0, 0), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (14, 0): 7x3 patches
closestPatchSearch (
(int2)(14, 0), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (28, 0): 6x3 patches
closestPatchSearch (
(int2)(28, 0), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (0, 6): 7x3
closestPatchSearch (
(int2)(0, 6), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 6): 7x3
closestPatchSearch (
(int2)(14, 6), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 6): 6x3
closestPatchSearch (
(int2)(28, 6), (int2)(6, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (0, 12): 7x3 patches
closestPatchSearch (
(int2)(0, 12), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 12): 7x3 patches
closestPatchSearch (
(int2)(14, 12), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 12): 6x3 patches
closestPatchSearch (
(int2)(28, 12), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (0, 18): 7x3
closestPatchSearch (
(int2)(0, 18), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 18): 7x3
closestPatchSearch (
(int2)(14, 18), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 18): 6x3
closestPatchSearch (
(int2)(28, 18), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
#endif
}
#ifdef USE_PS_STAGE1 // Stage2/3 Verified Correct.
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 4)].x = read_imagei(I_closestPatchShiftX, sampler, gid - 1).x;
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 4)].y = read_imagei(I_closestPatchShiftY, sampler, gid - 1).x;
if (lid.x < 4)
{
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 4)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x - 1 + grpSize.x, gid.y - 1)).x;
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 4)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x - 1 + grpSize.x, gid.y - 1)).x;
}
if (lid.y < 4)
{
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 4)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x - 1, gid.y - 1 + grpSize.y)).x;
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 4)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x - 1, gid.y - 1 + grpSize.y)).x;
}
if (lid.x < 4 && lid.y < 4)
{
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 4)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x - 1 + grpSize.x, gid.y - 1 + grpSize.y)).x;
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 4)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x - 1 + grpSize.x, gid.y - 1 + grpSize.y)).x;
}
#endif
// got the closest patch position...
// 9 6 9 6 9
// 6 4 6 4 6
// 9 6 9 6 9
// 6 4 6 4 6
// 9 6 9 6 9
///////////////////////////////////////////////////////////
// Stage 2: Calculate the High Frequency Image and Stage 3
///////////////////////////////////////////////////////////
// every work-item handles lower right 2x2 area
// 4 6
// 6 9
// can handle extra one padding for each dimension.
// reuse I_us32FP4LBuf
__local float* betaBuf = I_us32FP4LBuf;
// fill the betaBuf buffer (grpW + 4) x (grpH + 4) within the workgroup (with the overlapped area)
#ifndef USE_PS_R
if ((gid.x < outputImageW + 4) & (gid.y < outputImageH + 4))
{
// get the first 16x8
float R = read_imagef(I_R32FC4, sampler, gid ).x; // I_R32FC4 is padded by 2 extra patches on each one the boundary.
//R = 0.0f; //!!!!!!!!
// betaBuf: 20x12 (padded from 16x8)
betaBuf[lid.x + lid.y*(grpSize.x + 4)] = fmin( (R + 0.2f)*(R + 0.2f), 1.0f);
// fill the rest of the right columns: 4x8
if (lid.x < 4)
{
R = read_imagef(I_R32FC4, sampler, (int2)((gid.x + grpSize.x), gid.y)).x;
betaBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 4)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
// fill the rest of the bottom rows: 4x16
if (lid.y < 4)
{
R = read_imagef(I_R32FC4, sampler, (int2)(gid.x, (gid.y + grpSize.y))).x;
betaBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
if ((lid.x < 4) & (lid.y < 4))
{
R = read_imagef(I_R32FC4, sampler, (gid + grpSize)).x;
betaBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
}
#ifdef GLOBAL_CLOSEST_PATCH_BUF
// closestPatchShiftBuf: 20x12 (padded from 16x8, 2 patches at eatch side)
// Fill 16x8
if ((gid.x < outputImageW + 4) & (gid.y < outputImageH + 4))
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 4)] = closestPatchShiftGlobalBuf[gid.x + gid.y *closestPatchShiftGlobalBufStep];
// fill the rest of the right columns: 4x8
if (lid.x < 4 & gid.x + grpSize.x < outputImageW + 4 & gid.y < outputImageH + 4)
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 4)] = closestPatchShiftGlobalBuf[gid.x + grpSize.x + gid.y*closestPatchShiftGlobalBufStep];
// fill the rest of the bottom rows: 16x4
if (lid.y < 4 & gid.x < outputImageW + 4 & gid.y + grpSize.y < outputImageH + 4)
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = closestPatchShiftGlobalBuf[gid.x + (gid.y + grpSize.y)*closestPatchShiftGlobalBufStep];
// fill the rest 4x4
if (lid.x < 4 & lid.y < 4 & gid.x + grpSize.x < outputImageW + 4 & gid.y + grpSize.y < outputImageH + 4)
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = closestPatchShiftGlobalBuf[gid.x + grpSize.x + (gid.y + grpSize.y)*closestPatchShiftGlobalBufStep];
#endif
#else
{
float R = read_imagef(I_R32FC4, sampler, (gid << 1) - 2).x; // I_R32FC4 is padded by 2 extra patches on each one the boundary.
//R = 0.0f; //!!!!!!!!
// betaBuf: 20x12 (padded from 16x8)
betaBuf[lid.x + lid.y*(grpSize.x + 4)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
// fill the rest of the right columns: 4x8
if (lid.x < 4)
{
R = read_imagef(I_R32FC4, sampler, (int2)((gid.x + grpSize.x)*2 - 2, (gid.y << 1) - 2)).x;
betaBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 4)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
// fill the rest of the bottom rows: 16*4
if (lid.y < 4)
{
R = read_imagef(I_R32FC4, sampler, (int2)((gid.x << 1) - 2, (gid.y + grpSize.y)*2 - 2)).x;
betaBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
if ((lid.x < 4) & (lid.y < 4))
{
R = read_imagef(I_R32FC4, sampler, (gid + grpSize)*2 - 2).x;
betaBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
#ifdef GLOBAL_CLOSEST_PATCH_BUF
// closestPatchShiftBuf: 20x12 (padded from 16x8, 2 patches at eatch side)
// Fill 16x8
if ((gid.x < outputImageW + 4) & (gid.y < outputImageH + 4))
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 4)] = closestPatchShiftGlobalBuf[gid.x + gid.y *closestPatchShiftGlobalBufStep];
// fill the rest of the right columns: 4x8
if (lid.x < 4 & gid.x + grpSize.x < outputImageW + 4 & gid.y < outputImageH + 4)
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 4)] = closestPatchShiftGlobalBuf[gid.x + grpSize.x + gid.y*closestPatchShiftGlobalBufStep];
// fill the rest of the bottom rows: 16x4
if (lid.y < 4 & gid.x < outputImageW + 4 & gid.y + grpSize.y < outputImageH + 4)
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = closestPatchShiftGlobalBuf[gid.x + (gid.y + grpSize.y)*closestPatchShiftGlobalBufStep];
// fill the rest 4x4
if (lid.x < 4 & lid.y < 4 & gid.x + grpSize.x < outputImageW + 4 & gid.y + grpSize.y < outputImageH + 4)
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 4)] = closestPatchShiftGlobalBuf[gid.x + grpSize.x + (gid.y + grpSize.y)*closestPatchShiftGlobalBufStep];
#endif
}
#endif
barrier(CLK_LOCAL_MEM_FENCE);	// betaBuf and closestPatchShiftBuf are done.
// gOutputPos is the center of the patches.
if ((gOutputPos.x > outputImageW + padSizeTile - 1) | (gOutputPos.y > outputImageH + padSizeTile - 1))
return;
{
// (3, 3) -> relative location in each one of the patch, contributed by 4 patches
float4 IhfValue = 0.0f, sr_sm;
int2 accessPos1, accessPos2, oldAccessPos = (int2){0, 0};
int2 locShift;
int2 readLocShift = 0;
float beta = 0.0f;
for (int idx = 0; idx < 4; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep2[0][idx]/2; // can futher change lutPatchShiftNStep2 so that we do not need to divide it by 2
readLocShift = closestPatchShiftBuf[(lid.x + 2) + locShift.x + ((lid.y + 2) + locShift.y)*(grpSize.x + 4)];
// patch center + relative patch shift location: relative shifted patch center.
// cx = gOutputPos.x + lutPatchShiftNStep2[0][idx].x // relative shift from tile_x
// dx = (int)(((gOutputPos.x + lutPatchShiftNStep2[0][idx].x + tile_x) + 0.5f)/1.5f) - block_x
// + readLocShift.x: move to the closest patch on I_sm
// - lutPatchShiftNStep2[0][idx].x: consider the patch contributes to this pixel
// + 1: since the pixel is at (3, 3)
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep2[0][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep2[0][idx].x + 1 + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep2[0][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep2[0][idx].y + 1 + padSizeBlock;
beta = betaBuf[lid.x + 2 + locShift.x + (lid.y + 2 + locShift.y)*(grpSize.x + 4)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!!!!
accessPos.x = (int)((((gid.x << 1) - 1 + lutPatchShiftNStep2[0][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep2[0][idx].x + 1 + padSizeBlock;
accessPos.y = (int)((((gid.y << 1) - 1 + lutPatchShiftNStep2[0][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep2[0][idx].y + 1 + padSizeBlock;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= Frec;
write_imagef (
I_upscaled32FC4, gOutputPos + 1, read_imagef(I_us32FC4, sampler, gOutputPos + 1) + IhfValue
);
// (4, 3)
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 6; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep2[1][idx]/2;
readLocShift = closestPatchShiftBuf[(lid.x + 2) + locShift.x + ((lid.y + 2) + locShift.y)*(grpSize.x + 4)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep2[1][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) + readLocShift.x - lutPatchShiftNStep2[1][idx].x + 2 - block_x + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep2[1][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) + readLocShift.y - lutPatchShiftNStep2[1][idx].y + 1 - block_y + padSizeBlock;
beta = betaBuf[lid.x + 2 + locShift.x + (lid.y + 2 + locShift.y)*(grpSize.x + 4)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = floor(((float)((gid.x << 1) - 1 + lutPatchShiftNStep2[1][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - lutPatchShiftNStep2[1][idx].x + 2 - block_x + padSizeBlock;
accessPos.y = floor(((float)((gid.y << 1) - 1 + lutPatchShiftNStep2[1][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - lutPatchShiftNStep2[1][idx].y + 1 - block_y + padSizeBlock;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= Srec;
write_imagef(
I_upscaled32FC4, gOutputPos + (int2)(2, 1),	read_imagef(I_us32FC4, sampler, gOutputPos + (int2)(2, 1)) + IhfValue
);
// (3, 4)
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 6; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep2[2][idx]/2;
readLocShift = closestPatchShiftBuf[(lid.x + 2) + locShift.x + ((lid.y + 2) + locShift.y)*(grpSize.x + 4)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep2[2][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) + readLocShift.x - lutPatchShiftNStep2[2][idx].x + 1 - block_x + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep2[2][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) + readLocShift.y - lutPatchShiftNStep2[2][idx].y + 2 - block_y + padSizeBlock;
beta = betaBuf[lid.x + 2 + locShift.x + (lid.y + 2 + locShift.y)*(grpSize.x + 4)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = floor(((float)((gid.x << 1) - 1  + lutPatchShiftNStep2[2][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - lutPatchShiftNStep2[2][idx].x + 1 - block_x + padSizeBlock;
accessPos.y = floor(((float)((gid.y << 1) - 1  + lutPatchShiftNStep2[2][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - lutPatchShiftNStep2[2][idx].y + 2 - block_y + padSizeBlock;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= Srec;
write_imagef(
I_upscaled32FC4, gOutputPos + (int2)(1, 2), read_imagef(I_us32FC4, sampler, gOutputPos + (int2)(1, 2)) + IhfValue
);
// (4, 4)
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 9; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep2[3][idx]/2;
readLocShift = closestPatchShiftBuf[(lid.x + 2) + locShift.x + ((lid.y + 2) + locShift.y)*(grpSize.x + 4)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep2[3][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) + readLocShift.x - lutPatchShiftNStep2[3][idx].x + 2 - block_x + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep2[3][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) + readLocShift.y - lutPatchShiftNStep2[3][idx].y + 2 - block_y + padSizeBlock;
beta = betaBuf[lid.x + 2 + locShift.x + (lid.y + 2 + locShift.y)*(grpSize.x + 4)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = floor(((float)((gid.x << 1) - 1 + lutPatchShiftNStep2[3][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - lutPatchShiftNStep2[3][idx].x + 2 - block_x + padSizeBlock;
accessPos.y = floor(((float)((gid.y << 1) - 1 + lutPatchShiftNStep2[3][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - lutPatchShiftNStep2[3][idx].y + 2 - block_y + padSizeBlock;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= Nrec;
write_imagef(
I_upscaled32FC4, gOutputPos + 2, read_imagef(I_us32FC4, sampler, gOutputPos + 2) + IhfValue
);
}
}
////////////////////////////////////////////////////////////////////////////////
// STEP3
////////////////////////////////////////////////////////////////////////////////
// param.nStep == 3
#ifdef GLOBAL_CLOSEST_PATCH_BUF

__kernel /*__attribute__((reqd_work_group_size(16, 8, 1)))*/
void EdgeEnlargeUPSNStep3Image2dRGBA32fStage1 (
__read_only image2d_t I_sr32FC4,			// original input image (properly padded).
__read_only image2d_t I_us32FC4,			// bicubic upscaled image, size: 1.5 x I_sr (properly padded)
__read_only image2d_t I_sm32FC4,			// blurred image, size: 1.0 x I_sr (properly padded)
const int outputImageW,						// width of non-padded I_us: tile_cols of UpscaleC3() in UpscalePS.cpp.
const int outputImageH,						// height of non-padded I_us: tile_rows of UpscaleC3() in UpscalePS.cpp.
const int padSizeTile,						// (padSizeTile, padSizeTile) coordinate on image2D points to the (tile_x, tile_y) global coordinate for I_us.
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) coordinate on image2D points to the (block_x, block_y) global coordinate for I_sm, I_sr
__local float4* SLM_us32FP4,				// SLM for I_us32FC4
const int widthStep_SLM_us,			        // The width Step (in pixel) of SLM for I_us32FC4. => 2 extra on each side to make 5 x 5 patch around localWorkSize => localWorkSize[0] + 4;
const int height_SLM_us,			        // The height (in pixel) of SLM for I_us32FC4. => 2 extra on each side to make 5 x 5 patch around localWorkSize => localWorkSize[1] + 4;
__local float4* SLM_sm32FP4,				// SLM for I_sm32FC4
const int widthStep_SLM_sm,			        // The width Step (in pixel) of SLM for I_sm32FC4. => 3 extra on each side to make 7 x 7 patch around localWorkSize => localWorkSize[0] + 6;
const int height_SLM_sm,			        // The height (in pixel) of SLM for I_us32FC4. => 3 extra on each side to make 7 x 7 patch around localWorkSize => localWorkSize[1] + 6;
__global int2* closestPatchShiftGlobalBuf,	// sizeof(cl_int)*2*(outputImageW + 8)*(outputImageH + 8)
const int closestPatchShiftGlobalBufStep,	// The width Step (in pixel).
const int tile_x,							// Absolute global tile begin coordinate for tile_usC1, ... pointer in the CPU code. Passing from Upscale CPU function
const int tile_y,
const int block_x,
const int block_y
) {
const int2 grpSize = (int2)(get_local_size(0), get_local_size(1));
const int2 lid = (const int2)(get_local_id(0), get_local_id(1));
// Each gId handles one patch.
const int2 gid = (const int2)(get_global_id(0), get_global_id(1));
float ssdOld = MAXFLOAT;
float ssd = 0.0f;
float4 tmpValue;
//int i_us = 0; // usBuffer index //Disabled for direct read
int i_sm = 0; // smBuffer index
int row, col;
int2 indexAdjust;
const int cShift = -3;	// No overcompute is necessary
const int cShiftedX = gid.x*3 + cShift;	// relative patch center location based on tile_x for I_us
const int cShiftedY = gid.y*3 + cShift;
//Disabled for direct read
// usX, usY: origin to read widthStep_SLM_us x height_SLM_us patch from I_us32FC4 into SLM
/*int usX = padSizeTile + ((gid.x - lid.x) * 3) + cShift + lid.x - 2;
int usY = padSizeTile + ((gid.y - lid.y) * 3) + cShift + lid.y - 2;
//Initialize Shared local memory: widthStep_SLM_us x height_SLM_us region from I_us32FC4
for (row = lid.y, indexAdjust.y = 0; row < height_SLM_us; row += grpSize.y, indexAdjust.y += grpSize.y)
{
for (col = lid.x, indexAdjust.x = 0; col < widthStep_SLM_us; col += grpSize.x, indexAdjust.x += grpSize.x)
{
int index = row * widthStep_SLM_us + col;
SLM_us32FP4[index] = read_imagef(I_us32FC4, sampler, (int2)(usX + indexAdjust.x, usY + indexAdjust.y));
}
}*/
// csmCenterX, csmCenterY : Center cordinate to read I_sm32FC4
const int csmCenterX = (int)((tile_x + cShiftedX + 0.5f)*UpscaleFactorRecip) - block_x + padSizeBlock - 2;
const int csmCenterY = (int)((tile_y + cShiftedY + 0.5f)*UpscaleFactorRecip) - block_y + padSizeBlock - 2;
// smX, smY: Coordinate to read widthStep_SLM_sm x height_SLM_sm patch from I_sm32FC4
int smX = (int)((tile_x + ((gid.x - lid.x) * 3) + cShift + 0.5f)*UpscaleFactorRecip) - block_x + padSizeBlock + lid.x - 3;
int smY = ((tile_y + ((gid.y - lid.y) * 3) + cShift + 0.5f)*UpscaleFactorRecip) - block_y + padSizeBlock - 2 + lid.y - 1;
//Initialize Shared local memory: widthStep_SLM_sm x height_SLM_sm region from I_sm32FC4
for (row = lid.y, indexAdjust.y = 0; row < height_SLM_sm; row += grpSize.y, indexAdjust.y += grpSize.y)
{
for (col = lid.x, indexAdjust.x = 0; col < widthStep_SLM_sm; col += grpSize.x, indexAdjust.x += grpSize.x)
{
int index = col + row * widthStep_SLM_sm;
SLM_sm32FP4[index] = read_imagef(I_sm32FC4, sampler, (int2)(smX + indexAdjust.x, smY + indexAdjust.y));
}
}
barrier(CLK_LOCAL_MEM_FENCE); // Done with the SLM_us32FP4 and SLM_sm32FP4
// upscale handles patches by every three pixels
if ((gid.x > outputImageW + 1) | (gid.y > outputImageH + 1))
return;
// Setup for direct read
int cx = padSizeTile + cShiftedX - 2;
int cy = padSizeTile + cShiftedY - 2;
for (int searchIdx = 0; searchIdx < 5; ++searchIdx)
{
// dx, dy: Top-Center coordinate to read 5x5 patch from I_sm32FC4
// For each search, dx, dy shifts from smCenterX,Y to bottom, right, top, left, center respectively in spiral fashion
int dx = csmCenterX + XYsCStage1[searchIdx].x;	// relative patch center location based on smC
int dy = csmCenterY + XYsCStage1[searchIdx].y;
//i_us = lid.y * 3 * widthStep_SLM_us + lid.x * 3; // Reset usBuffer index //Disabled for direct read
i_sm = (dy + lid.y - smY)*widthStep_SLM_sm + (dx + lid.x - smX); // Reset smBuffer index
for (row = 0; row < 5; row++)
{
for (col = 0; col < 5; col++)
{
//tmpValue = SLM_us32FP4[i_us + col] - SLM_sm32FP4[i_sm + col]; //Disabled for direct read
tmpValue = read_imagef(I_us32FC4, sampler, (int2)(cx + col, cy + row)) - SLM_sm32FP4[i_sm + col];
ssd += dot(tmpValue, tmpValue);
}
//i_us += widthStep_SLM_us; //Disabled for direct read
i_sm += widthStep_SLM_sm;
}
if (searchIdx < 4)
{
if (ssd < ssdOld)
{
ssdOld = ssd;
// 20 x 12, each one of the element represents one closest patch information for one patch.
//closestPatchShiftGlobalBuf[0] =  XYsCStage1[searchIdx];
closestPatchShiftGlobalBuf[gid.x + gid.y*closestPatchShiftGlobalBufStep] = XYsCStage1[searchIdx];
}
}
else
{
if ((ssdOld >= ssd*0.5f) & (ssd > 0.0f))	// center patch is good enough, choose the center patch instead.
{
//closestPatchShiftGlobalBuf[0] = 0;
closestPatchShiftGlobalBuf[gid.x + gid.y*closestPatchShiftGlobalBufStep] = 0;
}
}
ssd = 0.0f;
}
}
#endif

__kernel /*__attribute__((reqd_work_group_size(16, 8, 1)))*/
void EdgeEnlargeUPSNStep3Image2dRGBA32f (
__read_only image2d_t I_sr32FC4,			// original input image.
__read_only image2d_t I_us32FC4,			// bicubic upscaled image, size: 1.5 x I_sr
__read_only image2d_t I_sm32FC4,			// blurred image, size: 1.0 x I_sr)
__read_only image2d_t I_R32FC4,				// R component: each pixel in I_R32FC4 represents a patch in I_us.  I_R32FC4 size should be as (ecols, erows) in UpscaleC3 in UpscalePS.cpp.
const int outputImageW,						// width of I_us, I_upscaled.
const int outputImageH,						// height of I_us, I_upscaled.
__write_only image2d_t I_upscaled32FC4,		// upscaled output result, size: 1.5 x I_sr.  !!! Image2d object has to be (number of patches in X dim * 3)*(number of patches in Y dim * 3)
const int padSizeTile,						// (padSizeTile, padSizeTile) coordinate on image2D points to absolute coordinate for tile_usC1, ...
const int padSizeBlock,						// (padSizeBlock, padSizeBlock) coordinate on image2D points to absolute coordinate for block_smC1, block_srC1, ...
__local float* I_us32FP4LBuf,				// sizeof(cl_float)*(workgroupSize[0] + 1)*(workgroupSize[1] + 1)*4
const int I_us32FP4LBufP1WidthStep,			// The width Step (in pixel) of each one of the planar image in I_us32FP4Buf.
const int I_us32FP4LBufP1Height,			// The height (in pixel) of each one of the planar image in I_us32FP4LBuf.
__local float* I_sm32FP4LBuf,				// sizeof(cl_float)*(workgroupSize[0] + 1)*((workgroupSize[1] + 1 + 0.75f)/1.5f)*4
const int I_sm32FP4LBufP1WidthStep,			// The width (in pixel) of each one of the planar image in I_sm32FP4Buf
const int I_sm32FP4LBufP1Height,			// The height (in pixel) of each one of the planar image in I_sm32FP4Buf
#ifdef GLOBAL_CLOSEST_PATCH_BUF
__global int2* closestPatchShiftGlobalBuf,	// sizeof(cl_int)*2*(outputImageW + 8)*(outputImageH + 8)
const int closestPatchShiftGlobalBufStep,	// The width Step (in pixel).
#endif
__local int2* closestPatchShiftBuf,			// sizeof(cl_int2)*(workgroupSize[0] + 2)*(workgroupSize[1] + 2)
const int tile_x,							// Absolute global tile begin coordinate for tile_usC1, ... pointer in the CPU code. Passing from Upscale CPU function
const int tile_y,
const int block_x,							// Passing from Upscale CPU function
const int block_y
#ifdef USE_PS_STAGE1
,
__read_only image2d_t I_closestPatchShiftX,
__read_only image2d_t I_closestPatchShiftY
#endif
) {
//const int2 grpSize = (int2)(get_local_size(0), get_local_size(1));
const int2 lid= (const int2)(get_local_id(0), get_local_id(1));
// Each gId handles one patch.
const int2 gid = (const int2)(get_global_id(0), get_global_id(1));
// Each work-item is reponsible for one patch.  Patch centers are (0, 0), (3, 0), (6, 0), ...
const int2 gOutputPos = gid + gid + gid + padSizeTile;	// Patch center coordinate
{
//////////////////////////////////////////////////////////////////////////////////////
// Stage 1: find the closest patch in I_sm with respect to each of the patch in I_us
//////////////////////////////////////////////////////////////////////////////////////
// 1. Each work-item handles one 5x5 patch.
// 2. Every other pixel is the center of a patch.
// 3. Uses multiple passes to save the local memory usage.
// o o x x x ... x x x o o -> o: overcompute patches, x: the patches that generate the results (including I_hf).
// search five patches
#ifdef USE_PS_STAGE1_REF_CODE
#ifndef GLOBAL_CLOSEST_PATCH_BUF
closestPatchSearchNStep3Ref (gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, tile_x, tile_y, block_x, block_y, closestPatchShiftBuf);
#endif
#else
// Offset (0, 0): 7x3 patches
closestPatchSearch (
(int2)(0, 0), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (14, 0): 7x3 patches
closestPatchSearch (
(int2)(14, 0), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (28, 0): 6x3 patches
closestPatchSearch (
(int2)(28, 0), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4, I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// Offset (0, 6): 7x3
closestPatchSearch (
(int2)(0, 6), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 6): 7x3
closestPatchSearch (
(int2)(14, 6), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 6): 6x3
closestPatchSearch (
(int2)(28, 6), (int2)(6, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (0, 12): 7x3 patches
closestPatchSearch (
(int2)(0, 12), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 12): 7x3 patches
closestPatchSearch (
(int2)(14, 12), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 12): 6x3 patches
closestPatchSearch (
(int2)(28, 12), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (0, 18): 7x3
closestPatchSearch (
(int2)(0, 18), (int2)(7, 3), gid, lid, grpSize,	padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (14, 18): 7x3
closestPatchSearch (
(int2)(14, 18), (int2)(7, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
// offset (28, 18): 6x3
closestPatchSearch (
(int2)(28, 18), (int2)(6, 3), gid, lid, grpSize, padSizeTile, padSizeBlock, I_sm32FC4, I_us32FC4,	I_us32FP4LBuf, I_us32FP4LBufP1WidthStep, I_us32FP4LBufP1Height,
I_sm32FP4LBuf,	I_sm32FP4LBufP1WidthStep, I_sm32FP4LBufP1Height, closestPatchShiftBuf, tile_x, tile_y, block_x, block_y);
#endif
}
#ifdef USE_PS_STAGE1 // Stage2/3 Verified Correct.
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 2)].x = read_imagei(I_closestPatchShiftX, sampler, gid).x;
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 2)].y = read_imagei(I_closestPatchShiftY, sampler, gid).x;
if (lid.x < 2)
{
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 2)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x + grpSize.x, gid.y)).x;
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 2)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x + grpSize.x, gid.y)).x;
}
if (lid.y < 2)
{
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 2)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x, gid.y + grpSize.y)).x;
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 2)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x, gid.y + grpSize.y)).x;
}
if (lid.x < 2 && lid.y < 2)
{
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 2)].x = read_imagei(I_closestPatchShiftX, sampler, (int2)(gid.x + grpSize.x, gid.y + grpSize.y)).x;
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 2)].y = read_imagei(I_closestPatchShiftY, sampler, (int2)(gid.x + grpSize.x, gid.y + grpSize.y)).x;
}
#endif
// got the closest patch position...
// 4  4  2  4  4
// 4  4  2  4  4
// 2  2  1* 2* 2*
// 4  4  2* 4* 4*
// 4  4  2* 4* 4*
///////////////////////////////////////////////////////////
// Stage 2: Calculate the High Frequency Image and Stage 3
///////////////////////////////////////////////////////////
// every work-item handles lower right including the center 3x3 area
// 1 2 2
// 2 4 4
// 2 4 4
//
// can handle extra one padding for each dimension.
// reuse I_us32FP4LBuf
__local float* betaBuf = I_us32FP4LBuf;
// fill the betaBuf buffer (grpW + 1) x (grpH + 1) within the workgroup (with the overlapped area)
#ifndef USE_PS_R
if (gid.x < outputImageW + 2 & gid.y < outputImageH + 2)
{
// get the first 16x8
float R = read_imagef(I_R32FC4, sampler, gid).x; // I_R32FC4 is padded by one extra patch on each size of the boundary.
//R = 0.0f; //!!!!!!!!
// betaBuf: 18x10 (padded from 16x8)
betaBuf[lid.x + lid.y*(grpSize.x + 2)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
// fill the rest of the right columns: 4x8
if (lid.x < 2)
{
R = read_imagef(I_R32FC4, sampler, (int2)(gid.x + grpSize.x, gid.y)).x;
betaBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 2)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
// fill the rest of the bottom rows: 4x16
if (lid.y < 2)
{
R = read_imagef(I_R32FC4, sampler, (int2)(gid.x, gid.y + grpSize.y)).x;
betaBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 2)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
if ((lid.x < 2) & (lid.y < 2))
{
R = read_imagef(I_R32FC4, sampler, (int2)(gid.x + grpSize.x, gid.y + grpSize.y)).x;
betaBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 2)] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
}
#ifdef GLOBAL_CLOSEST_PATCH_BUF
// closestPatchShiftBuf: 18x10 (padded from 16x8, 1 patch at eatch side)
// Fill 16x8
if (gid.x < outputImageW + 2 & gid.y < outputImageH + 2)
closestPatchShiftBuf[lid.x + lid.y*(grpSize.x + 2)] = closestPatchShiftGlobalBuf[gid.x + gid.y *closestPatchShiftGlobalBufStep];
// fill the rest of the right columns: 8x8
if (lid.x < 2 & gid.x + grpSize.x < outputImageW + 2 & gid.y < outputImageH + 2)
closestPatchShiftBuf[lid.x + grpSize.x + lid.y*(grpSize.x + 2)] = closestPatchShiftGlobalBuf[gid.x + grpSize.x + gid.y*closestPatchShiftGlobalBufStep];
// fill the rest of the bottom rows: 8x16
if (lid.y < 2 & gid.x < outputImageW + 2 & gid.y + grpSize.y < outputImageH + 2)
closestPatchShiftBuf[lid.x + (lid.y + grpSize.y)*(grpSize.x + 2)] = closestPatchShiftGlobalBuf[gid.x + (gid.y + grpSize.y)*closestPatchShiftGlobalBufStep];
// fill the rest 8x8
if (lid.x < 2 & lid.y < 2 & gid.x + grpSize.x < outputImageW + 2 & gid.y + grpSize.y < outputImageH + 2)
closestPatchShiftBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*(grpSize.x + 2)] = closestPatchShiftGlobalBuf[gid.x + grpSize.x + (gid.y + grpSize.y)*closestPatchShiftGlobalBufStep];
#endif
#else
{
float R = read_imagef(I_R32FC4, sampler, (padSizeTile + 3 - 4 - 1) + (gid << 1)).x; // I_R32FC4 is padded by 2 extra patches on each one the boundary.
R = 0.0f; //!!!!!!!!
// betaBuf: 20x12 (padded from 16x8)
betaBuf[lid.x + lid.y*I_us32FP4LBufP1WidthStep] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
// fill the rest of the right columns: 4x8
if (lid.x < 4)
{
//R = read_imagef(I_R32FC4, sampler, (int2)((gid.x + grpSize.x) << 1, gid.y << 1) + (padSize - 1)).x;
betaBuf[lid.x + grpSize.x + lid.y*I_us32FP4LBufP1WidthStep] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
// fill the rest of the bottom rows: 4x16
if (lid.y < 4)
{
//R = read_imagef(I_R32FC4, sampler, (int2)(gid.x << 1, (gid.y + grpSize.y) << 1) + (padSize - 1)).x;
betaBuf[lid.x + (lid.y + grpSize.y)*I_us32FP4LBufP1WidthStep] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
if ((lid.x < 4) & (lid.y < 4))
{
//R = read_imagef(I_R32FC4, sampler, (int2)((gid.x + grpSize.x) << 1, (gid.y + grpSize.y) << 1) + (padSize - 1)).x;
betaBuf[lid.x + grpSize.x + (lid.y + grpSize.y)*I_us32FP4LBufP1WidthStep] = (R >= 0.8f) ? 1.0f : (R + 0.2f)*(R + 0.2f);
}
}
#endif
barrier(CLK_LOCAL_MEM_FENCE);	// betaBuf and closestPatchShiftBuf are done.
// gOutputPos is the center of the patches.
if ((gOutputPos.x > outputImageW + padSizeTile - 1) | (gOutputPos.y > outputImageH + padSizeTile - 1))
return;
{
// (2, 2) -> relative location in each one of the patch, contributed by 1 patch. (0, 0) is the upper left corner of the patch.
float4 IhfValue = 0.0f, sr_sm;
int2 accessPos1, accessPos2, oldAccessPos = (int2){0, 0};
int2 locShift;
int2 readLocShift = 0;
float beta = 0.0f;
#ifndef DO_FAKE_SEARCH
locShift = 0;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + (lid.y + 1)*(grpSize.x + 2)];
// patch center + relative patch shift location: relative shifted patch center.
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[0][0].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[0][0].x + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[0][0].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[0][0].y + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[0][0].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[0][0].x;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[0][0].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[0][0].y;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
write_imagef(I_upscaled32FC4, gOutputPos, read_imagef(I_us32FC4, sampler, gOutputPos) + IhfValue);
// (3, 2) -> relative location in each one of the patch, contributed by 2 patches. (0, 0) is the upper left corner of the patch.
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 2; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep3[1][idx]/3;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + locShift.x + ((lid.y + 1) + locShift.y)*(grpSize.x + 2)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[1][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[1][idx].x + 1 + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[1][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[1][idx].y + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1- readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[1][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[1][idx].x + 1;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[1][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[1][idx].y;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= 0.5f;
write_imagef(I_upscaled32FC4, gOutputPos + (int2)(1, 0), read_imagef(I_us32FC4, sampler, gOutputPos + (int2)(1, 0)) + IhfValue);
// (4, 2) -> relative location in each one of the patch, contributed by 2 patches. (0, 0) is the upper left corner of the patch.
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 2; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep3[2][idx]/3;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + locShift.x + ((lid.y + 1) + locShift.y)*(grpSize.x + 2)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[2][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[2][idx].x + 2 + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[2][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[2][idx].y + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[2][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[2][idx].x + 2;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[2][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[2][idx].y;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= 0.5f;
write_imagef(I_upscaled32FC4, gOutputPos + (int2)(2, 0), read_imagef(I_us32FC4, sampler, gOutputPos + (int2)(2, 0)) + IhfValue);
// (2, 3) -> relative location in each one of the patch, contributed by 2 patches. (0, 0) is the upper left corner of the patch.
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 2; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep3[3][idx]/3;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + locShift.x + ((lid.y + 1) + locShift.y)*(grpSize.x + 2)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[3][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[3][idx].x + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[3][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[3][idx].y + 1 + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[3][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[3][idx].x;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[3][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[3][idx].y + 1;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= 0.5f;
write_imagef(I_upscaled32FC4, gOutputPos + (int2)(0, 1), read_imagef(I_us32FC4, sampler, gOutputPos + (int2)(0, 1)) + IhfValue);
// (3, 3) -> relative location in each one of the patch, contributed by 4 patches. (0, 0) is the upper left corner of the patch.
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 4; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep3[4][idx]/3;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + locShift.x + ((lid.y + 1) + locShift.y)*(grpSize.x + 2)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[4][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[4][idx].x + 1 + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[4][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[4][idx].y + 1 + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[4][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[4][idx].x + 1;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[4][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[4][idx].y + 1;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= 0.25f;
write_imagef(I_upscaled32FC4, gOutputPos + 1, read_imagef(I_us32FC4, sampler, gOutputPos + 1) + IhfValue);
// (4, 3) -> relative location in each one of the patch, contributed by 4 patches. (0, 0) is the upper left corner of the patch.
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 4; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep3[5][idx]/3;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + locShift.x + ((lid.y + 1) + locShift.y)*(grpSize.x + 2)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[5][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[5][idx].x + 2 + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[5][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[5][idx].y + 1 + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[5][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[5][idx].x + 2;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[5][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[5][idx].y + 1;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= 0.25f;
write_imagef(I_upscaled32FC4, gOutputPos + (int2)(2, 1), read_imagef(I_us32FC4, sampler, gOutputPos + (int2)(2, 1)) + IhfValue);
// (2, 4) -> relative location in each one of the patch, contributed by 2 patches. (0, 0) is the upper left corner of the patch.
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 2; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep3[6][idx]/3;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + locShift.x + ((lid.y + 1) + locShift.y)*(grpSize.x + 2)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[6][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[6][idx].x + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[6][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[6][idx].y + 2 + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[6][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[6][idx].x;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[6][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[6][idx].y + 2;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= 0.5f;
write_imagef(I_upscaled32FC4, gOutputPos + (int2)(0, 2), read_imagef(I_us32FC4, sampler, gOutputPos + (int2)(0, 2)) + IhfValue);
// (3, 4) -> relative location in each one of the patch, contributed by 4 patches. (0, 0) is the upper left corner of the patch.
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 4; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep3[7][idx]/3;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + locShift.x + ((lid.y + 1) + locShift.y)*(grpSize.x + 2)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[7][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[7][idx].x + 1 + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[7][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[7][idx].y + 2 + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[7][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[7][idx].x + 1;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[7][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[7][idx].y + 2;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= 0.25f;
write_imagef(I_upscaled32FC4, gOutputPos + (int2)(1, 2), read_imagef(I_us32FC4, sampler, gOutputPos + (int2)(1, 2)) + IhfValue);
// (4, 4) -> relative location in each one of the patch, contributed by 4 patches. (0, 0) is the upper left corner of the patch.
IhfValue = 0.0f;
oldAccessPos = (int2){0, 0};
for (int idx = 0; idx < 4; ++idx)
{
#ifndef DO_FAKE_SEARCH
locShift = lutPatchShiftNStep3[8][idx]/3;
readLocShift = closestPatchShiftBuf[(lid.x + 1) + locShift.x + ((lid.y + 1) + locShift.y)*(grpSize.x + 2)];
accessPos1.x = (int)(((gOutputPos.x - padSizeTile + lutPatchShiftNStep3[8][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x + readLocShift.x - lutPatchShiftNStep3[8][idx].x + 2 + padSizeBlock;
accessPos1.y = (int)(((gOutputPos.y - padSizeTile + lutPatchShiftNStep3[8][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y + readLocShift.y - lutPatchShiftNStep3[8][idx].y + 2 + padSizeBlock;
beta = betaBuf[lid.x + 1 + locShift.x + (lid.y + 1 + locShift.y)*(grpSize.x + 2)];
if (accessPos1.x != oldAccessPos.x || accessPos1.y != oldAccessPos.y)
sr_sm = read_imagef(I_sr32FC4, sampler, accessPos1) - read_imagef(I_sm32FC4, sampler, accessPos1);
IhfValue += beta*sr_sm;
oldAccessPos = accessPos1;
if (readLocShift.x == 0 && readLocShift.y == 0)
IhfValue += (1.0f - beta)*sr_sm;
else
{
accessPos2 = accessPos1 - readLocShift;
IhfValue += (1.0f - beta)*(read_imagef(I_sr32FC4, sampler, accessPos2) - read_imagef(I_sm32FC4, sampler, accessPos2));
}
#else
// !!!!!!
accessPos.x = (int)(((gOutputPos.x + lutPatchShiftNStep3[8][idx].x + tile_x) + 0.5f)*UpscaleFactorRecip) - block_x - lutPatchShiftNStep3[8][idx].x + 2;
accessPos.y = (int)(((gOutputPos.y + lutPatchShiftNStep3[8][idx].y + tile_y) + 0.5f)*UpscaleFactorRecip) - block_y - lutPatchShiftNStep3[8][idx].y + 2;
IhfValue += read_imagef(I_sr32FC4, sampler, accessPos) - read_imagef(I_sm32FC4, sampler, accessPos);
#endif
}
IhfValue *= 0.25f;
write_imagef(I_upscaled32FC4, gOutputPos + 2, read_imagef(I_us32FC4, sampler, gOutputPos + 2) + IhfValue);
}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
