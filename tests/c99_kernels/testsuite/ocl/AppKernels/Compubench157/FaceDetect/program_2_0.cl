#define USEBUFF
__kernel void integralStep1 (
	__global float* restrict intensity,
	__global float* restrict sat,
	__global float* restrict quadSat,
	const int height)
{
	const int x = get_global_id(0);
	const int width = get_global_size(0);
	float tmpQuadSat = 0.0f;
	float tmpSat = 0.0f;

	for (int y = 0; y < height; y++)
	{
		const float currIntensity = intensity[y*width+x];
		const int ind = y*width+x;
		tmpSat += currIntensity;
		tmpQuadSat += (currIntensity * currIntensity);

		sat[ind] = tmpSat;
		quadSat[ind] = tmpQuadSat;
	}
}

__kernel void integralStep2 (
	__global float* restrict srcSat,
	__global float* restrict destSat,
	__global float* restrict srcQuadSat,
	__global float* restrict destQuadSat,
	const int height)
{
	const int x = get_global_id(0);
	const int width = get_global_size(0);
	float tmpSat = 0.0f;
	float tmpQuadSat = 0.0f;

	for (int y = 0; y < height; y++) {
		tmpSat += srcSat[y*width + x];
		destSat[y*width + x] = tmpSat;

		tmpQuadSat += srcQuadSat[y*width + x];
		destQuadSat[y*width + x] = tmpQuadSat;
	}
}

__kernel __attribute__((reqd_work_group_size (16,16,1)))
__kernel void transposeLocal16x16( const int w, const int h ,__global const float* restrict in, __global float* restrict out)
{
	local float aux[16*16];
	int bx = get_group_id(0),
		by = get_group_id(1);
	int ix = get_local_id(0),
		iy = get_local_id(1);

	by = (by+bx)%get_num_groups(1);

	in += (bx*16)+(by*16)*w;
	out += (by*16)+(bx*16)*h;

	aux[iy+ix*16] = in[ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);
	out[ix+h*iy] = aux[ix+iy*16];
	barrier(CLK_LOCAL_MEM_FENCE);
}

__kernel __attribute__((reqd_work_group_size (8,8,1)))
__kernel void transposeLocal8x8( const int w, const int h ,__global const float* restrict in, __global float* restrict out)
{
	local float aux[8*8];
	int bx = get_group_id(0),
		by = get_group_id(1);
	int ix = get_local_id(0),
		iy = get_local_id(1);

	by = (by+bx)%get_num_groups(1);

	in += (bx*8)+(by*8)*w;
	out += (by*8)+(bx*8)*h;

	aux[iy+ix*8] = in[ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);
	out[ix+h*iy] = aux[ix+iy*8];
	barrier(CLK_LOCAL_MEM_FENCE);
}

__kernel void transposeGlobal(const int w, const int h , __global const float* restrict in, __global  float* restrict out)
{
	const size_t x = get_global_id(0);
	const size_t y = get_global_id(1);

	out[y+x*h] = in[x+y*w];
}

__kernel void satVertical_image
(
	__read_only image2d_t intensity,
	__write_only image2d_t sat,
	__write_only image2d_t quadSat
)
{
	const int x = get_global_id(0);
	const int height = get_image_height(intensity);
	const sampler_t smp = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;

	float tmpSat = 0.0f;
	float tmpQuadSat = 0.0f;

	for(int colId = 0; colId < height; ++colId)
	{
		const int2 coords = (int2)(x, colId);

		const float currIntensity = read_imagef(intensity, smp, coords).x;

		tmpSat += currIntensity;
		tmpQuadSat += (currIntensity * currIntensity);

		write_imagef( sat, coords, (float4)(tmpSat) );
		write_imagef( quadSat, coords, (float4)(tmpQuadSat) );
	}
}

__kernel void satHorizontal_image
(
	__read_only image2d_t srcSat,
	__write_only image2d_t destSat,
	__read_only image2d_t srcQuadSat,
	__write_only image2d_t destQuadSat
)
{
	const int x = get_global_id(0);
	const int width = get_image_width(srcSat);
	const sampler_t smp = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;

	float tmpSat = 0.0f;
	float tmpQuadSat = 0.0f;

	for(int rowId = 0; rowId < width; ++rowId)
	{
		const int2 coords = (int2)(rowId, x);

		tmpSat += read_imagef(srcSat, smp, coords).x;
		tmpQuadSat += read_imagef(srcQuadSat, smp, coords).x;

		write_imagef( destSat, coords, (float4)(tmpSat) );
		write_imagef( destQuadSat, coords, (float4)(tmpQuadSat) );
	}
}

#ifdef USEIMG

__kernel void createIntensity(read_only image2d_t source, write_only image2d_t result)
{
	const int2 coords = (int2)(get_global_id(0), get_global_id(1));

	const sampler_t smp = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_NONE | CLK_FILTER_NEAREST;

	float4 color = convert_float4( read_imageui(source, smp, coords) );

	float intensity = dot( (float4)(0.2989f, 0.5870f, 0.1140f, 0.0f), color );

	write_imagef( result, coords, (float4)(intensity) );
}

#else

__kernel void createIntensity(__global const uchar4* restrict source, __global float* restrict result)
{
	uint x = get_global_id(0);
	uint y = get_global_id(1);
	uint with = get_global_size(0);

	float4 color = convert_float4( source[x + y * with] );

	float intensity = dot( (float4)(0.2989f, 0.5870f, 0.1140f, 0.0f), color );

	result[ x + y * with ] = intensity;
}

#endif


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
