
typedef uint UINT;

#define MACRO_HEAVEN
#define VECTOR_LEN		1


#ifdef __ENDIAN_LITTLE__

#define byteswap(x) \
        ((x) << 24) |	\
        ((x & 0x0000ff00) <<  8) |	\
        ((x & 0x00ff0000) >>  8) |	\
        ((x) >> 24)

#else

#define byteswap(x)		(x)

#endif


#define COMPLEX_W_MACROS

#define DEF_W_VARS  \
uint W_0; \
uint W_1; \
uint W_2; \
uint W_3; \
uint W_4; \
uint W_5; \
uint W_6; \
uint W_7; \
uint W_8; \
uint W_9; \
uint W_10; \
uint W_11; \
uint W_12; \
uint W_13; \
uint W_14; \
uint W_15; \




#define FILL_W_16   \
W_0 = byteswap(data[0]);   \
W_1 = byteswap(data[1]);   \
W_2 = byteswap(data[2]);   \
W_3 = byteswap(data[3]);   \
W_4 = byteswap(data[4]);   \
W_5 = byteswap(data[5]);   \
W_6 = byteswap(data[6]);   \
W_7 = byteswap(data[7]);   \
W_8 = byteswap(data[8]);   \
W_9 = byteswap(data[9]);   \
W_10 = byteswap(data[10]);   \
W_11 = byteswap(data[11]);   \
W_12 = byteswap(data[12]);   \
W_13 = byteswap(data[13]);   \
W_14 = byteswap(data[14]);   \
W_15 = byteswap(data[15]);   \




#define CALC_W_16 (W_0 = S1(W_14) + W_9 +  S0(W_1) + W_0 )
#define CALC_W_17 (W_1 = S1(W_15) + W_10 +  S0(W_2) + W_1 )
#define CALC_W_18 (W_2 = S1(W_0) + W_11 +  S0(W_3) + W_2 )
#define CALC_W_19 (W_3 = S1(W_1) + W_12 +  S0(W_4) + W_3 )
#define CALC_W_20 (W_4 = S1(W_2) + W_13 +  S0(W_5) + W_4 )
#define CALC_W_21 (W_5 = S1(W_3) + W_14 +  S0(W_6) + W_5 )
#define CALC_W_22 (W_6 = S1(W_4) + W_15 +  S0(W_7) + W_6 )
#define CALC_W_23 (W_7 = S1(W_5) + W_0 +  S0(W_8) + W_7 )
#define CALC_W_24 (W_8 = S1(W_6) + W_1 +  S0(W_9) + W_8 )
#define CALC_W_25 (W_9 = S1(W_7) + W_2 +  S0(W_10) + W_9 )
#define CALC_W_26 (W_10 = S1(W_8) + W_3 +  S0(W_11) + W_10 )
#define CALC_W_27 (W_11 = S1(W_9) + W_4 +  S0(W_12) + W_11 )
#define CALC_W_28 (W_12 = S1(W_10) + W_5 +  S0(W_13) + W_12 )
#define CALC_W_29 (W_13 = S1(W_11) + W_6 +  S0(W_14) + W_13 )
#define CALC_W_30 (W_14 = S1(W_12) + W_7 +  S0(W_15) + W_14 )
#define CALC_W_31 (W_15 = S1(W_13) + W_8 +  S0(W_0) + W_15 )
#define CALC_W_32 (W_0 = S1(W_14) + W_9 +  S0(W_1) + W_0 )
#define CALC_W_33 (W_1 = S1(W_15) + W_10 +  S0(W_2) + W_1 )
#define CALC_W_34 (W_2 = S1(W_0) + W_11 +  S0(W_3) + W_2 )
#define CALC_W_35 (W_3 = S1(W_1) + W_12 +  S0(W_4) + W_3 )
#define CALC_W_36 (W_4 = S1(W_2) + W_13 +  S0(W_5) + W_4 )
#define CALC_W_37 (W_5 = S1(W_3) + W_14 +  S0(W_6) + W_5 )
#define CALC_W_38 (W_6 = S1(W_4) + W_15 +  S0(W_7) + W_6 )
#define CALC_W_39 (W_7 = S1(W_5) + W_0 +  S0(W_8) + W_7 )
#define CALC_W_40 (W_8 = S1(W_6) + W_1 +  S0(W_9) + W_8 )
#define CALC_W_41 (W_9 = S1(W_7) + W_2 +  S0(W_10) + W_9 )
#define CALC_W_42 (W_10 = S1(W_8) + W_3 +  S0(W_11) + W_10 )
#define CALC_W_43 (W_11 = S1(W_9) + W_4 +  S0(W_12) + W_11 )
#define CALC_W_44 (W_12 = S1(W_10) + W_5 +  S0(W_13) + W_12 )
#define CALC_W_45 (W_13 = S1(W_11) + W_6 +  S0(W_14) + W_13 )
#define CALC_W_46 (W_14 = S1(W_12) + W_7 +  S0(W_15) + W_14 )
#define CALC_W_47 (W_15 = S1(W_13) + W_8 +  S0(W_0) + W_15 )
#define CALC_W_48 (W_0 = S1(W_14) + W_9 +  S0(W_1) + W_0 )
#define CALC_W_49 (W_1 = S1(W_15) + W_10 +  S0(W_2) + W_1 )
#define CALC_W_50 (W_2 = S1(W_0) + W_11 +  S0(W_3) + W_2 )
#define CALC_W_51 (W_3 = S1(W_1) + W_12 +  S0(W_4) + W_3 )
#define CALC_W_52 (W_4 = S1(W_2) + W_13 +  S0(W_5) + W_4 )
#define CALC_W_53 (W_5 = S1(W_3) + W_14 +  S0(W_6) + W_5 )
#define CALC_W_54 (W_6 = S1(W_4) + W_15 +  S0(W_7) + W_6 )
#define CALC_W_55 (W_7 = S1(W_5) + W_0 +  S0(W_8) + W_7 )
#define CALC_W_56 (W_8 = S1(W_6) + W_1 +  S0(W_9) + W_8 )
#define CALC_W_57 (W_9 = S1(W_7) + W_2 +  S0(W_10) + W_9 )
#define CALC_W_58 (W_10 = S1(W_8) + W_3 +  S0(W_11) + W_10 )
#define CALC_W_59 (W_11 = S1(W_9) + W_4 +  S0(W_12) + W_11 )
#define CALC_W_60 (W_12 = S1(W_10) + W_5 +  S0(W_13) + W_12 )
#define CALC_W_61 (W_13 = S1(W_11) + W_6 +  S0(W_14) + W_13 )
#define CALC_W_62 (W_14 = S1(W_12) + W_7 +  S0(W_15) + W_14 )
#define CALC_W_63 (W_15 = S1(W_13) + W_8 +  S0(W_0) + W_15 )


