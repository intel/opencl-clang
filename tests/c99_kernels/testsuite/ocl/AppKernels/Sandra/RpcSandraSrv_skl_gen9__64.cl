
#if defined(cl_khr_int64)
#pragma OPENCL EXTENSION cl_khr_int64 : enable
#endif
#if defined(cles_khr_int64)
#pragma OPENCL EXTENSION cles_khr_int64 : enable
#endif

#if defined(cl_amd_media_ops)
#pragma OPENCL EXTENSION cl_amd_media_ops : enable
#endif

typedef ulong  UINT64;
typedef ulong4 UINT64v4;


#define VECTOR_LEN		1
#define OUTPUT_SIZE		8
#define STEP_DATA_SIZE	16


inline UINT64 byteswap( const UINT64 v )
{
#ifdef __ENDIAN_LITTLE__

#if _IS_64BIT_
	return	as_ulong(as_uchar8(v).s76543210);
#else
	const uint lo = (uint)(v);
	const uint hi = (uint)(v >> 32);

	const UINT64 nhil = as_uint(as_uchar4(lo).wzyx);
	const UINT64 nlol = as_uint(as_uchar4(hi).wzyx);

	return (nhil << 32) | nlol;
#endif

#else
	return v;
#endif
}


__constant ulong round_data[80] = {
    0x428a2f98d728ae22ul, 0x7137449123ef65cdul, 0xb5c0fbcfec4d3b2ful, 0xe9b5dba58189dbbcul,
    0x3956c25bf348b538ul, 0x59f111f1b605d019ul, 0x923f82a4af194f9bul, 0xab1c5ed5da6d8118ul,
    0xd807aa98a3030242ul, 0x12835b0145706fbeul, 0x243185be4ee4b28cul, 0x550c7dc3d5ffb4e2ul,
    0x72be5d74f27b896ful, 0x80deb1fe3b1696b1ul, 0x9bdc06a725c71235ul, 0xc19bf174cf692694ul,

    0xe49b69c19ef14ad2ul, 0xefbe4786384f25e3ul, 0x0fc19dc68b8cd5b5ul, 0x240ca1cc77ac9c65ul,
    0x2de92c6f592b0275ul, 0x4a7484aa6ea6e483ul, 0x5cb0a9dcbd41fbd4ul, 0x76f988da831153b5ul,
    0x983e5152ee66dfabul, 0xa831c66d2db43210ul, 0xb00327c898fb213ful, 0xbf597fc7beef0ee4ul,
    0xc6e00bf33da88fc2ul, 0xd5a79147930aa725ul, 0x06ca6351e003826ful, 0x142929670a0e6e70ul,

    0x27b70a8546d22ffcul, 0x2e1b21385c26c926ul, 0x4d2c6dfc5ac42aedul, 0x53380d139d95b3dful,
	0x650a73548baf63deul, 0x766a0abb3c77b2a8ul, 0x81c2c92e47edaee6ul, 0x92722c851482353bul,
    0xa2bfe8a14cf10364ul, 0xa81a664bbc423001ul, 0xc24b8b70d0f89791ul, 0xc76c51a30654be30ul,
    0xd192e819d6ef5218ul, 0xd69906245565a910ul, 0xf40e35855771202aul, 0x106aa07032bbd1b8ul,

    0x19a4c116b8d2d0c8ul, 0x1e376c085141ab53ul, 0x2748774cdf8eeb99ul, 0x34b0bcb5e19b48a8ul,
    0x391c0cb3c5c95a63ul, 0x4ed8aa4ae3418acbul, 0x5b9cca4f7763e373ul, 0x682e6ff3d6b2b8a3ul,
    0x748f82ee5defb2fcul, 0x78a5636f43172f60ul, 0x84c87814a1f0ab72ul, 0x8cc702081a6439ecul,
    0x90befffa23631e28ul, 0xa4506cebde82bde9ul, 0xbef9a3f7b2c67915ul, 0xc67178f2e372532bul,

	0xca273eceea26619cul, 0xd186b8c721c0c207ul, 0xeada7dd6cde0eb1eul, 0xf57d4f7fee6ed178ul,
    0x06f067aa72176fbaul, 0x0a637dc5a2c898a6ul, 0x113f9804bef90daeul, 0x1b710b35131c471bul,
	0x28db77f523047d84ul, 0x32caab7b40c72493ul, 0x3c9ebe0a15c9bebcul, 0x431d67c49c100d4cul,
    0x4cc5d4becb3e42b6ul, 0x597f299cfc657e2aul, 0x5fcb6fab3ad6faecul, 0x6c44198c4a475817ul,
};


