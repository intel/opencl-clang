

#if defined(TEXTURE_TEST)
__constant sampler_t insample = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;
#endif

#if defined(CODE_TEST)
#define BLOCK_REPEAT_2(x)		x; x
#define BLOCK_REPEAT_4(x)		BLOCK_REPEAT_2(x);   BLOCK_REPEAT_2(x)
#define BLOCK_REPEAT_8(x)		BLOCK_REPEAT_4(x);   BLOCK_REPEAT_4(x)
#define BLOCK_REPEAT_16(x)		BLOCK_REPEAT_8(x);   BLOCK_REPEAT_8(x)
#define BLOCK_REPEAT_32(x)		BLOCK_REPEAT_16(x);  BLOCK_REPEAT_16(x)
#define BLOCK_REPEAT_64(x)		BLOCK_REPEAT_32(x);  BLOCK_REPEAT_32(x)
#define BLOCK_REPEAT_128(x)		BLOCK_REPEAT_64(x);  BLOCK_REPEAT_64(x)
#define BLOCK_REPEAT_256(x)		BLOCK_REPEAT_128(x); BLOCK_REPEAT_128(x)
#define BLOCK_REPEAT_512(x)		BLOCK_REPEAT_256(x); BLOCK_REPEAT_256(x)
#endif

__kernel
__attribute__((work_group_size_hint(1, 1, 1)))
void MemWalker(
#if defined(TEXTURE_TEST)
	__read_only image2d_t input,
#elif defined(CONST_TEST)
	__constant DATA_TYPE* input,
#else
	__global DATA_TYPE* input,
#endif
	__global DATA_TYPE* output,
	const uint uCount, const uint uSize,
	const uint uOffset, const int bMem)
{
#ifdef LOCAL_TEST
	__local DATA_TYPE local_mem[BUFFER_SIZE];
#endif
#ifdef PRIVATE_TEST
	__private DATA_TYPE local_mem[BUFFER_SIZE];
#endif

#if defined(PRIVATE_TEST) || defined(LOCAL_TEST)
	for (uint j=0; j<uSize; j++)
		local_mem[j] = input[j];
#endif

#ifdef LOCAL_TEST
	barrier(CLK_LOCAL_MEM_FENCE);
#endif

		uint i = uCount;
	uint o = uOffset;
#if defined(TEXTURE_TEST)
	int2  nx = (int2)(0,0);

	uint4 x = read_imageui(input, insample, nx);
	nx = (int2)((x.y << 8) | x.x, (x.w << 8) | x.z);
#elif defined(PRIVATE_TEST) || defined(LOCAL_TEST)
	DATA_TYPE x = local_mem[0];
#else
	DATA_TYPE x = input[0];
#endif

	if (bMem) {
				while (i--) {
#if defined(TEXTURE_TEST)
			x = read_imageui(input, insample, nx);
			x.x += o;
			x.z += o;
			nx = (int2)((x.y << 8) | x.x, (x.w << 8) | x.z);
#elif defined(PRIVATE_TEST) || defined(LOCAL_TEST)
			x = local_mem[x] + o;
#else
			x = input[x] + o;
#endif
		}
	}
	else {
				while (i--) {
#if defined(TEXTURE_TEST)
			x.x = nx.x + o;
			x.z = nx.y + o;
			nx = (int2)((x.y << 8) | x.x, (x.w << 8) | x.z);
#else
			x += i;
#endif
		}
	}

#if defined(TEXTURE_TEST)
	output[0] = nx.x | nx.y;
#else
	output[0] = x;
#endif
}


// buildOptions=-D PRIVATE_TEST -D _IS_GPU_ -D DATA_TYPE=uint -D BUFFER_SIZE=8192
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -D PRIVATE_TEST -D _IS_GPU_ -D DATA_TYPE=uint -D BUFFER_SIZE=8192" %cfg_path --cl-device=%cl_device 2>&1
