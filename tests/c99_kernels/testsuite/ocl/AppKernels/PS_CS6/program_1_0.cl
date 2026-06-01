#if MAC_OS
	__kernel void InterleaveBuffer(__global float* image,const __global float * restrict inrIm0,
																		const __global float * restrict inrIm1,
																		const __global float * restrict inrIm2,
																		const __global float * restrict inrIm3,
																		int width, int height,
																		int row_increment_in,
																		int channels)
	{
		int tidX=get_global_id(0);
		if(tidX>=row_increment_in)
			return;
		for(int y=0;y<height;y++)
			{
					switch(channels)
					{
						default:
						case 4:
							image[tidX*4+3+y*row_increment_in*4]=inrIm3[row_increment_in*y + tidX];
						case 3:
							image[tidX*4+2+y*row_increment_in*4]=inrIm2[row_increment_in*y + tidX];
						case 2:
							image[tidX*4+1+y*row_increment_in*4]=inrIm1[row_increment_in*y + tidX];
						case 1:
							image[tidX*4+0+y*row_increment_in*4]=inrIm0[row_increment_in*y + tidX];
					}
					//write_imagef(image,(int2)(tidX,y),pixel);
			}
	}
	__kernel void InterleaveBuffer2(__global float* image,__global float* image2,const __global float * restrict inrIm0,
																		const __global float * restrict inrIm1,
																		const __global float * restrict inrIm2,
																		const __global float * restrict inrIm3,
																		const __global float * restrict inrIm4,
																		const __global float * restrict inrIm5,
																		int width, int height,
																		int row_increment_in,
																		int channels)
	{
		int tidX=get_global_id(0);
		if(tidX>=row_increment_in)
			return;
		for(int y=0;y<height;y++)
			{
				float4 pixel=(float4)0;
				float2 pixel2=(float2)0;
					switch(channels)
					{
						default:
						case 6:
							image2[tidX*2+1+y*row_increment_in*2]=inrIm5[row_increment_in*y + tidX];
						case 5:
							image2[tidX*2+0+y*row_increment_in*2]=inrIm4[row_increment_in*y + tidX];
						case 4:
							image[tidX*4+3+y*row_increment_in*4]=inrIm3[row_increment_in*y + tidX];
						case 3:
							image[tidX*4+2+y*row_increment_in*4]=inrIm2[row_increment_in*y + tidX];
						case 2:
							image[tidX*4+1+y*row_increment_in*4]=inrIm1[row_increment_in*y + tidX];
						case 1:
							image[tidX*4+0+y*row_increment_in*4]=inrIm0[row_increment_in*y + tidX];
					}
					//write_imagef(image,(int2)(tidX,y),pixel);
			}
	}
#else
	__kernel void InterleaveBuffer(__global float4* image,const __global float * restrict inrIm0,
																		const __global float * restrict inrIm1,
																		const __global float * restrict inrIm2,
																		const __global float * restrict inrIm3,
																		int width, int height,
																		int row_increment_in,
																		int channels)
	{
		int tidX=get_global_id(0);
		if(tidX>=row_increment_in)
			return;
		for(int y=0;y<height;y++)
			{
				float4 pixel=(float4)0;
					switch(channels)
					{
						default:
						case 4:
							pixel.w=inrIm3[row_increment_in*y + tidX];
						case 3:
							pixel.z=inrIm2[row_increment_in*y + tidX];
						case 2:
							pixel.y=inrIm1[row_increment_in*y + tidX];
						case 1:
							pixel.x=inrIm0[row_increment_in*y + tidX];
							image[tidX+y*row_increment_in]=pixel;
					}
					//write_imagef(image,(int2)(tidX,y),pixel);
			}
	}
	__kernel void InterleaveBuffer2(__global float4* image,__global float2* image2,const __global float * restrict inrIm0,
																		const __global float * restrict inrIm1,
																		const __global float * restrict inrIm2,
																		const __global float * restrict inrIm3,
																		const __global float * restrict inrIm4,
																		const __global float * restrict inrIm5,
																		int width, int height,
																		int row_increment_in,
																		int channels)
	{
		int tidX=get_global_id(0);
		if(tidX>=row_increment_in)
			return;
		for(int y=0;y<height;y++)
			{
				float4 pixel=(float4)0;
				float2 pixel2=(float2)0;
					switch(channels)
					{
						default:
						case 6:
							pixel2.y=inrIm3[row_increment_in*y + tidX];
						case 5:
							pixel2.x=inrIm3[row_increment_in*y + tidX];
							image2[tidX+y*row_increment_in]=pixel2;
						case 4:
							pixel.w=inrIm3[row_increment_in*y + tidX];
						case 3:
							pixel.z=inrIm2[row_increment_in*y + tidX];
						case 2:
							pixel.y=inrIm1[row_increment_in*y + tidX];
						case 1:
							pixel.x=inrIm0[row_increment_in*y + tidX];
						image[tidX+y*row_increment_in]=pixel;
					}
					//write_imagef(image,(int2)(tidX,y),pixel);
			}
	}
