
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



#define S(x,n) ((x << n) | ((x) >> (32 - n)))



#define STEP(a,b,c,d,e) e += S(a,5) + F(b,c,d) + K + temp; b = S(b,30)

#define P(a,b,c,d,e,x)                          \
	R(x);										\
    STEP(a,b,c,d,e);							\


#define PP(a,b,c,d,e,x,base)                         \
    ACCESS_W(x) = temp = byteswap(data[(x+base)]);	\
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



#ifndef MACRO_HEAVEN

#define DEF_W	UINT W[80]

#define ACCESS_W(t) W[(t)]

#define R(t)                                            \
    temp = ACCESS_W(t -  3) ^ ACCESS_W(t - 8) ^			\
           ACCESS_W(t - 14) ^ ACCESS_W(t - 16);			\
    temp = ACCESS_W(t) = S(temp,1)                      \



#else

#define DEF_W UINT W_0,W_1,W_2,W_3,W_4,W_5,W_6,W_7,W_8,W_9,W_10,W_11,W_12,W_13,W_14,W_15


#define CALC_SHA1_W_16 temp = ACCESS_W(13) ^ ACCESS_W(8) ^ ACCESS_W(2) ^ ACCESS_W(0); temp = ACCESS_W(0) = S(temp,1);
#define CALC_SHA1_W_17 temp = ACCESS_W(14) ^ ACCESS_W(9) ^ ACCESS_W(3) ^ ACCESS_W(1); temp = ACCESS_W(1) = S(temp,1);
#define CALC_SHA1_W_18 temp = ACCESS_W(15) ^ ACCESS_W(10) ^ ACCESS_W(4) ^ ACCESS_W(2); temp = ACCESS_W(2) = S(temp,1);
#define CALC_SHA1_W_19 temp = ACCESS_W(0) ^ ACCESS_W(11) ^ ACCESS_W(5) ^ ACCESS_W(3); temp = ACCESS_W(3) = S(temp,1);
#define CALC_SHA1_W_20 temp = ACCESS_W(1) ^ ACCESS_W(12) ^ ACCESS_W(6) ^ ACCESS_W(4); temp = ACCESS_W(4) = S(temp,1);
#define CALC_SHA1_W_21 temp = ACCESS_W(2) ^ ACCESS_W(13) ^ ACCESS_W(7) ^ ACCESS_W(5); temp = ACCESS_W(5) = S(temp,1);
#define CALC_SHA1_W_22 temp = ACCESS_W(3) ^ ACCESS_W(14) ^ ACCESS_W(8) ^ ACCESS_W(6); temp = ACCESS_W(6) = S(temp,1);
#define CALC_SHA1_W_23 temp = ACCESS_W(4) ^ ACCESS_W(15) ^ ACCESS_W(9) ^ ACCESS_W(7); temp = ACCESS_W(7) = S(temp,1);
#define CALC_SHA1_W_24 temp = ACCESS_W(5) ^ ACCESS_W(0) ^ ACCESS_W(10) ^ ACCESS_W(8); temp = ACCESS_W(8) = S(temp,1);
#define CALC_SHA1_W_25 temp = ACCESS_W(6) ^ ACCESS_W(1) ^ ACCESS_W(11) ^ ACCESS_W(9); temp = ACCESS_W(9) = S(temp,1);
#define CALC_SHA1_W_26 temp = ACCESS_W(7) ^ ACCESS_W(2) ^ ACCESS_W(12) ^ ACCESS_W(10); temp = ACCESS_W(10) = S(temp,1);
#define CALC_SHA1_W_27 temp = ACCESS_W(8) ^ ACCESS_W(3) ^ ACCESS_W(13) ^ ACCESS_W(11); temp = ACCESS_W(11) = S(temp,1);
#define CALC_SHA1_W_28 temp = ACCESS_W(9) ^ ACCESS_W(4) ^ ACCESS_W(14) ^ ACCESS_W(12); temp = ACCESS_W(12) = S(temp,1);
#define CALC_SHA1_W_29 temp = ACCESS_W(10) ^ ACCESS_W(5) ^ ACCESS_W(15) ^ ACCESS_W(13); temp = ACCESS_W(13) = S(temp,1);
#define CALC_SHA1_W_30 temp = ACCESS_W(11) ^ ACCESS_W(6) ^ ACCESS_W(0) ^ ACCESS_W(14); temp = ACCESS_W(14) = S(temp,1);
#define CALC_SHA1_W_31 temp = ACCESS_W(12) ^ ACCESS_W(7) ^ ACCESS_W(1) ^ ACCESS_W(15); temp = ACCESS_W(15) = S(temp,1);
#define CALC_SHA1_W_32 temp = ACCESS_W(13) ^ ACCESS_W(8) ^ ACCESS_W(2) ^ ACCESS_W(0); temp = ACCESS_W(0) = S(temp,1);
#define CALC_SHA1_W_33 temp = ACCESS_W(14) ^ ACCESS_W(9) ^ ACCESS_W(3) ^ ACCESS_W(1); temp = ACCESS_W(1) = S(temp,1);
#define CALC_SHA1_W_34 temp = ACCESS_W(15) ^ ACCESS_W(10) ^ ACCESS_W(4) ^ ACCESS_W(2); temp = ACCESS_W(2) = S(temp,1);
#define CALC_SHA1_W_35 temp = ACCESS_W(0) ^ ACCESS_W(11) ^ ACCESS_W(5) ^ ACCESS_W(3); temp = ACCESS_W(3) = S(temp,1);
#define CALC_SHA1_W_36 temp = ACCESS_W(1) ^ ACCESS_W(12) ^ ACCESS_W(6) ^ ACCESS_W(4); temp = ACCESS_W(4) = S(temp,1);
#define CALC_SHA1_W_37 temp = ACCESS_W(2) ^ ACCESS_W(13) ^ ACCESS_W(7) ^ ACCESS_W(5); temp = ACCESS_W(5) = S(temp,1);
#define CALC_SHA1_W_38 temp = ACCESS_W(3) ^ ACCESS_W(14) ^ ACCESS_W(8) ^ ACCESS_W(6); temp = ACCESS_W(6) = S(temp,1);
#define CALC_SHA1_W_39 temp = ACCESS_W(4) ^ ACCESS_W(15) ^ ACCESS_W(9) ^ ACCESS_W(7); temp = ACCESS_W(7) = S(temp,1);
#define CALC_SHA1_W_40 temp = ACCESS_W(5) ^ ACCESS_W(0) ^ ACCESS_W(10) ^ ACCESS_W(8); temp = ACCESS_W(8) = S(temp,1);
#define CALC_SHA1_W_41 temp = ACCESS_W(6) ^ ACCESS_W(1) ^ ACCESS_W(11) ^ ACCESS_W(9); temp = ACCESS_W(9) = S(temp,1);
#define CALC_SHA1_W_42 temp = ACCESS_W(7) ^ ACCESS_W(2) ^ ACCESS_W(12) ^ ACCESS_W(10); temp = ACCESS_W(10) = S(temp,1);
#define CALC_SHA1_W_43 temp = ACCESS_W(8) ^ ACCESS_W(3) ^ ACCESS_W(13) ^ ACCESS_W(11); temp = ACCESS_W(11) = S(temp,1);
#define CALC_SHA1_W_44 temp = ACCESS_W(9) ^ ACCESS_W(4) ^ ACCESS_W(14) ^ ACCESS_W(12); temp = ACCESS_W(12) = S(temp,1);
#define CALC_SHA1_W_45 temp = ACCESS_W(10) ^ ACCESS_W(5) ^ ACCESS_W(15) ^ ACCESS_W(13); temp = ACCESS_W(13) = S(temp,1);
#define CALC_SHA1_W_46 temp = ACCESS_W(11) ^ ACCESS_W(6) ^ ACCESS_W(0) ^ ACCESS_W(14); temp = ACCESS_W(14) = S(temp,1);
#define CALC_SHA1_W_47 temp = ACCESS_W(12) ^ ACCESS_W(7) ^ ACCESS_W(1) ^ ACCESS_W(15); temp = ACCESS_W(15) = S(temp,1);
#define CALC_SHA1_W_48 temp = ACCESS_W(13) ^ ACCESS_W(8) ^ ACCESS_W(2) ^ ACCESS_W(0); temp = ACCESS_W(0) = S(temp,1);
#define CALC_SHA1_W_49 temp = ACCESS_W(14) ^ ACCESS_W(9) ^ ACCESS_W(3) ^ ACCESS_W(1); temp = ACCESS_W(1) = S(temp,1);
#define CALC_SHA1_W_50 temp = ACCESS_W(15) ^ ACCESS_W(10) ^ ACCESS_W(4) ^ ACCESS_W(2); temp = ACCESS_W(2) = S(temp,1);
#define CALC_SHA1_W_51 temp = ACCESS_W(0) ^ ACCESS_W(11) ^ ACCESS_W(5) ^ ACCESS_W(3); temp = ACCESS_W(3) = S(temp,1);
#define CALC_SHA1_W_52 temp = ACCESS_W(1) ^ ACCESS_W(12) ^ ACCESS_W(6) ^ ACCESS_W(4); temp = ACCESS_W(4) = S(temp,1);
#define CALC_SHA1_W_53 temp = ACCESS_W(2) ^ ACCESS_W(13) ^ ACCESS_W(7) ^ ACCESS_W(5); temp = ACCESS_W(5) = S(temp,1);
#define CALC_SHA1_W_54 temp = ACCESS_W(3) ^ ACCESS_W(14) ^ ACCESS_W(8) ^ ACCESS_W(6); temp = ACCESS_W(6) = S(temp,1);
#define CALC_SHA1_W_55 temp = ACCESS_W(4) ^ ACCESS_W(15) ^ ACCESS_W(9) ^ ACCESS_W(7); temp = ACCESS_W(7) = S(temp,1);
#define CALC_SHA1_W_56 temp = ACCESS_W(5) ^ ACCESS_W(0) ^ ACCESS_W(10) ^ ACCESS_W(8); temp = ACCESS_W(8) = S(temp,1);
#define CALC_SHA1_W_57 temp = ACCESS_W(6) ^ ACCESS_W(1) ^ ACCESS_W(11) ^ ACCESS_W(9); temp = ACCESS_W(9) = S(temp,1);
#define CALC_SHA1_W_58 temp = ACCESS_W(7) ^ ACCESS_W(2) ^ ACCESS_W(12) ^ ACCESS_W(10); temp = ACCESS_W(10) = S(temp,1);
#define CALC_SHA1_W_59 temp = ACCESS_W(8) ^ ACCESS_W(3) ^ ACCESS_W(13) ^ ACCESS_W(11); temp = ACCESS_W(11) = S(temp,1);
#define CALC_SHA1_W_60 temp = ACCESS_W(9) ^ ACCESS_W(4) ^ ACCESS_W(14) ^ ACCESS_W(12); temp = ACCESS_W(12) = S(temp,1);
#define CALC_SHA1_W_61 temp = ACCESS_W(10) ^ ACCESS_W(5) ^ ACCESS_W(15) ^ ACCESS_W(13); temp = ACCESS_W(13) = S(temp,1);
#define CALC_SHA1_W_62 temp = ACCESS_W(11) ^ ACCESS_W(6) ^ ACCESS_W(0) ^ ACCESS_W(14); temp = ACCESS_W(14) = S(temp,1);
#define CALC_SHA1_W_63 temp = ACCESS_W(12) ^ ACCESS_W(7) ^ ACCESS_W(1) ^ ACCESS_W(15); temp = ACCESS_W(15) = S(temp,1);
#define CALC_SHA1_W_64 temp = ACCESS_W(13) ^ ACCESS_W(8) ^ ACCESS_W(2) ^ ACCESS_W(0); temp = ACCESS_W(0) = S(temp,1);
#define CALC_SHA1_W_65 temp = ACCESS_W(14) ^ ACCESS_W(9) ^ ACCESS_W(3) ^ ACCESS_W(1); temp = ACCESS_W(1) = S(temp,1);
#define CALC_SHA1_W_66 temp = ACCESS_W(15) ^ ACCESS_W(10) ^ ACCESS_W(4) ^ ACCESS_W(2); temp = ACCESS_W(2) = S(temp,1);
#define CALC_SHA1_W_67 temp = ACCESS_W(0) ^ ACCESS_W(11) ^ ACCESS_W(5) ^ ACCESS_W(3); temp = ACCESS_W(3) = S(temp,1);
#define CALC_SHA1_W_68 temp = ACCESS_W(1) ^ ACCESS_W(12) ^ ACCESS_W(6) ^ ACCESS_W(4); temp = ACCESS_W(4) = S(temp,1);
#define CALC_SHA1_W_69 temp = ACCESS_W(2) ^ ACCESS_W(13) ^ ACCESS_W(7) ^ ACCESS_W(5); temp = ACCESS_W(5) = S(temp,1);
#define CALC_SHA1_W_70 temp = ACCESS_W(3) ^ ACCESS_W(14) ^ ACCESS_W(8) ^ ACCESS_W(6); temp = ACCESS_W(6) = S(temp,1);
#define CALC_SHA1_W_71 temp = ACCESS_W(4) ^ ACCESS_W(15) ^ ACCESS_W(9) ^ ACCESS_W(7); temp = ACCESS_W(7) = S(temp,1);
#define CALC_SHA1_W_72 temp = ACCESS_W(5) ^ ACCESS_W(0) ^ ACCESS_W(10) ^ ACCESS_W(8); temp = ACCESS_W(8) = S(temp,1);
#define CALC_SHA1_W_73 temp = ACCESS_W(6) ^ ACCESS_W(1) ^ ACCESS_W(11) ^ ACCESS_W(9); temp = ACCESS_W(9) = S(temp,1);
#define CALC_SHA1_W_74 temp = ACCESS_W(7) ^ ACCESS_W(2) ^ ACCESS_W(12) ^ ACCESS_W(10); temp = ACCESS_W(10) = S(temp,1);
#define CALC_SHA1_W_75 temp = ACCESS_W(8) ^ ACCESS_W(3) ^ ACCESS_W(13) ^ ACCESS_W(11); temp = ACCESS_W(11) = S(temp,1);
#define CALC_SHA1_W_76 temp = ACCESS_W(9) ^ ACCESS_W(4) ^ ACCESS_W(14) ^ ACCESS_W(12); temp = ACCESS_W(12) = S(temp,1);
#define CALC_SHA1_W_77 temp = ACCESS_W(10) ^ ACCESS_W(5) ^ ACCESS_W(15) ^ ACCESS_W(13); temp = ACCESS_W(13) = S(temp,1);
#define CALC_SHA1_W_78 temp = ACCESS_W(11) ^ ACCESS_W(6) ^ ACCESS_W(0) ^ ACCESS_W(14); temp = ACCESS_W(14) = S(temp,1);
#define CALC_SHA1_W_79 temp = ACCESS_W(12) ^ ACCESS_W(7) ^ ACCESS_W(1) ^ ACCESS_W(15); temp = ACCESS_W(15) = S(temp,1);

