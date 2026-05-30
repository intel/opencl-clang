#define BVH_VERTS_PAGE_COUNT 1
#define BVH_NODES_PAGE_SIZE 13119859
#define BVH_NODES_PAGE_COUNT 1
#define BVH_VERTS_PAGE0 1
#define BVH_NODES_PAGE0 1
#line 2 "luxrays_types.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

#define NULL_INDEX (0xffffffffu)

#if defined(LUXRAYS_OPENCL_KERNEL)

#define NULL 0

#if defined(__APPLE_CL__)
float3 __OVERLOAD__ mix(float3 a, float3 b, float t)
{
	return a + ( b - a ) * t;
}
#endif

#if defined(__APPLE_FIX__)

float2 VLOAD2F(const __global float *p) {
	return (float2)(p[0], p[1]);
}

void VSTORE2F(const float2 v, __global float *p) {
	p[0] = v.x;
	p[1] = v.y;
}

float3 VLOAD3F(const __global float *p) {
	return (float3)(p[0], p[1], p[2]);
}

float3 VLOAD3F_Private(const float *p) {
	return (float3)(p[0], p[1], p[2]);
}

void VSTORE3F(const float3 v, __global float *p) {
	p[0] = v.x;
	p[1] = v.y;
	p[2] = v.z;
}

float4 VLOAD4F(const __global float *p) {
	return (float4)(p[0], p[1], p[2], p[3]);
}

float4 VLOAD4F_Private(const float *p) {
	return (float4)(p[0], p[1], p[2], p[3]);
}

void VSTORE4F(const float4 v, __global float *p) {
	p[0] = v.x;
	p[1] = v.y;
	p[2] = v.z;
	p[3] = v.w;
}

#else

float2 VLOAD2F(const __global float *p) {
	return vload2(0, p);
}

void VSTORE2F(const float2 v, __global float *p) {
	vstore2(v, 0, p);
}

float3 VLOAD3F(const __global float *p) {
	return vload3(0, p);
}

float3 VLOAD3F_Private(const float *p) {
	return vload3(0, p);
}

void VSTORE3F(const float3 v, __global float *p) {
	vstore3(v, 0, p);
}

float4 VLOAD4F(const __global float *p) {
	return vload4(0, p);
}

// Input address must be aligned to 16B
// This performs better than vload4()
float4 VLOAD4F_Align(const __global float *p) {
	return *((const __global float4 *)p);
}

float4 VLOAD4F_Private(const float *p) {
	return vload4(0, p);
}

void VSTORE4F(const float4 v, __global float *p) {
	vstore4(v, 0, p);
}

#endif

void VADD3F(__global float *p, const float3 v) {
	VSTORE3F(VLOAD3F(p) + v, p);
}

#endif
#line 2 "epsilon_types.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

// NOTE: DEFAULT_EPSILON_MIN is very small. A plane passing exactly for the
// origin will suffer of self shadow problems because the Ray class will use
// MachineEpsilon(ray.o) as epsilon for the ray.mint. However it is pretty much
// the only case where there is a problem so better to not change anything.
// As workaround, moving the plane away from the origin is enough.
#define DEFAULT_EPSILON_MIN 1e-9f
#define DEFAULT_EPSILON_MAX 1e-1f
#define DEFAULT_EPSILON_STATIC 1e-5f

// An epsilon that can be used as threshold for cos(theta). For instance:
// if (Dot(N, LightDir) < DEFAULT_COS_EPSILON_STATIC) return Spectrum();
#define DEFAULT_COS_EPSILON_STATIC 1e-4f

// This is about 1e-5f for values near 1.f
#define DEFAULT_EPSILON_DISTANCE_FROM_VALUE 0x80u
#line 2 "epsilon_funcs.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

float MachineEpsilon_FloatAdvance(const float value) {
	return as_float(as_uint(value) + DEFAULT_EPSILON_DISTANCE_FROM_VALUE);
}

