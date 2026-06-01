
#define WG_SIZE 128
#define ROW_WIDTH 2048
#define COLUMN_HEIGHT 1024

#define	SQR(X) ((X)*(X))

__inline void integrate(__local float *buffer, const int row_width, const int l_id)
{
	int offset = 1;

	// build the sum in place up the tree
	for (int d = row_width >> 1; d > 0; d >>= 1)
	{
		barrier(CLK_LOCAL_MEM_FENCE);

		// WG_SIZE < MAX_ROW_SIZE => loop through whole local memory
		for (int k = 0; k < row_width / WG_SIZE; ++k)
		{
			const int idx = WG_SIZE * k + l_id;
			if (idx < d)
			{
				int ai = offset * (2 * idx + 1) - 1;
				int bi = offset * (2 * idx + 2) - 1;

				buffer[bi] += buffer[ai];
			}
		}

		offset <<= 1;
	}

	// clear the last element
	if (l_id == 0)
	{
		buffer[row_width - 1] = 0.0f;
	}

	// traverse down the tree building the scan in the place
	for (int d = 1; d < row_width; d <<= 1)
	{
		offset >>= 1;
		barrier(CLK_LOCAL_MEM_FENCE);

		// again process whole local memory
		for (int k = 0; k < row_width / WG_SIZE; ++k)
		{
			const int idx = WG_SIZE * k + l_id;
			if (idx < d)
			{
				int ai = offset * (2 * idx + 1) - 1;
				int bi = offset * (2 * idx + 2) - 1;

				float t = buffer[ai];
				buffer[ai] = buffer[bi];
				buffer[bi] += t;
			}
		}
	}
}

__inline void integrate1(__local float2 *buffer, const int l_id, const int local_offset)
{
	int offset = 1;

	// build the sum in place up the tree
	for (int d = 64 >> 1; d > 0; d >>= 1)
	{
		if (l_id < d)
		{
			int ai = local_offset + offset * (2 * l_id + 1) - 1;
			int bi = local_offset + offset * (2 * l_id + 2) - 1;

			buffer[bi] += buffer[ai];
		}

		offset <<= 1;

		barrier(CLK_LOCAL_MEM_FENCE);
	}

	// clear the last element
	if (l_id == 0) buffer[63 + local_offset] = (float2)(0.0f);

	barrier(CLK_LOCAL_MEM_FENCE);

	// traverse down the tree building the scan in the place
	for (int d = 1; d < 64; d <<= 1)
	{
		offset >>= 1;

		if (l_id < d)
		{
			const int ai = local_offset + offset * (2 * l_id + 1) - 1;
			const int bi = local_offset + offset * (2 * l_id + 2) - 1;

			const float2 t = buffer[ai];
			buffer[ai] = buffer[bi];
			buffer[bi] += t;
		}

		barrier(CLK_LOCAL_MEM_FENCE);

	}
}

__inline float to_luminance(const float4 val)
{
	return (val.x + val.y + val.z) * (1.0f / 3.0f);
}