#define ACCESS_W(t) W_ ## t

#define R(t)                                            \
	CALC_SHA1_W_ ## t;									\



#endif



inline void sha1_step( const UINT* data, UINT *state, const UINT base )
{
   DEF_W;
   UINT temp;
   UINT A, B, C, D, E;

   A = state[0];
   B = state[1];
   C = state[2];
   D = state[3];
   E = state[4];

#define F(x,y,z) (z ^ (x & (y ^ z)))
#define K 0x5A827999

      PP( A, B, C, D, E, 0 , base  );
      PP( E, A, B, C, D, 1 , base  );
      PP( D, E, A, B, C, 2 , base  );
      PP( C, D, E, A, B, 3 , base  );
      PP( B, C, D, E, A, 4 , base  );
      PP( A, B, C, D, E, 5 , base );
      PP( E, A, B, C, D, 6 , base  );
      PP( D, E, A, B, C, 7 , base  );
      PP( C, D, E, A, B, 8 , base  );
      PP( B, C, D, E, A, 9 , base  );
      PP( A, B, C, D, E, 10 , base  );
      PP( E, A, B, C, D, 11 , base  );
      PP( D, E, A, B, C, 12 , base  );
      PP( C, D, E, A, B, 13 , base  );
      PP( B, C, D, E, A, 14 , base  );

   PP( A, B, C, D, E, 15 , base );
   P( E, A, B, C, D, 16 );
   P( D, E, A, B, C, 17 );
   P( C, D, E, A, B, 18 );
   P( B, C, D, E, A, 19 );

#undef K
#undef F

#define F(x,y,z) (x ^ y ^ z)
#define K 0x6ED9EBA1

		TEN_ROUND(2)
		TEN_ROUND(3)

#undef K
#undef F

#define F(x,y,z) ((x & y) | (z & (x | y)))
#define K 0x8F1BBCDC

		TEN_ROUND(4)
		TEN_ROUND(5)

#undef K
#undef F

#define F(x,y,z) (x ^ y ^ z)
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




inline void sha1_step_global( __global const UINT *data, UINT *state, const UINT base )
{
   DEF_W;
   UINT temp;
   UINT A, B, C, D, E;

   A = state[0];
   B = state[1];
   C = state[2];
   D = state[3];
   E = state[4];


#define F(x,y,z) (z ^ (x & (y ^ z)))
#define K 0x5A827999

      PP( A, B, C, D, E, 0 , base  );
      PP( E, A, B, C, D, 1 , base  );
      PP( D, E, A, B, C, 2 , base );
      PP( C, D, E, A, B, 3 , base  );
      PP( B, C, D, E, A, 4 , base  );
      PP( A, B, C, D, E, 5 , base  );
      PP( E, A, B, C, D, 6 , base  );
      PP( D, E, A, B, C, 7 , base  );
      PP( C, D, E, A, B, 8 , base  );
      PP( B, C, D, E, A, 9 , base  );
      PP( A, B, C, D, E, 10 , base  );
      PP( E, A, B, C, D, 11 , base  );
      PP( D, E, A, B, C, 12 , base  );
      PP( C, D, E, A, B, 13 , base  );
      PP( B, C, D, E, A, 14 , base  );

   PP( A, B, C, D, E, 15 , base );
   P( E, A, B, C, D, 16 );
   P( D, E, A, B, C, 17 );
   P( C, D, E, A, B, 18 );
   P( B, C, D, E, A, 19 );

#undef K
#undef F

#define F(x,y,z) (x ^ y ^ z)
#define K 0x6ED9EBA1

		TEN_ROUND(2)
		TEN_ROUND(3)

#undef K
#undef F

#define F(x,y,z) ((x & y) | (z & (x | y)))
#define K 0x8F1BBCDC

		TEN_ROUND(4)
		TEN_ROUND(5)

#undef K
#undef F

#define F(x,y,z) (x ^ y ^ z)
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


#define choose_temp(x) ((x)/16)

#define STORE_TO_TEMP(i) tb[((i)/16)][((i)%16)]


__kernel
__attribute__((vec_type_hint(uint)))
__attribute__((work_group_size_hint(256, 1, 1)))
void CryptThread(__global const uint *buffer, __global uint *state, const uint blockLen)
{
	const uint init[5] = {
	   0x67452301,
	   0xEFCDAB89,
	   0x98BADCFE,
	   0x10325476,
	   0xC3D2E1F0,
	};

	const uint id = get_global_id(0);
	uint len = blockLen;
	uint i, j;

	const uint startPosInDWORDs = (len*id*VECTOR_LEN)/4;

	const uint msgLenInBitsl = len * 8;
	const uint msgLenInBitsh = (len) >> (32-3);
	UINT localState[5];

	for (j=0; j<5; j++) {
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
			data[j] = buffer[j + uOffset];
		}
#endif

		sha1_step_global(buffer, localState, uOffset);
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

	sha1_step(tb[0], localState,0);
	if (32 == i)
	{
		sha1_step(tb[1], localState,0);
	}

	for (j=0; j<5; j++)
	{
		state[startPosInDWORDs + j] = localState[j];
	}
}




// buildOptions= -D _IS_GPU_
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D _IS_GPU_" %cfg_path --cl-device=%cl_device 2>&1
