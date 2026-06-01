#define USEIMG
/*---   data : face detecting window   ---
   x : 12bit; y : 12bit; width : 8bit
	      data = x|y|width
 ----------------------------------------*/

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

#ifdef USEIMG

#define calcSat(mem, meminfo, x, y, w, h) getSatImg(mem, meminfo, x, y, w, h)

inline float getSatImg(__read_only image2d_t satImg, sampler_t satSmp, int x, int y, int width, int height)
{
	return	read_imagef(satImg, satSmp, (int2)(x,		y		)).x +
			read_imagef(satImg, satSmp, (int2)(x+width, y+height)).x -
			read_imagef(satImg, satSmp, (int2)(x,		y+height)).x -
			read_imagef(satImg, satSmp, (int2)(x+width, y		)).x;
}

#else

#define calcSat(mem, meminfo, x, y, w, h) getSatBuff(mem, meminfo, x, y, w, h)

inline float getSatBuff(__global const float* restrict satBuff, int satOffset, int x, int y, int width, int height)
{
	return	satBuff[(x		) + satOffset*(y	   )] +
			satBuff[(x+width) + satOffset*(y+height)] -
			satBuff[(x		) + satOffset*(y+height)] -
			satBuff[(x+width) + satOffset*(y	   )];
}

#endif

// calculate feature node sum (= sum of all rectangles in node)
inline float getFeatureNodeSum(
	float4 rects0,
	float haarWeight,
	float4 rects1,
	float haarWeight1,
	float4 rects2,
	float haarWeight2,
#ifdef USEIMG
	__read_only image2d_t satMem,
	sampler_t satMemInfo,
#else
	__global const float* restrict satMem,
	int satMemInfo,
#endif
	int x,
	int y,
	int rectCount
)
{
	float sum = 0.0f;
	float weights = -(rects1.z * rects1.w * haarWeight1) / (rects0.z * rects0.w);

	weights += rectCount == 3 ? -(rects2.z * rects2.w * haarWeight2) / (rects0.z * rects0.w) : 0.0f;
	sum += rectCount == 3 ? calcSat(satMem, satMemInfo, x + rects2.x, y + rects2.y, rects2.z, rects2.w) * haarWeight2 : 0.0f;

	sum += calcSat(satMem, satMemInfo, x + rects0.x, y + rects0.y, rects0.z, rects0.w) * weights;
	sum += calcSat(satMem, satMemInfo, x + rects1.x, y + rects1.y, rects1.z, rects1.w) * haarWeight1;

	return sum;
}

__constant ushort stageNodeCounts[ 22 ] =
{ 3,16,21,39,33,44,50,51,56,71,80,103,111,102,135,137,140,160,177,182,211,213 };

__constant ushort stageNodeOffsets[ 22 ] =
{ 0,3,19,40,79,112,156,206,257,313,384,464,567,678,780,915,1052,1192,1352,1529,1711,1922 };

__constant float stageThresholds[ 22 ] =
{ 0.822689f,6.95661f,9.49854f,18.413f,15.3241f,21.0106f,23.9188f,24.5279f,27.1534f,34.5541f,39.1073f,50.6105f,54.6201f,50.1697f,66.6691f,67.6989f,69.2299f,79.2491f,87.696f,90.2533f,104.749f,105.761f };

/*---- stageNodes : HaarFeatureNode struct ------
            node.x = threshold  (float)
            node.y = leftValue  (float)
            node.z = rightValue (float)
            node.w = rectCount  (int)
------------------------------------------------*/

