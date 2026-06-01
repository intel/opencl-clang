__kernel void oggDecodeImg
(
	__write_only image2d_t output,
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

	float4 out = (float4)(r, g, b, 255.0f);
	out = clamp(out, (float4)(0.0f,0.0f,0.0f,255.0f), (float4)(255.0f,255.0f,255.0f,255.0f));
#ifdef USE_UNORM
	out /= (float4)(255.0f,255.0f,255.0f,255.0f);
#endif
	write_imagef(output, (int2)(x, y), out);
}

__kernel void oggDecodeBfr
(
	__global float4* output,
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

	float4 out = (float4)(r, g, b, 255.0f);
	out = clamp(out, (float4)(0.0f,0.0f,0.0f,255.0f), (float4)(255.0f,255.0f,255.0f,255.0f));

	output[x + y * get_global_size(0)] = out;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
