//OpenCL source code
#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

__kernel void censusTransformC1(
	__global uchar *src,
	int src_step,
	__global uint *dst,
	int dst_step,
	int width,
	int height,
	int radius,
	int lstep,
	int lheight,
	int wsize,
	int nbuffs,
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
	int src_step,
	__global uint *dst,
	int dst_step,
	int width,
	int height,
	int radius,
	int lstep,
	int lheight,
	int wsize,
	int nbuffs,
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

 __kernel void ocl_test_kernel(__global int *ocl_test_results)
 {
   ocl_test_results[3] = 0;
   ocl_test_results[0] = 2; //kernel finished
 }


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
