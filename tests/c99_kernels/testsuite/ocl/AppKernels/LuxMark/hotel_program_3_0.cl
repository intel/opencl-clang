#define MBVH_VERTS_PAGE_COUNT 1
#define MBVH_NODES_PAGE_SIZE 3449392
#define MBVH_NODES_PAGE_COUNT 1
#define MBVH_VERTS_PAGE0 1
#define MBVH_NODES_PAGE0 1
#define MBVH_HAS_TRANSFORMATIONS 1
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
#line 2 "matrix4x4_types.cl"

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
	float m[4][4];
} Matrix4x4;
#line 2 "matrix4x4_funcs.cl"

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

float3 Matrix4x4_ApplyPoint(__global const Matrix4x4* restrict m, const float3 point) {
	const float4 point4 = (float4)(point.x, point.y, point.z, 1.f);

	const float4 row3 = VLOAD4F(&m->m[3][0]);
	const float iw = 1.f / dot(row3, point4);

	const float4 row0 = VLOAD4F(&m->m[0][0]);
	const float4 row1 = VLOAD4F(&m->m[1][0]);
	const float4 row2 = VLOAD4F(&m->m[2][0]);
	return (float3)(
			iw * dot(row0, point4),
			iw * dot(row1, point4),
			iw * dot(row2, point4)
			);
}

float3 Matrix4x4_ApplyPoint_Align(__global const Matrix4x4* restrict m, const float3 point) {
	const float4 point4 = (float4)(point.x, point.y, point.z, 1.f);

	const float4 row3 = VLOAD4F_Align(&m->m[3][0]);
	const float iw = 1.f / dot(row3, point4);

	const float4 row0 = VLOAD4F_Align(&m->m[0][0]);
	const float4 row1 = VLOAD4F_Align(&m->m[1][0]);
	const float4 row2 = VLOAD4F_Align(&m->m[2][0]);
	return (float3)(
			iw * dot(row0, point4),
			iw * dot(row1, point4),
			iw * dot(row2, point4)
			);
}

float3 Matrix4x4_ApplyPoint_Private(Matrix4x4 *m, const float3 point) {
	const float4 point4 = (float4)(point.x, point.y, point.z, 1.f);

	const float4 row3 = VLOAD4F_Private(&m->m[3][0]);
	const float iw = 1.f / dot(row3, point4);

	const float4 row0 = VLOAD4F_Private(&m->m[0][0]);
	const float4 row1 = VLOAD4F_Private(&m->m[1][0]);
	const float4 row2 = VLOAD4F_Private(&m->m[2][0]);
	return (float3)(
			iw * dot(row0, point4),
			iw * dot(row1, point4),
			iw * dot(row2, point4)
			);
}

float3 Matrix4x4_ApplyVector(__global const Matrix4x4* restrict m, const float3 vector) {
	const float3 row0 = VLOAD3F(&m->m[0][0]);
	const float3 row1 = VLOAD3F(&m->m[1][0]);
	const float3 row2 = VLOAD3F(&m->m[2][0]);
	return (float3)(
			dot(row0, vector),
			dot(row1, vector),
			dot(row2, vector)
			);
}

float3 Matrix4x4_ApplyVector_Private(Matrix4x4 *m, const float3 vector) {
	const float3 row0 = VLOAD3F_Private(&m->m[0][0]);
	const float3 row1 = VLOAD3F_Private(&m->m[1][0]);
	const float3 row2 = VLOAD3F_Private(&m->m[2][0]);
	return (float3)(
			dot(row0, vector),
			dot(row1, vector),
			dot(row2, vector)
			);
}

float3 Matrix4x4_ApplyNormal(__global const Matrix4x4* restrict m, const float3 normal) {
	const float3 row0 = (float3)(m->m[0][0], m->m[1][0], m->m[2][0]);
	const float3 row1 = (float3)(m->m[0][1], m->m[1][1], m->m[2][1]);
	const float3 row2 = (float3)(m->m[0][2], m->m[1][2], m->m[2][2]);
	return (float3)(
			dot(row0, normal),
			dot(row1, normal),
			dot(row2, normal)
			);
}

void Matrix4x4_Identity(Matrix4x4 *m) {
	for (int j = 0; j < 4; ++j)
		for (int i = 0; i < 4; ++i)
			m->m[i][j] = (i == j) ? 1.f : 0.f;
}