#endif
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
//The reason for DO_PARTIAL_ELLIPTICAL not being a function is that I needed to return a sum,area i.e float4,float which is not possible as
//there is nothing like float5 or higher and pass by reference is no possible in opencl
#define DO_PARTIAL_ELLIPTICAL				 													\
	{																							\
    const float dy_sine = iChord * sine;														\
    const float dy_cosine = iChord * cosine;													\
    /* squared distance to center point*/														\
    int D2 = YCenter2 + dx_left * dx_left;														\
    for(int dx = dx_left; dx < dx_right; ++dx)													\
        {																						\
        /*distance from the point to the center of the ellipse*/								\
        const float D = native_sqrt((float)D2);														\
        const float dx_rotated = dx * cosine - dy_sine;											\
        const float dy_rotated = dy_cosine + dx * sine;											\
																								\
        const float dx_rotated_squared = dx_rotated * dx_rotated;								\
        const float dy_rotated_squared = dy_rotated * dy_rotated;								\
																								\
        /* F = 1 on the ellipse and is less than 1 on the inside*/								\
        const float F = native_sqrt (dx_rotated_squared * invR.x + dy_rotated_squared * invR.y);		\
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
		switch(channels)																		\
					{																			\
				case 6:																			\
				case 5:																			\
		sum2= sum2 + (incrementalSumImage2[row_increment_in*(tidY+iChord) + right]				\
							-incrementalSumImage2[row_increment_in*(tidY+iChord) + left])*partialArea;		\
				default:																					\
		sum4= sum4 + (incrementalSumImage[row_increment_in*(tidY+iChord) + right]           \
							-incrementalSumImage[row_increment_in*(tidY+iChord) + left])*partialArea;		\
	}																										\
																								\
        area += partialArea;																	\
        D2 += ((dx<<1) + 1);																	\
        }																						\
    }																							\