#define SHR(x,n)  ((x & 0xFFFFFFFF) >> n)
#define ROTR(x,n) (SHR(x,n) | (x << (32 - n)))

#define S0(x) (ROTR(x, 7) ^ ROTR(x,18) ^  SHR(x, 3))
#define S1(x) (ROTR(x,17) ^ ROTR(x,19) ^  SHR(x,10))

#define S2(x) (ROTR(x, 2) ^ ROTR(x,13) ^ ROTR(x,22))
#define S3(x) (ROTR(x, 6) ^ ROTR(x,11) ^ ROTR(x,25))

#define F0(x,y,z) ((x & y) | (z & (x | y)))
#define F1(x,y,z) (z ^ (x & (y ^ z)))

#ifdef COMPLEX_W_MACROS
#define R(t) (CALC_W_ ## t)
#define FILL_W  FILL_W_16
#define READ_W(t) (W_ ## t = byteswap(data[offset + t]))
#else
#define R(t)                                    \
(                                               \
    W[t] = S1(W[t -  2]) + W[t -  7] +          \
           S0(W[t - 15]) + W[t - 16]            \
)

#define FILL_W    for (UINT i=0;i<16;i++) {W[i] = byteswap(data[i]);}

#define DEF_W_VARS uint W[64];
#define READ_W(t) W[t]
#endif

#define P(a,b,c,d,e,f,g,h,x,K)                  \
{                                               \
    temp1 = h + S3(e) + F1(e,f,g) + K + (x);      \
    temp2 = S2(a) + F0(a,b,c);                  \
    d += temp1; h = temp1 + temp2;              \
}


