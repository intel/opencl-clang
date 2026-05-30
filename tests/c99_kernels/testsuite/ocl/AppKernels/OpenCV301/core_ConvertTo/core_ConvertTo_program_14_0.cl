#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#define noconvert
__kernel void convertTo(__global const uchar * srcptr, int src_step, int src_offset,
__global uchar * dstptr, int dst_step, int dst_offset, int dst_rows, int dst_cols,
#ifndef NO_SCALE
WT alpha, WT beta,
#endif
int rowsPerWI)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < dst_cols)
{
int src_index = mad24(y0, src_step, mad24(x, (int)sizeof(srcT), src_offset));
int dst_index = mad24(y0, dst_step, mad24(x, (int)sizeof(dstT), dst_offset));
for (int y = y0, y1 = min(dst_rows, y0 + rowsPerWI); y < y1; ++y, src_index += src_step, dst_index += dst_step)
{
__global const srcT * src = (__global const srcT *)(srcptr + src_index);
__global dstT * dst = (__global dstT *)(dstptr + dst_index);
#ifdef NO_SCALE
dst[0] = convertToDT(src[0]);
#else
dst[0] = convertToDT(fma(convertToWT(src[0]), alpha, beta));
#endif
}
}
}


// buildOptions=-D srcT=ushort -D WT=float -D dstT=char -D convertToWT=convert_float -D convertToDT=convert_char_sat_rte -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D srcT=ushort -D WT=float -D dstT=char -D convertToWT=convert_float -D convertToDT=convert_char_sat_rte -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
