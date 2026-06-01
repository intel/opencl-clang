
inline int Float4Equal(float4 a, float4 b)
{
	return ( length(a-b) < 0.0001f ) ? 1 : 0;
}

float4 MulMat4Vec4(const float16* mat, const float4* vec)
{
	float4 ret;

	ret.x = dot(*vec, (*mat).s048C);
	ret.y = dot(*vec, (*mat).s159D);
	ret.z = dot(*vec, (*mat).s26AE);
	ret.w = dot(*vec, (*mat).s37BF);

	return ret;
}

__kernel
void transform(const int vertexOffset,
			   __global const int4* restrict bone_indices, __global const float4* restrict bone_weights, __global const float16* restrict bone_matrices,
               __global const float4* restrict baseVertices, __global const float4* restrict baseNormals, __global const float4* restrict baseTangents,
			   __global float4* restrict transformedVertices, __global float4* restrict transformedNormals, __global float4* restrict transformedTangents)
{
	const uint currIndex = get_global_id(0);

	const float16 m0 = bone_weights[currIndex].s0 * bone_matrices[ bone_indices[currIndex].s0 ];
	const float16 m1 = bone_weights[currIndex].s1 * bone_matrices[ bone_indices[currIndex].s1 ];
	const float16 m2 = bone_weights[currIndex].s2 * bone_matrices[ bone_indices[currIndex].s2 ];
	const float16 m3 = bone_weights[currIndex].s3 * bone_matrices[ bone_indices[currIndex].s3 ];

	const float16 m = m0 + m1 + m2 + m3;

	float4 vertex = baseVertices[currIndex];
	vertex.w = 1.0f;

	float4 normal = baseNormals[currIndex];
	normal.w = 0.0f;

	float4 tangent = baseTangents[currIndex];
	tangent.w = 0.0f;

	transformedVertices[vertexOffset + currIndex] = MulMat4Vec4(&m, &vertex);
	transformedNormals[vertexOffset + currIndex] = MulMat4Vec4(&m, &normal);
	transformedTangents[vertexOffset + currIndex] = MulMat4Vec4(&m, &tangent);
}

__kernel
void ccFaceRule(const int vertexOffset, const int wgsPad, __global const int* restrict fOffset, __global const int* restrict fValence, __global const int* restrict fIndices,
				__global const float4* restrict vertices, __global float4* restrict newVertices,
				__global const float2* restrict texCoords, __global float2* restrict newTexCoords,
				__global const float4* restrict normals, __global float4* restrict newNormals,
				__global const float4* restrict tangents, __global float4* restrict newTangents)
{
	const uint currIndex = get_global_id(0);

	if (currIndex >= wgsPad)
		return;

	int currOffset = fOffset[currIndex];
	int currValence = fValence[currIndex];

	float4 tmpV = vertices[vertexOffset + fIndices[currOffset]];
	float2 tmpTC = texCoords[vertexOffset + fIndices[currOffset]];
	float4 tmpN = normals[vertexOffset + fIndices[currOffset]];
	float4 tmpT = tangents[vertexOffset + fIndices[currOffset]];

	for (int j=1; j<currValence; j++)
	{
		tmpV+=vertices[vertexOffset + fIndices[currOffset + j]];
		tmpTC+=texCoords[vertexOffset + fIndices[currOffset + j]];
		tmpN+=normals[vertexOffset + fIndices[currOffset + j]];
		tmpT+=tangents[vertexOffset + fIndices[currOffset + j]];
	}
	newVertices[vertexOffset + currIndex] = tmpV/currValence;
	newTexCoords[vertexOffset + currIndex] = tmpTC/currValence;
	newNormals[vertexOffset + currIndex] = tmpN/currValence;
	newTangents[vertexOffset + currIndex] = tmpT/currValence;
}

