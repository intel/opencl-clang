#ifdef FP_64
#ifdef cl_khr_fp64 //Khronos extension available
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#define DOUBLE_SUPPORT_AVAILABLE
#elif defined(cl_amd_fp64) //AMD extension available
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
#define DOUBLE_SUPPORT_AVAILABLE
#endif
#endif
#ifdef DOUBLE_SUPPORT_AVAILABLE
//double
typedef double myreal;
#else
//float
typedef float myreal;
#endif
__kernel void calcURatios(__global myreal *ratios, __global myreal *rhs, myreal c, myreal r)
{
size_t gid = get_global_id(0);
myreal pRatios = ratios[gid];
myreal pRHS = rhs[gid];
pRatios = pRatios / c;
ratios[gid] = pRatios;
//pRatios = pRatios * r;
pRHS = pRHS - (pRatios * r);
rhs[gid] = pRHS;
}
//__kernel void reduceURatios(__global myreal *coef, __global myreal *row, myreal ratio)
//{
//    size_t gid = get_global_id(0);
//
//    myreal pCoef = coef[gid];
//    myreal pRow = row[gid];
//
//    pCoef = pCoef - (pRow * ratio);
//    coef[gid] = pCoef;
//}
__kernel void reduceURatios(__global myreal *coef, __global myreal *ref, __constant myreal *ratios, __private const int nvar, __private const int offset, __private const int r)
{
size_t gid = get_global_id(0);
myreal pCoef = coef[gid];
const int minus = nvar - r;
myreal pRef = ref[gid % minus];
myreal ratio = ratios[(gid + offset) / minus];
pCoef = pCoef - (pRef * ratio);
coef[gid] = pCoef;
}


// buildOptions=-cl-denorms-are-zero
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-denorms-are-zero" %cfg_path --cl-device=%cl_device 2>&1