__kernel __attribute__((reqd_work_group_size(WG_SIZE, 1, 1)))
	void row_integral(
		__read_only image2d_t input,
		__write_only image2d_t output,
		const int width )
{
	const int y = get_global_id(1);
	const int l_id = get_local_id(0);

	__local float row[ROW_WIDTH];

	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
	for (int k = 0; k < ROW_WIDTH / WG_SIZE; ++k)
	{
		const int x = WG_SIZE * k + l_id;
		row[x] = x < width ? to_luminance(read_imagef(input, sampler, (int2)(x, y))) : 0.0f;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	integrate(row, ROW_WIDTH, l_id);

	barrier(CLK_LOCAL_MEM_FENCE);

	for (int k = 0; k < ROW_WIDTH / WG_SIZE; ++k)
	{
		const int x = WG_SIZE * k + l_id;
		if (x < width) write_imagef(output, (int2)(x, y), (float4)(row[x]) );
	}
}

__kernel __attribute__((reqd_work_group_size(WG_SIZE, 1, 1)))
	void column_integral(
		__read_only image2d_t input,
		__write_only image2d_t output,
		const int height )
{
	const int x = get_global_id(1);
	const int l_id = get_local_id(0);

	__local float column[COLUMN_HEIGHT];

	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
	for (int k = 0; k < COLUMN_HEIGHT / WG_SIZE; ++k)
	{
		const int y = WG_SIZE * k + l_id;
		column[y] = y < height ? read_imagef(input, sampler, (int2)(x, y)).x : 0.0f;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	integrate(column, COLUMN_HEIGHT, l_id);

	barrier(CLK_LOCAL_MEM_FENCE);

	for (int k = 0; k < COLUMN_HEIGHT / WG_SIZE; ++k)
	{
		const int y = WG_SIZE * k + l_id;
		if (y < height) write_imagef(output, (int2)(x, y), (float4)(column[y]));
	}
}

__kernel __attribute__((reqd_work_group_size(WG_SIZE, 1, 1)))
	void row_quad_integral(
		__read_only image2d_t input,
		__write_only image2d_t output,
		const int width )
{
	const int y = get_global_id(1);
	const int l_id = get_local_id(0);

	__local float row[ROW_WIDTH];

	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
	for (int k = 0; k < ROW_WIDTH / WG_SIZE; ++k)
	{
		const int x = WG_SIZE * k + l_id;
		const float p_val = x < width ? to_luminance(read_imagef(input, sampler, (int2)(x, y))) : 0.0f;
		row[x] = SQR(p_val);
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	integrate(row, ROW_WIDTH, l_id);

	barrier(CLK_LOCAL_MEM_FENCE);

	for (int k = 0; k < ROW_WIDTH / WG_SIZE; ++k)
	{
		const int x = WG_SIZE * k + l_id;
		if (x < width) write_imagef(output, (int2)(x, y), (float4)(row[x]) );
	}
}

__kernel __attribute__((reqd_work_group_size(32, 4, 1)))
	void row_quad_integral1(
		__read_only image2d_t input,
		__write_only image2d_t output,
		const int width)
{
	const int y = get_global_id(1);
	const int l_id = get_local_id(0);
	const int local_offset = get_local_id(1) * 64;

	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

	__local float2 row[256];

	int x = l_id;
	float2 last_element = (float2)(0.0f);
	const float loop_count = (width - 1) / 64 + 1;
	for (int i = 0; i < loop_count; ++i)
	{
		const float val0 = x < width ? to_luminance(read_imagef(input, sampler, (int2)(x, y))) : 0.0f;
		row[l_id + local_offset] = (float2)(val0, val0 * val0);
		const float val1 = x < width ? to_luminance(read_imagef(input, sampler, (int2)(x + 32, y))) : 0.0f;
		row[32 + l_id + local_offset] = (float2)(val1, val1 * val1);

		barrier(CLK_LOCAL_MEM_FENCE);

		integrate1(row, l_id, local_offset);

		row[local_offset + l_id] += last_element;
		row[local_offset + (32 + l_id)] += last_element;

		barrier(CLK_LOCAL_MEM_FENCE);

		if (x < width)		write_imagef(output, (int2)(x, y),
			(float4)(row[l_id + local_offset].x, row[l_id + local_offset].y, 0.0f, 0.0f));
		if (x + 32 < width) write_imagef(output, (int2)(x + 32, y),
			(float4)(row[l_id + 32 + local_offset].x, row[l_id + 32 + local_offset].y, 0.0f, 0.0f));

		last_element = row[63 + local_offset];
		x = x + 64;
	}
}

__kernel __attribute__((reqd_work_group_size(32, 4, 1)))
	void column_quad_integral(
		__read_only image2d_t input,
		__write_only image2d_t out_sat,
		__write_only image2d_t out_quad_sat,
		const int height )
{
	const int x = get_global_id(1);
	const int l_id = get_local_id(0);
	const int local_offset = get_local_id(1) * 64;

	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

	__local float2 column[256];

	int y = l_id;
	float2 last_element = (float2)(0.0f);
	const float loop_count = (height - 1) / 64 + 1;
	for (int i = 0; i < loop_count; ++i)
	{
		const float4 val0 = y < height ? read_imagef(input, sampler, (int2)(x, y)) : (float4)(0.0f);
		column[l_id + local_offset] = val0.xy;
		const float4 val1 = y < height ? read_imagef(input, sampler, (int2)(x, y + 32)) : (float4)(0.0f);
		column[l_id + local_offset + 32] = val1.xy;

		barrier(CLK_LOCAL_MEM_FENCE);

		integrate1(column, l_id, local_offset);

		column[local_offset + l_id] += last_element;
		column[local_offset + (32 + l_id)] += last_element;

		if (y < height)		 write_imagef(out_sat, (int2)(x, y), (float4)(column[l_id + local_offset].x));
		if (y + 32 < height) write_imagef(out_sat, (int2)(x, y + 32), (float4)(column[l_id + 32 + local_offset].x));
		if (y < height)		 write_imagef(out_quad_sat, (int2)(x, y), (float4)(column[l_id + local_offset].y));
		if (y + 32 < height) write_imagef(out_quad_sat, (int2)(x, y + 32), (float4)(column[l_id + 32 + local_offset].y));

		last_element = column[63 + local_offset];
		y += 64;
	}
}

const sampler_t cSampler= CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;

__kernel void combine_sat_images(__read_only image2d_t sat_image, __read_only image2d_t quad_sat_image, __write_only image2d_t combined_sat_image)
{
    int x0 = get_global_id(0);
    int y0 = get_global_id(1);


    float v1 = read_imagef(sat_image,      cSampler, (float2)(x0, y0)).x;
    float v2 = read_imagef(quad_sat_image, cSampler, (float2)(x0, y0)).x;

    write_imagef(combined_sat_image, (int2)(x0 * 2, y0), v1);
    write_imagef(combined_sat_image, (int2)(x0 * 2 + 1, y0), v2);

}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
