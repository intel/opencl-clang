
#if defined(cl_amd_media_ops)
#pragma OPENCL EXTENSION cl_amd_media_ops : enable
#endif

typedef uint  UINT;
typedef uint4 UINTv4;


#define VECTOR_LEN		1
#define OUTPUT_SIZE		8
#define STEP_DATA_SIZE	16


inline UINT byteswap( const UINT v )
{
#ifdef __ENDIAN_LITTLE__
	return	as_uint(as_uchar4(v).wzyx);
#else
	return v;
#endif
}


__constant uint round_data[64] = {
	0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5,
	0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5,
	0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
	0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174,
	0xE49B69C1, 0xEFBE4786, 0x0FC19DC6, 0x240CA1CC,
	0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
	0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7,
	0xC6E00BF3, 0xD5A79147, 0x06CA6351, 0x14292967,

	0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
	0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85,
	0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3,
	0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
	0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5,
	0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3,
	0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
	0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2,
};


#define SHR(x,n)		(x >> n)
#define SHL(x,n)		(x << n)

#if defined(cl_amd_media_ops)
#define ROTR(x,n)		amd_bitalign(x, x, n)
#else
#define ROTR(x,n)		rotate(x, (uint)(32 - n))
#endif

#define S0(x)	(ROTR(x, 7) ^ ROTR(x,18) ^  SHR(x, 3))
#define S1(x)	(ROTR(x,17) ^ ROTR(x,19) ^  SHR(x,10))

#define S2(x)	(ROTR(x, 2) ^ ROTR(x,13) ^ ROTR(x,22))
#define S3(x)	(ROTR(x, 6) ^ ROTR(x,11) ^ ROTR(x,25))

#ifdef _IS_GPU_
#define F0(x,y,z)		bitselect(x, z, y^x)
#define F1(x,y,z)		bitselect(z, y, x)
#else
#define F0(x,y,z)		((x & y) | (z & (x | y)))
#define F1(x,y,z)		(z ^ (x & (y ^ z)))
#endif

#define ACCESS_W(t)		W[(t) & 15]

#define READ_W(t)		( W[t] = byteswap(data[t]) )

#define READx_W(t)		( W[t] = byteswap(data[(t/4)].x) )
#define READy_W(t)		( W[t] = byteswap(data[(t/4)].y) )
#define READz_W(t)		( W[t] = byteswap(data[(t/4)].z) )
#define READw_W(t)		( W[t] = byteswap(data[(t/4)].w) )

#define R(t)                                    \
(                                               \
   ACCESS_W(t) = S1(ACCESS_W(t -  2)) + ACCESS_W(t -  7) +          \
				S0(ACCESS_W(t - 15)) + ACCESS_W(t - 16)            \
)

#define P(a,b,c,d,e,f,g,h,x,K)                  \
{                                               \
    temp1 = h + S3(e) + F1(e,f,g) + K + (x);      \
    temp2 = S2(a) + F0(a,b,c);                  \
    d += temp1; h = temp1 + temp2;              \
}

#ifdef USE_GLOBAL