inline void sha256_step_global( __global const UINT *data, UINT *state, const UINT offset )
{
   DEF_W_VARS;
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

    P( A, B, C, D, E, F, G, H, READ_W(0), 0x428A2F98 );
    P( H, A, B, C, D, E, F, G, READ_W(1), 0x71374491 );
    P( G, H, A, B, C, D, E, F, READ_W(2), 0xB5C0FBCF );
    P( F, G, H, A, B, C, D, E, READ_W(3), 0xE9B5DBA5 );
    P( E, F, G, H, A, B, C, D, READ_W(4), 0x3956C25B );
    P( D, E, F, G, H, A, B, C, READ_W(5), 0x59F111F1 );
    P( C, D, E, F, G, H, A, B, READ_W(6), 0x923F82A4 );
    P( B, C, D, E, F, G, H, A, READ_W(7), 0xAB1C5ED5 );
    P( A, B, C, D, E, F, G, H, READ_W(8), 0xD807AA98 );
    P( H, A, B, C, D, E, F, G, READ_W(9), 0x12835B01 );
    P( G, H, A, B, C, D, E, F, READ_W(10), 0x243185BE );
    P( F, G, H, A, B, C, D, E, READ_W(11), 0x550C7DC3 );
    P( E, F, G, H, A, B, C, D, READ_W(12), 0x72BE5D74 );
    P( D, E, F, G, H, A, B, C, READ_W(13), 0x80DEB1FE );
    P( C, D, E, F, G, H, A, B, READ_W(14), 0x9BDC06A7 );
    P( B, C, D, E, F, G, H, A, READ_W(15), 0xC19BF174 );
    P( A, B, C, D, E, F, G, H, R(16), 0xE49B69C1 );
    P( H, A, B, C, D, E, F, G, R(17), 0xEFBE4786 );
    P( G, H, A, B, C, D, E, F, R(18), 0x0FC19DC6 );
    P( F, G, H, A, B, C, D, E, R(19), 0x240CA1CC );
    P( E, F, G, H, A, B, C, D, R(20), 0x2DE92C6F );
    P( D, E, F, G, H, A, B, C, R(21), 0x4A7484AA );
    P( C, D, E, F, G, H, A, B, R(22), 0x5CB0A9DC );
    P( B, C, D, E, F, G, H, A, R(23), 0x76F988DA );
    P( A, B, C, D, E, F, G, H, R(24), 0x983E5152 );
    P( H, A, B, C, D, E, F, G, R(25), 0xA831C66D );
    P( G, H, A, B, C, D, E, F, R(26), 0xB00327C8 );
    P( F, G, H, A, B, C, D, E, R(27), 0xBF597FC7 );
    P( E, F, G, H, A, B, C, D, R(28), 0xC6E00BF3 );
    P( D, E, F, G, H, A, B, C, R(29), 0xD5A79147 );
    P( C, D, E, F, G, H, A, B, R(30), 0x06CA6351 );
    P( B, C, D, E, F, G, H, A, R(31), 0x14292967 );
    P( A, B, C, D, E, F, G, H, R(32), 0x27B70A85 );
    P( H, A, B, C, D, E, F, G, R(33), 0x2E1B2138 );
    P( G, H, A, B, C, D, E, F, R(34), 0x4D2C6DFC );
    P( F, G, H, A, B, C, D, E, R(35), 0x53380D13 );
    P( E, F, G, H, A, B, C, D, R(36), 0x650A7354 );
    P( D, E, F, G, H, A, B, C, R(37), 0x766A0ABB );
    P( C, D, E, F, G, H, A, B, R(38), 0x81C2C92E );
    P( B, C, D, E, F, G, H, A, R(39), 0x92722C85 );
    P( A, B, C, D, E, F, G, H, R(40), 0xA2BFE8A1 );
    P( H, A, B, C, D, E, F, G, R(41), 0xA81A664B );
    P( G, H, A, B, C, D, E, F, R(42), 0xC24B8B70 );
    P( F, G, H, A, B, C, D, E, R(43), 0xC76C51A3 );
    P( E, F, G, H, A, B, C, D, R(44), 0xD192E819 );
    P( D, E, F, G, H, A, B, C, R(45), 0xD6990624 );
    P( C, D, E, F, G, H, A, B, R(46), 0xF40E3585 );
    P( B, C, D, E, F, G, H, A, R(47), 0x106AA070 );
    P( A, B, C, D, E, F, G, H, R(48), 0x19A4C116 );
    P( H, A, B, C, D, E, F, G, R(49), 0x1E376C08 );
    P( G, H, A, B, C, D, E, F, R(50), 0x2748774C );
    P( F, G, H, A, B, C, D, E, R(51), 0x34B0BCB5 );
    P( E, F, G, H, A, B, C, D, R(52), 0x391C0CB3 );
    P( D, E, F, G, H, A, B, C, R(53), 0x4ED8AA4A );
    P( C, D, E, F, G, H, A, B, R(54), 0x5B9CCA4F );
    P( B, C, D, E, F, G, H, A, R(55), 0x682E6FF3 );
    P( A, B, C, D, E, F, G, H, R(56), 0x748F82EE );
    P( H, A, B, C, D, E, F, G, R(57), 0x78A5636F );
    P( G, H, A, B, C, D, E, F, R(58), 0x84C87814 );
    P( F, G, H, A, B, C, D, E, R(59), 0x8CC70208 );
    P( E, F, G, H, A, B, C, D, R(60), 0x90BEFFFA );
    P( D, E, F, G, H, A, B, C, R(61), 0xA4506CEB );
    P( C, D, E, F, G, H, A, B, R(62), 0xBEF9A3F7 );
    P( B, C, D, E, F, G, H, A, R(63), 0xC67178F2 );

    state[0] += A;
    state[1] += B;
    state[2] += C;
    state[3] += D;
    state[4] += E;
    state[5] += F;
    state[6] += G;
    state[7] += H;
}