float MachineEpsilon_E(const float value) {
	const float epsilon = fabs(MachineEpsilon_FloatAdvance(value) - value);

	return clamp(epsilon, PARAM_RAY_EPSILON_MIN, PARAM_RAY_EPSILON_MAX);
}

float MachineEpsilon_E_Float3(const float3 v) {
	return fmax(MachineEpsilon_E(v.x), fmax(MachineEpsilon_E(v.y), MachineEpsilon_E(v.z)));
}
#line 2 "point_types.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

typedef struct {
	float x, y, z;
} Point;
#line 2 "vector_types.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

#define ASSIGN_VECTOR(a, b) { (a).x = (b).x; (a).y = (b).y; (a).z = (b).z; }

typedef struct {
	float x, y, z;
} Vector;
#line 2 "ray_types.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

typedef struct {
	Point o;
	Vector d;
	float mint, maxt, time;
	float pad[3];
} Ray;

typedef struct {
	float t, b1, b2;
	unsigned int meshIndex, triangleIndex;
} RayHit;
#line 2 "ray_funcs.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/
void Ray_Init4_Private(Ray *ray, const float3 orig, const float3 dir,
		const float mint, const float maxt, const float time) {
	ray->o.x = orig.x;
	ray->o.y = orig.y;
	ray->o.z = orig.z;

	ray->d.x = dir.x;
	ray->d.y = dir.y;
	ray->d.z = dir.z;

	ray->mint = mint;
	ray->maxt = maxt;

	ray->time = time;
}

void Ray_Init3_Private(Ray *ray, const float3 orig, const float3 dir,
		const float maxt, const float time) {
	ray->o.x = orig.x;
	ray->o.y = orig.y;
	ray->o.z = orig.z;

	ray->d.x = dir.x;
	ray->d.y = dir.y;
	ray->d.z = dir.z;

	ray->mint = MachineEpsilon_E_Float3(orig);
	ray->maxt = maxt;

	ray->time = time;
}

void Ray_Init2_Private(Ray *ray, const float3 orig, const float3 dir, const float time) {
	ray->o.x = orig.x;
	ray->o.y = orig.y;
	ray->o.z = orig.z;

	ray->d.x = dir.x;
	ray->d.y = dir.y;
	ray->d.z = dir.z;

	ray->mint = MachineEpsilon_E_Float3(orig);
	ray->maxt = INFINITY;

	ray->time = time;
}

void Ray_Init4(__global Ray *ray, const float3 orig, const float3 dir,
		const float mint, const float maxt, const float time) {
	VSTORE3F(orig, &ray->o.x);
	VSTORE3F(dir, &ray->d.x);

	ray->mint = mint;
	ray->maxt = maxt;

	ray->time = time;
}

void Ray_Init3(__global Ray *ray, const float3 orig, const float3 dir,
		const float maxt, const float time) {
	VSTORE3F(orig, &ray->o.x);
	VSTORE3F(dir, &ray->d.x);

	ray->mint = MachineEpsilon_E_Float3(orig);
	ray->maxt = maxt;

	ray->time = time;
}

void Ray_Init2(__global Ray *ray, const float3 orig, const float3 dir, const float time) {
	VSTORE3F(orig, &ray->o.x);
	VSTORE3F(dir, &ray->d.x);

	ray->mint = MachineEpsilon_E_Float3(orig);
	ray->maxt = INFINITY;

	ray->time = time;
}

void Ray_ReadAligned4(__global const Ray* restrict ray, float3 *rayOrig, float3 *rayDir,
		float *mint, float *maxt, float *time) {
	__global float4 *basePtr =(__global float4 *)ray;
	const float4 data0 = (*basePtr++);
	const float4 data1 = (*basePtr);

	*rayOrig = (float3)(data0.x, data0.y, data0.z);
	*rayDir = (float3)(data0.w, data1.x, data1.y);

	*mint = data1.z;
	*maxt = data1.w;

	*time = ray->time;
}