inline void
sha256_step_global( __global const UINT* restrict data, UINT *state )
{
   UINT W[16];
   UINT temp1, temp2;
   UINT A, B, C, D, E, F, G, H;

    A = state[0];
    B = state[1];
    C = state[2];
    D = state[3];
    E = state[4];
    F = state[5];
    G = state[6];
    H = state[7];

    P( A, B, C, D, E, F, G, H, READ_W(0),  round_data[0] );
    P( H, A, B, C, D, E, F, G, READ_W(1),  round_data[1] );
    P( G, H, A, B, C, D, E, F, READ_W(2),  round_data[2] );
    P( F, G, H, A, B, C, D, E, READ_W(3),  round_data[3] );
    P( E, F, G, H, A, B, C, D, READ_W(4),  round_data[4] );
    P( D, E, F, G, H, A, B, C, READ_W(5),  round_data[5] );
    P( C, D, E, F, G, H, A, B, READ_W(6),  round_data[6] );
    P( B, C, D, E, F, G, H, A, READ_W(7),  round_data[7] );
    P( A, B, C, D, E, F, G, H, READ_W(8),  round_data[8] );
    P( H, A, B, C, D, E, F, G, READ_W(9),  round_data[9] );
    P( G, H, A, B, C, D, E, F, READ_W(10), round_data[10] );
    P( F, G, H, A, B, C, D, E, READ_W(11), round_data[11] );
    P( E, F, G, H, A, B, C, D, READ_W(12), round_data[12] );
    P( D, E, F, G, H, A, B, C, READ_W(13), round_data[13] );
    P( C, D, E, F, G, H, A, B, READ_W(14), round_data[14] );
    P( B, C, D, E, F, G, H, A, READ_W(15), round_data[15] );

    P( A, B, C, D, E, F, G, H, R(16), round_data[16] );
    P( H, A, B, C, D, E, F, G, R(17), round_data[17] );
    P( G, H, A, B, C, D, E, F, R(18), round_data[18] );
    P( F, G, H, A, B, C, D, E, R(19), round_data[19] );
    P( E, F, G, H, A, B, C, D, R(20), round_data[20] );
    P( D, E, F, G, H, A, B, C, R(21), round_data[21] );
    P( C, D, E, F, G, H, A, B, R(22), round_data[22] );
    P( B, C, D, E, F, G, H, A, R(23), round_data[23] );
    P( A, B, C, D, E, F, G, H, R(24), round_data[24] );
    P( H, A, B, C, D, E, F, G, R(25), round_data[25] );
    P( G, H, A, B, C, D, E, F, R(26), round_data[26] );
    P( F, G, H, A, B, C, D, E, R(27), round_data[27] );
    P( E, F, G, H, A, B, C, D, R(28), round_data[28] );
    P( D, E, F, G, H, A, B, C, R(29), round_data[29] );
    P( C, D, E, F, G, H, A, B, R(30), round_data[30] );
    P( B, C, D, E, F, G, H, A, R(31), round_data[31] );

    P( A, B, C, D, E, F, G, H, R(32), round_data[32] );
    P( H, A, B, C, D, E, F, G, R(33), round_data[33] );
    P( G, H, A, B, C, D, E, F, R(34), round_data[34] );
    P( F, G, H, A, B, C, D, E, R(35), round_data[35] );
    P( E, F, G, H, A, B, C, D, R(36), round_data[36] );
    P( D, E, F, G, H, A, B, C, R(37), round_data[37] );
    P( C, D, E, F, G, H, A, B, R(38), round_data[38] );
    P( B, C, D, E, F, G, H, A, R(39), round_data[39] );
    P( A, B, C, D, E, F, G, H, R(40), round_data[40] );
    P( H, A, B, C, D, E, F, G, R(41), round_data[41] );
    P( G, H, A, B, C, D, E, F, R(42), round_data[42] );
    P( F, G, H, A, B, C, D, E, R(43), round_data[43] );
    P( E, F, G, H, A, B, C, D, R(44), round_data[44] );
    P( D, E, F, G, H, A, B, C, R(45), round_data[45] );
    P( C, D, E, F, G, H, A, B, R(46), round_data[46] );
    P( B, C, D, E, F, G, H, A, R(47), round_data[47] );

    P( A, B, C, D, E, F, G, H, R(48), round_data[48] );
    P( H, A, B, C, D, E, F, G, R(49), round_data[49] );
    P( G, H, A, B, C, D, E, F, R(50), round_data[50] );
    P( F, G, H, A, B, C, D, E, R(51), round_data[51] );
    P( E, F, G, H, A, B, C, D, R(52), round_data[52] );
    P( D, E, F, G, H, A, B, C, R(53), round_data[53] );
    P( C, D, E, F, G, H, A, B, R(54), round_data[54] );
    P( B, C, D, E, F, G, H, A, R(55), round_data[55] );
    P( A, B, C, D, E, F, G, H, R(56), round_data[56] );
    P( H, A, B, C, D, E, F, G, R(57), round_data[57] );
    P( G, H, A, B, C, D, E, F, R(58), round_data[58] );
    P( F, G, H, A, B, C, D, E, R(59), round_data[59] );
    P( E, F, G, H, A, B, C, D, R(60), round_data[60] );
    P( D, E, F, G, H, A, B, C, R(61), round_data[61] );
    P( C, D, E, F, G, H, A, B, R(62), round_data[62] );
    P( B, C, D, E, F, G, H, A, R(63), round_data[63] );

    state[0] += A;
    state[1] += B;
    state[2] += C;
    state[3] += D;
    state[4] += E;
    state[5] += F;
    state[6] += G;
    state[7] += H;
}

#endif

