#if cn != 3
#define loadpix(addr) *(__global const T *)(addr)
#define storepix(val, addr)  *(__global T *)(addr) = val
#define TSIZE (int)sizeof(T)
#else
#define loadpix(addr) vload3(0, (__global const T1 *)(addr))
#define storepix(val, addr) vstore3(val, 0, (__global T1 *)(addr))
#define TSIZE ((int)sizeof(T1)*3)
#endif
#ifndef INPLACE
#define LDS_STEP      (TILE_DIM + 1)
__kernel void transpose(__global const uchar * srcptr, int src_step, int src_offset, int src_rows, int src_cols,
__global uchar * dstptr, int dst_step, int dst_offset)
{
int gp_x = get_group_id(0),   gp_y = get_group_id(1);
int gs_x = get_num_groups(0), gs_y = get_num_groups(1);
int groupId_x, groupId_y;
if (src_rows == src_cols)
{
groupId_y = gp_x;
groupId_x = (gp_x + gp_y) % gs_x;
}
else
{
int bid = mad24(gs_x, gp_y, gp_x);
groupId_y =  bid % gs_y;
groupId_x = ((bid / gs_y) + groupId_y) % gs_x;
}
int lx = get_local_id(0);
int ly = get_local_id(1);
int x = mad24(groupId_x, TILE_DIM, lx);
int y = mad24(groupId_y, TILE_DIM, ly);
int x_index = mad24(groupId_y, TILE_DIM, lx);
int y_index = mad24(groupId_x, TILE_DIM, ly);
__local T tile[TILE_DIM * LDS_STEP];
if (x < src_cols && y < src_rows)
{
int index_src = mad24(y, src_step, mad24(x, TSIZE, src_offset));
#pragma unroll
for (int i = 0; i < TILE_DIM; i += BLOCK_ROWS)
if (y + i < src_rows)
{
tile[mad24(ly + i, LDS_STEP, lx)] = loadpix(srcptr + index_src);
index_src = mad24(BLOCK_ROWS, src_step, index_src);
}
}
barrier(CLK_LOCAL_MEM_FENCE);
if (x_index < src_rows && y_index < src_cols)
{
int index_dst = mad24(y_index, dst_step, mad24(x_index, TSIZE, dst_offset));
#pragma unroll
for (int i = 0; i < TILE_DIM; i += BLOCK_ROWS)
if ((y_index + i) < src_cols)
{
storepix(tile[mad24(lx, LDS_STEP, ly + i)], dstptr + index_dst);
index_dst = mad24(BLOCK_ROWS, dst_step, index_dst);
}
}
}
#else
__kernel void transpose_inplace(__global uchar * srcptr, int src_step, int src_offset, int src_rows)
{
int x = get_global_id(0);
int y = get_global_id(1) * rowsPerWI;
if (x < y + rowsPerWI)
{
int src_index = mad24(y, src_step, mad24(x, TSIZE, src_offset));
int dst_index = mad24(x, src_step, mad24(y, TSIZE, src_offset));
T tmp;
#pragma unroll
for (int i = 0; i < rowsPerWI; ++i, ++y, src_index += src_step, dst_index += TSIZE)
if (y < src_rows && x < y)
{
__global uchar * src = srcptr + src_index;
__global uchar * dst = srcptr + dst_index;
tmp = loadpix(dst);
storepix(loadpix(src), dst);
storepix(tmp, src);
}
}
}
#endif


// buildOptions=-D T=ulong -D T1=ulong -D cn=1 -D TILE_DIM=32 -D BLOCK_ROWS=8 -D rowsPerWI=4 -D INTEL_DEVICE
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D T=ulong -D T1=ulong -D cn=1 -D TILE_DIM=32 -D BLOCK_ROWS=8 -D rowsPerWI=4 -D INTEL_DEVICE" %cfg_path --cl-device=%cl_device 2>&1
