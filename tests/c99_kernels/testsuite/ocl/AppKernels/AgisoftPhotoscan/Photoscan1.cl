//OpenCL source code
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

////	out[oindex]				= (v01 & 0xFFFF0000) | (v23 >> 16);\n\" //(obuf[32] << 16) | obuf[0];
////	out[oindex + height]	= ((v01 & 0xFFFF) << 16) | (v23 & 0xFFFF);
//		out[oindex]				= v01;//(v01 & 0xFFFF) | ((v23 & 0xFFFF) << 16);\n\" //(obuf[32] << 16) | obuf[0];
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

//		out[oindex]				= (v01 & 0xFFFF0000) | (v23 >> 16);\n\" //(obuf[32] << 16) | obuf[0];
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

 __kernel void ocl_test_kernel(__global int *ocl_test_results)
 {
   ocl_test_results[3] = 0;
   ocl_test_results[0] = 2; //kernel finished
 }


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
