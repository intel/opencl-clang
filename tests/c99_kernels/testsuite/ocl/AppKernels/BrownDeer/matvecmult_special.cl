/* matvecmult_special.cl */

__kernel void matvecmult_special_kern(
   uint n,
	__global float* aa,
	__global float* b,
	__global float* c,
	__read_only image2d_t table
)
{
	const sampler_t sampler0
		= CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;

   int i = get_global_id(0);
   int j;
   float tmp = 0.0f;
   for(j=0;j<n;j++) {
		int ri = i%24;
		int rj = j%24;
		float4 coef = read_imagef(table, sampler0, (int2)(ri,rj));
		tmp += coef.x * aa[i*n+j] * b[j];
	}
   c[i] = tmp;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