inline void
sha256_step_local4( const UINTv4 *data, UINT *state )
{
   UINT W[16];
   UINT temp1, temp2;
   UINT A, B, C, D, E, F, G, H;

    A = state[0];
    B = state[1];
    C = state[2];
    D = state[3];
    E = state[4];
    F = state[5];
    G = state[6];
    H = state[7];

    P( A, B, C, D, E, F, G, H, READx_W(0),  round_data[0] );
    P( H, A, B, C, D, E, F, G, READy_W(1),  round_data[1] );
    P( G, H, A, B, C, D, E, F, READz_W(2),  round_data[2] );
    P( F, G, H, A, B, C, D, E, READw_W(3),  round_data[3] );
    P( E, F, G, H, A, B, C, D, READx_W(4),  round_data[4] );
    P( D, E, F, G, H, A, B, C, READy_W(5),  round_data[5] );
    P( C, D, E, F, G, H, A, B, READz_W(6),  round_data[6] );
    P( B, C, D, E, F, G, H, A, READw_W(7),  round_data[7] );
    P( A, B, C, D, E, F, G, H, READx_W(8),  round_data[8] );
    P( H, A, B, C, D, E, F, G, READy_W(9),  round_data[9] );
    P( G, H, A, B, C, D, E, F, READz_W(10), round_data[10] );
    P( F, G, H, A, B, C, D, E, READw_W(11), round_data[11] );
    P( E, F, G, H, A, B, C, D, READx_W(12), round_data[12] );
    P( D, E, F, G, H, A, B, C, READy_W(13), round_data[13] );
    P( C, D, E, F, G, H, A, B, READz_W(14), round_data[14] );
    P( B, C, D, E, F, G, H, A, READw_W(15), round_data[15] );

    P( A, B, C, D, E, F, G, H, R(16), round_data[16] );
    P( H, A, B, C, D, E, F, G, R(17), round_data[17] );
    P( G, H, A, B, C, D, E, F, R(18), round_data[18] );
    P( F, G, H, A, B, C, D, E, R(19), round_data[19] );
    P( E, F, G, H, A, B, C, D, R(20), round_data[20] );
    P( D, E, F, G, H, A, B, C, R(21), round_data[21] );
    P( C, D, E, F, G, H, A, B, R(22), round_data[22] );
    P( B, C, D, E, F, G, H, A, R(23), round_data[23] );
    P( A, B, C, D, E, F, G, H, R(24), round_data[24] );
    P( H, A, B, C, D, E, F, G, R(25), round_data[25] );
    P( G, H, A, B, C, D, E, F, R(26), round_data[26] );
    P( F, G, H, A, B, C, D, E, R(27), round_data[27] );
    P( E, F, G, H, A, B, C, D, R(28), round_data[28] );
    P( D, E, F, G, H, A, B, C, R(29), round_data[29] );
    P( C, D, E, F, G, H, A, B, R(30), round_data[30] );
    P( B, C, D, E, F, G, H, A, R(31), round_data[31] );

    P( A, B, C, D, E, F, G, H, R(32), round_data[32] );
    P( H, A, B, C, D, E, F, G, R(33), round_data[33] );
    P( G, H, A, B, C, D, E, F, R(34), round_data[34] );
    P( F, G, H, A, B, C, D, E, R(35), round_data[35] );
    P( E, F, G, H, A, B, C, D, R(36), round_data[36] );
    P( D, E, F, G, H, A, B, C, R(37), round_data[37] );
    P( C, D, E, F, G, H, A, B, R(38), round_data[38] );
    P( B, C, D, E, F, G, H, A, R(39), round_data[39] );
    P( A, B, C, D, E, F, G, H, R(40), round_data[40] );
    P( H, A, B, C, D, E, F, G, R(41), round_data[41] );
    P( G, H, A, B, C, D, E, F, R(42), round_data[42] );
    P( F, G, H, A, B, C, D, E, R(43), round_data[43] );
    P( E, F, G, H, A, B, C, D, R(44), round_data[44] );
    P( D, E, F, G, H, A, B, C, R(45), round_data[45] );
    P( C, D, E, F, G, H, A, B, R(46), round_data[46] );
    P( B, C, D, E, F, G, H, A, R(47), round_data[47] );

    P( A, B, C, D, E, F, G, H, R(48), round_data[48] );
    P( H, A, B, C, D, E, F, G, R(49), round_data[49] );
    P( G, H, A, B, C, D, E, F, R(50), round_data[50] );
    P( F, G, H, A, B, C, D, E, R(51), round_data[51] );
    P( E, F, G, H, A, B, C, D, R(52), round_data[52] );
    P( D, E, F, G, H, A, B, C, R(53), round_data[53] );
    P( C, D, E, F, G, H, A, B, R(54), round_data[54] );
    P( B, C, D, E, F, G, H, A, R(55), round_data[55] );
    P( A, B, C, D, E, F, G, H, R(56), round_data[56] );
    P( H, A, B, C, D, E, F, G, R(57), round_data[57] );
    P( G, H, A, B, C, D, E, F, R(58), round_data[58] );
    P( F, G, H, A, B, C, D, E, R(59), round_data[59] );
    P( E, F, G, H, A, B, C, D, R(60), round_data[60] );
    P( D, E, F, G, H, A, B, C, R(61), round_data[61] );
    P( C, D, E, F, G, H, A, B, R(62), round_data[62] );
    P( B, C, D, E, F, G, H, A, R(63), round_data[63] );

    state[0] += A;
    state[1] += B;
    state[2] += C;
    state[3] += D;
    state[4] += E;
    state[5] += F;
    state[6] += G;
    state[7] += H;
}


#define STORE_TO_TEMP(i) tb[((i) / STEP_DATA_SIZE)][((i) % STEP_DATA_SIZE)]

__constant uint init_data[OUTPUT_SIZE] = {
	0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
	0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19,
};

__kernel
__attribute__((vec_type_hint(UINTv4)))
#ifdef KERNEL_MAX_THREADS
__attribute__((work_group_size_hint(KERNEL_MAX_THREADS, 1, 1)))
#endif
void CryptThread(__global const uint* restrict buffer,
	__global uint* restrict state, const uint blockLen)
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

		sha256_step_local4(data, localState);
#else
		sha256_step_global(buffer+uOffset, localState);
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

	sha256_step_local4( (const UINTv4*)tb[0], localState);
	if (32 == i) {
		sha256_step_local4( (const UINTv4*)tb[1], localState);
	}

	#pragma unroll
	for (j=0; j<OUTPUT_SIZE; j++) {
		state[startPosInDWORDs + j] = byteswap(localState[j]);
	}
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
