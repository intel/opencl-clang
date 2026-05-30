#define USEIMG
__kernel void oggDecode
(
#ifdef USEIMG
	__write_only image2d_t output,
#else
	__global uchar4* restrict output,
#endif
	const __global uchar* yChannel,
	const __global uchar* uChannel,
	const __global uchar* vChannel,
	const int yStride,
	const int uStride,
	const int vStride,
	const int hdec,
	const int vdec
)
{
	const int x = get_global_id(0);
	const int y = get_global_id(1);

	uchar yCh = yChannel[y*yStride+x];
	uchar uCh = uChannel[((y/2)*uStride)+(x>>hdec)];
	uchar vCh = vChannel[((y/2)*vStride)+(x>>hdec)];

	int r = (1904000 * yCh + 2609823 * vCh - 363703744) / 1635200;
	int g = (3827562 * yCh - 1287801 * uCh - 2672387 * vCh + 447306710) / 3287200;
	int b = (952000  * yCh + 1649289 * uCh - 225932192) / 817600;

	int4 out = (int4)(r, g, b, 255);
	out = clamp(out, (int4)(0,0,0,255), (int4)(255,255,255,255));

#ifdef USEIMG
	write_imageui(output, (int2)(x, y), convert_uint4(out));
#else
	output[x + y * get_global_size(0)] = convert_uchar4(out);
#endif
}

__kernel
void buildPyramid( __read_only image2d_t src, __write_only image2d_t dst, const float sx, const float sy )
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);

	int width = get_image_width(dst);
	int height = get_image_height(dst);

	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR;

	if(idx < width && idy < height)
	{
		//uint4 val = read_imageui(src, sampler, (int2)(idx, idy));
	    uint4 val = read_imageui(src, sampler, (float2)(idx * sx, idy * sy));

		write_imageui(dst, (int2)(idx, idy), val);
	}
}

__kernel
void copyImageToBufferRect( __read_only image2d_t src, __global float* dst, const int ox, const int oy )
{
	int idx = get_global_id(0);
	int idy = get_global_id(1);

	int nx = get_global_size(0);
	int ny = get_global_size(1);

	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;
	uint4 val = read_imageui(src, sampler, (int2)(ox + idx, oy + idy));

	// !!! tranform to rgb planes !!!
	dst[0*nx*ny + (idx + idy * nx)] = val.x / 255.0f;
	dst[1*nx*ny + (idx + idy * nx)] = val.y / 255.0f;
	dst[2*nx*ny + (idx + idy * nx)] = val.z / 255.0f;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
