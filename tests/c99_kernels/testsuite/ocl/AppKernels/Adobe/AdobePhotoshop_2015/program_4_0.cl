//  Copyright (c) 2013 Adobe Systems Inc. All rights reserved.
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
void smartSharpenDenoiseRGBA32f(
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
            const int2 lid = (int2){get_local_id(0), get_local_id(1)};

            for (int idx = 0; idx < searchSize; ++idx)
            {
                ssd = 0.0f;
                centerPatchReadPos = globalPos - patchRadius;
                shiftPatchReadPos = centerPatchReadPos + (int2){XYsC[idx][0], XYsC[idx][1]};

                // fill the first 4 columns
                if (lid.x < 4)
                {
                    tmpValue = read_imagef(inputImageRGBA32F, sampler, shiftPatchReadPos)
                        - read_imagef(inputImageRGBA32F, sampler, centerPatchReadPos);
                    ssdRowTable[lid.y*ssdRowTableWidth + lid.x] = dot(tmpValue, tmpValue);
                }

                // fill the rest
                tmpValue = read_imagef(inputImageRGBA32F, sampler, (int2){shiftPatchReadPos.x + 4, shiftPatchReadPos.y})
                    - read_imagef(inputImageRGBA32F, sampler, (int2){centerPatchReadPos.x + 4, centerPatchReadPos.y});

                ssdRowTable[lid.y*ssdRowTableWidth + lid.x + 4] = dot(tmpValue, tmpValue);

                if (lid.y > get_local_size(1) - 5)
                {
                    if (lid.x < 4)
                    {
                        //for (int i = 1; i < 5; ++i)
                        {
                            tmpValue = read_imagef(inputImageRGBA32F, sampler, (int2){shiftPatchReadPos.x, shiftPatchReadPos.y + 4})
                                - read_imagef(inputImageRGBA32F, sampler, (int2){centerPatchReadPos.x, centerPatchReadPos.y + 4});
                            ssdRowTable[(lid.y + 4)*ssdRowTableWidth + lid.x] = dot(tmpValue, tmpValue);
                        }
                    }

                    //for (int i = 1; i < 5; ++i)
                    {
                        // fill the rest
                        tmpValue = read_imagef(inputImageRGBA32F, sampler, (int2){shiftPatchReadPos.x + 4, shiftPatchReadPos.y + 4})
                            - read_imagef(inputImageRGBA32F, sampler, (int2){centerPatchReadPos.x + 4, centerPatchReadPos.y + 4});

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
                srcColorF4 += ssd*(read_imagef(inputImageRGBA32F, sampler, (int2){globalPos.x + XYsC[idx][0], globalPos.y + XYsC[idx][1]}));

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
                srcColorF4 += ssd*read_imagef(inputImageRGBA32F, sampler, (int2){globalPos.x + XYsC[idx][0], globalPos.y + XYsC[idx][1]});

                normFactor += ssd;
            }
        }

	}
    //normFactor += 1.0e-9f;

	// UpdateUsImg to combine the original pixels with denoised smoothed pixels.
	float4 usColorF4 = read_imagef(inputImageRGBA32F, sampler, globalPos);

   // int2 writePos = globalPos-padSize;
    if ((get_global_id(0) < (get_image_width(outputImageRGBA32F)-padSize)) & (get_global_id(1) <(get_image_height(outputImageRGBA32F)-padSize)))
    {
        write_imagef(outputImageRGBA32F, globalPos, (10.0f*usColorF4 + srcColorF4)/(10.0f + normFactor));
    }
}


__kernel void imageCopy(__read_only image2d_t srcImage,__write_only image2d_t dstImage,int width,int height,int offsetX,int offsetY)
{
	int i= get_global_id(0);
	int j= get_global_id(1);

	if(i>=width||j>=height)
		return ;
	//const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
	float4 pixel= read_imagef(srcImage,sampler,(int2){i+offsetX,j+offsetY});
	write_imagef(dstImage,(int2){i,j},pixel);
}


// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Interleave8To32(const __global uchar* srcChan0,
								const __global uchar* srcChan1,
								const __global uchar* srcChan2,
								const __global uchar* srcChan3,
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

	int chanIndex = row * chanRowStep + col;
	float4 pixel32;

	if (numChannels == 3)
		pixel32 = (float4)((float)srcChan0[chanIndex], (float)srcChan1[chanIndex], (float)srcChan2[chanIndex], 255.0f);
	else
		pixel32 = (float4)((float)srcChan0[chanIndex], (float)srcChan1[chanIndex], (float)srcChan2[chanIndex], (float)srcChan3[chanIndex]);
	pixel32 /= 255.0f;
	write_imagef(dstImage, (int2)(originX + col, originY + row), pixel32);
}


// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Interleave16To32(const __global ushort* srcChan0,
								const __global ushort* srcChan1,
								const __global ushort* srcChan2,
								const __global ushort* srcChan3,
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

	int chanIndex = row * chanRowStep + col;
	float4 pixel32;

	if (numChannels == 3)
		pixel32 = (float4)((float)srcChan0[chanIndex], (float)srcChan1[chanIndex], (float)srcChan2[chanIndex], 32768.0f);
	else
		pixel32 = (float4)((float)srcChan0[chanIndex], (float)srcChan1[chanIndex], (float)srcChan2[chanIndex], (float)srcChan3[chanIndex]);
	pixel32 /= 32768.0f;
	write_imagef(dstImage, (int2)(originX + col, originY + row), pixel32);
}


// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Interleave32To32(const __global float* srcChan0,
								const __global float* srcChan1,
								const __global float* srcChan2,
								const __global float* srcChan3,
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

	int chanIndex = row * chanRowStep + col;
	float4 pixel32;

	if (numChannels == 3)
		pixel32 = (float4)(srcChan0[chanIndex], srcChan1[chanIndex], srcChan2[chanIndex], 1.0);
	else
		pixel32 = (float4)(srcChan0[chanIndex], srcChan1[chanIndex], srcChan2[chanIndex], srcChan3[chanIndex]);
	write_imagef(dstImage, (int2)(originX + col, originY + row), pixel32);
}


// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Deinterleave32To8(__read_only image2d_t srcImage,
									 __global uchar* dstChan0,
									 __global uchar* dstChan1,
									 __global uchar* dstChan2,
									 __global uchar* dstChan3,
									 int originX, int originY,
									 int cols, int rows,
									 int numChannels,
									 int chanRowStep)
{
	int col = get_global_id(0);
	int row = get_global_id(1);
	if(col >= cols || row >= rows)
		return;

	int chanIndex = row * chanRowStep + col;

	float4 pixel32 = read_imagef(srcImage,sampler,(int2)(originX + col, originY + row)) * 255.0f;
	uchar4 pixel8 = convert_uchar4_sat(pixel32);
	dstChan0[chanIndex] = pixel8.x;
	dstChan1[chanIndex] = pixel8.y;
	dstChan2[chanIndex] = pixel8.z;

	if (numChannels == 4)
		dstChan3[chanIndex] = pixel8.w;
}


// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Deinterleave32To16(__read_only image2d_t srcImage,
									 __global ushort* dstChan0,
									 __global ushort* dstChan1,
									 __global ushort* dstChan2,
									 __global ushort* dstChan3,
									 int originX, int originY,
									 int cols, int rows,
									 int numChannels,
									 int chanRowStep)
{
	int col = get_global_id(0);
	int row = get_global_id(1);
	if(col >= cols || row >= rows)
		return;

	int chanIndex = row * chanRowStep + col;

	float4 pixel32 = read_imagef(srcImage,sampler,(int2)(originX + col, originY + row)) * 32768.0f;
	pixel32 = clamp(pixel32, 0.0, 32768.0f);
	ushort4 pixel16 = convert_ushort4(pixel32);
	dstChan0[chanIndex] = pixel16.x;
	dstChan1[chanIndex] = pixel16.y;
	dstChan2[chanIndex] = pixel16.z;

	if (numChannels == 4)
		dstChan3[chanIndex] = pixel16.w;
}


// Supports 3 or 4 channels. Can add support for 1 or 2 channels as needed.

__kernel void Deinterleave32To32(__read_only image2d_t srcImage,
									 __global float* dstChan0,
									 __global float* dstChan1,
									 __global float* dstChan2,
									 __global float* dstChan3,
									 int originX, int originY,
									 int cols, int rows,
									 int numChannels,
									 int chanRowStep)
{
	int col = get_global_id(0);
	int row = get_global_id(1);
	if(col >= cols || row >= rows)
		return;

	int chanIndex = row * chanRowStep + col;

	float4 pixel32 = read_imagef(srcImage,sampler,(int2)(originX + col, originY + row));
	dstChan0[chanIndex] = pixel32.x;
	dstChan1[chanIndex] = pixel32.y;
	dstChan2[chanIndex] = pixel32.z;

	if (numChannels == 4)
		dstChan3[chanIndex] = pixel32.w;
}


__kernel void ComputekernelRGBA32f1_1(__read_only image2d_t rowSum_image,__write_only image2d_t mappedRow,int rows,int cols,int kHeight)
{
unsigned int iGid=(unsigned int)get_global_id(0);

if(iGid>=rows)
return ;

float4 data;
int2 cords;
float4 sum=0;
//mappedRow=mappedRow+cols*iGid;
for(int i=0;i<kHeight;i++)
{
cords=(int2)(iGid,i);
data=read_imagef(rowSum_image,sampler,cords);
sum=sum+data;
}

write_imagef(mappedRow,(int2)(0,iGid),sum);
//mappedRow[0]=sum;
}


__kernel void ComputekernelRGBA32f1_0(__read_only image2d_t sPtr,const __global unsigned char * restrict kernelPtr,

__write_only image2d_t rowSum_image,

const __global int * restrict kernelRowBounds,

int kHeight,int kRowBytes,

int rows,int padSize)

{

unsigned int X=(unsigned int)get_global_id(0);
unsigned int Y=(unsigned int)get_global_id(1);
if(X>=rows||Y>=kHeight)
return ;
int  srcOffset =(X+Y);
int kOffset = Y*kRowBytes;
int RowBoundOffset=2*Y;

//kernelRowBounds+=RowBoundOffset;
int2 cords;
float4 rowSum;
int kx,count,kValue;
float4 data;
rowSum = (float4)0.0f;
kx = kernelRowBounds[RowBoundOffset+0];

count= kernelRowBounds[RowBoundOffset+1] - kx;

while(count > 3)
{
kValue = kernelPtr[ kOffset + kx ];

cords=(int2)(kx+padSize,srcOffset+padSize);
data=read_imagef(sPtr,sampler,cords);

rowSum = rowSum+(float4)kValue *data;
kValue = kernelPtr[ kOffset + kx+1 ];

cords=(int2)(kx+1+padSize,srcOffset+padSize);
data=read_imagef(sPtr,sampler,cords);

rowSum = rowSum+(float4)kValue *data;
kValue = kernelPtr[ kOffset + kx+2];

cords=(int2)(kx+2+padSize,srcOffset+padSize);
data=read_imagef(sPtr,sampler,cords);

rowSum = rowSum+(float4)kValue *data;
kValue = kernelPtr[ kOffset + kx+3];

cords=(int2)(kx+3+padSize,srcOffset+padSize);
data=read_imagef(sPtr,sampler,cords);

rowSum = rowSum+(float4)kValue *data;
count -= 4;
kx += 4;
}


while(count--)
{
kValue = kernelPtr[ kOffset + kx ];
cords=(int2)(kx+padSize,srcOffset+padSize);
data=read_imagef(sPtr,sampler,cords);
rowSum = rowSum+(float4)kValue *data;
kx++;
}
data=rowSum;
write_imagef(rowSum_image,(int2)(X,Y),data);
}

