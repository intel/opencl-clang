
inline int RectX (int data){
	return (data & 0xFFF00000) >> 20;
}
inline int RectY (int data){
	return (data & 0x000FFF00) >> 8;
}
inline int RectWidth (int data){
	return data & 0x000000FF;
}
inline float RectScale (int data){
	return (data & 0x000000FF)/20.0f;
}


inline float calcSat(__read_only image2d_t satImg, sampler_t satSmp, float x, float y, float width, float height)
{


        return	        read_imagef(satImg, satSmp, (float2)(x + 0.5f		, y + 0.5f	        )).x +
			read_imagef(satImg, satSmp, (float2)(x + width + 0.5f	, y + height + 0.5f	)).x -
                        read_imagef(satImg, satSmp, (float2)(x + 0.5f		, y + height + 0.5f	)).x -
                        read_imagef(satImg, satSmp, (float2)(x + width + 0.5f	, y + 0.5f		)).x;

}


inline float calcSatFull(__read_only image2d_t satImg, sampler_t satSmp, int x, int y, int width, int height, int data, float scale)
{
        return	read_imagef(satImg, satSmp, (float2)(x + scale + 0.5f			, y + scale + 0.5f	    )).x +
                        read_imagef(satImg, satSmp, (float2)(x + width - scale + 0.5f	, y + height - scale + 0.5f )).x -
                        read_imagef(satImg, satSmp, (float2)(x + scale + 0.5f		, y + height - scale + 0.5f )).x -
                        read_imagef(satImg, satSmp, (float2)(x + width - scale + 0.5f	, y + scale + 0.5f	    )).x;
}

inline float getFeatureNodeSum(
	float4 rects0,
	float haarWeight,
	float4 rects1,
	float haarWeight1,
	float4 rects2,
	float haarWeight2,
	__read_only image2d_t satMem,
	sampler_t satMemInfo,
	int x,
	int y,
	int rectCount,
	int i,
	int j)
{
	//float sum = 0.0f;
	float weights = -(rects1.z * rects1.w * haarWeight1) / (rects0.z * rects0.w);

	weights += rectCount == 3 ? -(rects2.z * rects2.w * haarWeight2) / (rects0.z * rects0.w) : 0.0f;

        float sum1 = rectCount == 3 ? 255.0f * calcSat(satMem, satMemInfo, x + rects2.x, y + rects2.y, rects2.z, rects2.w) * haarWeight2 : 0.0f;
        float sum2 = 255.0f * calcSat(satMem, satMemInfo, x + rects0.x, y + rects0.y, rects0.z, rects0.w) * weights;
        float sum3 = 255.0f * calcSat(satMem, satMemInfo, x + rects1.x, y + rects1.y, rects1.z, rects1.w) * haarWeight1;


        return sum1 + sum2 + sum3;
}


__inline int RoiMinX(const float a, const float b, const int y)
{
        return max(0, (int)(((float)y - b) / a));
}

__inline int RoiMaxX(const float a, const float b, const int y, const int width)
{
	return min(width, max(0, (int)(((float)y - b) / a)));
}

