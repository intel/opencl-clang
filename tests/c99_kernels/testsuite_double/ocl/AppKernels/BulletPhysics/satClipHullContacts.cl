
#pragma OPENCL EXTENSION cl_amd_printf : enable
#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#pragma OPENCL EXTENSION cl_khr_local_int32_extended_atomics : enable
#pragma OPENCL EXTENSION cl_khr_global_int32_extended_atomics : enable

#ifdef cl_ext_atomic_counters_32
#pragma OPENCL EXTENSION cl_ext_atomic_counters_32 : enable
#else
#define counter32_t volatile global int*
#endif

#define GET_GROUP_IDX get_group_id(0)
#define GET_LOCAL_IDX get_local_id(0)
#define GET_GLOBAL_IDX get_global_id(0)
#define GET_GROUP_SIZE get_local_size(0)
#define GET_NUM_GROUPS get_num_groups(0)
#define GROUP_LDS_BARRIER barrier(CLK_LOCAL_MEM_FENCE)
#define GROUP_MEM_FENCE mem_fence(CLK_LOCAL_MEM_FENCE)
#define AtomInc(x) atom_inc(&(x))
#define AtomInc1(x, out) out = atom_inc(&(x))
#define AppendInc(x, out) out = atomic_inc(x)
#define AtomAdd(x, value) atom_add(&(x), value)
#define AtomCmpxhg(x, cmp, value) atom_cmpxchg( &(x), cmp, value )
#define AtomXhg(x, value) atom_xchg ( &(x), value )

#define max2 max
#define min2 min

typedef unsigned int u32;

typedef struct
{
	float4 m_worldPos[4];
	float4 m_worldNormal;	//	w: m_nPoints
//	float m_restituitionCoeff;
//	float m_frictionCoeff;
	u32 m_coeffs;
	u32 m_batchIdx;
//	int m_nPoints;
//	int m_padding0;

	int m_bodyAPtrAndSignBit;//x:m_bodyAPtr, y:m_bodyBPtr
	int m_bodyBPtrAndSignBit;
} Contact4;

#define GET_NPOINTS(x) (x).m_worldNormal.w

typedef struct
{
	float4 m_pos;
	float4 m_quat;
	float4 m_linVel;
	float4 m_angVel;

	u32 m_shapeIdx;
	u32 m_shapeType;

	float m_invMass;
	float m_restituitionCoeff;
	float m_frictionCoeff;
} BodyData;


typedef struct
{
	float4		m_localCenter;
	float4		m_extents;
	float4		mC;
	float4		mE;
	float			m_radius;

	int	m_faceOffset;
	int m_numFaces;

	int	m_numVertices;
	int m_vertexOffset;

	int	m_uniqueEdgesOffset;
	int	m_numUniqueEdges;

} ConvexPolyhedronCL;

typedef struct
{
	float4 m_plane;
	int m_indexOffset;
	int m_numIndices;
} btGpuFace;

#define SELECT_UINT4( b, a, condition ) select( b,a,condition )

#define make_float4 (float4)
#define make_float2 (float2)
#define make_uint4 (uint4)
#define make_int4 (int4)
#define make_uint2 (uint2)
#define make_int2 (int2)


__inline
float fastDiv(float numerator, float denominator)
{
	return native_divide(numerator, denominator);
//	return numerator/denominator;
}

__inline
float4 fastDiv4(float4 numerator, float4 denominator)
{
	return native_divide(numerator, denominator);
}


__inline
float4 cross3(float4 a, float4 b)
{
	return cross(a,b);
}

__inline
float dot3F4(float4 a, float4 b)
{
	float4 a1 = make_float4(a.xyz,0.f);
	float4 b1 = make_float4(b.xyz,0.f);
	return dot(a1, b1);
}

__inline
float4 fastNormalize4(float4 v)
{
	return fast_normalize(v);
}


///////////////////////////////////////
//	Quaternion
///////////////////////////////////////

typedef float4 Quaternion;

__inline
Quaternion qtMul(Quaternion a, Quaternion b);

__inline
Quaternion qtNormalize(Quaternion in);

__inline
float4 qtRotate(Quaternion q, float4 vec);

__inline
Quaternion qtInvert(Quaternion q);




__inline
Quaternion qtMul(Quaternion a, Quaternion b)
{
	Quaternion ans;
	ans = cross3( a, b );
	ans += a.w*b+b.w*a;
//	ans.w = a.w*b.w - (a.x*b.x+a.y*b.y+a.z*b.z);
	ans.w = a.w*b.w - dot3F4(a, b);
	return ans;
}

