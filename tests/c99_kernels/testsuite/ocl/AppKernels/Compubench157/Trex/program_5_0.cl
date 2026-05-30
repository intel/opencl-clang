typedef struct
{
	float4	min, max;
} CLAABB;

typedef struct
{
	float4	plane, edgePlane20, edgePlane01;
} CLTriangle;

typedef struct
{
	int nodeData0;	// parentNode
	int nodeData1;	// childLowerNode OR startTri
	int nodeData2;	// childUpperNode OR countTri
	int nodeData3;	// node ray mask - traversal order
} CLBVHNode;

int EncodeMorton(int x, int y, int z)
{
	x = (x | (x << 16)) & 0x030000FF;
    x = (x | (x <<  8)) & 0x0300F00F;
    x = (x | (x <<  4)) & 0x030C30C3;
    x = (x | (x <<  2)) & 0x09249249;

    y = (y | (y << 16)) & 0x030000FF;
    y = (y | (y <<  8)) & 0x0300F00F;
    y = (y | (y <<  4)) & 0x030C30C3;
    y = (y | (y <<  2)) & 0x09249249;

    z = (z | (z << 16)) & 0x030000FF;
    z = (z | (z <<  8)) & 0x0300F00F;
    z = (z | (z <<  4)) & 0x030C30C3;
    z = (z | (z <<  2)) & 0x09249249;

    return x | (y << 1) | (z << 2);
}

__kernel
void clearToOnes(__global int* restrict ones)
{
	int wiIdG = get_global_id(0);

	ones[wiIdG] = 1;
}

__kernel
void calculateMortonPairs(const int numLeafs, const int depth,
						  __global const CLAABB* restrict worldAABB, __global const float4* restrict triMortonValue,
						  __global int2* restrict mortonPairs)
{
	int wiIdG = get_global_id(0);

	if(wiIdG >= numLeafs)
		return;

	float4 step = (*worldAABB).max - (*worldAABB).min;
	step.x = 1.0f / step.x;
	step.y = 1.0f / step.y;
	step.z = 1.0f / step.z;

	float4 mortonValue = triMortonValue[wiIdG];

	int xId = (mortonValue.x - (*worldAABB).min.x) * step.x * depth;
	int yId = (mortonValue.y - (*worldAABB).min.y) * step.y * depth;
	int zId = (mortonValue.z - (*worldAABB).min.z) * step.z * depth;

	int mortonCode = EncodeMorton(xId, yId, zId);

	mortonPairs[wiIdG] = (int2)(wiIdG, mortonCode);
}

__kernel
void sortTrianglesWithMorton(const int numLeafs, const int dynamicStart,
							 __global const int2* restrict mortonPairs, __global const float4* restrict vertsW,
							 __global CLTriangle* restrict triData, __global CLAABB* restrict triAABB)
{
	int wiIdG = get_global_id(0);
	int srcId = mortonPairs[wiIdG].s0;

	if(wiIdG >= numLeafs)
		return;

	// load tri data
	const float4 vertexA = vertsW[3*dynamicStart + 3*srcId  ];
	const float4 vertexB = vertsW[3*dynamicStart + 3*srcId+1];
	const float4 vertexC = vertsW[3*dynamicStart + 3*srcId+2];

	// calculate tri accdata
	CLTriangle tridata;

	tridata.plane = normalize( cross(vertexB - vertexA, vertexC - vertexA) );
	tridata.plane.w = -dot(tridata.plane, vertexA);

	tridata.edgePlane20 = normalize( cross(tridata.plane, vertexA-vertexC) );
	tridata.edgePlane20.w = -dot(tridata.edgePlane20, vertexC);

	tridata.edgePlane01 = normalize( cross(tridata.plane, vertexB-vertexA) );
	tridata.edgePlane01.w = -dot(tridata.edgePlane01, vertexA);

	tridata.edgePlane20 *= 1.0f / dot(vertexB, tridata.edgePlane20);
	tridata.edgePlane01 *= 1.0f / dot(vertexC, tridata.edgePlane01);

	// calculate tri aabb
	CLAABB triaabb;

	triaabb.min = min( vertexA, min( vertexB, vertexC ) );
	triaabb.max = max( vertexA, max( vertexB, vertexC ) );

	triData[dynamicStart+wiIdG] = tridata;
	triAABB[wiIdG] = triaabb;
}