__kernel void GenerateEllipseSmoothBlur_BufferFF(__global float * lensBlurImage0,__global float * lensBlurImage1,
																		__global float * lensBlurImage2,
																		__global float * lensBlurImage3,
                                                                        __global float * lensBlurImage4,
                                                                        __global float * lensBlurImage5,
																		const __global float4 * restrict  incrementalSumImage,
                                                                        const __global float2 * restrict incrementalSumImage2,
																		const __global float * restrict  radiusImage,
																		const __global float * restrict  ellipse_angle,
																		const __global float * restrict  ellipse_distortion,
																		float radiusMax, int width, int height,
																		int row_increment_in, int row_increment_out,
																		int radius_increment, int ellipse_angle_increment,
																		int ellipse_distortion_increment,
																		int data_orgin_x,
																		int channels,
																		int smooth)
{
    int Offset=(int)(radiusMax+.5f) +3 ;
	int tidX=get_global_id(0)+ Offset;
	int tidY=get_global_id(1)+ Offset;
	if(tidX>=(width+ Offset) || tidY>=(height+ Offset))
		return;
	if (radiusMax <= 0.5f)
		return;
	float radius= radiusMax * radiusImage[(tidX-Offset)+(tidY-Offset)*radius_increment] ;
	const float ellipseDistortion=ellipse_distortion[(tidX-Offset)+(tidY-Offset)*ellipse_distortion_increment];
	const float ellipseAngle=ellipse_angle[(tidX-Offset)+(tidY-Offset)*ellipse_angle_increment];
	float2 R12=ellipseRadii(radius,ellipseDistortion,radiusMax);
	if(R12.x<0.5f || R12.y<0.5f)
		{
			//R12 = max(R12,(float2)0.5f);
			  float4 sum4;
			  float2 sum2;
			  sum4=(incrementalSumImage[row_increment_in*tidY + tidX]-incrementalSumImage[row_increment_in*tidY + tidX-1]);
			switch(channels)
			{
				case 6:
				case 5:
					sum2=(incrementalSumImage2[row_increment_in*tidY + tidX]-incrementalSumImage2[row_increment_in*tidY + tidX-1]);
				  lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.y;
				  lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.x;
				case 4:
				case 3:
				  lensBlurImage3[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.w;
				  lensBlurImage2[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.z;
				case 2:
				case 1:
				  lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.y;
				  lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.x;
			}
			return;
		}
	float2 invR= ((float2) 1.0f)/(R12*R12);
	float sine= sin(ellipseAngle);
	float cosine= cos(ellipseAngle);
	float area=0;
    float4 sum4=0;
    float2 sum2=0;
	float4 k1k2beta2=ellipseVariables(R12.x,R12.y,sine,cosine,invR.x,invR.y);
	const float gridHeight = -(((int)rint(native_sqrt(k1k2beta2.z)))+0.5f);
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
        const float k2_sqrt = k1k2beta2.y * native_sqrt (max(D2,0.f));
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
		leftFull = ceil(lFull+.5f);
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
        else if(rightFull < leftFull)
        {
            rightFull = leftFull = rightIndex+1;
        }
		int dx_left=leftIndex;
		int dx_right=leftFull;
		if(smooth)
			DO_PARTIAL_ELLIPTICAL
		if(rightFull<= rightIndex)
        {
            //Using incremental image does not work for x=0 column
            if(false)
            {
				int shift=min(max(tidX+leftFull,0),row_increment_in-1);
                        float4 sumdt;
						float2 sumdt2;
                switch(channels)
					{
				case 6:
				case 5:
						sumdt2=shift==Offset?incrementalSumImage2[row_increment_in*(tidY+iChord) + shift]:(incrementalSumImage2[row_increment_in*(tidY+iChord) + shift]-incrementalSumImage2[row_increment_in*(tidY+iChord) + shift-1]);
									sum2 = sum2 + sumdt2;
				default:
						sumdt=shift==Offset?incrementalSumImage[row_increment_in*(tidY+iChord) + shift]:(incrementalSumImage[row_increment_in*(tidY+iChord) + shift]-incrementalSumImage[row_increment_in*(tidY+iChord) + shift-1]);
                                    sum4 = sum4 +sumdt;
					}
				area = area + 1.0;
            }
            else
            {
				int right= min(max(tidX+rightFull,0),row_increment_in-1);
				int left= min(max(tidX+leftFull-1,0),row_increment_in-1);
                        float4 sumdt;
                        float2 sumdt2;
                switch(channels)
					{
				case 6:
				case 5:
						sumdt2=(incrementalSumImage2[row_increment_in*(tidY+iChord) + right]-incrementalSumImage2[row_increment_in*(tidY+iChord) + left]);
                                    sum2 = sum2 + sumdt2;
				default:
						sumdt=(incrementalSumImage[row_increment_in*(tidY+iChord) + right]-incrementalSumImage[row_increment_in*(tidY+iChord) + left]);
                                    sum4 = sum4 +sumdt;
					}
				area = area + (right - left);
            }
        }
		dx_left=rightFull+1;
		dx_right=rightIndex+1;
		if(smooth)
			DO_PARTIAL_ELLIPTICAL
		 topLeftChordWidth = bottomLeftChordWidth;
		 topRightChordWidth = bottomRightChordWidth;
		 YCenter2 += ((iChord<<1)+1);
         iChord++;
	}
	if(area>1)
		area=1.0/area; // this is a mac ati bugfix for  p/q is inaccurate as compared to p*(1/q)
	else
        {
			area=1.0f;
			 switch(channels)
					{
				case 6:
				case 5:
			        sum2=(incrementalSumImage2[row_increment_in*tidY + tidX]-incrementalSumImage2[row_increment_in*tidY + tidX-1]);
				default:
			        sum4=(incrementalSumImage[row_increment_in*tidY + tidX]-incrementalSumImage[row_increment_in*tidY + tidX-1]);
				 }
        }
	/*if(channels>4)
		{
		lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.y*area;
		lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.x*area;
		}*/
	switch(channels)
			{
		case 6:
		case 5:
			lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.y*area;
			lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.x*area;
		case 4:
		case 3:
			lensBlurImage3[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.w*area;
			lensBlurImage2[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.z*area;
		case 2:
		case 1:
			lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.y*area;
			lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.x*area;
		}
}
//The reason for DO_PARTIAL_ELLIPTICAL not being a function is that I needed to return a sum,area i.e float4,float which is not possible as
//there is nothing like float5 or higher and pass by reference is no possible in opencl
#define DO_PARTIAL_ELLIPTICAL_1CH			 													\
	{																							\
    const float dy_sine = iChord * sine;														\
    const float dy_cosine = iChord * cosine;													\
    /* squared distance to center point*/														\
    int D2 = YCenter2 + dx_left * dx_left;														\
    for(int dx = dx_left; dx < dx_right; ++dx)													\
        {																						\
        /*distance from the point to the center of the ellipse*/								\
        const float D = native_sqrt((float)D2);														\
        const float dx_rotated = dx * cosine - dy_sine;											\
        const float dy_rotated = dy_cosine + dx * sine;											\
																								\
        const float dx_rotated_squared = dx_rotated * dx_rotated;								\
        const float dy_rotated_squared = dy_rotated * dy_rotated;								\
																								\
		/* F = 1 on the ellipse and is less than 1 on the inside*/								\
        const float F = native_sqrt (dx_rotated_squared * invR.x + dy_rotated_squared * invR.y);		\
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
		sum4= sum4 + (incrementalSumImage[row_increment_in*(tidY+iChord) + right]           \
							-incrementalSumImage[row_increment_in*(tidY+iChord) + left])*partialArea;		\
		area += partialArea;																	\
        D2 += ((dx<<1) + 1);																	\
        }																						\
    }																							\

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
__kernel void GenerateEllipseSmoothBlur_BufferFF_1ch(__global float * lensBlurImage0,
																		const __global float * restrict  incrementalSumImage,
                                                                        const __global float * restrict  radiusImage,
																		const __global float * restrict  ellipse_angle,
																		const __global float * restrict  ellipse_distortion,
																		float radiusMax, int width, int height,
																		int row_increment_in, int row_increment_out,
																		int radius_increment, int ellipse_angle_increment,
																		int ellipse_distortion_increment,
																		int data_orgin_x,
																		int smooth)
{
    int Offset=(int)(radiusMax+.5f) +3 ;
	int tidX=get_global_id(0)+ Offset;
	int tidY=get_global_id(1)+ Offset;
	if(tidX>=(width+ Offset) || tidY>=(height+ Offset))
		return;
	if (radiusMax <= 0.5f)
		return;
	float radius= radiusMax * radiusImage[(tidX-Offset)+(tidY-Offset)*radius_increment] ;
	const float ellipseDistortion=ellipse_distortion[(tidX-Offset)+(tidY-Offset)*ellipse_distortion_increment];
	const float ellipseAngle=ellipse_angle[(tidX-Offset)+(tidY-Offset)*ellipse_angle_increment];
	float2 R12=ellipseRadii(radius,ellipseDistortion,radiusMax);
	if(R12.x<0.5f || R12.y<0.5f)
		{
			//R12 = max(R12,(float2)0.5f);
			  float sum4;
			  sum4=(incrementalSumImage[row_increment_in*tidY + tidX]-incrementalSumImage[row_increment_in*tidY + tidX-1]);
			  lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4;
			return;
		}
	float2 invR= (float2)((1.0f/(R12.x*R12.x)),(1.0f/(R12.y*R12.y)));
	float sine= sin(ellipseAngle);
	float cosine= cos(ellipseAngle);
	float area=0;
    float sum4=0;
	float4 k1k2beta2=ellipseVariables(R12.x,R12.y,sine,cosine,invR.x,invR.y);
	const float gridHeight = -(((int)rint(native_sqrt(k1k2beta2.z)))+0.5f);
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
        const float k2_sqrt = k1k2beta2.y * native_sqrt (max(D2,0.f));
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
		leftFull = ceil(lFull+.5f);
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
		else if(rightFull < leftFull)
        {
            rightFull = leftFull = rightIndex+1;
        }
		int dx_left=leftIndex;
		int dx_right=leftFull;
		if(smooth)
			DO_PARTIAL_ELLIPTICAL_1CH
		if(rightFull<= rightIndex)
        {
            //Using incremental image does not work for x=0 column
            if(false)
            {
				int shift=min(max(tidX+leftFull,0),row_increment_in-1);
                        float sumdt;
						sumdt=shift==Offset?incrementalSumImage[row_increment_in*(tidY+iChord) + shift]:(incrementalSumImage[row_increment_in*(tidY+iChord) + shift]-incrementalSumImage[row_increment_in*(tidY+iChord) + shift-1]);
                                    sum4 = sum4 +sumdt;
				area = area + 1.0;
            }
            else
            {
				int right= min(max(tidX+rightFull,0),row_increment_in-1);
				int left= min(max(tidX+leftFull-1,0),row_increment_in-1);
				float sumdt;
				sumdt=(incrementalSumImage[row_increment_in*(tidY+iChord) + right]-incrementalSumImage[row_increment_in*(tidY+iChord) + left]);
				sum4 = sum4 +sumdt;
				area = area + (right - left);
            }
        }
		dx_left=rightFull+1;
		dx_right=rightIndex+1;
		if(smooth)
			DO_PARTIAL_ELLIPTICAL_1CH
		 topLeftChordWidth = bottomLeftChordWidth;
		 topRightChordWidth = bottomRightChordWidth;
		 YCenter2 += ((iChord<<1)+1);
         iChord++;
	}
	if(area>1)
		area=1.0/area; // this is a mac ati bugfix for  p/q is inaccurate as compared to p*(1/q)
	else
        {
			area=1.0f;
			sum4=(incrementalSumImage[row_increment_in*tidY + tidX]-incrementalSumImage[row_increment_in*tidY + tidX-1]);
        }
			//area=1.0f;
			lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4*area;
}
#if HAS_IMAGE_SUPPORT
__kernel void MakeImageFromBuffer(__write_only image2d_t image,const __global float * restrict inrIm0,
																		const __global float * restrict inrIm1,
																		const __global float * restrict inrIm2,
																		const __global float * restrict inrIm3,
																		int width, int height,
																		int row_increment_in,
																		int channels)
	{
		int tidX=get_global_id(0);
		if(tidX>=row_increment_in)
			return;
		for(int y=0;y<height;y++)
			{
				float4 pixel=(float4)0;
				switch(channels)
					{
						default:
						case 4:
							pixel.w=inrIm3[row_increment_in*y + tidX];
						case 3:
							pixel.z=inrIm2[row_increment_in*y + tidX];
						case 2:
							pixel.y=inrIm1[row_increment_in*y + tidX];
						case 1:
							pixel.x=inrIm0[row_increment_in*y + tidX];
					}
				write_imagef(image,(int2)(tidX,y),pixel);
			}
	}
__kernel void MakeImageFromBuffer2(__write_only image2d_t image,__global float2 * image2,
																		const __global float * restrict inrIm0,
																		const __global float * restrict inrIm1,
																		const __global float * restrict inrIm2,
																		const __global float * restrict inrIm3,
																		const __global float * restrict inrIm4,
																		const __global float * restrict inrIm5,
																		int width, int height,
																		int row_increment_in,
																		int channels)
	{
		int tidX=get_global_id(0);
		if(tidX>=row_increment_in)
			return;
		for(int y=0;y<height;y++)
			{
				float4 pixel=(float4)0;
				float2 pixel2=0;
				switch(channels)
					{
						default:
						case 6:
							pixel2.y=inrIm5[row_increment_in*y + tidX];
						case 5:
							pixel2.x=inrIm4[row_increment_in*y + tidX];
							image2[tidX+y*row_increment_in]=pixel2;
						case 4:
							pixel.w=inrIm3[row_increment_in*y + tidX];
						case 3:
							pixel.z=inrIm2[row_increment_in*y + tidX];
						case 2:
							pixel.y=inrIm1[row_increment_in*y + tidX];
						case 1:
							pixel.x=inrIm0[row_increment_in*y + tidX];
							write_imagef(image,(int2)(tidX,y),pixel);
					}
			}
	}
__kernel void MakeImageFromBuffer3(__write_only image2d_t image,__write_only image2d_t image2,
																		const __global float * restrict inrIm0,
																		const __global float * restrict inrIm1,
																		const __global float * restrict inrIm2,
																		const __global float * restrict inrIm3,
																		const __global float * restrict inrIm4,
																		const __global float * restrict inrIm5,
																		int width, int height,
																		int row_increment_in,
																		int channels)
	{
		int tidX=get_global_id(0);
		if(tidX>=row_increment_in)
			return;
		for(int y=0;y<height;y++)
			{
				float4 pixel=(float4)0;
				float4 pixel2=0;
				switch(channels)
					{
						default:
						case 6:
							pixel2.y=inrIm5[row_increment_in*y + tidX];
						case 5:
							pixel2.x=inrIm4[row_increment_in*y + tidX];
							write_imagef(image2,(int2)(tidX,y),pixel2);
						case 4:
							pixel.w=inrIm3[row_increment_in*y + tidX];
						case 3:
							pixel.z=inrIm2[row_increment_in*y + tidX];
						case 2:
							pixel.y=inrIm1[row_increment_in*y + tidX];
						case 1:
							pixel.x=inrIm0[row_increment_in*y + tidX];
							write_imagef(image,(int2)(tidX,y),pixel);
					}
			}
	}
#define DO_PARTIAL_ELLIPTICAL_IMAGE			 													\
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
        float partialArea=max(approxCoverage,0.f);												\
																								\
        /*const float R1 = 1.0/fast_sqrt (inverse_R1_squared); // for debugging*/				\
        /*const float partial_area = std::fabs (R1 + 0.5 - D);*/								\
        /*ASSERT (0 <= partial_area, "Warning (gdw). negative blur weight");*/					\
		int right= min(max(tidX+dx,0),row_increment_in-1);										\
		int left= min(max(tidX+dx-1,0),row_increment_in-1);										\
		switch(channels)																		\
					{																			\
				case 6:																			\
				case 5:																			\
		sum2= sum2 + (incrementalSumImage2[row_increment_in*(tidY+iChord) + right]				\
							-incrementalSumImage2[row_increment_in*(tidY+iChord) + left])*partialArea;		\
				default:																		\
		sum4= sum4 + (read_imagef(incrementalSumImage,sampler,(int2)(right,(tidY+iChord)))  \
						-read_imagef(incrementalSumImage,sampler,(int2)(left,(tidY+iChord))))*partialArea;	\
		}																						\
																								\
        area += partialArea;																	\
        D2 += ((dx<<1) + 1);																	\
        }																						\
    }																							\