__kernel
void ccEdgeRule(const int vertexOffset, const int wgsPad, const int faceNum, __global const int2* restrict eVertices, __global const int2* restrict eFaces, __global const float* restrict eSharpness,
				__global const float4* restrict vertices, __global float4* restrict newVertices,
				__global const float2* restrict texCoords, __global float2* restrict newTexCoords,
				__global const float4* restrict normals, __global float4* restrict newNormals,
				__global const float4* restrict tangents, __global float4* restrict newTangents)
{
	const uint currIndex = get_global_id(0);

	if (currIndex >= wgsPad)
		return;

	int2 currVertex = eVertices[currIndex];
	int2 currFace = eFaces[currIndex];

	float4 tmpV = vertices[vertexOffset + currVertex.x];
	float4 tmpN = normals[vertexOffset + currVertex.x];
	float4 tmpT = tangents[vertexOffset + currVertex.x];
	float2 tmpTC = texCoords[vertexOffset + currVertex.x];

	tmpV += vertices[vertexOffset + currVertex.y];
	tmpV += newVertices[vertexOffset + currFace.x];
	tmpV += newVertices[vertexOffset + currFace.y];
	newVertices[vertexOffset + faceNum + currIndex] = tmpV / 4.0f;

	tmpN += normals[vertexOffset + currVertex.y];
	tmpN += newNormals[vertexOffset + currFace.x];
	tmpN += newNormals[vertexOffset + currFace.y];
	newNormals[vertexOffset + faceNum + currIndex] = tmpN / 4.0f;

	tmpT += tangents[vertexOffset + currVertex.y];
	tmpT += newTangents[vertexOffset + currFace.x];
	tmpT += newTangents[vertexOffset + currFace.y];
	newTangents[vertexOffset + faceNum + currIndex] = tmpT / 4.0f;

	newTexCoords[vertexOffset + faceNum + currIndex] = (texCoords[vertexOffset + currVertex.x] + texCoords[vertexOffset + currVertex.y])/2.0f;
}

__kernel
void ccVertexRule(const int vertexOffset, const int wgsPad, const int offset, __global const int* restrict vOffset, __global const int* restrict vValence, __global const int2* restrict vEdges,
				  __global const int* restrict vindices, __global const int* restrict vEdgeSharpnessNum, __global const int2* restrict eVertices,
				  __global const float4* restrict vertices, __global float4* restrict newVertices,
				  __global const float2* restrict texCoords, __global float2* restrict newTexCoords,
				  __global const float4* restrict normals, __global float4* restrict newNormals,
				  __global const float4* restrict tangents, __global float4* restrict newTangents)
{
	const uint currIndex = get_global_id(0);

	if (currIndex >= wgsPad)
		return;

	int currOffset = vOffset[currIndex];
	int currValence = vValence[currIndex];

	float4 tmpV = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	float4 tmpV1 = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	float4 tmpN = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
    float4 tmpN1 = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	float4 tmpT = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
    float4 tmpT1 = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	float2 tmpTC = (float2)(0.0f, 0.0f);
    float2 tmpTC1 = (float2)(0.0f, 0.0f);

	//faces
	for (int j = 0; j<currValence; j++)
	{
		tmpV += newVertices[vertexOffset + vindices[currOffset + currValence + j]];
		tmpN += newNormals[vertexOffset + vindices[currOffset + currValence + j]];
		tmpT += newTangents[vertexOffset + vindices[currOffset + currValence + j]];
		tmpTC += newTexCoords[vertexOffset + vindices[currOffset + currValence + j]];
	}
	tmpV /= (currValence * currValence);
	tmpN /= (currValence * currValence);
	tmpT /= (currValence * currValence);
	tmpTC /= (currValence * currValence);

	//middle of edges
	for (int j = 0; j<currValence; j++)
	{
		tmpV1 += vertices[vertexOffset + vindices[currOffset + j]];
		tmpN1 += normals[vertexOffset + vindices[currOffset + j]];
		tmpT1 += tangents[vertexOffset + vindices[currOffset + j]];
		tmpTC1 += texCoords[vertexOffset + vindices[currOffset + j]];
	}
	tmpV1 /= (currValence * currValence);
	tmpN1 /= (currValence * currValence);
	tmpT1 /= (currValence * currValence);
	tmpTC1 /= (currValence * currValence);

	float tmpV2 = ((currValence - 2.0f) / currValence);
	float tmpN2 = ((currValence - 2.0f) / currValence);
	float tmpT2 = ((currValence - 2.0f) / currValence);
	float tmpTC2 = ((currValence - 2.0f) / currValence);

	newVertices[vertexOffset + offset + currIndex] = tmpV + tmpV1 + tmpV2*vertices[vertexOffset + currIndex];
	newNormals[vertexOffset + offset + currIndex] = tmpN + tmpN1 + tmpN2*normals[vertexOffset + currIndex];
	newTangents[vertexOffset + offset + currIndex] = tmpT + tmpT1 + tmpT2*tangents[vertexOffset + currIndex];
	newTexCoords[vertexOffset + offset + currIndex] = texCoords[vertexOffset + currIndex];
}

