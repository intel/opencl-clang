__kernel
void createIntensity(__read_only image2d_t source, __global float* restrict result, const uint width)
{
	const uint x = get_global_id(0);
	const uint y = get_global_id(1);

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	float4 color = read_imagef(source, sampler, (int2)(x, y));

	float4 params = (float4)(0.2989f, 0.5870f, 0.1140f, 0.0f);
	float intensity = dot(params, color);

	intensity *= 255.0f;
	result[x + width*y] = intensity;
}
__kernel
void satVerticalImage
(
	__global const float* restrict intensity,
	__global float* restrict sat,
	__global float* restrict quadSat,
	const int width,
	const int height
)
{
	int x = get_global_id(0);

	if (x >= width)
		return;

	float tmpSat = 0.0f;
	float tmpQuadSat = 0.0f;

	for(int colId = 0; colId < height; ++colId)
	{
		//const int2 coords = (int2)(x, colId);

		//float currIntensity = read_imagef(intensity, sampler, coords).x;
		float currIntensity = intensity[x + width*colId];

		tmpSat += currIntensity;
		tmpQuadSat += (currIntensity * currIntensity);

		//write_imagef(sat, coords, tmpSat);
		//write_imagef(quadSat, coords, tmpQuadSat);
		sat[x + width*colId] = tmpSat;
		quadSat[x + width*colId] = tmpQuadSat;
	}
}

__kernel
void satHorizontalImage
(
	__global const float* restrict srcSat,
	__global const float* restrict srcQuadSat,
	__global float* restrict destSat,
	__global float* restrict destQuadSat,
	const int width,
	const int height
)
{
	int x = get_global_id(0);

	if (x >= height)
		return;

	float tmpSat = 0.0f;
	float tmpQuadSat = 0.0f;

	for(int rowId = 0; rowId < width; ++rowId)
	{
		//const int2 coords = (int2)(rowId, x);

		//float satVal = read_imagef(srcSat, sampler, coords).x;
		//float satQuadVal = read_imagef(srcQuadSat, sampler, coords).x;
		float satVal = srcSat[rowId + width*x];
		float satQuadVal = srcQuadSat[rowId + width*x];

		tmpSat += satVal;
		tmpQuadSat += satQuadVal;

		//write_imagef(destSat, coords, tmpSat);
		//write_imagef(destQuadSat, coords, tmpQuadSat);
		destSat[rowId + width*x] = tmpSat;
		destQuadSat[rowId + width*x] = tmpQuadSat;
	}
}

inline int RectX(int data){
	return (data & 0xFFF00000) >> 20;
}

inline int RectY(int data){
	return (data & 0x000FFF00) >> 8;
}

inline int RectWidth(int data){
	return data & 0x000000FF;
}

inline float RectScale(int data){
	return (data & 0x000000FF) / 20.0f;
}

inline float getSatBuff(__global const float* restrict satBuff, int satOffset, int x, int y, int width, int height)
{
	return	satBuff[(x		) + satOffset*(y	   )] +
			satBuff[(x+width) + satOffset*(y+height)] -
			satBuff[(x		) + satOffset*(y+height)] -
			satBuff[(x+width) + satOffset*(y	   )];
}

inline float getFeatureNodeSum(
	float4 rects0,
	float haarWeight,
	float4 rects1,
	float haarWeight1,
	float4 rects2,
	float haarWeight2,
	__global const float* restrict satMem,
	int satOffset,
	int x,
	int y,
	int rectCount)
{
	float sum = 0.0f;
	float weights = -(rects1.z * rects1.w * haarWeight1) / (rects0.z * rects0.w);

	weights += rectCount == 3 ? -(rects2.z * rects2.w * haarWeight2) / (rects0.z * rects0.w) : 0.0f;
	sum += rectCount == 3 ? getSatBuff(satMem, satOffset, x + rects2.x, y + rects2.y, rects2.z, rects2.w) * haarWeight2 : 0.0f;

	sum += getSatBuff(satMem, satOffset, x + rects0.x, y + rects0.y, rects0.z, rects0.w) * weights;
	sum += getSatBuff(satMem, satOffset, x + rects1.x, y + rects1.y, rects1.z, rects1.w) * haarWeight1;

	return sum;
}

