inline float2 ellipseRadii( const float R, const float distortion, const float radius_max)
{
	float R1, R2;
    // Positive distortion shrinks the radius transverse to the line of sight to the tilt shift marker
    // On the other hand, negative distortion shrinks the radius along the line of sight to the tilt shift marker
    // Thus, positive distortions lead to ellipse heading radially towards the marker (think of cigar-shaped ellipses)
    // while negative distortions lead to ellipses encircliing the marker
    if (0 <= distortion)
       {
       R1 = R;
       R2 = R / (1.0f  +  distortion);
       }
    else
       {
       R1 = R / (1.0f  -  distortion);
       R2 = R;
       }
     // Make sure the radii are in the allowed range of values
	R1=min(max(R1,0.f),radius_max);
	R2=min(max(R2,0.f),radius_max);
	return (float2)(R1,R2);
}
inline float4 ellipseVariables(const float R1, const float R2, const float sine, const float cosine, const float inverse_R1_squared, const float inverse_R2_squared)
{
   float k1, k2, beta2;
   const float R1_sine = R1 * sine;
   const float R2_cosine = R2 * cosine;
   const float R1_sine_R2_cosine = R1_sine * R2_cosine;
   beta2 = R1_sine * R1_sine + R2_cosine * R2_cosine;
   const float R1_R2 = R1 * R2;
   k1 = (R1_sine_R2_cosine * (R2*R2 - R1*R1)/R1_R2)/beta2;
   k2 = R1_R2/beta2;
   return (float4)(k1,k2,beta2,0.f);
}
#define DO_PARTIAL_ELLIPTICAL_IMAGEALL		 													\
	{																							\
    const float dy_sine = iChord * sine;														\
    const float dy_cosine = iChord * cosine;													\
    /* squared distance to center point*/														\
    int D2 = YCenter2 + dx_left * dx_left;														\
    for(int dx = dx_left; dx < dx_right; ++dx)													\
        {																						\
        /*distance from the point to the center of the ellipse*/								\
        const float D = sqrt((float)D2);														\
        const float dx_rotated = dx * cosine - dy_sine;											\
        const float dy_rotated = dy_cosine + dx * sine;											\
																								\
        const float dx_rotated_squared = dx_rotated * dx_rotated;								\
        const float dy_rotated_squared = dy_rotated * dy_rotated;								\
																								\
        /* F = 1 on the ellipse and is less than 1 on the inside*/								\
        const float F = sqrt (dx_rotated_squared * invR.x + dy_rotated_squared * invR.y);		\
																								\
        /*TODO - This can go slightly -ve*/														\
        const float approxCoverage = .5f+(D * (1.0/F)  - D );									\
        const float zero = 0.f;																	\
        float partialArea=max(approxCoverage,0.f);												\
																								\
        /*const float R1 = 1.0/fast_sqrt (inverse_R1_squared); // for debugging*/				\
        /*const float partial_area = std::fabs (R1 + 0.5 - D);*/								\
        /*ASSERT (0 <= partial_area, "Warning (gdw). negative blur weight");*/					\
		int right= min(max(tidX+dx,0),row_increment_in-1);										\
		int left= min(max(tidX+dx-1,0),row_increment_in-1);										\
		{																						\
		float4 diff;																			\
				diff=			(read_imagef(incrementalSumImage3,sampler,(int2)(right,(tidY+iChord)))	\
						-read_imagef(incrementalSumImage3,sampler,(int2)(left,(tidY+iChord))))*partialArea;	\
					sum3= sum3 +	diff.x;																	\
				diff=			(read_imagef(incrementalSumImage2,sampler,(int2)(right,(tidY+iChord)))	\
						-read_imagef(incrementalSumImage2,sampler,(int2)(left,(tidY+iChord))))*partialArea;	\
					sum2= sum2 +	diff.x;																	\
				diff=			(read_imagef(incrementalSumImage1,sampler,(int2)(right,(tidY+iChord)))  \
						-read_imagef(incrementalSumImage1,sampler,(int2)(left,(tidY+iChord))))*partialArea;	\
					sum1= sum1 +	diff.x;																	\
					sum4= sum4 + (read_imagef(incrementalSumImage,sampler,(int2)(right,(tidY+iChord)))  \
						-read_imagef(incrementalSumImage,sampler,(int2)(left,(tidY+iChord))))*partialArea;	\
		}																						\
        area += partialArea;																	\
        D2 += ((dx<<1) + 1);																	\
        }																						\
    }																							\

