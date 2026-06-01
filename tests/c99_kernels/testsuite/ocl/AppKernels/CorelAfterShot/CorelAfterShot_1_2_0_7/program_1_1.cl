#define Kernel16


//#pragma OPENCL EXTENSION cl_amd_printf : enable

void pixsort(float *a, float *b)
{
	if (*a > *b) {
		float tmp = *a;
		*a = *b;
		*b = tmp;
	}
}

void pixsort2(float2 *a, float2 *b)
{
	float2 t1 = *a;
	float2 t2 = *b;
	*a = min(t1, t2);
	*b = max(t1, t2);
}

#ifdef Kernel
__kernel void rawNoiseKernel(__global  float * dst,
                             __global  float * src,
                             const     unsigned short grx,
                             const     unsigned short gry,
                             const     float thresh,
                             const     float limit,
                             const     unsigned int rowWords,
                             const     unsigned int doMedian)
{
	int x = get_global_id(0);
	int y = get_global_id(1);

	const unsigned int offset = x + y * rowWords;
	bool isRedBlue = ((y + (grx ^ gry) + x) & 1) != 0;
	float minv;
	float maxv;

	if (isRedBlue) {					// is red/blue pixel
		minv = maxv = src[offset - (2 * rowWords)];
		maxv = max(maxv, src[offset - (2 * rowWords) - 2]);
		minv = min(minv, src[offset - (2 * rowWords) - 2]);
		maxv = max(maxv, src[offset - (2 * rowWords) + 2]);
		minv = min(minv, src[offset - (2 * rowWords) + 2]);
		maxv = max(maxv, src[offset - 2]);
		minv = min(minv, src[offset - 2]);
		maxv = max(maxv, src[offset + 2]);
		minv = min(minv, src[offset + 2]);
		maxv = max(maxv, src[offset + (2 * rowWords) - 2]);
		minv = min(minv, src[offset + (2 * rowWords) - 2]);
		maxv = max(maxv, src[offset + (2 * rowWords)]);
		minv = min(minv, src[offset + (2 * rowWords)]);
		maxv = max(maxv, src[offset + (2 * rowWords) + 2]);
		minv = min(minv, src[offset + (2 * rowWords) + 2]);
	}
	else {													// is green pixel
		minv = maxv = src[offset - (2 * rowWords)];
		maxv = max(maxv, src[offset - (rowWords) - 1]);
		minv = min(minv, src[offset - (rowWords) - 1]);
		maxv = max(maxv, src[offset - (rowWords) + 1]);
		minv = min(minv, src[offset - (rowWords) + 1]);
		maxv = max(maxv, src[offset - 2]);
		minv = min(minv, src[offset - 2]);
		maxv = max(maxv, src[offset + 2]);
		minv = min(minv, src[offset + 2]);
		maxv = max(maxv, src[offset + (rowWords) - 1]);
		minv = min(minv, src[offset + (rowWords) - 1]);
		maxv = max(maxv, src[offset + (rowWords) + 1]);
		minv = min(minv, src[offset + (rowWords) + 1]);
		maxv = max(maxv, src[offset + (rowWords) + 2]);
		minv = min(minv, src[offset + (rowWords) + 2]);

	}
	dst[offset] = (src[offset] > maxv) ? maxv : src[offset];
	dst[offset] = (src[offset] < minv) ? minv : src[offset];

	if (doMedian == 0) {
		dst[offset] = (src[offset] > maxv) ? maxv : src[offset];
		dst[offset] = (dst[offset] < minv) ? minv : dst[offset];
		return;
	}
	else {
		src[offset] = (src[offset] > maxv) ? maxv : src[offset];
		src[offset] = (src[offset] < minv) ? minv : src[offset];
	}
	// median

	if (isRedBlue)	// dont do red/blue, the green pixel will handle them
		return;

	float pixels[9];

	pixels[0] = src[offset - 2 * rowWords];
	pixels[1] = src[offset - rowWords - 1];
	pixels[2] = src[offset - rowWords + 1];
	pixels[3] = src[offset - 2];
	pixels[4] = src[offset];
	pixels[5] = src[offset + 2];
	pixels[6] = src[offset + rowWords - 1];
	pixels[7] = src[offset + rowWords + 1];
	pixels[8] = src[offset + 2 * rowWords];

	pixsort(&pixels[1], &pixels[2]);
	pixsort(&pixels[4], &pixels[5]);
	pixsort(&pixels[7], &pixels[8]);
	pixsort(&pixels[0], &pixels[1]);
	pixsort(&pixels[3], &pixels[4]);
	pixsort(&pixels[6], &pixels[7]);
	pixsort(&pixels[1], &pixels[2]);
	pixsort(&pixels[4], &pixels[5]);
	pixsort(&pixels[7], &pixels[8]);
	pixsort(&pixels[0], &pixels[3]);
	pixsort(&pixels[5], &pixels[8]);
	pixsort(&pixels[4], &pixels[7]);
	pixsort(&pixels[3], &pixels[6]);
	pixsort(&pixels[1], &pixels[4]);
	pixsort(&pixels[2], &pixels[5]);
	pixsort(&pixels[4], &pixels[7]);
	pixsort(&pixels[4], &pixels[2]);
	pixsort(&pixels[6], &pixels[4]);
	pixsort(&pixels[4], &pixels[2]);	// median in 4
	pixsort(&pixels[0], &pixels[3]);	// min to 0
	pixsort(&pixels[5], &pixels[8]);	// max to 8

	float delta = (pixels[8] - pixels[0]);
	if (delta < thresh) {
		if (delta < limit)
			delta = limit;
		float blend = delta / thresh;
		dst[offset] = ((1.0f - blend) * pixels[4]) + (blend * src[offset]);

		// red/blue
		pixels[0] = src[offset - 2 * rowWords - 1];
		pixels[1] = src[offset - 2 * rowWords + 1];
		pixels[2] = src[offset - 2 * rowWords + 3];
		pixels[3] = src[offset - 1];
		pixels[4] = src[offset + 1];
		pixels[5] = src[offset + 3];
		pixels[6] = src[offset + 2 * rowWords - 1];
		pixels[7] = src[offset + 2 * rowWords + 1];
		pixels[8] = src[offset + 2 * rowWords + 3];


		pixsort(&pixels[1], &pixels[2]);
		pixsort(&pixels[4], &pixels[5]);
		pixsort(&pixels[7], &pixels[8]);
		pixsort(&pixels[0], &pixels[1]);
		pixsort(&pixels[3], &pixels[4]);
		pixsort(&pixels[6], &pixels[7]);
		pixsort(&pixels[1], &pixels[2]);
		pixsort(&pixels[4], &pixels[5]);
		pixsort(&pixels[7], &pixels[8]);
		pixsort(&pixels[0], &pixels[3]);
		pixsort(&pixels[5], &pixels[8]);
		pixsort(&pixels[4], &pixels[7]);
		pixsort(&pixels[3], &pixels[6]);
		pixsort(&pixels[1], &pixels[4]);
		pixsort(&pixels[2], &pixels[5]);
		pixsort(&pixels[4], &pixels[7]);
		pixsort(&pixels[4], &pixels[2]);
		pixsort(&pixels[6], &pixels[4]);
		pixsort(&pixels[4], &pixels[2]);	// median in 4
		pixsort(&pixels[0], &pixels[3]);	// min to 0
		pixsort(&pixels[5], &pixels[8]);	// max to 8

		delta = (pixels[7] - pixels[0]);
		if (delta < thresh) {
			if (delta < limit)
				delta = limit;
			float blend = delta / thresh;
			dst[offset + 1] = ((1.0f - blend) * pixels[4]) + (blend * src[offset + 1]);
		}
	}
	else {
		dst[offset] = src[offset];
		dst[offset + 1] = src[offset + 1];
	}
}
#endif



 void loadLDS(__local float *pixels, __global float const *src, const int lrp, const int rowPixels, const int size, const int pad, const int globalWidth, const int globalHeight, const int groupId, const int workGroupSize) {
	const int lsize = lrp * lrp;
	int srcx = get_group_id(0) * size - pad;
	int srcy = get_group_id(1) * size - pad;
    int loadOffset = groupId;

	while (loadOffset < lsize) {
		int x = srcx + (loadOffset % lrp);
		int y = srcy + (loadOffset / lrp);
		x = (x < 0) ? -x : x;
		x = (x >= globalWidth) ? (2 * (globalWidth - 1) - x) : x;
		y = (y < 0) ? -y : y;
		y = (y >= globalHeight) ? (2 * (globalHeight - 1) - y) : y;
		//pixels[loadOffset] = (float)(src[x + y * rowPixels]) * 1.0f / 16383.0f;
		pixels[loadOffset] = src[x + y * rowPixels];
		loadOffset += workGroupSize;
	}
}

 void loadLDSShort(__local float *pixels, __global unsigned short const *src, const int lrp, const int rowPixels, const int size, const int pad, const int globalWidth, const int globalHeight, const int groupId, const int workGroupSize) {
	const int lsize = lrp * lrp;
	int srcx = get_group_id(0) * size - pad;
	int srcy = get_group_id(1) * size - pad;
    int loadOffset = groupId;

	while (loadOffset < lsize) {
		int x = srcx + (loadOffset % lrp);
		int y = srcy + (loadOffset / lrp);
		x = (x < 0) ? -x : x;
		x = (x >= globalWidth) ? (2 * (globalWidth - 1) - x) : x;
		y = (y < 0) ? -y : y;
		y = (y >= globalHeight) ? (2 * (globalHeight - 1) - y) : y;
		pixels[loadOffset] = (float)(src[x + y * rowPixels]) * 1.0f / 16383.0f;
		//pixels[loadOffset] = src[x + y * rowPixels];
		loadOffset += workGroupSize;
	}
}

 #ifdef Kernel16
 __kernel __attribute__((reqd_work_group_size(16, 16, 1))) void rawNoiseKernel(__global float *dst,
						__global  float const *src,
						const	unsigned short grx,
						const	unsigned short gry,
						const	float thresh,
						const	float limit,
						const	unsigned int rowPixels,
						const	unsigned int doMedian,
						const	unsigned int sourceFormat)

