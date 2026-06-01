// one WI to create histogram cdf
__kernel __attribute__((reqd_work_group_size(1,1,1)))
void histEval( __global uint* restrict gHistogram, __global uint* restrict gCDFMin )
{
	uint pCDF[256];

	// init cdf
	for(int i = 0; i < 256; ++i)
	{
		pCDF[i] = gHistogram[i];
	}

	// create cdf - scan opPlus
	for(int i = 1; i < 256; ++i)
	{
		pCDF[i] += pCDF[i-1];
	}

	// save
	for(int i = 0; i < 256; ++i)
	{
		gHistogram[i] = pCDF[i];
	}

	// init cdf
	gCDFMin[0] = 0;

	// search cdf - scan opMin
	for(int i = 0; i < 256; ++i)
	{
		if(pCDF[i])
		{
			gCDFMin[0] = pCDF[i];
			break;
		}
	}
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