__inline
Quaternion qtNormalize(Quaternion in)
{
	return fastNormalize4(in);
//	in /= length( in );
//	return in;
}
__inline
float4 qtRotate(Quaternion q, float4 vec)
{
	Quaternion qInv = qtInvert( q );
	float4 vcpy = vec;
	vcpy.w = 0.f;
	float4 out = qtMul(qtMul(q,vcpy),qInv);
	return out;
}

__inline
Quaternion qtInvert(Quaternion q)
{
	return (Quaternion)(-q.xyz, q.w);
}

__inline
float4 qtInvRotate(const Quaternion q, float4 vec)
{
	return qtRotate( qtInvert( q ), vec );
}

__inline
float4 transform(const float4* p, const float4* translation, const Quaternion* orientation)
{
	return qtRotate( *orientation, *p ) + (*translation);
}



__inline
float4 normalize3(const float4 a)
{
	float4 n = make_float4(a.x, a.y, a.z, 0.f);
	return fastNormalize4( n );
}


__inline float4 lerp3(const float4 a,const float4 b, float  t)
{
	return make_float4(	a.x + (b.x - a.x) * t,
						a.y + (b.y - a.y) * t,
						a.z + (b.z - a.z) * t,
						0.f);
}





// Clips a face to the back of a plane, return the number of vertices out, stored in ppVtxOut
int clipFace(const float4* pVtxIn, int numVertsIn, float4 planeNormalWS,float planeEqWS, float4* ppVtxOut)
{

	int ve;
	float ds, de;
	int numVertsOut = 0;
//double-check next test
	if (numVertsIn < 2)
		return 0;

	float4 firstVertex=pVtxIn[numVertsIn-1];
	float4 endVertex = pVtxIn[0];

	ds = dot3F4(planeNormalWS,firstVertex)+planeEqWS;

	for (ve = 0; ve < numVertsIn; ve++)
	{
		endVertex=pVtxIn[ve];

		de = dot3F4(planeNormalWS,endVertex)+planeEqWS;

		if (ds<0)
		{
			if (de<0)
			{
				// Start < 0, end < 0, so output endVertex
				ppVtxOut[numVertsOut++] = endVertex;
			}
			else
			{
				// Start < 0, end >= 0, so output intersection
				ppVtxOut[numVertsOut++] = lerp3(firstVertex, endVertex,(ds * 1.f/(ds - de)) );
			}
		}
		else
		{
			if (de<0)
			{
				// Start >= 0, end < 0 so output intersection and end
				ppVtxOut[numVertsOut++] = lerp3(firstVertex, endVertex,(ds * 1.f/(ds - de)) );
				ppVtxOut[numVertsOut++] = endVertex;
			}
		}
		firstVertex = endVertex;
		ds = de;
	}
	return numVertsOut;
}