__kernel void GenerateEllipseSmoothBlur_ImageFFALL(__global float * lensBlurImage0,__global float * lensBlurImage1,
																		__global float * lensBlurImage2,
																		__global float * lensBlurImage3,
                                                                        __global float * lensBlurImage4,
                                                                        __global float * lensBlurImage5,
                                                                        __global float * lensBlurImage6,
																		__read_only image2d_t incrementalSumImage,
                                                                        __read_only image2d_t incrementalSumImage1,
                                                                        __read_only image2d_t incrementalSumImage2,
                                                                        __read_only image2d_t incrementalSumImage3,
																		const __global float * restrict  radiusImage,
																		const __global float * restrict  ellipse_angle,
																		const __global float * restrict  ellipse_distortion,
																		float radiusMax, int width, int height,
																		int row_increment_in, int row_increment_out,
																		int radius_increment, int ellipse_angle_increment,
																		int ellipse_distortion_increment,
																		int channels,
																		int smooth,int OffsetX,int OffsetY)
{
	const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
	int tidX=get_global_id(0);
	int tidY=get_global_id(1);
	if(tidX>=(width) || tidY>=(height))
		return;
	int tidOffX=tidX-OffsetX;
	int tidOffY=tidY-OffsetY;
	float radiusNorm=radiusImage[(tidX)+(tidY)*radius_increment];
	float radius= radiusNorm * radiusMax;
	const float ellipseDistortion=ellipse_distortion[(tidOffX)+(tidOffY)*ellipse_distortion_increment];
	const float ellipseAngle=ellipse_angle[(tidOffX)+(tidOffY)*ellipse_angle_increment];
	float2 R12=ellipseRadii(radius,ellipseDistortion,radiusMax);
	if(R12.x<0.5 || R12.y<0.5)
		{
			//R12 = max(R12,(float2)0.5f);
                  float4 sum4;
                  float sum2,sum1, sum3;
                  switch(channels)
                  {
                        case 7:
                              sum4=(read_imagef(incrementalSumImage3,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage3,sampler,(int2)(tidX-1,tidY)));
							  sum3=sum4.x;
                        case 6:
                              sum4=(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
							  sum2=sum4.x;
                        case 5:
                              sum4=(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
							  sum1=sum4.x;
                        case 4:
                        case 3:
                              sum4=(read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage,sampler,(int2)(tidX-1,tidY)));
                              break;
                        case 2:
                              sum4=(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
							  sum2=sum4.x;
                        case 1:
                              sum4=(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
							  sum1=sum4.x;
                        default:
                              break;
                  }
			switch(channels)
				{
                        case 7:
                              lensBlurImage6[tidOffX+(tidOffY)*row_increment_out]=sum3;
                        case 6:
                              lensBlurImage5[tidOffX+(tidOffY)*row_increment_out]=sum2;
                        case 5:
                              lensBlurImage4[tidOffX+(tidOffY)*row_increment_out]=sum1;
                        case 4:
						case 3:
                              lensBlurImage3[tidOffX+(tidOffY)*row_increment_out]=sum4.w;
                              lensBlurImage2[tidOffX+(tidOffY)*row_increment_out]=sum4.z;
                              lensBlurImage1[tidOffX+(tidOffY)*row_increment_out]=sum4.y;
                              lensBlurImage0[tidOffX+(tidOffY)*row_increment_out]=sum4.x;
                              break;
                        case 2:
                              lensBlurImage1[tidOffX+(tidOffY)*row_increment_out]=sum2;
                        case 1:
                              lensBlurImage0[tidOffX+(tidOffY)*row_increment_out]=sum1;
                        default:
                              break;
				}
			return;
		}
	float2 invR= ((float2) 1.0f)/(R12*R12);
	float sine= sin(ellipseAngle);
	float cosine= cos(ellipseAngle);
	float area=0;
      float4 sum4=0;
      float sum3=0;
      float sum2=0;
      float sum1=0;
	float4 k1k2beta2=ellipseVariables(R12.x,R12.y,sine,cosine,invR.x,invR.y);
	const float gridHeight = -(((int)rint(sqrt(k1k2beta2.z)))+0.5f);
	int iChord = gridHeight ;
	int YCenter2 = iChord*iChord;
	float topLeftChordWidth = 0.f;
    float bottomLeftChordWidth = 0.f;
    float topRightChordWidth = 0.f;
    float bottomRightChordWidth = 0.f;
	for(float iGrid=gridHeight+1.f; iGrid < (-gridHeight)+1.f; iGrid+=1.f)
	{
	 // The left (1) and right (2) x axis intersections (relative to an origin at the pixel center), dx, of the ellipse for specified dy coordinate are given by
     // dx1  = k1 dy - k2 sqrt (beta2 - dy*dy)
     // dx2  = k1 dy + k2 sqrt (beta2 - dy*dy)
        const float D2 = k1k2beta2.z-(float) iGrid * iGrid;
        const float k1_dy = k1k2beta2.x * (iGrid);
        const float k2_sqrt = k1k2beta2.y * sqrt (max(D2,0.f));
        // (L)eft and (R)ight precise horizontal (x axis) displacements for obtaining the chord endpoints
		const float dx_R_b = (D2 > 0)?(k1_dy + k2_sqrt) : 0 ;
		const float dx_L_b = (D2 > 0)?(k1_dy - k2_sqrt) : 0 ;
        bottomRightChordWidth = min(max(dx_R_b,-radiusMax),radiusMax);
        bottomLeftChordWidth =  min(max(dx_L_b,-radiusMax),radiusMax);
		int leftIndex;
        int rightIndex;
		int rightFull;
		int leftFull;
		leftIndex =  (int)rint(min(topLeftChordWidth, bottomLeftChordWidth));
		rightIndex = (int)rint(max(topRightChordWidth, bottomRightChordWidth));
		 //Determine which pixels are fully covered
        float rFull=min(topRightChordWidth, bottomRightChordWidth);
        float lFull=max(topLeftChordWidth, bottomLeftChordWidth);
        //????: Seeing errors using ceil on NVIDIA 1700, but not in the other kernels
        const float lGridFull = lFull+.5f;
		leftFull = lGridFull - floor(lGridFull) > 0 ? lGridFull : lGridFull + 1.f;
		rightFull = floor(rFull-.5f);
        if (topRightChordWidth*topLeftChordWidth == 0.f)
        {
            rightIndex = (bottomRightChordWidth);
            leftIndex = (bottomLeftChordWidth);
            rightFull = leftFull = rightIndex+1;
        }
        else if(bottomLeftChordWidth * bottomRightChordWidth == 0.f)
        {
            rightIndex = (topRightChordWidth);
            leftIndex = (topLeftChordWidth);
            rightFull = leftFull = rightIndex+1;
        }
		int dx_left=leftIndex;
		int dx_right=leftFull;
		if(smooth)
			DO_PARTIAL_ELLIPTICAL_IMAGEALL
		if(rightFull<= rightIndex)
        {
            //Using incremental image does not work for x=0 column
            if(false)
            {
				int shift=min(max(tidX+leftFull,0),row_increment_in-1);
                        float4 sumdt;
                        //float sumdt1;
                        switch(channels)
                              {
                              case 7:
                                    sumdt=(read_imagef(incrementalSumImage3,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage3,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum3 = sum3 + sumdt.x;
                              case 6:
                                    sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.x;
                              case 5:
                                    sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage1,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum1 = sum1 + sumdt.x;
                              case 4:
                              case 3:
                                    sumdt=(read_imagef(incrementalSumImage,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum4 = sum4 +sumdt;
                                    break;
                              case 2:
                                    sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.x;
                              case 1:
                                    sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage1,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum1 = sum1 + sumdt.x;
                              default:
                                    break;
                              }
				area = area + 1.0;
            }
            else
            {
				int right= min(max(tidX+rightFull,0),row_increment_in-1);
				int left= min(max(tidX+leftFull-1,0),row_increment_in-1);
                        float4 sumdt;
                        //float sumdt1;
                        switch(channels)
                              {
                              case 7:
                                    sumdt=(read_imagef(incrementalSumImage3,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage3,sampler,(int2)(left,(tidY+iChord))));
                                    sum3 = sum3 + sumdt.x;
                              case 6:
                                    sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(left,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.x;
                              case 5:
                                    sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage1,sampler,(int2)(left,(tidY+iChord))));
                                    sum1 = sum1 + sumdt.x;
                              case 4:
                              case 3:
                                    sumdt=(read_imagef(incrementalSumImage,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage,sampler,(int2)(left,(tidY+iChord))));
                                    sum4 = sum4 +sumdt;
                                    break;
                              case 2:
                                    sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(left,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.x;
                              case 1:
                                    sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage1,sampler,(int2)(left,(tidY+iChord))));
									sum1 = sum1 + sumdt.x;
                              default:
                                    break;
                              }
							/*sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(left,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.y;
							sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage1,sampler,(int2)(left,(tidY+iChord))));
                                    sum1 = sum1 + sumdt.x;
							sumdt=(read_imagef(incrementalSumImage,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage,sampler,(int2)(left,(tidY+iChord))));
									sum4 = sum4 +sumdt;*/
				area = area + (right - left);
            }
        }
		dx_left=rightFull+1;
		dx_right=rightIndex+1;
		if(smooth)
			DO_PARTIAL_ELLIPTICAL_IMAGEALL
		 topLeftChordWidth = bottomLeftChordWidth;
		 topRightChordWidth = bottomRightChordWidth;
		 YCenter2 += ((iChord<<1)+1);
         iChord++;
	}
	float divBy=1.0;
	if(area>1)
		divBy=1.0/area; // this is a mac ati bugfix for  p/q is inaccurate as compared to p*(1/q)
	else
            {
				 float4 sumdt;
                  switch(channels)
                        {
                              case 7:
                                    sumdt=(read_imagef(incrementalSumImage3,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage3,sampler,(int2)(tidX-1,tidY)));
									sum3=sumdt.x;
                              case 6:
                                    sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
									sum2=sumdt.x;
                              case 5:
                                    sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
									sum1=sumdt.x;
                              case 4:
                              case 3:
                                    sum4=(read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage,sampler,(int2)(tidX-1,tidY)));
                                    break;
                              case 2:
                                    sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
									sum2=sumdt.x;
                              case 1:
                                    sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
									sum1=sumdt.x;
                              default:
                                    break;
                        }
            }
	switch(channels)
	{
            case 7:
                  lensBlurImage6[tidOffX+(tidOffY)*row_increment_out]=sum3*divBy;
            case 6:
                  lensBlurImage5[tidOffX+(tidOffY)*row_increment_out]=sum2*divBy;
            case 5:
                  lensBlurImage4[tidOffX+(tidOffY)*row_increment_out]=sum1*divBy;
            case 4:
			case 3:
                  lensBlurImage3[tidOffX+(tidOffY)*row_increment_out]=sum4.w*divBy;
                  lensBlurImage2[tidOffX+(tidOffY)*row_increment_out]=sum4.z*divBy;
                  lensBlurImage1[tidOffX+(tidOffY)*row_increment_out]=sum4.y*divBy;
                  lensBlurImage0[tidOffX+(tidOffY)*row_increment_out]=sum4.x*divBy;
                  break;
            case 2:
                  lensBlurImage1[tidOffX+(tidOffY)*row_increment_out]=sum2*divBy;
            case 1:
                  lensBlurImage0[tidOffX+(tidOffY)*row_increment_out]=sum1*divBy;
	}
}
__kernel void copybuftoimage(__global float *maskBuffer,__write_only image2d_t dst, int width,int height,int mode)
{

int tidx=get_global_id(0);
int tidy=get_global_id(1);


if(tidx>=width ||tidy>=height)
return ;

float data=(maskBuffer[tidy*width+tidx]);
float scaleddata=mode?0.5f:data;
float4 color = (float4)(data,scaleddata,scaleddata,data);
write_imagef(dst,(int2)(tidx,tidy),color);
}
__kernel void normalizeToImage( const __global float* restrict maskBuffer0,
								 const __global float* restrict maskBuffer1,
								 const __global float* restrict maskBuffer2,
								 const __global float* restrict maskBuffer3,
								 const __global float* restrict maskBuffer4,
								 const __global float* restrict maskBuffer5,
								 const __global float* restrict normalBuffer,
								 const int d_buffer,
								 __read_only image2d_t inputColor,
								 __read_only image2d_t inputAlpha,
								 __read_only image2d_t inputLayer,
								 const float selectionBleed,
								 __read_only image2d_t selectionMask,
								 __write_only image2d_t dst, __write_only image2d_t alphaDst, __write_only image2d_t layerDst,
								int width,int height,int offsetX,int offsetY )
{
    const sampler_t sampler =   CLK_NORMALIZED_COORDS_FALSE |
                                CLK_ADDRESS_CLAMP_TO_EDGE |
                                CLK_FILTER_NEAREST;
int tidx=get_global_id(0);
int tidy=get_global_id(1);


if(tidx>=width ||tidy>=height)
	return ;
//Due to linear-sample, need to have the edges replicated
tidx = max(1, tidx);
tidx = min(width-2, tidx);
tidy = max(1, tidy);
tidy = min(height-2, tidy);
int tidOffX=tidx+offsetX;
int tidOffY=tidy+offsetY;
float selection = read_imagef(selectionMask, sampler, (int2)(tidOffX, tidOffY)).x;
const float4 selectionVec = (float4)(selection, selection, selection, selection);
const float4 input = read_imagef(inputColor, sampler, (int2)(tidOffX, tidOffY));
const float alpha = read_imagef(inputAlpha, sampler, (int2)(tidOffX, tidOffY)).x;
const float layer = read_imagef(inputLayer, sampler, (int2)(tidOffX, tidOffY)).x;
const float data0=(maskBuffer0[tidy*d_buffer+tidx]);
const float data1=(maskBuffer1[tidy*d_buffer+tidx]);
const float data2=(maskBuffer2[tidy*d_buffer+tidx]);
const float data3=(maskBuffer3[tidy*d_buffer+tidx]);
const float normal=(normalBuffer[tidy*d_buffer+tidx]);
float4 blurColor = (float4)(data0/normal,data1/normal,data2/normal,data3/normal);
float blurAlpha = (maskBuffer4[tidy*d_buffer+tidx])/normal;
float blurLayer = (maskBuffer5[tidy*d_buffer+tidx])/normal;
//Need to account for impact of precision during divide (especially for HDR image)
blurColor /= normal/normal;
blurAlpha /= normal/normal;
blurLayer /= normal/normal;
const float blendAdd = (1.f-selectionBleed)*(1.f-selection);
const float4 blendInput = blendAdd*input;
const float4 result = normal > 0.f ? (selection*blurColor)+((1-selection)*input) : input;
const float resultAlpha = normal > 0.f ? (selection*blurAlpha)+((1-selection)*alpha) : alpha;
const float resultLayer = normal > 0.f ? (selection*blurLayer)+((1-selection)*layer) : layer;
write_imagef(dst,(int2)(get_global_id(0)+offsetX, get_global_id(1)+offsetY), result);
write_imagef(alphaDst,(int2)(get_global_id(0)+offsetX, get_global_id(1)+offsetY), resultAlpha);
write_imagef(layerDst,(int2)(get_global_id(0)+offsetX, get_global_id(1)+offsetY), resultLayer);
}
inline void _RNGbkey(unsigned int  *key)
{
key[0] += ((unsigned int) 2654435769);
key[1] += ((unsigned int) 3144134277);
}

inline unsigned int multihi(unsigned int a, unsigned int b, unsigned int * h)
{
ulong  p = ((ulong ) a) * ((ulong ) b);
*h = p >> 32;
return (unsigned int) p;
}


inline void _RNGround (unsigned int *c, unsigned int *key)
{
unsigned int h[2];
unsigned int a0 = multihi (((unsigned int) 3528531795), c[0], &h[0]);
unsigned int a1 = multihi(((unsigned int) 3449720151), c[2], &h[1]);

c[0]=h[1] ^ c[1] ^ key[0];
c[1]=a1;
c[2]=h[0] ^ c[3] ^ key[1];
c[3]=a0;

}

inline void  _RNG(unsigned int R, unsigned int *c, unsigned int *key)
{

_RNGround (c, key);

for(unsigned int i=1;i<R;i++)
{
_RNGbkey(key);
_RNGround (c, key);
}


}

inline
float fast_sqrt (float x)
{
union
{
int i;
float x;
} u;

if (x <= 0)
{
return 0;
}
else
{
u.x = x;
u.i = (1<<29) + (u.i >> 1) - (1<<22);

// One Babylonian Step
u.x = 0.5f * (u.x + x/u.x);

return u.x;
}
}
__kernel void add_midtone_noise(__global float *src,unsigned int _number,
float noise_amplitude)
{
unsigned int tid=get_global_id(0);
if(tid>=_number)
return ;
unsigned int c[4] ={tid,0,0,0};
unsigned int key[2] = {3735928559,3738021615};
_RNG(10,c,key);

ulong scale=4294967295;
float in=src[tid];
float noise =noise_amplitude * 2.0f * ((float)c[0]/scale - 0.5f);
float midtone_mask = fast_sqrt (4.0f * in* (1.0f - in));
src[tid]=max (0.0f,min ((in+  midtone_mask * noise), 1.0f));
}

__kernel void
copyImage( __read_only image2d_t  input,
             __write_only image2d_t output  )
{
    const sampler_t sampler =   CLK_NORMALIZED_COORDS_FALSE |
                                CLK_ADDRESS_CLAMP_TO_EDGE |
                                CLK_FILTER_NEAREST;
    const int x = get_global_id(0);
    const int y = get_global_id(1);
    write_imagef(output, (int2)(x,y),read_imagef(input, sampler, (int2)(x,y)));
}
__kernel void
applySelection(	__read_only image2d_t  input, __read_only image2d_t selection, const int width, const int height, const float bleed,
					__write_only image2d_t output  )
{
    const sampler_t sampler =   CLK_NORMALIZED_COORDS_FALSE |
                                CLK_ADDRESS_CLAMP_TO_EDGE |
                                CLK_FILTER_NEAREST;
    const int x = get_global_id(0);
    const int y = get_global_id(1);
	if(y>=height || x>=width)
			return;
    const int2 currentPos = (int2)(x, y);
	 const float4 unit = (float4)(1.f, 1.f, 1.f, 1.f);
	 const float select = read_imagef(selection, sampler, currentPos).x;
    write_imagef(output, currentPos, (bleed+(1.f-bleed)*select)*read_imagef(input, sampler, currentPos));
}
__kernel void GenerateIncrementalSumImageX(__write_only image2d_t incrementalSumImage,__read_only image2d_t inputImage,int width,int height)
	{
		const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
		int tid=get_global_id(0);
		if(tid>=height)
			return;
		float4 sum=(float4)(0);
		for(int X=0;X<width;X++)
		{
			sum=sum+read_imagef(inputImage,sampler,(int2)(X,tid));
			write_imagef(incrementalSumImage,(int2)(X,tid),sum);
		}
	}
__kernel void allBlack(__global float* buffer, int len)
	{
		int tid=get_global_id(0);
		if(tid>=len)
			return;
		buffer[tid] = 0.f;
	}
__kernel void clearImage(__write_only image2d_t image, const int width, const int height, const float greyScale)
	{
		const int x = get_global_id(0);
		const int y = get_global_id(1);
	if(y>=height || x>=width)
			return;
		write_imagef(image, (int2)(x,y), (float4)(greyScale, greyScale, greyScale, greyScale));
	}
__kernel void updateImageByte(__write_only image2d_t image, const int width, const int height, const int borderWidth, __global const uchar* bufferRed, __global const uchar* bufferGreen, __global const uchar* bufferBlur, __global const uchar* bufferAlpha)
	{
		const int x = get_global_id(0);
		const int y = get_global_id(1);
		if(y>=height || x>=width)
			return;
		const float red = bufferRed[x+y*width]/255.f;
		const float green = bufferGreen[x+y*width]/255.f;
		const float blue = bufferBlur[x+y*width]/255.f;
		const float alpha = bufferAlpha[x+y*width]/255.f;
		write_imagef(image, (int2)(x+borderWidth,y+borderWidth), (float4)(red, green, blue, alpha));
	}
__kernel void updateImageShort(__write_only image2d_t image, const int width, const int height, const int borderWidth, __global const ushort* bufferRed, __global const ushort* bufferGreen, __global const ushort* bufferBlur, __global const ushort* bufferAlpha)
	{
		const int x = get_global_id(0);
		const int y = get_global_id(1);
		if(y>=height || x>=width)
			return;
		const float red = bufferRed[x+y*width]/32768.f;
		const float green = bufferGreen[x+y*width]/32768.f;
		const float blue = bufferBlur[x+y*width]/32768.f;
		const float alpha = bufferAlpha[x+y*width]/32768.f;
		write_imagef(image, (int2)(x+borderWidth,y+borderWidth), (float4)(red, green, blue, alpha));
	}
__kernel void updateImageFloat(__write_only image2d_t image, const int width, const int height, const int borderWidth, __global const float* bufferRed, __global const float* bufferGreen, __global const float* bufferBlur, __global const float* bufferAlpha)
	{
		const int x = get_global_id(0);
		const int y = get_global_id(1);
		if(y>=height || x>=width)
			return;
		const float red = bufferRed[x+y*width];
		const float green = bufferGreen[x+y*width];
		const float blue = bufferBlur[x+y*width];
		const float alpha = bufferAlpha[x+y*width];
		write_imagef(image, (int2)(x+borderWidth,y+borderWidth), (float4)(red, green, blue, alpha));
	}
__kernel void allWhite(__global float* buffer, int len)
	{
		int tid=get_global_id(0);
		if(tid>=len)
			return;
		buffer[tid] = 1.f;
	}
__kernel void upScaleByte(__global uchar* buffer, const int xOffset, const int yOffset, const int stride, const int height, const int index, const float xScale, const float yScale, __read_only image2d_t inputImage, const int inputWidth, const int inputHeight, const float borderWidth)
	{
       //Must use Normalized coords because of INTEL bug
		const sampler_t sampler=CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_LINEAR;
		const int x = get_global_id(0);
		const int y = get_global_id(1);
		if(x>=stride || y>=height)
			return;
       const float2 coord= (float2)((xOffset+x+.5f)/xScale+borderWidth, (yOffset+y+.5f)/yScale+borderWidth);
		const float4 sampleColor = read_imagef(inputImage, sampler, (float2)(coord.x/inputWidth, coord.y/inputHeight));
		float color;
		if(index==0) color = sampleColor.x;
		if(index==1) color = sampleColor.y;
		if(index==2) color = sampleColor.z;
		if(index==3) color = sampleColor.w;
		buffer[y*stride+x]= min(1.f, color)*255+.5f ;
	}
__kernel void upScaleFloat(__global float* buffer, const int xOffset, const int yOffset, const int stride, const int height, const int index, const float xScale, const float yScale, __read_only image2d_t inputImage, const int inputWidth, const int inputHeight, const float borderWidth)
	{
		const sampler_t sampler=CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP|CLK_FILTER_LINEAR;
		const int x = get_global_id(0);
		const int y = get_global_id(1);
		if(x>=stride || y>=height)
			return;
       const float2 coord= (float2)((xOffset+x+.5f)/xScale+borderWidth, (yOffset+y+.5f)/yScale+borderWidth);
		const float4 sampleColor = read_imagef(inputImage, sampler, (float2)(coord.x/inputWidth, coord.y/inputHeight));
		float color;
		if(index==0) color = sampleColor.x;
		if(index==1) color = sampleColor.y;
		if(index==2) color = sampleColor.z;
		if(index==3) color = sampleColor.w;
		buffer[y*stride+x]= color;
	}
__kernel void upScaleShort(__global ushort* buffer, const int xOffset, const int yOffset, const int stride, const int height, const int index, const float xScale, const float yScale, const float scaleFactor, __read_only image2d_t inputImage, const int inputWidth, const int inputHeight, const float borderWidth)
	{
		const sampler_t sampler=CLK_NORMALIZED_COORDS_TRUE|CLK_ADDRESS_CLAMP|CLK_FILTER_LINEAR;
		const int x = get_global_id(0);
		const int y = get_global_id(1);
		if(x>=stride || y>=height)
			return;
       const float2 coord= (float2)((xOffset+x+.5f)/xScale+borderWidth, (yOffset+y+.5f)/yScale+borderWidth);
		const float4 sampleColor = read_imagef(inputImage, sampler, (float2)(coord.x/inputWidth, coord.y/inputHeight));
		float color;
		if(index==0) color = sampleColor.x;
		if(index==1) color = sampleColor.y;
		if(index==2) color = sampleColor.z;
		if(index==3) color = sampleColor.w;
		buffer[y*stride+x]= min(1.f, color)*scaleFactor+.5f ;
	}


// buildOptions=-D HAS_IMAGE_SUPPORT=1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D HAS_IMAGE_SUPPORT=1" %cfg_path --cl-device=%cl_device 2>&1