__kernel
void faceTableUpdate(const int faceNum, const int edgeNum,
					 __global const int* restrict fOffsetIn, __global const int* restrict fValenceIn, __global const int* restrict fIndicesIn, __global const int* restrict fEdgesIn,
					 __global int* restrict fOffsetOut, __global int* restrict fValenceOut, __global int* restrict fIndicesOut, __global int* restrict fEdgesOut,
					 __global int* restrict vOffsetOut, __global int* restrict vValenceOut, __global int2* restrict vEdgesOut, __global int* restrict vindicesOut, __global int* restrict vEdgeSharpnessNumOut, const int vertexOffsetHost)
{
	const uint currIndex = get_global_id(0);

	if (currIndex >= faceNum)
		return;

	int currValence = fValenceIn[currIndex];
	int currOffset = fOffsetIn[currIndex];

	for (int j = 0; j < currValence; j++)
	{
		int indexOffset = 4 * (currOffset + j);
		fValenceOut[currOffset + j] = 4;
		fOffsetOut[currOffset + j] = indexOffset;

		fIndicesOut[indexOffset + 0] = currIndex;
		fIndicesOut[indexOffset + 1] = (faceNum + fEdgesIn[currOffset + j]);
		fIndicesOut[indexOffset + 2] = (faceNum + edgeNum + fIndicesIn[currOffset + j]);

		if (j>0)
			fIndicesOut[indexOffset + 3] = (faceNum + fEdgesIn[currOffset + j - 1]);
		else
			fIndicesOut[indexOffset + 3] = (faceNum + fEdgesIn[currOffset + currValence - 1]);

		fEdgesOut[indexOffset + 0] = 0;
		fEdgesOut[indexOffset + 1] = 0;
		fEdgesOut[indexOffset + 2] = 0;
		fEdgesOut[indexOffset + 3] = 0;

	}

	vOffsetOut[currIndex] = currOffset * 2;
	vValenceOut[currIndex] = currValence;
	vEdgesOut[currIndex] = (int2)(-1, -1);
	vEdgeSharpnessNumOut[currIndex] = 0;

	for (int j = 0; j < currValence; j++)
	{
		vindicesOut[currOffset*2 + j] = faceNum + fEdgesIn[currOffset + j];
		vindicesOut[currOffset*2 + j + currValence] = currOffset + j;
	}
}

inline int edgeListOffset(int4 fIndices, int2 edgeVertex)
{
	if( ((fIndices.x == edgeVertex.y) && (fIndices.y == edgeVertex.x)) || ((fIndices.x == edgeVertex.x) && (fIndices.y == edgeVertex.y)) )
		return 0;
	if( ((fIndices.y == edgeVertex.y) && (fIndices.z == edgeVertex.x)) || ((fIndices.y == edgeVertex.x) && (fIndices.z == edgeVertex.y)) )
		return 1;
	if( ((fIndices.z == edgeVertex.y) && (fIndices.w == edgeVertex.x)) || ((fIndices.z == edgeVertex.x) && (fIndices.w == edgeVertex.y)) )
		return 2;
	if( ((fIndices.w == edgeVertex.y) && (fIndices.x == edgeVertex.x)) || ((fIndices.w == edgeVertex.x) && (fIndices.x == edgeVertex.y)) )
		return 3;

	return -1;
}

