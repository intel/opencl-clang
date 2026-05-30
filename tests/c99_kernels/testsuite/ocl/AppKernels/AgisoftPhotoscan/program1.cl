#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

__kernel void censusTransformC1(
	__global uchar *src,
	__global uint *dst,
	int src_step,
	int width,
	int height,
	int radius,
	int lstep,
	int lheight,
	int wsize,
	__local uchar *ldata
){

	for (int bj = 0; bj < lheight; bj += get_local_size(1)) {
	for (int bi = 0; bi < lstep;   bi += get_local_size(0)) {
		int i = bi + get_local_id(0);
		int j = bj + get_local_id(1);
		if (i < lstep && j < lheight) {
			int x = get_global_id(0) + bi - radius;
			int y = get_global_id(1) + bj - radius;
			if (x >= 0 && y >= 0 && x < width && y < height)
				ldata[j * lstep + i] = src[y * src_step + x]; else
				ldata[j * lstep + i] = (uchar) 0;
		}
	}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	if (get_global_id(0) < width && get_global_id(1) < height) {
		__local uchar *pix = ldata + get_local_id(1) * lstep + get_local_id(0);
		int c = pix[radius * lstep + radius];

		__global uint *census = dst + get_global_id(1) * width + get_global_id(0);

		unsigned int val = 0;
		int k = 0;
		for (int y = 0; y < wsize; y++, pix += lstep)
			for (int x = 0; x < wsize; x++) {
				val = (val << 1) | ((unsigned int)(pix[x] - c) >> 31);
				k++;
				if (k == 32) {
					census[0] = val;
					census += width * height;
					val	= 0;
					k	= 0;
				}
			}
		if (k) {
			census[0] = val;
			census += width * height;
		}
	}
}

__kernel void censusTransformC3(
	__global uchar *src,
	__global uint *dst,
	int src_step,
	int width,
	int height,
	int radius,
	int lstep,
	int lheight,
	int wsize,
	__local uchar *ldata
){

	int x0 = 3 * (get_group_id(0) * get_local_size(0) - radius);
	int y0 =      get_group_id(1) * get_local_size(1) - radius;

	for (int bj = 0; bj < lheight; bj += get_local_size(1)) {
	for (int bi = 0; bi < lstep;   bi += get_local_size(0)) {
		int i = bi + get_local_id(0);
		int j = bj + get_local_id(1);
		if (i < lstep && j < lheight) {
			int x = x0 + bi + get_local_id(0);
			int y = y0 + bj + get_local_id(1);
			if (x >= 0 && y >= 0 && x < 3 * width && y < height)
				ldata[j * lstep + i] = src[y * src_step + x]; else
				ldata[j * lstep + i] = (uchar) 0;
		}
	}
	}

	barrier(CLK_LOCAL_MEM_FENCE);

	if (get_global_id(0) < width && get_global_id(1) < height) {
		__local uchar *pix = ldata + get_local_id(1) * lstep + get_local_id(0) * 3;
		int c0 = pix[radius * lstep + radius * 3 + 0];
		int c1 = pix[radius * lstep + radius * 3 + 1];
		int c2 = pix[radius * lstep + radius * 3 + 2];

		__global uint *census = dst + get_global_id(1) * width + get_global_id(0);

		unsigned int val = 0;
		int k = 0;
		for (int y = 0; y < wsize; y++, pix += lstep)
			for (int x = 0; x < wsize; x++) {
				val = (val << 1) | ((unsigned int)(pix[3 * x + 0] - c0) >> 31);
				val = (val << 1) | ((unsigned int)(pix[3 * x + 1] - c1) >> 31);
				val = (val << 1) | ((unsigned int)(pix[3 * x + 2] - c2) >> 31);
				k++;
				if (k == 10) {
					census[0] = val;
					census += width * height;
					val	= 0;
					k	= 0;
				}
			}
		if (k) {
			census[0] = val;
			census += width * height;
		}
	}
}
__kernel void boxFilter( __global const  uint *usSource, __global uint *usDest,
						  int pitch_x, int pitch_y, int size_x, int size_y, int d, int r)
{
	__global const uint *id = usSource + get_global_id(1) * pitch_y + get_global_id(0);
	__global uint *od = usDest + get_global_id(1) * pitch_y + get_global_id(0);

	if (get_global_id(1) < size_y && get_global_id(0) < d) {
		uint t;
		// do left edge
		t = id[0] * r;
		for (int x = 0; x < r + 1; x++) {
			t += id[x * pitch_x];
		}
		od[0] = t;

		for(int x = 1; x < r + 1; x++) {
			t += id[(x + r) * pitch_x];
			t -= id[0];
			od[x * pitch_x] = t;
		}

		// main loop
		for(int x = r + 1; x < size_x - r; x++) {
			t += id[(x + r) * pitch_x];
			t -= id[(x - r - 1) * pitch_x];
			od[x * pitch_x] = t;
		}

		// do right edge
		for (int x = size_x - r; x < size_x; x++) {
			t += id[(size_x - 1) * pitch_x];
			t -= id[(x - r - 1) * pitch_x];
			od[x * pitch_x] = t;
		}
	}
}
/*
int __popc(uint b)
{
	b = (b & 0x55555555) + (b >> 1 & 0x55555555);
	b = (b & 0x33333333) + (b >> 2 & 0x33333333);
	b = (b + (b >> 4)) & 0x0F0F0F0F;
	b = b + (b >> 8);
	b = (b + (b >> 16)) & 0x0000003F;
	return (int) b;
}
*/

int __popc(unsigned int a)
{
	a = a - ((a >> 1) & 0x55555555);
	a = (a & 0x33333333) + ((a >> 2) & 0x33333333);
	a = (a + (a >> 4)) & 0x0f0f0f0f;
	a = ((mul24(a, 0x808080u) << 1) + a) >> 24;
	return a;
}

__kernel void hamming(
	__global uint *src_l,
	__global uint *src_r,
	__global uint *dst,
	int col0, int row0, int ncols, int nrows,
	int width, int height, int offset,
	int disp_min, int disp_num,
	__local uint *ldata
){
	dst		+= (get_global_id(1) * ncols + get_group_id(0) * 16) * disp_num / 2 + get_local_id(0);
	ldata	+= get_local_id(1) * 4 * 16;
	offset	+= (row0 + get_global_id(1)) * width;

	ncols	 = min((int) (ncols - get_group_id(0) * 16), (int) 16);

	if (get_global_id(1) < nrows)
	ldata[get_local_id(0)] = (col0 + get_global_id(0) < width ? src_l[offset + col0 + get_global_id(0)] : 0);

	for (int block = 0; block < disp_num; block += 32) {

		if (get_global_id(1) < nrows)
		for (int k = 0; k < 3; k++) {
			int offs = col0 + get_global_id(0) - disp_min - block + 16 * (k - 2);
			ldata[16 * (k + 1) + get_local_id(0)] = (offs >= 0 && offs < width ? src_r[offset + offs] : 0);
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		__local uint *buf_r = ldata + (48 - 2 * get_local_id(0));

		if (get_global_id(1) < nrows)
		for (int k = 0; k < ncols; k++) {

			uint score0 = __popc(ldata[k] ^ buf_r[k]);
			uint score1 = __popc(ldata[k] ^ buf_r[k - 1]);

			dst[k * disp_num / 2] += ((score1 << 16) | score0);
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		dst		+= 16;
	}
}

__kernel void filter(
	__global uint *dsi,
	int col0, int row0, int ncols, int nrows,
	int width, int height,
	int disp_min, int disp_num,
	uint match_max
){
	dsi		+= (get_global_id(1) * ncols + get_group_id(0) * 16) * disp_num / 2 + get_local_id(0);

	ncols	 = min((int) (ncols - get_group_id(0) * 16), (int) 16);

	if (get_global_id(1) < nrows)
	for (int block = 0; block < disp_num; block += 32) {

		for (int k = 0; k < ncols; k++) {

			uint val = dsi[k * disp_num / 2];
			uint score0 = (val & 0xFFFF);
			uint score1 = ((val >> 16) & 0xFFFF);

			int x_r = col0 + get_group_id(0) * 16 + k - (disp_min + block + 2 * get_local_id(0));

			if (x_r >= 0 && x_r < width)
				score0 = min(score0, match_max); else
				score0 = match_max;
			if (x_r >= 1 && x_r <= width)
				score1 = min(score1, match_max); else
				score1 = match_max;

			dsi[k * disp_num / 2] = ((score1 << 16) | score0);
		}

		dsi		+= 16;
	}
}
__kernel void memzero(__global uint *sum, int size)
{
	int nchunks = (size + get_global_size(0) - 1) / get_global_size(0);
	int id = get_global_id(0);
	for (int k = 0; k < nchunks; k++) {
		if (id < size)
			sum[id] = 0;
		id += get_global_size(0);
	}
}
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable


//	#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : require
//	#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics: enable
//	#pragma OPENCL EXTENSION cl_khr_local_int32_extended_atomics : require
//	#pragma OPENCL EXTENSION cl_khr_local_int32_extended_atomics : enable

__kernel void sgCosts(
	__global uchar *		im,
	__global uint *			costs,
	int width, int height,
	int P1, int P2, int dir,
	int im_offs, int im_step, int cn)
{
	int i = get_global_id(0);
	int j = get_global_id(1);

	if (i < width && j < height) {

		int di = 0, dj = 0;
		switch (dir) {
		case 0x02010201:	// {  1,  0,  1,  0 }
			di = 1;
			dj = 0;
			break;
		case 0x00010001: // { -1,  0, -1,  0 }
			di = -1;
			dj = 0;
			break;
		case 0x01020102: // {  0,  1,  0,  1 }
			di = 0;
			dj = 1;
			break;
		case 0x01000100: // {  0, -1,  0, -1 }
			di = 0;
			dj = -1;
			break;

		case 0x02020202: // {  1,  1,  1,  1 }
			di = +1;
			dj = +1;
			break;
		case 0x00000000: // { -1, -1, -1, -1 }
			di = -1;
			dj = -1;
			break;
		case 0x00020002: // { -1,  1, -1,  1 }
			di = -1;
			dj = +1;
			break;
		case 0x02000200: // {  1, -1,  1, -1 }
			di = +1;
			dj = -1;
			break;

		case 0x02010202: // {  1,  0,  1,  1 },
			di = 1;
			dj = (i & 1 ? +1 : 0);
			break;
		case 0x02010200: // {  1,  0,  1, -1 },
			di = 1;
			dj = (i & 1 ? -1 : 0);
			break;
		case 0x00010002: // { -1,  0, -1,  1 },
			di = -1;
			dj = ((width - i - 1) & 1 ? +1 : 0);
			break;
		case 0x00010000: // { -1,  0, -1, -1 },
			di = -1;
			dj = ((width - i - 1) & 1 ? -1 : 0);
			break;

		case 0x01020202: // {  0,  1,  1,  1 },
			di = (j & 1 ? +1 : 0);
			dj = +1;
			break;
		case 0x01020002: // {  0,  1, -1,  1 },
			di = (j & 1 ? -1 : 0);
			dj = +1;
			break;
		case 0x01000200: // {  0, -1,  1, -1 },
			di = ((height - j - 1) & 1 ? +1 : 0);
			dj = -1;
			break;
		case 0x01000000: // {  0, -1, -1, -1 },
			di = ((height - j - 1) & 1 ? -1 : 0);
			dj = -1;
			break;
		}

		int i0 = i - di;
		int j0 = j - dj;

		if (i0 < 0 || i0 >= width)	i0 = i;
		if (j0 < 0 || j0 >= height)	j0 = j;

		__global uchar *im0 = im + im_offs + j0 * im_step + i0 * cn;
		__global uchar *im1 = im + im_offs + j  * im_step + i  * cn;

		int dist = 0;
		for (int k = 0; k < cn; k++)
			dist = max(dist, (int) abs_diff(im0[k], im1[k]));

		dist = max(dist / 4, 1);
		costs[j * width + i] = max(P2 / dist, P1 + 1);

	}

}

__kernel void sgAggregateB1(
	__global const uint *	dsi,
	__global uint *			sum,
	__global uint *			P2,
	__local  ushort *		L,
	int width, int height,
	int P1, int dir,
	int di0, int dj0, int di1, int dj1)
{
	int i, j;

	switch (dir) {
	case 0x02010201:	// {  1,  0,  1,  0 }
		i = 0;
		j = get_group_id(1);
		break;
	case 0x00010001: // { -1,  0, -1,  0 }
		i = width - 1;
		j = get_group_id(1);
		break;
	case 0x01020102: // {  0,  1,  0,  1 }
		i = get_group_id(1);
		j = 0;
		break;
	case 0x01000100: // {  0, -1,  0, -1 }
		i = get_group_id(1);
		j = height - 1;
		break;

	case 0x02020202: // {  1,  1,  1,  1 }
		i = (get_group_id(1) < width ? get_group_id(1) : 0);
		j = (get_group_id(1) < width ? 0 : get_group_id(1) - width + 1);
		break;
	case 0x00000000: // { -1, -1, -1, -1 }
		i = (get_group_id(1) < height ? width - 1 : get_group_id(1) - height);
		j = (get_group_id(1) < height ? get_group_id(1) : height - 1);
		break;
	case 0x00020002: // { -1,  1, -1,  1 }
		i = (get_group_id(1) < width ? get_group_id(1) : width - 1);
		j = (get_group_id(1) < width ? 0 : get_group_id(1) - width + 1);
		break;
	case 0x02000200: // {  1, -1,  1, -1 }
		i = (get_group_id(1) < height ? 0 : get_group_id(1) - height + 1);
		j = (get_group_id(1) < height ? get_group_id(1) : height - 1);
		break;

	case 0x02010202: // {  1,  0,  1,  1 },
		i = (get_group_id(1) < height ? 0 : 2 * (get_group_id(1) - height + 1));
		j = (get_group_id(1) < height ? get_group_id(1) : 0);
		break;
	case 0x02010200: // {  1,  0,  1, -1 },
		i = (get_group_id(1) < height ? 0 : 2 * (get_group_id(1) - height + 1));
		j = (get_group_id(1) < height ? get_group_id(1) : height - 1);
		break;
	case 0x00010002: // { -1,  0, -1,  1 },
		i = (get_group_id(1) < height ? width - 1 : width - 1 - 2 * (get_group_id(1) - height + 1));
		j = (get_group_id(1) < height ? get_group_id(1) : 0);
		break;
	case 0x00010000: // { -1,  0, -1, -1 },
		i = (get_group_id(1) < height ? width - 1 : width - 1 - 2 * (get_group_id(1) - height + 1));
		j = (get_group_id(1) < height ? get_group_id(1) : height - 1);
		break;

	case 0x01020202: // {  0,  1,  1,  1 },
		i = (get_group_id(1) < width ? get_group_id(1) : 0);
		j = (get_group_id(1) < width ? 0 : 2 * (get_group_id(1) - width + 1));
		break;
	case 0x01020002: // {  0,  1, -1,  1 },
		i = (get_group_id(1) < width ? get_group_id(1) : width - 1);
		j = (get_group_id(1) < width ? 0 : 2 * (get_group_id(1) - width + 1));
		break;
	case 0x01000200: // {  0, -1,  1, -1 },
		i = (get_group_id(1) < width ? get_group_id(1) : 0);
		j = (get_group_id(1) < width ? height - 1 : height - 1 - 2 * (get_group_id(1) - width + 1));
		break;
	case 0x01000000: // {  0, -1, -1, -1 },
		i = (get_group_id(1) < width ? get_group_id(1) : width - 1);
		j = (get_group_id(1) < width ? height - 1 : height - 1 - 2 * (get_group_id(1) - width + 1));
		break;
	}

	int disp_num	= get_local_size(0);
	int d			= get_local_id(0);

//	reset L to zero
	L[d] = 0;

	int n = 0;
	while (i >= 0 && j >= 0 && i < width && j < height) {

		barrier(CLK_LOCAL_MEM_FENCE);

		int val = min(L[max(d - 1, 0)], L[min(d + 1, disp_num - 1)]) + P1;
		val = min(val, (int) L[d]);

		barrier(CLK_LOCAL_MEM_FENCE);

		if (disp_num > 512) { if (d >= 512) L[d] = min(L[d], L[d - 512]); barrier(CLK_LOCAL_MEM_FENCE); }
		if (disp_num > 256) { if (d >= 256) L[d] = min(L[d], L[d - 256]); barrier(CLK_LOCAL_MEM_FENCE); }
		if (disp_num > 128) { if (d >= 128) L[d] = min(L[d], L[d - 128]); barrier(CLK_LOCAL_MEM_FENCE); }
		if (disp_num > 64)  { if (d >= 64)  L[d] = min(L[d], L[d - 64 ]); barrier(CLK_LOCAL_MEM_FENCE); }

		if (d >= 32) L[d] = min(L[d], L[d - 32]);
		if (d >= 16) L[d] = min(L[d], L[d - 16]);
		if (d >=  8) L[d] = min(L[d], L[d -  8]);
		if (d >=  4) L[d] = min(L[d], L[d -  4]);
		if (d >=  2) L[d] = min(L[d], L[d -  2]);
		if (d >=  1) L[d] = min(L[d], L[d -  1]);

		barrier(CLK_LOCAL_MEM_FENCE);

// enable coalescing on compute capabilities 1.0 and 1.1
		val = min(val - L[disp_num - 1], (int) P2[j * width + i]);

		barrier(CLK_LOCAL_MEM_FENCE);

		L[d]	= val;

		barrier(CLK_LOCAL_MEM_FENCE);

		if (d < disp_num / 2) {
			((__local uint *) L)[d] += dsi[(j * width + i) * disp_num / 2 + d];
			sum[(j * width + i) * disp_num / 2 + d] += ((__local uint *) L)[d];
		}
/*
// uncoalesced code
		val = dsi[(j * width + i) * disp_num + d] + min(val - L[disp_num - 1], (int) P2[j * width + i]);
		sum[(j * width + i) * disp_num + d] += val;

		barrier(CLK_LOCAL_MEM_FENCE);

		L[d]	= val;
*/


		if (n == 0) {
			i += di0;
			j += dj0;
		} else {
			i += di1;
			j += dj1;
		}

/*
		i += select(di1, di0, n == 0);
		j += select(dj1, dj0, n == 0);
*/
		n = 1 - n;
	}

}

__kernel void sgAggregateBn(
	__global const uint *	dsi,
	__global uint *			sum,
	__global uint *			P2,
	__local  ushort *		ldata,
	int width, int height,
	int P1, int dir,
	int di0, int dj0, int di1, int dj1,
	int disp_num, int nblocks)
{
	int i, j;

	switch (dir) {
	case 0x02010201:	// {  1,  0,  1,  0 }
		i = 0;
		j = get_group_id(1);
		break;
	case 0x00010001: // { -1,  0, -1,  0 }
		i = width - 1;
		j = get_group_id(1);
		break;
	case 0x01020102: // {  0,  1,  0,  1 }
		i = get_group_id(1);
		j = 0;
		break;
	case 0x01000100: // {  0, -1,  0, -1 }
		i = get_group_id(1);
		j = height - 1;
		break;

	case 0x02020202: // {  1,  1,  1,  1 }
		i = (get_group_id(1) < width ? get_group_id(1) : 0);
		j = (get_group_id(1) < width ? 0 : get_group_id(1) - width + 1);
		break;
	case 0x00000000: // { -1, -1, -1, -1 }
		i = (get_group_id(1) < height ? width - 1 : get_group_id(1) - height);
		j = (get_group_id(1) < height ? get_group_id(1) : height - 1);
		break;
	case 0x00020002: // { -1,  1, -1,  1 }
		i = (get_group_id(1) < width ? get_group_id(1) : width - 1);
		j = (get_group_id(1) < width ? 0 : get_group_id(1) - width + 1);
		break;
	case 0x02000200: // {  1, -1,  1, -1 }
		i = (get_group_id(1) < height ? 0 : get_group_id(1) - height + 1);
		j = (get_group_id(1) < height ? get_group_id(1) : height - 1);
		break;

	case 0x02010202: // {  1,  0,  1,  1 },
		i = (get_group_id(1) < height ? 0 : 2 * (get_group_id(1) - height + 1));
		j = (get_group_id(1) < height ? get_group_id(1) : 0);
		break;
	case 0x02010200: // {  1,  0,  1, -1 },
		i = (get_group_id(1) < height ? 0 : 2 * (get_group_id(1) - height + 1));
		j = (get_group_id(1) < height ? get_group_id(1) : height - 1);
		break;
	case 0x00010002: // { -1,  0, -1,  1 },
		i = (get_group_id(1) < height ? width - 1 : width - 1 - 2 * (get_group_id(1) - height + 1));
		j = (get_group_id(1) < height ? get_group_id(1) : 0);
		break;
	case 0x00010000: // { -1,  0, -1, -1 },
		i = (get_group_id(1) < height ? width - 1 : width - 1 - 2 * (get_group_id(1) - height + 1));
		j = (get_group_id(1) < height ? get_group_id(1) : height - 1);
		break;

	case 0x01020202: // {  0,  1,  1,  1 },
		i = (get_group_id(1) < width ? get_group_id(1) : 0);
		j = (get_group_id(1) < width ? 0 : 2 * (get_group_id(1) - width + 1));
		break;
	case 0x01020002: // {  0,  1, -1,  1 },
		i = (get_group_id(1) < width ? get_group_id(1) : width - 1);
		j = (get_group_id(1) < width ? 0 : 2 * (get_group_id(1) - width + 1));
		break;
	case 0x01000200: // {  0, -1,  1, -1 },
		i = (get_group_id(1) < width ? get_group_id(1) : 0);
		j = (get_group_id(1) < width ? height - 1 : height - 1 - 2 * (get_group_id(1) - width + 1));
		break;
	case 0x01000000: // {  0, -1, -1, -1 },
		i = (get_group_id(1) < width ? get_group_id(1) : width - 1);
		j = (get_group_id(1) < width ? height - 1 : height - 1 - 2 * (get_group_id(1) - width + 1));
		break;
	}

//		int disp_num	= get_global_size(0);
//		int d			= get_global_id(0);

	__local ushort *L = ldata;

//	reset L to zero
	for (int k = 0; k < nblocks; k++) {
		int d = get_local_id(0) + k * get_local_size(0);
		if (d < disp_num)
			L[d] = 0;
	}

	int n = 0;
	while (i >= 0 && j >= 0 && i < width && j < height) {

		barrier(CLK_LOCAL_MEM_FENCE);

		for (int k = 0; k < nblocks; k++) {
			int d = get_local_id(0) + k * get_local_size(0);
			int val = (d + 1 < disp_num ? min((int) L[d], L[d + 1] + P1) : 0);
			d = (d & 0x0FFFFFFF); 	// ATI hack
			barrier(CLK_LOCAL_MEM_FENCE);
			if (d + 1 < disp_num)
				L[d] = val;
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		for (int k = nblocks - 1; k >= 0; k--) {
			int d = get_local_id(0) + k * get_local_size(0);
			int val = ((d > 0 && d < disp_num) ? min((int) L[d], L[d - 1] + P1) : 0);
			d = (d & 0x0FFFFFFF); 	// ATI hack
			barrier(CLK_LOCAL_MEM_FENCE);
			if (d > 0 && d < disp_num)
				L[d] = val;
		}

		barrier(CLK_LOCAL_MEM_FENCE);

//			int val = min(L[max(d - 1, 0)], L[min(d + 1, disp_num - 1)]) + P1;
//			val = min(val, (int) L[d]);

		// save L value from 0 block
		int Lblock0 = L[get_local_id(0)];

		for (int k = 1; k < nblocks; k++) {
			int d = get_local_id(0) + k * get_local_size(0);
			if (d < disp_num)
				L[get_local_id(0)] = min(L[get_local_id(0)], L[d]);
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		if (get_local_size(0) > 512) { if (get_local_id(0) >= 512) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) - 512]); barrier(CLK_LOCAL_MEM_FENCE); }
		if (get_local_size(0) > 256) { if (get_local_id(0) >= 256) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) - 256]); barrier(CLK_LOCAL_MEM_FENCE); }
		if (get_local_size(0) > 128) { if (get_local_id(0) >= 128) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) - 128]); barrier(CLK_LOCAL_MEM_FENCE); }
		if (get_local_size(0) > 64)  { if (get_local_id(0) >= 64)  L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) - 64 ]); barrier(CLK_LOCAL_MEM_FENCE); }

		if (get_local_id(0) >= 32) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) - 32]);
		if (get_local_id(0) >= 16) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) - 16]);
		if (get_local_id(0) >=  8) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) -  8]);
		if (get_local_id(0) >=  4) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) -  4]);
		if (get_local_id(0) >=  2) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) -  2]);
		if (get_local_id(0) >=  1) L[get_local_id(0)] = min(L[get_local_id(0)], L[get_local_id(0) -  1]);

		barrier(CLK_LOCAL_MEM_FENCE);

		int Lmin = L[get_local_size(0) - 1];

		barrier(CLK_LOCAL_MEM_FENCE);

