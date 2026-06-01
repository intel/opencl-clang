
inline uint Load(__global uint* pData, const uint iX, const uint iY)
{
	return pData[iX | (iY << 8)];
}


inline uint4 Load4(__global uint* pData, const uint4 uX, const uint iY)
{
	uint  uExtent = iY << 8;
	uint4 uNdx = uX + uExtent;

	return (uint4)(pData[uNdx.x], pData[uNdx.y], pData[uNdx.z], pData[uNdx.w]);
}


__kernel
__attribute__((vec_type_hint(uint4)))
void CryptThread(__global uint4* pInput, __global uint4* pOutput,
						__global uint* pTables,
						__global uint4* pKey, const uint iRounds)
{
	const uint iNdx = get_global_id(0);

	uint4 state, istate, tstate;
	state = pInput[iNdx] ^ pKey[0];

	for (uint i = 1; i < iRounds; i++)
	{
		istate = state & 0xFF;
		tstate = Load4(pTables, istate.xyzw, 0);

		istate = (state >> 8) & 0xFF;
		tstate^= Load4(pTables, istate.yzwx, 1);

		istate = (state >> 16) & 0xFF;
		tstate^= Load4(pTables, istate.zwxy, 2);

		istate = state >> 24;
		tstate^= Load4(pTables, istate.wxyz, 3);

		state = tstate ^ pKey[i];
	}

	istate = state & 0xFF;
	tstate = Load4(pTables, istate.xyzw, 4);

	istate = (state >> 8) & 0xFF;
	tstate |= Load4(pTables, istate.yzwx, 4) << 8;

	istate = (state >> 16) & 0xFF;
	tstate |= Load4(pTables, istate.zwxy, 4) << 16;

	istate = state >> 24;
	tstate |= Load4(pTables, istate.wxyz, 4) << 24;

	pOutput[iNdx] = tstate ^ pKey[iRounds];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