void Ray_ReadAligned4_Private(__global const Ray* restrict ray, Ray *dstRay) {
	__global float4 *basePtr =(__global float4 *)ray;
	const float4 data0 = (*basePtr++);
	const float4 data1 = (*basePtr);

	dstRay->o.x = data0.x;
	dstRay->o.y = data0.y;
	dstRay->o.z = data0.z;
	dstRay->d.x = data0.w;
	dstRay->d.y = data1.x;
	dstRay->d.z = data1.y;

	dstRay->mint = data1.z;
	dstRay->maxt = data1.w;

	dstRay->time = ray->time;
}
#line 2 "bbox_types.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

typedef struct {
	Point pMin, pMax;
} BBox;
#line 2 "bbox_funcs.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

int BBox_IntersectP(const float3 pMin, const float3 pMax,
		const float3 rayOrig, const float3 invRayDir,
		const float mint, const float maxt) {
	const float3 l1 = (pMin - rayOrig) * invRayDir;
	const float3 l2 = (pMax - rayOrig) * invRayDir;
	const float3 tNear = fmin(l1, l2);
	const float3 tFar = fmax(l1, l2);

	float t0 = fmax(fmax(fmax(tNear.x, tNear.y), fmax(tNear.x, tNear.z)), mint);
    float t1 = fmin(fmin(fmin(tFar.x, tFar.y), fmin(tFar.x, tFar.z)), maxt);

	return (t1 > t0);
}
#line 2 "triangle_types.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

typedef struct {
	unsigned int v[3];
} Triangle;
#line 2 "triangle_funcs.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

void Triangle_UniformSample(const float u0, const float u1, float *b1, float *b2) {
	const float su1 = sqrt(u0);
	*b1 = 1.f - su1;
	*b2 = u1 * su1;
}

float3 Triangle_Sample(const float3 p0, const float3 p1, const float3 p2,
	const float u0, const float u1,
	float *b0, float *b1, float *b2) {
	Triangle_UniformSample(u0, u1, b1, b2);
	*b0 = 1.f - (*b1) - (*b2);

	return (*b0) * p0 + (*b1) * p1 + (*b2) * p2;
}

float3 Triangle_GetGeometryNormal(const float3 p0, const float3 p1, const float3 p2) {
	return normalize(cross(p1 - p0, p2 - p0));
}

float3 Triangle_InterpolateNormal(const float3 n0, const float3 n1, const float3 n2,
		const float b0, const float b1, const float b2) {
	return normalize(b0 * n0 + b1 * n1 + b2 * n2);
}

float2 Triangle_InterpolateUV(const float2 uv0, const float2 uv1, const float2 uv2,
		const float b0, const float b1, const float b2) {
	return b0 * uv0 + b1 * uv1 + b2 * uv2;
}

float3 Triangle_InterpolateColor(const float3 rgb0, const float3 rgb1, const float3 rgb2,
		const float b0, const float b1, const float b2) {
	return b0 * rgb0 + b1 * rgb1 + b2 * rgb2;
}

float Triangle_InterpolateAlpha(const float a0, const float a1, const float a2,
		const float b0, const float b1, const float b2) {
	return b0 * a0 + b1 * a1 + b2 * a2;
}