// enable coalescing on compute capabilities 1.0 and 1.1

		L[get_global_id(0)]	= min(Lblock0 - Lmin, (int) P2[j * width + i]);
		for (int k = 1; k < nblocks; k++) {
			int d = get_local_id(0) + k * get_local_size(0);
			if (d < disp_num)
				L[d] = min(L[d] - Lmin, (int) P2[j * width + i]);
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		if (get_local_id(0) < get_local_size(0) / 2)
		for (int k = 0; k < nblocks; k++) {
			int d = get_local_id(0) + k * get_local_size(0) / 2;
			if (d < disp_num / 2) {
				((__local uint *) L)[d] += dsi[(j * width + i) * disp_num / 2 + d];
				sum[(j * width + i) * disp_num / 2 + d] += ((__local uint *) L)[d];
			}
		}

// uncoalesced code

/*
		// block 0
		int val = dsi[(j * width + i) * disp_num + get_global_id(0)] + min(Lblock0 - Lmin, (int) P2[j * width + i]);
		sum[(j * width + i) * disp_num + get_global_id(0)] += val;
		L[get_global_id(0)]	= val;

		for (int k = 1; k < nblocks; k++) {
			int d = get_global_id(0) + k * get_global_size(0);
			if (d < disp_num) {
				int val = dsi[(j * width + i) * disp_num + d] + min(L[d] - Lmin, (int) P2[j * width + i]);
				sum[(j * width + i) * disp_num + d] += val;
				L[d]	= val;
			}
		}
*/

		if (n == 0) {
			i += di0;
			j += dj0;
		} else {
			i += di1;
			j += dj1;
		}

		n = 1 - n;
	}
}
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable
/*
__kernel void transpose(__global const ushort *in, __global ushort *out, int width, int height, int slices)
{
	__local ushort buf[17 * 16];
	int gx = get_global_id(0);
	int gy = get_global_id(1);
	int lx = get_local_id(0);
	int ly = get_local_id(1);
	unsigned int offs = width * height;

	int limx = width  - get_group_id(0) * get_local_size(0);
	int limy = height - get_group_id(1) * get_local_size(1);

	for (int s = 0; s < slices; s++) {
		// read the matrix tile into shared memory
		if (lx < limx && ly < limy)
			buf[ly * 17 + lx] = in[gy * width + gx];

		barrier(CLK_LOCAL_MEM_FENCE);

		if (ly < limx && lx < limy)
			out[height * (gx - lx + ly) + gy - ly + lx] = buf[lx * 17 + ly];

		barrier(CLK_LOCAL_MEM_FENCE);

		in  += offs;
		out += offs;
	}
//	// write the transposed matrix tile to global memory
//	unsigned int oindex = 2 * mul24(gx - lx + ly, height) + gy - ly + lx;
//	unsigned int v01 = obuf[0];
//	unsigned int v23 = obuf[17 * 16];

////	out[oindex]				= (v01 & 0xFFFF0000) | (v23 >> 16);\n" //(obuf[32] << 16) | obuf[0];
////	out[oindex + height]	= ((v01 & 0xFFFF) << 16) | (v23 & 0xFFFF);
//		out[oindex]				= v01;//(v01 & 0xFFFF) | ((v23 & 0xFFFF) << 16);\n" //(obuf[32] << 16) | obuf[0];
//		out[oindex + height]	= v23;//(v01 >> 16) | (v23 & 0xFFFF0000);
}
*/

