#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
#ifdef VECTORIZED
__kernel void threshold(__global const T * restrict src, int src_offset, int src_step,
__global T * dst, int dst_offset, int dst_step,
T thresh, T max_val, int max_index, int rows, int cols)
{
int gx = get_global_id(0);
int gy = get_global_id(1);
if (gx < cols && gy < rows)
{
gx *= VECSIZE;
int src_index = mad24(gy, src_step, src_offset + gx);
int dst_index = mad24(gy, dst_step, dst_offset + gx);
#ifdef SRC_ALIGNED
VT sdata = *((__global VT *)(src + src_index));
#else
VT sdata = VLOADN(0, src + src_index);
#endif
VT vthresh = (VT)(thresh);
#ifdef THRESH_BINARY
VT vecValue = sdata > vthresh ? (VT)max_val : (VT)(0);
#elif defined THRESH_BINARY_INV
VT vecValue = sdata > vthresh ? (VT)(0) : (VT)max_val;
#elif defined THRESH_TRUNC
VT vecValue = sdata > vthresh ? (VT)thresh : sdata;
#elif defined THRESH_TOZERO
VT vecValue = sdata > vthresh ? sdata : (VT)(0);
#elif defined THRESH_TOZERO_INV
VT vecValue = sdata > vthresh ? (VT)(0) : sdata;
#endif
if (gx + VECSIZE <= max_index)
#ifdef DST_ALIGNED
*(__global VT*)(dst + dst_index) = vecValue;
#else
VSTOREN(vecValue, 0, dst + dst_index);
#endif
else
{
__attribute__(( aligned(sizeof(VT)) )) T array[VECSIZE];
*((VT*)array) = vecValue;
#pragma unroll
for (int i = 0; i < VECSIZE; ++i)
if (gx + i < max_index)
dst[dst_index + i] = array[i];
}
}
}
#else
__kernel void threshold(__global const T * restrict src, int src_offset, int src_step,
__global T * dst, int dst_offset, int dst_step,
T thresh, T max_val, int rows, int cols)
{
int gx = get_global_id(0);
int gy = get_global_id(1);
if (gx < cols && gy < rows)
{
int src_index = mad24(gy, src_step, src_offset + gx);
int dst_index = mad24(gy, dst_step, dst_offset + gx);
T sdata = src[src_index];
#ifdef THRESH_BINARY
dst[dst_index] = sdata > thresh ? max_val : (T)(0);
#elif defined THRESH_BINARY_INV
dst[dst_index] = sdata > thresh ? (T)(0) : max_val;
#elif defined THRESH_TRUNC
dst[dst_index] = sdata > thresh ? thresh : sdata;
#elif defined THRESH_TOZERO
dst[dst_index] = sdata > thresh ? sdata : (T)(0);
#elif defined THRESH_TOZERO_INV
dst[dst_index] = sdata > thresh ? (T)(0) : sdata;
#endif
}
}
#endif


// buildOptions= -D INTEL_DEVICE -D T=uchar4 -D THRESH_TOZERO_INV
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D T=uchar4 -D THRESH_TOZERO_INV" %cfg_path --cl-device=%cl_device 2>&1
