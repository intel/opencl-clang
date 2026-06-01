
#if defined(cl_amd_media_ops)
#pragma OPENCL EXTENSION cl_amd_media_ops : enable
#endif

typedef uint  UINT;
typedef uint4 UINTv4;


#define VECTOR_LEN		1
#define OUTPUT_SIZE		5
#define STEP_DATA_SIZE	16

inline UINT byteswap( const UINT v )
{
#ifdef __ENDIAN_LITTLE__
	return	as_uint(as_uchar4(v).wzyx);
#else
	return v;
#endif
}


#if defined(cl_amd_media_ops)
#define S(x, n)			amd_bitalign(x, x, (uint)(32-n))
#else
#define S(x, n)			rotate(x, (uint)n)
#endif

#define ACCESS_W(t)		W[(t) & 15]

#define R(t)                                          \
    temp = ACCESS_W(t -  3) ^ ACCESS_W(t -  8) ^		\
           ACCESS_W(t - 14) ^ ACCESS_W(t - 16);			\
    temp = ACCESS_W(t) = S(temp,1)                      \

#define STEP(a,b,c,d,e) e += S(a,5) + F(b,c,d) + K + temp; b = S(b,30)

#define P(a,b,c,d,e,x)                          \
	R(x);										\
    STEP(a,b,c,d,e);							\

#define PP(a,b,c,d,e,x)                         \
    ACCESS_W(x) = temp = byteswap(data[(x)]);	\
    STEP(a,b,c,d,e);							\

#define PPx(a,b,c,d,e,i)                         \
    ACCESS_W(i) = temp = byteswap(data[(i/4)].x);	\
    STEP(a,b,c,d,e);							\

#define PPy(a,b,c,d,e,i)                         \
    ACCESS_W(i) = temp = byteswap(data[(i/4)].y);	\
    STEP(a,b,c,d,e);							\

#define PPz(a,b,c,d,e,i)                         \
    ACCESS_W(i) = temp = byteswap(data[(i/4)].z);	\
    STEP(a,b,c,d,e);							\

#define PPw(a,b,c,d,e,i)                         \
    ACCESS_W(i) = temp = byteswap(data[(i/4)].w);	\
    STEP(a,b,c,d,e);							\