inline void sha256_step_local( const UINT *data, UINT *state, const UINT offset )
{
   DEF_W_VARS;
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

    P( A, B, C, D, E, F, G, H, READ_W(0), 0x428A2F98 );
    P( H, A, B, C, D, E, F, G, READ_W(1), 0x71374491 );
    P( G, H, A, B, C, D, E, F, READ_W(2), 0xB5C0FBCF );
    P( F, G, H, A, B, C, D, E, READ_W(3), 0xE9B5DBA5 );
    P( E, F, G, H, A, B, C, D, READ_W(4), 0x3956C25B );
    P( D, E, F, G, H, A, B, C, READ_W(5), 0x59F111F1 );
    P( C, D, E, F, G, H, A, B, READ_W(6), 0x923F82A4 );
    P( B, C, D, E, F, G, H, A, READ_W(7), 0xAB1C5ED5 );
    P( A, B, C, D, E, F, G, H, READ_W(8), 0xD807AA98 );
    P( H, A, B, C, D, E, F, G, READ_W(9), 0x12835B01 );
    P( G, H, A, B, C, D, E, F, READ_W(10), 0x243185BE );
    P( F, G, H, A, B, C, D, E, READ_W(11), 0x550C7DC3 );
    P( E, F, G, H, A, B, C, D, READ_W(12), 0x72BE5D74 );
    P( D, E, F, G, H, A, B, C, READ_W(13), 0x80DEB1FE );
    P( C, D, E, F, G, H, A, B, READ_W(14), 0x9BDC06A7 );
    P( B, C, D, E, F, G, H, A, READ_W(15), 0xC19BF174 );
    P( A, B, C, D, E, F, G, H, R(16), 0xE49B69C1 );
    P( H, A, B, C, D, E, F, G, R(17), 0xEFBE4786 );
    P( G, H, A, B, C, D, E, F, R(18), 0x0FC19DC6 );
    P( F, G, H, A, B, C, D, E, R(19), 0x240CA1CC );
    P( E, F, G, H, A, B, C, D, R(20), 0x2DE92C6F );
    P( D, E, F, G, H, A, B, C, R(21), 0x4A7484AA );
    P( C, D, E, F, G, H, A, B, R(22), 0x5CB0A9DC );
    P( B, C, D, E, F, G, H, A, R(23), 0x76F988DA );
    P( A, B, C, D, E, F, G, H, R(24), 0x983E5152 );
    P( H, A, B, C, D, E, F, G, R(25), 0xA831C66D );
    P( G, H, A, B, C, D, E, F, R(26), 0xB00327C8 );
    P( F, G, H, A, B, C, D, E, R(27), 0xBF597FC7 );
    P( E, F, G, H, A, B, C, D, R(28), 0xC6E00BF3 );
    P( D, E, F, G, H, A, B, C, R(29), 0xD5A79147 );
    P( C, D, E, F, G, H, A, B, R(30), 0x06CA6351 );
    P( B, C, D, E, F, G, H, A, R(31), 0x14292967 );
    P( A, B, C, D, E, F, G, H, R(32), 0x27B70A85 );
    P( H, A, B, C, D, E, F, G, R(33), 0x2E1B2138 );
    P( G, H, A, B, C, D, E, F, R(34), 0x4D2C6DFC );
    P( F, G, H, A, B, C, D, E, R(35), 0x53380D13 );
    P( E, F, G, H, A, B, C, D, R(36), 0x650A7354 );
    P( D, E, F, G, H, A, B, C, R(37), 0x766A0ABB );
    P( C, D, E, F, G, H, A, B, R(38), 0x81C2C92E );
    P( B, C, D, E, F, G, H, A, R(39), 0x92722C85 );
    P( A, B, C, D, E, F, G, H, R(40), 0xA2BFE8A1 );
    P( H, A, B, C, D, E, F, G, R(41), 0xA81A664B );
    P( G, H, A, B, C, D, E, F, R(42), 0xC24B8B70 );
    P( F, G, H, A, B, C, D, E, R(43), 0xC76C51A3 );
    P( E, F, G, H, A, B, C, D, R(44), 0xD192E819 );
    P( D, E, F, G, H, A, B, C, R(45), 0xD6990624 );
    P( C, D, E, F, G, H, A, B, R(46), 0xF40E3585 );
    P( B, C, D, E, F, G, H, A, R(47), 0x106AA070 );
    P( A, B, C, D, E, F, G, H, R(48), 0x19A4C116 );
    P( H, A, B, C, D, E, F, G, R(49), 0x1E376C08 );
    P( G, H, A, B, C, D, E, F, R(50), 0x2748774C );
    P( F, G, H, A, B, C, D, E, R(51), 0x34B0BCB5 );
    P( E, F, G, H, A, B, C, D, R(52), 0x391C0CB3 );
    P( D, E, F, G, H, A, B, C, R(53), 0x4ED8AA4A );
    P( C, D, E, F, G, H, A, B, R(54), 0x5B9CCA4F );
    P( B, C, D, E, F, G, H, A, R(55), 0x682E6FF3 );
    P( A, B, C, D, E, F, G, H, R(56), 0x748F82EE );
    P( H, A, B, C, D, E, F, G, R(57), 0x78A5636F );
    P( G, H, A, B, C, D, E, F, R(58), 0x84C87814 );
    P( F, G, H, A, B, C, D, E, R(59), 0x8CC70208 );
    P( E, F, G, H, A, B, C, D, R(60), 0x90BEFFFA );
    P( D, E, F, G, H, A, B, C, R(61), 0xA4506CEB );
    P( C, D, E, F, G, H, A, B, R(62), 0xBEF9A3F7 );
    P( B, C, D, E, F, G, H, A, R(63), 0xC67178F2 );

    state[0] += A;
    state[1] += B;
    state[2] += C;
    state[3] += D;
    state[4] += E;
    state[5] += F;
    state[6] += G;
    state[7] += H;
}