int clipFaceAgainstHull(const float4 separatingNormal, __global const ConvexPolyhedronCL* hullA,
	const float4 posA, const Quaternion ornA, float4* worldVertsB1, int numWorldVertsB1,
	float4* worldVertsB2, int capacityWorldVertsB2,
	const float minDist, float maxDist,
	__global const float4* vertices,
	__global const btGpuFace* faces,
	__global const int* indices,
	float4* contactsOut,
	int contactCapacity)
{
	int numContactsOut = 0;

	float4* pVtxIn = worldVertsB1;
	float4* pVtxOut = worldVertsB2;

	int numVertsIn = numWorldVertsB1;
	int numVertsOut = 0;

	int closestFaceA=-1;
	{
		float dmin = FLT_MAX;
		for(int face=0;face<hullA->m_numFaces;face++)
		{
			const float4 Normal = make_float4(
				faces[hullA->m_faceOffset+face].m_plane.x,
				faces[hullA->m_faceOffset+face].m_plane.y,
				faces[hullA->m_faceOffset+face].m_plane.z,0.f);
			const float4 faceANormalWS = qtRotate(ornA,Normal);

			float d = dot3F4(faceANormalWS,separatingNormal);
			if (d < dmin)
			{
				dmin = d;
				closestFaceA = face;
			}
		}
	}
	if (closestFaceA<0)
		return numContactsOut;

	btGpuFace polyA = faces[hullA->m_faceOffset+closestFaceA];

	// clip polygon to back of planes of all faces of hull A that are adjacent to witness face
	int numVerticesA = polyA.m_numIndices;
	for(int e0=0;e0<numVerticesA;e0++)
	{
		const float4 a = vertices[hullA->m_vertexOffset+indices[polyA.m_indexOffset+e0]];
		const float4 b = vertices[hullA->m_vertexOffset+indices[polyA.m_indexOffset+((e0+1)%numVerticesA)]];
		const float4 edge0 = a - b;
		const float4 WorldEdge0 = qtRotate(ornA,edge0);
		float4 planeNormalA = make_float4(polyA.m_plane.x,polyA.m_plane.y,polyA.m_plane.z,0.f);
		float4 worldPlaneAnormal1 = qtRotate(ornA,planeNormalA);

		float4 planeNormalWS1 = -cross3(WorldEdge0,worldPlaneAnormal1);
		float4 worldA1 = transform(&a,&posA,&ornA);
		float planeEqWS1 = -dot3F4(worldA1,planeNormalWS1);

		float4 planeNormalWS = planeNormalWS1;
		float planeEqWS=planeEqWS1;

		//clip face
		//clipFace(*pVtxIn, *pVtxOut,planeNormalWS,planeEqWS);
		numVertsOut = clipFace(pVtxIn, numVertsIn, planeNormalWS,planeEqWS, pVtxOut);

		//btSwap(pVtxIn,pVtxOut);
		float4* tmp = pVtxOut;
		pVtxOut = pVtxIn;
		pVtxIn = tmp;
		numVertsIn = numVertsOut;
		numVertsOut = 0;
	}


	// only keep points that are behind the witness face
	{
		float4 localPlaneNormal  = make_float4(polyA.m_plane.x,polyA.m_plane.y,polyA.m_plane.z,0.f);
		float localPlaneEq = polyA.m_plane.w;
		float4 planeNormalWS = qtRotate(ornA,localPlaneNormal);
		float planeEqWS=localPlaneEq-dot3F4(planeNormalWS,posA);
		for (int i=0;i<numVertsIn;i++)
		{
			float depth = dot3F4(planeNormalWS,pVtxIn[i])+planeEqWS;
			if (depth <=minDist)
			{
				depth = minDist;
			}

			if (depth <=maxDist)
			{
				float4 pointInWorld = pVtxIn[i];
				//resultOut.addContactPoint(separatingNormal,point,depth);
				contactsOut[numContactsOut++] = make_float4(pointInWorld.x,pointInWorld.y,pointInWorld.z,depth);
			}
		}
	}

	return numContactsOut;
}




int	clipHullAgainstHull(const float4 separatingNormal,
	__global const ConvexPolyhedronCL* hullA, __global const ConvexPolyhedronCL* hullB,
	const float4 posA, const Quaternion ornA,const float4 posB, const Quaternion ornB,
	float4* worldVertsB1, float4* worldVertsB2, int capacityWorldVerts,
	const float minDist, float maxDist,
	__global const float4* vertices,
	__global const btGpuFace* faces,
	__global const int* indices,
	float4*	localContactsOut,
	int localContactCapacity)
{
	int numContactsOut = 0;
	int numWorldVertsB1= 0;


	int closestFaceB=-1;
	float dmax = -FLT_MAX;

	{
		for(int face=0;face<hullB->m_numFaces;face++)
		{
			const float4 Normal = make_float4(faces[hullB->m_faceOffset+face].m_plane.x,
				faces[hullB->m_faceOffset+face].m_plane.y, faces[hullB->m_faceOffset+face].m_plane.z,0.f);
			const float4 WorldNormal = qtRotate(ornB, Normal);
			float d = dot3F4(WorldNormal,separatingNormal);
			if (d > dmax)
			{
				dmax = d;
				closestFaceB = face;
			}
		}
	}

	{
		const btGpuFace polyB = faces[hullB->m_faceOffset+closestFaceB];
		const int numVertices = polyB.m_numIndices;
		for(int e0=0;e0<numVertices;e0++)
		{
			const float4 b = vertices[hullB->m_vertexOffset+indices[polyB.m_indexOffset+e0]];
			worldVertsB1[numWorldVertsB1++] = transform(&b,&posB,&ornB);
		}
	}

	if (closestFaceB>=0)
	{
		numContactsOut = clipFaceAgainstHull(separatingNormal, hullA,
				posA,ornA,
				worldVertsB1,numWorldVertsB1,worldVertsB2,capacityWorldVerts, minDist, maxDist,vertices,
				faces,
				indices,localContactsOut,localContactCapacity);
	}

	return numContactsOut;
}