__kernel void transpose(
			__global const	uint *data0, int step0,	// step0 - row stride in uints
			__global		uint *data1, int step1,	// step1 - row stride in uints
			int width, int height,					// output slice dimensions in ushorts
			int slices)
{
	__local uint buf[17 * 32];

	__local uint *ibuf = buf + get_local_id(1) * 17 + get_local_id(0);
	__local uint *obuf = buf + get_local_id(0) * 17 + get_local_id(1);

	data0 += 2 * step0 * (get_group_id(0) * 16 + get_local_id(1)) + get_group_id(1) * 16 + get_local_id(0);
	data1 += 2 * step1 * get_global_id(1) + get_global_id(0);

	for (int s = 0; s < slices; s++) {

		// read the matrix tile into shared memory
//		if (2 * get_global_id(0) < width) {
		if (get_group_id(0) * 32 + get_local_id(1) * 2 + 0 < width)	ibuf[0]			= data0[0];
		if (get_group_id(0) * 32 + get_local_id(1) * 2 + 1 < width)	ibuf[17 * 16]	= data0[step0];
//		}

		barrier(CLK_LOCAL_MEM_FENCE);

		// write the transposed matrix tile to global memory
		unsigned int v01 = obuf[0];
		unsigned int v23 = obuf[17 * 16];

//		out[oindex]				= (v01 & 0xFFFF0000) | (v23 >> 16);\n" //(obuf[32] << 16) | obuf[0];
//		out[oindex + height]	= ((v01 & 0xFFFF) << 16) | (v23 & 0xFFFF);
//		if (2 * (get_group_id(1) * 16 + get_local_id(0)) < height) {
//		if (2 * (get_group_id(0) * 16 + get_local_id(1)) + 0 < width) data1[0]		= ((v01 & 0xFFFF) | ((v23 & 0xFFFF) << 16)); //(obuf[32] << 16) | obuf[0];
//		if (2 * (get_group_id(0) * 16 + get_local_id(1)) + 1 < width) data1[step1]	= ((v01 >> 16) | (v23 & 0xFFFF0000));
		if (2 * get_global_id(1) + 0 < height) data1[0]		= ((v01 & 0xFFFF) | ((v23 & 0xFFFF) << 16)); //(obuf[32] << 16) | obuf[0];
		if (2 * get_global_id(1) + 1 < height) data1[step1]	= ((v01 >> 16) | (v23 & 0xFFFF0000));
//		}

		barrier(CLK_LOCAL_MEM_FENCE);

		data0 += step0 * width;
		data1 += step1 * height;
	}
}