#define choose_temp(x) ((x)/16)

#define STORE_TO_TEMP(i) tb[((i)/16)][((i)%16)]

#define WAVE_FRONT (32)


__kernel
__attribute__((vec_type_hint(uint)))
__attribute__((work_group_size_hint(256, 1, 1)))
void CryptThread(__global const uint *buffer, __global uint *state, const uint blockLen)
{
	const uint init[8] = {
		0x6a09e667,
		0xbb67ae85,
		0x3c6ef372,
		0xa54ff53a,
		0x510e527f,
		0x9b05688c,
		0x1f83d9ab,
		0x5be0cd19,
	};

	const uint id = get_global_id(0);
	uint len = blockLen;
	uint i, j;

	const uint startPosInDWORDs = (len*id*VECTOR_LEN)/4;

	const uint msgLenInBitsl = len * 8;
	const uint msgLenInBitsh = (len) >> (32-3);
	UINT localState[8];

	for (j=0; j<8; j++) {
		localState[j] = init[j];
	}

	i = 0;
	while (len >=64)
	{
		const uint uOffset = startPosInDWORDs + i;

#if 0
		UINT data[16];

		for (j=0; j<16; j++)
		{
			data[j] = buffer[j*step + uOffset];
		}
#endif

		sha256_step_global(buffer, localState, uOffset);
		i += 16;
		len -= 64;
	}

	len /= 4;

	UINT tb[2][16];

	for (j=0; j<len; j++)
	{
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

	sha256_step_local(tb[0], localState, 0);
	if (32 == i)
	{
		sha256_step_local(tb[1], localState, 0);
	}

	for (j=0; j<8; j++)
	{
		state[startPosInDWORDs + j] = localState[j];
	}
}




// buildOptions= -D _IS_GPU_
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D _IS_GPU_" %cfg_path --cl-device=%cl_device 2>&1