__kernel
void edgeTableUpdate(const int faceNum, const int edgeNum,
					 __global const int* restrict fOffsetIn, __global const int* restrict fValenceIn, __global const int4* fIndicesOut, __global int* restrict fEdgesOut,
					 __global const int2* restrict eVerticesIn, __global const int2* restrict eFacesIn, __global const float* restrict eSharpnessIn,
					 __global int8* restrict eVerticesOut, __global int8* restrict eFacesOut, __global float4* restrict eSharpnessOut,
					 __global int* restrict vOffsetOut, __global int* restrict vValenceOut, __global int2* restrict vEdgesOut, __global int8* restrict vindicesOut, __global int* restrict vEdgeSharpnessNumOut,
					 __global float4* restrict newVertices, const int vertexOffsetHost)
{
	const uint currIndex = get_global_id(0);

	if (currIndex >= edgeNum)
		return;

	int2 currEdgeVertex = eVerticesIn[currIndex];
	int2 currEdgeFaces = eFacesIn[currIndex];
	float currEdgeSharpness = eSharpnessIn[currIndex];

	int faceOffset0 = 4 * fOffsetIn[currEdgeFaces.x];
	int faceOffset1 = 4 * fOffsetIn[currEdgeFaces.y];
	int vertexOffset = faceNum + edgeNum;

	int4 F = (int4)(-1);
	int4 F_ = (int4)(-1);

	for (int j = 0; j < fValenceIn[currEdgeFaces.x]; j++)
	{
		if (Float4Equal(newVertices[vertexOffsetHost + fIndicesOut[faceOffset0/4 + j].z], newVertices[vertexOffsetHost + vertexOffset + currEdgeVertex.x]))
		{
			F.x = faceOffset0 / 4 + j;
			F_.x = faceOffset0 + 4 * j;
		}
		if (Float4Equal(newVertices[vertexOffsetHost + fIndicesOut[faceOffset0/4 + j].z], newVertices[vertexOffsetHost + vertexOffset + currEdgeVertex.y]))
		{
			F.y = faceOffset0 / 4 + j;
			F_.y = faceOffset0 + 4 * j;
		}
	}

	for (int j = 0; j < fValenceIn[currEdgeFaces.y]; j++)
	{
		if (Float4Equal(newVertices[vertexOffsetHost + fIndicesOut[faceOffset1/4 + j].z], newVertices[vertexOffsetHost + vertexOffset + currEdgeVertex.x]))
		{
			F.z = faceOffset1 / 4 + j;
			F_.z = faceOffset1 + 4 * j;
		}
		if (Float4Equal(newVertices[vertexOffsetHost + fIndicesOut[faceOffset1/4 + j].z],newVertices[vertexOffsetHost + vertexOffset + currEdgeVertex.y]))
		{
			F.w = faceOffset1 / 4 + j;
			F_.w = faceOffset1 + 4 * j;
		}
	}

	int currEdgeIndex = faceNum + currIndex;

	eVerticesOut[currIndex] = (int8)(currEdgeIndex, vertexOffset + currEdgeVertex.x, currEdgeIndex, vertexOffset + currEdgeVertex.y, currEdgeIndex, currEdgeFaces.x, currEdgeIndex, currEdgeFaces.y);
	eFacesOut[currIndex] = (int8)(F.x, F.z, F.y, F.w, F.x, F.y, F.z, F.w);
	eSharpnessOut[currIndex] = (float4)(currEdgeSharpness, currEdgeSharpness, 0.0f, 0.0f);

	int tmpOffset = edgeListOffset(fIndicesOut[F_.x/4], (int2)(currEdgeIndex, vertexOffset + currEdgeVertex.x));
	if (tmpOffset != -1)
		fEdgesOut[F_.x + tmpOffset] = 4 * currIndex + 0;

	tmpOffset = edgeListOffset(fIndicesOut[F_.z/4], (int2)(currEdgeIndex, vertexOffset + currEdgeVertex.x));
	if (tmpOffset != -1)
		fEdgesOut[F_.z + tmpOffset] = 4 * currIndex + 0;

	tmpOffset = edgeListOffset(fIndicesOut[F_.y/4], (int2)(currEdgeIndex, vertexOffset + currEdgeVertex.y));
	if (tmpOffset != -1)
		fEdgesOut[F_.y + tmpOffset] = 4 * currIndex + 1;

	tmpOffset = edgeListOffset(fIndicesOut[F_.w/4], (int2)(currEdgeIndex, vertexOffset + currEdgeVertex.y));
	if (tmpOffset != -1)
		fEdgesOut[F_.w + tmpOffset] = 4 * currIndex + 1;

	tmpOffset = edgeListOffset(fIndicesOut[F_.x/4], (int2)(currEdgeIndex, currEdgeFaces.x));
	if (tmpOffset != -1)
		fEdgesOut[F_.x + tmpOffset] = 4 * currIndex + 2;

	tmpOffset = edgeListOffset(fIndicesOut[F_.y/4], (int2)(currEdgeIndex, currEdgeFaces.x));
	if (tmpOffset != -1)
		fEdgesOut[F_.y + tmpOffset] = 4 * currIndex + 2;

	tmpOffset = edgeListOffset(fIndicesOut[F_.z/4], (int2)(currEdgeIndex, currEdgeFaces.y));
	if (tmpOffset != -1)
		fEdgesOut[F_.z + tmpOffset] = 4 * currIndex + 3;

	tmpOffset = edgeListOffset(fIndicesOut[F_.w/4], (int2)(currEdgeIndex, currEdgeFaces.y));
	if (tmpOffset != -1)
		fEdgesOut[F_.w + tmpOffset] = 4 * currIndex + 3;

	int vOffset = vOffsetOut[faceNum-1] + 2 * vValenceOut[faceNum-1];

	int2 vEdge;
	if (currEdgeSharpness > 0.0f)
	{
		vEdgeSharpnessNumOut[faceNum + currIndex] = 2;
		vEdge = (int2)(4 * currIndex + 0, 4 * currIndex + 1);
	}
	else
	{
		vEdgeSharpnessNumOut[faceNum + currIndex] = 0;
		vEdge = (int2)(-1, -1);
	}

	vOffsetOut[faceNum + currIndex] = vOffset + currIndex * 8;
	vValenceOut[faceNum + currIndex] = 4;
	vEdgesOut[faceNum + currIndex] = vEdge;
	vindicesOut[vOffset/8 + currIndex] = (int8)(vertexOffset + currEdgeVertex.x, vertexOffset + currEdgeVertex.y, currEdgeFaces.x, currEdgeFaces.y, F.x, F.y, F.z, F.w);
}

