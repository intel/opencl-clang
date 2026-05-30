
#define AES_BLOCK_SIZE		16
#define AES_TABLE_SIZE		256

#define AES_TABLE_MAX		5
#define AES_CONST_SIZE		(AES_TABLE_SIZE*AES_TABLE_MAX)

#define AES_ROUND_128		10
#define AES_ROUND_192		12
#define AES_ROUND_256		14
#define AES_ROUNDKEY_MAX	(AES_BLOCK_SIZE/4*(AES_ROUND_256+1))


inline uint Load(
#ifdef _IS_GPU_
	__local uint* pData,
#elif defined(USE_CONST_TABLES)
	__constant uint* pData,
#else
	__global const uint* restrict pData,
#endif
	const uint iX, const uint iY)
{
	const uint uNdx = iX + iY*AES_TABLE_SIZE;
	return pData[uNdx];
}


inline uint4 Load4(
#ifdef _IS_GPU_
	__local uint* pData,
#elif defined(USE_CONST_TABLES)
	__constant uint* pData,
#else
	__global const uint* restrict pData,
#endif
	const uint4 uX, const uint iY)
{
	const uint  uExtent = iY*AES_TABLE_SIZE;
	const uint4 uNdx = uX + uExtent;

	return (uint4)(pData[uNdx.x], pData[uNdx.y], pData[uNdx.z], pData[uNdx.w]);
}


__kernel
__attribute__((vec_type_hint(uint4)))
#ifdef KERNEL_MAX_THREADS
__attribute__((work_group_size_hint(KERNEL_MAX_THREADS, 1, 1)))
#endif
void CryptThread(__global const uint4* restrict pInput, __global uint4* restrict pOutput,
#if defined(USE_CONST_TABLES)
	__constant uint* pTables,
#else
	__global const uint* restrict pTables,
#endif
	__constant uint4* pKey, const uint iRounds)
{
	const size_t iNdx = get_global_id(0);

#ifdef _IS_GPU_
		#define Load4T(x, y)	Load4(ulTables, x, y)

		__local uint  ulTables[AES_CONST_SIZE];

	const uint iLdx = get_local_id(0);
	if (iLdx < AES_TABLE_SIZE) {
		const uint iGrps = get_local_size(0);
		const uint iLSize = min(iGrps, (uint)AES_TABLE_SIZE);
		const uint iBpL = AES_CONST_SIZE/iLSize;

		const uint iStart = iLdx*iBpL;
		const uint iEnd   = iStart + iBpL;

				#pragma unroll
		for (uint i=iStart; i<iEnd; i++) {
			ulTables[i] = pTables[i];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);
#else
		#define Load4T(x, y)	Load4(pTables, x, y)
#endif

#ifdef RUN_AES_DECRYPT
  	uint4 state = pInput[iNdx] ^ pKey[iRounds];
	uint4 istate, tstate;

		for (uint i = iRounds-1; i > 0; i--) {
		istate = state & 0xFF;
		tstate = Load4T(istate.xyzw, 0);

		istate = (state >> 8) & 0xFF;
		tstate^= Load4T(istate.wxyz, 1);

		istate = (state >> 16) & 0xFF;
		tstate^= Load4T(istate.zwxy, 2);

		istate = state >> 24;
		tstate^= Load4T(istate.yzwx, 3);

		state = tstate ^ pKey[i];
	}

	istate = state & 0xFF;
	tstate = Load4T(istate.xyzw, 4);

	istate = (state >> 8) & 0xFF;
	tstate |= Load4T(istate.wxyz, 4) << 8;

	istate = (state >> 16) & 0xFF;
	tstate |= Load4T(istate.zwxy, 4) << 16;

	istate = state >> 24;
	tstate |= Load4T(istate.yzwx, 4) << 24;

	pOutput[iNdx] = tstate ^ pKey[0];
#endif

#ifdef RUN_AES_ENCRYPT
   	uint4 state = pInput[iNdx] ^ pKey[0];
	uint4 istate, tstate;

		for (uint i = 1; i < iRounds; i++) {
		istate = state & 0xFF;
		tstate = Load4T(istate.xyzw, 0);

		istate = (state >> 8) & 0xFF;
		tstate^= Load4T(istate.yzwx, 1);

		istate = (state >> 16) & 0xFF;
		tstate^= Load4T(istate.zwxy, 2);

		istate = state >> 24;
		tstate^= Load4T(istate.wxyz, 3);

		state = tstate ^ pKey[i];
	}

	istate = state & 0xFF;
	tstate = Load4T(istate.xyzw, 4);

	istate = (state >> 8) & 0xFF;
	tstate |= Load4T(istate.yzwx, 4) << 8;

	istate = (state >> 16) & 0xFF;
	tstate |= Load4T(istate.zwxy, 4) << 16;

	istate = state >> 24;
	tstate |= Load4T(istate.wxyz, 4) << 24;

	pOutput[iNdx] = tstate ^ pKey[iRounds];
#endif
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
