// one WG to merge the histograms
__kernel
__attribute__((reqd_work_group_size(128,1,1)))
void histReduce128( __global const uint* restrict gHistograms, __global uint* restrict gHistogram, const int histCount )
{
	int gId = get_global_id(0);

	uint binAccum0 = 0;
	uint binAccum1 = 0;

	for(int i = 0; i < histCount; ++i)
	{
		binAccum0 += gHistograms[gId+128*0+256*i];
		binAccum1 += gHistograms[gId+128*1+256*i];
	}

	gHistogram[gId+128*0] = binAccum0;
	gHistogram[gId+128*1] = binAccum1;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
