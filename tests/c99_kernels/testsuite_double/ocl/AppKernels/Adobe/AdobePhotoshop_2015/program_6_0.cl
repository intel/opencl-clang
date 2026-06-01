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
// Implementing updateHfImgC3KNN()
__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
CLK_ADDRESS_CLAMP_TO_EDGE   |
CLK_FILTER_NEAREST;
__constant int XYsC[65][2] = {{0,  0},
{0,  1}, { 1,  0}, { 0, -1}, {-1,  0},
{1,  1}, { 1, -1}, {-1, -1}, {-1,  1},
{0,  2}, { 2,  0}, { 0, -2}, {-2,  0},
{2,  4}, { 2, -4}, {-2, -4}, {-2,  4},
{4,  2}, { 4, -2}, {-4, -2}, {-4,  2},
{4,  4}, { 4, -4}, {-4, -4}, {-4,  4},
{0,  6}, { 6,  0}, { 0, -6}, {-6,  0},
{2,  6}, {-2,  6}, { 6,  2}, { 6, -2},
{2, -6}, {-2, -6}, {-6, -2}, {-6,  2},
{4,  6}, {-4,  6}, { 6, -4}, { 6,  4},
{4, -6}, {-4, -6}, {-6, -4}, {-6,  4},
{2,  8}, {-2,  8}, { 8, -2}, { 8,  2},
{2, -8}, {-2, -8}, {-8, -2}, {-8,  2},
{6,  6}, { 6, -6}, {-6, -6}, {-6,  6},
{4,  8}, {-4,  8}, { 8, -4}, { 8,  4},
{4, -8}, {-4, -8}, {-8, -4}, {-8,  4}
};
// Implementation using image2d as the memory object.
// * Should add the read the padded input image capability
// Later, inputImageRGBA32F should be padded, outputImageRGBA32F is the original size (without padding).
// For shapen part, both need to be padded.
// Note:
// clEnqueueWriteImage is slower than elEnqueueWriteBuffer (p.115 heterogeneous computing OpenCL 1st edition)
//
// work-item size should be the same size as the output image (without padding).
// inputImageRGBA32F: normalized padded RGBA image ranging from 0.0f ~ 1.0f. global_id(0, 0) should point to the beginning
// outputImageRGBA32F: denoised RGBA image ranging from 0.0f ~ 1.0f.

