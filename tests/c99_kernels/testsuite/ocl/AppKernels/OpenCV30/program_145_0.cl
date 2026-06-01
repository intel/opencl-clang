#ifdef DOUBLE_SUPPORT
#ifdef cl_amd_fp64
#pragma OPENCL EXTENSION cl_amd_fp64:enable
#elif defined (cl_khr_fp64)
#pragma OPENCL EXTENSION cl_khr_fp64:enable
#endif
#endif
__kernel void convert_to(
__global const srcT* restrict srcMat,
__global dstT* dstMat,
int cols1, int rows,
int sstep1, int soffset1,
int dstep1, int doffset1,
float alpha, float beta)
{
int x = get_global_id(0);
int y = get_global_id(1);
int srcidx = mad24(y, sstep1, x + soffset1);
int dstidx = mad24(y, dstep1, x + doffset1);
if ( (x < cols1) && (y < rows) )
{
float temp_src = convert_float(srcMat[srcidx]);
dstMat[dstidx] = convertToDstType(temp_src*alpha+beta);
}
}


// buildOptions= -D INTEL_DEVICE -D srcT=ushort -D dstT=uchar -D convertToDstType=convert_uchar_sat_rte
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D INTEL_DEVICE -D srcT=ushort -D dstT=uchar -D convertToDstType=convert_uchar_sat_rte" %cfg_path --cl-device=%cl_device 2>&1