__kernel void viola_jones(
	__global const float4* restrict stageNodes,
	__global const int4*   restrict haarRectangleWindow,
	__global const float*  restrict haarRectangleWeight,
	__global const int4*   restrict haarRectangleWindow1,
	__global const float*  restrict haarRectangleWeight1,
	__global const int4*   restrict haarRectangleWindow2,
	__global const float*  restrict haarRectangleWeight2,
	__global const int*    restrict stageNodeCounts,
	__global const int*    restrict stageNodeOffsets,
	__global const float*  restrict stageThresholds,
	__global int* restrict resRectangles,
	__global const int*    restrict regions,
	__global const float*  restrict region_scales,
	__read_only image2d_t  sat,
	__read_only image2d_t  satQuad,
	const float kernel_scale,
	const int offset,
	const int stagesCount,
	const int rectCount,
	const int buffWidth,
	const float a1,
	const float b1,
	const float a2,
	const float b2)
{
	// Every thread processes a region
	const int id = get_global_id(0);

	// If thread id greater than number of thread exit
	if (id >= rectCount) return;

	// The region number
	int data = regions[id + offset];

	// The scale
	float scale = region_scales[id + offset];

	// Roi crop, check if left and tight horizontal edges are inside the ROI
	float minX = RoiMinX(a1, b1, (RectY(data) + RectWidth(data)) * kernel_scale);
	float maxX = RoiMaxX(a2, b2, (RectY(data) + RectWidth(data)) * kernel_scale, buffWidth);

	// If not, then set the number of resulting rectangles to 0 and exit
	if (RectX(data) * kernel_scale < minX || RectX(data) * kernel_scale > maxX)
	{
		resRectangles[id + offset] = 0;
		return;
	}

	// Calculate the area of the rectangle
	float invArea = 1.0f / (((float)RectWidth(data) - 2 * scale) * ((float)RectWidth(data) - 2 * scale));

	// A sample to use...
	const sampler_t satMemInfoLinear = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;

	// Now calculate the integral and the square integral of the rectangle
	const float mean = calcSatFull(sat, satMemInfoLinear, RectX(data), RectY(data), RectWidth(data), RectWidth(data), data, scale) * invArea;
	const float quad_mean = calcSatFull(satQuad, satMemInfoLinear, RectX(data), RectY(data), RectWidth(data), RectWidth(data), data, scale) * invArea;


	// The variance
	float normFactor = (quad_mean - mean * mean) * (255.0f * 255.0f);
	//	float normFactor = mean*mean * 255.0f * 255.0f*0.30; //ezzel a konstanssal eleg jol szimulalhato a quad hatas...

	// In principle it should always be greater than zero  <x^2> - <x><x> is always greater than 0
	normFactor = (normFactor >= 0.0f) ? sqrt(normFactor) : 1.0f;

	int result = 1;

	if (normFactor < 32){
//		normFactor = 32;
		result = 0;
	}
	else{

		// Now go on the stages...
		// for (int j = 0; j < 1; j++)
		for (int j = 0; j < stagesCount; j++)

		{
			if (normFactor < 60 && j == 0){
				result = 1;
			}

			const int count = stageNodeCounts[j];
			const int offset = stageNodeOffsets[j];
			const float threshold = stageThresholds[j];

			float value = 0.0f;
			for (int i = 0; i < count; i++)
			{
				float4 node = stageNodes[offset + i];

				// evaluate the node's feature

				const float sum = getFeatureNodeSum(convert_float4(haarRectangleWindow[offset + i]) * scale,
					haarRectangleWeight[offset + i] * invArea,
					convert_float4(haarRectangleWindow1[offset + i]) * scale,
					haarRectangleWeight1[offset + i] * invArea,
					convert_float4(haarRectangleWindow2[offset + i]) * scale,
					haarRectangleWeight2[offset + i] * invArea,
					satQuad,
					satMemInfoLinear,
					RectX(data),
					RectY(data),
					node.w, 0, 0);

				// and increase the value accumulator
				value += ((sum < node.x * normFactor) ? node.y : node.z);
			}
			// value = threshold + 0.01;
			if (value <= threshold)
			{
				result = 0;
				break;
			}
		}
		resRectangles[id + offset] = result;
	}
}