#define PARALLEL_SUM(v, n) for(int j=1; j<n; j++) v[0] += v[j];
#define PARALLEL_DO(execution, n) for(int ie=0; ie<n; ie++){execution;}
#define REDUCE_MAX(v, n) {int i=0;\
	for(int offset=0; offset<n; offset++) v[i] = (v[i].y > v[i+offset].y)? v[i]: v[i+offset]; }
#define REDUCE_MIN(v, n) {int i=0;\
	for(int offset=0; offset<n; offset++) v[i] = (v[i].y < v[i+offset].y)? v[i]: v[i+offset]; }

int extractManifoldSequential(const float4* p, int nPoints, float4 nearNormal, int* contactIdx)
{
	if( nPoints == 0 ) return 0;

	nPoints = min2( nPoints, 64 );

	float4 center = make_float4(0.f);
	{
		float4 v[64];
		for (int i=0;i<nPoints;i++)
			v[i] = p[i];
		//memcpy( v, p, nPoints*sizeof(float4) );
		PARALLEL_SUM( v, nPoints );
		center = v[0]/(float)nPoints;
	}



	{	//	sample 4 directions
		if( nPoints < 4 )
		{
			for(int i=0; i<nPoints; i++)
				contactIdx[i] = i;
			return nPoints;
		}

		float4 aVector = p[0] - center;
		float4 u = cross3( nearNormal, aVector );
		float4 v = cross3( nearNormal, u );
		u = normalize3( u );
		v = normalize3( v );

		int idx[4];

		float2 max00 = make_float2(0,FLT_MAX);
		{
			//	idx, distance
			{
				{
					int4 a[64];
					for(int ie = 0; ie<nPoints; ie++ )
					{


						float f;
						float4 r = p[ie]-center;
						f = dot3F4( u, r );
						a[ie].x = ((*(u32*)&f) & 0xffffff00) | (0xff & ie);

						f = dot3F4( -u, r );
						a[ie].y = ((*(u32*)&f) & 0xffffff00) | (0xff & ie);

						f = dot3F4( v, r );
						a[ie].z = ((*(u32*)&f) & 0xffffff00) | (0xff & ie);

						f = dot3F4( -v, r );
						a[ie].w = ((*(u32*)&f) & 0xffffff00) | (0xff & ie);
					}

					for(int ie=0; ie<nPoints; ie++)
					{
						a[0].x = (a[0].x > a[ie].x )? a[0].x: a[ie].x;
						a[0].y = (a[0].y > a[ie].y )? a[0].y: a[ie].y;
						a[0].z = (a[0].z > a[ie].z )? a[0].z: a[ie].z;
						a[0].w = (a[0].w > a[ie].w )? a[0].w: a[ie].w;
					}

					idx[0] = (int)a[0].x & 0xff;
					idx[1] = (int)a[0].y & 0xff;
					idx[2] = (int)a[0].z & 0xff;
					idx[3] = (int)a[0].w & 0xff;
				}
			}

			{
				float2 h[64];
				PARALLEL_DO( h[ie] = make_float2((float)ie, p[ie].w), nPoints );
				REDUCE_MIN( h, nPoints );
				max00 = h[0];
			}
		}

		contactIdx[0] = idx[0];
		contactIdx[1] = idx[1];
		contactIdx[2] = idx[2];
		contactIdx[3] = idx[3];

//		if( max00.y < 0.0f )
//			contactIdx[0] = (int)max00.x;

		//does this sort happen on GPU too?
		//std::sort( contactIdx, contactIdx+4 );

		return 4;
	}
}



