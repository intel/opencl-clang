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


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
