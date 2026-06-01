#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void threshold(__global const uchar * srcptr, int src_step, int src_offset,
__global uchar * dstptr, int dst_step, int dst_offset, int rows, int cols,
T1 thresh, T1 max_val, T1 min_val)
{
int gx = get_global_id(0);
int gy = get_global_id(1) * STRIDE_SIZE;
if (gx < cols)
{
int src_index = mad24(gy, src_step, mad24(gx, (int)sizeof(T), src_offset));
int dst_index = mad24(gy, dst_step, mad24(gx, (int)sizeof(T), dst_offset));
#pragma unroll
for (int i = 0; i < STRIDE_SIZE; i++)
{
if (gy < rows)
{
T sdata = *(__global const T *)(srcptr + src_index);
__global T * dst = (__global T *)(dstptr + dst_index);
#ifdef THRESH_BINARY
dst[0] = sdata > (thresh) ? (T)(max_val) : (T)(0);
#elif defined THRESH_BINARY_INV
dst[0] = sdata > (thresh) ? (T)(0) : (T)(max_val);
#elif defined THRESH_TRUNC
dst[0] = clamp(sdata, (T)min_val, (T)(thresh));
#elif defined THRESH_TOZERO
dst[0] = sdata > (thresh) ? sdata : (T)(0);
#elif defined THRESH_TOZERO_INV
dst[0] = sdata > (thresh) ? (T)(0) : sdata;
#endif
gy++;
src_index += src_step;
dst_index += dst_step;
}
}
}
}


// buildOptions=-D THRESH_TRUNC -D T=uchar4 -D T1=uchar -D STRIDE_SIZE=4 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D THRESH_TRUNC -D T=uchar4 -D T1=uchar -D STRIDE_SIZE=4 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
