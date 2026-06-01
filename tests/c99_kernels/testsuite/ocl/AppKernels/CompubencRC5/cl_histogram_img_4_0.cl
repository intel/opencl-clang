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
	__read_only image2d_t srcTex,
	__write_only image2d_t dstTex,
	__global const uint* restrict gCDF,
	__global const uint* restrict gCDFMin,
	const int width
)
{
	uint idX = get_global_id(0);
	uint idY = get_global_id(1);

	uint size = get_global_size(0) * get_global_size(1);

	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_NONE |
		CLK_FILTER_NEAREST;

	float4 color = read_imagef(srcTex, sampler, (int2)(idX, idY));

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

	write_imagef(dstTex, (int2)(idX, idY), out_RGB);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