__kernel void GenerateEllipseSmoothBlur_ImageFF(__global float * lensBlurImage0,__global float * lensBlurImage1,
																		__global float * lensBlurImage2,
																		__global float * lensBlurImage3,
                                                                        __global float * lensBlurImage4,
                                                                        __global float * lensBlurImage5,
																		__read_only image2d_t incrementalSumImage,
                                                                        const __global float2 * restrict incrementalSumImage2,
																		const __global float * restrict  radiusImage,
																		const __global float * restrict  ellipse_angle,
																		const __global float * restrict  ellipse_distortion,
																		float radiusMax, int width, int height,
																		int row_increment_in, int row_increment_out,
																		int radius_increment, int ellipse_angle_increment,
																		int ellipse_distortion_increment,
																		int data_orgin_x,
																		int channels,
																		int smooth)
{
	const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int Offset=(int)(radiusMax+.5f) +3 ;
	int tidX=get_global_id(0)+ Offset;
	int tidY=get_global_id(1)+ Offset;
	if(tidX>=(width+ Offset) || tidY>=(height+ Offset))
		return;
	if (radiusMax <= 0.5f)
		return;
	float radiusNorm=radiusImage[(tidX-Offset)+(tidY-Offset)*radius_increment];
	float radius= radiusNorm * radiusMax;
	const float ellipseDistortion=ellipse_distortion[(tidX-Offset)+(tidY-Offset)*ellipse_distortion_increment];
	const float ellipseAngle=ellipse_angle[(tidX-Offset)+(tidY-Offset)*ellipse_angle_increment];
	float2 R12=ellipseRadii(radius,ellipseDistortion,radiusMax);
	if(R12.x<0.5f || R12.y<0.5f)
		{
			//R12 = max(R12,(float2)0.5f);
            float4 sum4;
            float2 sum2;
			sum4=(read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage,sampler,(int2)(tidX-1,tidY)));
			switch(channels)
			{
				case 6:
				case 5:
					sum2=(incrementalSumImage2[row_increment_in*tidY + tidX]-incrementalSumImage2[row_increment_in*tidY + tidX-1]);
				lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.y;
                lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.x;
				case 4:
				case 3:
                lensBlurImage3[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.w;
                lensBlurImage2[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.z;
				case 2:
				case 1:
                lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.y;
                lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.x;
			}
			return;
		}
	float2 invR= ((float2) 1.0f)/(R12*R12);
	float sine= sin(ellipseAngle);
	float cosine= cos(ellipseAngle);
	float area=0;
    float4 sum4=0;
    float2 sum2=0;
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
		leftFull = ceil((lFull+.5f));
		rightFull = floor((rFull-.5f));
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
        else if(rightFull < leftFull)
        {
            rightFull = leftFull = rightIndex+1;
        }
		int dx_left=leftIndex;
		int dx_right=leftFull;
		if(smooth)
			DO_PARTIAL_ELLIPTICAL_IMAGE
		if(rightFull<= rightIndex)
        {
            //Using incremental image does not work for x=0 column
            if(false)
            {
				int shift=min(max(tidX+leftFull,0),row_increment_in-1);
                float4 sumdt;
                float2 sumdt1;
			 switch(channels)
					{
				case 6:
				case 5:
				        sumdt1=(incrementalSumImage2[row_increment_in*(tidY+iChord) + shift]-incrementalSumImage2[row_increment_in*(tidY+iChord) + shift-1]);
                        sum2 = sum2 + sumdt1;
				default:
				        sumdt=(read_imagef(incrementalSumImage,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage,sampler,(int2)(shift-1,(tidY+iChord))));
                        sum4 = sum4 +sumdt;
					}
				area = area + 1.0;
            }
            else
            {
				int right= min(max(tidX+rightFull,0),row_increment_in-1);
				int left= min(max(tidX+leftFull-1,0),row_increment_in-1);
                float4 sumdt;
                float2 sumdt1;
			switch(channels)
			{
				case 6:
				case 5:
                sumdt1=(incrementalSumImage2[row_increment_in*(tidY+iChord) + right]-incrementalSumImage2[row_increment_in*(tidY+iChord) + left]);
                sum2 = sum2 + sumdt1;
				default:
                sumdt=(read_imagef(incrementalSumImage,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage,sampler,(int2)(left,(tidY+iChord))));
                sum4 = sum4 +sumdt;
			}
				area = area + (right - left);
            }
        }
		dx_left=rightFull+1;
		dx_right=rightIndex+1;
		if(smooth)
			DO_PARTIAL_ELLIPTICAL_IMAGE
		 topLeftChordWidth = bottomLeftChordWidth;
		 topRightChordWidth = bottomRightChordWidth;
		 YCenter2 += ((iChord<<1)+1);
         iChord++;
	}
	if(area>1)
		area=1.0/area; // this is a mac ati bugfix for  p/q is inaccurate as compared to p*(1/q)
	else
        {
			area=1.0f;
			switch(channels)
			{
				case 6:
				case 5:
			        sum2=(incrementalSumImage2[row_increment_in*tidY + tidX]-incrementalSumImage2[row_increment_in*tidY + tidX-1]);
				default:
			        sum4=(read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage,sampler,(int2)(tidX-1,tidY)));
				}
		}