void Matrix4x4_Invert(Matrix4x4 *m) {
	int indxc[4], indxr[4];
	int ipiv[4] = {0, 0, 0, 0};

	for (int i = 0; i < 4; ++i) {
		int irow = -1, icol = -1;
		float big = 0.;
		// Choose pivot
		for (int j = 0; j < 4; ++j) {
			if (ipiv[j] != 1) {
				for (int k = 0; k < 4; ++k) {
					if (ipiv[k] == 0) {
						if (fabs(m->m[j][k]) >= big) {
							big = fabs(m->m[j][k]);
							irow = j;
							icol = k;
						}
					} else if (ipiv[k] > 1) {
						//throw std::runtime_error("Singular matrix in MatrixInvert: " + ToString(*this));
						// I can not do very much here
						Matrix4x4_Identity(m);
						return;
					}
				}
			}
		}
		++ipiv[icol];
		// Swap rows _irow_ and _icol_ for pivot
		if (irow != icol) {
			for (int k = 0; k < 4; ++k) {
				const float tmp = m->m[irow][k];
				m->m[irow][k] = m->m[icol][k];
				m->m[icol][k] = tmp;
			}
		}
		indxr[i] = irow;
		indxc[i] = icol;
		if (m->m[icol][icol] == 0.f) {
			//throw std::runtime_error("Singular matrix in MatrixInvert: " + ToString(*this));
			// I can not do very much here
			Matrix4x4_Identity(m);
			return;
		}
		// Set $m[icol][icol]$ to one by scaling row _icol_ appropriately
		float pivinv = 1.f / m->m[icol][icol];
		m->m[icol][icol] = 1.f;
		for (int j = 0; j < 4; ++j)
			m->m[icol][j] *= pivinv;
		// Subtract this row from others to zero out their columns
		for (int j = 0; j < 4; ++j) {
			if (j != icol) {
				float save = m->m[j][icol];
				m->m[j][icol] = 0;
				for (int k = 0; k < 4; ++k)
					m->m[j][k] -= m->m[icol][k] * save;
			}
		}
	}
	// Swap columns to reflect permutation
	for (int j = 3; j >= 0; --j) {
		if (indxr[j] != indxc[j]) {
			for (int k = 0; k < 4; ++k) {
				const float tmp = m->m[k][indxr[j]];
				m->m[k][indxr[j]] = m->m[k][indxc[j]];
				m->m[k][indxc[j]] = tmp;
			}
		}
	}
}
#line 2 "quaternion_types.cl"

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
	float w;
	Vector v;
} Quaternion;
#line 2 "quaternion_funcs.cl"

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

// Get the rotation matrix from quaternion
void Quaternion_ToMatrix(const float4 q, Matrix4x4 *m) {
	const float xx = q.s1 * q.s1;
	const float yy = q.s2 * q.s2;
	const float zz = q.s3 * q.s3;
	const float xy = q.s1 * q.s2;
	const float xz = q.s1 * q.s3;
	const float yz = q.s2 * q.s3;
	const float xw = q.s1 * q.s0;
	const float yw = q.s2 * q.s0;
	const float zw = q.s3 * q.s0;

	m->m[0][0] = 1.f - 2.f * (yy + zz);
	m->m[1][0] = 2.f * (xy - zw);
	m->m[2][0] = 2.f * (xz + yw);
	m->m[0][1] = 2.f * (xy + zw);
	m->m[1][1] = 1.f - 2.f * (xx + zz);
	m->m[2][1] = 2.f * (yz - xw);
	m->m[0][2] = 2.f * (xz - yw);
	m->m[1][2] = 2.f * (yz + xw);
	m->m[2][2] = 1.f - 2.f * (xx + yy);

	// Complete matrix
	m->m[0][3] = m->m[1][3] = m->m[2][3] = 0.f;
	m->m[3][0] = m->m[3][1] = m->m[3][2] = 0.f;
	m->m[3][3] = 1.f;
}

float4 Quaternion_Slerp(float t, const float4 q1, const float4 q2) {

	float cos_phi = dot(q1, q2);
	const float sign = (cos_phi > 0.f) ? 1.f : -1.f;

	cos_phi *= sign;

	float f1, f2;
	if (1.f - cos_phi > 1e-6f) {
		float phi = acos(cos_phi);
		float sin_phi = sin(phi);
		f1 = sin((1.f - t) * phi) / sin_phi;
		f2 = sin(t * phi) / sin_phi;
	} else {
		// start and end are very close
		// perform linear interpolation
		f1 = 1.f - t;
		f2 = t;
	}

	return f1 * q1 + (sign * f2) * q2;
}
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
#line 2 "transform_types.cl"

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
	Matrix4x4 m, mInv;
} Transform;
#line 2 "transform_funcs.cl"

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