#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

__kernel void wtaL(
	__global ushort *dsi,
	int dsi_step,
	__global float *disp,
	__global float *conf,
	int ncols, int nrows,
	int col0, int width,
	int disp_min, int disp_num, int lr_check
){
	int i = get_global_id(0);
	int j = get_global_id(1);

	if (i < ncols && j < nrows) {
		dsi += j * dsi_step * disp_num;

		int vmin = 65535;
		int vpos = 0;
		for (int d = 0; d < disp_num; d++) {
			int xr = col0 + i - disp_min - d;
			if (xr >= 0 && xr < width) {
				int val = dsi[d * dsi_step + i];
				if (val < vmin) {
					vmin = val;
					vpos = d;
				}
			}
		}

		if (vpos == disp_num - 1) vpos = 0;

		if (lr_check && vpos) {

			int vpos_r = vpos;
			for (int d = 0; d < disp_num; d++) {
				int xl = i + d - vpos;
				if (xl >= 0 && xl < ncols) {
					int val = dsi[d * dsi_step + xl];
					if (val < vmin) {
						vmin   = val;
						vpos_r = d;
					}
				}
			}

			if (abs(vpos_r - vpos) > 1) vpos = 0;

		}

		float res_d = FLT_MAX;
		float res_c = 0;

		if (vpos) {
			float c0 = (float) dsi[i + dsi_step * (vpos - 1)];
			float c1 = (float) dsi[i + dsi_step * vpos];
			float c2 = (float) dsi[i + dsi_step * (vpos + 1)];
			float doff = 0;
			float denom = 2 * (c0-2*c1+c2);
			if (denom > 1e-2f)
				doff = (c0 - c2) / denom;

			res_d = disp_min + vpos + doff;
			res_c = denom * 0.5f;
		}

		int offs = j * ncols + i;
		disp[offs] = res_d;
		conf[offs] = res_c;
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
