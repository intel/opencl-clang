#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void set_to_without_mask_C1_D0(__global uchar * scalar,__global uchar * dstMat,
int cols,int rows,int dstStep_in_pixel,int offset_in_pixel)
{
int x=get_global_id(0)<<2;
int y=get_global_id(1);
int idx = mad24(y,dstStep_in_pixel,x+ offset_in_pixel);
uchar4 out;
out.x = out.y = out.z = out.w = scalar[0];
if ( (x+3 < cols) && (y < rows)&& ((offset_in_pixel&3) == 0))
{
*(__global uchar4*)(dstMat+idx) = out;
}
else
{
if((x+3 < cols) && (y < rows))
{
dstMat[idx] = out.x;
dstMat[idx+1] = out.y;
dstMat[idx+2] = out.z;
dstMat[idx+3] = out.w;
}
if((x+2 < cols) && (y < rows))
{
dstMat[idx] = out.x;
dstMat[idx+1] = out.y;
dstMat[idx+2] = out.z;
}
else if((x+1 < cols) && (y < rows))
{
dstMat[idx] = out.x;
dstMat[idx+1] = out.y;
}
else if((x < cols) && (y < rows))
{
dstMat[idx] = out.x;
}
}
}
__kernel void set_to_without_mask(__global GENTYPE * scalar,__global GENTYPE * dstMat,
int cols, int rows, int dstStep_in_pixel, int offset_in_pixel)
{
int x = get_global_id(0);
int y = get_global_id(1);
if ( (x < cols) & (y < rows))
{
int idx = mad24(y, dstStep_in_pixel, x + offset_in_pixel);
dstMat[idx] = scalar[0];
}
}


// buildOptions= -D INTEL_DEVICE -D GENTYPE=uchar
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D GENTYPE=uchar" %cfg_path --cl-device=%cl_device 2>&1
