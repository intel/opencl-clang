/* outerprod.cl */

#ifndef COEF
#define COEF 1
#endif

__kernel void outerprod_kern(
   __global float* a,
	__global float* b,
	__global float* c
)
{
   int i = get_global_id(0);
   c[i] = COEF * a[i] * b[i];
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
