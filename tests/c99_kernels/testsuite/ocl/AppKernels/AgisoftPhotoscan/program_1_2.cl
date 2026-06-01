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


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