__kernel
void vertexTableUpdate(const int vertexNum, const int faceNum, const int edgeNum,
					   __global int* restrict vOffsetIn, __global int* restrict vValenceIn, __global int2* restrict vEdgesIn, __global int* restrict vindicesIn, __global int* restrict vEdgeSharpnessNumIn,
					   __global int* restrict vOffsetOut, __global int* restrict vValenceOut, __global int2* restrict vEdgesOut, __global int* restrict vindicesOut, __global int* restrict vEdgeSharpnessNumOut,
					   __global const int2* restrict eVerticesOut, __global const int2* restrict eFacesOut,
					   __global const int* restrict fOffsetIn, __global const int* restrict fValenceIn, __global const int* restrict fIndicesIn, __global int* restrict fEdgesIn,
					   __global float4* restrict newVertices, const int vertexOffsetHost)
{
	const uint currIndex = get_global_id(0);

	if (currIndex >= vertexNum)
		return;

	int vOffset = vOffsetOut[faceNum+edgeNum-1] + 8;
	int currOffset = vOffsetIn[currIndex];
	int currValence = vValenceIn[currIndex];
	int2 currEdge = vEdgesIn[currIndex];

	vOffsetOut[faceNum + edgeNum + currIndex] = vOffset + currOffset;
	vValenceOut[faceNum + edgeNum + currIndex] = currValence;
	vEdgeSharpnessNumOut[faceNum + edgeNum + currIndex] = vEdgeSharpnessNumIn[currIndex];

	int2 newEdge;
	if (currEdge.x != -1 && currEdge.y != -1)
	{
		if (Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[currEdge.x * 4 + 0].x], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]) || Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[currEdge.x * 4 + 0].y], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]))
			newEdge.x = currEdge.x * 4 + 0;
		else if (Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[currEdge.x * 4 + 1].x], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]) || Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[currEdge.x * 4 + 1].y], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]))
			newEdge.x = currEdge.x * 4 + 1;

		if (Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[currEdge.y * 4 + 0].x], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]) || Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[currEdge.y * 4 + 0].y], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]))
			newEdge.y = currEdge.y * 4 + 0;
		else if (Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[currEdge.y * 4 + 1].x], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]) || Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[currEdge.y * 4 + 1].y], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]))
			newEdge.y = currEdge.y * 4 + 1;
	}
	else
	{
		newEdge.x = -1;
		newEdge.y = -1;
	}

	vEdgesOut[faceNum + edgeNum + currIndex] = newEdge;

	int counter = 0;
	int tmpA, tmpB, tmpAOld, tmpBOld;
	for (int j = 0; j < currValence; j++)
	{
		int faceID = vindicesIn[currOffset + currValence + j];
		int faceOffset = fOffsetIn[faceID];
		int faceValence = fValenceIn[faceID];

		for (int k = 0; k < faceValence; k++)
		{
			int faceVert = fIndicesIn[faceOffset + k];
			if (Float4Equal(newVertices[vertexOffsetHost + faceNum + edgeNum + faceVert], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]))
			{
				tmpA = fEdgesIn[faceOffset + k];
				if (k>0)
					tmpB = fEdgesIn[faceOffset + k - 1];
				else
					tmpB = fEdgesIn[faceOffset + faceValence - 1];

				if (counter == 0)
				{
					tmpAOld = tmpA;
					tmpBOld = tmpB;
					vindicesOut[vOffset + currOffset + 0] = faceNum + tmpA;
					vindicesOut[vOffset + currOffset + 1] = faceNum + tmpB;
					counter+=2;
				}
				else if (counter < currValence)
				{
					vindicesOut[vOffset + currOffset + counter] = Float4Equal(newVertices[vertexOffsetHost + faceNum + tmpAOld], newVertices[vertexOffsetHost + faceNum + tmpA]) || Float4Equal(newVertices[vertexOffsetHost + faceNum + tmpBOld], newVertices[vertexOffsetHost + faceNum + tmpA]) ? faceNum + tmpB : faceNum + tmpA;

					tmpAOld = Float4Equal(newVertices[vertexOffsetHost + faceNum + tmpAOld] , newVertices[vertexOffsetHost + faceNum + tmpA]) ? tmpB : tmpAOld == tmpB ? tmpA : tmpAOld;
					tmpBOld = Float4Equal(newVertices[vertexOffsetHost + faceNum + tmpBOld] , newVertices[vertexOffsetHost + faceNum + tmpA]) ? tmpB : tmpBOld == tmpB ? tmpA : tmpBOld;

					counter++;
				}
			}
		}
	}

	counter = 0;
	for (int j = 0; j < currValence; j++)
	{
		int v = vindicesOut[vOffset + currOffset + j] - faceNum;
		if (Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[4 * v + 0].y], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]))
		{
			tmpA = eFacesOut[4 * v + 0].x;
			tmpB = eFacesOut[4 * v + 0].y;
		}
		if (Float4Equal(newVertices[vertexOffsetHost + eVerticesOut[4 * v + 1].y], newVertices[vertexOffsetHost + faceNum + edgeNum + currIndex]))
		{
			tmpA = eFacesOut[4 * v + 1].x;
			tmpB = eFacesOut[4 * v + 1].y;
		}

		if (counter == 0)
		{
			tmpAOld = vindicesOut[vOffset + currOffset + currValence + 0] = tmpA;
			tmpBOld = vindicesOut[vOffset + currOffset + currValence + 1] = tmpB;
			counter+=2;
		}
		else if (counter < currValence)
		{
			vindicesOut[vOffset + currOffset + currValence + counter] = (tmpAOld == tmpA) || (tmpBOld == tmpA) ? tmpB : tmpA;

			tmpAOld = tmpAOld == tmpA ? tmpB : tmpAOld == tmpB ? tmpA : tmpAOld;
			tmpBOld = tmpBOld == tmpA ? tmpB : tmpBOld == tmpB ? tmpA : tmpBOld;

			counter++;
		}
	}

}

