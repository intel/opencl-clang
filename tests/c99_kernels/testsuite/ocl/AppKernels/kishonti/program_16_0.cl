__kernel void LocalScan
(
	__global uint *g,
	__global uint *t,
	__local uint *l
)
{
	const uint gId = get_global_id(0),
		lId = get_local_id(0),
		lIdSucc = get_local_id(0) + 1,
		lSize = get_local_size(0);

	l[lId*2] = g[gId*2];
	l[lId*2 + 1] = g[gId*2 + 1];
	barrier(CLK_LOCAL_MEM_FENCE);

	for(uint N = get_local_size(0), M = 2, m = 1; 1 <= N; N >>= 1)
	{
		if(lId < N)
		{
			const uint i = lIdSucc*M - 1;
			l[i] += l[i - m];

			M <<= 1;
			m <<= 1;
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	for(uint N = 2, M = lSize, m = lSize >> 1; N <= lSize; N <<= 1, M >>= 1, m >>= 1)
	{
		if( lIdSucc < N )
		{
			const uint i = lIdSucc*M - 1;
			l[i + m] += l[i];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	g[gId*2] = l[lId*2];
	g[gId*2 + 1] = l[lId*2 + 1];
	if(lIdSucc == lSize)
	{
		t[gId/lSize] = l[lId*2 + 1];
	}
}

__kernel void GlobalBlockAdd
(
	__global uint *g,
	__global uint *t,
	const uint lSize
)
{
	const uint gId = get_global_id(0) + lSize;
	const uint tId = get_global_id(0)/lSize;

	g[gId] += t[tId];
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
