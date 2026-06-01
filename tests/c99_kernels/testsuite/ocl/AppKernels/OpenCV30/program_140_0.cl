#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void set_to_with_mask(
__global GENTYPE * scalar,
__global GENTYPE * dstMat,
int cols,
int rows,
int dstStep_in_pixel,
int dstoffset_in_pixel,
__global const uchar * restrict maskMat,
int maskStep,
int maskoffset)
{
int x = get_global_id(0);
int y = get_global_id(1);
if (x < cols && y < rows)
{
int maskidx = mad24(y,maskStep,x+ maskoffset);
if (maskMat[maskidx])
{
int dstidx = mad24(y,dstStep_in_pixel,x+ dstoffset_in_pixel);
dstMat[dstidx] = scalar[0];
}
}
}


// buildOptions= -D INTEL_DEVICE -D GENTYPE=uchar
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D GENTYPE=uchar" %cfg_path --cl-device=%cl_device 2>&1