void Triangle_Intersect(
		const float3 rayOrig,
		const float3 rayDir,
		const float mint,
		float *maxt,
		uint *hitMeshIndex,
		uint *hitTriangleIndex,
		float *hitB1,
		float *hitB2,
		const uint currentMeshIndex,
		const uint currentTriangleIndex,
		const float3 v0,
		const float3 v1,
		const float3 v2) {
	// Calculate intersection
	const float3 e1 = v1 - v0;
	const float3 e2 = v2 - v0;
	const float3 s1 = cross(rayDir, e2);

	const float divisor = dot(s1, e1);
	if (divisor == 0.f)
		return;

	const float invDivisor = 1.f / divisor;

	// Compute first barycentric coordinate
	const float3 d = rayOrig - v0;
	const float b1 = dot(d, s1) * invDivisor;
	if (b1 < 0.f)
		return;

	// Compute second barycentric coordinate
	const float3 s2 = cross(d, e1);
	const float b2 = dot(rayDir, s2) * invDivisor;
	if (b2 < 0.f)
		return;

	const float b0 = 1.f - b1 - b2;
	if (b0 < 0.f)
		return;

	// Compute _t_ to intersection point
	const float t = dot(e2, s2) * invDivisor;
	if (t < mint || t > *maxt)
		return;

	*maxt = t;
	*hitB1 = b1;
	*hitB2 = b2;
	*hitMeshIndex = currentMeshIndex;
	*hitTriangleIndex = currentTriangleIndex;
}
#line 2 "bvh_types.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

typedef struct {
	union {
		struct {
			// I can not use BBox here because objects with a constructor are not
			// allowed inside an union.
			float bboxMin[3];
			float bboxMax[3];
		} bvhNode;
		struct {
			unsigned int v[3];
			unsigned int meshIndex, triangleIndex;
		} triangleLeaf;
		struct {
			unsigned int leafIndex;
			unsigned int transformIndex, motionIndex; // transformIndex or motionIndex have to be NULL_INDEX (i.e. only one can be used)
			unsigned int meshOffsetIndex;
		} bvhLeaf; // Used by MBVH
	};
	// Most significant bit is used to mark leafs
	unsigned int nodeData;
	int pad0; // To align to float4
} BVHAccelArrayNode;
#line 2 "bvh_kernel.cl"

/***************************************************************************
 * Copyright 1998-2015 by authors (see AUTHORS.txt)                        *
 *                                                                         *
 *   This file is part of LuxRender.                                       *
 *                                                                         *
 * Licensed under the Apache License, Version 2.0 (the "License");         *
 * you may not use this file except in compliance with the License.        *
 * You may obtain a copy of the License at                                 *
 *                                                                         *
 *     http://www.apache.org/licenses/LICENSE-2.0                          *
 *                                                                         *
 * Unless required by applicable law or agreed to in writing, software     *
 * distributed under the License is distributed on an "AS IS" BASIS,       *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.*
 * See the License for the specific language governing permissions and     *
 * limitations under the License.                                          *
 ***************************************************************************/

#define BVHNodeData_IsLeaf(nodeData) ((nodeData) & 0x80000000u)
#define BVHNodeData_GetSkipIndex(nodeData) ((nodeData) & 0x7fffffffu)
#if (BVH_NODES_PAGE_COUNT > 1)
#define BVHNodeData_GetPageIndex(nodeData) (((nodeData) & 0x70000000u) >> 28)
#define BVHNodeData_GetNodeIndex(nodeData) ((nodeData) & 0x0fffffffu)
#endif

#if (BVH_NODES_PAGE_COUNT > 1)
void NextNode(uint *pageIndex, uint *nodeIndex) {
	++(*nodeIndex);
	if (*nodeIndex >= BVH_NODES_PAGE_SIZE) {
		*nodeIndex = 0;
		++(*pageIndex);
	}
}
#endif

