
// 2D iteration
__kernel void Tr_Fade_Global(__global const uchar4* src1, __global const uchar4* src2, __global uchar4* dst,
int width, int height, int alpha)
{
	int i = get_global_id(0);
	int j = get_global_id(1);
	int index = j*width+i;

	int4 TempSrc1 = convert_int4(src1[index]);
	int4 TempSrc2 = convert_int4(src2[index]);
	int4 TempDst;
	int4 alpha_4 = alpha;
	int4 shift_4 = 128;

	TempDst = (TempSrc2 - TempSrc1) * alpha_4 / shift_4 + TempSrc1;

	dst[index] = convert_uchar4(TempDst);
}

#if 0
__kernel void Tr_Fade_Global(__global const uchar4* src1, __global const uchar4* src2, __global uchar4* dst,
int width, int height, int alpha)
{
	int index = get_global_id(0);

	int j = index / width;
	int i = index % width;

	int4 TempSrc1 = convert_int4(src1[index]);
	int4 TempSrc2 = convert_int4(src2[index]);
	int4 TempDst;
	int4 alpha_4 = alpha;
	int4 shift_4 = 128;

	TempDst = (TempSrc2 - TempSrc1) * alpha_4 / shift_4 + TempSrc1;

	dst[index] = convert_uchar4(TempDst);


}
#endif


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