__kernel
__attribute__((reqd_work_group_size(32, 1, 1)))
void viola_jones_LWS32(
	__global const float4* restrict stageNodes,
	__global const int4*   restrict haarRectangleWindow,
	__global const float*  restrict haarRectangleWeight,
	__global const int4*   restrict haarRectangleWindow1,
	__global const float*  restrict haarRectangleWeight1,
	__global const int4*   restrict haarRectangleWindow2,
	__global const float*  restrict haarRectangleWeight2,
	__global const int*    restrict stageNodeCounts,
	__global const int*    restrict stageNodeOffsets,
	__global const float*  restrict stageThresholds,
	__global int* restrict resRectangles,
	__global const int*    restrict regions,
	__global const float*  restrict region_scales,
	__read_only image2d_t  sat,
	__read_only image2d_t  satQuad,
	const float kernel_scale,
	const int offset,
	const int stagesCount,
	const int rectCount,
	const int buffWidth,
	const float a1,
	const float b1,
	const float a2,
	const float b2)
{
	// Every thread processes a region
	const int id = get_global_id(0) / 32;
	const ushort lid = get_local_id(0);
	local float stageSumArr[32];

	// If thread id greater than number of thread exit
	if (id >= rectCount) return;

	// The region number
	int data = regions[id];

	// The scale
	float scale = region_scales[id];

	// Roi crop, check if left and tight horizontal edges are inside the ROI
	float minX = RoiMinX(a1, b1, (RectY(data) + RectWidth(data)) * kernel_scale);
	float maxX = RoiMaxX(a2, b2, (RectY(data) + RectWidth(data)) * kernel_scale, buffWidth);

	// If not, then set the number of resulting rectangles to 0 and exit
	if (RectX(data) * kernel_scale < minX || RectX(data) * kernel_scale > maxX)
	{
		resRectangles[id] = 0;
		return;
	}

	// Calculate the area of the rectangle
	float invArea = 1.0f / (((float)RectWidth(data) - 2 * scale) * ((float)RectWidth(data) - 2 * scale));

	// A sample to use...
	const sampler_t satMemInfoLinear = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;

	// Now calculate the integral and the square integral of the rectangle
	const float mean = calcSatFull(sat, satMemInfoLinear, RectX(data), RectY(data), RectWidth(data), RectWidth(data), data, scale) * invArea;
	const float quad_mean = calcSatFull(satQuad, satMemInfoLinear, RectX(data), RectY(data), RectWidth(data), RectWidth(data), data, scale) * invArea;


	// The variance
	float normFactor = (quad_mean - mean * mean) * (255.0f * 255.0f);

	// In principle it should always be greater than zero  <x^2> - <x><x> is always greater than 0
	normFactor = (normFactor >= 0.0f) ? sqrt(normFactor) : 1.0f;

	int result = 1;

	// Now go on the stages...
	for (int j = 0; j < stagesCount; j++)
	{

		const ushort count = stageNodeCounts[j];
		const ushort offset = stageNodeOffsets[j];
		const float threshold = stageThresholds[j];

		float stageSum = 0.0f;

		ushort f = lid;
		while (f < count)
		{
			float4 node = stageNodes[offset + f];

			// evaluate the node's feature
			const float sum = getFeatureNodeSum(convert_float4(haarRectangleWindow[offset + f]) * scale,
				haarRectangleWeight[offset + f] * invArea,
				convert_float4(haarRectangleWindow1[offset + f]) * scale,
				haarRectangleWeight1[offset + f] * invArea,
				convert_float4(haarRectangleWindow2[offset + f]) * scale,
				haarRectangleWeight2[offset + f] * invArea,
				satQuad,
				satMemInfoLinear,
				RectX(data),
				RectY(data), node.w, 0, 0);

			// and increase the value accumulator
			stageSum += ((sum < node.x * normFactor) ? node.y : node.z);

			f += 32;
		}

		// sum across threads
		stageSumArr[lid] = stageSum;
		barrier(CLK_LOCAL_MEM_FENCE);

		if (lid >= 1) stageSumArr[lid] = stageSumArr[lid - 1] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid >= 2) stageSumArr[lid] = stageSumArr[lid - 2] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid >= 4) stageSumArr[lid] = stageSumArr[lid - 4] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid >= 8) stageSumArr[lid] = stageSumArr[lid - 8] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if (lid >= 16) stageSumArr[lid] = stageSumArr[lid - 16] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);

		stageSum = stageSumArr[31];
		barrier(CLK_LOCAL_MEM_FENCE);

		if (stageSum <= threshold)
		{
			result = 0;
			break;
		}
	}
	resRectangles[id] = result;
}

#define wg_size 32

__kernel void fast_sat_step1(int width, int height, __global float * image, __global float * sat, __global float * prologs)
{
    int x0     = get_group_id(0);
    int y0     = get_group_id(1);

    int lid    = get_local_id(0);

    __local float l_data[wg_size * wg_size];
    __local float l_prologs[wg_size * 2];

    event_t cpyEvents[wg_size];

    // Copy the square boxes
    for (int i = 0; i < wg_size; i++) {
        int src_idx  = (y0 * wg_size + i ) * width + x0 * wg_size;
        int dest_idx = i * wg_size;
        async_work_group_copy(&l_data[dest_idx], &image[src_idx], wg_size, cpyEvents[i]);
    }

    wait_group_events(wg_size, cpyEvents);

    // Summing up the horizontal lines
    float sum = 0;
    for (int i = 0; i < wg_size; i++) {
        sum += l_data[lid * wg_size + i];
    }
    l_prologs[lid] = sum;


    // Summing up the vertical lines
    sum = 0;
    for (int i = 0; i < wg_size; i++) {
        sum += l_data[i * wg_size + lid];
    }
    l_prologs[wg_size + lid] = sum;

    // Writing out the results
    int prolog_idx = (y0 * (width / wg_size) + x0) * wg_size * 2;

    async_work_group_copy(&prologs[prolog_idx], &l_prologs[0], wg_size * 2, cpyEvents[0]);
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