#if (BVH_NODES_PAGE_COUNT == 8)
#define ACCELERATOR_INTERSECT_PARAM_DECL , __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const Point* restrict accelVertPage4, __global const Point* restrict accelVertPage5, __global const Point* restrict accelVertPage6, __global const Point* restrict accelVertPage7, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3, __global const BVHAccelArrayNode* restrict accelNodePage4, __global const BVHAccelArrayNode* restrict accelNodePage5, __global const BVHAccelArrayNode* restrict accelNodePage6, __global const BVHAccelArrayNode* restrict accelNodePage7
#define ACCELERATOR_INTERSECT_PARAM , accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelVertPage4, accelVertPage5, accelVertPage6, accelVertPage7, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3, accelNodePage4, accelNodePage5, accelNodePage6, accelNodePage7
#elif (BVH_NODES_PAGE_COUNT == 7)
#define ACCELERATOR_INTERSECT_PARAM_DECL , __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const Point* restrict accelVertPage4, __global const Point* restrict accelVertPage5, __global const Point* restrict accelVertPage6, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3, __global const BVHAccelArrayNode* restrict accelNodePage4, __global const BVHAccelArrayNode* restrict accelNodePage5, __global const BVHAccelArrayNode* restrict accelNodePage6
#define ACCELERATOR_INTERSECT_PARAM , accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelVertPage4, accelVertPage5, accelVertPage6, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3, accelNodePage4, accelNodePage5, accelNodePage6
#elif (BVH_NODES_PAGE_COUNT == 6)
#define ACCELERATOR_INTERSECT_PARAM_DECL , __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const Point* restrict accelVertPage4, __global const Point* restrict accelVertPage5, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3, __global const BVHAccelArrayNode* restrict accelNodePage4, __global const BVHAccelArrayNode* restrict accelNodePage5
#define ACCELERATOR_INTERSECT_PARAM , accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelVertPage4, accelVertPage5, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3, accelNodePage4, accelNodePage5
#elif (BVH_NODES_PAGE_COUNT == 5)
#define ACCELERATOR_INTERSECT_PARAM_DECL , __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const Point* restrict accelVertPage4, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3, __global const BVHAccelArrayNode* restrict accelNodePage4
#define ACCELERATOR_INTERSECT_PARAM , accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelVertPage4, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3, accelNodePage4
#elif (BVH_NODES_PAGE_COUNT == 4)
#define ACCELERATOR_INTERSECT_PARAM_DECL , __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3
#define ACCELERATOR_INTERSECT_PARAM , accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3
#elif (BVH_NODES_PAGE_COUNT == 3)
#define ACCELERATOR_INTERSECT_PARAM_DECL , __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2
#define ACCELERATOR_INTERSECT_PARAM , accelVertPage0, accelVertPage1, accelVertPage2, accelNodePage0, accelNodePage1, accelNodePage2
#elif (BVH_NODES_PAGE_COUNT == 2)
#define ACCELERATOR_INTERSECT_PARAM_DECL , __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1
#define ACCELERATOR_INTERSECT_PARAM , accelVertPage0, accelVertPage1, accelNodePage0, accelNodePage1
#elif (BVH_NODES_PAGE_COUNT == 1)
#define ACCELERATOR_INTERSECT_PARAM_DECL , __global const Point* restrict accelVertPage0, __global const BVHAccelArrayNode* restrict accelNodePage0
#define ACCELERATOR_INTERSECT_PARAM , accelVertPage0, accelNodePage0
#elif
ERROR: unsuported BVH_NODES_PAGE_COUNT !!!
#endif