{
    const int size = 32;
    const int pad = 2;
    const int lrp = 36;     // local row pixels

	__local float pixels[36 * 36];

	const int localx = get_local_id(0);
	const int localy = get_local_id(1);
	const int x = get_global_id(0);
	const int y = get_global_id(1);
    const int groupId = localx + localy * size / 2;
    const int localOffset = (localx * 2 + pad) + (localy * 2 + pad) * lrp;

    int globalWidth = get_global_size(0) * 2;		// FIXME: this should be src row pixels
    int globalHeight = get_global_size(1) * 2;

	if (sourceFormat == 0)
		loadLDS(pixels, src, lrp, rowPixels, size, pad, globalWidth, globalHeight, groupId, 256);
	else
		loadLDSShort(pixels, (__global unsigned short *)(src), lrp, rowPixels, size, pad, globalWidth, globalHeight, groupId, 256);

    barrier(CLK_LOCAL_MEM_FENCE);

	bool isRedBlue = ((y + (grx ^ gry) + x) & 1) != 0;
	float2 minv, maxv;

	//
	// Do the 2 color pixels
	//

	int p1 = isRedBlue ? localOffset : localOffset + 1;
	int p2 = p1 + lrp + (isRedBlue ? 1 : -1);

	minv = maxv = (float2)(pixels[p1 - 2 * lrp - 2], pixels[p2 - 2 * lrp - 2]);
	maxv = max(maxv, (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]));
	minv = min(minv, (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]));
	maxv = max(maxv, (float2)(pixels[p1 - 2 * lrp + 2], pixels[p2 - 2 * lrp + 2]));
	minv = min(minv, (float2)(pixels[p1 - 2 * lrp + 2], pixels[p2 - 2 * lrp + 2]));

	maxv = max(maxv, (float2)(pixels[p1 - 2], pixels[p2 - 2]));
	minv = min(minv, (float2)(pixels[p1 - 2], pixels[p2 - 2]));
	//maxv = max(maxv, (float2)(pixels[p1], pixels[p2]));		// original value
	//minv = min(minv, (float2)(pixels[p1], pixels[p2]));		// original value
	maxv = max(maxv, (float2)(pixels[p1 + 2], pixels[p2 + 2]));
	minv = min(minv, (float2)(pixels[p1 + 2], pixels[p2 + 2]));

	maxv = max(maxv, (float2)(pixels[p1 + 2 * lrp - 2], pixels[p2 + 2 * lrp - 2]));
	minv = min(minv, (float2)(pixels[p1 + 2 * lrp - 2], pixels[p2 + 2 * lrp - 2]));
	maxv = max(maxv, (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]));
	minv = min(minv, (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]));
	maxv = max(maxv, (float2)(pixels[p1 + 2 * lrp + 2], pixels[p2 + 2 * lrp + 2]));
	minv = min(minv, (float2)(pixels[p1 + 2 * lrp + 2], pixels[p2 + 2 * lrp + 2]));

	pixels[p1] = (pixels[p1] > maxv.x) ? maxv.x : pixels[p1];
	pixels[p1] = (pixels[p1] < minv.x) ? minv.x : pixels[p1];
	pixels[p2] = (pixels[p2] > maxv.y) ? maxv.y : pixels[p2];
	pixels[p2] = (pixels[p2] < minv.y) ? minv.y : pixels[p2];

	//
	// Do the 2 green pixels
	//

	p1 = isRedBlue ? localOffset + 1 : localOffset;
	p2 = p1 + lrp + (isRedBlue ? -1 : 1);

	minv = maxv = (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]);
	maxv = max(maxv, (float2)(pixels[p1 - lrp - 1], pixels[p2 - lrp - 1]));
	minv = min(minv, (float2)(pixels[p1 - lrp - 1], pixels[p2 - lrp - 1]));
	maxv = max(maxv, (float2)(pixels[p1 - lrp + 1], pixels[p2 - lrp + 1]));
	minv = min(minv, (float2)(pixels[p1 - lrp + 1], pixels[p2 - lrp + 1]));

	maxv = max(maxv, (float2)(pixels[p1 - 2], pixels[p2 - 2]));
	minv = min(minv, (float2)(pixels[p1 - 2], pixels[p2 - 2]));
	//maxv = max(maxv, (float2)(pixels[p1], pixels[p2]));		// original value
	//minv = min(minv, (float2)(pixels[p1], pixels[p2]));		// original value
	maxv = max(maxv, (float2)(pixels[p1 + 2], pixels[p2 + 2]));
	minv = min(minv, (float2)(pixels[p1 + 2], pixels[p2 + 2]));

	maxv = max(maxv, (float2)(pixels[p1 + lrp - 1], pixels[p2 + lrp - 1]));
	minv = min(minv, (float2)(pixels[p1 + lrp - 1], pixels[p2 + lrp - 1]));
	maxv = max(maxv, (float2)(pixels[p1 + lrp + 1], pixels[p2 + lrp + 1]));
	minv = min(minv, (float2)(pixels[p1 + lrp + 1], pixels[p2 + lrp + 1]));
	maxv = max(maxv, (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]));
	minv = min(minv, (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]));

	pixels[p1] = (pixels[p1] > maxv.x) ? maxv.x : pixels[p1];
	pixels[p1] = (pixels[p1] < minv.x) ? minv.x : pixels[p1];
	pixels[p2] = (pixels[p2] > maxv.y) ? maxv.y : pixels[p2];
	pixels[p2] = (pixels[p2] < minv.y) ? minv.y : pixels[p2];

	barrier(CLK_LOCAL_MEM_FENCE);


	if (doMedian == 1) {

		// Median the green channels
		float2 pix[9];
		p1 = isRedBlue ? localOffset + 1 : localOffset;
		p2 = p1 + lrp + (isRedBlue ? -1 : 1);

		pix[0] = (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]);
		pix[1] = (float2)(pixels[p1 - lrp - 1], pixels[p2 - lrp - 1]);
		pix[2] = (float2)(pixels[p1 - lrp + 1], pixels[p2 - lrp + 1]);
		pix[3] = (float2)(pixels[p1 - 2], pixels[p2 - 2]);
		pix[4] = (float2)(pixels[p1], pixels[p2]);
		pix[5] = (float2)(pixels[p1 + 2], pixels[p2 + 2]);
		pix[6] = (float2)(pixels[p1 + lrp - 1], pixels[p2 + lrp - 1]);
		pix[7] = (float2)(pixels[p1 + lrp + 1], pixels[p2 + lrp + 1]);
		pix[8] = (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]);

		pixsort2(&pix[1], &pix[2]);
		pixsort2(&pix[4], &pix[5]);
		pixsort2(&pix[7], &pix[8]);
		pixsort2(&pix[0], &pix[1]);
		pixsort2(&pix[3], &pix[4]);
		pixsort2(&pix[6], &pix[7]);
		pixsort2(&pix[1], &pix[2]);
		pixsort2(&pix[4], &pix[5]);
		pixsort2(&pix[7], &pix[8]);
		pixsort2(&pix[0], &pix[3]);
		pixsort2(&pix[5], &pix[8]);
		pixsort2(&pix[4], &pix[7]);
		pixsort2(&pix[3], &pix[6]);
		pixsort2(&pix[1], &pix[4]);
		pixsort2(&pix[2], &pix[5]);
		pixsort2(&pix[4], &pix[7]);
		pixsort2(&pix[4], &pix[2]);
		pixsort2(&pix[6], &pix[4]);
		pixsort2(&pix[4], &pix[2]);	// median in 4
		pixsort2(&pix[0], &pix[3]);	// min to 0
		pixsort2(&pix[5], &pix[8]);	// max to 8

		float2 delta = pix[8] - pix[0];
		delta = max(delta, limit);
		delta = delta / thresh;		// delta is now "blend"
		delta = min(delta, 1.0f);
		pixels[p1] = (1.0f - delta.x) * pix[4].x + delta.x * pixels[p1];
		pixels[p2] = (1.0f - delta.y) * pix[4].y + delta.y * pixels[p2];

		delta = pix[8] - pix[0];
		if (delta.x + delta.y < 2.0f * thresh) {	// Only do color if green was altered
			p1 = isRedBlue ? localOffset : localOffset + 1;
			p2 = p1 + lrp + (isRedBlue ? 1 : -1);

			pix[0] = (float2)(pixels[p1 - 2 * lrp - 2], pixels[p2 - 2 * lrp - 2]);
			pix[1] = (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]);
			pix[2] = (float2)(pixels[p1 - 2 * lrp + 2], pixels[p2 - 2 * lrp + 2]);
			pix[3] = (float2)(pixels[p1 - 2], pixels[p2 - 2]);
			pix[4] = (float2)(pixels[p1], pixels[p2]);
			pix[5] = (float2)(pixels[p1 + 2], pixels[p2 + 2]);
			pix[6] = (float2)(pixels[p1 + 2 * lrp - 2], pixels[p2 + 2 * lrp - 2]);
			pix[7] = (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]);
			pix[8] = (float2)(pixels[p1 + 2 * lrp + 2], pixels[p2 + 2 * lrp + 2]);

			pixsort2(&pix[1], &pix[2]);
			pixsort2(&pix[4], &pix[5]);
			pixsort2(&pix[7], &pix[8]);
			pixsort2(&pix[0], &pix[1]);
			pixsort2(&pix[3], &pix[4]);
			pixsort2(&pix[6], &pix[7]);
			pixsort2(&pix[1], &pix[2]);
			pixsort2(&pix[4], &pix[5]);
			pixsort2(&pix[7], &pix[8]);
			pixsort2(&pix[0], &pix[3]);
			pixsort2(&pix[5], &pix[8]);
			pixsort2(&pix[4], &pix[7]);
			pixsort2(&pix[3], &pix[6]);
			pixsort2(&pix[1], &pix[4]);
			pixsort2(&pix[2], &pix[5]);
			pixsort2(&pix[4], &pix[7]);
			pixsort2(&pix[4], &pix[2]);
			pixsort2(&pix[6], &pix[4]);
			pixsort2(&pix[4], &pix[2]);	// median in 4
			pixsort2(&pix[0], &pix[3]);	// min to 0
			pixsort2(&pix[5], &pix[8]);	// max to 8

			float2 delta = pix[8] - pix[0];
			delta = max(delta, limit);
			delta = delta / thresh;		// delta is now "blend"
			delta = min(delta, 1.0f);
			pixels[p1] = (1.0f - delta.x) * pix[4].x + delta.x * pixels[p1];
			pixels[p2] = (1.0f - delta.y) * pix[4].y + delta.y * pixels[p2];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	if ((x + 1 < globalWidth) && (y + 1 < globalHeight)) {
		int offset = get_global_id(0) * 2 + get_global_id(1) * 2 * rowPixels;
		dst[offset] = pixels[localOffset];
		dst[offset + 1] = pixels[localOffset + 1];
		dst[offset + rowPixels] = pixels[localOffset + lrp];
		dst[offset + rowPixels + 1] = pixels[localOffset + lrp + 1];
	}
}
#endif