#define TEN_ROUND(x)				\
      P( A, B, C, D, E, x ## 0 );\
      P( E, A, B, C, D, x ## 1 );\
      P( D, E, A, B, C, x ## 2 );\
      P( C, D, E, A, B, x ## 3 );\
      P( B, C, D, E, A, x ## 4 );\
      P( A, B, C, D, E, x ## 5 );\
      P( E, A, B, C, D, x ## 6 );\
      P( D, E, A, B, C, x ## 7 );\
      P( C, D, E, A, B, x ## 8 );\
      P( B, C, D, E, A, x ## 9 );\


#ifndef USE_GLOBAL

inline void sha1_step_local4( const UINTv4* data, UINT *state )
{
	UINT W[16], temp;
	UINT A, B, C, D, E;

	A = state[0];
	B = state[1];
	C = state[2];
	D = state[3];
	E = state[4];

#ifdef _IS_GPU_
#define F(x,y,z)	bitselect(z, y, x)
#else
#define F(x,y,z)	(z ^ (x & (y ^ z)))
#endif
#define K 0x5A827999

	PPx( A, B, C, D, E, 0 );
	PPy( E, A, B, C, D, 1 );
	PPz( D, E, A, B, C, 2 );
	PPw( C, D, E, A, B, 3 );
	PPx( B, C, D, E, A, 4 );
	PPy( A, B, C, D, E, 5 );
	PPz( E, A, B, C, D, 6 );
	PPw( D, E, A, B, C, 7 );
	PPx( C, D, E, A, B, 8 );
	PPy( B, C, D, E, A, 9 );
	PPz( A, B, C, D, E, 10 );
	PPw( E, A, B, C, D, 11 );
	PPx( D, E, A, B, C, 12 );
	PPy( C, D, E, A, B, 13 );
	PPz( B, C, D, E, A, 14 );
	PPw( A, B, C, D, E, 15 );

	P( E, A, B, C, D, 16 );
	P( D, E, A, B, C, 17 );
	P( C, D, E, A, B, 18 );
	P( B, C, D, E, A, 19 );

#undef K
#undef F

#define F(x,y,z)	(x ^ y ^ z)
#define K 0x6ED9EBA1

	TEN_ROUND(2)
	TEN_ROUND(3)

#undef K
#undef F

#ifdef _IS_GPU_
#define F(x,y,z)	bitselect(x, z, y^x)
#else
#define F(x,y,z)	((x & y) | (z & (x | y)))
#endif
#define K 0x8F1BBCDC

		TEN_ROUND(4)
		TEN_ROUND(5)

#undef K
#undef F

#define F(x,y,z)	(x ^ y ^ z)
#define K 0xCA62C1D6

		TEN_ROUND(6)
		TEN_ROUND(7)

#undef K
#undef F

	state[0] += A;
	state[1] += B;
	state[2] += C;
	state[3] += D;
	state[4] += E;
}

#endif
#ifdef USE_GLOBAL

inline void
sha1_step_global( __global const UINT* restrict data, UINT *state )
{
   UINT W[16], temp;
   UINT A, B, C, D, E;

   A = state[0];
   B = state[1];
   C = state[2];
   D = state[3];
   E = state[4];

#ifdef _IS_GPU_
#define F(x,y,z)	bitselect(z, y, x)
#else
#define F(x,y,z)	(z ^ (x & (y ^ z)))
#endif
#define K 0x5A827999

    PP( A, B, C, D, E, 0 );
    PP( E, A, B, C, D, 1 );
    PP( D, E, A, B, C, 2 );
    PP( C, D, E, A, B, 3 );
    PP( B, C, D, E, A, 4 );
    PP( A, B, C, D, E, 5 );
    PP( E, A, B, C, D, 6 );
    PP( D, E, A, B, C, 7 );
    PP( C, D, E, A, B, 8 );
    PP( B, C, D, E, A, 9 );
    PP( A, B, C, D, E, 10 );
	PP( E, A, B, C, D, 11 );
	PP( D, E, A, B, C, 12 );
	PP( C, D, E, A, B, 13 );
	PP( B, C, D, E, A, 14 );
	PP( A, B, C, D, E, 15 );

	P( E, A, B, C, D, 16 );
	P( D, E, A, B, C, 17 );
	P( C, D, E, A, B, 18 );
	P( B, C, D, E, A, 19 );

#undef K
#undef F

#define F(x,y,z)	(x ^ y ^ z)
#define K 0x6ED9EBA1

		TEN_ROUND(2)
		TEN_ROUND(3)

#undef K
#undef F

#ifdef _IS_GPU_
#define F(x,y,z)	bitselect(x, z, y^x)
#else
#define F(x,y,z)	((x & y) | (z & (x | y)))
#endif
#define K 0x8F1BBCDC

		TEN_ROUND(4)
		TEN_ROUND(5)

#undef K
#undef F

#define F(x,y,z)	(x ^ y ^ z)
#define K 0xCA62C1D6

		TEN_ROUND(6)
		TEN_ROUND(7)

#undef K
#undef F

   state[0] += A;
   state[1] += B;
   state[2] += C;
   state[3] += D;
   state[4] += E;
}

#endif

#define STORE_TO_TEMP(i) tb[((i) / STEP_DATA_SIZE)][((i) % STEP_DATA_SIZE)]

__constant uint init_data[OUTPUT_SIZE] = {
	0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476,
	0xC3D2E1F0,
};

__kernel
__attribute__((vec_type_hint(UINTv4)))
#ifdef KERNEL_MAX_THREADS
__attribute__((work_group_size_hint(KERNEL_MAX_THREADS, 1, 1)))
#endif
void CryptThread(__global const uint* restrict buffer,
	__global uint* restrict state,
	const uint blockLen)
{
	const uint id = get_global_id(0);
	uint len = blockLen;
	uint i, j;

	const uint startPosInDWORDs = (id*blockLen*VECTOR_LEN)/4;

	const uint msgLenInBitsl = len * 8;
	const uint msgLenInBitsh = (len) >> (32-3);
	UINT localState[OUTPUT_SIZE];

	#pragma unroll
	for (j=0; j<OUTPUT_SIZE; j++) {
		localState[j] = init_data[j];
	}

	i = 0;
	while (len >= STEP_DATA_SIZE*4)
	{
		const uint uOffset = startPosInDWORDs + i;
#ifndef USE_GLOBAL
		__global const UINTv4* pBuf = (__global const UINTv4*)(buffer + uOffset);

		#define STEP_DATA_SIZE_U4 (STEP_DATA_SIZE/4)
		UINTv4 data[STEP_DATA_SIZE_U4];

		#pragma unroll
		for (j=0; j<STEP_DATA_SIZE_U4; j++) {
			data[j] = pBuf[j];
		}

		sha1_step_local4(data, localState);
#else
		sha1_step_global(buffer+uOffset, localState);
#endif
		i += STEP_DATA_SIZE;
		len -= STEP_DATA_SIZE*4;
	}

	len /= 4;

	UINT tb[2][STEP_DATA_SIZE];

	#pragma unroll
	for (j=0; j<len; j++) {
		const uint uOffset = j + startPosInDWORDs + i;
		STORE_TO_TEMP(j) = buffer[uOffset];
	}

#ifdef __ENDIAN_LITTLE__
	STORE_TO_TEMP(len) = 0x80;
#else
	STORE_TO_TEMP(len) = byteswap(0x80000000);
#endif

	i = len+1;

	while ((i % (512/32)) != (448/32))
	{
		STORE_TO_TEMP(i) = 0;
		i++;
	}

#ifdef __ENDIAN_LITTLE__
	{
		STORE_TO_TEMP(i) = byteswap(msgLenInBitsh);
		STORE_TO_TEMP(i + 1) = byteswap(msgLenInBitsl);
		i += 2;
	}
#else
#endif

	sha1_step_local4( (const UINTv4*)tb[0], localState);
	if (32 == i) {
		sha1_step_local4( (const UINTv4*)tb[1], localState);
	}

	#pragma unroll
	for (j=0; j<OUTPUT_SIZE; j++) {
		state[startPosInDWORDs + j] = byteswap(localState[j]);
	}
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
