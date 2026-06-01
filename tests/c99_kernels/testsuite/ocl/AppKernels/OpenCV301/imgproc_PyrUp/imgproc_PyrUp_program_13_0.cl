#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#if cn != 3
#define loadpix(addr)  *(__global const T*)(addr)
#define storepix(val, addr)  *(__global T*)(addr) = (val)
#define PIXSIZE ((int)sizeof(T))
#else
#define loadpix(addr)  vload3(0, (__global const T1*)(addr))
#define storepix(val, addr) vstore3((val), 0, (__global T1*)(addr))
#define PIXSIZE ((int)sizeof(T1)*3)
#endif
#define EXTRAPOLATE(x, maxV) min(maxV - 1, (int) abs(x))
#define noconvert
__kernel void pyrUp(__global const uchar * src, int src_step, int src_offset, int src_rows, int src_cols,
__global uchar * dst, int dst_step, int dst_offset, int dst_rows, int dst_cols)
{
const int x = get_global_id(0);
const int y = get_global_id(1);
const int tidx = get_local_id(0);
const int tidy = get_local_id(1);
__local FT s_srcPatch[LOCAL_SIZE/2 + 2][LOCAL_SIZE/2 + 2];
__local FT s_dstPatch[LOCAL_SIZE/2 + 2][LOCAL_SIZE];
__global uchar * dstData = dst + dst_offset;
__global const uchar * srcData = src + src_offset;
if( tidx < (LOCAL_SIZE/2 + 2) && tidy < LOCAL_SIZE/2 + 2 )
{
int srcx = EXTRAPOLATE(mad24((int)get_group_id(0), LOCAL_SIZE/2, tidx) - 1, src_cols);
int srcy = EXTRAPOLATE(mad24((int)get_group_id(1), LOCAL_SIZE/2, tidy) - 1, src_rows);
s_srcPatch[tidy][tidx] = convertToFT(loadpix(srcData + srcy * src_step + srcx * PIXSIZE));
}
barrier(CLK_LOCAL_MEM_FENCE);
FT sum = 0.f;
const FT co1 = 0.75f;
const FT co2 = 0.5f;
const FT co3 = 0.125f;
const FT coef1 = (tidx & 1) == 0 ? co1 : (FT) 0;
const FT coef2 = (tidx & 1) == 0 ? co3 : co2;
const FT coefy1 = (tidy & 1) == 0 ? co1 : (FT) 0;
const FT coefy2 = (tidy & 1) == 0 ? co3 : co2;
if(tidy < LOCAL_SIZE/2 + 2)
{
sum =     coef2* s_srcPatch[tidy][1 + ((tidx - 1) >> 1)];
sum = mad(coef1, s_srcPatch[tidy][1 + ((tidx    ) >> 1)], sum);
sum = mad(coef2, s_srcPatch[tidy][1 + ((tidx + 2) >> 1)], sum);
s_dstPatch[tidy][tidx] = sum;
}
barrier(CLK_LOCAL_MEM_FENCE);
sum =     coefy2* s_dstPatch[1 + ((tidy - 1) >> 1)][tidx];
sum = mad(coefy1, s_dstPatch[1 + ((tidy    ) >> 1)][tidx], sum);
sum = mad(coefy2, s_dstPatch[1 + ((tidy + 2) >> 1)][tidx], sum);
if ((x < dst_cols) && (y < dst_rows))
storepix(convertToT(sum), dstData + y * dst_step + x * PIXSIZE);
}
__kernel void pyrUp_unrolled(__global const uchar * src, int src_step, int src_offset, int src_rows, int src_cols,
__global uchar * dst, int dst_step, int dst_offset, int dst_rows, int dst_cols)
{
const int lx = 2*get_local_id(0);
const int ly = 2*get_local_id(1);
__local FT s_srcPatch[LOCAL_SIZE+2][LOCAL_SIZE+2];
__local FT s_dstPatch[LOCAL_SIZE+2][2*LOCAL_SIZE];
__global uchar * dstData = dst + dst_offset;
__global const uchar * srcData = src + src_offset;
if( lx < (LOCAL_SIZE+2) && ly < (LOCAL_SIZE+2) )
{
int srcx = mad24((int)get_group_id(0), LOCAL_SIZE, lx) - 1;
int srcy = mad24((int)get_group_id(1), LOCAL_SIZE, ly) - 1;
int srcx1 = EXTRAPOLATE(srcx, src_cols);
int srcx2 = EXTRAPOLATE(srcx+1, src_cols);
int srcy1 = EXTRAPOLATE(srcy, src_rows);
int srcy2 = EXTRAPOLATE(srcy+1, src_rows);
s_srcPatch[ly][lx] = convertToFT(loadpix(srcData + srcy1 * src_step + srcx1 * PIXSIZE));
s_srcPatch[ly+1][lx] = convertToFT(loadpix(srcData + srcy2 * src_step + srcx1 * PIXSIZE));
s_srcPatch[ly][lx+1] = convertToFT(loadpix(srcData + srcy1 * src_step + srcx2 * PIXSIZE));
s_srcPatch[ly+1][lx+1] = convertToFT(loadpix(srcData + srcy2 * src_step + srcx2 * PIXSIZE));
}
barrier(CLK_LOCAL_MEM_FENCE);
FT sum;
const FT co1 = 0.75f;
const FT co2 = 0.5f;
const FT co3 = 0.125f;
sum =       co3 * s_srcPatch[1 + (ly >> 1)][1 + ((lx - 2) >> 1)];
sum = mad(co1, s_srcPatch[1 + (ly >> 1)][1 + ((lx    ) >> 1)], sum);
sum = mad(co3, s_srcPatch[1 + (ly >> 1)][1 + ((lx + 2) >> 1)], sum);
s_dstPatch[1 + get_local_id(1)][lx] = sum;
sum =       co2 * s_srcPatch[1 + (ly >> 1)][1 + ((lx + 1 - 1) >> 1)];
sum = mad(co2, s_srcPatch[1 + (ly >> 1)][1 + ((lx + 1 + 1) >> 1)], sum);
s_dstPatch[1 + get_local_id(1)][lx+1] = sum;
if (ly < 1)
{
sum =       co3 * s_srcPatch[0][1 + ((lx - 2) >> 1)];
sum = mad(co1, s_srcPatch[0][1 + ((lx    ) >> 1)], sum);
sum = mad(co3, s_srcPatch[0][1 + ((lx + 2) >> 1)], sum);
s_dstPatch[0][lx] = sum;
sum =       co2 * s_srcPatch[0][1 + ((lx + 1 - 1) >> 1)];
sum = mad(co2, s_srcPatch[0][1 + ((lx + 1 + 1) >> 1)], sum);
s_dstPatch[0][lx+1] = sum;
}
if (ly > 2*LOCAL_SIZE-3)
{
sum =       co3 * s_srcPatch[LOCAL_SIZE+1][1 + ((lx - 2) >> 1)];
sum = mad(co1, s_srcPatch[LOCAL_SIZE+1][1 + ((lx    ) >> 1)], sum);
sum = mad(co3, s_srcPatch[LOCAL_SIZE+1][1 + ((lx + 2) >> 1)], sum);
s_dstPatch[LOCAL_SIZE+1][lx] = sum;
sum =       co2 * s_srcPatch[LOCAL_SIZE+1][1 + ((lx + 1 - 1) >> 1)];
sum = mad(co2, s_srcPatch[LOCAL_SIZE+1][1 + ((lx + 1 + 1) >> 1)], sum);
s_dstPatch[LOCAL_SIZE+1][lx+1] = sum;
}
barrier(CLK_LOCAL_MEM_FENCE);
int dst_x = 2*get_global_id(0);
int dst_y = 2*get_global_id(1);
if ((dst_x < dst_cols) && (dst_y < dst_rows))
{
sum =       co3 * s_dstPatch[1 + get_local_id(1) - 1][lx];
sum = mad(co1, s_dstPatch[1 + get_local_id(1)    ][lx], sum);
sum = mad(co3, s_dstPatch[1 + get_local_id(1) + 1][lx], sum);
storepix(convertToT(sum), dstData + dst_y * dst_step + dst_x * PIXSIZE);
sum =       co3 * s_dstPatch[1 + get_local_id(1) - 1][lx+1];
sum = mad(co1, s_dstPatch[1 + get_local_id(1)    ][lx+1], sum);
sum = mad(co3, s_dstPatch[1 + get_local_id(1) + 1][lx+1], sum);
storepix(convertToT(sum), dstData + dst_y * dst_step + (dst_x+1) * PIXSIZE);
sum =       co2 * s_dstPatch[1 + get_local_id(1)    ][lx];
sum = mad(co2, s_dstPatch[1 + get_local_id(1) + 1][lx], sum);
storepix(convertToT(sum), dstData + (dst_y+1) * dst_step + dst_x * PIXSIZE);
sum =       co2 * s_dstPatch[1 + get_local_id(1)    ][lx+1];
sum = mad(co2, s_dstPatch[1 + get_local_id(1) + 1][lx+1], sum);
storepix(convertToT(sum), dstData + (dst_y+1) * dst_step + (dst_x+1) * PIXSIZE);
}
}


// buildOptions=-D T=float -D FT=float -D convertToT=noconvert -D convertToFT=noconvert -D T1=float -D cn=1 -D LOCAL_SIZE=16 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D T=float -D FT=float -D convertToT=noconvert -D convertToFT=noconvert -D T1=float -D cn=1 -D LOCAL_SIZE=16 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
