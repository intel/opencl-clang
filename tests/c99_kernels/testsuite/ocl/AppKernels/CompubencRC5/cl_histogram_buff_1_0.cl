#define USE_UCHAR4

#ifdef USE_UCHAR4
	#define DATATYPE uchar4
	#define DATATYPEIMG uint4
	#define WRITEIMG write_imageui
	#define READIMG read_imageui
	#define CONVERTU4(x) convert_uchar4(x+(float4)(0.5f))
	#define CONVERTU4IMG(x) convert_uint4(x+(float4)(0.5f))
	#define CONVERTF4 convert_float4
#endif

inline uint float4ToUchar(float4 rgba)
{
	return clamp((uint)((85.0f*rgba.x) + (85.0f*rgba.y) + (85.0f*rgba.z)+0.5f), (uint)(0), (uint)(255));
}

inline float float4ToGray(float4 rgba)
{
	return (0.333f * rgba.x) + (0.333f * rgba.y) + (0.333f * rgba.z);
}

__kernel
void histBin_local(
	__global const DATATYPE* restrict srcTex,
	__global DATATYPE* restrict dstTex,
	__global uint* restrict histogramBins,
	const uint numsteps,
	const uint offset,
	const int width,
	const int height,
	const float scale
)
{
	uint gIdX = get_global_id(0);
	uint lIdX = get_local_id(0);

	uint grIdX = get_group_id(0);

	__local uint lHistogramBin[256];

	for (uint i = 0; i < numsteps; ++i)
	{
		if (lIdX < offset)
		{
			lHistogramBin[lIdX + i*offset] = (uint)(0);
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	for(int rowId = 0; rowId < height; ++rowId)
	{
		float4 color = CONVERTF4(srcTex[gIdX + width*rowId]) / (float4)(255.0f) + scale;
		color = clamp(color, (float4)(0.0f), (float4)(1.0f));
		dstTex[gIdX + width*rowId] = CONVERTU4(color * (float4)(255.0f));

		uint histogramKey = float4ToUchar(color);

		atomic_inc(lHistogramBin+histogramKey);
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	for (uint i = 0; i < numsteps; ++i)
	{
		if (lIdX < offset)
		{
			histogramBins[grIdX * (uint)(256) + lIdX + i*offset] = lHistogramBin[lIdX + i*offset];
		}
	}
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