__kernel
void violaJones_NAIVE(
	__global const float4* restrict stageNodes,
	__global const uchar4* restrict haarRectangleWindow,
	__global const float* restrict haarRectangleWeight,
	__global const uchar4* restrict haarRectangleWindow1,
	__global const float* restrict haarRectangleWeight1,
	__global const uchar4* restrict haarRectangleWindow2,
	__global const float* restrict haarRectangleWeight2,
	__global int* restrict resRectangles,
	__global const int* restrict regions,
#ifdef USEIMG
	__read_only image2d_t sat,
	__read_only image2d_t satQuad,
#else
	__global const float* restrict sat,
	__global const float* restrict satQuad,
#endif
	const int stagesCount,
	const int rectCount,
	const int buffWidth)
{
	const int id = get_global_id(0);

	if (id >= rectCount)
		return;

	int data = regions[id];
	float invArea = 1.0f / ((float)RectWidth(data) * (float)RectWidth(data));

#ifdef USEIMG
	const sampler_t satMemInfo = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;
#else
	int satMemInfo = buffWidth;
#endif

	float mean = calcSat(sat, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea;
	float normFactor = calcSat(satQuad, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea - (mean * mean);

	normFactor = (normFactor >= 0.0f) ? sqrt(normFactor) : 1.0f;

	int result = 1;

	for(ushort j = 0; j < 22; ++j)
	{
		const ushort count = stageNodeCounts[j];
		const ushort offset = stageNodeOffsets[j];
		const float threshold = stageThresholds[j];

		float value = 0.0f;
		for(ushort i = 0; i < count; ++i)
		{
			float4 node = stageNodes[offset+i];

			// evaluate the node's feature
			const float sum = getFeatureNodeSum(convert_float4(haarRectangleWindow [offset+i])*RectScale(data), haarRectangleWeight [offset+i] * invArea,
												convert_float4(haarRectangleWindow1[offset+i])*RectScale(data), haarRectangleWeight1[offset+i] * invArea,
												convert_float4(haarRectangleWindow2[offset+i])*RectScale(data), haarRectangleWeight2[offset+i] * invArea,
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
	__global const float4* restrict stageNodes,
	__global const uchar4* restrict haarRectangleWindow,
	__global const float* restrict haarRectangleWeight,
	__global const uchar4* restrict haarRectangleWindow1,
	__global const float* restrict haarRectangleWeight1,
	__global const uchar4* restrict haarRectangleWindow2,
	__global const float* restrict haarRectangleWeight2,
	__global int* restrict resRectangles,
	__global const int* restrict regions,
#ifdef USEIMG
	__read_only image2d_t sat,
	__read_only image2d_t satQuad,
#else
	__global const float* restrict sat,
	__global const float* restrict satQuad,
#endif
	const int stagesCount,
	const int rectCount,
	const int buffWidth)
{
	const int id = get_global_id(0) / 32;
	int data = regions[id];

	const ushort lid = get_local_id(0);
	local float stageSumArr[32];

	float invArea = 1.0f / ((float)RectWidth(data) * (float)RectWidth(data));

#ifdef USEIMG
	const sampler_t satMemInfo = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;
#else
	int satMemInfo = buffWidth;
#endif

	float mean = calcSat(sat, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea;
	float normFactor = calcSat(satQuad, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea - (mean * mean);

	normFactor = (normFactor >= 0.0f) ? sqrt(normFactor) : 1.0f;

	int result = 1;

	for(ushort j = 0; j < 22; ++j)
	{
		const ushort count = stageNodeCounts[j];
		const ushort offset = stageNodeOffsets[j];
		const float threshold = stageThresholds[j];

		float stageSum = 0.0f;

		ushort f = lid;
		while(f < count)
		{
			float4 node = stageNodes[offset+f];

			// evaluate the node's feature
			const float sum = getFeatureNodeSum(convert_float4(haarRectangleWindow [offset+f])*RectScale(data), haarRectangleWeight [offset+f] * invArea,
				                                convert_float4(haarRectangleWindow1[offset+f])*RectScale(data), haarRectangleWeight1[offset+f] * invArea,
												convert_float4(haarRectangleWindow2[offset+f])*RectScale(data), haarRectangleWeight2[offset+f] * invArea,
												sat, satMemInfo, RectX(data), RectY(data), node.w);

			// and increase the value accumulator
			stageSum += ((sum < node.x * normFactor) ? node.y : node.z);

			f += 32;
		}

		// sum across threads
		stageSumArr[lid] = stageSum;
		barrier(CLK_LOCAL_MEM_FENCE);

		if( lid >=  1 ) stageSumArr[lid] = stageSumArr[lid -  1] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >=  2 ) stageSumArr[lid] = stageSumArr[lid -  2] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >=  4 ) stageSumArr[lid] = stageSumArr[lid -  4] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >=  8 ) stageSumArr[lid] = stageSumArr[lid -  8] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >= 16 ) stageSumArr[lid] = stageSumArr[lid - 16] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);

        stageSum = stageSumArr[31];
		barrier(CLK_LOCAL_MEM_FENCE);

		if(stageSum <= threshold)
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
	__global const float4* restrict stageNodes,
	__global const uchar4* restrict haarRectangleWindow,
	__global const float* restrict haarRectangleWeight,
	__global const uchar4* restrict haarRectangleWindow1,
	__global const float* restrict haarRectangleWeight1,
	__global const uchar4* restrict haarRectangleWindow2,
	__global const float* restrict haarRectangleWeight2,
	__global int* restrict resRectangles,
	__global const int* restrict regions,
#ifdef USEIMG
	__read_only image2d_t sat,
	__read_only image2d_t satQuad,
#else
	__global const float* restrict sat,
	__global const float* restrict satQuad,
#endif
	const int stagesCount,
	const int rectCount,
	const int buffWidth)
{
	const int id = get_global_id(0) / 64;
	int data = regions[id];

	const ushort lid = get_local_id(0);
	local float stageSumArr[64];

	float invArea = 1.0f / ((float)RectWidth(data) * (float)RectWidth(data));

#ifdef USEIMG
	const sampler_t satMemInfo = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;
#else
	int satMemInfo = buffWidth;
#endif

	float mean = calcSat(sat, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea;
	float normFactor = calcSat(satQuad, satMemInfo, RectX(data), RectY(data), RectWidth(data), RectWidth(data)) * invArea - (mean * mean);

	normFactor = (normFactor >= 0.0f) ? sqrt(normFactor) : 1.0f;

	int result = 1;

	for(ushort j = 0; j < 22; ++j)
	{
		const ushort count = stageNodeCounts[j];
		const ushort offset = stageNodeOffsets[j];
		const float threshold = stageThresholds[j];

		float stageSum = 0.0f;

		ushort f = lid;
		while(f < count)
		{
			float4 node = stageNodes[offset+f];

			// evaluate the node's feature
			const float sum = getFeatureNodeSum(convert_float4(haarRectangleWindow [offset+f])*RectScale(data), haarRectangleWeight [offset+f] * invArea,
				                                convert_float4(haarRectangleWindow1[offset+f])*RectScale(data), haarRectangleWeight1[offset+f] * invArea,
												convert_float4(haarRectangleWindow2[offset+f])*RectScale(data), haarRectangleWeight2[offset+f] * invArea,
												sat, satMemInfo, RectX(data), RectY(data), node.w);

			// and increase the value accumulator
			stageSum += ((sum < node.x * normFactor) ? node.y : node.z);

			f += 64;
		}

		// sum across threads
		stageSumArr[lid] = stageSum;
		barrier(CLK_LOCAL_MEM_FENCE);

		if( lid >=  1 ) stageSumArr[lid] = stageSumArr[lid -  1] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >=  2 ) stageSumArr[lid] = stageSumArr[lid -  2] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >=  4 ) stageSumArr[lid] = stageSumArr[lid -  4] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >=  8 ) stageSumArr[lid] = stageSumArr[lid -  8] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >= 16 ) stageSumArr[lid] = stageSumArr[lid - 16] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);
		if( lid >= 32 ) stageSumArr[lid] = stageSumArr[lid - 32] + stageSumArr[lid];
		barrier(CLK_LOCAL_MEM_FENCE);

        stageSum = stageSumArr[63];
		barrier(CLK_LOCAL_MEM_FENCE);

		if(stageSum <= threshold)
		{
			result = 0;
			break;
		}
	}

	resRectangles[id] = result;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
