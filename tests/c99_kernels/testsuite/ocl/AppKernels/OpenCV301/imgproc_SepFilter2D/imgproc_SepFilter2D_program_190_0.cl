#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#define READ_TIMES_COL ((2*(RADIUSY+LSIZE1)-1)/LSIZE1)
#define RADIUS 1
#define noconvert
#if CN != 3
#define loadpix(addr) *(__global const srcT *)(addr)
#define storepix(val, addr)  *(__global dstT *)(addr) = val
#define SRCSIZE (int)sizeof(srcT)
#define DSTSIZE (int)sizeof(dstT)
#else
#define loadpix(addr)  vload3(0, (__global const srcT1 *)(addr))
#define storepix(val, addr) vstore3(val, 0, (__global dstT1 *)(addr))
#define SRCSIZE (int)sizeof(srcT1)*3
#define DSTSIZE (int)sizeof(dstT1)*3
#endif
#define DIG(a) a,
__constant srcT1 mat_kernel[] = { COEFF };
__kernel void col_filter(__global const uchar * src, int src_step, int src_offset, int src_whole_rows, int src_whole_cols,
__global uchar * dst, int dst_step, int dst_offset, int dst_rows, int dst_cols, float delta)
{
int x = get_global_id(0);
int y = get_global_id(1);
int l_x = get_local_id(0);
int l_y = get_local_id(1);
int start_addr = mad24(y, src_step, x * SRCSIZE);
int end_addr = mad24(src_whole_rows - 1, src_step, src_whole_cols * SRCSIZE);
srcT sum, temp[READ_TIMES_COL];
__local srcT LDS_DAT[LSIZE1 * READ_TIMES_COL][LSIZE0 + 1];
for (int i = 0; i < READ_TIMES_COL; ++i)
{
int current_addr = mad24(i, LSIZE1 * src_step, start_addr);
current_addr = current_addr < end_addr ? current_addr : 0;
temp[i] = loadpix(src + current_addr);
}
for (int i = 0; i < READ_TIMES_COL; ++i)
LDS_DAT[mad24(i, LSIZE1, l_y)][l_x] = temp[i];
barrier(CLK_LOCAL_MEM_FENCE);
sum = LDS_DAT[l_y + RADIUSY][l_x] * mat_kernel[RADIUSY];
for (int i = 1; i <= RADIUSY; ++i)
{
temp[0] = LDS_DAT[l_y + RADIUSY - i][l_x];
temp[1] = LDS_DAT[l_y + RADIUSY + i][l_x];
#if (defined(INTEGER_ARITHMETIC) && !INTEL_DEVICE)
sum += mad24(temp[0],mat_kernel[RADIUSY - i], temp[1] * mat_kernel[RADIUSY + i]);
#else
sum += mad(temp[0], mat_kernel[RADIUSY - i], temp[1] * mat_kernel[RADIUSY + i]);
#endif
}
#ifdef INTEGER_ARITHMETIC
#ifdef INTEL_DEVICE
sum = (sum + (1 << (SHIFT_BITS-1))) / (1 << SHIFT_BITS);
#else
sum = (sum + (1 << (SHIFT_BITS-1))) >> SHIFT_BITS;
#endif
#endif
if (x < dst_cols && y < dst_rows)
{
start_addr = mad24(y, dst_step, mad24(DSTSIZE, x, dst_offset));
storepix(convertToDstT(sum + (srcT)(delta)), dst + start_addr);
}
}


// buildOptions=-D RADIUSY=4 -D LSIZE0=16 -D LSIZE1=16 -D CN=2 -D srcT=float2 -D dstT=float2 -D convertToDstT=noconvert -D srcT1=float -D dstT1=float -D SHIFT_BITS=16 -D COEFF=DIG(-0.06147346646f)DIG(-0.07180448622f)DIG(0.1147519723f)DIG(-0.1352790445f)DIG(-0.1516204625f)DIG(-0.1217835024f)DIG(-0.1543113738f)DIG(-0.1373673230f)DIG(-0.05160841346f) -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D RADIUSY=4 -D LSIZE0=16 -D LSIZE1=16 -D CN=2 -D srcT=float2 -D dstT=float2 -D convertToDstT=noconvert -D srcT1=float -D dstT1=float -D SHIFT_BITS=16 -D COEFF=DIG(-0.06147346646f)DIG(-0.07180448622f)DIG(0.1147519723f)DIG(-0.1352790445f)DIG(-0.1516204625f)DIG(-0.1217835024f)DIG(-0.1543113738f)DIG(-0.1373673230f)DIG(-0.05160841346f) -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