__kernel
void writeMortonBorders(const int numLeafs, __global const int2* restrict mortonPairs,
						__global int* restrict mortonHeads, __global int* restrict mortonTails)
{
	int wiIdG = get_global_id(0);

	if(wiIdG >= numLeafs)
		return;

	int headElem = 0;
	int tailElem = 0;

	if(wiIdG > 0 && wiIdG < get_global_size(0)-1)
	{
		int2 prevElem = mortonPairs[wiIdG-1];
		int2 currElem = mortonPairs[wiIdG];
		int2 nextElem = mortonPairs[wiIdG+1];

		if(prevElem.s1 != currElem.s1)
		{
			headElem = 1;
		}

		if(nextElem.s1 != currElem.s1)
		{
			tailElem = 1;
		}
	}
	else if(wiIdG == 0)
	{
		headElem = 1;

		int2 currElem = mortonPairs[wiIdG];
		int2 nextElem = mortonPairs[wiIdG+1];

		if(nextElem.s1 != currElem.s1)
		{
			tailElem = 1;
		}
	}
	else
	{
		tailElem = 1;

		int2 prevElem = mortonPairs[wiIdG-1];
		int2 currElem = mortonPairs[wiIdG];

		if(prevElem.s1 != currElem.s1)
		{
			headElem = 1;
		}
	}

	mortonHeads[ wiIdG ] = headElem;
	mortonTails[ wiIdG ] = tailElem;
}

__kernel
void writeLeafNodes(const int leafOffset, __global const int2* restrict mortonPairs, __global const int* restrict mortonTails, __global const int* restrict uniqueLeafsAddress, __global const int* restrict uniqueLeafsCount, __global const CLAABB* restrict triAABB,
					__global CLAABB* restrict bvhNodeAABBs, __global CLBVHNode* restrict bvhNodeLinks, __global int* restrict uniqueMortonKeys)
{
	int wiIdG = get_global_id(0);

	if(mortonTails[wiIdG] == 1)
	{
		int address = uniqueLeafsAddress[wiIdG];
		int count = uniqueLeafsCount[wiIdG];

		bvhNodeAABBs[ leafOffset + address ] = triAABB[wiIdG];

		bvhNodeLinks[ leafOffset + address ].nodeData1 = wiIdG+1 - count;
		bvhNodeLinks[ leafOffset + address ].nodeData2 = count;

		uniqueMortonKeys[ address ] = mortonPairs[wiIdG].s1;
	}
}

__kernel
void buildBVHNodesKarras(__global const int* restrict mortonKeys, __global const int* restrict keyCount, __global CLBVHNode* restrict bvhNodeLinks, const int leafOffset)
{
	int nodeId = get_global_id(0);

	int range0, range1;

	if(nodeId >= keyCount[0]-1)
		return;

	if(nodeId)
	{
		int clz0 = clz( mortonKeys[nodeId] ^ mortonKeys[nodeId-1] );
		int clz1 = clz( mortonKeys[nodeId] ^ mortonKeys[nodeId+1] );

		int d = (clz1 - clz0 >= 0) ? 1 : -1;

		int prefixMin = clz( mortonKeys[nodeId] ^ mortonKeys[nodeId-d] );

		int stepMax = 2;

		while(true)
		{
			int newRange = nodeId + d*stepMax;

			if( newRange >= 0 && newRange < keyCount[0] )
			{
				int rangePrefix = clz( mortonKeys[nodeId] ^ mortonKeys[newRange] );
				if( rangePrefix > prefixMin )
				{
					stepMax = stepMax << 1;
				}
				else
				{
					break;
				}
			}
			else
			{
				break;
			}
		};

		int stepRange = 0;

		do
		{
			stepMax = (stepMax + 1) >> 1;
			int newRange = nodeId + (stepRange + stepMax)*d;

			if( newRange >= 0 && newRange < keyCount[0] )
			{
				int rangePrefix = clz( mortonKeys[nodeId] ^ mortonKeys[newRange] );
				if( rangePrefix > prefixMin )
					stepRange = stepRange + stepMax;
			}
		}
		while(stepMax > 1);

		int j = nodeId + stepRange*d;

		if(j < nodeId)
		{
			range0 = j;
			range1 = nodeId;
		}
		else
		{
			range0 = nodeId;
			range1 = j;
		}
	}
	else
	{
		range0 = 0;
		range1 = keyCount[0]-1;
	}

	int firstCode = mortonKeys[range0];
	int lastCode = mortonKeys[range1];

	int commonPrefix = clz( firstCode ^ lastCode );

	int split = range0;
	int step = range1 - range0;

	do
	{
		step = (step + 1) >> 1;
		int newSplit = split + step;

		if( newSplit < range1 )
		{
			int splitCode = mortonKeys[newSplit];
			int splitPrefix = clz( firstCode ^ splitCode );
			if( splitPrefix > commonPrefix )
				split = newSplit;
		}
	}
	while(step > 1);

	int childLower = split;
	int childUpper = split+1;

	if(split == range0)
	{
		childLower += leafOffset;
	}

	if(split+1 == range1)
	{
		childUpper += leafOffset;
	}

	// split level
	bvhNodeLinks[ nodeId ].nodeData0 = (clz( mortonKeys[split] ^ mortonKeys[split+1] ) << 1) + 1;

	bvhNodeLinks[ nodeId ].nodeData1 = childLower;
	bvhNodeLinks[ nodeId ].nodeData2 = childUpper;

	//bvhNodeLinks[ nodeId ].nodeData3 = 2 - ( (clz( mortonKeys[split] ^ mortonKeys[split+1] )-2) % 3 );

	// parent index
	bvhNodeLinks[ childLower ].nodeData3 = nodeId;
	bvhNodeLinks[ childUpper ].nodeData3 = nodeId;
}