float3 Transform_ApplyPoint(__global const Transform* restrict trans, const float3 point) {
	return Matrix4x4_ApplyPoint(&trans->m, point);
}

float3 Transform_ApplyVector(__global const Transform* restrict trans, const float3 vector) {
	return Matrix4x4_ApplyVector(&trans->m, vector);
}

float3 Transform_ApplyNormal(__global const Transform* restrict trans, const float3 normal) {
	return Matrix4x4_ApplyNormal(&trans->m, normal);
}

float3 Transform_InvApplyPoint(__global const Transform* restrict trans, const float3 point) {
	return Matrix4x4_ApplyPoint(&trans->mInv, point);
}

float3 Transform_InvApplyVector(__global const Transform* restrict trans, const float3 vector) {
	return Matrix4x4_ApplyVector(&trans->mInv, vector);
}

float3 Transform_InvApplyNormal(__global const Transform* restrict trans, const float3 normal) {
	return Matrix4x4_ApplyNormal(&trans->mInv, normal);
}
#line 2 "motionsystem_types.cl"

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
	// Scaling
	float Sx, Sy, Sz;
	// Shearing
	float Sxy, Sxz, Syz;
	// Rotation
	Matrix4x4 R;
	// Translation
	float Tx, Ty, Tz;
	// Perspective
	float Px, Py, Pz, Pw;
	// Represents a valid series of transformations
	bool Valid;
} DecomposedTransform;

typedef struct {
	float startTime, endTime;
	Transform start, end;
	DecomposedTransform startT, endT;
	Quaternion startQ, endQ;
	int hasRotation, hasTranslation, hasScale;
	int hasTranslationX, hasTranslationY, hasTranslationZ;
	int hasScaleX, hasScaleY, hasScaleZ;
	// false if start and end transformations are identical
	int isActive;
} InterpolatedTransform;

typedef struct {
	unsigned int interpolatedTransformFirstIndex;
	unsigned int interpolatedTransformLastIndex;
} MotionSystem;
#line 2 "motionsystem_funcs.cl"

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

void InterpolatedTransform_Sample(__global const InterpolatedTransform* restrict interpolatedTransform,
		const float time, Matrix4x4 *result) {
	if (!interpolatedTransform->isActive) {
		*result = interpolatedTransform->start.m;
		return;
	}

	// Determine interpolation value
	if (time <= interpolatedTransform->startTime) {
		*result = interpolatedTransform->start.m;
		return;
	}
	if (time >= interpolatedTransform->endTime) {
		*result = interpolatedTransform->end.m;
		return;
	}

	const float w = interpolatedTransform->endTime - interpolatedTransform->startTime;
	const float d = time - interpolatedTransform->startTime;
	const float le = d / w;

	// if translation only, just modify start matrix
	if (interpolatedTransform->hasTranslation &&
			!(interpolatedTransform->hasScale || interpolatedTransform->hasRotation)) {
		*result = interpolatedTransform->start.m;
		if (interpolatedTransform->hasTranslationX)
			result->m[0][3] = mix(interpolatedTransform->startT.Tx, interpolatedTransform->endT.Tx, le);
		if (interpolatedTransform->hasTranslationY)
			result->m[1][3] = mix(interpolatedTransform->startT.Ty, interpolatedTransform->endT.Ty, le);
		if (interpolatedTransform->hasTranslationZ)
			result->m[2][3] = mix(interpolatedTransform->startT.Tz, interpolatedTransform->endT.Tz, le);

		return;
	}

	if (interpolatedTransform->hasRotation) {
		// Quaternion interpolation of rotation
		const float4 startQ = VLOAD4F(&interpolatedTransform->startQ.w);
		const float4 endQ = VLOAD4F(&interpolatedTransform->endQ.w);
		const float4 interQ = Quaternion_Slerp(le, startQ, endQ);
		Quaternion_ToMatrix(interQ, result);
	} else
		*result = interpolatedTransform->startT.R;

	if (interpolatedTransform->hasScale) {
		const float Sx = mix(interpolatedTransform->startT.Sx, interpolatedTransform->endT.Sx, le);
		const float Sy = mix(interpolatedTransform->startT.Sy, interpolatedTransform->endT.Sy, le);
		const float Sz = mix(interpolatedTransform->startT.Sz, interpolatedTransform->endT.Sz, le);

		// T * S * R
		for (uint j = 0; j < 3; ++j) {
			result->m[0][j] = Sx * result->m[0][j];
			result->m[1][j] = Sy * result->m[1][j];
			result->m[2][j] = Sz * result->m[2][j];
		}
	} else {
		for (uint j = 0; j < 3; ++j) {
			result->m[0][j] = interpolatedTransform->startT.Sx * result->m[0][j];
			result->m[1][j] = interpolatedTransform->startT.Sy * result->m[1][j];
			result->m[2][j] = interpolatedTransform->startT.Sz * result->m[2][j];
		}
	}

	if (interpolatedTransform->hasTranslationX)
		result->m[0][3] = mix(interpolatedTransform->startT.Tx, interpolatedTransform->endT.Tx, le);
	else
		result->m[0][3] = interpolatedTransform->startT.Tx;

	if (interpolatedTransform->hasTranslationY)
		result->m[1][3] = mix(interpolatedTransform->startT.Ty, interpolatedTransform->endT.Ty, le);
	else
		result->m[1][3] = interpolatedTransform->startT.Ty;

	if (interpolatedTransform->hasTranslationZ)
		result->m[2][3] = mix(interpolatedTransform->startT.Tz, interpolatedTransform->endT.Tz, le);
	else
		result->m[2][3] = interpolatedTransform->startT.Tz;
}