__kernel
void DenoiseRGBA32f(
__read_only image2d_t inputImageRGBA32F,
__write_only image2d_t outputImageRGBA32F,
const int patchRadius,	// param.hps: patchRadius*2 + 1 = patchSize.
const int searchSize,	// param.Num: The number of patches being searched.
const float nSigma,		// param.nSigma: noise sigma.
const int padSize,
__local float* ssdRowTable,
const int ssdRowTableWidth
)
{
const int2 globalPos = {get_global_id(0) + padSize, get_global_id(1) + padSize};
// fill the ssdRowTable
float4 srcColorF4 = {0.0f, 0.0f, 0.0f, 0.0f};
float normFactor = 0.0f;
{
int2 centerPatchReadPos;
int2 shiftPatchReadPos;
float distSquare = 0.0f;
float ssd = 0.0f;
// (2 * nChannels * nSigma^2 * (patchSize)^2)
//float denominator = 2.0f*3.0f*nSigma*patchSize*patchSize/25.0f;
const int patchSize = patchRadius*2 + 1;
const float denominator = 0.24f*nSigma*patchSize*patchSize;
float4 tmpValue;
if (patchSize == 5)
{
const int2 lid = (int2)(get_local_id(0), get_local_id(1));
for (int idx = 0; idx < searchSize; ++idx)
{
ssd = 0.0f;
centerPatchReadPos = globalPos - patchRadius;
shiftPatchReadPos = centerPatchReadPos + (int2)(XYsC[idx][0], XYsC[idx][1]);
// fill the first 4 columns
if (lid.x < 4)
{
tmpValue = read_imagef(inputImageRGBA32F, sampler, shiftPatchReadPos)
- read_imagef(inputImageRGBA32F, sampler, centerPatchReadPos);
ssdRowTable[lid.y*ssdRowTableWidth + lid.x] = dot(tmpValue, tmpValue);
}
// fill the rest
tmpValue = read_imagef(inputImageRGBA32F, sampler, (int2)(shiftPatchReadPos.x + 4, shiftPatchReadPos.y))
- read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x + 4, centerPatchReadPos.y));
ssdRowTable[lid.y*ssdRowTableWidth + lid.x + 4] = dot(tmpValue, tmpValue);
if (lid.y > get_local_size(1) - 5)
{
if (lid.x < 4)
{
//for (int i = 1; i < 5; ++i)
{
tmpValue = read_imagef(inputImageRGBA32F, sampler, (int2)(shiftPatchReadPos.x, shiftPatchReadPos.y + 4))
- read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x, centerPatchReadPos.y + 4));
ssdRowTable[(lid.y + 4)*ssdRowTableWidth + lid.x] = dot(tmpValue, tmpValue);
}
}
//for (int i = 1; i < 5; ++i)
{
// fill the rest
tmpValue = read_imagef(inputImageRGBA32F, sampler, (int2)(shiftPatchReadPos.x + 4, shiftPatchReadPos.y + 4))
- read_imagef(inputImageRGBA32F, sampler, (int2)(centerPatchReadPos.x + 4, centerPatchReadPos.y + 4));
ssdRowTable[(lid.y + 4)*ssdRowTableWidth + lid.x + 4] = dot(tmpValue, tmpValue);
}
}
barrier(CLK_LOCAL_MEM_FENCE);
// Done with the ssdRowTable
// stalled the video adapter ???
//                if (get_global_id(0) > get_image_width(outputImageRGBA32F) - 1 || get_global_id(1) > get_image_height(outputImageRGBA32F) - 1)
//                    return;
int ssdTableIdx = lid.y*ssdRowTableWidth + lid.x;
for (int row = 0; row < 5; ++row)
{
ssd += ssdRowTable[ssdTableIdx];
ssd += ssdRowTable[ssdTableIdx + 1];
ssd += ssdRowTable[ssdTableIdx + 2];
ssd += ssdRowTable[ssdTableIdx + 3];
ssd += ssdRowTable[ssdTableIdx + 4];
ssdTableIdx += ssdRowTableWidth;
}
// weight = exp(- dist^2 * (5x5) / (2 * nChannels * nSigma * (patchSize)^2)
ssd = exp(-ssd/denominator);
//srcColorF4 += ssd*read_imagef(inputImageRGBA32F, sampler, (int2){globalPos.x + XYs[idx].x, globalPos.y + XYs[idx].y});
srcColorF4 += ssd*(read_imagef(inputImageRGBA32F, sampler, (int2)(globalPos.x + XYsC[idx][0], globalPos.y + XYsC[idx][1])));
normFactor += ssd;
}
}
else
{
for (int idx = 0; idx < searchSize; ++idx)
{
ssd = 0.0f;
for (int patchRow = 0; patchRow < patchSize; ++patchRow)
{
shiftPatchReadPos.y = (globalPos.y + XYsC[idx][1] - patchRadius) + patchRow;
centerPatchReadPos.y = (globalPos.y - patchRadius) + patchRow;
for (int patchCol = 0; patchCol < patchSize; ++patchCol)	// will do manual unrolling (4 at a time for example) later for upscale
{
shiftPatchReadPos.x = (globalPos.x + XYsC[idx][0] - patchRadius) + patchCol;
centerPatchReadPos.x = globalPos.x - patchRadius + patchCol;
tmpValue = read_imagef(inputImageRGBA32F, sampler, shiftPatchReadPos) - read_imagef(inputImageRGBA32F, sampler, centerPatchReadPos);
distSquare = dot(tmpValue, tmpValue);
ssd += distSquare;
}
}
// weight = exp(- dist^2 * (5x5) / (2 * nChannels * nSigma * (patchSize)^2)
ssd = exp(-ssd/denominator);
srcColorF4 += ssd*read_imagef(inputImageRGBA32F, sampler, (int2)(globalPos.x + XYsC[idx][0], globalPos.y + XYsC[idx][1]));
normFactor += ssd;
}
}
}
//normFactor += 1.0e-9f;
// UpdateUsImg to combine the original pixels with denoised smoothed pixels.
float4 usColorF4 = read_imagef(inputImageRGBA32F, sampler, globalPos);
int2 writePos = globalPos-padSize;
if (get_global_id(0) < get_image_width(outputImageRGBA32F) && get_global_id(1) < get_image_height(outputImageRGBA32F))
{
write_imagef(outputImageRGBA32F, globalPos - padSize, (10.0f*usColorF4 + srcColorF4)/(10.0f + normFactor));
}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