__kernel void   extractManifoldAndAddContactKernel(__global const int2* pairs,
																	__global const BodyData* rigidBodies,
																	__global const float4* closestPointsWorld,
																	__global const float4* separatingNormalsWorld,
																	__global const int* contactCounts,
																	__global const int* contactOffsets,
																	__global Contact4* restrict contactsOut,
																	counter32_t nContactsOut,
																	int numPairs,
																	int pairIndex
																	)
{
	int idx = get_global_id(0);

	if (idx<numPairs)
	{
		float4 normal = separatingNormalsWorld[idx];
		int nPoints = contactCounts[idx];
		__global const float4* pointsIn = &closestPointsWorld[contactOffsets[idx]];
		float4 localPoints[64];
		for (int i=0;i<nPoints;i++)
		{
			localPoints[i] = pointsIn[i];
		}
		int contactIdx[4] = {-1,-1,-1,-1};

		int nContacts = extractManifoldSequential(localPoints, nPoints, normal, contactIdx);

		int dstIdx;
		AppendInc( nContactsOut, dstIdx );
		//if ((dstIdx+nContacts) < capacity)
		{
			__global Contact4* c = contactsOut + dstIdx;
			c->m_worldNormal = normal;
			c->m_coeffs = (u32)(0.f*0xffff) | ((u32)(0.7f*0xffff)<<16);
			c->m_batchIdx = idx;
			int bodyA = pairs[pairIndex].x;
			int bodyB = pairs[pairIndex].y;
			c->m_bodyAPtrAndSignBit = rigidBodies[bodyA].m_invMass==0 ? -bodyA:bodyA;
			c->m_bodyBPtrAndSignBit = rigidBodies[bodyB].m_invMass==0 ? -bodyB:bodyB;
			for (int i=0;i<nContacts;i++)
			{
				c->m_worldPos[i] = localPoints[contactIdx[i]];
			}
			GET_NPOINTS(*c) = nContacts;
		}
	}
}


__kernel void   clipHullHullKernel( __global const int2* pairs,
																					__global const BodyData* rigidBodies,
																					__global const ConvexPolyhedronCL* convexShapes,
																					__global const float4* vertices,
																					__global const float4* uniqueEdges,
																					__global const btGpuFace* faces,
																					__global const int* indices,
																					__global const float4* separatingNormals,
																					__global const int* hasSeparatingAxis,
																					__global Contact4* restrict globalContactsOut,
																					counter32_t nGlobalContactsOut,
																					int numPairs)
{

	int i = get_global_id(0);
	int pairIndex = i;

	float4 worldVertsB1[64];
	float4 worldVertsB2[64];
	int capacityWorldVerts = 64;

	float4 localContactsOut[64];
	int localContactCapacity=64;

	float minDist = -1e30f;
	float maxDist = 0.02f;

	if (i<numPairs)
	{

		if (hasSeparatingAxis[i])
		{

			int bodyIndexA = pairs[i].x;
			int bodyIndexB = pairs[i].y;
			int shapeIndexA = rigidBodies[bodyIndexA].m_shapeIdx;
			int shapeIndexB = rigidBodies[bodyIndexB].m_shapeIdx;


			int numLocalContactsOut = clipHullAgainstHull(separatingNormals[i],
														&convexShapes[shapeIndexA], &convexShapes[shapeIndexB],
														rigidBodies[bodyIndexA].m_pos,rigidBodies[bodyIndexA].m_quat,
													  rigidBodies[bodyIndexB].m_pos,rigidBodies[bodyIndexB].m_quat,
													  worldVertsB1,worldVertsB2,capacityWorldVerts,
														minDist, maxDist,
														vertices,faces,indices,
														localContactsOut,localContactCapacity);

		if (numLocalContactsOut>0)
		{
				float4 normal = -separatingNormals[i];
				int nPoints = numLocalContactsOut;
				float4* pointsIn = localContactsOut;
				int contactIdx[4] = {-1,-1,-1,-1};

				int nReducedContacts = extractManifoldSequential(pointsIn, nPoints, normal, contactIdx);

				int dstIdx;
				AppendInc( nGlobalContactsOut, dstIdx );
				//if ((dstIdx+nReducedContacts) < capacity)
				{
					__global Contact4* c = globalContactsOut+ dstIdx;
					c->m_worldNormal = normal;
					c->m_coeffs = (u32)(0.f*0xffff) | ((u32)(0.7f*0xffff)<<16);
					c->m_batchIdx = pairIndex;
					int bodyA = pairs[pairIndex].x;
					int bodyB = pairs[pairIndex].y;
					c->m_bodyAPtrAndSignBit = rigidBodies[bodyA].m_invMass==0?-bodyA:bodyA;
					c->m_bodyBPtrAndSignBit = rigidBodies[bodyB].m_invMass==0?-bodyB:bodyB;

					for (int i=0;i<nReducedContacts;i++)
					{
						c->m_worldPos[i] = pointsIn[contactIdx[i]];
					}
					GET_NPOINTS(*c) = nReducedContacts;
				}

			}//		if (numContactsOut>0)
		}//		if (hasSeparatingAxis[i])
	}//	if (i<numPairs)

}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
