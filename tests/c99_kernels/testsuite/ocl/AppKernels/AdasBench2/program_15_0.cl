/*
* Thresholding an image with lowerThreshold and upperThreshold
*/

inline float RGBAToGray(const float4 c)
{
	return (c.x + c.y + c.z) * (1.0f/3.0f);
}

__kernel void ThresholdImage(
	__read_only image2d_t imageIn,
	__write_only image2d_t imageOut,
	const float lowerThreshold,
	const float upperThreshold)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	float color = RGBAToGray(read_imagef(imageIn, sampler, coord));
	float tmpColor = 0.0f;

	//if (get_global_id(0) == 100)
	//	printf("%f %f %f %f\n", color.x, color.y, color.z, color.w);
	if(color < lowerThreshold)
	{
		color = 0.0f;
	}
	else if(color > upperThreshold )
	{
		color = 1.0f;
	}
	else
	{
		color = 0.0f;
		bool l = false;
		for(int i = -1; i < 2 && !l; ++i)
		{
			for(int j = -1; j < 2 && !l; ++j)
			{
				int2 tmp = coord + (int2)(i,j);

				tmpColor = read_imagef(imageIn, sampler, tmp).x;

				if(tmpColor > upperThreshold)
				{
					color = 1.0f;
					l = true;
				}
			}
		}
	}

	write_imagef(imageOut, coord, (float4)(color, color, color, 1.0f));
}

kernel void ThresholdHSVImage(read_only image2d_t  imageIn,
							   write_only image2d_t  imageOut,
							   float lowerThresholdH, float upperThresholdH,
							   float lowerThresholdS, float upperThresholdS,
							   float lowerThresholdV, float upperThresholdV)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	float4 image_pixel = read_imagef(imageIn, sampler, coord);

	float h,s,v;
	h = image_pixel.x;
	s = image_pixel.y;
	v = image_pixel.z;

	float4 color = ( s>=lowerThresholdS && s<=upperThresholdS && v>=lowerThresholdV && v<=upperThresholdV
					&& h>=lowerThresholdH && h<=upperThresholdH)? (float4)(1.0f, 1.0f, 1.0f, 1.0f) : (float4)(0.0f, 0.0f, 0.0f, 1.0f);

	write_imagef(imageOut, coord, color);
}

inline int getIdx(int2 coord_, int width_)
{
	return coord_.y * width_ + coord_.x;
}

kernel void ThresholdImageBuff(
	global const float * image,
	global float * imageOut,
	const float lowerTreshold,
	const float upperTreshold
	)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	int width = get_global_size(0);
	//int height = 0.3 *  get_global_size(1) ;


	float color = image[getIdx(coord,width)];
	//float color = read_imagef(image, samplerA, coord).x;;
	float tmpColor;


	if(color < lowerTreshold/* || coord.y < height*/)
	{
		color = 0.0f;
	}
	else if(color > upperTreshold )
	{
		color = 1.0f;
	}
	else
	{
		color = 0.0f;
		bool l = false;
		for(int i = -1; i < 2 && !l; ++i)
		{
			for(int j = -1; j < 2 && !l; ++j)
			{
				tmpColor = image[getIdx(coord + (int2)(i,j), width)];

				if(tmpColor > upperTreshold)
				{
					color = 1.0;
					l = true;
				}
			}
		}
	}

	imageOut[getIdx(coord,width)] = color;
	//write_imagef(imageOut,coord,color);
}



float getSlope(float g_x, float g_y, float p_x, float p_y)
{
	float g = sqrt(g_x * g_x + g_y * g_y);
	float gx = g_x / g;
	float gy = g_y / g;

	float p = sqrt(p_x * p_x + p_y * p_y);
	float px = p_x / p;
	float py = p_y / p;

	return gx * px + gy * py;


}

kernel void ThresholdImageBuffWithGradientInformation(
	global const float * image,
	global float * imageOut,
	const float lowerTreshold,
	const float upperTreshold,
	const float vpx,
	const float vpy,
	global float * gx,
	global float * gy,
	float dir_thres
	)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	int width = get_global_size(0);
	int idx = getIdx(coord, width);
	//int height = 0.3 *  get_global_size(1) ;


	float color = image[idx];
	//float color = read_imagef(image, samplerA, coord).x;;
	float tmpColor;


	if (color < lowerTreshold /*|| fabs(
		getSlope(
		gx[idx],
		gy[idx],
		vpx - (float)coord.x,
		vpy - (float)coord.y
		)
		) > dir_thres*/  /*|| coord.y < height*/)
	{
		color = 0.0f;
	}
	else if (color > upperTreshold)
	{
		color = 1.0f;
	}
	else
	{
		color = 0.0f;
		bool l = false;
		for (int i = -1; i < 2 && !l; ++i)
		{
			for (int j = -1; j < 2 && !l; ++j)
			{
				tmpColor = image[getIdx(coord + (int2)(i, j), width)];

				if (tmpColor > upperTreshold)
				{
						color = 1.0;
						l = true;
				}
			}
		}
	}

	imageOut[getIdx(coord, width)] = color;
	//write_imagef(imageOut,coord,color);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
