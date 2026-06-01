#define DECLARE_INPUT_MAT(i) \
__global const uchar * src##i##ptr, int src##i##_step, int src##i##_offset,
#define DECLARE_OUTPUT_MAT(i) \
__global uchar * dst##i##ptr, int dst##i##_step, int dst##i##_offset,
#define DECLARE_INDEX(i) \
int src##i##_index = mad24(src##i##_step, y0, mad24(x, (int)sizeof(T) * scn##i, src##i##_offset)); \
int dst##i##_index = mad24(dst##i##_step, y0, mad24(x, (int)sizeof(T) * dcn##i, dst##i##_offset));
#define PROCESS_ELEM(i) \
__global const T * src##i = (__global const T *)(src##i##ptr + src##i##_index); \
__global T * dst##i = (__global T *)(dst##i##ptr + dst##i##_index); \
dst##i[0] = src##i[0]; \
src##i##_index += src##i##_step; \
dst##i##_index += dst##i##_step;
__kernel void mixChannels(DECLARE_INPUT_MAT_N DECLARE_OUTPUT_MAT_N int rows, int cols, int rowsPerWI)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < cols)
{
DECLARE_INDEX_N
for (int y = y0, y1 = min(y0 + rowsPerWI, rows); y < y1; ++y)
{
PROCESS_ELEM_N
}
}
}


// buildOptions=-D T=ulong -D DECLARE_INPUT_MAT_N=DECLARE_INPUT_MAT(0)DECLARE_INPUT_MAT(1) -D DECLARE_OUTPUT_MAT_N=DECLARE_OUTPUT_MAT(0)DECLARE_OUTPUT_MAT(1) -D PROCESS_ELEM_N=PROCESS_ELEM(0)PROCESS_ELEM(1) -D DECLARE_INDEX_N=DECLARE_INDEX(0)DECLARE_INDEX(1) -D scn0=3 -D dcn0=3 -D scn1=3 -D dcn1=3 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D T=ulong -D DECLARE_INPUT_MAT_N=DECLARE_INPUT_MAT(0)DECLARE_INPUT_MAT(1) -D DECLARE_OUTPUT_MAT_N=DECLARE_OUTPUT_MAT(0)DECLARE_OUTPUT_MAT(1) -D PROCESS_ELEM_N=PROCESS_ELEM(0)PROCESS_ELEM(1) -D DECLARE_INDEX_N=DECLARE_INDEX(0)DECLARE_INDEX(1) -D scn0=3 -D dcn0=3 -D scn1=3 -D dcn1=3 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