// thread block should be rows*(cols-1) as one column is already processed by kernel 1

__kernel void ComputeKernelRGBA32f2(__read_only image2d_t sPtr,
__write_only image2d_t mappedRow,
const __global short * restrict gRowUpdates,
__local short *rowUpdates,
 int rowUpdateSize,
int localWidth,
int elementperThread,
int kHeight,int cols,int rows,int padSize)
{

int iGidX=(int)get_global_id(0);
int iGidY=(int)get_global_id(1);


int LidX=get_local_id(0);
int LidY=get_local_id(1);


for(int x=0;(x<elementperThread)&&((LidX*elementperThread+x)+LidY*(localWidth*elementperThread))<rowUpdateSize;x++)
rowUpdates[(LidX*elementperThread+x)+LidY*(localWidth*elementperThread)]=(short)gRowUpdates[(LidX*elementperThread+x)+LidY*(localWidth*elementperThread)];

barrier(CLK_LOCAL_MEM_FENCE);

if(iGidX>=(cols-1)||iGidY>=(rows))
return ;

int ky,kx;
int srcOffset=iGidY;
int col=iGidX+1;
int position = 0,updates;
int2 cords;
int xOffset0,kValue0,xOffset1,kValue1 ; ;
float4 data;
float4 change0,change1;
//	float kValue0,kValue1;
float4 mappedValue=(float4)0.0f;

for (ky = 0; ky < kHeight; ky++ )
{
updates = rowUpdates[position++];
kx = 0;

for ( ; kx < (updates & ~1); kx += 2)
{
xOffset0 = rowUpdates[position + 0];
kValue0 = rowUpdates[position + 1];
xOffset1 = rowUpdates[position + 2];
kValue1 = rowUpdates[position + 3];

cords=(int2)( col + xOffset0 - 1+padSize,srcOffset+padSize);
data=read_imagef(sPtr,sampler,cords);
change0 = (float4)kValue0 * data;

cords=(int2)( col + xOffset1 - 1+padSize,srcOffset+padSize);
data=read_imagef(sPtr,sampler,cords);
change1 = (float4)kValue1 * data;

mappedValue=mappedValue+change0 + change1;
position += 4;
}

for ( ; kx < updates; kx++)
{
xOffset0 = rowUpdates[position + 0];
kValue0 = rowUpdates[position + 1];
cords=(int2)( col + xOffset0 - 1+padSize,srcOffset+padSize);
data=read_imagef(sPtr,sampler,cords);
change0 = (float4)kValue0 * data;
mappedValue=mappedValue+change0;
position += 2;
}
srcOffset += 1;
}
write_imagef(mappedRow,(int2)(col,iGidY),mappedValue);
//mappedRow[cols*iGidY+col]=mappedValue;

}

__kernel void ComputeKernelRGBA32f3(__write_only image2d_t dst,__read_only image2d_t mappedRow,int cols,int rows,const float divisor,int padSize)
{
int iGid=(unsigned int)get_global_id(0);
if(iGid>=rows)
return ;

float4 result=read_imagef(mappedRow,sampler,(int2)(0,iGid));

for (int col = 0; col < cols; col++ )
{
float4  data = (float4)(result.x/divisor,result.y/divisor,result.z/divisor,result.w/divisor);
write_imagef(dst,(int2)(col+padSize,iGid+padSize),(float4)(data));
// if the kernel total is correct, then the result cannot be out of range
if((col+1)<cols)
//result =result+ mappedRow[cols*iGid+col+1];
result =result+ read_imagef(mappedRow,sampler,(int2)(col+1,iGid));

}

}
 //Gaussian Blur
__kernel void ColBoxBlurImage1(__read_only image2d_t src,__write_only image2d_t dst,
const short cols, const short rows,
const short radius,int padSizeX,int padSizeY)
{
int iGidX=get_global_id(0)+padSizeX;
int iGidY=get_global_id(1)+padSizeY;
if(iGidX>=(cols+padSizeX))
return ;
if(iGidY!=padSizeY)
return ;
const float4 fscale=1.0f/(2*radius+1);
float4 sum =0;
int2 pos;
short x=0;



for (x = -radius; x < radius + 1; x++)
{
pos=(int2)(iGidX,iGidY+x);
sum += read_imagef(src, sampler, pos);
}

write_imagef(dst,(int2)(iGidX,iGidY),(sum*fscale));

int count=(rows-1);
x=1;

while(count>=4)
{
sum += read_imagef(src, sampler, (int2)(iGidX,x+iGidY+radius));
sum -= read_imagef(src, sampler, (int2)(iGidX,x+iGidY-radius-1));
write_imagef(dst,(int2)(iGidX,x+iGidY),(sum*fscale));
x++;
sum += read_imagef(src, sampler, (int2)(iGidX,x+iGidY+radius));
sum -= read_imagef(src, sampler, (int2)(iGidX,x+iGidY-radius-1));
write_imagef(dst,(int2)(iGidX,x+iGidY),(sum*fscale));
x++;
sum += read_imagef(src, sampler, (int2)(iGidX,x+iGidY+radius));
sum -= read_imagef(src, sampler, (int2)(iGidX,x+iGidY-radius-1));
write_imagef(dst,(int2)(iGidX,x+iGidY),(sum*fscale));
x++;
sum += read_imagef(src, sampler, (int2)(iGidX,x+iGidY+radius));
sum -= read_imagef(src, sampler, (int2)(iGidX,x+iGidY-radius-1));
write_imagef(dst,(int2)(iGidX,x+iGidY),(sum*fscale));
x++;

count-=4;
}
while(count>0)
{
sum += read_imagef(src, sampler, (int2)(iGidX,x+iGidY+radius));
sum -= read_imagef(src, sampler, (int2)(iGidX,x+iGidY-radius-1));
write_imagef(dst,(int2)(iGidX,x+iGidY),(sum*fscale));
x++;
count--;
}

}

