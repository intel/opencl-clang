
#define AES_BLOCK_SIZE		16
#define AES_TABLE_SIZE		256

#define AES_TABLE_MAX		5
#define AES_CONST_SIZE		(AES_TABLE_SIZE*AES_TABLE_MAX)

#define AES_ROUND_256		14
#define AES_ROUNDKEY_MAX	(AES_BLOCK_SIZE/4*(AES_ROUND_256+1))


inline uint Load(
#ifdef _IS_GPU_
	__local uint* pData,
#else
	__constant uint* pData,
#endif
	const uint iX, const uint iY)
{
	const uint uNdx = iX + iY*AES_TABLE_SIZE;
	return pData[uNdx];
}


inline uint4 Load4(
#ifdef _IS_GPU_
	__local uint* pData,
#else
	__constant uint* pData,
#endif
	const uint4 uX, const uint iY)
{
	const uint  uExtent = iY*AES_TABLE_SIZE;
	const uint4 uNdx = uX + uExtent;

	return (uint4)(pData[uNdx.x], pData[uNdx.y], pData[uNdx.z], pData[uNdx.w]);
}


__kernel
__attribute__((vec_type_hint(uint4)))
__attribute__((work_group_size_hint(AES_TABLE_SIZE, 1, 1)))
void CryptThread(__global const uint4* pInput, __global uint4* pOutput,
						__constant uint* pTables,
						__constant uint4* pKey, const uint iRounds)
{
	const size_t iNdx = get_global_id(0);

#ifdef _IS_GPU_
		#define Load4T(x, y)	Load4(ulTables, x, y)

		__local uint  ulTables[AES_CONST_SIZE];

	const size_t iLdx = get_local_id(0);
	if (iLdx < AES_TABLE_SIZE) {
		const size_t iGrps = get_local_size(0);
		const size_t iLSize = min(iGrps, (size_t)AES_TABLE_SIZE);
		const size_t iBpL = AES_CONST_SIZE/iLSize;

		const size_t iStart = iLdx*iBpL;
		const size_t iEnd   = iStart + iBpL;

				for (size_t i=iStart; i<iEnd; i++) {
			ulTables[i] = pTables[i];
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);
#else
		#define Load4T(x, y)	Load4(pTables, x, y)
#endif

	uint4 state, istate, tstate;
	state = pInput[iNdx] ^ pKey[0];

	for (uint i = 1; i < iRounds; i++)
	{
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
}


// buildOptions= -D _IS_GPU_
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D _IS_GPU_" %cfg_path --cl-device=%cl_device 2>&1