switch(channels)
			{
				case 6:
				case 5:
	lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.y*area;
    lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2.x*area;
				case 4:
				case 3:
    lensBlurImage3[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.w*area;
    lensBlurImage2[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.z*area;
				case 2:
				case 1:
    lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.y*area;
    lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.x*area;
	}
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
				diff=			(read_imagef(incrementalSumImage2,sampler,(int2)(right,(tidY+iChord)))	\
						-read_imagef(incrementalSumImage2,sampler,(int2)(left,(tidY+iChord))))*partialArea;	\
					sum2= sum2 +	diff.y;																	\
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
																		__read_only image2d_t incrementalSumImage,
                                                                        __read_only image2d_t incrementalSumImage1,
                                                                        __read_only image2d_t incrementalSumImage2,
																		const __global float * restrict  radiusImage,
																		const __global float * restrict  ellipse_angle,
																		const __global float * restrict  ellipse_distortion,
																		float radiusMax, int width, int height,
																		int row_increment_in, int row_increment_out,
																		int radius_increment, int ellipse_angle_increment,
																		int ellipse_distortion_increment,
																		int channels,
																		int smooth)
{
	const sampler_t sampler=CLK_NORMALIZED_COORDS_FALSE|CLK_ADDRESS_CLAMP_TO_EDGE|CLK_FILTER_NEAREST;
    int Offset=(int)(radiusMax+.5f) +3 ;
	int tidX=get_global_id(0)+ Offset;
	int tidY=get_global_id(1)+ Offset;
	if(tidX>=(width+ Offset) || tidY>=(height+ Offset))
		return;
	if (radiusMax <= 0.5)
		return;
	float radiusNorm=radiusImage[(tidX-Offset)+(tidY-Offset)*radius_increment];
	float radius= radiusNorm * radiusMax;
	const float ellipseDistortion=ellipse_distortion[(tidX-Offset)+(tidY-Offset)*ellipse_distortion_increment];
	const float ellipseAngle=ellipse_angle[(tidX-Offset)+(tidY-Offset)*ellipse_angle_increment];
	float2 R12=ellipseRadii(radius,ellipseDistortion,radiusMax);
	if(R12.x<0.5 || R12.y<0.5)
		{
			//R12 = max(R12,(float2)0.5f);
                  float4 sum4;
                  float sum2,sum1;
                  switch(channels)
                  {
                        case 6:
                              sum4=(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
							  sum2=sum4.y;
                        case 5:
                              sum4=(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
							  sum1=sum4.x;
                        case 4:
                        case 3:
                              sum4=(read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage,sampler,(int2)(tidX-1,tidY)));
                              break;
                        case 2:
                              sum4=(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
							  sum2=sum4.y;
                        case 1:
                              sum4=(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
							  sum1=sum4.x;
                        default:
                              break;
                  }
					/*sum4=tidX==Offset?read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY)):(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
							  sum2=sum4.y;
					sum4=tidX==Offset?read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY)):(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
							  sum1=sum4.x;
                    sum4=tidX==Offset?read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY)):(read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage,sampler,(int2)(tidX-1,tidY)));
*/
			switch(channels)
				{
                        case 6:
                              lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2;
                        case 5:
                              lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum1;
                        case 4:
						case 3:
                              lensBlurImage3[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.w;
                              lensBlurImage2[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.z;
                              lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.y;
                              lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.x;
                              break;
                        case 2:
                              lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2;
                        case 1:
                              lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum1;
                        default:
                              break;
				}
				/*lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2;
                lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum1;
                lensBlurImage3[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.w;
                lensBlurImage2[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.z;
                lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.y;
                lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.x;
			*/
			return;
		}
	float2 invR= ((float2) 1.0f)/(R12*R12);
	float sine= sin(ellipseAngle);
	float cosine= cos(ellipseAngle);
	float area=0;
      float4 sum4=0;
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
                              case 6:
                                    sumdt=shift==Offset?read_imagef(incrementalSumImage2,sampler,(int2)(shift,(tidY+iChord))):(read_imagef(incrementalSumImage2,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.y;
                              case 5:
                                    sumdt=shift==Offset?read_imagef(incrementalSumImage1,sampler,(int2)(shift,(tidY+iChord))):(read_imagef(incrementalSumImage1,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage1,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum1 = sum1 + sumdt.x;
                              case 4:
                              case 3:
                                    sumdt=shift==Offset?read_imagef(incrementalSumImage,sampler,(int2)(shift,(tidY+iChord))):(read_imagef(incrementalSumImage,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum4 = sum4 +sumdt;
                                    break;
                              case 2:
                                    sumdt=shift==Offset?read_imagef(incrementalSumImage2,sampler,(int2)(shift,(tidY+iChord))):(read_imagef(incrementalSumImage2,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.y;
                              case 1:
                                    sumdt=shift==Offset?read_imagef(incrementalSumImage1,sampler,(int2)(shift,(tidY+iChord))):(read_imagef(incrementalSumImage1,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage1,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum1 = sum1 + sumdt.x;
                              default:
                                    break;
                              }
						/*sumdt=shift==Offset?read_imagef(incrementalSumImage2,sampler,(int2)(shift,(tidY+iChord))):(read_imagef(incrementalSumImage2,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.y;
                        sumdt=shift==Offset?read_imagef(incrementalSumImage1,sampler,(int2)(shift,(tidY+iChord))):(read_imagef(incrementalSumImage1,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage1,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum1 = sum1 + sumdt.x;
                        sumdt=shift==Offset?read_imagef(incrementalSumImage,sampler,(int2)(shift,(tidY+iChord))):(read_imagef(incrementalSumImage,sampler,(int2)(shift,(tidY+iChord)))-read_imagef(incrementalSumImage,sampler,(int2)(shift-1,(tidY+iChord))));
                                    sum4 = sum4 +sumdt;*/
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
                              case 6:
                                    sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(right,(tidY+iChord)))-read_imagef(incrementalSumImage2,sampler,(int2)(left,(tidY+iChord))));
                                    sum2 = sum2 + sumdt.y;
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
                                    sum2 = sum2 + sumdt.y;
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
                              case 6:
                                    sumdt=(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
									sum2=sumdt.y;
                              case 5:
                                    sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
									sum1=sumdt.x;
                              case 4:
                              case 3:
                                    sum4=(read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage,sampler,(int2)(tidX-1,tidY)));
                                    break;
                              case 2:
                                    sumdt=tidX==Offset?read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY)):(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
									sum2=sumdt.y;
                              case 1:
                                    sumdt=(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
									sum1=sumdt.x;
                              default:
                                    break;
                        }
					/*sumdt=tidX==Offset?read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY)):(read_imagef(incrementalSumImage2,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage2,sampler,(int2)(tidX-1,tidY)));
								sum2=sumdt.y;
					sumdt=tidX==Offset?read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY)):(read_imagef(incrementalSumImage1,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage1,sampler,(int2)(tidX-1,tidY)));
								sum1=sumdt.x;
                    sum4=tidX==Offset?read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY)):(read_imagef(incrementalSumImage,sampler,(int2)(tidX,tidY))-read_imagef(incrementalSumImage,sampler,(int2)(tidX-1,tidY)));*/
            }
	switch(channels)
	{
            case 6:
                  lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2*divBy;
            case 5:
                  lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum1*divBy;
            case 4:
			case 3:
                  lensBlurImage3[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.w*divBy;
                  lensBlurImage2[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.z*divBy;
                  lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.y*divBy;
                  lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.x*divBy;
                  break;
            case 2:
                  lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2*divBy;
            case 1:
                  lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum1*divBy;
	}
	/*lensBlurImage5[tidX-Offset+(tidY-Offset)*row_increment_out]=sum2*divBy;
		lensBlurImage4[tidX-Offset+(tidY-Offset)*row_increment_out]=sum1*divBy;
		lensBlurImage3[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.w*divBy;
		lensBlurImage2[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.z*divBy;
        lensBlurImage1[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.y*divBy;
        lensBlurImage0[tidX-Offset+(tidY-Offset)*row_increment_out]=sum4.x*divBy;*/
}
#endif


// buildOptions=-D HAS_IMAGE_SUPPORT=1
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D HAS_IMAGE_SUPPORT=1" %cfg_path --cl-device=%cl_device 2>&1
