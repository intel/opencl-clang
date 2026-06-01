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
void histNorm(
	__global const DATATYPE* restrict srcTex,
	__global DATATYPE* restrict dstTex,
	__global const uint* restrict gCDF,
	__global const uint* restrict gCDFMin,
	const int width
)
{
	uint idX = get_global_id(0);
	uint idY = get_global_id(1);

	uint size = get_global_size(0) * get_global_size(1);

	float4 color = CONVERTF4(srcTex[idX + width*idY]) / (float4)(255.0f);

	//compute the normalizing factor
	uint histogramKey = float4ToUchar(color);
	float currCdf = (float)gCDF[histogramKey];
	float currCdfMin = (float)gCDFMin[0];
	float norm = ((currCdf - currCdfMin) / ((float)size - currCdfMin));

	//get luminance
	float lum = float4ToGray(color);

	//compute RGB and CMY color component
	float scale = clamp(norm / (lum + 0.0001f), 0.0f, 1.0f);
	float4 out_RGB = color * scale;
	scale = (1.0f - norm)/(1.0f - lum);
	float4 out_CMY = (float4)(1.0f) - (((float4)(1.0f) - color) * scale);

	//interpolation function between RGB and CMY
	float f = clamp((1.0f-lum - 0.25f) * 2.0f, 0.0f, 1.0f);

	//interpolation
	out_RGB = out_RGB * f + out_CMY * (1.0f - f);
	out_RGB = clamp(out_RGB, (float4)(0.0f), (float4)(1.0f));

	dstTex[idX + width*idY] = CONVERTU4(out_RGB * (float4)(255.0f));
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
