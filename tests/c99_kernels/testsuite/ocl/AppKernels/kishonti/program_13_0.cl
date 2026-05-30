__kernel void Median3x3
(
	__read_only image2d_t image,
	__write_only image2d_t result
)
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int pX = get_global_id(0);
	const int pXPrec = pX - 1;
	const int pXSucc = pX + 1;
	const int pY = get_global_id(1);
	const int pYPrec = pY - 1;
	const int pYSucc = pY + 1;
	const unsigned int width = get_global_size(0);

	uchar4 box[3*3];
	box[0] = convert_uchar4(read_imageui(image, sampler, (int2)(pXPrec, pYPrec)));
	box[1] = convert_uchar4(read_imageui(image, sampler, (int2)(pX,		pYPrec)));
	box[2] = convert_uchar4(read_imageui(image, sampler, (int2)(pXSucc, pYPrec)));
	box[3] = convert_uchar4(read_imageui(image, sampler, (int2)(pXPrec, pY)));
	box[4] = convert_uchar4(read_imageui(image, sampler, (int2)(pXSucc, pY)));
	box[5] = convert_uchar4(read_imageui(image, sampler, (int2)(pXPrec, pY)));
	box[6] = convert_uchar4(read_imageui(image, sampler, (int2)(pXPrec, pYSucc)));
	box[7] = convert_uchar4(read_imageui(image, sampler, (int2)(pX,		pYSucc)));
	box[8] = convert_uchar4(read_imageui(image, sampler, (int2)(pXSucc, pYSucc)));

	uchar4 t1, t2;
	#define MinMaxSwap(i, j) t1 = box[i]; t2 = box[j]; box[i] = min(t1, t2); box[j] = max(t1, t2);

	MinMaxSwap(0,1);
	MinMaxSwap(3,2);
	MinMaxSwap(2,0);
	MinMaxSwap(3,1);
	MinMaxSwap(1,0);
	MinMaxSwap(3,2);
	MinMaxSwap(5,4);
	MinMaxSwap(7,8);
	MinMaxSwap(6,8);
	MinMaxSwap(6,7);
	MinMaxSwap(4,8);
	MinMaxSwap(4,6);
	MinMaxSwap(5,7);
	MinMaxSwap(4,5);
	MinMaxSwap(6,7);
	MinMaxSwap(0,8);

	box[4] = max(box[0], box[4]);
	box[5] = max(box[1], box[5]);
	box[6] = max(box[2], box[6]);
	box[7] = max(box[3], box[7]);

	box[4] = min(box[4], box[6]);
	box[5] = min(box[5], box[7]);

	uint4 median = convert_uint4(min(box[4], box[5]));
	write_imageui(result, (int2)(pX, pY), median);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
