__kernel void LocalReduction
(
	__global uint *g,
	__global uint *t,
	__local	uint *l
)
{
	const	uint gId = get_global_id(0);
	const	uint grId = get_group_id(0);
	const	uint lSize = get_local_size(0);
	const	uint lId = get_local_id(0);

	l[lId*2] = g[gId*2];
	l[lId*2 + 1] = g[gId*2 + 1];
	barrier(CLK_LOCAL_MEM_FENCE);

	for(uint N = lSize; 0 < N; N >>= 1)
	{
		if(lId < N)
		{
			l[lId] += l[lId + N];
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	if(0 == lId)
	{
		t[grId] = l[0];
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
