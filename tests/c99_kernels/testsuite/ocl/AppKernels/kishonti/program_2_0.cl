// Density grid

//#define dgSize i3(32+2,32+2,32+2)
//#define Magnitude 2.0f

#define dgSize ((int3)(64+2,64+2,64+2))
#define Magnitude 4.0f

#define dgSumSize dgSize.x*dgSize.y*dgSize.z
#define dgSizef ((float3)(dgSize.x-2.0f, dgSize.x-2.0f, dgSize.x-2.0f))


inline uint dgPos(int3 p)
{
	return p.z*dgSize.y*dgSize.x + p.y*dgSize.x + p.x;
}

__kernel void ResetDensityGrid(__global uint *densityGrid) // 3D linear
{
	densityGrid[get_global_id(0)] = 0;
}

__kernel void CalculateDensityGrid(__global uint *densityGrid,
								   __global const float3 *restrict x)
{
	unsigned int i = get_global_id(0);

	const float3 xi = x[i]; // global load

	const float3 cellSize = (SpaceMax-SpaceMin)/dgSizef;
	const int mi = convert_int(Magnitude + 0.5f);
	const float R = cellSize.x*Magnitude;

	const int3 gp = clamp(convert_int3((xi - SpaceMin)/cellSize - 0.5f), (int3)(-1), dgSize - 1);

	const int3 cell_min = max(gp + 1 - mi, (int3)(0));
	const int3 cell_max = min(gp + mi, dgSize - (1+2));
	int3 cell = cell_min;
	for(cell.z = cell_min.z; cell.z <= cell_max.z; ++cell.z)
	{
		for(cell.y = cell_min.y; cell.y <= cell_max.y; ++cell.y)
		{
			for(cell.x = cell_min.x; cell.x <= cell_max.x; ++cell.x)
			{
				const float3 xj = (convert_float3(cell) + 0.5f)*cellSize + SpaceMin; //cellCenter

				const float3 xij = xj - xi;
				const float r2 = dot(xij,xij);
				const float R2_r2 = R*R - r2;

				if(R2_r2 > 0.0f)
				{
					const uint density = convert_uint(R2_r2*R2_r2*R2_r2);

					atomic_add(densityGrid + dgPos(cell + 1), density); // atomic global load and store
				}
			}
		}
	}
}


// Surface generator

__kernel void ClearVertexNum(__global uint *vertexNum)
{
	*vertexNum = 0;
}

inline float3 Normal(const int3 cell,
					  __global const uint *dGrid)
{
	int indices[6];
	int index = dgPos(cell);

	indices[0] = index + 1;
	indices[1] = index - 1;

	indices[2] = index + dgSize.x;
	indices[3] = index - dgSize.x;

	indices[4] = index + dgSize.x * dgSize.y;
	indices[5] = index - dgSize.x * dgSize.y;

	float data[6];
	for(uint i = 0; i < 6; ++i)
		data[i] = (0 <= indices[i] && indices[i] <= dgSumSize) ? (float)dGrid[indices[i]] : 0.0f; //else (indices[i] < 0 || indices[i] > m_size)


	return (float3)(data[1],data[3],data[5]) - (float3)(data[0],data[2],data[4]);
}