void Accelerator_Intersect(
		const Ray *ray,
		RayHit *rayHit
		ACCELERATOR_INTERSECT_PARAM_DECL
		) {
	// Initialize vertex page references
#if (BVH_VERTS_PAGE_COUNT > 1)
	__global const Point* restrict accelVertPages[BVH_VERTS_PAGE_COUNT];
#if defined(BVH_VERTS_PAGE0)
	accelVertPages[0] = accelVertPage0;
#endif
#if defined(BVH_VERTS_PAGE1)
	accelVertPages[1] = accelVertPage1;
#endif
#if defined(BVH_VERTS_PAGE2)
	accelVertPages[2] = accelVertPage2;
#endif
#if defined(BVH_VERTS_PAGE3)
	accelVertPages[3] = accelVertPage3;
#endif
#if defined(BVH_VERTS_PAGE4)
	accelVertPages[4] = accelVertPage4;
#endif
#if defined(BVH_VERTS_PAGE5)
	accelVertPages[5] = accelVertPage5;
#endif
#if defined(BVH_VERTS_PAGE6)
	accelVertPages[6] = accelVertPage6;
#endif
#if defined(BVH_VERTS_PAGE7)
	accelVertPages[7] = accelVertPage7;
#endif
#endif

	// Initialize node page references
#if (BVH_NODES_PAGE_COUNT > 1)
	__global const BVHAccelArrayNode* restrict accelNodePages[BVH_NODES_PAGE_COUNT];
#if defined(BVH_NODES_PAGE0)
	accelNodePages[0] = accelNodePage0;
#endif
#if defined(BVH_NODES_PAGE1)
	accelNodePages[1] = accelNodePage1;
#endif
#if defined(BVH_NODES_PAGE2)
	accelNodePages[2] = accelNodePage2;
#endif
#if defined(BVH_NODES_PAGE3)
	accelNodePages[3] = accelNodePage3;
#endif
#if defined(BVH_NODES_PAGE4)
	accelNodePages[4] = accelNodePage4;
#endif
#if defined(BVH_NODES_PAGE5)
	accelNodePages[5] = accelNodePage5;
#endif
#if defined(BVH_NODES_PAGE6)
	accelNodePages[6] = accelNodePage6;
#endif
#if defined(BVH_NODES_PAGE7)
	accelNodePages[7] = accelNodePage7;
#endif

	const uint rootNodeData = accelNodePage0[0].nodeData;
	const uint stopPage = BVHNodeData_GetPageIndex(rootNodeData);
	const uint stopNode = BVHNodeData_GetNodeIndex(rootNodeData); // Non-existent
	uint currentPage = 0; // Root Node Page
#else
	const uint stopNode = BVHNodeData_GetSkipIndex(accelNodePage0[0].nodeData); // Non-existent
#endif

	const float3 rayOrig = (float3)(ray->o.x, ray->o.y, ray->o.z);
	const float3 rayDir = (float3)(ray->d.x, ray->d.y, ray->d.z);
	const float mint = ray->mint;
	float maxt = ray->maxt;

	const float3 invRayDir = 1.f / rayDir;

	uint hitMeshIndex = NULL_INDEX;
	uint hitTriangleIndex = NULL_INDEX;
	uint currentNode = 0; // Root Node

	float b1, b2;
#if (BVH_NODES_PAGE_COUNT == 1)
	while (currentNode < stopNode) {
		__global const BVHAccelArrayNode* restrict node = &accelNodePage0[currentNode];
#else
	while ((currentPage < stopPage) || (currentNode < stopNode)) {
		__global const BVHAccelArrayNode* restrict accelNodePage = accelNodePages[currentPage];
		__global const BVHAccelArrayNode* restrict node = &accelNodePage[currentNode];
#endif
		// Read the node
		__global float4* restrict data = (__global float4* restrict)node;
		const float4 data0 = *data++;
		const float4 data1 = *data;

		//const uint nodeData = node->nodeData;
		const uint nodeData = as_uint(data1.s2);
		if (BVHNodeData_IsLeaf(nodeData)) {
			// It is a leaf, check the triangle

			//const uint i0 = node->triangleLeaf.v[0];
			//const uint i1 = node->triangleLeaf.v[1];
			//const uint i2 = node->triangleLeaf.v[2];
			const uint v0 = as_uint(data0.s0);
			const uint v1 = as_uint(data0.s1);
			const uint v2 = as_uint(data0.s2);

#if (BVH_VERTS_PAGE_COUNT == 1)
			// Fast path for when there is only one memory page
			const float3 p0 = VLOAD3F(&accelVertPage0[v0].x);
			const float3 p1 = VLOAD3F(&accelVertPage0[v1].x);
			const float3 p2 = VLOAD3F(&accelVertPage0[v2].x);
#else
			const uint pv0 = (v0 & 0xe0000000u) >> 29;
			const uint iv0 = (v0 & 0x1fffffffu);
			__global Point* restrict vp0 = accelVertPages[pv0];
			const float3 p0 = VLOAD3F(&vp0[iv0].x);

			const uint pv1 = (v1 & 0xe0000000u) >> 29;
			const uint iv1 = (v1 & 0x1fffffffu);
			__global Point* restrict vp1 = accelVertPages[pv1];
			const float3 p1 = VLOAD3F(&vp1[iv1].x);

			const uint pv2 = (v2 & 0xe0000000u) >> 29;
			const uint iv2 = (v2 & 0x1fffffffu);
			__global Point* restrict vp2 = accelVertPages[pv2];
			const float3 p2 = VLOAD3F(&vp2[iv2].x);
#endif

			//const uint triangleIndex = node->triangleLeaf.triangleIndex;
			const uint meshIndex = as_uint(data0.s3);
			const uint triangleIndex = as_uint(data1.s0);

			Triangle_Intersect(rayOrig, rayDir, mint, &maxt, &hitMeshIndex, &hitTriangleIndex,
					&b1, &b2, meshIndex, triangleIndex, p0, p1, p2);
#if (BVH_NODES_PAGE_COUNT == 1)
			++currentNode;
#else
			NextNode(&currentPage, &currentNode);
#endif
		} else {
			// It is a node, check the bounding box
			//const float3 pMin = VLOAD3F(&node->bvhNode.bboxMin[0]);
			//const float3 pMax = VLOAD3F(&node->bvhNode.bboxMax[0]);
			const float3 pMin = (float3)(data0.s0, data0.s1, data0.s2);
			const float3 pMax = (float3)(data0.s3, data1.s0, data1.s1);

			if (BBox_IntersectP(pMin, pMax, rayOrig, invRayDir, mint, maxt)) {
#if (BVH_NODES_PAGE_COUNT == 1)
				++currentNode;
#else
				NextNode(&currentPage, &currentNode);
#endif
			} else {
#if (BVH_NODES_PAGE_COUNT == 1)
				// I don't need to use BVHNodeData_GetSkipIndex() here because
				// I already know the flag (i.e. the last bit) is 0
				currentNode = nodeData;
#else
				currentPage = BVHNodeData_GetPageIndex(nodeData);
				currentNode = BVHNodeData_GetNodeIndex(nodeData);
#endif
			}
		}
	}

	rayHit->t = maxt;
	rayHit->b1 = b1;
	rayHit->b2 = b2;
	rayHit->meshIndex = hitMeshIndex;
	rayHit->triangleIndex = hitTriangleIndex;
}

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void Accelerator_Intersect_RayBuffer(
		__global const Ray* restrict rays,
		__global RayHit *rayHits,
		const uint rayCount
		ACCELERATOR_INTERSECT_PARAM_DECL
		) {
	// Select the ray to check
	const int gid = get_global_id(0);
	if (gid >= rayCount)
		return;

	Ray ray;
	Ray_ReadAligned4_Private(&rays[gid], &ray);

	RayHit rayHit;
	Accelerator_Intersect(
		&ray,
		&rayHit
		ACCELERATOR_INTERSECT_PARAM
		);

	// Write result
	__global RayHit *memRayHit = &rayHits[gid];
	memRayHit->t = rayHit.t;
	memRayHit->b1 = rayHit.b1;
	memRayHit->b2 = rayHit.b2;
	memRayHit->meshIndex = rayHit.meshIndex;
	memRayHit->triangleIndex = rayHit.triangleIndex;
}


// buildOptions= -D LUXRAYS_OPENCL_KERNEL -D PARAM_RAY_EPSILON_MIN=1e-005f -D PARAM_RAY_EPSILON_MAX=0.01f
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D LUXRAYS_OPENCL_KERNEL -D PARAM_RAY_EPSILON_MIN=1e-005f -D PARAM_RAY_EPSILON_MAX=0.01f" %cfg_path --cl-device=%cl_device 2>&1
