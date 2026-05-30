#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void LUT_C1( __global const srcT * src, __global const dstT *lut,
__global dstT *dst,
int cols1, int rows,
int src_offset1,
int lut_offset1,
int dst_offset1,
int src_step1, int dst_step1)
{
int x1 = get_global_id(0);
int y = get_global_id(1);
if (x1 < cols1 && y < rows)
{
int src_index = mad24(y, src_step1, src_offset1 + x1);
int dst_index = mad24(y, dst_step1, dst_offset1 + x1);
dst[dst_index] = lut[lut_offset1 + src[src_index]];
}
}
__kernel void LUT_C2( __global const srcT * src, __global const dstT *lut,
__global dstT *dst,
int cols1, int rows,
int src_offset1,
int lut_offset1,
int dst_offset1,
int src_step1, int dst_step1)
{
int x1 = get_global_id(0) << 1;
int y = get_global_id(1);
if (x1 < cols1 && y < rows)
{
int src_index = mad24(y, src_step1, src_offset1 + x1);
int dst_index = mad24(y, dst_step1, dst_offset1 + x1);
dst[dst_index    ] =                  lut[lut_offset1 + (src[src_index    ] << 1)    ];
dst[dst_index + 1] = x1 + 1 < cols1 ? lut[lut_offset1 + (src[src_index + 1] << 1) + 1] : dst[dst_index + 1];
}
}
__kernel void LUT_C4( __global const srcT * src, __global const dstT *lut,
__global dstT *dst,
int cols1, int rows,
int src_offset1,
int lut_offset1,
int dst_offset1,
int src_step1, int dst_step1)
{
int x1 = get_global_id(0) << 2;
int y = get_global_id(1);
if (x1 < cols1 && y < rows)
{
int src_index = mad24(y, src_step1, src_offset1 + x1);
int dst_index = mad24(y, dst_step1, dst_offset1 + x1);
dst[dst_index    ] =                  lut[lut_offset1 + (src[src_index    ] << 2)    ];
dst[dst_index + 1] = x1 + 1 < cols1 ? lut[lut_offset1 + (src[src_index + 1] << 2) + 1] : dst[dst_index + 1];
dst[dst_index + 2] = x1 + 2 < cols1 ? lut[lut_offset1 + (src[src_index + 2] << 2) + 2] : dst[dst_index + 2];
dst[dst_index + 3] = x1 + 3 < cols1 ? lut[lut_offset1 + (src[src_index + 3] << 2) + 3] : dst[dst_index + 3];
}
}


// buildOptions= -D INTEL_DEVICE -D srcT=uchar -D dstT=uchar
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D srcT=uchar -D dstT=uchar" %cfg_path --cl-device=%cl_device 2>&1
