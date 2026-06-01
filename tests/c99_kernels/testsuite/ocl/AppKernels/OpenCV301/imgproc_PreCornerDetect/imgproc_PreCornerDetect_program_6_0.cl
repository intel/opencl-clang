__kernel void preCornerDetect(__global const uchar * Dxptr, int dx_step, int dx_offset,
__global const uchar * Dyptr, int dy_step, int dy_offset,
__global const uchar * D2xptr, int d2x_step, int d2x_offset,
__global const uchar * D2yptr, int d2y_step, int d2y_offset,
__global const uchar * Dxyptr, int dxy_step, int dxy_offset,
__global uchar * dstptr, int dst_step, int dst_offset,
int dst_rows, int dst_cols, float factor)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < dst_cols && y < dst_rows)
{
int dx_index = mad24(dx_step, y, (int)sizeof(float) * x + dx_offset);
int dy_index = mad24(dy_step, y, (int)sizeof(float) * x + dy_offset);
int d2x_index = mad24(d2x_step, y, (int)sizeof(float) * x + d2x_offset);
int d2y_index = mad24(d2y_step, y, (int)sizeof(float) * x + d2y_offset);
int dxy_index = mad24(dxy_step, y, (int)sizeof(float) * x + dxy_offset);
int dst_index = mad24(dst_step, y, (int)sizeof(float) * x + dst_offset);
float dx = *(__global const float *)(Dxptr + dx_index);
float dy = *(__global const float *)(Dyptr + dy_index);
float d2x = *(__global const float *)(D2xptr + d2x_index);
float d2y = *(__global const float *)(D2yptr + d2y_index);
float dxy = *(__global const float *)(Dxyptr + dxy_index);
__global float * dst = (__global float *)(dstptr + dst_index);
dst[0] = factor * (dx*dx*d2y + dy*dy*d2x - 2*dx*dy*dxy);
}
}


// buildOptions= -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
