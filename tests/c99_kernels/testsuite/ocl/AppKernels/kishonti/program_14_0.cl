__kernel void BucketInitializing
(
	const uint bucketCount,
	__global const uint *b,
	__global uint *bSum
)
{
	const uint gId = get_global_id(0);
	const uint bucket = b[gId];

	const uint startIndex = gId*bucketCount;
	uint bucketId = 0;

	while(bucketId < bucket)
	{
		bSum[startIndex + bucketId] = 0;
		++bucketId;
	}

	bSum[startIndex + bucketId] = 1; // bucketId = bucket
	++bucketId;

	while(bucketId < bucketCount)
	{
		bSum[startIndex + bucketId] = 0;
		++bucketId;
	}
}

__kernel void LocalScan
(
	const uint bucketCount,
	__global uint *g,
	__global uint *t,
	__local uint *l
)
{
	const uint 	gId = get_global_id(0),
			lId = get_local_id(0),
			lIdSucc = get_local_id(0) + 1,
			gSize = get_global_size(0),
			lSize = get_local_size(0);

	for(uint i = 0; i < bucketCount; ++i)
	{
		l[bucketCount*(lId*2) + i] = g[bucketCount*(gId*2) + i];
		l[bucketCount*(lId*2 + 1) + i] = g[bucketCount*(gId*2 + 1) + i];
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	for(uint N = get_local_size(0), M = 2, m = 1; 1 <= N; N >>= 1)
	{
		if(lId < N)
		{
			const uint rightPartialIndex = lIdSucc*M - 1;
			const uint leftPartialIndex = rightPartialIndex - m;
			const uint	rightIndex = bucketCount*rightPartialIndex,
						leftIndex = bucketCount*leftPartialIndex;

			for(uint i = 0; i < bucketCount; ++i)
			{
				l[rightIndex + i] += l[leftIndex + i];
			}

			M <<= 1;
			m <<= 1;
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}

	for(uint N = 2, M = lSize, m = lSize >> 1; N <= lSize; N <<= 1, M >>= 1, m >>= 1)
	{
		if( lIdSucc < N )
		{
			const uint leftPartialIndex = lIdSucc*M - 1;
			const uint rightPartialIndex = leftPartialIndex + m;
			const uint	leftIndex = bucketCount*leftPartialIndex,
						rightIndex = bucketCount*rightPartialIndex;

			for(uint i = 0; i < bucketCount; ++i)
			{
				l[rightIndex + i] += l[leftIndex + i];
			}
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}


	for(uint i = 0; i < bucketCount; ++i)
	{
		g[bucketCount*(gId*2) + i] = l[bucketCount*(lId*2) + i];
		g[bucketCount*(gId*2 + 1) + i] = l[bucketCount*(lId*2 + 1) + i];
	}
	if(lIdSucc == lSize)
	{
		for(uint i = 0; i < bucketCount; ++i)
		{
			t[bucketCount*(gId/lSize) + i] = l[bucketCount*(lId*2 + 1) + i];
		}
	}
}

__kernel void GlobalBlockAdd
(
	const uint bucketCount,
	__global uint *g,
	__global uint *t,
	const uint lSize
)
{
	const uint gId = get_global_id(0) + lSize;
	const uint tId = get_global_id(0)/lSize;

	for(uint i = 0; i < bucketCount; ++i)
	{
		g[bucketCount*gId + i] += t[bucketCount*tId + i];
	}
}

__kernel void BucketPlacing
(
	const uint bucketCount,
	__global const uint *b,
	__global uint *bOffset,
	__global uint *bResult
)
{
	const uint gId = get_global_id(0);
	const uint bucket = b[gId];
	const uint bucketOffset = bOffset[gId*bucketCount + bucket] - 1;

	bResult[bucketOffset*bucketCount + bucket] = gId;
}
//bResult[offsetOfBucket[bucket] + bucketOffset] = bucket;


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