#ifdef Kernel8
 __kernel __attribute__((reqd_work_group_size(8, 8, 1))) void rawNoiseKernel(__global float *dst,
						__global  float const *src,
						const	unsigned short grx,
						const	unsigned short gry,
						const	float thresh,
						const	float limit,
						const	unsigned int rowPixels,
						const	unsigned int doMedian,
						const	unsigned int sourceFormat)

{
    const int size = 16;
    const int pad = 2;
    const int lrp = 20;     // local row pixels

	__local float pixels[20 * 20];

	const int localx = get_local_id(0);
	const int localy = get_local_id(1);
	const int x = get_global_id(0);
	const int y = get_global_id(1);
    const int groupId = localx + localy * size / 2;
    const int localOffset = (localx * 2 + pad) + (localy * 2 + pad) * lrp;

    int globalWidth = get_global_size(0) * 2;		// FIXME: this should be src row pixels
    int globalHeight = get_global_size(1) * 2;

	if (sourceFormat == 0)
		loadLDS(pixels, src, lrp, rowPixels, size, pad, globalWidth, globalHeight, groupId, 64);
	else
		loadLDSShort(pixels, (__global unsigned short *)(src), lrp, rowPixels, size, pad, globalWidth, globalHeight, groupId, 64);

    barrier(CLK_LOCAL_MEM_FENCE);

	bool isRedBlue = ((y + (grx ^ gry) + x) & 1) != 0;
	float2 minv, maxv;

	//
	// Do the 2 color pixels
	//

	int p1 = isRedBlue ? localOffset : localOffset + 1;
	int p2 = p1 + lrp + (isRedBlue ? 1 : -1);

	minv = maxv = (float2)(pixels[p1 - 2 * lrp - 2], pixels[p2 - 2 * lrp - 2]);
	maxv = max(maxv, (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]));
	minv = min(minv, (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]));
	maxv = max(maxv, (float2)(pixels[p1 - 2 * lrp + 2], pixels[p2 - 2 * lrp + 2]));
	minv = min(minv, (float2)(pixels[p1 - 2 * lrp + 2], pixels[p2 - 2 * lrp + 2]));

	maxv = max(maxv, (float2)(pixels[p1 - 2], pixels[p2 - 2]));
	minv = min(minv, (float2)(pixels[p1 - 2], pixels[p2 - 2]));
	//maxv = max(maxv, (float2)(pixels[p1], pixels[p2]));		// original value
	//minv = min(minv, (float2)(pixels[p1], pixels[p2]));		// original value
	maxv = max(maxv, (float2)(pixels[p1 + 2], pixels[p2 + 2]));
	minv = min(minv, (float2)(pixels[p1 + 2], pixels[p2 + 2]));

	maxv = max(maxv, (float2)(pixels[p1 + 2 * lrp - 2], pixels[p2 + 2 * lrp - 2]));
	minv = min(minv, (float2)(pixels[p1 + 2 * lrp - 2], pixels[p2 + 2 * lrp - 2]));
	maxv = max(maxv, (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]));
	minv = min(minv, (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]));
	maxv = max(maxv, (float2)(pixels[p1 + 2 * lrp + 2], pixels[p2 + 2 * lrp + 2]));
	minv = min(minv, (float2)(pixels[p1 + 2 * lrp + 2], pixels[p2 + 2 * lrp + 2]));

	pixels[p1] = (pixels[p1] > maxv.x) ? maxv.x : pixels[p1];
	pixels[p1] = (pixels[p1] < minv.x) ? minv.x : pixels[p1];
	pixels[p2] = (pixels[p2] > maxv.y) ? maxv.y : pixels[p2];
	pixels[p2] = (pixels[p2] < minv.y) ? minv.y : pixels[p2];

	//
	// Do the 2 green pixels
	//

	p1 = isRedBlue ? localOffset + 1 : localOffset;
	p2 = p1 + lrp + (isRedBlue ? -1 : 1);

	minv = maxv = (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]);
	maxv = max(maxv, (float2)(pixels[p1 - lrp - 1], pixels[p2 - lrp - 1]));
	minv = min(minv, (float2)(pixels[p1 - lrp - 1], pixels[p2 - lrp - 1]));
	maxv = max(maxv, (float2)(pixels[p1 - lrp + 1], pixels[p2 - lrp + 1]));
	minv = min(minv, (float2)(pixels[p1 - lrp + 1], pixels[p2 - lrp + 1]));

	maxv = max(maxv, (float2)(pixels[p1 - 2], pixels[p2 - 2]));
	minv = min(minv, (float2)(pixels[p1 - 2], pixels[p2 - 2]));
	//maxv = max(maxv, (float2)(pixels[p1], pixels[p2]));		// original value
	//minv = min(minv, (float2)(pixels[p1], pixels[p2]));		// original value
	maxv = max(maxv, (float2)(pixels[p1 + 2], pixels[p2 + 2]));
	minv = min(minv, (float2)(pixels[p1 + 2], pixels[p2 + 2]));

	maxv = max(maxv, (float2)(pixels[p1 + lrp - 1], pixels[p2 + lrp - 1]));
	minv = min(minv, (float2)(pixels[p1 + lrp - 1], pixels[p2 + lrp - 1]));
	maxv = max(maxv, (float2)(pixels[p1 + lrp + 1], pixels[p2 + lrp + 1]));
	minv = min(minv, (float2)(pixels[p1 + lrp + 1], pixels[p2 + lrp + 1]));
	maxv = max(maxv, (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]));
	minv = min(minv, (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]));

	pixels[p1] = (pixels[p1] > maxv.x) ? maxv.x : pixels[p1];
	pixels[p1] = (pixels[p1] < minv.x) ? minv.x : pixels[p1];
	pixels[p2] = (pixels[p2] > maxv.y) ? maxv.y : pixels[p2];
	pixels[p2] = (pixels[p2] < minv.y) ? minv.y : pixels[p2];

	barrier(CLK_LOCAL_MEM_FENCE);


	if (doMedian == 1) {

		// Median the green channels
		float2 pix[9];
		p1 = isRedBlue ? localOffset + 1 : localOffset;
		p2 = p1 + lrp + (isRedBlue ? -1 : 1);

		pix[0] = (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]);
		pix[1] = (float2)(pixels[p1 - lrp - 1], pixels[p2 - lrp - 1]);
		pix[2] = (float2)(pixels[p1 - lrp + 1], pixels[p2 - lrp + 1]);
		pix[3] = (float2)(pixels[p1 - 2], pixels[p2 - 2]);
		pix[4] = (float2)(pixels[p1], pixels[p2]);
		pix[5] = (float2)(pixels[p1 + 2], pixels[p2 + 2]);
		pix[6] = (float2)(pixels[p1 + lrp - 1], pixels[p2 + lrp - 1]);
		pix[7] = (float2)(pixels[p1 + lrp + 1], pixels[p2 + lrp + 1]);
		pix[8] = (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]);

		pixsort2(&pix[1], &pix[2]);
		pixsort2(&pix[4], &pix[5]);
		pixsort2(&pix[7], &pix[8]);
		pixsort2(&pix[0], &pix[1]);
		pixsort2(&pix[3], &pix[4]);
		pixsort2(&pix[6], &pix[7]);
		pixsort2(&pix[1], &pix[2]);
		pixsort2(&pix[4], &pix[5]);
		pixsort2(&pix[7], &pix[8]);
		pixsort2(&pix[0], &pix[3]);
		pixsort2(&pix[5], &pix[8]);
		pixsort2(&pix[4], &pix[7]);
		pixsort2(&pix[3], &pix[6]);
		pixsort2(&pix[1], &pix[4]);
		pixsort2(&pix[2], &pix[5]);
		pixsort2(&pix[4], &pix[7]);
		pixsort2(&pix[4], &pix[2]);
		pixsort2(&pix[6], &pix[4]);
		pixsort2(&pix[4], &pix[2]);	// median in 4
		pixsort2(&pix[0], &pix[3]);	// min to 0
		pixsort2(&pix[5], &pix[8]);	// max to 8

		float2 delta = pix[8] - pix[0];
		delta = max(delta, limit);
		delta = delta / thresh;		// delta is now "blend"
		delta = min(delta, 1.0f);
		pixels[p1] = (1.0f - delta.x) * pix[4].x + delta.x * pixels[p1];
		pixels[p2] = (1.0f - delta.y) * pix[4].y + delta.y * pixels[p2];

		delta = pix[8] - pix[0];
		if (delta.x + delta.y < 2.0f * thresh) {	// Only do color if green was altered
			p1 = isRedBlue ? localOffset : localOffset + 1;
			p2 = p1 + lrp + (isRedBlue ? 1 : -1);

			pix[0] = (float2)(pixels[p1 - 2 * lrp - 2], pixels[p2 - 2 * lrp - 2]);
			pix[1] = (float2)(pixels[p1 - 2 * lrp], pixels[p2 - 2 * lrp]);
			pix[2] = (float2)(pixels[p1 - 2 * lrp + 2], pixels[p2 - 2 * lrp + 2]);
			pix[3] = (float2)(pixels[p1 - 2], pixels[p2 - 2]);
			pix[4] = (float2)(pixels[p1], pixels[p2]);
			pix[5] = (float2)(pixels[p1 + 2], pixels[p2 + 2]);
			pix[6] = (float2)(pixels[p1 + 2 * lrp - 2], pixels[p2 + 2 * lrp - 2]);
			pix[7] = (float2)(pixels[p1 + 2 * lrp], pixels[p2 + 2 * lrp]);
			pix[8] = (float2)(pixels[p1 + 2 * lrp + 2], pixels[p2 + 2 * lrp + 2]);

			pixsort2(&pix[1], &pix[2]);
			pixsort2(&pix[4], &pix[5]);
			pixsort2(&pix[7], &pix[8]);
			pixsort2(&pix[0], &pix[1]);
			pixsort2(&pix[3], &pix[4]);
			pixsort2(&pix[6], &pix[7]);
			pixsort2(&pix[1], &pix[2]);
			pixsort2(&pix[4], &pix[5]);
			pixsort2(&pix[7], &pix[8]);
			pixsort2(&pix[0], &pix[3]);
			pixsort2(&pix[5], &pix[8]);
			pixsort2(&pix[4], &pix[7]);
			pixsort2(&pix[3], &pix[6]);
			pixsort2(&pix[1], &pix[4]);
			pixsort2(&pix[2], &pix[5]);
			pixsort2(&pix[4], &pix[7]);
			pixsort2(&pix[4], &pix[2]);
			pixsort2(&pix[6], &pix[4]);
			pixsort2(&pix[4], &pix[2]);	// median in 4
			pixsort2(&pix[0], &pix[3]);	// min to 0
			pixsort2(&pix[5], &pix[8]);	// max to 8

			float2 delta = pix[8] - pix[0];
			delta = max(delta, limit);
			delta = delta / thresh;		// delta is now "blend"
			delta = min(delta, 1.0f);
			pixels[p1] = (1.0f - delta.x) * pix[4].x + delta.x * pixels[p1];
			pixels[p2] = (1.0f - delta.y) * pix[4].y + delta.y * pixels[p2];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	if ((x + 1 < globalWidth) && (y + 1 < globalHeight)) {
		int offset = get_global_id(0) * 2 + get_global_id(1) * 2 * rowPixels;
		dst[offset] = pixels[localOffset];
		dst[offset + 1] = pixels[localOffset + 1];
		dst[offset + rowPixels] = pixels[localOffset + lrp];
		dst[offset + rowPixels + 1] = pixels[localOffset + lrp + 1];
	}
}
#endif






// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