__kernel
void buildBVHAABBsKarras(__global int* restrict nodeCounters, __global const int* restrict keyCount, __global CLAABB* restrict bvhNodeAABBs, __global CLBVHNode* restrict bvhNodeLinks, const int leafOffset)
{
	int wiIdG = get_global_id(0);

	if(wiIdG >= keyCount[0])
		return;

	int parent = bvhNodeLinks[leafOffset + wiIdG].nodeData0;

	do
	{
		uint visitedFlag = atomic_inc(nodeCounters+parent);

		if(visitedFlag == 2)
		{
			int child0 = bvhNodeLinks[parent].nodeData1;
			int child1 = bvhNodeLinks[parent].nodeData2;

			float4 myMin = min( bvhNodeAABBs[child0].min, bvhNodeAABBs[child1].min );
			float4 myMax = max( bvhNodeAABBs[child0].max, bvhNodeAABBs[child1].max );

			atomic_xchg( (__global float*)( &(bvhNodeAABBs[parent].min) )  , myMin.x );
			atomic_xchg( (__global float*)( &(bvhNodeAABBs[parent].min) )+1, myMin.y );
			atomic_xchg( (__global float*)( &(bvhNodeAABBs[parent].min) )+2, myMin.z );
			atomic_xchg( (__global float*)( &(bvhNodeAABBs[parent].min) )+3, myMin.w );

			atomic_xchg( (__global float*)( &(bvhNodeAABBs[parent].max) )  , myMax.x );
			atomic_xchg( (__global float*)( &(bvhNodeAABBs[parent].max) )+1, myMax.y );
			atomic_xchg( (__global float*)( &(bvhNodeAABBs[parent].max) )+2, myMax.z );
			atomic_xchg( (__global float*)( &(bvhNodeAABBs[parent].max) )+3, myMax.w );
		}
		else
		{
			break;
		}

		parent = bvhNodeLinks[parent].nodeData0;
	}
	while( parent != -1 );
}

__kernel
void buildBVHAABBsCollapse(const int currLevel, __global const int* restrict keyCount, __global CLAABB* restrict bvhNodeAABBs, __global CLBVHNode* restrict bvhNodeLinks)
{
	int wiIdG = get_global_id(0);

	if(wiIdG >= keyCount[0]-1)
		return;

	if( (bvhNodeLinks[wiIdG].nodeData0 & 1) && (bvhNodeLinks[wiIdG].nodeData0 >> 1) == currLevel )
	{
		int child0 = bvhNodeLinks[wiIdG].nodeData1;
		int child1 = bvhNodeLinks[wiIdG].nodeData2;

		bvhNodeLinks[wiIdG].nodeData0 = 0;
		bvhNodeLinks[child0].nodeData0 = child1 << 1;
		bvhNodeLinks[child1].nodeData0 = child0 << 1;

		bvhNodeAABBs[wiIdG].min = min( bvhNodeAABBs[child0].min, bvhNodeAABBs[child1].min );
		bvhNodeAABBs[wiIdG].max = max( bvhNodeAABBs[child0].max, bvhNodeAABBs[child1].max );
	}
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
