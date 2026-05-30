#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void arithm_op_nonzero(int cols, int invalid_cols, int offset, int elemnum, int groupnum,
__global srcT *src, __global dstT *dst)
{
int lid = get_local_id(0);
int gid = get_group_id(0);
int  id = get_global_id(0);
int idx = offset + id + (id / cols) * invalid_cols;
__local dstT localmem_nonzero[128];
dstT nonzero = (dstT)(0);
srcT zero = (srcT)(0), one = (srcT)(1);
for (int grain = groupnum << 8; id < elemnum; id += grain)
{
idx = offset + id + (id / cols) * invalid_cols;
nonzero += src[idx] == zero ? zero : one;
}
if (lid > 127)
localmem_nonzero[lid - 128] = nonzero;
barrier(CLK_LOCAL_MEM_FENCE);
if (lid < 128)
localmem_nonzero[lid] = nonzero + localmem_nonzero[lid];
barrier(CLK_LOCAL_MEM_FENCE);
for (int lsize = 64; lsize > 0; lsize >>= 1)
{
if (lid < lsize)
{
int lid2 = lsize + lid;
localmem_nonzero[lid] = localmem_nonzero[lid] + localmem_nonzero[lid2];
}
barrier(CLK_LOCAL_MEM_FENCE);
}
if (lid == 0)
dst[gid] = localmem_nonzero[0];
}


// buildOptions= -D INTEL_DEVICE -D srcT=uchar -D dstT=int
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D srcT=uchar -D dstT=int" %cfg_path --cl-device=%cl_device 2>&1
