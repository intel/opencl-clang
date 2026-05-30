#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#define noconvert
#if cn != 3
#define loadpix(addr) *(__global const srcT *)(addr)
#define storepix(val, addr)  *(__global dstT *)(addr) = val
#define srcTSIZE (int)sizeof(srcT)
#define dstTSIZE (int)sizeof(dstT)
#else
#define loadpix(addr) vload3(0, (__global const srcT1 *)(addr))
#define storepix(val, addr) vstore3(val, 0, (__global dstT1 *)(addr))
#define srcTSIZE ((int)sizeof(srcT1)*3)
#define dstTSIZE ((int)sizeof(dstT1)*3)
#endif
__kernel void normalizek(__global const uchar * srcptr, int src_step, int src_offset,
__global const uchar * mask, int mask_step, int mask_offset,
__global uchar * dstptr, int dst_step, int dst_offset, int dst_rows, int dst_cols
#ifdef HAVE_SCALE
, float scale
#endif
#ifdef HAVE_DELTA
, float delta
#endif
)
{
int x = get_global_id(0);
int y0 = get_global_id(1) * rowsPerWI;
if (x < dst_cols)
{
int src_index  = mad24(y0, src_step, mad24(x, srcTSIZE, src_offset));
int mask_index = mad24(y0, mask_step, x + mask_offset);
int dst_index  = mad24(y0, dst_step, mad24(x, dstTSIZE, dst_offset));
for (int y = y0, y1 = min(y0 + rowsPerWI, dst_rows); y < y1;
++y, src_index += src_step, dst_index += dst_step, mask_index += mask_step)
{
if (mask[mask_index])
{
workT value = convertToWT(loadpix(srcptr + src_index));
#ifdef HAVE_SCALE
#ifdef HAVE_DELTA
value = fma(value, (workT)(scale), (workT)(delta));
#else
value *= (workT)(scale);
#endif
#else
#ifdef HAVE_DELTA
value += (workT)(delta);
#endif
#endif
storepix(convertToDT(value), dstptr + dst_index);
}
}
}
}


// buildOptions=-D srcT=uchar -D dstT=uchar -D convertToWT=convert_float -D cn=1 -D rowsPerWI=4 -D convertToDT=convert_uchar_sat_rte -D workT=float -D HAVE_SCALE -D HAVE_DELTA -D srcT1=uchar -D dstT1=uchar -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D srcT=uchar -D dstT=uchar -D convertToWT=convert_float -D cn=1 -D rowsPerWI=4 -D convertToDT=convert_uchar_sat_rte -D workT=float -D HAVE_SCALE -D HAVE_DELTA -D srcT1=uchar -D dstT1=uchar -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
