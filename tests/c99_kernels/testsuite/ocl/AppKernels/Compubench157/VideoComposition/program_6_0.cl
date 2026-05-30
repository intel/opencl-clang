#define USE_UCHAR4
#ifdef USE_FLOAT4
	#define DATATYPE float4
	#define DATATYPEIMG float4
	#define READIMG read_imagef
	#define WRITEIMG write_imagef
	#define CONVERTU4
	#define CONVERTU4IMG
	#define CONVERTF4
#endif

#ifdef USE_UCHAR4
	#define DATATYPE uchar4
	#define DATATYPEIMG uint4
	#define WRITEIMG write_imageui
	#define READIMG read_imageui
	#define CONVERTU4 convert_uchar4
	#define CONVERTU4IMG convert_uint4
	#define CONVERTF4 convert_float4
#endif

__kernel
void copyBuffer( __global DATATYPE* restrict input, __global DATATYPE* restrict output )
{
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);

	const size_t sizeX = get_global_size(0);
	//const size_t sizeY = get_global_size(1);

	output[idY * sizeX + idX] = input[idY * sizeX + idX];
}

__kernel
void transposeBuffer( __global DATATYPE* restrict input, __global DATATYPE* restrict output )
{
	const size_t idX = get_global_id(0);
	const size_t idY = get_global_id(1);

	const size_t sizeX = get_global_size(0);
	const size_t sizeY = get_global_size(1);

	output[idX * sizeY + idY] = input[idY * sizeX + idX];
}

__kernel __attribute__((reqd_work_group_size (16,16,1)))
void transposeBufferLocal16x16( __global DATATYPE* restrict input, __global DATATYPE* restrict output )
{
	local DATATYPE aux[256];
	size_t bx = get_group_id(0);
	size_t by = get_group_id(1);
	size_t ix = get_local_id(0);
	size_t iy = get_local_id(1);

	size_t w = get_global_size(0);
	size_t h = get_global_size(1);

	by = (by+bx)%get_num_groups(1);

	input += (bx*16)+(by*16)*w;
	output += (by*16)+(bx*16)*h;

	aux[iy+ix*16] = input[ix+w*iy];
	barrier(CLK_LOCAL_MEM_FENCE);

	output[ix+h*iy] = aux[ix+iy*16];
}

__kernel
void copyImage( __read_only image2d_t input, __write_only image2d_t output )
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	WRITEIMG(output, (int2)(idX,idY), READIMG(input, sampler, (int2)(idX,idY)));
}

__kernel
void transposeImage( __read_only image2d_t input, __write_only image2d_t output )
{
	const sampler_t sampler =
		CLK_NORMALIZED_COORDS_FALSE |
		CLK_ADDRESS_CLAMP_TO_EDGE |
		CLK_FILTER_NEAREST;

	const int idX = get_global_id(0);
	const int idY = get_global_id(1);

	WRITEIMG(output, (int2)(idY,idX), READIMG(input, sampler, (int2)(idX,idY)));
}

// TODO: shuffle version instead of swizzle

inline int4 sortElements4Asc(int4 data)
{
	data = (data.s0123 > data.s1032) ? data.s1122 : data.s0033;

	data = (data.s0123 > data.s2301) ? data.s2323 : data.s0101;
	data = (data.s0123 > data.s1032) ? data.s1133 : data.s0022;

	return data;
}

inline int4 sortElements4Dsc(int4 data)
{
	data = (data.s0123 > data.s1032) ? data.s1122 : data.s0033;

	data = (data.s0123 < data.s2301) ? data.s2323 : data.s0101;
	data = (data.s0123 < data.s1032) ? data.s1133 : data.s0022;

	return data;
}

__kernel
void createSortedSeq4( __global const int4* restrict input, __global int4* restrict output )
{
	const int i = get_global_id(0);

	int4 data = input[i];

	data = sortElements4Asc( data );

	output[i] = data;
}

__kernel
void createBitonicSeq8( __global const int4* restrict input, __global int4* restrict output )
{
	const int i = get_global_id(0);

	int4 data = input[i];

	if(i & 1)
		data = sortElements4Dsc( data );
	else
		data = sortElements4Asc( data );

	output[i] = data;
}

__kernel
void createBitonicSplit4( __global const int4* restrict input, __global int4* restrict output, const int offset )
{
	const int i = get_global_id(0);

	int4 data0 = input[i];
	int4 data1 = input[i+offset];

	int4 _data0 = min(data0, data1);
	int4 _data1 = max(data0, data1);

	output[i] = _data0;
	output[i+offset] = _data1;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
