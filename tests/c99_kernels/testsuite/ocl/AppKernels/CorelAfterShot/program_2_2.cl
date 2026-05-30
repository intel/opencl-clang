
//#pragma OPENCL EXTENSION cl_amd_printf : enable



 void loadLDS(__local float *pixels, __global float const *src, const int lrp, const int rowPixels, const int size, const int pad, const int globalWidth, const int globalHeight, const int srcx, const int srcy, const int groupId, const int workGroupSize) {
	const int lsize = lrp * lrp;
    int loadOffset = groupId;

	while (loadOffset < lsize) {
		int x = srcx + (loadOffset % lrp) + pad;
		int y = srcy + (loadOffset / lrp) + pad;
		x = (x < 0) ? -x : x;
		x = (x >= globalWidth) ? (2 * (globalWidth - 1) - x) : x;
		y = (y < 0) ? -y : y;
		y = (y >= globalHeight) ? (2 * (globalHeight - 1) - y) : y;
		//pixels[loadOffset] = (float)(src[x + y * rowPixels]) * 1.0f / 16383.0f;
		pixels[loadOffset] = src[x + y * rowPixels];
		loadOffset += workGroupSize;
	}
}

 void loadLDSShort(__local float *pixels, __global unsigned short const *src, const int lrp, const int rowPixels, const int size, const int pad, const int globalWidth, const int globalHeight, const int srcx, const int srcy, const int groupId, const int workGroupSize) {
	const int lsize = lrp * lrp;
    int loadOffset = groupId;

	while (loadOffset < lsize) {
		int x = srcx + (loadOffset % lrp) + pad;
		int y = srcy + (loadOffset / lrp) + pad;
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
__kernel __attribute__((reqd_work_group_size(16, 16, 1))) void demosaicKernel(__global float *dst,
							__global  float *src,
							const unsigned int grx,
							const unsigned int gry,
							const float threshold,
							const unsigned int srcRowPixels,
							const unsigned int dstRowPixels,
							const unsigned int dstPlanePixels,
							const unsigned int sourceFormat,
							const unsigned int destFormat)

{
    const int size = 32;		// Processing size
	const int outSize = 26;		// Output size (padding is partially processed but not written out)
    const int pad = 2;
    const int lrp = 36;     // local row pixels

    __local float pixels[36 * 36];
	__local float xgrads[36 * 36];
	__local float ygrads[36 * 36];
	__local float greens[36 * 36];

    const int localx = get_local_id(0);
    const int localy = get_local_id(1);
    const int groupId = localx + localy * size / 2;

    const int globalWidth = (get_global_size(0) * 2 * outSize) / size;
    const int globalHeight = (get_global_size(1) * 2 * outSize) / size;

    int srcx = get_group_id(0) * outSize - pad - grx;	// always a green at 0,0 on a red line
    int srcy = get_group_id(1) * outSize - pad - gry;

	if (sourceFormat == 0)
		loadLDS(pixels, src, lrp, srcRowPixels, size, pad, globalWidth, globalHeight, srcx, srcy, groupId, 256);
	else
		loadLDSShort(pixels, (__global unsigned short *)(src), lrp, srcRowPixels, size, pad, globalWidth, globalHeight, srcx, srcy, groupId, 256);

    barrier(CLK_LOCAL_MEM_FENCE);

	const int x_src = (localx * 2) + pad;	// x position in the (lds) src data
	const int y_src = (localy * 2) + pad;	// x position in the (lds) src data
	const int p_src = x_src + y_src * lrp;

	{
		// Calculate the gradiants

		int p = p_src;
		float dx0 = fabs(pixels[p - 2] * -0.140625f + pixels[p - 1] * 1.26953f + pixels[p + 1] * -1.26953f + pixels[p + 2] * 0.140625f);
		float dx1 = fabs(pixels[p - 1] * -0.140625f + pixels[p] * 1.26953f + pixels[p + 2] * -1.26953f + pixels[p + 3] * 0.140625f);
		float odx0 = fabs(pixels[p] * 2.0f - pixels[p - 1] - pixels[p + 1]);
		float odx1 = fabs(pixels[p + 1] * 2.0f - pixels[p] - pixels[p + 2]);

		float dy0 = fabs(pixels[p - 2 * lrp] * -0.140625f + pixels[p - 1 * lrp] * 1.26953f + pixels[p + 1 * lrp] * -1.26953f + pixels[p + 2 * lrp] * 0.140625f);
		float dy2 = fabs(pixels[p - 1 * lrp] * -0.140625f + pixels[p] * 1.26953f + pixels[p + 2 * lrp] * -1.26953f + pixels[p + 3 * lrp] * 0.140625f);
		float ody0 = fabs(pixels[p] * 2.0f - pixels[p - 1 * lrp] - pixels[p + 1 * lrp]);
		float ody2 = fabs(pixels[p + 1 * lrp] * 2.0f - pixels[p] - pixels[p + 2 * lrp]);
		p += lrp;	// move down a row
		float dx2 = fabs(pixels[p - 2] * -0.140625f + pixels[p - 1] * 1.26953f + pixels[p + 1] * -1.26953f + pixels[p + 2] * 0.140625f);
		float dx3 = fabs(pixels[p - 1] * -0.140625f + pixels[p] * 1.26953f + pixels[p + 2] * -1.26953f + pixels[p + 3] * 0.140625f);
		float odx2 = fabs(pixels[p] * 2.0f - pixels[p - 1] - pixels[p + 1]);
		float odx3 = fabs(pixels[p + 1] * 2.0f - pixels[p] - pixels[p + 2]);
		p -= lrp;
		p += 1;		// move back up and over a column
		float dy1 = fabs(pixels[p - 2 * lrp] * -0.140625f + pixels[p - 1 * lrp] * 1.26953f + pixels[p + 1 * lrp] * -1.26953f + pixels[p + 2 * lrp] * 0.140625f);
		float dy3 = fabs(pixels[p - 1 * lrp] * -0.140625f + pixels[p] * 1.26953f + pixels[p + 2 * lrp] * -1.26953f + pixels[p + 3 * lrp] * 0.140625f);
		float ody1 = fabs(pixels[p] * 2.0f - pixels[p - 1 * lrp] - pixels[p + 1 * lrp]);
		float ody3 = fabs(pixels[p + 1 * lrp] * 2.0f - pixels[p] - pixels[p + 2 * lrp]);
		p -= 1;		// restore p

		const float DERCONST = 800.0f / 16383.0f;

		xgrads[p]					= ((dx0 + dy0) < DERCONST) ? dx0 : dx0 + odx0;
		ygrads[p]					= ((dx0 + dy0) < DERCONST) ? dy0 : dy0 + ody0;
		xgrads[p + 1]				= ((dx1 + dy1) < DERCONST) ? dx1 : dx1 + odx1;
		ygrads[p + 1]				= ((dx1 + dy1) < DERCONST) ? dy1 : dy1 + ody1;
		xgrads[p + lrp]				= ((dx2 + dy2) < DERCONST) ? dx2 : dx2 + odx2;
		ygrads[p + lrp]				= ((dx2 + dy2) < DERCONST) ? dy2 : dy2 + ody2;
		xgrads[p + lrp + 1]			= ((dx3 + dy3) < DERCONST) ? dx3 : dx3 + odx3;
		ygrads[p + lrp + 1]			= ((dx3 + dy3) < DERCONST) ? dy3 : dy3 + ody3;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	{
		// Reduce.  Replace grad data with 3 pixel windowed average values
		float p0 = xgrads[p_src - 1] + xgrads[p_src] + xgrads[p_src + 1];
		float p1 = xgrads[p_src] + xgrads[p_src + 1] + xgrads[p_src + 2];
		float p2 = xgrads[p_src - 1 + lrp] + xgrads[p_src + lrp] + xgrads[p_src + 1 + lrp];
		float p3 = xgrads[p_src + lrp] + xgrads[p_src + 1 + lrp] + xgrads[p_src + 2 + lrp];
		float p4 = ygrads[p_src - lrp] + ygrads[p_src] + ygrads[p_src + lrp];
		float p6 = ygrads[p_src] + ygrads[p_src + lrp] + ygrads[p_src + 2 * lrp];			// yes 6
		float p5 = ygrads[p_src - lrp + 1] + ygrads[p_src + 1] + ygrads[p_src + lrp +1];	// yes 5
		float p7 = ygrads[p_src + 1] + ygrads[p_src + lrp + 1] + ygrads[p_src + 2 * lrp + 1];

		barrier(CLK_LOCAL_MEM_FENCE);

		xgrads[p_src] = p0;
		xgrads[p_src + 1] = p1;
		xgrads[p_src + lrp] = p2;
		xgrads[p_src + lrp + 1] = p3;
		ygrads[p_src] = p4;
		ygrads[p_src + 1] = p5;
		ygrads[p_src + lrp] = p6;
		ygrads[p_src + lrp + 1] = p7;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	{
		// Calculate green pixels

		float xg1 = xgrads[p_src + 1 - lrp] + xgrads[p_src + 1] + xgrads[p_src + 1 + lrp];
		float xg2 = xgrads[p_src] + xgrads[p_src + lrp] + xgrads[p_src + 2 * lrp];
		float yg1 = ygrads[p_src] + ygrads[p_src + 1] + ygrads[p_src + 2];
		float yg2 = ygrads[p_src - 1 + lrp] + ygrads[p_src + lrp] + ygrads[p_src + 2 + lrp];

		// pixel 1
		float h = pixels[p_src] + pixels[p_src + 2];
		float v = pixels[p_src + 1 - lrp] + pixels[p_src + 1 + lrp];
		if (fabs(xg1 - yg1) < threshold) {
			greens[p_src] = pixels[p_src];
			greens[p_src + 1] = (h + v) / 4.0f;
		}
		else if (xg1 > yg1) {
			greens[p_src] = pixels[p_src];
			greens[p_src + 1] = v / 2.0f;
		}
		else {
			greens[p_src] = pixels[p_src];
			greens[p_src + 1] = h / 2.0f;
		}
		// pixel 2
		h = pixels[p_src - 1 + lrp] + pixels[p_src + 1 + lrp];
		v = pixels[p_src] + pixels[p_src + 2 * lrp];
		if (fabs(xg2 - yg2) < threshold) {
			greens[p_src + lrp] = (h + v) / 4.0f;
			greens[p_src + lrp + 1] = pixels[p_src + lrp + 1];
		}
		else if (xg2 > yg2) {
			greens[p_src + lrp] = v / 2.0f;
			greens[p_src + lrp + 1] = pixels[p_src + lrp + 1];
		}
		else {
			greens[p_src + lrp] = h / 2.0f;
			greens[p_src + lrp + 1] = pixels[p_src + lrp + 1];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	{
		// Calculate the red/blue pixels

		// 1 - Non color row
		// 1a - vertical interpolation

		float2 pix_b0r3 = (float2)(
				(greens[p_src] * 2 - greens[p_src - lrp] - greens[p_src + lrp])					// green impulse
				+ (pixels[p_src - lrp] + pixels[p_src + lrp])									// average color
				, (greens[p_src + 1 + lrp] * 2 - greens[p_src + 1] - greens[p_src + 1 + 2 * lrp])
				+ (pixels[p_src + 1] + pixels[p_src + 1 + 2 * lrp])
				);
		pix_b0r3 /= 2.0f;
		pix_b0r3 = max(pix_b0r3, 0.0f);


		// 1b diagonal interpolation
		float2 pix_b1r2 = (float2)(
				pixels[p_src - lrp] + pixels[p_src + 2 - lrp] + pixels[p_src + lrp] + pixels[p_src + lrp + 2]
				, pixels[p_src - 1] + pixels[p_src + 1] + pixels[p_src + 2 * lrp - 1] + pixels[p_src + 2 * lrp + 1]
				);
		pix_b1r2 /= 4.0f;
		float2 h = (float2)(
					2.0f * greens[p_src + 1] - greens[p_src] - greens[p_src + 2]
					, 2.0f * greens[p_src + lrp] - greens[p_src + lrp - 1] - greens[p_src + lrp + 1]
				);
		float2 v = (float2)(
					2.0f * greens[p_src + 1] - greens[p_src + 1 - lrp] - greens[p_src + 1 + lrp]
					, 2.0f * greens[p_src + lrp] - greens[p_src] - greens[p_src + 2 * lrp]
				);

		// figure out blue
		float xg = xgrads[p_src + 1 - lrp] + xgrads[p_src + 1] + xgrads[p_src + 1 + lrp];
		float yg = ygrads[p_src] + ygrads[p_src + 1] + ygrads[p_src + 2];
		if (fabs(xg - yg) < threshold)
			pix_b1r2.x += (h.x + v.x) / 4.0f;
		else if (xg > yg)
			pix_b1r2.x += h.x / 2.0f;
		else
			pix_b1r2.x += v.x / 2.0f;

		// figure out red
		xg = xgrads[p_src] + xgrads[p_src + lrp] + xgrads[p_src + 2 * lrp];
		yg = ygrads[p_src - 1 + lrp] + ygrads[p_src + lrp] + ygrads[p_src + 2 + lrp];
		if (fabs(xg - yg) < threshold)
			pix_b1r2.y += (h.y + v.y) / 4.0f;
		else if (xg > yg)
			pix_b1r2.y += h.y / 2.0f;
		else
			pix_b1r2.y += v.y / 2.0f;

		pix_b1r2 = max(pix_b1r2, 0.0f);

		// 2 - Color row
		// 2a - horizontal interpolation

		float2 pix_b3r0 = (float2)(
				(greens[p_src + 1 + lrp] * 2 - greens[p_src + lrp] - greens[p_src + 2 + lrp])			// green impulse
				+ (pixels[p_src + lrp] + pixels[p_src + lrp + 2])									// average color
				, (greens[p_src] * 2 - greens[p_src - 1] - greens[p_src + 1])
				+ (pixels[p_src - 1] + pixels[p_src + 1])
				);
		pix_b3r0 /= 2.0f;
		pix_b3r0 = max(pix_b3r0, 0.0f);

		barrier(CLK_LOCAL_MEM_FENCE);

		// We want to use the lds to global "unloader" below for simplicity.
		// Rather than allocating an LDS buffer for red and blue just reuse xgrads and ygrads

		xgrads[p_src] = pix_b3r0.y;
		xgrads[p_src + 1] = pixels[p_src + 1];
		xgrads[p_src + lrp] = pix_b1r2.y;
		xgrads[p_src + lrp + 1] = pix_b0r3.y;
		ygrads[p_src] = pix_b0r3.x;
		ygrads[p_src + 1] = pix_b1r2.x;
		ygrads[p_src + lrp] = pixels[p_src + lrp];
		ygrads[p_src + lrp + 1] = pix_b3r0.x;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	int x1 = get_group_id(0) * outSize;
	int x2 = x1 + outSize;
	x2 = min(x2, (int)(dstRowPixels));
	int y1 = get_group_id(1) * outSize;
	int y2 = y1 + outSize;
	y2 = min(y2, (int)(dstRowPixels));

	const int globalX = srcx + pad - 3 + grx + localx * 2;	// global x under our workitem.  3 is half the 32->26 padding
	const int globalY = srcy + pad - 3 + gry + localy * 2;

	if (destFormat == 0) {
		for (int i = 0; i < 2; ++i) {
			for (int j = 0; j < 2; ++j) {
				if (((globalX + i) >= x1) && ((globalX + i) < x2) && ((globalY + j) >= y1) && ((globalY + j) < y2))	{
					// This pixel is inside the output area
					dst[(globalX + i) + (globalY + j) * dstRowPixels] = xgrads[(x_src + i) + (y_src + j) * lrp];
					dst[(globalX + i) + (globalY + j) * dstRowPixels + dstPlanePixels] = greens[(x_src + i) + (y_src + j) * lrp];
					dst[(globalX + i) + (globalY + j) * dstRowPixels + 2 * dstPlanePixels] = ygrads[(x_src + i) + (y_src + j) * lrp];
				}
			}
		}
	}
	else {
		__global unsigned short int *shortDst = (__global unsigned short int *)(dst);
		for (int i = 0; i < 2; ++i) {
			for (int j = 0; j < 2; ++j) {
				if (((globalX + i) >= x1) && ((globalX + i) < x2) && ((globalY + j) >= y1) && ((globalY + j) < y2))	{
					// This pixel is inside the output area
					shortDst[(globalX + i) + (globalY + j) * dstRowPixels] = (unsigned short int)(xgrads[(x_src + i) + (y_src + j) * lrp] * 16383.0f);
					shortDst[(globalX + i) + (globalY + j) * dstRowPixels + dstPlanePixels] = (unsigned short int)(greens[(x_src + i) + (y_src + j) * lrp] * 16383.0f);
					shortDst[(globalX + i) + (globalY + j) * dstRowPixels + 2 * dstPlanePixels] = (unsigned short int)(ygrads[(x_src + i) + (y_src + j) * lrp] * 16383.0f);
				}
			}
		}
	}
}
#endif



#ifdef Kernel8
__kernel __attribute__((reqd_work_group_size(8, 8, 1))) void demosaicKernel(__global float *dst,
							__global  float *src,
							const unsigned int grx,
							const unsigned int gry,
							const float threshold,
							const unsigned int srcRowPixels,
							const unsigned int dstRowPixels,
							const unsigned int dstPlanePixels,
							const unsigned int sourceFormat,
							const unsigned int destFormat)

{
    const int size = 16;		// Processing size
	const int outSize = 10;		// Output size (padding is partially processed but not written out)
    const int pad = 2;
    const int lrp = 20;     // local row pixels

    __local float pixels[20 * 20];
	__local float xgrads[20 * 20];
	__local float ygrads[20 * 20];
	__local float greens[20 * 20];

    int localx = get_local_id(0);
    int localy = get_local_id(1);
    const int groupId = localx + localy * size / 2;

    int globalWidth = (get_global_size(0) * 2 * outSize) / size;
    int globalHeight = (get_global_size(1) * 2 * outSize) / size;

    int srcx = get_group_id(0) * outSize - pad - grx;	// always a green at 0,0 on a red line
    int srcy = get_group_id(1) * outSize - pad - gry;

	if (sourceFormat == 0)
		loadLDS(pixels, src, lrp, srcRowPixels, size, pad, globalWidth, globalHeight, srcx, srcy, groupId, 64);
	else
		loadLDSShort(pixels, (__global unsigned short *)(src), lrp, srcRowPixels, size, pad, globalWidth, globalHeight, srcx, srcy, groupId, 64);

    barrier(CLK_LOCAL_MEM_FENCE);

	const int x_src = (localx * 2) + pad;	// x position in the (lds) src data
	const int y_src = (localy * 2) + pad;	// x position in the (lds) src data
	const int p_src = x_src + y_src * lrp;

	{
		// Calculate the gradiants

		int p = p_src;
		float dx0 = fabs(pixels[p - 2] * -0.140625f + pixels[p - 1] * 1.26953f + pixels[p + 1] * -1.26953f + pixels[p + 2] * 0.140625f);
		float dx1 = fabs(pixels[p - 1] * -0.140625f + pixels[p] * 1.26953f + pixels[p + 2] * -1.26953f + pixels[p + 3] * 0.140625f);
		float odx0 = fabs(pixels[p] * 2.0f - pixels[p - 1] - pixels[p + 1]);
		float odx1 = fabs(pixels[p + 1] * 2.0f - pixels[p] - pixels[p + 2]);

		float dy0 = fabs(pixels[p - 2 * lrp] * -0.140625f + pixels[p - 1 * lrp] * 1.26953f + pixels[p + 1 * lrp] * -1.26953f + pixels[p + 2 * lrp] * 0.140625f);
		float dy2 = fabs(pixels[p - 1 * lrp] * -0.140625f + pixels[p] * 1.26953f + pixels[p + 2 * lrp] * -1.26953f + pixels[p + 3 * lrp] * 0.140625f);
		float ody0 = fabs(pixels[p] * 2.0f - pixels[p - 1 * lrp] - pixels[p + 1 * lrp]);
		float ody2 = fabs(pixels[p + 1 * lrp] * 2.0f - pixels[p] - pixels[p + 2 * lrp]);
		p += lrp;	// move down a row
		float dx2 = fabs(pixels[p - 2] * -0.140625f + pixels[p - 1] * 1.26953f + pixels[p + 1] * -1.26953f + pixels[p + 2] * 0.140625f);
		float dx3 = fabs(pixels[p - 1] * -0.140625f + pixels[p] * 1.26953f + pixels[p + 2] * -1.26953f + pixels[p + 3] * 0.140625f);
		float odx2 = fabs(pixels[p] * 2.0f - pixels[p - 1] - pixels[p + 1]);
		float odx3 = fabs(pixels[p + 1] * 2.0f - pixels[p] - pixels[p + 2]);
		p -= lrp;
		p += 1;		// move back up and over a column
		float dy1 = fabs(pixels[p - 2 * lrp] * -0.140625f + pixels[p - 1 * lrp] * 1.26953f + pixels[p + 1 * lrp] * -1.26953f + pixels[p + 2 * lrp] * 0.140625f);
		float dy3 = fabs(pixels[p - 1 * lrp] * -0.140625f + pixels[p] * 1.26953f + pixels[p + 2 * lrp] * -1.26953f + pixels[p + 3 * lrp] * 0.140625f);
		float ody1 = fabs(pixels[p] * 2.0f - pixels[p - 1 * lrp] - pixels[p + 1 * lrp]);
		float ody3 = fabs(pixels[p + 1 * lrp] * 2.0f - pixels[p] - pixels[p + 2 * lrp]);
		p -= 1;		// restore p

		const float DERCONST = 800.0f / 16383.0f;

		xgrads[p]					= ((dx0 + dy0) < DERCONST) ? dx0 : dx0 + odx0;
		ygrads[p]					= ((dx0 + dy0) < DERCONST) ? dy0 : dy0 + ody0;
		xgrads[p + 1]				= ((dx1 + dy1) < DERCONST) ? dx1 : dx1 + odx1;
		ygrads[p + 1]				= ((dx1 + dy1) < DERCONST) ? dy1 : dy1 + ody1;
		xgrads[p + lrp]				= ((dx2 + dy2) < DERCONST) ? dx2 : dx2 + odx2;
		ygrads[p + lrp]				= ((dx2 + dy2) < DERCONST) ? dy2 : dy2 + ody2;
		xgrads[p + lrp + 1]			= ((dx3 + dy3) < DERCONST) ? dx3 : dx3 + odx3;
		ygrads[p + lrp + 1]			= ((dx3 + dy3) < DERCONST) ? dy3 : dy3 + ody3;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	{
		// Reduce.  Replace grad data with 3 pixel windowed average values
		float p0 = xgrads[p_src - 1] + xgrads[p_src] + xgrads[p_src + 1];
		float p1 = xgrads[p_src] + xgrads[p_src + 1] + xgrads[p_src + 2];
		float p2 = xgrads[p_src - 1 + lrp] + xgrads[p_src + lrp] + xgrads[p_src + 1 + lrp];
		float p3 = xgrads[p_src + lrp] + xgrads[p_src + 1 + lrp] + xgrads[p_src + 2 + lrp];
		float p4 = ygrads[p_src - lrp] + ygrads[p_src] + ygrads[p_src + lrp];
		float p6 = ygrads[p_src] + ygrads[p_src + lrp] + ygrads[p_src + 2 * lrp];			// yes 6
		float p5 = ygrads[p_src - lrp + 1] + ygrads[p_src + 1] + ygrads[p_src + lrp +1];	// yes 5
		float p7 = ygrads[p_src + 1] + ygrads[p_src + lrp + 1] + ygrads[p_src + 2 * lrp + 1];

		barrier(CLK_LOCAL_MEM_FENCE);

		xgrads[p_src] = p0;
		xgrads[p_src + 1] = p1;
		xgrads[p_src + lrp] = p2;
		xgrads[p_src + lrp + 1] = p3;
		ygrads[p_src] = p4;
		ygrads[p_src + 1] = p5;
		ygrads[p_src + lrp] = p6;
		ygrads[p_src + lrp + 1] = p7;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	{
		// Calculate green pixels

		float xg1 = xgrads[p_src + 1 - lrp] + xgrads[p_src + 1] + xgrads[p_src + 1 + lrp];
		float xg2 = xgrads[p_src] + xgrads[p_src + lrp] + xgrads[p_src + 2 * lrp];
		float yg1 = ygrads[p_src] + ygrads[p_src + 1] + ygrads[p_src + 2];
		float yg2 = ygrads[p_src - 1 + lrp] + ygrads[p_src + lrp] + ygrads[p_src + 2 + lrp];

		// pixel 1
		float h = pixels[p_src] + pixels[p_src + 2];
		float v = pixels[p_src + 1 - lrp] + pixels[p_src + 1 + lrp];
		if (fabs(xg1 - yg1) < threshold) {
			greens[p_src] = pixels[p_src];
			greens[p_src + 1] = (h + v) / 4.0f;
		}
		else if (xg1 > yg1) {
			greens[p_src] = pixels[p_src];
			greens[p_src + 1] = v / 2.0f;
		}
		else {
			greens[p_src] = pixels[p_src];
			greens[p_src + 1] = h / 2.0f;
		}
		// pixel 2
		h = pixels[p_src - 1 + lrp] + pixels[p_src + 1 + lrp];
		v = pixels[p_src] + pixels[p_src + 2 * lrp];
		if (fabs(xg2 - yg2) < threshold) {
			greens[p_src + lrp] = (h + v) / 4.0f;
			greens[p_src + lrp + 1] = pixels[p_src + lrp + 1];
		}
		else if (xg2 > yg2) {
			greens[p_src + lrp] = v / 2.0f;
			greens[p_src + lrp + 1] = pixels[p_src + lrp + 1];
		}
		else {
			greens[p_src + lrp] = h / 2.0f;
			greens[p_src + lrp + 1] = pixels[p_src + lrp + 1];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	{
		// Calculate the red/blue pixels

		// 1 - Non color row
		// 1a - vertical interpolation

		float2 pix_b0r3 = (float2)(
				(greens[p_src] * 2 - greens[p_src - lrp] - greens[p_src + lrp])					// green impulse
				+ (pixels[p_src - lrp] + pixels[p_src + lrp])									// average color
				, (greens[p_src + 1 + lrp] * 2 - greens[p_src + 1] - greens[p_src + 1 + 2 * lrp])
				+ (pixels[p_src + 1] + pixels[p_src + 1 + 2 * lrp])
				);
		pix_b0r3 /= 2.0f;
		pix_b0r3 = max(pix_b0r3, 0.0f);


		// 1b diagonal interpolation
		float2 pix_b1r2 = (float2)(
				pixels[p_src - lrp] + pixels[p_src + 2 - lrp] + pixels[p_src + lrp] + pixels[p_src + lrp + 2]
				, pixels[p_src - 1] + pixels[p_src + 1] + pixels[p_src + 2 * lrp - 1] + pixels[p_src + 2 * lrp + 1]
				);
		pix_b1r2 /= 4.0f;
		float2 h = (float2)(
					2.0f * greens[p_src + 1] - greens[p_src] - greens[p_src + 2]
					, 2.0f * greens[p_src + lrp] - greens[p_src + lrp - 1] - greens[p_src + lrp + 1]
				);
		float2 v = (float2)(
					2.0f * greens[p_src + 1] - greens[p_src + 1 - lrp] - greens[p_src + 1 + lrp]
					, 2.0f * greens[p_src + lrp] - greens[p_src] - greens[p_src + 2 * lrp]
				);

		// figure out blue
		float xg = xgrads[p_src + 1 - lrp] + xgrads[p_src + 1] + xgrads[p_src + 1 + lrp];
		float yg = ygrads[p_src] + ygrads[p_src + 1] + ygrads[p_src + 2];
		if (fabs(xg - yg) < threshold)
			pix_b1r2.x += (h.x + v.x) / 4.0f;
		else if (xg > yg)
			pix_b1r2.x += h.x / 2.0f;
		else
			pix_b1r2.x += v.x / 2.0f;

		// figure out red
		xg = xgrads[p_src] + xgrads[p_src + lrp] + xgrads[p_src + 2 * lrp];
		yg = ygrads[p_src - 1 + lrp] + ygrads[p_src + lrp] + ygrads[p_src + 2 + lrp];
		if (fabs(xg - yg) < threshold)
			pix_b1r2.y += (h.y + v.y) / 4.0f;
		else if (xg > yg)
			pix_b1r2.y += h.y / 2.0f;
		else
			pix_b1r2.y += v.y / 2.0f;

		pix_b1r2 = max(pix_b1r2, 0.0f);

		// 2 - Color row
		// 2a - horizontal interpolation

		float2 pix_b3r0 = (float2)(
				(greens[p_src + 1 + lrp] * 2 - greens[p_src + lrp] - greens[p_src + 2 + lrp])			// green impulse
				+ (pixels[p_src + lrp] + pixels[p_src + lrp + 2])									// average color
				, (greens[p_src] * 2 - greens[p_src - 1] - greens[p_src + 1])
				+ (pixels[p_src - 1] + pixels[p_src + 1])
				);
		pix_b3r0 /= 2.0f;
		pix_b3r0 = max(pix_b3r0, 0.0f);

		barrier(CLK_LOCAL_MEM_FENCE);

		// We want to use the lds to global "unloader" below for simplicity.
		// Rather than allocating an LDS buffer for red and blue just reuse xgrads and ygrads

		xgrads[p_src] = pix_b3r0.y;
		xgrads[p_src + 1] = pixels[p_src + 1];
		xgrads[p_src + lrp] = pix_b1r2.y;
		xgrads[p_src + lrp + 1] = pix_b0r3.y;
		ygrads[p_src] = pix_b0r3.x;
		ygrads[p_src + 1] = pix_b1r2.x;
		ygrads[p_src + lrp] = pixels[p_src + lrp];
		ygrads[p_src + lrp + 1] = pix_b3r0.x;
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	int x1 = get_group_id(0) * outSize;
	int x2 = x1 + outSize;
	x2 = min(x2, (int)(dstRowPixels));
	int y1 = get_group_id(1) * outSize;
	int y2 = y1 + outSize;
	y2 = min(y2, (int)(dstRowPixels));

	const int globalX = srcx + pad - 3 + grx + localx * 2;	// global x under our workitem.  3 is half the 32->26 padding
	const int globalY = srcy + pad - 3 + gry + localy * 2;

	if (destFormat == 0) {
		for (int i = 0; i < 2; ++i) {
			for (int j = 0; j < 2; ++j) {
				if (((globalX + i) >= x1) && ((globalX + i) < x2) && ((globalY + j) >= y1) && ((globalY + j) < y2))	{
					// This pixel is inside the output area
					dst[(globalX + i) + (globalY + j) * dstRowPixels] = xgrads[(x_src + i) + (y_src + j) * lrp];
					dst[(globalX + i) + (globalY + j) * dstRowPixels + dstPlanePixels] = greens[(x_src + i) + (y_src + j) * lrp];
					dst[(globalX + i) + (globalY + j) * dstRowPixels + 2 * dstPlanePixels] = ygrads[(x_src + i) + (y_src + j) * lrp];
				}
			}
		}
	}
	else {
		__global unsigned short int *shortDst = (__global unsigned short int *)(dst);
		for (int i = 0; i < 2; ++i) {
			for (int j = 0; j < 2; ++j) {
				if (((globalX + i) >= x1) && ((globalX + i) < x2) && ((globalY + j) >= y1) && ((globalY + j) < y2))	{
					// This pixel is inside the output area
					shortDst[(globalX + i) + (globalY + j) * dstRowPixels] = (unsigned short int)(xgrads[(x_src + i) + (y_src + j) * lrp] * 16383.0f);
					shortDst[(globalX + i) + (globalY + j) * dstRowPixels + dstPlanePixels] = (unsigned short int)(greens[(x_src + i) + (y_src + j) * lrp] * 16383.0f);
					shortDst[(globalX + i) + (globalY + j) * dstRowPixels + 2 * dstPlanePixels] = (unsigned short int)(ygrads[(x_src + i) + (y_src + j) * lrp] * 16383.0f);
				}
			}
		}
	}
}
#endif


// buildOptions=-D Kernel16
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D Kernel16" %cfg_path --cl-device=%cl_device 2>&1
