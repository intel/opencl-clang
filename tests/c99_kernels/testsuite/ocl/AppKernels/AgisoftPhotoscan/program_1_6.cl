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