__kernel void FillBuffers(	const uint isoLevel,
							//__global const uint *offsets,
							__global uint *vertexNum,
							__global const uint *dGrid,
							__global float3 *vertexArray,
							__global float3 *normalArray,
							__constant int *edgeTable,
							__constant int *triTable,
							__constant int *edge2vertexTable) // illegal? __constant
{
	const int3 cell = (int3)(get_global_id(0), get_global_id(1), get_global_id(2));

	float density[8];

	density[0] = convert_float(dGrid[dgPos(cell+(int3)(0,0,0))]);
	density[1] = convert_float(dGrid[dgPos(cell+(int3)(1,0,0))]);
	density[2] = convert_float(dGrid[dgPos(cell+(int3)(1,1,0))]);
	density[3] = convert_float(dGrid[dgPos(cell+(int3)(0,1,0))]);
	density[4] = convert_float(dGrid[dgPos(cell+(int3)(0,0,1))]);
	density[5] = convert_float(dGrid[dgPos(cell+(int3)(1,0,1))]);
	density[6] = convert_float(dGrid[dgPos(cell+(int3)(1,1,1))]);
	density[7] = convert_float(dGrid[dgPos(cell+(int3)(0,1,1))]);

	uint cubeindex = 0;
	for(uint i = 0; i < 8; ++i)
	{
		if(density[i] > (float)isoLevel)
			cubeindex |= (1<<i);
	}
	if(edgeTable[cubeindex] == 0)
		return; // !

	const float3 cellf = convert_float3(cell);

	float3 cell_vertices[8];
	cell_vertices[0] = cellf + (float3)(0.0f, 0.0f, 0.0f);
	cell_vertices[1] = cellf + (float3)(1.0f, 0.0f, 0.0f);
	cell_vertices[2] = cellf + (float3)(1.0f, 1.0f, 0.0f);
	cell_vertices[3] = cellf + (float3)(0.0f, 1.0f, 0.0f);
	cell_vertices[4] = cellf + (float3)(0.0f, 0.0f, 1.0f);
	cell_vertices[5] = cellf + (float3)(1.0f, 0.0f, 1.0f);
	cell_vertices[6] = cellf + (float3)(1.0f, 1.0f, 1.0f);
	cell_vertices[7] = cellf + (float3)(0.0f, 1.0f, 1.0f);

	float3 cell_normals[8];
	cell_normals[0] = Normal(cell+(int3)(0,0,0), dGrid);
	cell_normals[1] = Normal(cell+(int3)(1,0,0), dGrid);
	cell_normals[2] = Normal(cell+(int3)(1,1,0), dGrid);
	cell_normals[3] = Normal(cell+(int3)(0,1,0), dGrid);
	cell_normals[4] = Normal(cell+(int3)(0,0,1), dGrid);
	cell_normals[5] = Normal(cell+(int3)(1,0,1), dGrid);
	cell_normals[6] = Normal(cell+(int3)(1,1,1), dGrid);
	cell_normals[7] = Normal(cell+(int3)(0,1,1), dGrid);

	float3 vertices[12];
	float3 normals[12];

	for(uint i = 0; i < 12; ++i)
	{
		if(edgeTable[cubeindex] & (1<<i) )
		{
			float f = (convert_float(isoLevel) - density[ edge2vertexTable[i*2 + 0] ]) / (density[ edge2vertexTable[i*2 + 1] ] - density[ edge2vertexTable[i*2 + 0] ]);
			//f = clamp(f, 0.0f, 1.0f);
			vertices[i] = mix(	cell_vertices[ edge2vertexTable[i*2 + 0] ],
								cell_vertices[ edge2vertexTable[i*2 + 1] ],
								(float3)(f));
			normals[i] = normalize(mix(	cell_normals[ edge2vertexTable[i*2 + 0] ],
										cell_normals[ edge2vertexTable[i*2 + 1] ],
										(float3)(f)));

			const float FlatLimit = 0.95f;
			if (normals[i].x > FlatLimit) // to flatter
			{
				normals[i].x = 1.0f;
				normals[i].y = 0.0f;
				normals[i].z = 0.0f;
			}
			if (normals[i].y > FlatLimit) // to flatter
			{
				normals[i].x = 0.0f;
				normals[i].y = 1.0f;
				normals[i].z = 0.0f;
			}
			if (normals[i].z > FlatLimit) // to flatter
			{
				normals[i].x = 0.0f;
				normals[i].y = 0.0f;
				normals[i].z = 1.0f;
			}
		}
	}
	uint vertexCount = 0;
	for(int i = 0; triTable[cubeindex*16 + i] != -1; i += 3) vertexCount += 3;
	uint offset = atomic_add(vertexNum, vertexCount); //global!
	for(int i = 0; triTable[cubeindex*16 + i] != -1; i += 3, offset += 3)
	{
		normalArray[offset+0] = normals[triTable[cubeindex*16 + i  ]];
		normalArray[offset+1] = normals[triTable[cubeindex*16 + i+1]];
		normalArray[offset+2] = normals[triTable[cubeindex*16 + i+2]];

		vertexArray[offset+0] = vertices[triTable[cubeindex*16 + i  ]];
		vertexArray[offset+1] = vertices[triTable[cubeindex*16 + i+1]];
		vertexArray[offset+2] = vertices[triTable[cubeindex*16 + i+2]];
	}
}


// buildOptions=-cl-std=CL1.1 -D SpaceMin=((float3)(0.00000000000000f,0.00000000000000f,0.00000000000000f)) -D SpaceMax=((float3)(159.00000000000000f,159.89999389648437f,159.89999389648437f))
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-std=CL1.1 -D SpaceMin=((float3)(0.00000000000000f,0.00000000000000f,0.00000000000000f)) -D SpaceMax=((float3)(159.00000000000000f,159.89999389648437f,159.89999389648437f))" %cfg_path --cl-device=%cl_device 2>&1
