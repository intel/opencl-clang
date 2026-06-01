__kernel void columnSum_C1_D5(__global float * src, __global float * dst,
int cols, int rows, int src_step, int dst_step, int src_offset, int dst_offset)
{
const int x = get_global_id(0);
if (x < cols)
{
int srcIdx = x + src_offset;
int dstIdx = x + dst_offset;
float sum = 0;
for (int y = 0; y < rows; ++y)
{
sum += src[srcIdx];
dst[dstIdx] = sum;
srcIdx += src_step;
dstIdx += dst_step;
}
}
}


// buildOptions= -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
