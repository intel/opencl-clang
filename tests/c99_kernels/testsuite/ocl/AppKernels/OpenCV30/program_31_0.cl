__kernel void arithm_bitwise_binary(__global uchar * src1, int src1_step, int src1_offset,
__global uchar * src2, int src2_step, int src2_offset,
__global uchar * dst, int dst_step, int dst_offset,
int cols, int rows)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
#if elemSize > 1
x *= elemSize;
#endif
int src1_index = mad24(y, src1_step, x + src1_offset);
int src2_index = mad24(y, src2_step, x + src2_offset);
int dst_index = mad24(y, dst_step, x + dst_offset);
#if elemSize > 1
#pragma unroll
for (int i = 0; i < elemSize; i += vlen)
{
ucharv t0 = vloadn(0, src1 + src1_index + i);
ucharv t1 = vloadn(0, src2 + src2_index + i);
ucharv t2 = t0 Operation t1;
vstoren(t2, 0, dst + dst_index + i);
}
#else
dst[dst_index] = src1[src1_index] Operation src2[src2_index];
#endif
}
}


// buildOptions= -D INTEL_DEVICE -D Operation=& -D vloadn=vload -D vstoren=vstore -D elemSize=1 -D vlen=1 -D ucharv=uchar
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D Operation=& -D vloadn=vload -D vstoren=vstore -D elemSize=1 -D vlen=1 -D ucharv=uchar" %cfg_path --cl-device=%cl_device 2>&1
