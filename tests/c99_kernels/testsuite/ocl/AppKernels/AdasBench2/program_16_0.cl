
__inline float rgba_to_luminance(const float4 val)
{
	return (val.x + val.y + val.z) * (1.0f / 3.0f);
}

__kernel void init_float2(__global float2 *buffer)
{
	const int idx = get_global_id(0);

	buffer[idx] = idx == 0 ? (float2)(as_float((int)1), 0.0f) : (float2)(0.0f);
}

//#pragma OPENCL EXTENSION cl_amd_printf : enable

//*******************************************************************************************
//  KERNEL  treshholding
//
//      detect line strips (of variing width) and threshold results
//
//*******************************************************************************************
kernel void tresholding(
	read_only image2d_t  src,
	write_only image2d_t  dst,
	const float strip_width_0,//strip width at car
	const float strip_width_1,//strip width change per one pixel
	const float treshold,
	const int width,
	const int height )
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_LINEAR;

	const int2 coord = (int2)(get_global_id(0), get_global_id(1));
	const float2 fcoord = (float2)(get_global_id(0), get_global_id(1)) + (float2)(0.5f, 0.5f);

	if (coord.x >= width || coord.y >= height) return;

	const float tau = strip_width_0+strip_width_1*fcoord.x;
	const float4 color = read_imagef(src, sampler, fcoord);
	const float4 xtau  = read_imagef(src, sampler, fcoord + (float2)(0,tau));
	const float4 x_tau = read_imagef(src, sampler, fcoord - (float2)(0,tau));

	float c = rgba_to_luminance(2 * color - xtau - x_tau - fabs(xtau - x_tau));
	write_imagef(dst, coord, (c < treshold) ? (float4)0.0f : (float4)1.0f);
}

#define WG_SIZE 256

//__kernel void project_to_x(
//	__read_only image2d_t image,
//	__global float * sums,
//	const int height )
//{
//	const int x = get_global_id(0);
//	const int width = get_global_size(0);
//
//	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
//		CLK_ADDRESS_CLAMP_TO_EDGE |
//		CLK_FILTER_NEAREST;
//
//	float sum = 0.0f;
//	for (int y = 0; y < height; ++y)
//	{
//		sum += read_imagef(image, sampler, (int2)(x, y)).x;
//	}
//
//	sums[x] = (sum < 80.0f) ? 0.0f : sum;
//}

//project to x (if more than 80 pixels...)
__kernel __attribute__((reqd_work_group_size(256, 1, 1)))
	void project_to_x(
		__read_only image2d_t image,
		__global int *sums,
		const int width,
		const int height )
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int l_id = get_local_id(0);
	const int y = get_global_id(1);
	if (y >= height) return;

	__local uint row_pixels[WG_SIZE];

	row_pixels[l_id] = l_id < width && (read_imagef(image, sampler, (int2)(l_id, y)).x > 0.0f) ? 1 : 0;
	const int block_count = (width - 1) / WG_SIZE + 1;
	for (int i = 1; i < block_count; ++i)
	{
		const int x = i * WG_SIZE + l_id;
		row_pixels[l_id] += x < width && (read_imagef(image, sampler, (int2)(x, y)).x > 0.0f) ? 1 : 0;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	int offset = 1;

	// build the sum in place up the tree
	for (int d = WG_SIZE >> 1; d > 0; d >>= 1)
	{
		barrier(CLK_LOCAL_MEM_FENCE);

		if (l_id < d)
		{
			int ai = offset * (2 * l_id + 1) - 1;
			int bi = offset * (2 * l_id + 2) - 1;

			row_pixels[bi] += row_pixels[ai];
		}

		offset <<= 1;
	}

	// clear the last element
	if (l_id == 0)
	{
		row_pixels[WG_SIZE - 1] = 0;
	}

	// traverse down the tree building the scan in the place
	for (int d = 1; d < WG_SIZE; d <<= 1)
	{
		offset >>= 1;
		barrier(CLK_LOCAL_MEM_FENCE);

		if (l_id < d)
		{
			int ai = offset * (2 * l_id + 1) - 1;
			int bi = offset * (2 * l_id + 2) - 1;

			int t = row_pixels[ai];
			row_pixels[ai] = row_pixels[bi];
			row_pixels[bi] += t;
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	if (l_id == 0)
	{
		int sum = row_pixels[WG_SIZE - 1];
		sums[y] = (sum < 80) ? 0 : sum;
	}
}

__kernel void extract_points(
	__read_only image2d_t image,
	__global float2 * points,
	const int step,
	const int height,
	const int extraction_width
)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int x = get_global_id(0);

	if (x >= extraction_width) return;

	float val = read_imagef(image, sampler, (int2)(get_global_id(0), get_global_id(1)) ).x;

	int length = 0;
	const int w = step * x;
	for (int h = 0; h<height-1; ++h)
	{
		float val = read_imagef(image, sampler, (int2)(w, h)).x;

		//if (val > 0.0f) printf("%f\n", val);

		if (val > 0.0f)
		{
			++length;
		}
		else
		{
			if (length >= 2)
			{
				__global int *idx_counter = (global int*)points;
				const int idx = atomic_inc(idx_counter);
				points[idx] = (float2)(h - (float)length *0.5, w);
			}
			length = 0;
		}
	}
}

//Subpixel enhancement based on original intensity, by parabola fit (
__kernel void subpixel_enchantment(
	__global float2 * points,
	__read_only image2d_t image )
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_LINEAR;

	const int idx = get_global_id(0);
	const float2 raw_point = points[idx];

	if (raw_point.x == 0.0f && raw_point.y == 0.0f) return;

	const int n = 3;

	float4 mat = (float4)0.0f;
	float4 B   = (float4)0.0f;

	#pragma unroll
	for (int i=-3; i<=3; ++i)
	{
		const int x = raw_point.y;
		const int y = raw_point.x;
		const float p_val = rgba_to_luminance(read_imagef(image, sampler, (float2)(x, y+i) + (float2)(0.5f)));

		const float vx = p_val;
		const float vy = i;

		B.x += vx;//mass

		B.y += vx * vy;//CoG: sum mass*poz
		mat.x += vy;//summ pos

		const float vy_2 = vy * vy;
		mat.y += vy_2;//sum pos^2
		B.z += vx * vy_2; // moment

		mat.z += vy_2 * vy;//sym i^3
		mat.w += vy_2 * vy_2;//sym i^4
	}

	const float a = n*2+1; // mat[0];
	const float b = mat.x;
	const float c = mat.y;
	const float d = mat.x;
	const float e = mat.y;
	const float f = mat.z;
	const float g = mat.y;
	const float h = mat.z;
	const float i = mat.w;
	const float j = B.x;
	const float k = B.y;
	const float l = B.z;

	// solve 3x3 system
	const float Det_i = 1.0f / ((a*e*i + b*f*g + c*d*h) - (c*e*g + b*d*i + a*f*h));
	const float DetX = (j*e*i + b*f*l + c*k*h) - (c*e*l + b*k*i + j*f*h);
	const float DetY = (a*k*i + j*f*g + c*d*l) - (c*k*g + j*d*i + a*f*l);
	// const float DetZ = (a*e*l + b*k*g + j*d*h) - (j*e*g + b*d*l + a*k*h);

	const float poly_a = DetX * Det_i;
	const float poly_b = DetY * Det_i;
	// const float poly_c = DetZ * Det_i;

	float poly_max_location = raw_point.x - poly_b / (2 * poly_a);
	points[idx] = (float2)(poly_max_location, raw_point.y);
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
