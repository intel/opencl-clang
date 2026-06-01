#define WPI 4

__kernel
void clppiHistogram_8u_C1(__global uchar* src, __global int* hist, uint srcStride, uint width, uint height, __global int* levels, uint numLevels)
{
	local int localHist[8];

	uchar in[WPI];
	int pLevels[9];

	int gix = get_group_id(0);
    int giy = get_group_id(1);

	int lix = get_local_id(0);
	int liy = get_local_id(1);

	uint2 baseCoords = (uint2)(gix * get_local_size(0) * WPI, giy * get_local_size(1));
	uint2 coords = (uint2)(baseCoords.x + lix * WPI, baseCoords.y + liy);

    __global uchar* pSrc = ((__global uchar*)(src) + coords.y * srcStride + coords.x);

	for (uint i = 0; i < WPI; ++i)
	{
		in[i] = pSrc[i];
	}

	uint i = 0;

    for ( i = 0; i < numLevels - 8; i += 8)
	{
		if ((0 == lix) && (0 == liy))
		{
			for( uint j = 0; j < 8; ++j )
			{
				localHist[j] = 0;
			}
		}

		barrier( CLK_LOCAL_MEM_FENCE );

		for (uint j = 0; j < 9; ++j)
		{
			pLevels[j] = levels[i + j];
		}

		for( uint j = 0; j < WPI; ++j )
		{
			for( uint k = 0; k < 8; ++k )
			{
				if( in[j] >= pLevels[k] && in[j] < pLevels[k + 1] )
				{
					atomic_inc(&localHist[k]);
					break;
				}
			}
		}

		barrier( CLK_LOCAL_MEM_FENCE );

		if ((0 == lix) && (0 == liy))
		{
			for( uint j = 0; j < 8; ++j )
			{
				atomic_add(&hist[i + j], localHist[j]);
			}
		}

		barrier( CLK_LOCAL_MEM_FENCE );
    }

	if( i != numLevels )
	{
		uint remainingLevels = numLevels - i;

		if ((0 == lix) && (0 == liy))
		{
			for( uint j = 0; j < remainingLevels; ++j )
			{
				localHist[j] = 0;
			}
		}

		barrier( CLK_LOCAL_MEM_FENCE );

		for (uint j = 0; j < (remainingLevels + 1); ++j)
		{
			pLevels[j] = levels[i + j];
		}

		for( uint j = 0; j < WPI; ++j )
		{
			for( uint k = 0; k < remainingLevels; ++k )
			{
				if( in[j] >= pLevels[k] && in[j] < pLevels[k + 1] )
				{
					atomic_inc(&localHist[k]);
					break;
				}
			}
		}

		barrier( CLK_LOCAL_MEM_FENCE );

		if ((0 == lix) && (0 == liy))
		{
			for( uint j = 0; j < remainingLevels; ++j )
			{
				atomic_add(&hist[i + j], localHist[j]);
			}
		}

		barrier( CLK_LOCAL_MEM_FENCE );
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
// From groups/BDWspecificKernels.lst: status: , errorcode: , message: 
