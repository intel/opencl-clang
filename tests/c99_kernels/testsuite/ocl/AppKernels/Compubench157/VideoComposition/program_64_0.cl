
inline int OC_CLAMP255( int x)
{
	if( x > 255)
		return 255;
	if( x < 0)
		return 0;
	return x;
}

__kernel void yuvToRgba
(
	__write_only image2d_t output,
	const __global uchar* yChannel,
	const __global uchar* uChannel,
	const __global uchar* vChannel,
	const int yStride,
	const int uStride,
	const int vStride
)
{
	const int x = get_global_id(0);
	const int y = get_global_id(1);

	uchar yCh = yChannel[y*yStride+x];
	uchar uCh = uChannel[((y/2)*uStride)+(x>>1)];
	uchar vCh = vChannel[((y/2)*vStride)+(x>>1)];
	int r = (1904000 * yCh + 2609823 * vCh - 363703744) / 1635200;
	int g = (3827562 * yCh - 1287801 * uCh - 2672387 * vCh + 447306710) / 3287200;
	int b = (952000  * yCh + 1649289 * uCh - 225932192) / 817600;

	write_imageui(output, (int2)(x, y), (uint4)(OC_CLAMP255(r), OC_CLAMP255(g), OC_CLAMP255(b), 255) );
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