#define SHR(x,n)		(x >> n)
#define SHL(x,n)		(x << n)

#define ROTR(x,n)		rotate(x, (ulong)(64 - n))

#define S0(x) (ROTR(x, 1) ^ ROTR(x,8) ^  SHR(x,7))
#define S1(x) (ROTR(x,19) ^ ROTR(x,61) ^ SHR(x,6))

#define S2(x) (ROTR(x, 28) ^ ROTR(x,34) ^ ROTR(x,39))
#define S3(x) (ROTR(x, 14) ^ ROTR(x,18) ^ ROTR(x,41))

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
    ACCESS_W(t & 15) = S1(ACCESS_W(t -  2)) + ACCESS_W(t -  7) +          \
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
sha512_step_global( __global const UINT64 *data, UINT64 *state )
{
   UINT64 W[16];
   UINT64 temp1, temp2;
   UINT64 A, B, C, D, E, F, G, H;

    A = state[0];
    B = state[1];
    C = state[2];
    D = state[3];
    E = state[4];
    F = state[5];
    G = state[6];
    H = state[7];

    P( A, B, C, D, E, F, G, H, READ_W(0), round_data[0] );
    P( H, A, B, C, D, E, F, G, READ_W(1), round_data[1] );
    P( G, H, A, B, C, D, E, F, READ_W(2), round_data[2] );
    P( F, G, H, A, B, C, D, E, READ_W(3), round_data[3] );
    P( E, F, G, H, A, B, C, D, READ_W(4), round_data[4] );
    P( D, E, F, G, H, A, B, C, READ_W(5), round_data[5] );
    P( C, D, E, F, G, H, A, B, READ_W(6), round_data[6] );
    P( B, C, D, E, F, G, H, A, READ_W(7), round_data[7] );
    P( A, B, C, D, E, F, G, H, READ_W(8), round_data[8] );
    P( H, A, B, C, D, E, F, G, READ_W(9), round_data[9] );
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

	P( A, B, C, D, E, F, G, H, R(64), round_data[64] );
    P( H, A, B, C, D, E, F, G, R(65), round_data[65] );
    P( G, H, A, B, C, D, E, F, R(66), round_data[66] );
    P( F, G, H, A, B, C, D, E, R(67), round_data[67] );
    P( E, F, G, H, A, B, C, D, R(68), round_data[68] );
    P( D, E, F, G, H, A, B, C, R(69), round_data[69] );
    P( C, D, E, F, G, H, A, B, R(70), round_data[70] );
    P( B, C, D, E, F, G, H, A, R(71), round_data[71] );
	P( A, B, C, D, E, F, G, H, R(72), round_data[72] );
    P( H, A, B, C, D, E, F, G, R(73), round_data[73] );
    P( G, H, A, B, C, D, E, F, R(74), round_data[74] );
    P( F, G, H, A, B, C, D, E, R(75), round_data[75] );
    P( E, F, G, H, A, B, C, D, R(76), round_data[76] );
    P( D, E, F, G, H, A, B, C, R(77), round_data[77] );
    P( C, D, E, F, G, H, A, B, R(78), round_data[78] );
    P( B, C, D, E, F, G, H, A, R(79), round_data[79] );

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
sha512_step_local4( const UINT64v4 *data, UINT64 *state )
{
   UINT64 W[16];
   UINT64 temp1, temp2;
   UINT64 A, B, C, D, E, F, G, H;

    A = state[0];
    B = state[1];
    C = state[2];
    D = state[3];
    E = state[4];
    F = state[5];
    G = state[6];
    H = state[7];

    P( A, B, C, D, E, F, G, H, READx_W(0), round_data[0] );
    P( H, A, B, C, D, E, F, G, READy_W(1), round_data[1] );
    P( G, H, A, B, C, D, E, F, READz_W(2), round_data[2] );
    P( F, G, H, A, B, C, D, E, READw_W(3), round_data[3] );
    P( E, F, G, H, A, B, C, D, READx_W(4), round_data[4] );
    P( D, E, F, G, H, A, B, C, READy_W(5), round_data[5] );
    P( C, D, E, F, G, H, A, B, READz_W(6), round_data[6] );
    P( B, C, D, E, F, G, H, A, READw_W(7), round_data[7] );
    P( A, B, C, D, E, F, G, H, READx_W(8), round_data[8] );
    P( H, A, B, C, D, E, F, G, READy_W(9), round_data[9] );
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

	P( A, B, C, D, E, F, G, H, R(64), round_data[64] );
    P( H, A, B, C, D, E, F, G, R(65), round_data[65] );
    P( G, H, A, B, C, D, E, F, R(66), round_data[66] );
    P( F, G, H, A, B, C, D, E, R(67), round_data[67] );
    P( E, F, G, H, A, B, C, D, R(68), round_data[68] );
    P( D, E, F, G, H, A, B, C, R(69), round_data[69] );
    P( C, D, E, F, G, H, A, B, R(70), round_data[70] );
    P( B, C, D, E, F, G, H, A, R(71), round_data[71] );
	P( A, B, C, D, E, F, G, H, R(72), round_data[72] );
    P( H, A, B, C, D, E, F, G, R(73), round_data[73] );
    P( G, H, A, B, C, D, E, F, R(74), round_data[74] );
    P( F, G, H, A, B, C, D, E, R(75), round_data[75] );
    P( E, F, G, H, A, B, C, D, R(76), round_data[76] );
    P( D, E, F, G, H, A, B, C, R(77), round_data[77] );
    P( C, D, E, F, G, H, A, B, R(78), round_data[78] );
    P( B, C, D, E, F, G, H, A, R(79), round_data[79] );

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

__constant ulong init_data[OUTPUT_SIZE] = {
	0x6a09e667f3bcc908ul, 0xbb67ae8584caa73bul, 0x3c6ef372fe94f82bul, 0xa54ff53a5f1d36f1ul,
	0x510e527fade682d1ul, 0x9b05688c2b3e6c1ful, 0x1f83d9abfb41bd6bul, 0x5be0cd19137e2179ul,
};

__kernel
__attribute__((vec_type_hint(UINT64v4)))
#ifdef KERNEL_MAX_THREADS
__attribute__((work_group_size_hint(KERNEL_MAX_THREADS, 1, 1)))
#endif
void CryptThread(__global const ulong* restrict buffer,
	__global ulong* restrict state, const uint blockLen)
{
	const uint id = get_global_id(0);
	uint len = blockLen;
	uint i, j;

	const uint startPosInQWORDs = (id*blockLen*VECTOR_LEN)/8;

	const uint msgLenInBitsl = len * 8;
	const uint msgLenInBitsh = (len) >> (32-3);
	UINT64 localState[OUTPUT_SIZE];

	#pragma unroll
	for (j=0; j<OUTPUT_SIZE; j++) {
		localState[j] = init_data[j];
	}

	i = 0;
	while (len >= STEP_DATA_SIZE*8)
	{
		const uint uOffset = startPosInQWORDs + i;
#ifndef USE_GLOBAL
		__global const UINT64v4* pBuf = (__global const UINT64v4*)(buffer + uOffset);

		#define STEP_DATA_SIZE_U4 (STEP_DATA_SIZE/4)
		UINT64v4 data[STEP_DATA_SIZE_U4];

		#pragma unroll
		for (j=0; j<STEP_DATA_SIZE_U4; j++) {
			data[j] = pBuf[j];
		}

		sha512_step_local4(data, localState);
#else
		sha512_step_global(buffer+uOffset, localState);
#endif
		i += STEP_DATA_SIZE;
		len -= STEP_DATA_SIZE*8;
	}

	len /= 8;

	UINT64 tb[2][STEP_DATA_SIZE];

	#pragma unroll
	for (j=0; j<len; j++) {
		const uint uOffset = j + startPosInQWORDs + i;
		STORE_TO_TEMP(j) = buffer[uOffset];
	}

#ifdef __ENDIAN_LITTLE__
	STORE_TO_TEMP(len) = 0x80;
#else
	STORE_TO_TEMP(len) = byteswap(0x8000000000000000ul);
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

	sha512_step_local4( (const UINT64v4*)tb[0], localState);
	if (32 == i) {
		sha512_step_local4( (const UINT64v4*)tb[1], localState);
	}

	#pragma unroll
	for (j=0; j<OUTPUT_SIZE; j++) {
		state[startPosInQWORDs + j] = byteswap(localState[j]);
	}
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