__kernel void RowBoxBlurImage(__read_only image2d_t src,__write_only image2d_t dst,
const short cols, const short rows,
const short radius,int padSizeX,int padSizeY)
{
int iGidX=get_global_id(0)+padSizeX;
int iGidY=get_global_id(1)+padSizeY;

if(iGidY>=(rows+padSizeY))
return ;
if(iGidX!=padSizeX)
return ;

const float4 fscale=1.0f/(2*radius+1);

float4 sum =0;
int2 pos;
short x=0;



for (x = -radius; x < radius + 1; x++)
{
pos=(int2)(x+iGidX,iGidY);
sum += read_imagef(src, sampler, pos);
}

write_imagef(dst,(int2)(iGidX,iGidY),(sum*fscale));

int count=(cols-1);
x=1;

while(count>=4)
{
sum += read_imagef(src, sampler, (int2)(x+iGidX+radius,iGidY));
sum -= read_imagef(src, sampler, (int2)(x+iGidX-radius-1,iGidY));
write_imagef(dst,(int2)(x+iGidX,iGidY),(sum*fscale));
x++;
sum += read_imagef(src, sampler, (int2)(x+iGidX+radius,iGidY));
sum -= read_imagef(src, sampler, (int2)(x+iGidX-radius-1,iGidY));
write_imagef(dst,(int2)(x+iGidX,iGidY),(sum*fscale));
x++;
sum += read_imagef(src, sampler, (int2)(x+iGidX+radius,iGidY));
sum -= read_imagef(src, sampler, (int2)(x+iGidX-radius-1,iGidY));
write_imagef(dst,(int2)(x+iGidX,iGidY),(sum*fscale));
x++;
sum += read_imagef(src, sampler, (int2)(x+iGidX+radius,iGidY));
sum -= read_imagef(src, sampler, (int2)(x+iGidX-radius-1,iGidY));
write_imagef(dst,(int2)(x+iGidX,iGidY),(sum*fscale));
x++;

count-=4;
}
while(count>0)
{
sum += read_imagef(src, sampler, (int2)(x+iGidX+radius,iGidY));
sum -= read_imagef(src, sampler, (int2)(x+iGidX-radius-1,iGidY));
write_imagef(dst,(int2)(x+iGidX,iGidY),(sum*fscale));
x++;
count--;
}

}

__kernel void Motion_Blur(__read_only image2d_t src,__write_only image2d_t dst,
const int cols, const int rows,const int padSizeX,const int padSizeY,
float x0, float y0,float xi,float yi,int numSamples,
int imageWidth, int imageHeight)
{
int iGidX=get_global_id(0)+padSizeX;
int iGidY=get_global_id(1)+padSizeY;
if(iGidX>=(cols+padSizeX)||iGidY>=(rows+padSizeY))
return ;
float4 sum = 0.0f;
float2 pos = (float2)(iGidX + 0.5f + x0, iGidY + 0.5f + y0);
float2 delta = (float2)(xi, yi);
float2 imageSize = (float2)(imageWidth, imageHeight);

// Use normalized coordinates with linear sampling to work around bugs on some systems.
const sampler_t LineSampler=CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;

for (int i = 0; i < numSamples; i++)
{
	float2 normPos = pos / imageSize;
	sum += read_imagef(src, LineSampler, normPos);
pos += delta;
}

float4 result = sum / (float4)numSamples;
write_imagef(dst,(int2)(iGidX,iGidY),result);


}
//True Gaussian Kernel for pixel <=2.0
__kernel void GaussianRows(
__read_only image2d_t src,
__write_only image2d_t dst,
__read_only image2d_t c_kernel,
const int cols,
const int rows,
int KernelR,
const int padSizeX,
const int padSizeY
)
{
int x = get_global_id(0)+padSizeX;
int y = get_global_id(1)+padSizeY;
if(x >= (cols+padSizeX)||y >= (rows+padSizeY)) return;

float4 sum = 0.0f;
for(int k = -KernelR; k <= KernelR; k++)
{

sum = sum+read_imagef(src, sampler, (int2)(x+k,y)) * (float4)read_imagef(c_kernel, sampler, (int2)(k + KernelR,0)).x;
}
write_imagef(dst, (int2)(x,y), sum*((float4)0.00390625));
}
////////////////////////////////////////////////////////////////////////////////
// Column Convolution Filter - Gaussian smoothing
////////////////////////////////////////////////////////////////////////////////
__kernel void GaussianCols(
__read_only image2d_t src,
__write_only image2d_t dst,
__read_only image2d_t c_kernel,
const int cols,
const int rows,
int KernelR,
const int padSizeX,
const int padSizeY
)
{
int x = get_global_id(0)+padSizeX;
int y = get_global_id(1)+padSizeY;
if(x >= (cols+padSizeX)||y >= (rows+padSizeY)) return;

float4 sum = 0.0f;

for(int k = -KernelR; k <= KernelR; k++)
{
sum = sum+read_imagef(src, sampler, (int2)(x,y+k)) * (float4) read_imagef(c_kernel, sampler, (int2)(k + KernelR,0)).x;
}
write_imagef(dst, (int2)(x,y), sum*((float4)0.00390625));
}
//  Copyright (c) 2013 Adobe Systems Inc. All rights reserved.
#define Nrec 0.1111111111111111f
#define Srec 0.1666666666666667f
#define Frec 0.25f

// check CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE
__constant int2 XYsCStage1[4] = {
	(int2){0,  1}, (int2){ 1,  0}, (int2){ 0, -1}, (int2){-1,  0},
};

// 9 6 9 6 9
// 6 4 6 4 6
// 9 6 9 6 9
// 6 4 6 4 6
// 9 6 9 6 9

//__constant float IcountReciprocal[5][5] = {
//	{Nrec, Srec, Nrec, Srec, Nrec},
//	{Srec, Frec, Srec, Frec, Srec},
//	{Nrec, Srec, Nrec, Srec, Nrec},
//	{Srec, Frec, Srec, Frec, Srec},
//	{Nrec, Srec, Nrec, Srec, Nrec}
//};