__kernel
void triangleIndicesCreate(const int faceOffset, const int vertexOffset, __global const int4* restrict fIndices, __global int* restrict triIndices)
{
	uint currIndex = get_global_id(0);
	const int4 currFace = fIndices[currIndex];

	currIndex+=faceOffset;

	triIndices[6*currIndex+0] =  vertexOffset + currFace.x;
	triIndices[6*currIndex+1] =  vertexOffset + currFace.y;
	triIndices[6*currIndex+2] =  vertexOffset + currFace.w;

	triIndices[6*currIndex+3] =  vertexOffset + currFace.z;
	triIndices[6*currIndex+4] =  vertexOffset + currFace.y;
	triIndices[6*currIndex+5] =  vertexOffset + currFace.w;
}

__kernel
void normalCompute(__global const float4* restrict vertices, __global const int* restrict fOffset, __global const int* restrict fIndices, __global const int* restrict vValence, __global const int* restrict vOffset, __global const int* restrict vIndices,
				   __global float4* restrict normals)
{
	const uint currIndex = get_global_id(0);
	const int currOffset = vOffset[currIndex];
	const int currValence = vValence[currIndex];

	float4 NTmp = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

	for (int i = 0; i < currValence; i++)
	{
		int faceID = vIndices[currOffset + currValence + i];
		int currFOffset = fOffset[faceID];
		float4 tmpV = vertices[fIndices[currFOffset + 0]];
		NTmp += normalize(cross(tmpV - vertices[fIndices[currFOffset + 1]], tmpV - vertices[fIndices[currFOffset + 2]]));
	}

	NTmp /= currValence;
	NTmp.w = 0.0f;
	normals[currIndex] = dot(normals[currIndex], NTmp) < 0.0f ? -NTmp : NTmp;
}