__constant ushort stageNodeCounts[22] =
{ 3, 16, 21, 39, 33, 44, 50, 51, 56, 71, 80, 103, 111, 102, 135, 137, 140, 160, 177, 182, 211, 213 };

__constant ushort stageNodeOffsets[22] =
{ 0, 3, 19, 40, 79, 112, 156, 206, 257, 313, 384, 464, 567, 678, 780, 915, 1052, 1192, 1352, 1529, 1711, 1922 };

__constant float stageThresholds[22] =
{ 0.822689f, 6.95661f, 9.49854f, 18.413f, 15.3241f, 21.0106f, 23.9188f, 24.5279f, 27.1534f, 34.5541f, 39.1073f, 50.6105f, 54.6201f, 50.1697f, 66.6691f, 67.6989f, 69.2299f, 79.2491f, 87.696f, 90.2533f, 104.749f, 105.761f };

__kernel
void violaJones_NAIVE(
	const __global float4* __restrict stageNodes,
	const __global float4* __restrict haarRectangleWindow,
	const __global float* __restrict haarRectangleWeight,
	const __global float4* __restrict haarRectangleWindow1,
	const __global float* __restrict haarRectangleWeight1,
	const __global float4* __restrict haarRectangleWindow2,
	const __global float* __restrict haarRectangleWeight2,
	__global int* __restrict resRectangles,
	const __global int* __restrict regions,
	__global const float* restrict sat,
	__global const float* restrict satQuad,
	const int rectCount)
{
	const int id = get_global_id(0);

	if (id >= rectCount)
		return;

	int data = regions[id];
	float invArea = 1.0f / ((float)RectWidth(data) * (float)RectWidth(data));

	int satMemInfo = 1280;

	float mean = getSatBuff(sat, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea;
	float normFactor = getSatBuff(satQuad, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea - (mean * mean);

	normFactor = (normFactor >= 0.0f) ? sqrt(normFactor) : 1.0f;

	int result = 1;

	for (ushort j = 0; j < 22; ++j)
	{
		const ushort count = stageNodeCounts[j];
		const ushort offset = stageNodeOffsets[j];
		const float threshold = stageThresholds[j];

		float value = 0.0f;
		for (ushort i = 0; i < count; ++i)
		{
			float4 node = stageNodes[offset + i];

			// evaluate the node's feature
			const float sum = getFeatureNodeSum((haarRectangleWindow[offset + i])*RectScale(data), haarRectangleWeight[offset + i] * invArea,
				(haarRectangleWindow1[offset + i])*RectScale(data), haarRectangleWeight1[offset + i] * invArea,
				(haarRectangleWindow2[offset + i])*RectScale(data), haarRectangleWeight2[offset + i] * invArea,
				sat, satMemInfo, RectX(data), RectY(data), node.w);

			// and increase the value accumulator
			value += ((sum < node.x * normFactor) ? node.y : node.z);
		}

		if (value <= threshold)
		{
			result = 0;
			break;
		}
	}

	resRectangles[id] = result;
}

__kernel
__attribute__((reqd_work_group_size(32, 1, 1)))
void violaJones_LWS32(
	const __global float4* __restrict stageNodes,
	const __global float4* __restrict haarRectangleWindow,
	const __global float* __restrict haarRectangleWeight,
	const __global float4* __restrict haarRectangleWindow1,
	const __global float* __restrict haarRectangleWeight1,
	const __global float4* __restrict haarRectangleWindow2,
	const __global float* __restrict haarRectangleWeight2,
	__global int* __restrict resRectangles,
	const __global int* __restrict regions,
	__global const float* restrict sat,
	__global const float* restrict satQuad,
	const int rectCount)
{
	const int id = get_global_id(0) / 32;
	int data = regions[id];

	const ushort lid = get_local_id(0);
	local float stageSumArr[32];

	float invArea = 1.0f / ((float)RectWidth(data) * (float)RectWidth(data));

	int satMemInfo = 1280;

	float mean = getSatBuff(sat, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea;
	float normFactor = getSatBuff(satQuad, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea - (mean * mean);

	normFactor = (normFactor >= 0.0f) ? sqrt(normFactor) : 1.0f;

	int result = 1;

	for (ushort j = 0; j < 22; ++j)
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
			const float sum = getFeatureNodeSum((haarRectangleWindow[offset + f])*RectScale(data), haarRectangleWeight[offset + f] * invArea,
				(haarRectangleWindow1[offset + f])*RectScale(data), haarRectangleWeight1[offset + f] * invArea,
				(haarRectangleWindow2[offset + f])*RectScale(data), haarRectangleWeight2[offset + f] * invArea,
				sat, satMemInfo, RectX(data), RectY(data), node.w);

			// and increase the value accumulator
			stageSum += ((sum < node.x * normFactor) ? node.y : node.z);

			f += 32;
		}

		// sum across threads
		stageSumArr[lid] = stageSum;
		barrier(CLK_LOCAL_MEM_FENCE);

		#pragma unroll
		for( int offset=1; offset <= 16; offset*=2 )
		{
			float t;
			if(lid >= offset)
				t = stageSumArr[lid - offset];
			barrier(CLK_LOCAL_MEM_FENCE);

			if(lid >= offset)
				stageSumArr[lid] = t + stageSumArr[lid];
			barrier(CLK_LOCAL_MEM_FENCE);
		}

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

__kernel
__attribute__((reqd_work_group_size(64, 1, 1)))
void violaJones_LWS64(
	const __global float4* __restrict stageNodes,
	const __global float4* __restrict haarRectangleWindow,
	const __global float* __restrict haarRectangleWeight,
	const __global float4* __restrict haarRectangleWindow1,
	const __global float* __restrict haarRectangleWeight1,
	const __global float4* __restrict haarRectangleWindow2,
	const __global float* __restrict haarRectangleWeight2,
	__global int* __restrict resRectangles,
	const __global int* __restrict regions,
	__global const float* restrict sat,
	__global const float* restrict satQuad,
	const int rectCount)
{
	const int id = get_global_id(0) / 64;
	int data = regions[id];

	const ushort lid = get_local_id(0);
	local float stageSumArr[64];

	float invArea = 1.0f / ((float)RectWidth(data) * (float)RectWidth(data));

	int satMemInfo = 1280;

	float mean = getSatBuff(sat, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea;
	float normFactor = getSatBuff(satQuad, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea - (mean * mean);

	normFactor = (normFactor >= 0.0f) ? sqrt(normFactor) : 1.0f;

	int result = 1;

	for (ushort j = 0; j < 22; ++j)
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
			const float sum = getFeatureNodeSum((haarRectangleWindow[offset + f])*RectScale(data), haarRectangleWeight[offset + f] * invArea,
				(haarRectangleWindow1[offset + f])*RectScale(data), haarRectangleWeight1[offset + f] * invArea,
				(haarRectangleWindow2[offset + f])*RectScale(data), haarRectangleWeight2[offset + f] * invArea,
				sat, satMemInfo, RectX(data), RectY(data), node.w);

			// and increase the value accumulator
			stageSum += ((sum < node.x * normFactor) ? node.y : node.z);

			f += 64;
		}

		// sum across threads
		stageSumArr[lid] = stageSum;
		barrier(CLK_LOCAL_MEM_FENCE);

		#pragma unroll
		for( int offset=1; offset <= 32; offset*=2 )
		{
			float t;
			if(lid >= offset)
				t = stageSumArr[lid - offset];
			barrier(CLK_LOCAL_MEM_FENCE);

			if(lid >= offset)
				stageSumArr[lid] = t + stageSumArr[lid];
			barrier(CLK_LOCAL_MEM_FENCE);
		}

		stageSum = stageSumArr[63];
		barrier(CLK_LOCAL_MEM_FENCE);

		if (stageSum <= threshold)
		{
			result = 0;
			break;
		}
	}

	resRectangles[id] = result;
}



// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