// 0.1KB
//__constant float Icount[5][5] = {
//	{9.0f, 6.0f, 9.0f, 6.0f, 9.0f},
//	{6.0f, 4.0f, 6.0f, 4.0f, 6.0f},
//	{9.0f, 6.0f, 9.0f, 6.0f, 9.0f},
//	{6.0f, 4.0f, 6.0f, 4.0f, 6.0f},
//	{9.0f, 6.0f, 9.0f, 6.0f, 9.0f}
//};

// look up tables for stage 2 I_hf

// 0.1 KB
//__constant int lutL1[5][5] = {
//	{10, 19, 11, 22, 12},
//	{ 4,  0,  5,  1,  6},
//	{13, 20, 14, 23, 15},
//	{ 7,  2,  8,  3,  9},
//	{16, 21, 17, 24, 18}
//};

// table of center of patches that contribute to relevant pixel location.
//__constant int lutL2NumElements[25] = {
//	4, 4, 4, 4,
//	6, 6, 6, 6, 6, 6,
//	9, 9, 9, 9, 9, 9, 9, 9, 9,
//	6, 6, 6, 6, 6, 6
//};

// 25*9*4*2 = 1.8KB

// 0 1
// 2 3
__constant int2 lutL2[4][9] = {
	{(int2){-4, -4}, (int2){-2, -4}, (int2){ 0, -4}, (int2){-4, -2}, (int2){-2, -2}, (int2){ 0, -2}, (int2){-4,  0}, (int2){-2,  0}, (int2){ 0,  0}},	// (0, 0) contributed by 9 patches
	{(int2){ 0, -4}, (int2){ 0, -2}, (int2){ 0,  0}, (int2){-2, -4}, (int2){-2, -2}, (int2){-2,  0}},	// (1, 0) contributed by 6 patches
	{(int2){-4,  0}, (int2){-2,  0}, (int2){ 0,  0}, (int2){-4, -2}, (int2){-2, -2}, (int2){ 0, -2}},	// (0, 1) contributed by 6 patches
	{(int2){ 0,  0}, (int2){-2,  0}, (int2){ 0, -2}, (int2){-2, -2}}	// pixel (1, 1) contributed by 4 patches
};

//__constant int2 lutL2[25][9] = {
//	// 0, 1, 2, 3
//	{(int2){ 0,  0}, (int2){-2,  0}, (int2){ 0, -2}, (int2){-2, -2}},	// pixel (1, 1) contributed by 4 patches
//	{(int2){ 0,  0}, (int2){ 2,  0}, (int2){ 0, -2}, (int2){ 2, -2}},	// pixel (3, 1) contributed by 4 patches
//	{(int2){ 0,  0}, (int2){-2,  0}, (int2){ 0,  2}, (int2){-2,  2}},	// pixel (1, 3) contributed by 4 patches
//	{(int2){ 0,  0}, (int2){ 2,  0}, (int2){ 0,  2}, (int2){ 2,  2}},	// pixel (3, 3) contributed by 4 patches
//
//	// 4, 5, 6
//	{(int2){-4,  0}, (int2){-2,  0}, (int2){ 0,  0}, (int2){-4, -2}, (int2){-2, -2}, (int2){ 0, -2}},	// (0, 1) contributed by 6 patches
//	{(int2){-2,  0}, (int2){ 0,  0}, (int2){ 2,  0}, (int2){-2, -2}, (int2){ 0, -2}, (int2){ 2, -2}},	// (2, 1) contributed by 6 patches
//	{(int2){ 0,  0}, (int2){ 2,  0}, (int2){ 4,  0}, (int2){ 0, -2}, (int2){ 2, -2}, (int2){ 4, -2}},	// (4, 1) contributed by 6 patches
//
//	// 7, 8, 9
//	{(int2){-4,  0}, (int2){-2,  0}, (int2){ 0,  0}, (int2){-4,  2}, (int2){-2,  2}, (int2){ 0,  2}},	// (0, 3) contributed by 6 patches
//	{(int2){-2,  0}, (int2){ 0,  0}, (int2){ 2,  0}, (int2){-2,  2}, (int2){ 0,  2}, (int2){ 2,  2}},	// (2, 3) contributed by 6 patches
//	{(int2){ 0,  0}, (int2){ 2,  0}, (int2){ 4,  0}, (int2){ 0,  2}, (int2){ 2,  2}, (int2){ 4,  2}},	// (4, 3) contributed by 6 patches
//
//	// 10, 11, 12
//	{(int2){-4, -4}, (int2){-2, -4}, (int2){ 0, -4}, (int2){-4, -2}, (int2){-2, -2}, (int2){ 0, -2}, (int2){-4,  0}, (int2){-2,  0}, (int2){ 0,  0}},	// (0, 0) contributed by 9 patches
//	{(int2){-2, -4}, (int2){ 0, -4}, (int2){ 2, -4}, (int2){-2, -2}, (int2){ 0, -2}, (int2){ 2, -2}, (int2){-2,  0}, (int2){ 0,  0}, (int2){ 2,  0}},	// (2, 0) contributed by 9 patches
//	{(int2){ 0, -4}, (int2){ 2, -4}, (int2){ 4, -4}, (int2){ 0, -2}, (int2){ 2, -2}, (int2){ 4, -2}, (int2){ 0,  0}, (int2){ 2,  0}, (int2){ 4,  0}},	// (4, 0) contributed by 9 patches
//
//	// 13, 14, 15
//	{(int2){-4, -2}, (int2){-2, -2}, (int2){ 0, -2}, (int2){-4,  0}, (int2){-2,  0}, (int2){ 0,  0}, (int2){-4,  2}, (int2){-2,  2}, (int2){ 0,  2}},	// (0, 2) contributed by 9 patches
//	{(int2){-2, -2}, (int2){ 0, -2}, (int2){ 2, -2}, (int2){-2,  0}, (int2){ 0,  0}, (int2){ 2,  0}, (int2){-2,  2}, (int2){ 0,  2}, (int2){ 2,  2}},	// (2, 2) contributed by 9 patches
//	{(int2){ 0, -2}, (int2){ 2, -2}, (int2){ 4, -2}, (int2){ 0,  0}, (int2){ 2,  0}, (int2){ 4,  0}, (int2){ 0,  2}, (int2){ 2,  2}, (int2){ 4,  2}},	// (4, 2) contributed by 9 patches
//
//	// 16, 17, 18
//	{(int2){-4,  0}, (int2){-2,  0}, (int2){ 0,  0}, (int2){-4,  2}, (int2){-2,  2}, (int2){ 0,  2}, (int2){-4,  4}, (int2){-2,  4}, (int2){ 0,  4}},	// (0, 4) contributed by 9 patches
//	{(int2){-2,  0}, (int2){ 0,  0}, (int2){ 2,  0}, (int2){-2,  2}, (int2){ 0,  2}, (int2){ 2,  2}, (int2){-2,  4}, (int2){ 0,  4}, (int2){ 2,  4}},	// (2, 4) contributed by 9 patches
//	{(int2){ 0,  0}, (int2){ 2,  0}, (int2){ 4,  0}, (int2){ 0,  2}, (int2){ 2,  2}, (int2){ 4,  2}, (int2){ 0,  4}, (int2){ 2,  4}, (int2){ 4,  4}},	// (4, 4) contributed by 9 patches
//
//	// 19, 20, 21
//	{(int2){ 0, -4}, (int2){ 0, -2}, (int2){ 0,  0}, (int2){-2, -4}, (int2){-2, -2}, (int2){-2,  0}},	// (1, 0) contributed by 6 patches
//	{(int2){ 0, -2}, (int2){ 0,  0}, (int2){ 0,  2}, (int2){-2, -2}, (int2){-2,  0}, (int2){-2,  2}},	// (1, 2) contributed by 6 patches
//	{(int2){ 0,  0}, (int2){ 0,  2}, (int2){ 0,  4}, (int2){-2,  0}, (int2){-2,  2}, (int2){-2,  4}},	// (1, 4) contributed by 6 patches
//
//	// 22, 23, 24
//	{(int2){ 0, -4}, (int2){ 0, -2}, (int2){ 0,  0}, (int2){ 2, -4}, (int2){ 2, -2}, (int2){ 2,  0}},	// (3, 0) contributed by 6 patches
//	{(int2){ 0, -2}, (int2){ 0,  0}, (int2){ 0,  2}, (int2){ 2, -2}, (int2){ 2,  0}, (int2){ 2,  2}},	// (3, 2) contributed by 6 patches
//	{(int2){ 0,  0}, (int2){ 0,  2}, (int2){ 0,  4}, (int2){ 2,  0}, (int2){ 2,  2}, (int2){ 2,  4}}	// (3, 4) contributed by 6 patches
//};