float textureBilinearLookup(__global const uchar* restrict texture, int2 iTexSize, float2 UV)
{
	UV = UV * convert_float2(iTexSize - 1) - 0.5f;
	float2 UV_f = floor(UV);
	float2 ratio = UV - UV_f;
	float2 opposite = 1.0f - ratio;

	float t00 = UV_f.x + UV_f.y*iTexSize.x;
	float t10 = UV_f.x + 1 + UV_f.y*iTexSize.x;
	float t01 = UV_f.x + (UV_f.y + 1)*iTexSize.x;
	float t11 = UV_f.x + 1 + (UV_f.y + 1)*iTexSize.x;

    return ((texture[(int)(t00)] * opposite.x  + texture[(int)(t10)] * ratio.x) * opposite.y +
		   (texture[(int)(t01)] * opposite.x  + texture[(int)(t11)] * ratio.x) * ratio.y)/255.0f;
}

__kernel
void vertexShift(__global const float2* restrict texCoords, __global const float4* restrict normals, __global const uchar* restrict displacementMap, __global float4* restrict vertices)
{
	const uint currIndex = get_global_id(0);

	const float2 currUV = texCoords[currIndex];
	const float4 currNormal = normals[currIndex];

	float df = textureBilinearLookup(displacementMap, (int2)(2048, 2048), (float2)(currUV.x, currUV.y));

	vertices[currIndex]+= normalize(currNormal) * (df-0.5f) * 0.5f;
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