void MotionSystem_Sample(__global const MotionSystem* restrict motionSystem, const float time,
		__global const InterpolatedTransform *interpolatedTransforms, Matrix4x4 *result) {
	const uint interpolatedTransformFirstIndex = motionSystem->interpolatedTransformFirstIndex;
	const uint interpolatedTransformLastIndex = motionSystem->interpolatedTransformLastIndex;

	// Pick the right InterpolatedTransform
	uint index = interpolatedTransformLastIndex;
	for (uint i = interpolatedTransformFirstIndex; i <= interpolatedTransformLastIndex; ++i) {
		if (time < interpolatedTransforms[i].endTime) {
			index = i;
			break;
		}
	}

	InterpolatedTransform_Sample(&interpolatedTransforms[index], time, result);
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
#line 2 "mbvh_kernel.cl"

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
#if (MBVH_NODES_PAGE_COUNT > 1)
#define BVHNodeData_GetPageIndex(nodeData) (((nodeData) & 0x70000000u) >> 28)
#define BVHNodeData_GetNodeIndex(nodeData) ((nodeData) & 0x0fffffffu)
#endif

#if (MBVH_NODES_PAGE_COUNT > 1)
void NextNode(uint *pageIndex, uint *nodeIndex) {
	++(*nodeIndex);
	if (*nodeIndex >= MBVH_NODES_PAGE_SIZE) {
		*nodeIndex = 0;
		++(*pageIndex);
	}
}
#endif

#if defined(MBVH_HAS_TRANSFORMATIONS)
#define MBVH_TRANSFORMATIONS_PARAM_DECL , __global const Matrix4x4* restrict leafTransformations
#define MBVH_TRANSFORMATIONS_PARAM , leafTransformations
#else
#define MBVH_TRANSFORMATIONS_PARAM_DECL
#define MBVH_TRANSFORMATIONS_PARAM
#endif

#if defined(MBVH_HAS_MOTIONSYSTEMS)
#define MBVH_MOTIONSYSTEMS_PARAM_DECL , __global const MotionSystem* leafMotionSystems , __global const InterpolatedTransform* restrict leafInterpolatedTransforms
#define MBVH_MOTIONSYSTEMS_PARAM , leafMotionSystems, leafInterpolatedTransforms
#else
#define MBVH_MOTIONSYSTEMS_PARAM_DECL
#define MBVH_MOTIONSYSTEMS_PARAM
#endif

#if (MBVH_NODES_PAGE_COUNT == 8)
#define ACCELERATOR_INTERSECT_PARAM_DECL MBVH_TRANSFORMATIONS_PARAM_DECL MBVH_MOTIONSYSTEMS_PARAM_DECL, __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const Point* restrict accelVertPage4, __global const Point* restrict accelVertPage5, __global const Point* restrict accelVertPage6, __global const Point* restrict accelVertPage7, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3, __global const BVHAccelArrayNode* restrict accelNodePage4, __global const BVHAccelArrayNode* restrict accelNodePage5, __global const BVHAccelArrayNode* restrict accelNodePage6, __global const BVHAccelArrayNode* restrict accelNodePage7
#define ACCELERATOR_INTERSECT_PARAM MBVH_TRANSFORMATIONS_PARAM MBVH_MOTIONSYSTEMS_PARAM, accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelVertPage4, accelVertPage5, accelVertPage6, accelVertPage7, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3, accelNodePage4, accelNodePage5, accelNodePage6, accelNodePage7
#elif (MBVH_NODES_PAGE_COUNT == 7)
#define ACCELERATOR_INTERSECT_PARAM_DECL MBVH_TRANSFORMATIONS_PARAM_DECL MBVH_MOTIONSYSTEMS_PARAM_DECL, __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const Point* restrict accelVertPage4, __global const Point* restrict accelVertPage5, __global const Point* restrict accelVertPage6, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3, __global const BVHAccelArrayNode* restrict accelNodePage4, __global const BVHAccelArrayNode* restrict accelNodePage5, __global const BVHAccelArrayNode* restrict accelNodePage6
#define ACCELERATOR_INTERSECT_PARAM MBVH_TRANSFORMATIONS_PARAM MBVH_MOTIONSYSTEMS_PARAM, accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelVertPage4, accelVertPage5, accelVertPage6, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3, accelNodePage4, accelNodePage5, accelNodePage6
#elif (MBVH_NODES_PAGE_COUNT == 6)
#define ACCELERATOR_INTERSECT_PARAM_DECL MBVH_TRANSFORMATIONS_PARAM_DECL MBVH_MOTIONSYSTEMS_PARAM_DECL, __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const Point* restrict accelVertPage4, __global const Point* restrict accelVertPage5, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3, __global const BVHAccelArrayNode* restrict accelNodePage4, __global const BVHAccelArrayNode* restrict accelNodePage5
#define ACCELERATOR_INTERSECT_PARAM MBVH_TRANSFORMATIONS_PARAM MBVH_MOTIONSYSTEMS_PARAM, accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelVertPage4, accelVertPage5, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3, accelNodePage4, accelNodePage5
#elif (MBVH_NODES_PAGE_COUNT == 5)
#define ACCELERATOR_INTERSECT_PARAM_DECL MBVH_TRANSFORMATIONS_PARAM_DECL MBVH_MOTIONSYSTEMS_PARAM_DECL, __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const Point* restrict accelVertPage4, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3, __global const BVHAccelArrayNode* restrict accelNodePage4
#define ACCELERATOR_INTERSECT_PARAM MBVH_TRANSFORMATIONS_PARAM MBVH_MOTIONSYSTEMS_PARAM, accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelVertPage4, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3, accelNodePage4
#elif (MBVH_NODES_PAGE_COUNT == 4)
#define ACCELERATOR_INTERSECT_PARAM_DECL MBVH_TRANSFORMATIONS_PARAM_DECL MBVH_MOTIONSYSTEMS_PARAM_DECL, __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const Point* restrict accelVertPage3, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2, __global const BVHAccelArrayNode* restrict accelNodePage3
#define ACCELERATOR_INTERSECT_PARAM MBVH_TRANSFORMATIONS_PARAM MBVH_MOTIONSYSTEMS_PARAM, accelVertPage0, accelVertPage1, accelVertPage2, accelVertPage3, accelNodePage0, accelNodePage1, accelNodePage2, accelNodePage3
#elif (MBVH_NODES_PAGE_COUNT == 3)
#define ACCELERATOR_INTERSECT_PARAM_DECL MBVH_TRANSFORMATIONS_PARAM_DECL MBVH_MOTIONSYSTEMS_PARAM_DECL, __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const Point* restrict accelVertPage2, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1, __global const BVHAccelArrayNode* restrict accelNodePage2
#define ACCELERATOR_INTERSECT_PARAM MBVH_TRANSFORMATIONS_PARAM MBVH_MOTIONSYSTEMS_PARAM, accelVertPage0, accelVertPage1, accelVertPage2, accelNodePage0, accelNodePage1, accelNodePage2
#elif (MBVH_NODES_PAGE_COUNT == 2)
#define ACCELERATOR_INTERSECT_PARAM_DECL MBVH_TRANSFORMATIONS_PARAM_DECL MBVH_MOTIONSYSTEMS_PARAM_DECL, __global const Point* restrict accelVertPage0, __global const Point* restrict accelVertPage1, __global const BVHAccelArrayNode* restrict accelNodePage0, __global const BVHAccelArrayNode* restrict accelNodePage1
#define ACCELERATOR_INTERSECT_PARAM MBVH_TRANSFORMATIONS_PARAM MBVH_MOTIONSYSTEMS_PARAM, accelVertPage0, accelVertPage1, accelNodePage0, accelNodePage1
#elif (MBVH_NODES_PAGE_COUNT == 1)
#define ACCELERATOR_INTERSECT_PARAM_DECL MBVH_TRANSFORMATIONS_PARAM_DECL MBVH_MOTIONSYSTEMS_PARAM_DECL, __global const Point* restrict accelVertPage0, __global const BVHAccelArrayNode* restrict accelNodePage0
#define ACCELERATOR_INTERSECT_PARAM MBVH_TRANSFORMATIONS_PARAM MBVH_MOTIONSYSTEMS_PARAM, accelVertPage0, accelNodePage0
#elif
ERROR: unsuported MBVH_NODES_PAGE_COUNT !!!
#endif

void Accelerator_Intersect(
		const Ray *ray,
		RayHit *rayHit
		ACCELERATOR_INTERSECT_PARAM_DECL
		) {
	// Initialize vertex page references
#if (MBVH_VERTS_PAGE_COUNT > 1)
	__global const Point* restrict accelVertPages[MBVH_VERTS_PAGE_COUNT];
#if defined(MBVH_VERTS_PAGE0)
	accelVertPages[0] = accelVertPage0;
#endif
#if defined(MBVH_VERTS_PAGE1)
	accelVertPages[1] = accelVertPage1;
#endif
#if defined(MBVH_VERTS_PAGE2)
	accelVertPages[2] = accelVertPage2;
#endif
#if defined(MBVH_VERTS_PAGE3)
	accelVertPages[3] = accelVertPage3;
#endif
#if defined(MBVH_VERTS_PAGE4)
	accelVertPages[4] = accelVertPage4;
#endif
#if defined(MBVH_VERTS_PAGE5)
	accelVertPages[5] = accelVertPage5;
#endif
#if defined(MBVH_VERTS_PAGE6)
	accelVertPages[6] = accelVertPage6;
#endif
#if defined(MBVH_VERTS_PAGE7)
	accelVertPages[7] = accelVertPage7;
#endif
#endif

	// Initialize node page references
#if (MBVH_NODES_PAGE_COUNT > 1)
	__global const BVHAccelArrayNode* restrict accelNodePages[MBVH_NODES_PAGE_COUNT];
#if defined(MBVH_NODES_PAGE0)
	accelNodePages[0] = accelNodePage0;
#endif
#if defined(MBVH_NODES_PAGE1)
	accelNodePages[1] = accelNodePage1;
#endif
#if defined(MBVH_NODES_PAGE2)
	accelNodePages[2] = accelNodePage2;
#endif
#if defined(MBVH_NODES_PAGE3)
	accelNodePages[3] = accelNodePage3;
#endif
#if defined(MBVH_NODES_PAGE4)
	accelNodePages[4] = accelNodePage4;
#endif
#if defined(MBVH_NODES_PAGE5)
	accelNodePages[5] = accelNodePage5;
#endif
#if defined(MBVH_NODES_PAGE6)
	accelNodePages[6] = accelNodePage6;
#endif
#if defined(MBVH_NODES_PAGE7)
	accelNodePages[7] = accelNodePage7;
#endif
#endif

	bool insideLeafTree = false;
#if (MBVH_NODES_PAGE_COUNT == 1)
	uint currentRootNode = 0;
	uint rootStopNode = BVHNodeData_GetSkipIndex(accelNodePage0[0].nodeData); // Non-existent
	uint currentStopNode = rootStopNode; // Non-existent
	uint currentNode = currentRootNode;
#else
	uint currentRootPage = 0;
	uint currentRootNode = 0;

	const uint rootStopIndex = accelNodePage0[0].nodeData;
	const uint rootStopPage = BVHNodeData_GetPageIndex(rootStopIndex);
	const uint rootStopNode = BVHNodeData_GetNodeIndex(rootStopIndex); // Non-existent

	uint currentStopPage = rootStopPage; // Non-existent
	uint currentStopNode = rootStopNode; // Non-existent

	uint currentPage = 0; // Root Node Page
	uint currentNode = currentRootNode;
#endif

	uint currentMeshOffset = 0;

	const float3 rootRayOrig = (float3)(ray->o.x, ray->o.y, ray->o.z);
	const float3 rootRayDir = (float3)(ray->d.x, ray->d.y, ray->d.z);
	const float mint = ray->mint;
	float maxt = ray->maxt;
#if defined(MBVH_HAS_MOTIONSYSTEMS)
	const float rayTime = ray->time;
#endif

	float3 currentRayOrig = rootRayOrig;
	float3 currentRayDir = rootRayDir;

	uint hitMeshIndex = NULL_INDEX;
	uint hitTriangleIndex = NULL_INDEX;

	float b1, b2;
	for (;;) {
#if (MBVH_NODES_PAGE_COUNT == 1)
		if (currentNode >= currentStopNode) {
#else
		if (!((currentPage < currentStopPage) || (currentNode < currentStopNode))) {
#endif
			if (insideLeafTree) {
				// Go back to the root tree
#if (MBVH_NODES_PAGE_COUNT == 1)
				currentNode = currentRootNode;
				currentStopNode = rootStopNode;
#else
				currentPage = currentRootPage;
				currentNode = currentRootNode;
				currentStopPage = rootStopPage;
				currentStopNode = rootStopNode;
#endif
				currentRayOrig = rootRayOrig;
				currentRayDir = rootRayDir;
				insideLeafTree = false;

				// Check if the leaf was the very last root node
#if (MBVH_NODES_PAGE_COUNT == 1)
				if (currentNode >= currentStopNode)
#else
				if (!((currentPage < currentStopPage) || (currentNode < currentStopNode)))
#endif
					break;
			} else {
				// Done
				break;
			}
		}

#if (MBVH_NODES_PAGE_COUNT == 1)
		__global const BVHAccelArrayNode* restrict node = &accelNodePage0[currentNode];
#else
		__global const BVHAccelArrayNode* restrict accelNodePage = accelNodePages[currentPage];
		__global const BVHAccelArrayNode* restrict node = &accelNodePage[currentNode];
#endif
// Read the node
		__global const float4* restrict data = (__global const float4* restrict)node;
		const float4 data0 = *data++;
		const float4 data1 = *data;

		//const uint nodeData = node->nodeData;
		const uint nodeData = as_uint(data1.s2);
		if (BVHNodeData_IsLeaf(nodeData)) {
			if (insideLeafTree) {
				// I'm inside a leaf tree, I have to check the triangle

				//const uint i0 = node->triangleLeaf.v[0];
				//const uint i1 = node->triangleLeaf.v[1];
				//const uint i2 = node->triangleLeaf.v[2];
				const uint v0 = as_uint(data0.s0);
				const uint v1 = as_uint(data0.s1);
				const uint v2 = as_uint(data0.s2);

#if (MBVH_VERTS_PAGE_COUNT == 1)
				// Fast path for when there is only one memory page
				const float3 p0 = VLOAD3F(&accelVertPage0[v0].x);
				const float3 p1 = VLOAD3F(&accelVertPage0[v1].x);
				const float3 p2 = VLOAD3F(&accelVertPage0[v2].x);
#else
				const uint pv0 = (v0 & 0xe0000000u) >> 29;
				const uint iv0 = (v0 & 0x1fffffffu);
				__global const Point* restrict vp0 = accelVertPages[pv0];
				const float3 p0 = VLOAD3F(&vp0[iv0].x);

				const uint pv1 = (v1 & 0xe0000000u) >> 29;
				const uint iv1 = (v1 & 0x1fffffffu);
				__global const Point* restrict vp1 = accelVertPages[pv1];
				const float3 p1 = VLOAD3F(&vp1[iv1].x);

				const uint pv2 = (v2 & 0xe0000000u) >> 29;
				const uint iv2 = (v2 & 0x1fffffffu);
				__global const Point* restrict vp2 = accelVertPages[pv2];
				const float3 p2 = VLOAD3F(&vp2[iv2].x);
#endif

				//const uint meshIndex = node->triangleLeaf.meshIndex + currentMeshOffset;
				//const uint triangleIndex = node->triangleLeaf.triangleIndex;
				const uint meshIndex = as_uint(data0.s3) + currentMeshOffset;
				const uint triangleIndex = as_uint(data1.s0);
				Triangle_Intersect(currentRayOrig, currentRayDir, mint, &maxt, &hitMeshIndex, &hitTriangleIndex, &b1, &b2,
					meshIndex, triangleIndex, p0, p1, p2);
#if (MBVH_NODES_PAGE_COUNT == 1)
				++currentNode;
#else
				NextNode(&currentPage, &currentNode);
#endif
			} else {
				// I have to check a leaf tree

				// Transform the ray in the local coordinate system

#if defined(MBVH_HAS_TRANSFORMATIONS)
				//const uint transformIndex = node->bvhLeaf.transformIndex;
				const uint transformIndex = as_int(data0.s1);
				if (transformIndex != NULL_INDEX) {
					// Transform ray origin and direction
					__global const Matrix4x4* restrict m = &leafTransformations[transformIndex];
					currentRayOrig = Matrix4x4_ApplyPoint_Align(m, rootRayOrig);
					currentRayDir = Matrix4x4_ApplyVector(m, rootRayDir);
				}
#endif

#if defined(MBVH_HAS_MOTIONSYSTEMS)
				//const uint motionIndex = node->bvhLeaf.motionIndex;
				const uint motionIndex = as_int(data0.s2);
				if (motionIndex != NULL_INDEX) {
					// Transform ray origin and direction
					Matrix4x4 m;
					MotionSystem_Sample(&leafMotionSystems[motionIndex], rayTime, leafInterpolatedTransforms, &m);
					currentRayOrig = Matrix4x4_ApplyPoint_Private(&m, rootRayOrig);
					currentRayDir = Matrix4x4_ApplyVector_Private(&m, rootRayDir);
				}
#endif

				//currentMeshOffset = node->bvhLeaf.meshOffsetIndex;
				currentMeshOffset = as_int(data0.s3);

				//const uint leafIndex = node->bvhLeaf.leafIndex;
				const uint leafIndex = as_int(data0.s0);
#if (MBVH_NODES_PAGE_COUNT == 1)
				currentRootNode = currentNode + 1;
				currentNode = leafIndex;
				currentStopNode = BVHNodeData_GetSkipIndex(accelNodePage0[currentNode].nodeData);
#else
				currentRootPage = currentPage;
				currentRootNode = currentNode;
				NextNode(&currentRootPage, &currentRootNode);

				currentPage = BVHNodeData_GetPageIndex(leafIndex);
				currentNode = BVHNodeData_GetNodeIndex(leafIndex);

				__global BVHAccelArrayNode* restrict stopaccelNodePage = accelNodePages[currentPage];
				__global BVHAccelArrayNode* restrict stopNode = &stopaccelNodePage[currentNode];
				const uint stopIndex = stopNode->nodeData;
				currentStopPage = BVHNodeData_GetPageIndex(stopIndex);
				currentStopNode = BVHNodeData_GetNodeIndex(stopIndex);
#endif

				// Now, I'm inside a leaf tree
				insideLeafTree = true;
			}
		} else {
			// It is a node, check the bounding box
			//const float3 pMin = VLOAD3F(&node->bvhNode.bboxMin[0]);
			//const float3 pMax = VLOAD3F(&node->bvhNode.bboxMax[0]);
			const float3 pMin = (float3)(data0.s0, data0.s1, data0.s2);
			const float3 pMax = (float3)(data0.s3, data1.s0, data1.s1);

			if (BBox_IntersectP(pMin, pMax, currentRayOrig, 1.f / currentRayDir, mint, maxt)) {
#if (MBVH_NODES_PAGE_COUNT == 1)
				++currentNode;
#else
				NextNode(&currentPage, &currentNode);
#endif
			} else {
#if (MBVH_NODES_PAGE_COUNT == 1)
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


// buildOptions= -D LUXRAYS_OPENCL_KERNEL -D PARAM_RAY_EPSILON_MIN=1e-009f -D PARAM_RAY_EPSILON_MAX=0.1f
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D LUXRAYS_OPENCL_KERNEL -D PARAM_RAY_EPSILON_MIN=1e-009f -D PARAM_RAY_EPSILON_MAX=0.1f" %cfg_path --cl-device=%cl_device 2>&1