// When output image size is {w, h}, work-item dimentions should be {roundUp(w/2), roundUp(h/w)} (without padding).

// Each work-item is responsible for one 5x5 patch

// inputImageRGBA32F: normalized padded RGBA image ranging from 0.0f ~ 1.0f.
// outputImage32FC4: denoised RGBA image ranging from 0.0f ~ 1.0f.
__kernel
void smartSharpenImage2dRGBA32fStage1(
    __read_only image2d_t inputImageDenoised32FC4,			// I_t0 (original denoised image)
    __read_only image2d_t inputImageBlurredIth32FC4,		// ith iteration smoothed image
    __read_only image2d_t inputImageUnsharpIth32FC4,		// ith iteration unsharp image (not smoothed image)
    const int outputImageW,	// inputImageXXX, Icount, imageHighFreqeuncy, outputImage are all the same size.
    const int outputImageH,
    __write_only image2d_t sharpenedImage32FC4,
    const int blurPadSize,	// padSize has to be >= 2.
	__local float* localBuf,
   __local int2* closestPatchPosBuf,
	const uint localBufSize,
	const float alpha
) {
	const int grpW = get_local_size(0);
	const int grpH = get_local_size(1);
	const int lidX = get_local_id(0);
	const int lidY = get_local_id(1);

    // smart sharpen handles patches by every other pixel
    // Each global_id is the center of the 5x5 patch

	// Every work item in the workgroup handles one patch.  Left, right, top, bottom all have extra two patches for over-computation.
	// (get_local_id(0)*2 - 2): shift to the left for two patches to do overcompute + get_group_id(0)*(get_local_size(0) - 4)*2 + blurPadSize + 2: shift to the center.
	//globalOutputPos: center global position of a patch.

	const int2 globalOutputPos = (int2){
		((get_local_id(0) - 2) * 2) + get_group_id(0)*(get_local_size(0) - 4)*2 + blurPadSize + 2,
		((get_local_id(1) - 2) * 2) + get_group_id(1)*(get_local_size(1) - 4)*2 + blurPadSize + 2
	}; // patch center


	//int2 closestReadPos;

	{
		// localBuf: first ((localWorkSize[0])*2 + 3)*((localWorkSize[1])*2 + 3) stores image diff
		// second ((localWorkSize[0])*2 + 3)*((localWorkSize[1])*2 + 3) stores squared
		// store squared difference in ssdBuf using ((localWorkSize[0])*2 + 3)*((localWorkSize[1])*2 + 3) area
		__local float* ssdBuf = (__local float*)localBuf;	// store squared image difference


		// upper left corner of the over compute patch to the left:.
		// o o x x x ... x x x o o -> o: overcompute patches, x: the patches that generate the results (including I_hf).
		const int2 globalReadPos = (int2){globalOutputPos.x - 2 - lidX*2, globalOutputPos.y - 2 - lidY*2}; // upper left corner of the workgroup

		float ssdOld = MAXFLOAT;
		float ssd = 0.0f;


		// search five patches
		float4 tmpValue;
		int ssdBufWidth = (grpW)*2 + 3;

		//                       grpW
		//  <-  ssdBuf  ->  <closest patch pos>
		//	x x x ... x x x o o o ... o o o  ^
 		//	x x x ... x x x o o o ... o o o  grpH
		//  ...         ... ...         ...
		//  x x x ... x x x o o o ... o o o  v
		for (int i = 0; i < 4; ++i)
		{
			// work-items are used as 1d work-items here.
			int ssdBufIdx = lidX + lidY*grpW;
			while (ssdBufIdx < (grpW*2 + 3)*(grpH*2 + 3))
			{
				int linearlocal2globalShiftX = ssdBufIdx % ssdBufWidth;
				int linearlocal2globalShiftY = ssdBufIdx / ssdBufWidth;

				tmpValue =
					read_imagef(inputImageUnsharpIth32FC4, sampler,
						(int2){globalReadPos.x + linearlocal2globalShiftX, globalReadPos.y + linearlocal2globalShiftY})
					- read_imagef(inputImageBlurredIth32FC4, sampler,
						(int2){globalReadPos.x + linearlocal2globalShiftX + XYsCStage1[i].x, globalReadPos.y + linearlocal2globalShiftY + XYsCStage1[i].y});

				ssdBuf[ssdBufIdx]  = dot(tmpValue, tmpValue);
				ssdBufIdx += grpW*grpH;
			}

			// fill the closest patch position
			// need to handle extra over compute area

			int ssdTableIdx = lidY*2*ssdBufWidth + lidX*2;	// upper left corner of a patch.
			ssd = 0.0f;

			barrier(CLK_LOCAL_MEM_FENCE);	// ssdBuf is done


			// 3% bank conflict !!!
			for (int row = 0; row < 5; ++row)
			{
				ssd += ssdBuf[ssdTableIdx];
				ssd += ssdBuf[ssdTableIdx + 1];
				ssd += ssdBuf[ssdTableIdx + 2];
				ssd += ssdBuf[ssdTableIdx + 3];
				ssd += ssdBuf[ssdTableIdx + 4];
				ssdTableIdx += ssdBufWidth;
			}

			if (ssd < ssdOld)
			{
				ssdOld = ssd;
				closestPatchPosBuf[lidX + lidY*grpW] = XYsCStage1[i];
			}

		}

		// 9 6 9 6 9
		// 6 4 6 4 6
		// 9 6 9 6 9
		// 6 4 6 4 6
		// 9 6 9 6 9
		// center patch
		// The ssdBuf will store the diff of I_us and I_sm and pass to stage 2.
		{
			int bufIdx = lidX + lidY*grpW;

			while (bufIdx < (grpW*2 + 3)*(grpH*2 + 3))
			{
				int linearlocal2globalShiftX = bufIdx % ssdBufWidth;
				int linearlocal2globalShiftY = bufIdx / ssdBufWidth;

				tmpValue = read_imagef(inputImageUnsharpIth32FC4, sampler, (int2){globalReadPos.x + linearlocal2globalShiftX, globalReadPos.y + linearlocal2globalShiftY})
					- read_imagef(inputImageBlurredIth32FC4, sampler, (int2){globalReadPos.x + linearlocal2globalShiftX, globalReadPos.y + linearlocal2globalShiftY});

				//localBuf[bufIdx]  = tmpValue;
				ssdBuf[bufIdx] = dot(tmpValue, tmpValue);
				bufIdx += grpW*grpH;
			}
		}
		ssd = 0.0f;
		{
			int ssdTableIdx = lidY*2*ssdBufWidth + lidX*2;

			barrier(CLK_LOCAL_MEM_FENCE);

			// !!! Serious bank conflict 20% !!! Needs revision !!!
			for (int row = 0; row < 5; ++row)
			{
				//tmpValue = localBuf[ssdTableIdx];
				//ssd += dot(tmpValue, tmpValue);

				//tmpValue = localBuf[ssdTableIdx + 1];
				//ssd += dot(tmpValue, tmpValue);

				//tmpValue = localBuf[ssdTableIdx + 2];
				//ssd += dot(tmpValue, tmpValue);

				//tmpValue = localBuf[ssdTableIdx + 3];
				//ssd += dot(tmpValue, tmpValue);

				//tmpValue = localBuf[ssdTableIdx + 4];
				//ssd += dot(tmpValue, tmpValue);
				//ssdTableIdx += ssdBufWidth;

				ssd += ssdBuf[ssdTableIdx];
				ssd += ssdBuf[ssdTableIdx + 1];
				ssd += ssdBuf[ssdTableIdx + 2];
				ssd += ssdBuf[ssdTableIdx + 3];
				ssd += ssdBuf[ssdTableIdx + 4];
				ssdTableIdx += ssdBufWidth;
			}

			if (ssdOld >= ssd*0.7f && ssd > 0.0f)	// center patch is good enough, choose the center patch instead.
			{
				closestPatchPosBuf[lidX + lidY*grpW] = (int2){0, 0};
			}

		}
	}


	///////////////////////////////////////////////////////////
	// Stage 2: Calculate the High Frequency Image and Stage 3
	///////////////////////////////////////////////////////////
	barrier(CLK_LOCAL_MEM_FENCE);


	if ((globalOutputPos.x > outputImageW - blurPadSize + 1) |  (globalOutputPos.y > outputImageH - blurPadSize + 1))
		return;

	// every work-item handles upper left 2x2 area
	// x x
	// x x
	// can handle extra one padding for each dimension.
	//int ssdBufWidth = (grpW)*2 + 3;
	int2 locShift;
	int2 readLocShift;

	if ((lidX > 1) & (lidY > 1) & (lidX < grpW - 2) & (lidY < grpH - 2))
	{
		// (0, 0)
		float4 IhfValue = (float4){0.0f, 0.0f, 0.0f, 0.0f};
		for (int idx = 0; idx < 9; ++idx)
		{
			locShift = lutL2[0][idx]/2;
			readLocShift = closestPatchPosBuf[lidX + locShift.x + (lidY + locShift.y)*grpW];
			//IhfValue += localBuf[lidX*2 + readLocShift.x + (lidY*2 + readLocShift.y)*ssdBufWidth];
			IhfValue += read_imagef(inputImageUnsharpIth32FC4, sampler, (int2){globalOutputPos.x - 2 + readLocShift.x, globalOutputPos.y - 2 + readLocShift.y})
				- read_imagef(inputImageBlurredIth32FC4, sampler, (int2){globalOutputPos.x - 2 + readLocShift.x, globalOutputPos.y - 2 + readLocShift.y});
		}
		IhfValue *= Nrec;

		int2 writePos = (int2){globalOutputPos.x - 2, globalOutputPos.y - 2};
		if ((writePos.x < outputImageW - blurPadSize) & (writePos.y < outputImageH - blurPadSize))
		write_imagef(
			sharpenedImage32FC4, writePos,
			alpha*IhfValue	+ alpha*read_imagef(inputImageDenoised32FC4, sampler, writePos)
			+ (1.0f - alpha)*read_imagef(inputImageUnsharpIth32FC4, sampler, writePos)
		);


		// (1, 0)
		IhfValue = (float4){0.0f, 0.0f, 0.0f, 0.0f};
		for (int idx = 0; idx < 6; ++idx)
		{
			locShift = lutL2[1][idx]/2;
			readLocShift = closestPatchPosBuf[lidX + locShift.x + (lidY + locShift.y)*grpW];
			//IhfValue += localBuf[lidX*2 + 1 + readLocShift.x + (lidY*2 + readLocShift.y)*ssdBufWidth];
			IhfValue += read_imagef(inputImageUnsharpIth32FC4, sampler, (int2){globalOutputPos.x - 1 + readLocShift.x, globalOutputPos.y - 2 + readLocShift.y})
				- read_imagef(inputImageBlurredIth32FC4, sampler, (int2){globalOutputPos.x - 1 + readLocShift.x, globalOutputPos.y - 2 + readLocShift.y});
		}
		IhfValue *= Srec;

		writePos = (int2){globalOutputPos.x - 2 + 1, globalOutputPos.y - 2};
		if ((writePos.x < outputImageW - blurPadSize) & (writePos.y < outputImageH - blurPadSize))
		write_imagef(
			sharpenedImage32FC4, writePos,
			alpha*IhfValue	+ alpha*read_imagef(inputImageDenoised32FC4, sampler, writePos)
			+ (1.0f - alpha)*read_imagef(inputImageUnsharpIth32FC4, sampler, writePos)
		);

		// (0, 1)
		IhfValue = (float4){0.0f, 0.0f, 0.0f, 0.0f};
		for (int idx = 0; idx < 6; ++idx)
		{
			locShift = lutL2[2][idx]/2;
			readLocShift = closestPatchPosBuf[lidX + locShift.x + (lidY + locShift.y)*grpW];
			//IhfValue += localBuf[lidX*2 + readLocShift.x + (lidY*2 + 1 + readLocShift.y)*ssdBufWidth];
			IhfValue += read_imagef(inputImageUnsharpIth32FC4, sampler, (int2){globalOutputPos.x - 2 + readLocShift.x, globalOutputPos.y - 1 + readLocShift.y})
				- read_imagef(inputImageBlurredIth32FC4, sampler, (int2){globalOutputPos.x - 2 + readLocShift.x, globalOutputPos.y - 1 + readLocShift.y});
		}
		IhfValue *= Srec;

		writePos = (int2){globalOutputPos.x - 2, globalOutputPos.y - 2 + 1};
		if ((writePos.x < outputImageW - blurPadSize) & (writePos.y < outputImageH - blurPadSize))
		write_imagef(
			sharpenedImage32FC4, writePos,
			alpha*IhfValue	+ alpha*read_imagef(inputImageDenoised32FC4, sampler, writePos)
			+ (1.0f - alpha)*read_imagef(inputImageUnsharpIth32FC4, sampler, writePos)
		);

		// (1, 1)
		IhfValue = (float4){0.0f, 0.0f, 0.0f, 0.0f};
		for (int idx = 0; idx < 4; ++idx)
		{
			locShift = lutL2[3][idx]/2;
			readLocShift = closestPatchPosBuf[lidX + locShift.x + (lidY + locShift.y)*grpW];
			//IhfValue += localBuf[lidX*2 + 1 + readLocShift.x + (lidY*2 + 1 + readLocShift.y)*ssdBufWidth];
			IhfValue += read_imagef(inputImageUnsharpIth32FC4, sampler, (int2){globalOutputPos.x - 1 + readLocShift.x, globalOutputPos.y - 1 + readLocShift.y})
				- read_imagef(inputImageBlurredIth32FC4, sampler, (int2){globalOutputPos.x - 1 + readLocShift.x, globalOutputPos.y - 1 + readLocShift.y});
		}
		IhfValue *= Frec;

		writePos = (int2){globalOutputPos.x - 2 + 1, globalOutputPos.y - 2 + 1};
		if ((writePos.x < outputImageW - blurPadSize) & (writePos.y < outputImageH - blurPadSize))
		write_imagef(
			sharpenedImage32FC4, writePos,
			alpha*IhfValue	+ alpha*read_imagef(inputImageDenoised32FC4, sampler, writePos)
			+ (1.0f - alpha)*read_imagef(inputImageUnsharpIth32FC4, sampler, writePos)
		);
	}

// SHARPENV2 o o x x x ... x x x o o
	//if (get_local_id(0) > 1 && get_local_id(1) > 1 && get_local_id(0) < get_local_size(0) - 2 && get_local_id(1) < get_local_size(1) - 2)
	//{
	//	closestPatchReadPosTable[get_local_id(0) - 2 + get_group_id(0)*(get_local_size(0) - 4)
	//		+ (get_local_id(1) - 2 + get_group_id(1)*(get_local_size(1) - 4))*globalItemW] = closestReadPos;
	//}

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
