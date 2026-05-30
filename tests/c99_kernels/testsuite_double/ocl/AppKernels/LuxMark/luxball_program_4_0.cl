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
#line 2 "uv_types.cl"

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

#define ASSIGN_UV(a, b) { (a).u = (b).u; (a).v = (b).v; }

typedef struct {
	float u,v;
} UV;
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
#line 2 "normal_types.cl"

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
} Normal;
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
#line 2 "color_types.cl"

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

#if defined(SLG_OPENCL_KERNEL)
#define BLACK ((float3)(0.f, 0.f, 0.f))
#define WHITE ((float3)(1.f, 1.f, 1.f))
#define ZERO BLACK
#endif

#define ASSIGN_SPECTRUM(c0, c1) { (c0).c[0] = (c1).c[0]; (c0).c[1] = (c1).c[1]; (c0).c[2] = (c1).c[2]; }

typedef struct {
	float c[3];
} RGBColor;

typedef RGBColor Spectrum;
#line 2 "frame_types.cl"

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
	Vector X, Y, Z;
} Frame;
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
#line 2 "utils_funcs.cl"

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

int Mod(int a, int b) {
	if (b == 0)
		b = 1;

	a %= b;
	if (a < 0)
		a += b;

	return a;
}

float Radians(float deg) {
	return (M_PI_F / 180.f) * deg;
}

float Degrees(float rad) {
	return (180.f / M_PI_F) * rad;
}

int Ceil2Int(float val) {
	return (int)ceil(val);
}

uint Ceil2UInt(float val) {
	return (uint)ceil(val);
}

int Floor2Int(const float val) {
	return (int)floor(val);
}

unsigned int Floor2UInt(const float val) {
	return (val > 0.f) ? ((unsigned int)floor(val)) : 0;
}

float Lerp(const float t, const float v1, const float v2) {
	// Linear interpolation
	return mix(v1, v2, t);
}

float3 Lerp3(const float t, const float3 v1, const float3 v2) {
	// Linear interpolation
	return mix(v1, v2, t);
}

float Cerp(float t, float v0, float v1, float v2, float v3) {
	// Cubic interpolation
	return v1 + .5f *
			t * (v2 - v0 +
				t * (2.f * v0 - 5.f * v1 + 4.f * v2 - v3 +
					t * (3.f * (v1 - v2) + v3 - v0)));
}

float3 Cerp3(float t, float3 v0, float3 v1, float3 v2, float3 v3) {
	// Cubic interpolation
	return v1 + .5f *
			t * (v2 - v0 +
				t * (2.f * v0 - 5.f * v1 + 4.f * v2 - v3 +
					t * (3.f * (v1 - v2) + v3 - v0)));
}

float SmoothStep(const float min, const float max, const float value) {
	const float v = clamp((value - min) / (max - min), 0.f, 1.f);
	return v * v * (-2.f * v  + 3.f);
}

float CosTheta(const float3 v) {
	return v.z;
}

float SinTheta2(const float3 w) {
	return fmax(0.f, 1.f - CosTheta(w) * CosTheta(w));
}

float SinTheta(const float3 w) {
	return sqrt(SinTheta2(w));
}

float CosPhi(const float3 w) {
	const float sinTheta = SinTheta(w);
	return sinTheta > 0.f ? clamp(w.x / sinTheta, -1.f, 1.f) : 1.f;
}

float SinPhi(const float3 w) {
	const float sinTheta = SinTheta(w);
	return sinTheta > 0.f ? clamp(w.y / sinTheta, -1.f, 1.f) : 0.f;
}

float3 SphericalDirection(float sintheta, float costheta, float phi) {
	return (float3)(sintheta * cos(phi), sintheta * sin(phi), costheta);
}

float3 SphericalDirectionWithFrame(float sintheta, float costheta, float phi,
	const float3 x, const float3 y, const float3 z) {
	return sintheta * cos(phi) * x + sintheta * sin(phi) * y +
		costheta * z;
}
#line 2 "vector_funcs.cl"

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

float SphericalTheta(const float3 v) {
	return acos(clamp(v.z, -1.f, 1.f));
}

float SphericalPhi(const float3 v) {
	const float p = atan2(v.y, v.x);
	return (p < 0.f) ? p + 2.f * M_PI_F : p;
}

void CoordinateSystem(const float3 v1, float3 *v2, float3 *v3) {
	if (fabs(v1.x) > fabs(v1.y)) {
		float invLen = 1.f / sqrt(v1.x * v1.x + v1.z * v1.z);
		(*v2).x = -v1.z * invLen;
		(*v2).y = 0.f;
		(*v2).z = v1.x * invLen;
	} else {
		float invLen = 1.f / sqrt(v1.y * v1.y + v1.z * v1.z);
		(*v2).x = 0.f;
		(*v2).y = v1.z * invLen;
		(*v2).z = -v1.y * invLen;
	}

	*v3 = cross(v1, *v2);
}
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
#line 2 "specturm_funcs.cl"

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

bool Spectrum_IsEqual(const float3 a, const float3 b) {
	return all(isequal(a, b));
}

bool Spectrum_IsBlack(const float3 a) {
	return Spectrum_IsEqual(a, BLACK);
}

float Spectrum_Filter(const float3 s)  {
	return (s.s0 + s.s1 + s.s2) * 0.33333333f;
}

float Spectrum_Y(const float3 s) {
	return 0.212671f * s.s0 + 0.715160f * s.s1 + 0.072169f * s.s2;
}

float3 Spectrum_Clamp(const float3 s) {
	return clamp(s, BLACK, WHITE);
}

float3 Spectrum_Exp(const float3 s) {
	return (float3)(exp(s.x), exp(s.y), exp(s.z));
}

float3 Spectrum_Pow(const float3 s, const float e) {
	return (float3)(pow(s.x, e), pow(s.y, e), pow(s.z, e));
}

float3 Spectrum_Sqrt(const float3 s) {
	return (float3)(sqrt(s.x), sqrt(s.y), sqrt(s.z));
}
#line 2 "frame_funcs.cl"

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

void Frame_Set(__global Frame *frame, const float3 x, const float3 y, const float3 z)
{
	const float3 Y = normalize(cross(z, x));
	const float3 X = cross(Y, z);

	VSTORE3F(X, &frame->X.x);
	VSTORE3F(Y, &frame->Y.x);
	VSTORE3F(z, &frame->Z.x);
}

void Frame_Set_Private(Frame *frame, const float3 x, const float3 y, const float3 z)
{
	const float3 Y = normalize(cross(z, x));
	const float3 X = cross(Y, z);

	frame->X.x = X.x;
	frame->X.y = X.y;
	frame->X.z = X.z;
	frame->Y.x = Y.x;
	frame->Y.y = Y.y;
	frame->Y.z = Y.z;
	frame->Z.x = z.x;
	frame->Z.y = z.y;
	frame->Z.z = z.z;
}

void Frame_SetFromZ(__global Frame *frame, const float3 Z) {
	float3 X, Y;
	CoordinateSystem(Z, &X, &Y);

	VSTORE3F(X, &frame->X.x);
	VSTORE3F(Y, &frame->Y.x);
	VSTORE3F(Z, &frame->Z.x);
}

void Frame_SetFromZ_Private(Frame *frame, const float3 Z)
{
	float3 X, Y;
	CoordinateSystem(Z, &X, &Y);

	frame->X.x = X.x;
	frame->X.y = X.y;
	frame->X.z = X.z;
	frame->Y.x = Y.x;
	frame->Y.y = Y.y;
	frame->Y.z = Y.z;
	frame->Z.x = Z.x;
	frame->Z.y = Z.y;
	frame->Z.z = Z.z;
}

float3 ToWorld(const float3 X, const float3 Y, const float3 Z, const float3 v) {
	return X * v.x + Y * v.y + Z * v.z;
}

float3 ToLocal(const float3 X, const float3 Y, const float3 Z, const float3 a) {
	return (float3)(dot(a, X), dot(a, Y), dot(a, Z));
}

float3 Frame_ToWorld(__global const Frame* restrict frame, const float3 v) {
	return ToWorld(VLOAD3F(&frame->X.x), VLOAD3F(&frame->Y.x), VLOAD3F(&frame->Z.x), v);
}

float3 Frame_ToWorld_Private(const Frame *frame, const float3 v) {
	return ToWorld(
			(float3)(frame->X.x, frame->X.y, frame->X.z),
			(float3)(frame->Y.x, frame->Y.y, frame->Y.z),
			(float3)(frame->Z.x, frame->Z.y, frame->Z.z), v);
}

float3 Frame_ToLocal(__global const Frame* restrict frame, const float3 v) {
	return ToLocal(VLOAD3F(&frame->X.x), VLOAD3F(&frame->Y.x), VLOAD3F(&frame->Z.x), v);
}

float3 Frame_ToLocal_Private(const Frame *frame, const float3 v) {
	return ToLocal(
			(float3)(frame->X.x, frame->X.y, frame->X.z),
			(float3)(frame->Y.x, frame->Y.y, frame->Y.z),
			(float3)(frame->Z.x, frame->Z.y, frame->Z.z), v);
}
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
#line 2 "randomgen_types.cl"

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
	unsigned int s1, s2, s3;
} Seed;
#line 2 "trianglemesh_types.cl"

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
	// Vertex informaiton
	unsigned int vertsOffset;
	unsigned int normalsOffset;
	unsigned int uvsOffset;
	unsigned int colsOffset;
	unsigned int alphasOffset;

	// Triangle information
	unsigned int trisOffset;

	// Information used by MQBVH
	Transform trans;
} Mesh;
#line 2 "hitpoint_types.cl"

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

// This is defined only under OpenCL because of variable size structures
#if defined(SLG_OPENCL_KERNEL)

typedef struct {
	// The incoming direction. It is the eyeDir when fromLight = false and
	// lightDir when fromLight = true
	Vector fixedDir;
	Point p;
	UV uv;
	Normal geometryN;
	Normal shadeN;
#if defined(PARAM_HAS_BUMPMAPS)
	// Note: dpdu and dpdv are orthogonal to shading normal (i.e not geometry normal)
	Vector dpdu, dpdv;
	Normal dndu, dndv;
#endif

#if defined(PARAM_ENABLE_TEX_HITPOINTCOLOR) || defined(PARAM_ENABLE_TEX_HITPOINTGREY) || defined(PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR)
	Spectrum color;
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTALPHA)
	float alpha;
#endif

#if defined(PARAM_HAS_PASSTHROUGH)
	// passThroughEvent can be stored here in a path state even before of
	// BSDF initialization (while tracing the next path vertex ray)
	float passThroughEvent;
#endif

#if defined(PARAM_HAS_VOLUMES)
	// Interior and exterior volume (this includes volume priority system
	// computation and scene default world volume)
	unsigned int interiorVolumeIndex, exteriorVolumeIndex;
	// Material code (i.e. glass, etc.) doesn't have access to materials list
	// so I use HitPoint to carry texture index information
	unsigned int interiorIorTexIndex, exteriorIorTexIndex;
	int intoObject;
#endif
} HitPoint;

#endif
#line 2 "mapping_types.cl"

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

//------------------------------------------------------------------------------
// TextureMapping2D
//------------------------------------------------------------------------------

typedef enum {
	UVMAPPING2D
} TextureMapping2DType;

typedef struct {
    float uScale, vScale, uDelta, vDelta;
} UVMappingParam;


typedef struct {
	TextureMapping2DType type;
	union {
		UVMappingParam uvMapping2D;
	};
} TextureMapping2D;

//------------------------------------------------------------------------------
// TextureMapping3D
//------------------------------------------------------------------------------

typedef enum {
	UVMAPPING3D, GLOBALMAPPING3D
} TextureMapping3DType;

typedef struct {
	TextureMapping3DType type;
	Transform worldToLocal;
	//union {
		// UVMapping3D has no parameters
		// GlobalMapping3D has no parameters
	//};
} TextureMapping3D;
#line 2 "texture_types.cl"

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

#define DUDV_VALUE 0.001f

typedef enum {
	CONST_FLOAT, CONST_FLOAT3, IMAGEMAP, SCALE_TEX, FRESNEL_APPROX_N,
	FRESNEL_APPROX_K, MIX_TEX, ADD_TEX, SUBTRACT_TEX, HITPOINTCOLOR, HITPOINTALPHA,
	HITPOINTGREY, NORMALMAP_TEX, BLACKBODY_TEX, IRREGULARDATA_TEX,
	ABS_TEX, CLAMP_TEX,
	// Procedural textures
	BLENDER_BLEND, BLENDER_CLOUDS, BLENDER_DISTORTED_NOISE, BLENDER_MAGIC,
	BLENDER_MARBLE, BLENDER_MUSGRAVE, BLENDER_STUCCI, BLENDER_WOOD, BLENDER_VORONOI,
	CHECKERBOARD2D, CHECKERBOARD3D, CLOUD_TEX, FBM_TEX, MARBLE, DOTS, BRICK, WINDY, WRINKLED, UV_TEX, BAND_TEX,
	// Fresnel textures
	FRESNELCOLOR_TEX, FRESNELCONST_TEX
} TextureType;

typedef struct {
	float value;
} ConstFloatParam;

typedef struct {
	Spectrum color;
} ConstFloat3Param;

typedef struct {
	TextureMapping2D mapping;
	float gain;

	unsigned int imageMapIndex;
} ImageMapTexParam;

typedef struct {
	unsigned int tex1Index, tex2Index;
} ScaleTexParam;

typedef struct {
	unsigned int texIndex;
} FresnelApproxNTexParam;

typedef struct {
	unsigned int texIndex;
} FresnelApproxKTexParam;

typedef struct {
	unsigned int amountTexIndex, tex1Index, tex2Index;
} MixTexParam;

typedef struct {
	TextureMapping2D mapping;
	unsigned int tex1Index, tex2Index;
} CheckerBoard2DTexParam;

typedef struct {
	TextureMapping3D mapping;
	unsigned int tex1Index, tex2Index;
} CheckerBoard3DTexParam;

typedef struct {
	TextureMapping3D mapping;
	int octaves;
	float omega;
} FBMTexParam;

typedef struct {
	TextureMapping3D mapping;
	float radius;
	unsigned int numspheres;
	float spheresize;
	float sharpness;
	float basefadedistance;
	float baseflatness;
	float variability;
	float omega;
	float noisescale;
	float noiseoffset;
	float turbulence;
	int octaves;
//	CumulusSphere *spheres;
} CloudTexParam;


typedef struct {
	TextureMapping3D mapping;
	int octaves;
	float omega, scale, variation;
} MarbleTexParam;

typedef struct {
	TextureMapping2D mapping;
	unsigned int insideIndex, outsideIndex;
} DotsTexParam;

typedef enum {
	FLEMISH, RUNNING, ENGLISH, HERRINGBONE, BASKET, KETTING
} MasonryBond;

typedef struct {
	TextureMapping3D mapping;
	unsigned int tex1Index, tex2Index, tex3Index;
	MasonryBond bond;
	float offsetx, offsety, offsetz;
	float brickwidth, brickheight, brickdepth, mortarsize;
	float proportion, invproportion, run;
	float mortarwidth, mortarheight, mortardepth;
	float bevelwidth, bevelheight, beveldepth;
	int usebevel;
} BrickTexParam;

typedef struct {
	unsigned int tex1Index, tex2Index;
} AddTexParam;

typedef struct {
	TextureMapping3D mapping;
	int octaves;
	float omega;
} WindyTexParam;

typedef enum {
	ACTUAL_DISTANCE, DISTANCE_SQUARED, MANHATTAN, CHEBYCHEV, MINKOWSKI_HALF,
	MINKOWSKI_FOUR, MINKOWSKI
} DistanceMetric;

typedef enum {
	TEX_LIN, TEX_QUAD, TEX_EASE, TEX_DIAG, TEX_SPHERE, TEX_HALO, TEX_RAD
} ProgressionType;

typedef enum {
    BLENDER_ORIGINAL, ORIGINAL_PERLIN, IMPROVED_PERLIN,
    VORONOI_F1, VORONOI_F2, VORONOI_F3, VORONOI_F4, VORONOI_F2_F1,
    VORONOI_CRACKLE, CELL_NOISE
} BlenderNoiseBasis;

typedef enum {
	TEX_SIN, TEX_SAW, TEX_TRI
} BlenderNoiseBase;

typedef struct {
	TextureMapping3D mapping;
	ProgressionType type;
	bool direction;
	float bright, contrast;
} BlenderBlendTexParam;

typedef struct {
	TextureMapping3D mapping;
	BlenderNoiseBasis noisebasis;
	float noisesize;
	int noisedepth;
	float bright, contrast;
	bool hard;
} BlenderCloudsTexParam;

typedef struct {
	TextureMapping3D mapping;
	BlenderNoiseBasis noisedistortion;
	BlenderNoiseBasis noisebasis;
	float distortion;
	float noisesize;
	float bright, contrast;
} BlenderDistortedNoiseTexParam;

typedef struct {
	TextureMapping3D mapping;
	int noisedepth;
	float turbulence;
	float bright, contrast;
} BlenderMagicTexParam;

typedef enum {
	TEX_SOFT, TEX_SHARP, TEX_SHARPER
} BlenderMarbleType;

typedef struct {
	TextureMapping3D mapping;
	BlenderMarbleType type;
	BlenderNoiseBasis noisebasis;
	BlenderNoiseBase noisebasis2;
	float noisesize, turbulence;
	int noisedepth;
	float bright, contrast;
	bool hard;
} BlenderMarbleTexParam;

typedef enum {
	TEX_MULTIFRACTAL, TEX_RIDGED_MULTIFRACTAL, TEX_HYBRID_MULTIFRACTAL, TEX_FBM, TEX_HETERO_TERRAIN
} BlenderMusgraveType;

typedef struct {
	TextureMapping3D mapping;
	BlenderMusgraveType type;
	BlenderNoiseBasis noisebasis;
	float dimension;
	float intensity;
	float lacunarity;
	float offset;
	float gain;
	float octaves;
	float noisesize;
	float bright, contrast;
} BlenderMusgraveTexParam;

typedef struct {
	int noisedepth;
	float bright, contrast;
} BlenderNoiseTexParam;

typedef enum {
	TEX_PLASTIC, TEX_WALL_IN, TEX_WALL_OUT
} BlenderStucciType;

typedef struct {
	TextureMapping3D mapping;
	BlenderStucciType type;
	BlenderNoiseBasis noisebasis;
	float noisesize;
	float turbulence;
	float bright, contrast;
	bool hard;
} BlenderStucciTexParam;

typedef enum {
	BANDS, RINGS, BANDNOISE, RINGNOISE
} BlenderWoodType;

typedef struct {
	TextureMapping3D mapping;
	BlenderWoodType type;
	BlenderNoiseBase noisebasis2;
	BlenderNoiseBasis noisebasis;
	float noisesize, turbulence;
	float bright, contrast;
	int hard;
} BlenderWoodTexParam;

typedef struct {
 	TextureMapping3D mapping;
	DistanceMetric distancemetric;
	float feature_weight1;
	float feature_weight2;
	float feature_weight3;
	float feature_weight4;
	float noisesize;
	float intensity;
	float exponent;
 	float bright, contrast;
} BlenderVoronoiTexParam;

typedef struct {
	TextureMapping3D mapping;
	int octaves;
	float omega;
} WrinkledTexParam;

typedef struct {
	TextureMapping2D mapping;
} UVTexParam;

#define BAND_TEX_MAX_SIZE 16

typedef enum {
	INTERP_NONE,
	INTERP_LINEAR,
	INTERP_CUBIC
} InterpolationType;

typedef struct {
	InterpolationType interpType;
	unsigned int amountTexIndex;
	unsigned int size;
	float offsets[BAND_TEX_MAX_SIZE];
	Spectrum values[BAND_TEX_MAX_SIZE];
} BandTexParam;

typedef struct {
	unsigned int channel;
} HitPointGreyTexParam;

typedef struct {
	unsigned int texIndex;
} NormalMapTexParam;

typedef struct {
	Spectrum rgb;
} BlackBodyParam;

typedef struct {
	Spectrum rgb;
} IrregularDataParam;

typedef struct {
	unsigned int krIndex;
} FresnelColorParam;

typedef struct {
	Spectrum n, k;
} FresnelConstParam;

typedef struct {
	unsigned int texIndex;
} AbsTexParam;

typedef struct {
	unsigned int texIndex;
	float minVal, maxVal;
} ClampTexParam;

typedef struct {
	TextureType type;
	union {
		BlenderBlendTexParam blenderBlend;
 		BlenderCloudsTexParam blenderClouds;
		BlenderDistortedNoiseTexParam blenderDistortedNoise;
		BlenderMagicTexParam blenderMagic;
		BlenderMarbleTexParam blenderMarble;
		BlenderMusgraveTexParam blenderMusgrave;
		BlenderNoiseTexParam blenderNoise;
		BlenderStucciTexParam blenderStucci;
 		BlenderWoodTexParam blenderWood;
		BlenderVoronoiTexParam blenderVoronoi;
		ConstFloatParam constFloat;
		ConstFloat3Param constFloat3;
		ImageMapTexParam imageMapTex;
		ScaleTexParam scaleTex;
		FresnelApproxNTexParam fresnelApproxN;
		FresnelApproxKTexParam fresnelApproxK;
		MixTexParam mixTex;
		CheckerBoard2DTexParam checkerBoard2D;
		CheckerBoard3DTexParam checkerBoard3D;
		CloudTexParam cloud;
		FBMTexParam fbm;
		MarbleTexParam marble;
		DotsTexParam dots;
		BrickTexParam brick;
		AddTexParam addTex;
		AddTexParam subtractTex;
		WindyTexParam windy;
		WrinkledTexParam wrinkled;
		UVTexParam uvTex;
		BandTexParam band;
		HitPointGreyTexParam hitPointGrey;
        NormalMapTexParam normalMap;
		BlackBodyParam blackBody;
		IrregularDataParam irregularData;
		FresnelColorParam fresnelColor;
		FresnelConstParam fresnelConst;
		AbsTexParam absTex;
		ClampTexParam clampTex;
	};
} Texture;

//------------------------------------------------------------------------------
// Some macro trick in order to have more readable code
//------------------------------------------------------------------------------

#if defined(SLG_OPENCL_KERNEL)

#define TEXTURES_PARAM_DECL , __global const Texture* restrict texs IMAGEMAPS_PARAM_DECL
#define TEXTURES_PARAM , texs IMAGEMAPS_PARAM

#endif
#line 2 "bsdf_types.cl"

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

typedef enum {
	NONE = 0,
	DIFFUSE = 1,
	GLOSSY = 2,
	SPECULAR = 4,
	REFLECT = 8,
	TRANSMIT = 16,

	ALL_TYPES = DIFFUSE | GLOSSY | SPECULAR,
	ALL_REFLECT = REFLECT | ALL_TYPES,
	ALL_TRANSMIT = TRANSMIT | ALL_TYPES,
	ALL = ALL_REFLECT | ALL_TRANSMIT
} BSDFEventType;

typedef int BSDFEvent;

// This is defined only under OpenCL because of variable size structures
#if defined(SLG_OPENCL_KERNEL)

typedef struct {
	HitPoint hitPoint;

	unsigned int materialIndex;
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
	unsigned int triangleLightSourceIndex;
#endif

	Frame frame;

#if defined(PARAM_HAS_VOLUMES)
	int isVolume;
#endif
} BSDF;

#endif
#line 2 "material_types.cl"

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

typedef enum {
	MATTE, MIRROR, GLASS, ARCHGLASS, MIX, NULLMAT, MATTETRANSLUCENT,
	GLOSSY2, METAL2, ROUGHGLASS, VELVET, CLOTH, CARPAINT, ROUGHMATTE,
	ROUGHMATTETRANSLUCENT, GLOSSYTRANSLUCENT, GLOSSYCOATING,

	// Volumes
	HOMOGENEOUS_VOL, CLEAR_VOL, HETEROGENEOUS_VOL
} MaterialType;

typedef struct {
    unsigned int kdTexIndex;
} MatteParam;

typedef struct {
    unsigned int kdTexIndex;
    unsigned int sigmaTexIndex;
} RoughMatteParam;

typedef struct {
    unsigned int krTexIndex;
} MirrorParam;

typedef struct {
    unsigned int krTexIndex;
	unsigned int ktTexIndex;
	unsigned int exteriorIorTexIndex, interiorIorTexIndex;
} GlassParam;

typedef struct {
    unsigned int krTexIndex;
	unsigned int expTexIndex;
} MetalParam;

typedef struct {
    unsigned int krTexIndex;
	unsigned int ktTexIndex;
	unsigned int exteriorIorTexIndex, interiorIorTexIndex;
} ArchGlassParam;

typedef struct {
	unsigned int matAIndex, matBIndex;
	unsigned int mixFactorTexIndex;
} MixParam;

typedef struct {
    unsigned int krTexIndex;
	unsigned int ktTexIndex;
} MatteTranslucentParam;

typedef struct {
    unsigned int krTexIndex;
	unsigned int ktTexIndex;
	unsigned int sigmaTexIndex;
} RoughMatteTranslucentParam;

typedef struct {
	unsigned int kdTexIndex;
	unsigned int ksTexIndex;
	unsigned int nuTexIndex;
	unsigned int nvTexIndex;
	unsigned int kaTexIndex;
	unsigned int depthTexIndex;
	unsigned int indexTexIndex;
	int multibounce;
} Glossy2Param;

typedef struct {
    unsigned int fresnelTexIndex;
    unsigned int nTexIndex;
	unsigned int kTexIndex;
	unsigned int nuTexIndex;
	unsigned int nvTexIndex;
} Metal2Param;

typedef struct {
    unsigned int krTexIndex;
	unsigned int ktTexIndex;
	unsigned int exteriorIorTexIndex, interiorIorTexIndex;
	unsigned int nuTexIndex;
	unsigned int nvTexIndex;
} RoughGlassParam;

typedef struct {
    unsigned int kdTexIndex;
	unsigned int p1TexIndex;
	unsigned int p2TexIndex;
	unsigned int p3TexIndex;
	unsigned int thicknessTexIndex;
} VelvetParam;

typedef enum {
	DENIM, SILKSHANTUNG, SILKCHARMEUSE, COTTONTWILL, WOOLGARBARDINE, POLYESTER
} ClothPreset;

typedef enum {
	WARP, WEFT
} YarnType;

// Data structure describing the properties of a single yarn
typedef struct {
	// Fiber twist angle
	float psi;
	// Maximum inclination angle
	float umax;
	// Spine curvature
	float kappa;
	// Width of segment rectangle
	float width;
	// Length of segment rectangle
	float length;
	/*! u coordinate of the yarn segment center,
	 * assumes that the tile covers 0 <= u, v <= 1.
	 * (0, 0) is lower left corner of the weave pattern
	 */
	float centerU;
	// v coordinate of the yarn segment center
	float centerV;

	// Weft/Warp flag
	YarnType yarn_type;
} Yarn;

typedef struct  {
	// Size of the weave pattern
	unsigned int tileWidth, tileHeight;

	// Uniform scattering parameter
	float alpha;
	// Forward scattering parameter
	float beta;
	// Filament smoothing
	float ss;
	// Highlight width
	float hWidth;
	// Combined area taken up by the warp & weft
	float warpArea, weftArea;

	// Noise-related parameters
	float fineness;

	float dWarpUmaxOverDWarp;
	float dWarpUmaxOverDWeft;
	float dWeftUmaxOverDWarp;
	float dWeftUmaxOverDWeft;
	float period;
} WeaveConfig;

typedef struct {
    ClothPreset Preset;
	unsigned int Weft_KdIndex;
	unsigned int Weft_KsIndex;
	unsigned int Warp_KdIndex;
	unsigned int Warp_KsIndex;
	float Repeat_U;
	float Repeat_V;
	float specularNormalization;
} ClothParam;

typedef struct {
	unsigned int KdTexIndex;
	unsigned int Ks1TexIndex;
	unsigned int Ks2TexIndex;
	unsigned int Ks3TexIndex;
	unsigned int M1TexIndex;
	unsigned int M2TexIndex;
	unsigned int M3TexIndex;
	unsigned int R1TexIndex;
	unsigned int R2TexIndex;
	unsigned int R3TexIndex;
	unsigned int KaTexIndex;
	unsigned int depthTexIndex;
} CarPaintParam;

typedef struct {
	unsigned int kdTexIndex;
	unsigned int ktTexIndex;
	unsigned int ksTexIndex;
	unsigned int ksbfTexIndex;
	unsigned int nuTexIndex;
	unsigned int nubfTexIndex;
	unsigned int nvTexIndex;
	unsigned int nvbfTexIndex;
	unsigned int kaTexIndex;
	unsigned int kabfTexIndex;
	unsigned int depthTexIndex;
	unsigned int depthbfTexIndex;
	unsigned int indexTexIndex;
	unsigned int indexbfTexIndex;
	int multibounce;
	int multibouncebf;
} GlossyTranslucentParam;

typedef struct {
	unsigned int matBaseIndex;
	unsigned int ksTexIndex;
	unsigned int nuTexIndex;
	unsigned int nvTexIndex;
	unsigned int kaTexIndex;
	unsigned int depthTexIndex;
	unsigned int indexTexIndex;
	int multibounce;
} GlossyCoatingParam;

typedef struct {
	unsigned int sigmaATexIndex;
} ClearVolumeParam;

typedef struct {
	unsigned int sigmaATexIndex;
	unsigned int sigmaSTexIndex;
	unsigned int gTexIndex;
	int multiScattering;
} HomogenousVolumeParam;

typedef struct {
	unsigned int sigmaATexIndex;
	unsigned int sigmaSTexIndex;
	unsigned int gTexIndex;
	float stepSize;
	unsigned int maxStepsCount;
	int multiScattering;
} HeterogenousVolumeParam;

typedef struct {
	unsigned int iorTexIndex;
	// This is a different kind of emission texture from the one in
	// Material class (i.e. is not sampled by direct light).
	unsigned int volumeEmissionTexIndex;
	unsigned int volumeLightID;
	int priority;

	union {
		ClearVolumeParam clear;
		HomogenousVolumeParam homogenous;
		HeterogenousVolumeParam heterogenous;
	};
} VolumeParam;

typedef struct {
	MaterialType type;
	unsigned int matID, lightID;
	float bumpSampleDistance;
	Spectrum emittedFactor;
	int usePrimitiveArea;
	unsigned int emitTexIndex, bumpTexIndex;
	int samples;
	// Type of indirect paths where a light source is visible with a direct hit. It is
	// an OR of DIFFUSE, GLOSSY and SPECULAR.
	BSDFEvent visibility;
	unsigned int interiorVolumeIndex, exteriorVolumeIndex;

	union {
		MatteParam matte;
		RoughMatteParam roughmatte;
		MirrorParam mirror;
		GlassParam glass;
		MetalParam metal;
		ArchGlassParam archglass;
		MixParam mix;
		// NULLMAT has no parameters
		MatteTranslucentParam matteTranslucent;
		RoughMatteTranslucentParam roughmatteTranslucent;
		Glossy2Param glossy2;
		Metal2Param metal2;
		RoughGlassParam roughglass;
		VelvetParam velvet;
        	ClothParam cloth;
		CarPaintParam carpaint;
		GlossyTranslucentParam glossytranslucent;
		GlossyCoatingParam glossycoating;
		VolumeParam volume;
	};
} Material;

//------------------------------------------------------------------------------
// Some macro trick in order to have more readable code
//------------------------------------------------------------------------------

#if defined(SLG_OPENCL_KERNEL)

#define MATERIALS_PARAM_DECL , __global const Material* restrict mats TEXTURES_PARAM_DECL
#define MATERIALS_PARAM , mats TEXTURES_PARAM

#endif
#line 2 "volume_types.cl"

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

// NOTE: check VolumeParam in material_type.cl for volume definitions

#define OPENCL_PATHVOLUMEINFO_SIZE 8

typedef struct {
	unsigned int currentVolumeIndex;
	unsigned int volumeIndexList[OPENCL_PATHVOLUMEINFO_SIZE];
	unsigned int volumeIndexListSize;

	int scatteredStart;
} PathVolumeInfo;

typedef Material Volume;
#line 2 "film_types.cl"

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

//------------------------------------------------------------------------------
// SampleResult
//------------------------------------------------------------------------------

#if defined(SLG_OPENCL_KERNEL)

typedef struct {
	float filmX, filmY;
	Spectrum radiancePerPixelNormalized[PARAM_FILM_RADIANCE_GROUP_COUNT];
#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
	float alpha;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
	float depth;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
	Point position;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
	Normal geometryNormal;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
	Normal shadingNormal;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
	// Note: MATERIAL_ID_MASK and BY_MATERIAL_ID are calculated starting from materialID field
	uint materialID;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
	Spectrum directDiffuse;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
	Spectrum directGlossy;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
	Spectrum emission;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
	Spectrum indirectDiffuse;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
	Spectrum indirectGlossy;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
	Spectrum indirectSpecular;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
	float directShadowMask;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
	float indirectShadowMask;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
	UV uv;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
	float rayCount;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
	Spectrum irradiance, irradiancePathThroughput;
#endif

	BSDFEvent firstPathVertexEvent;
	int firstPathVertex, lastPathVertex;
} SampleResult;

#endif

//------------------------------------------------------------------------------
// Some macro trick in order to have more readable code
//------------------------------------------------------------------------------

#if defined(SLG_OPENCL_KERNEL)

#define FILM_RADIANCE_GROUP_PARAM_DECL , __global float **filmRadianceGroup
#define FILM_RADIANCE_GROUP_PARAM , filmRadianceGroup

#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
#define FILM_ALPHA_PARAM_DECL , __global float *filmAlpha
#define FILM_ALPHA_PARAM , filmAlpha
#else
#define FILM_ALPHA_PARAM_DECL
#define FILM_ALPHA_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
#define FILM_DEPTH_PARAM_DECL , __global float *filmDepth
#define FILM_DEPTH_PARAM , filmDepth
#else
#define FILM_DEPTH_PARAM_DECL
#define FILM_DEPTH_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
#define FILM_POSITION_PARAM_DECL , __global float *filmPosition
#define FILM_POSITION_PARAM , filmPosition
#else
#define FILM_POSITION_PARAM_DECL
#define FILM_POSITION_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
#define FILM_GEOMETRY_NORMAL_PARAM_DECL , __global float *filmGeometryNormal
#define FILM_GEOMETRY_NORMAL_PARAM , filmGeometryNormal
#else
#define FILM_GEOMETRY_NORMAL_PARAM_DECL
#define FILM_GEOMETRY_NORMAL_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
#define FILM_SHADING_NORMAL_PARAM_DECL , __global float *filmShadingNormal
#define FILM_SHADING_NORMAL_PARAM , filmShadingNormal
#else
#define FILM_SHADING_NORMAL_PARAM_DECL
#define FILM_SHADING_NORMAL_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
#define FILM_MATERIAL_ID_PARAM_DECL , __global uint *filmMaterialID
#define FILM_MATERIAL_ID_PARAM , filmMaterialID
#else
#define FILM_MATERIAL_ID_PARAM_DECL
#define FILM_MATERIAL_ID_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
#define FILM_DIRECT_DIFFUSE_PARAM_DECL , __global float *filmDirectDiffuse
#define FILM_DIRECT_DIFFUSE_PARAM , filmDirectDiffuse
#else
#define FILM_DIRECT_DIFFUSE_PARAM_DECL
#define FILM_DIRECT_DIFFUSE_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
#define FILM_DIRECT_GLOSSY_PARAM_DECL , __global float *filmDirectGlossy
#define FILM_DIRECT_GLOSSY_PARAM , filmDirectGlossy
#else
#define FILM_DIRECT_GLOSSY_PARAM_DECL
#define FILM_DIRECT_GLOSSY_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
#define FILM_EMISSION_PARAM_DECL , __global float *filmEmission
#define FILM_EMISSION_PARAM , filmEmission
#else
#define FILM_EMISSION_PARAM_DECL
#define FILM_EMISSION_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
#define FILM_INDIRECT_DIFFUSE_PARAM_DECL , __global float *filmIndirectDiffuse
#define FILM_INDIRECT_DIFFUSE_PARAM , filmIndirectDiffuse
#else
#define FILM_INDIRECT_DIFFUSE_PARAM_DECL
#define FILM_INDIRECT_DIFFUSE_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
#define FILM_INDIRECT_GLOSSY_PARAM_DECL , __global float *filmIndirectGlossy
#define FILM_INDIRECT_GLOSSY_PARAM , filmIndirectGlossy
#else
#define FILM_INDIRECT_GLOSSY_PARAM_DECL
#define FILM_INDIRECT_GLOSSY_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
#define FILM_INDIRECT_SPECULAR_PARAM_DECL , __global float *filmIndirectSpecular
#define FILM_INDIRECT_SPECULAR_PARAM , filmIndirectSpecular
#else
#define FILM_INDIRECT_SPECULAR_PARAM_DECL
#define FILM_INDIRECT_SPECULAR_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID_MASK)
#define FILM_MATERIAL_ID_MASK_PARAM_DECL , __global float *filmMaterialIDMask
#define FILM_MATERIAL_ID_MASK_PARAM , filmMaterialIDMask
#else
#define FILM_MATERIAL_ID_MASK_PARAM_DECL
#define FILM_MATERIAL_ID_MASK_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
#define FILM_DIRECT_SHADOW_MASK_PARAM_DECL , __global float *filmDirectShadowMask
#define FILM_DIRECT_SHADOW_MASK_PARAM , filmDirectShadowMask
#else
#define FILM_DIRECT_SHADOW_MASK_PARAM_DECL
#define FILM_DIRECT_SHADOW_MASK_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
#define FILM_INDIRECT_SHADOW_MASK_PARAM_DECL , __global float *filmIndirectShadowMask
#define FILM_INDIRECT_SHADOW_MASK_PARAM , filmIndirectShadowMask
#else
#define FILM_INDIRECT_SHADOW_MASK_PARAM_DECL
#define FILM_INDIRECT_SHADOW_MASK_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
#define FILM_UV_PARAM_DECL , __global float *filmUV
#define FILM_UV_PARAM , filmUV
#else
#define FILM_UV_PARAM_DECL
#define FILM_UV_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
#define FILM_RAYCOUNT_PARAM_DECL , __global float *filmRayCount
#define FILM_RAYCOUNT_PARAM , filmRayCount
#else
#define FILM_RAYCOUNT_PARAM_DECL
#define FILM_RAYCOUNT_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_BY_MATERIAL_ID)
#define FILM_BY_MATERIAL_ID_PARAM_DECL , __global float *filmByMaterialID
#define FILM_BY_MATERIAL_ID_PARAM , filmByMaterialID
#else
#define FILM_BY_MATERIAL_ID_PARAM_DECL
#define FILM_BY_MATERIAL_ID_PARAM
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
#define FILM_IRRADIANCE_PARAM_DECL , __global float *filmIrradiance
#define FILM_IRRADIANCE_PARAM , filmIrradiance
#else
#define FILM_IRRADIANCE_PARAM_DECL
#define FILM_IRRADIANCE_PARAM
#endif

#define FILM_PARAM_DECL , const uint filmWidth, const uint filmHeight FILM_RADIANCE_GROUP_PARAM_DECL FILM_ALPHA_PARAM_DECL FILM_DEPTH_PARAM_DECL FILM_POSITION_PARAM_DECL FILM_GEOMETRY_NORMAL_PARAM_DECL FILM_SHADING_NORMAL_PARAM_DECL FILM_MATERIAL_ID_PARAM_DECL FILM_DIRECT_DIFFUSE_PARAM_DECL FILM_DIRECT_GLOSSY_PARAM_DECL FILM_EMISSION_PARAM_DECL FILM_INDIRECT_DIFFUSE_PARAM_DECL FILM_INDIRECT_GLOSSY_PARAM_DECL FILM_INDIRECT_SPECULAR_PARAM_DECL FILM_MATERIAL_ID_MASK_PARAM_DECL FILM_DIRECT_SHADOW_MASK_PARAM_DECL FILM_INDIRECT_SHADOW_MASK_PARAM_DECL FILM_UV_PARAM_DECL FILM_RAYCOUNT_PARAM_DECL FILM_BY_MATERIAL_ID_PARAM_DECL FILM_IRRADIANCE_PARAM_DECL
#define FILM_PARAM , filmWidth, filmHeight FILM_RADIANCE_GROUP_PARAM FILM_ALPHA_PARAM FILM_DEPTH_PARAM FILM_POSITION_PARAM FILM_GEOMETRY_NORMAL_PARAM FILM_SHADING_NORMAL_PARAM FILM_MATERIAL_ID_PARAM FILM_DIRECT_DIFFUSE_PARAM FILM_DIRECT_GLOSSY_PARAM FILM_EMISSION_PARAM FILM_INDIRECT_DIFFUSE_PARAM FILM_INDIRECT_GLOSSY_PARAM FILM_INDIRECT_SPECULAR_PARAM FILM_MATERIAL_ID_MASK_PARAM FILM_DIRECT_SHADOW_MASK_PARAM FILM_INDIRECT_SHADOW_MASK_PARAM FILM_UV_PARAM FILM_RAYCOUNT_PARAM FILM_BY_MATERIAL_ID_PARAM FILM_IRRADIANCE_PARAM

#endif
#line 2 "filter_types.cl"

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

//------------------------------------------------------------------------------
// Frame buffer data types
//------------------------------------------------------------------------------

typedef struct {
	Spectrum c;
	float count;
} Pixel;

typedef struct {
	float alpha;
} AlphaPixel;

//------------------------------------------------------------------------------
// Filter data types
//------------------------------------------------------------------------------

typedef enum {
	FILTER_NONE, FILTER_BOX, FILTER_GAUSSIAN, FILTER_MITCHELL, FILTER_BLACKMANHARRIS
} FilterType;

typedef struct {
	FilterType type;

	union {
		// Nothing to store for NONE filter
		struct {
			float widthX, widthY;
		} box;
		struct {
			float widthX, widthY;
			float alpha;
		} gaussian;
		struct {
			float widthX, widthY;
			float B, C;
		} mitchell;
		struct {
			float widthX, widthY;
		} blackmanharris;
	};
} Filter;
#line 2 "sampler_types.cl"

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

//------------------------------------------------------------------------------
// Indices of Sample related u[] array
//------------------------------------------------------------------------------

#if defined(SLG_OPENCL_KERNEL)

#define IDX_SCREEN_X 0
#define IDX_SCREEN_Y 1
#define IDX_EYE_TIME 2
#if defined(PARAM_CAMERA_HAS_DOF) && defined(PARAM_HAS_PASSTHROUGH)
#define IDX_EYE_PASSTHROUGH 3
#define IDX_DOF_X 4
#define IDX_DOF_Y 5
#define IDX_BSDF_OFFSET 6
#elif defined(PARAM_CAMERA_HAS_DOF)
#define IDX_DOF_X 3
#define IDX_DOF_Y 4
#define IDX_BSDF_OFFSET 5
#elif defined(PARAM_HAS_PASSTHROUGH)
#define IDX_EYE_PASSTHROUGH 3
#define IDX_BSDF_OFFSET 4
#else
#define IDX_BSDF_OFFSET 3
#endif

// Relative to IDX_BSDF_OFFSET + PathDepth * VERTEX_SAMPLE_SIZE
#if defined(PARAM_HAS_PASSTHROUGH)

#define IDX_PASSTHROUGH 0
#define IDX_BSDF_X 1
#define IDX_BSDF_Y 2
#define IDX_DIRECTLIGHT_X 3
#define IDX_DIRECTLIGHT_Y 4
#define IDX_DIRECTLIGHT_Z 5
#define IDX_DIRECTLIGHT_W 6
#define IDX_DIRECTLIGHT_A 7
#define IDX_RR 8

#define VERTEX_SAMPLE_SIZE 9

#else

#define IDX_BSDF_X 0
#define IDX_BSDF_Y 1
#define IDX_DIRECTLIGHT_X 2
#define IDX_DIRECTLIGHT_Y 3
#define IDX_DIRECTLIGHT_Z 4
#define IDX_DIRECTLIGHT_W 5
#define IDX_RR 6

#define VERTEX_SAMPLE_SIZE 7
#endif

#if (PARAM_SAMPLER_TYPE == 0) || (PARAM_SAMPLER_TYPE == 2)
#define TOTAL_U_SIZE 2
#endif

#if (PARAM_SAMPLER_TYPE == 1)
#define TOTAL_U_SIZE (IDX_BSDF_OFFSET + PARAM_MAX_PATH_DEPTH * VERTEX_SAMPLE_SIZE)
#endif

#endif

//------------------------------------------------------------------------------
// Sample data types
//------------------------------------------------------------------------------

// This is defined only under OpenCL because of variable size structures
#if defined(SLG_OPENCL_KERNEL)

typedef struct {
	SampleResult result;
} RandomSample;

typedef struct {
	SampleResult result;

	float totalI;

	// Using ushort here totally freeze the ATI driver
	unsigned int largeMutationCount, smallMutationCount;
	unsigned int current, proposed, consecutiveRejects;

	float weight;
	SampleResult currentResult;
} MetropolisSample;

typedef struct {
	unsigned int pass;

	SampleResult result;
} SobolSample;

#if (PARAM_SAMPLER_TYPE == 0)
typedef RandomSample Sample;
#endif

#if (PARAM_SAMPLER_TYPE == 1)
typedef MetropolisSample Sample;
#endif

#if (PARAM_SAMPLER_TYPE == 2)
typedef SobolSample Sample;
#endif

#endif

//------------------------------------------------------------------------------
// Sampler data types
//------------------------------------------------------------------------------

typedef enum {
	RANDOM = 0,
	METROPOLIS = 1,
	SOBOL = 2
} SamplerType;

typedef struct {
	SamplerType type;
	union {
		struct {
			float largeMutationProbability, imageMutationRange;
			unsigned int maxRejects;
		} metropolis;
	};
} Sampler;

#define SOBOL_BITS 32
#define SOBOL_MAX_DIMENSIONS 21201
#line 2 "camera_types.cl"

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

#define CAMERA_MAX_INTERPOLATED_TRANSFORM 8

typedef enum {
	PERSPECTIVE, ORTHOGRAPHIC, STEREO
} CameraType;

typedef struct {
	// Placed here for Transform memory alignment
	Transform rasterToCamera;
	Transform cameraToWorld;

	float yon, hither;
	float shutterOpen, shutterClose;

	// Used for camera motion blur
	MotionSystem motionSystem;
	InterpolatedTransform interpolatedTransforms[CAMERA_MAX_INTERPOLATED_TRANSFORM];
} CameraBase;

typedef struct {
	// Used for camera clipping plane
	Point clippingPlaneCenter;
	Normal clippingPlaneNormal;
	// Note: preprocessor macro PARAM_CAMERA_ENABLE_CLIPPING_PLANE set if to use
	// the user defined clipping plane

	float lensRadius;
	float focalDistance;
} ProjectiveCamera;

typedef struct {
	ProjectiveCamera projCamera;

	float screenOffsetX, screenOffsetY;
	float fieldOfView;
	// Note: preprocessor macro PARAM_CAMERA_ENABLE_OCULUSRIFT_BARREL set if to use
	// Oculus Rift barrel effect
} PerspectiveCamera;

typedef struct {
	ProjectiveCamera projCamera;
} OrthographicCamera;

typedef struct {
	PerspectiveCamera perspCamera;

	Transform leftEyeRasterToCamera;
	Transform leftEyeCameraToWorld;

	Transform rightEyeRasterToCamera;
	Transform rightEyeCameraToWorld;
} StereoCamera;

typedef struct {
	// The type of camera in use is defined by preprocessor macro:
	//  PARAM_CAMERA_TYPE (0 = Perspective, 1 = Orthographic, 2 = Stereo)

	CameraBase base;

	union {
		PerspectiveCamera persp;
		OrthographicCamera ortho;
		StereoCamera stereo;
	};
} Camera;
#line 2 "light_types.cl"

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

typedef enum {
	TYPE_IL, TYPE_IL_SKY, TYPE_SUN, TYPE_TRIANGLE, TYPE_POINT, TYPE_MAPPOINT,
	TYPE_SPOT, TYPE_PROJECTION, TYPE_IL_CONSTANT, TYPE_SHARPDISTANT, TYPE_DISTANT,
	TYPE_IL_SKY2, TYPE_LASER,
	LIGHT_SOURCE_TYPE_COUNT
} LightSourceType;

typedef struct {
	TextureMapping2D mapping;
	unsigned int imageMapIndex;
	unsigned int distributionOffset;
} InfiniteLightParam;

typedef struct {
	float absoluteTheta;
	float absolutePhi;
	float zenith_Y, zenith_x, zenith_y;
	float perez_Y[6], perez_x[6], perez_y[6];
} SkyLightParam;

typedef struct {
	Vector absoluteSunDir;
	Spectrum aTerm, bTerm, cTerm, dTerm, eTerm, fTerm,
		gTerm, hTerm, iTerm, radianceTerm;
} SkyLight2Param;

typedef struct {
	Vector absoluteDir;
	float turbidity, relSize;
	// XY Vectors for cone sampling
	Vector x, y;
	float cosThetaMax, sin2ThetaMax;
	Spectrum color;
} SunLightParam;

typedef struct {
	Vector absolutePos;
	Spectrum emittedFactor;
} PointLightParam;

typedef struct {
	Vector absolutePos, localPos;
	Spectrum emittedFactor;
	float avarage;
	unsigned int imageMapIndex;
} MapPointLightParam;

typedef struct {
	Vector absolutePos;
	Spectrum emittedFactor;
	float cosTotalWidth, cosFalloffStart;
} SpotLightParam;

typedef struct {
	Vector absolutePos, lightNormal;
	Spectrum emittedFactor;
	Matrix4x4 lightProjection;
	float screenX0, screenX1, screenY0, screenY1;
	unsigned int imageMapIndex;
} ProjectionLightParam;

typedef struct {
	Spectrum color;
} ConstantInfiniteLightParam;

typedef struct {
	Spectrum color;
	Vector absoluteLightDir;
} SharpDistantLightParam;

typedef struct {
	Spectrum color;
	Vector absoluteLightDir, x, y;
	float cosThetaMax;
} DistantLightParam;

typedef struct {
	Vector absoluteLightPos, absoluteLightDir;
	Spectrum emittedFactor;
	float radius;
} LaserLightParam;

typedef struct {
	Transform light2World;
	Spectrum gain;

	union {
		SunLightParam sun;
		SkyLightParam sky;
		SkyLight2Param sky2;
		InfiniteLightParam infinite;
		PointLightParam point;
		MapPointLightParam mapPoint;
		SpotLightParam spot;
		ProjectionLightParam projection;
		ConstantInfiniteLightParam constantInfinite;
		SharpDistantLightParam sharpDistant;
		DistantLightParam distant;
		LaserLightParam laser;
	};
} NotIntersectableLightSource;

typedef struct {
	Vector v0, v1, v2;
	UV uv0, uv1, uv2;
	Spectrum rgb0, rgb1, rgb2;
	float invTriangleArea, invMeshArea;

	unsigned int materialIndex;
	unsigned int lightSceneIndex;

	// Used for image map and/or IES map
	float avarage;
	unsigned int imageMapIndex;
} TriangleLightParam;

typedef struct {
	LightSourceType type;
	unsigned int lightSceneIndex;
	unsigned int lightID;
	int samples;
	// Type of indirect paths where a light source is visible with a direct hit. It is
	// an OR of DIFFUSE, GLOSSY and SPECULAR.
	BSDFEvent visibility;

	union {
		NotIntersectableLightSource notIntersectable;
		TriangleLightParam triangle;
	};
} LightSource;


//------------------------------------------------------------------------------
// Some macro trick in order to have more readable code
//------------------------------------------------------------------------------

#if defined(SLG_OPENCL_KERNEL)

#if defined(PARAM_HAS_INFINITELIGHT)
#define LIGHTS_PARAM_DECL , __global const LightSource* restrict lights, __global const uint* restrict envLightIndices, const uint envLightCount, __global const uint* restrict meshTriLightDefsOffset, __global const float* restrict infiniteLightDistribution, __global const float* restrict lightsDistribution MATERIALS_PARAM_DECL
#define LIGHTS_PARAM , lights, envLightIndices, envLightCount, meshTriLightDefsOffset, infiniteLightDistribution, lightsDistribution MATERIALS_PARAM
#elif defined(PARAM_HAS_ENVLIGHTS)
#define LIGHTS_PARAM_DECL , __global  const LightSource* restrict lights, __global const uint* restrict envLightIndices, const uint envLightCount, __global const uint* restrict meshTriLightDefsOffset, __global const float* restrict lightsDistribution MATERIALS_PARAM_DECL
#define LIGHTS_PARAM , lights, envLightIndices, envLightCount, meshTriLightDefsOffset, lightsDistribution MATERIALS_PARAM
#else
#define LIGHTS_PARAM_DECL , __global const LightSource* restrict lights, __global const uint* restrict meshTriLightDefsOffset, __global const float* restrict lightsDistribution MATERIALS_PARAM_DECL
#define LIGHTS_PARAM , lights, meshTriLightDefsOffset, lightsDistribution MATERIALS_PARAM
#endif

#endif
#line 2 "mc_funcs.cl"

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

void ConcentricSampleDisk(const float u0, const float u1, float *dx, float *dy) {
	float r, theta;
	// Map uniform random numbers to $[-1,1]^2$
	const float sx = 2.f * u0 - 1.f;
	const float sy = 2.f * u1 - 1.f;
	// Map square to $(r,\theta)$
	// Handle degeneracy at the origin
	if (sx == 0.f && sy == 0.f) {
		*dx = 0.f;
		*dy = 0.f;
		return;
	}
	if (sx >= -sy) {
		if (sx > sy) {
			// Handle first region of disk
			r = sx;
			if (sy > 0.f)
				theta = sy / r;
			else
				theta = 8.f + sy / r;
		} else {
			// Handle second region of disk
			r = sy;
			theta = 2.f - sx / r;
		}
	} else {
		if (sx <= sy) {
			// Handle third region of disk
			r = -sx;
			theta = 4.f - sy / r;
		} else {
			// Handle fourth region of disk
			r = -sy;
			theta = 6.f + sx / r;
		}
	}
	theta *= M_PI_F / 4.f;
	*dx = r * cos(theta);
	*dy = r * sin(theta);
}

float3 CosineSampleHemisphere(const float u0, const float u1) {
	float x, y;
	ConcentricSampleDisk(u0, u1, &x, &y);

	const float z = sqrt(fmax(0.f, 1.f - x * x - y * y));

	return (float3)(x, y, z);
}

float3 CosineSampleHemisphereWithPdf(const float u0, const float u1, float *pdfW) {
	float x, y;
	ConcentricSampleDisk(u0, u1, &x, &y);

	const float z = sqrt(fmax(0.f, 1.f - x * x - y * y));

	*pdfW = z * M_1_PI_F;

	return (float3)(x, y, z);
}

float3 UniformSampleSphere(const float u1, const float u2) {
	float z = 1.f - 2.f * u1;
	float r = sqrt(max(0.f, 1.f - z * z));
	float phi = 2.f * M_PI_F * u2;
	float x = r * cos(phi);
	float y = r * sin(phi);

	return (float3)(x, y, z);
}

float3 UniformSampleCone(const float u0, const float u1, const float costhetamax,
	const float3 x, const float3 y, const float3 z) {
	const float costheta = mix(1.f, costhetamax, u0);
	const float u0x = (1.f - costhetamax) * u0;
	const float sintheta = sqrt(u0x * (2.f - u0x));
	const float phi = u1 * 2.f * M_PI_F;

	const float kx = cos(phi) * sintheta;
	const float ky = sin(phi) * sintheta;
	const float kz = costheta;

	return (float3)(kx * x.x + ky * y.x + kz * z.x,
			kx * x.y + ky * y.y + kz * z.y,
			kx * x.z + ky * y.z + kz * z.z);
}

float UniformConePdf(const float costhetamax) {
	return 1.f / (2.f * M_PI_F * (1.f - costhetamax));
}

float PowerHeuristic(const float fPdf, const float gPdf) {
	const float f = fPdf;
	const float g = gPdf;

	return (f * f) / (f * f + g * g);
}

float PdfWtoA(const float pdfW, const float dist, const float cosThere) {
    return pdfW * fabs(cosThere) / (dist * dist);
}

float PdfAtoW(const float pdfA, const float dist, const float cosThere) {
    return pdfA * dist * dist / fabs(cosThere);
}

//------------------------------------------------------------------------------
// Distribution1D
//------------------------------------------------------------------------------

// Implementation of std::upper_bound()
__global const float *std_upper_bound(__global const float* restrict first,
		__global const float* restrict last, const float val) {
	__global const float* restrict it;
	uint count = last - first;
	uint step;

	while (count > 0) {
		it = first;
		step = count / 2;
		it += step;

		if (!(val < *it)) {
			first = ++it;
			count -= step + 1;
		} else
			count = step;
	}

	return first;
}

//__global const float *std_upper_bound(__global const float* restrict first, __global const float* restrict last, const float val) {
//	__global const float *it = first;
//
//	while ((it <= last) && (*it <= val)) {
//		it++;
//	}
//
//	return it;
//}

float Distribution1D_SampleContinuous(__global const float* restrict distribution1D, const float u,
		float *pdf, uint *off) {
	const uint count = as_uint(distribution1D[0]);
	__global const float* restrict func = &distribution1D[1];
	__global const float* restrict cdf = &distribution1D[1 + count];

	// Find surrounding CDF segments and _offset_
	if (u <= cdf[0]) {
		*pdf = func[0];
		if (off)
			*off = 0;
		return 0.f;
	}
	if (u >= cdf[count]) {
		*pdf = func[count - 1];
		if (off)
			*off = count - 1;
		return 1.f;
	}

	__global const float* restrict ptr = std_upper_bound(cdf, cdf + count + 1, u);
	const uint offset = ptr - cdf - 1;

	// Compute offset along CDF segment
	const float du = (u - cdf[offset]) /
			(cdf[offset + 1] - cdf[offset]);

	// Compute PDF for sampled offset
	*pdf = func[offset];

	// Save offset
	if (off)
		*off = offset;

	return (offset + du) / count;
}

uint Distribution1D_SampleDiscrete(__global const float *distribution1D, const float u, float *pdf) {
	const uint count = as_uint(distribution1D[0]);
	__global const float* restrict func = &distribution1D[1];
	__global const float* restrict cdf = &distribution1D[1 + count];

	// Find surrounding CDF segments and _offset_
	if (u <= cdf[0]) {
		*pdf = func[0] / count;
		return 0;
	}
	if (u >= cdf[count]) {
		*pdf = func[count - 1] / count;
		return count - 1;
	}

	__global const float* restrict ptr = std_upper_bound(cdf, cdf + count + 1, u);
	const uint offset = ptr - cdf - 1;

	// Compute PDF for sampled offset
	*pdf = func[offset] / count;

	return offset;
}

uint Distribution1D_Offset(__global const float* restrict distribution1D, const float u) {
	const uint count = as_uint(distribution1D[0]);

	return min(count - 1, Floor2UInt(u * count));
}

float Distribution1D_Pdf_UINT(__global const float* restrict distribution1D, const uint offset) {
	const uint count = as_uint(distribution1D[0]);
	__global const float* restrict func = &distribution1D[1];

	return func[offset] / count;
}

float Distribution1D_Pdf_FLOAT(__global const float* restrict distribution1D, const float u) {
	const uint count = as_uint(distribution1D[0]);
	__global const float* restrict func = &distribution1D[1];

	return func[Distribution1D_Offset(distribution1D, u)];
}

//------------------------------------------------------------------------------
// Distribution2D
//------------------------------------------------------------------------------

void Distribution2D_SampleContinuous(__global const float* restrict distribution2D,
		const float u0, const float u1, float2 *uv, float *pdf) {
	const uint width = as_uint(distribution2D[0]);
	const uint height = as_uint(distribution2D[1]);
	__global const float* restrict marginal = &distribution2D[2];
	// size of Distribution1D: size of counts + size of func + size of cdf
	const uint marginalSize = 1 + height + height + 1;
	// size of Distribution1D: size of counts + size of func + size of cdf
	const uint conditionalSize = 1 + width + width + 1;

	float pdf1;
	uint index;
	(*uv).s1 = Distribution1D_SampleContinuous(marginal, u1, &pdf1, &index);

	float pdf0;
	__global const float* restrict conditional = &distribution2D[2 + marginalSize + index * conditionalSize];
	(*uv).s0 = Distribution1D_SampleContinuous(conditional, u0, &pdf0, NULL);

	*pdf = pdf0 * pdf1;
}

float Distribution2D_Pdf(__global const float* restrict distribution2D, const float u0, const float u1) {
	const uint width = as_uint(distribution2D[0]);
	const uint height = as_uint(distribution2D[1]);
	__global const float* restrict marginal = &distribution2D[2];
	// size of Distribution1D: size of counts + size of func + size of cdf
	const uint marginalSize = 1 + height + height + 1;
	// size of Distribution1D: size of counts + size of func + size of cdf
	const uint conditionalSize = 1 + width + width + 1;

	const uint index = Distribution1D_Offset(marginal, u1);
	__global const float *conditional = &distribution2D[2 + marginalSize + index * conditionalSize];

	return Distribution1D_Pdf_FLOAT(conditional, u0) * Distribution1D_Pdf_FLOAT(marginal, u1);
}
#line 2 "randomgen_funcs.cl"

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

//------------------------------------------------------------------------------
// Random number generator
// maximally equidistributed combined Tausworthe generator
//------------------------------------------------------------------------------

#define FLOATMASK 0x00ffffffu

uint TAUSWORTHE(const uint s, const uint a,
	const uint b, const uint c,
	const uint d) {
	return ((s&c)<<d) ^ (((s << a) ^ s) >> b);
}

uint LCG(const uint x) { return x * 69069; }

uint ValidSeed(const uint x, const uint m) {
	return (x < m) ? (x + m) : x;
}

void Rnd_Init(uint seed, Seed *s) {
	// Avoid 0 value
	seed = (seed == 0) ? (seed + 0xffffffu) : seed;

	s->s1 = ValidSeed(LCG(seed), 1);
	s->s2 = ValidSeed(LCG(s->s1), 7);
	s->s3 = ValidSeed(LCG(s->s2), 15);
}

unsigned long Rnd_UintValue(Seed *s) {
	s->s1 = TAUSWORTHE(s->s1, 13, 19, 4294967294UL, 12);
	s->s2 = TAUSWORTHE(s->s2, 2, 25, 4294967288UL, 4);
	s->s3 = TAUSWORTHE(s->s3, 3, 11, 4294967280UL, 17);

	return ((s->s1) ^ (s->s2) ^ (s->s3));
}

float Rnd_FloatValue(Seed *s) {
	return (Rnd_UintValue(s) & FLOATMASK) * (1.f / (FLOATMASK + 1UL));
}
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
#line 2 "trianglemesh_funcs.cl"

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

float3 Mesh_GetGeometryNormal(__global const Point* restrict vertices,
		__global const Triangle* restrict triangles, const uint triIndex) {
	__global const Triangle* restrict tri = &triangles[triIndex];
	const float3 p0 = VLOAD3F(&vertices[tri->v[0]].x);
	const float3 p1 = VLOAD3F(&vertices[tri->v[1]].x);
	const float3 p2 = VLOAD3F(&vertices[tri->v[2]].x);

	return Triangle_GetGeometryNormal(p0, p1, p2);
}

float3 Mesh_InterpolateNormal(__global const Vector* restrict normals,
		__global const Triangle* restrict triangles,
		const uint triIndex, const float b1, const float b2) {
	__global const Triangle* restrict tri = &triangles[triIndex];
	const float3 n0 = VLOAD3F(&normals[tri->v[0]].x);
	const float3 n1 = VLOAD3F(&normals[tri->v[1]].x);
	const float3 n2 = VLOAD3F(&normals[tri->v[2]].x);

	const float b0 = 1.f - b1 - b2;
	return Triangle_InterpolateNormal(n0, n1, n2, b0, b1, b2);
}

float2 Mesh_InterpolateUV(__global const UV* restrict vertUVs,
		__global const Triangle *triangles,
		const uint triIndex, const float b1, const float b2) {
	__global const Triangle* restrict tri = &triangles[triIndex];
	const float2 uv0 = VLOAD2F(&vertUVs[tri->v[0]].u);
	const float2 uv1 = VLOAD2F(&vertUVs[tri->v[1]].u);
	const float2 uv2 = VLOAD2F(&vertUVs[tri->v[2]].u);

	const float b0 = 1.f - b1 - b2;
	return Triangle_InterpolateUV(uv0, uv1, uv2, b0, b1, b2);
}

float3 Mesh_InterpolateColor(__global const Spectrum* restrict vertCols,
		__global const Triangle* restrict triangles,
		const uint triIndex, const float b1, const float b2) {
	__global const Triangle* restrict tri = &triangles[triIndex];
	const float3 rgb0 = VLOAD3F(vertCols[tri->v[0]].c);
	const float3 rgb1 = VLOAD3F(vertCols[tri->v[1]].c);
	const float3 rgb2 = VLOAD3F(vertCols[tri->v[2]].c);

	const float b0 = 1.f - b1 - b2;
	return Triangle_InterpolateColor(rgb0, rgb1, rgb2, b0, b1, b2);
}

float Mesh_InterpolateAlpha(__global const float* restrict vertAlphas,
		__global const Triangle* restrict triangles,
		const uint triIndex, const float b1, const float b2) {
	__global const Triangle* restrict tri = &triangles[triIndex];
	const float a0 = vertAlphas[tri->v[0]];
	const float a1 = vertAlphas[tri->v[1]];
	const float a2 = vertAlphas[tri->v[2]];

	const float b0 = 1.f - b1 - b2;
	return Triangle_InterpolateAlpha(a0, a1, a2, b0, b1, b2);
}

#line 2 "mapping_funcs.cl"

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

float2 UVMapping2D_Map(__global const TextureMapping2D *mapping, __global HitPoint *hitPoint) {
	const float2 scale = VLOAD2F(&mapping->uvMapping2D.uScale);
	const float2 delta = VLOAD2F(&mapping->uvMapping2D.uDelta);
	const float2 uv = VLOAD2F(&hitPoint->uv.u);

	return uv * scale + delta;
}

float2 UVMapping2D_MapDuv(__global const TextureMapping2D *mapping, __global HitPoint *hitPoint, float2 *ds, float2 *dt) {
	(*ds).xy = VLOAD2F(&mapping->uvMapping2D.uScale);
	(*dt).xy = (float2)(0.f, (*ds).y);
	(*ds).y = 0.f;
	return UVMapping2D_Map(mapping, hitPoint);
}

float3 UVMapping3D_Map(__global const TextureMapping3D *mapping, __global HitPoint *hitPoint) {
	const float2 uv = VLOAD2F(&hitPoint->uv.u);
	return Transform_ApplyPoint(&mapping->worldToLocal, (float3)(uv.xy, 0.f));
}

float3 GlobalMapping3D_Map(__global const TextureMapping3D *mapping, __global HitPoint *hitPoint) {
	const float3 p = VLOAD3F(&hitPoint->p.x);
	return Transform_ApplyPoint(&mapping->worldToLocal, p);
}

float2 TextureMapping2D_Map(__global const TextureMapping2D *mapping, __global HitPoint *hitPoint) {
	switch (mapping->type) {
		case UVMAPPING2D:
			return UVMapping2D_Map(mapping, hitPoint);
		default:
			return 0.f;
	}
}

float2 TextureMapping2D_MapDuv(__global const TextureMapping2D *mapping, __global HitPoint *hitPoint, float2 *ds, float2 *dt) {
	switch (mapping->type) {
		case UVMAPPING2D:
			return UVMapping2D_MapDuv(mapping, hitPoint, ds, dt);
		default:
			return 0.f;
	}
}

float3 TextureMapping3D_Map(__global const TextureMapping3D *mapping, __global HitPoint *hitPoint) {
	switch (mapping->type) {
		case UVMAPPING3D:
			return UVMapping3D_Map(mapping, hitPoint);
		case GLOBALMAPPING3D:
			return GlobalMapping3D_Map(mapping, hitPoint);
		default:
			return 0.f;
	}
}
#line 2 "imagemap_types.cl"

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

typedef enum {
	BYTE, HALF, FLOAT
} ImageMapStorageType;

typedef struct {
	ImageMapStorageType storageType;
	unsigned int channelCount, width, height;
	unsigned int pageIndex, pixelsIndex;
} ImageMap;

//------------------------------------------------------------------------------
// Some macro trick in order to have more readable code
//------------------------------------------------------------------------------

#if defined(SLG_OPENCL_KERNEL)

#if defined(PARAM_HAS_IMAGEMAPS)

#define IMAGEMAPS_PARAM_DECL , __global const ImageMap* restrict imageMapDescs, __global const float* restrict* restrict imageMapBuff
#define IMAGEMAPS_PARAM , imageMapDescs, imageMapBuff

#else

#define IMAGEMAPS_PARAM_DECL
#define IMAGEMAPS_PARAM

#endif

#endif
#line 2 "imagemap_funcs.cl"

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

//------------------------------------------------------------------------------
// ImageMaps support
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_IMAGEMAPS)

__global const void *ImageMap_GetPixelsAddress(__global const float* restrict* restrict imageMapBuff,
		const uint page, const uint offset) {
	return &imageMapBuff[page][offset];
}

float ImageMap_GetTexel_Float(
		const ImageMapStorageType storageType,
		__global const void *pixels,
		const uint width, const uint height, const uint channelCount,
		const int s, const int t) {
	const uint u = Mod(s, width);
	const uint v = Mod(t, height);

	const uint index = v * width + u;

	switch (storageType) {
		case BYTE: {
			switch (channelCount) {
				case 1: {
					const uchar a = ((__global const uchar *)pixels)[index];
					return a * (1.f / 255.f);
				}
				case 2: {
					const uchar a = ((__global const uchar *)pixels)[index * 2];
					return a * (1.f / 255.f);
				}
				case 3: {
					__global const uchar *rgb = &((__global const uchar *)pixels)[index * 3];
					return Spectrum_Y((float3)(rgb[0] * (1.f / 255.f), rgb[1] * (1.f / 255.f), rgb[2] * (1.f / 255.f)));
				}
				case 4: {
					__global const uchar *rgba = &((__global const uchar *)pixels)[index * 4];
					return Spectrum_Y((float3)(rgba[0] * (1.f / 255.f), rgba[1] * (1.f / 255.f), rgba[2] * (1.f / 255.f)));
				}
				default:
					return 0.f;
			}
		}
		case HALF: {
			switch (channelCount) {
				case 1: {
					return vload_half(index, (__global const half *)pixels);
				}
				case 2: {
					return vload_half(index * 2, (__global const half *)pixels);
				}
				case 3: {
					return Spectrum_Y((float3)(
							vload_half(index * 3, (__global const half *)pixels),
							vload_half(index * 3 + 1, (__global const half *)pixels),
							vload_half(index * 3 + 2, (__global const half *)pixels)));
				}
				case 4: {
					return Spectrum_Y((float3)(
							vload_half(index * 4, (__global const half *)pixels),
							vload_half(index * 4 + 1, (__global const half *)pixels),
							vload_half(index * 4 + 2, (__global const half *)pixels)));
				}
				default:
					return 0.f;
			}
		}
		case FLOAT: {
			switch (channelCount) {
				case 1: {
					const float a = ((__global const float *)pixels)[index];
					return a;
				}
				case 2: {
					const float a = ((__global const float *)pixels)[index * 2];
					return a;
				}
				case 3: {
					__global const float *rgb = &((__global const float *)pixels)[index * 3];
					return Spectrum_Y((float3)(rgb[0], rgb[1], rgb[2]));
				}
				case 4: {
					__global const float *rgba = &((__global const float *)pixels)[index * 4];
					return Spectrum_Y((float3)(rgba[0], rgba[1], rgba[2]));
				}
				default:
					return 0.f;
			}
		}
		default:
			return 0.f;
	}
}

float3 ImageMap_GetTexel_Spectrum(
		const ImageMapStorageType storageType,
		__global const void *pixels,
		const uint width, const uint height, const uint channelCount,
		const int s, const int t) {
	const uint u = Mod(s, width);
	const uint v = Mod(t, height);

	const uint index = v * width + u;

	switch (storageType) {
		case BYTE: {
			switch (channelCount) {
				case 1: {
					const uchar a = ((__global const uchar *)pixels)[index];
					return a * (1.f / 255.f);
				}
				case 2: {
					const uchar a = ((__global const uchar *)pixels)[index * 2] * (1.f / 255.f);
					return a;
				}
				case 3: {
					__global const uchar *rgb = &((__global const uchar *)pixels)[index * 3];
					return (float3)(rgb[0] * (1.f / 255.f), rgb[1] * (1.f / 255.f), rgb[2] * (1.f / 255.f));
				}
				case 4: {
					__global const uchar *rgba = &((__global const uchar *)pixels)[index * 4];
					return (float3)(rgba[0] * (1.f / 255.f), rgba[1] * (1.f / 255.f), rgba[2] * (1.f / 255.f));
				}
				default:
					return 0.f;
			}
		}
		case HALF: {
			switch (channelCount) {
				case 1: {
					return vload_half(index, (__global const half *)pixels);
				}
				case 2: {
					return vload_half(index * 2, (__global const half *)pixels);
				}
				case 3: {
					return (float3)(
							vload_half(index * 3, (__global const half *)pixels),
							vload_half(index * 3 + 1, (__global const half *)pixels),
							vload_half(index * 3 + 2, (__global const half *)pixels));
				}
				case 4: {
					return (float3)(
							vload_half(index * 4, (__global const half *)pixels),
							vload_half(index * 4 + 1, (__global const half *)pixels),
							vload_half(index * 4 + 2, (__global const half *)pixels));
				}
				default:
					return 0.f;
			}
		}
		case FLOAT: {
			switch (channelCount) {
				case 1: {
					const float a = ((__global const float *)pixels)[index];
					return a;
				}
				case 2: {
					const float a = ((__global const float *)pixels)[index * 2];
					return a;
				}
				case 3: {
					__global const float *rgb = &((__global const float *)pixels)[index * 3];
					return (float3)(rgb[0], rgb[1], rgb[2]);
				}
				case 4: {
					__global const float *rgba = &((__global const float *)pixels)[index * 4];
					return (float3)(rgba[0], rgba[1], rgba[2]);
				}
				default:
					return 0.f;
			}
		}
		default:
			return 0.f;
	}
}

float ImageMap_GetFloat(__global const ImageMap *imageMap,
		const float u, const float v
		IMAGEMAPS_PARAM_DECL) {
	__global const void *pixels = ImageMap_GetPixelsAddress(
		imageMapBuff, imageMap->pageIndex, imageMap->pixelsIndex);
	const ImageMapStorageType storageType = imageMap->storageType;
	const uint channelCount = imageMap->channelCount;
	const uint width = imageMap->width;
	const uint height = imageMap->height;

	const float s = u * width - 0.5f;
	const float t = v * height - 0.5f;

	const int s0 = Floor2Int(s);
	const int t0 = Floor2Int(t);

	const float ds = s - s0;
	const float dt = t - t0;

	const float ids = 1.f - ds;
	const float idt = 1.f - dt;

	const float c0 = ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, s0, t0);
	const float c1 = ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, s0, t0 + 1);
	const float c2 = ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, s0 + 1, t0);
	const float c3 = ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, s0 + 1, t0 + 1);

	const float k0 = ids * idt;
	const float k1 = ids * dt;
	const float k2 = ds * idt;
	const float k3 = ds * dt;

	return (k0 * c0 + k1 *c1 + k2 * c2 + k3 * c3);
}

float3 ImageMap_GetSpectrum(__global const ImageMap *imageMap,
		const float u, const float v
		IMAGEMAPS_PARAM_DECL) {
	__global const void *pixels = ImageMap_GetPixelsAddress(
		imageMapBuff, imageMap->pageIndex, imageMap->pixelsIndex);
	const ImageMapStorageType storageType = imageMap->storageType;
	const uint channelCount = imageMap->channelCount;
	const uint width = imageMap->width;
	const uint height = imageMap->height;

	const float s = u * width - 0.5f;
	const float t = v * height - 0.5f;

	const int s0 = Floor2Int(s);
	const int t0 = Floor2Int(t);

	const float ds = s - s0;
	const float dt = t - t0;

	const float ids = 1.f - ds;
	const float idt = 1.f - dt;

	const float3 c0 = ImageMap_GetTexel_Spectrum(storageType, pixels, width, height, channelCount, s0, t0);
	const float3 c1 = ImageMap_GetTexel_Spectrum(storageType, pixels, width, height, channelCount, s0, t0 + 1);
	const float3 c2 = ImageMap_GetTexel_Spectrum(storageType, pixels, width, height, channelCount, s0 + 1, t0);
	const float3 c3 = ImageMap_GetTexel_Spectrum(storageType, pixels, width, height, channelCount, s0 + 1, t0 + 1);

	const float k0 = ids * idt;
	const float k1 = ids * dt;
	const float k2 = ds * idt;
	const float k3 = ds * dt;

	return (k0 * c0 + k1 *c1 + k2 * c2 + k3 * c3);
}

float2 ImageMap_GetDuv(__global const ImageMap *imageMap,
		const float u, const float v
		IMAGEMAPS_PARAM_DECL) {
	__global const void *pixels = ImageMap_GetPixelsAddress(
		imageMapBuff, imageMap->pageIndex, imageMap->pixelsIndex);
	const ImageMapStorageType storageType = imageMap->storageType;
	const uint channelCount = imageMap->channelCount;
	const uint width = imageMap->width;
	const uint height = imageMap->height;

	const float s = u * width;
	const float t = v * height;

	const int is = Floor2Int(s);
	const int it = Floor2Int(t);

	const float as = s - is;
	const float at = t - it;

	int s0, s1;
	if (as < .5f) {
		s0 = is - 1;
		s1 = is;
	} else {
		s0 = is;
		s1 = is + 1;
	}
	int t0, t1;
	if (at < .5f) {
		t0 = it - 1;
		t1 = it;
	} else {
		t0 = it;
		t1 = it + 1;
	}

	float2 duv;
	duv.x = mix(ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, s1, it) - ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, s0, it),
		ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, s1, it + 1) - ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, s0, it + 1), at) * width;
	duv.y = mix(ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, is, t1) - ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, is, t0),
		ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, is + 1, t1) - ImageMap_GetTexel_Float(storageType, pixels, width, height, channelCount, is + 1, t0), as) * height;

	return duv;
}

#endif
#line 2 "texture_noise_funcs.cl"

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

//------------------------------------------------------------------------------
// Texture utility functions
//------------------------------------------------------------------------------

// Perlin Noise Data
#define NOISE_PERM_SIZE 256
__constant int NoisePerm[2 * NOISE_PERM_SIZE] = {
	151, 160, 137, 91, 90, 15, 131, 13, 201, 95, 96,
	53, 194, 233, 7, 225, 140, 36, 103, 30, 69, 142,
	// Rest of noise permutation table
	8, 99, 37, 240, 21, 10, 23,
	190, 6, 148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33,
	88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166,
	77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245, 40, 244,
	102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196,
	135, 130, 116, 188, 159, 86, 164, 100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123,
	5, 202, 38, 147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42,
	223, 183, 170, 213, 119, 248, 152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9,
	129, 22, 39, 253, 19, 98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228,
	251, 34, 242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107,
	49, 192, 214, 31, 181, 199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254,
	138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180,
	151, 160, 137, 91, 90, 15,
	131, 13, 201, 95, 96, 53, 194, 233, 7, 225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23,
	190, 6, 148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33,
	88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166,
	77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245, 40, 244,
	102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196,
	135, 130, 116, 188, 159, 86, 164, 100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123,
	5, 202, 38, 147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42,
	223, 183, 170, 213, 119, 248, 152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9,
	129, 22, 39, 253, 19, 98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228,
	251, 34, 242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107,
	49, 192, 214, 31, 181, 199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254,
	138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180
};

float Grad(int x, int y, int z, float dx, float dy, float dz) {
	const int h = NoisePerm[NoisePerm[NoisePerm[x] + y] + z] & 15;
	const float u = h < 8 || h == 12 || h == 13 ? dx : dy;
	const float v = h < 4 || h == 12 || h == 13 ? dy : dz;
	return ((h & 1) ? -u : u) + ((h & 2) ? -v : v);
}

float NoiseWeight(float t) {
	const float t3 = t * t * t;
	const float t4 = t3 * t;
	return 6.f * t4 * t - 15.f * t4 + 10.f * t3;
}

float Noise(float x, float y, float z) {
	// Compute noise cell coordinates and offsets
	int ix = Floor2Int(x);
	int iy = Floor2Int(y);
	int iz = Floor2Int(z);
	const float dx = x - ix, dy = y - iy, dz = z - iz;
	// Compute gradient weights
	ix &= (NOISE_PERM_SIZE - 1);
	iy &= (NOISE_PERM_SIZE - 1);
	iz &= (NOISE_PERM_SIZE - 1);
	const float w000 = Grad(ix, iy, iz, dx, dy, dz);
	const float w100 = Grad(ix + 1, iy, iz, dx - 1, dy, dz);
	const float w010 = Grad(ix, iy + 1, iz, dx, dy - 1, dz);
	const float w110 = Grad(ix + 1, iy + 1, iz, dx - 1, dy - 1, dz);
	const float w001 = Grad(ix, iy, iz + 1, dx, dy, dz - 1);
	const float w101 = Grad(ix + 1, iy, iz + 1, dx - 1, dy, dz - 1);
	const float w011 = Grad(ix, iy + 1, iz + 1, dx, dy - 1, dz - 1);
	const float w111 = Grad(ix + 1, iy + 1, iz + 1, dx - 1, dy - 1, dz - 1);
	// Compute trilinear interpolation of weights
	const float wx = NoiseWeight(dx);
	const float wy = NoiseWeight(dy);
	const float wz = NoiseWeight(dz);
	const float x00 = Lerp(wx, w000, w100);
	const float x10 = Lerp(wx, w010, w110);
	const float x01 = Lerp(wx, w001, w101);
	const float x11 = Lerp(wx, w011, w111);
	const float y0 = Lerp(wy, x00, x10);
	const float y1 = Lerp(wy, x01, x11);
	return Lerp(wz, y0, y1);
}

float Noise3(const float3 P) {
	return Noise(P.x, P.y, P.z);
}

float FBm(const float3 P, const float omega, const int maxOctaves) {
	// Compute number of octaves for anti-aliased FBm
	const float foctaves = (float)maxOctaves;
	const int octaves = Floor2Int(foctaves);
	// Compute sum of octaves of noise for FBm
	float sum = 0.f, lambda = 1.f, o = 1.f;
	for (int i = 0; i < octaves; ++i) {
		sum += o * Noise3(lambda * P);
		lambda *= 1.99f;
		o *= omega;
	}
	const float partialOctave = foctaves - (float)octaves;
	sum += o * SmoothStep(.3f, .7f, partialOctave) *
			Noise3(lambda * P);
	return sum;
}

float Turbulence(const float3 P, const float omega, const int maxOctaves) {
	// Compute number of octaves for anti-aliased FBm
	const float foctaves = (float)maxOctaves;
	const int octaves = Floor2Int(foctaves);
	// Compute sum of octaves of noise for turbulence
	float sum = 0.f, lambda = 1.f, o = 1.f;
	for (int i = 0; i < octaves; ++i) {
		sum += o * fabs(Noise3(lambda * P));
		lambda *= 1.99f;
		o *= omega;
	}
	const float partialOctave = foctaves - (float)(octaves);
	sum += o * SmoothStep(.3f, .7f, partialOctave) *
	       fabs(Noise3(lambda * P));

	// finally, add in value to account for average value of fabsf(Noise())
	// (~0.2) for the remaining octaves...
	sum += (maxOctaves - foctaves) * 0.2f;

	return sum;
}
#line 2 "texture_blender_noise_funcs.cl"

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

//------------------------------------------------------------------------------
// Blender Texture utility functions
//------------------------------------------------------------------------------

/* needed for voronoi */

__constant float hashpntf[768] = {0.536902f, 0.020915f, 0.501445f, 0.216316f, 0.517036f, 0.822466f, 0.965315f,
0.377313f, 0.678764f, 0.744545f, 0.097731f, 0.396357f, 0.247202f, 0.520897f,
0.613396f, 0.542124f, 0.146813f, 0.255489f, 0.810868f, 0.638641f, 0.980742f,
0.292316f, 0.357948f, 0.114382f, 0.861377f, 0.629634f, 0.722530f, 0.714103f,
0.048549f, 0.075668f, 0.564920f, 0.162026f, 0.054466f, 0.411738f, 0.156897f,
0.887657f, 0.599368f, 0.074249f, 0.170277f, 0.225799f, 0.393154f, 0.301348f,
0.057434f, 0.293849f, 0.442745f, 0.150002f, 0.398732f, 0.184582f, 0.915200f,
0.630984f, 0.974040f, 0.117228f, 0.795520f, 0.763238f, 0.158982f, 0.616211f,
0.250825f, 0.906539f, 0.316874f, 0.676205f, 0.234720f, 0.667673f, 0.792225f,
0.273671f, 0.119363f, 0.199131f, 0.856716f, 0.828554f, 0.900718f, 0.705960f,
0.635923f, 0.989433f, 0.027261f, 0.283507f, 0.113426f, 0.388115f, 0.900176f,
0.637741f, 0.438802f, 0.715490f, 0.043692f, 0.202640f, 0.378325f, 0.450325f,
0.471832f, 0.147803f, 0.906899f, 0.524178f, 0.784981f, 0.051483f, 0.893369f,
0.596895f, 0.275635f, 0.391483f, 0.844673f, 0.103061f, 0.257322f, 0.708390f,
0.504091f, 0.199517f, 0.660339f, 0.376071f, 0.038880f, 0.531293f, 0.216116f,
0.138672f, 0.907737f, 0.807994f, 0.659582f, 0.915264f, 0.449075f, 0.627128f,
0.480173f, 0.380942f, 0.018843f, 0.211808f, 0.569701f, 0.082294f, 0.689488f,
0.573060f, 0.593859f, 0.216080f, 0.373159f, 0.108117f, 0.595539f, 0.021768f,
0.380297f, 0.948125f, 0.377833f, 0.319699f, 0.315249f, 0.972805f, 0.792270f,
0.445396f, 0.845323f, 0.372186f, 0.096147f, 0.689405f, 0.423958f, 0.055675f,
0.117940f, 0.328456f, 0.605808f, 0.631768f, 0.372170f, 0.213723f, 0.032700f,
0.447257f, 0.440661f, 0.728488f, 0.299853f, 0.148599f, 0.649212f, 0.498381f,
0.049921f, 0.496112f, 0.607142f, 0.562595f, 0.990246f, 0.739659f, 0.108633f,
0.978156f, 0.209814f, 0.258436f, 0.876021f, 0.309260f, 0.600673f, 0.713597f,
0.576967f, 0.641402f, 0.853930f, 0.029173f, 0.418111f, 0.581593f, 0.008394f,
0.589904f, 0.661574f, 0.979326f, 0.275724f, 0.111109f, 0.440472f, 0.120839f,
0.521602f, 0.648308f, 0.284575f, 0.204501f, 0.153286f, 0.822444f, 0.300786f,
0.303906f, 0.364717f, 0.209038f, 0.916831f, 0.900245f, 0.600685f, 0.890002f,
0.581660f, 0.431154f, 0.705569f, 0.551250f, 0.417075f, 0.403749f, 0.696652f,
0.292652f, 0.911372f, 0.690922f, 0.323718f, 0.036773f, 0.258976f, 0.274265f,
0.225076f, 0.628965f, 0.351644f, 0.065158f, 0.080340f, 0.467271f, 0.130643f,
0.385914f, 0.919315f, 0.253821f, 0.966163f, 0.017439f, 0.392610f, 0.478792f,
0.978185f, 0.072691f, 0.982009f, 0.097987f, 0.731533f, 0.401233f, 0.107570f,
0.349587f, 0.479122f, 0.700598f, 0.481751f, 0.788429f, 0.706864f, 0.120086f,
0.562691f, 0.981797f, 0.001223f, 0.192120f, 0.451543f, 0.173092f, 0.108960f,
0.549594f, 0.587892f, 0.657534f, 0.396365f, 0.125153f, 0.666420f, 0.385823f,
0.890916f, 0.436729f, 0.128114f, 0.369598f, 0.759096f, 0.044677f, 0.904752f,
0.088052f, 0.621148f, 0.005047f, 0.452331f, 0.162032f, 0.494238f, 0.523349f,
0.741829f, 0.698450f, 0.452316f, 0.563487f, 0.819776f, 0.492160f, 0.004210f,
0.647158f, 0.551475f, 0.362995f, 0.177937f, 0.814722f, 0.727729f, 0.867126f,
0.997157f, 0.108149f, 0.085726f, 0.796024f, 0.665075f, 0.362462f, 0.323124f,
0.043718f, 0.042357f, 0.315030f, 0.328954f, 0.870845f, 0.683186f, 0.467922f,
0.514894f, 0.809971f, 0.631979f, 0.176571f, 0.366320f, 0.850621f, 0.505555f,
0.749551f, 0.750830f, 0.401714f, 0.481216f, 0.438393f, 0.508832f, 0.867971f,
0.654581f, 0.058204f, 0.566454f, 0.084124f, 0.548539f, 0.902690f, 0.779571f,
0.562058f, 0.048082f, 0.863109f, 0.079290f, 0.713559f, 0.783496f, 0.265266f,
0.672089f, 0.786939f, 0.143048f, 0.086196f, 0.876129f, 0.408708f, 0.229312f,
0.629995f, 0.206665f, 0.207308f, 0.710079f, 0.341704f, 0.264921f, 0.028748f,
0.629222f, 0.470173f, 0.726228f, 0.125243f, 0.328249f, 0.794187f, 0.741340f,
0.489895f, 0.189396f, 0.724654f, 0.092841f, 0.039809f, 0.860126f, 0.247701f,
0.655331f, 0.964121f, 0.672536f, 0.044522f, 0.690567f, 0.837238f, 0.631520f,
0.953734f, 0.352484f, 0.289026f, 0.034152f, 0.852575f, 0.098454f, 0.795529f,
0.452181f, 0.826159f, 0.186993f, 0.820725f, 0.440328f, 0.922137f, 0.704592f,
0.915437f, 0.738183f, 0.733461f, 0.193798f, 0.929213f, 0.161390f, 0.318547f,
0.888751f, 0.430968f, 0.740837f, 0.193544f, 0.872253f, 0.563074f, 0.274598f,
0.347805f, 0.666176f, 0.449831f, 0.800991f, 0.588727f, 0.052296f, 0.714761f,
0.420620f, 0.570325f, 0.057550f, 0.210888f, 0.407312f, 0.662848f, 0.924382f,
0.895958f, 0.775198f, 0.688605f, 0.025721f, 0.301913f, 0.791408f, 0.500602f,
0.831984f, 0.828509f, 0.642093f, 0.494174f, 0.525880f, 0.446365f, 0.440063f,
0.763114f, 0.630358f, 0.223943f, 0.333806f, 0.906033f, 0.498306f, 0.241278f,
0.427640f, 0.772683f, 0.198082f, 0.225379f, 0.503894f, 0.436599f, 0.016503f,
0.803725f, 0.189878f, 0.291095f, 0.499114f, 0.151573f, 0.079031f, 0.904618f,
0.708535f, 0.273900f, 0.067419f, 0.317124f, 0.936499f, 0.716511f, 0.543845f,
0.939909f, 0.826574f, 0.715090f, 0.154864f, 0.750150f, 0.845808f, 0.648108f,
0.556564f, 0.644757f, 0.140873f, 0.799167f, 0.632989f, 0.444245f, 0.471978f,
0.435910f, 0.359793f, 0.216241f, 0.007633f, 0.337236f, 0.857863f, 0.380247f,
0.092517f, 0.799973f, 0.919000f, 0.296798f, 0.096989f, 0.854831f, 0.165369f,
0.568475f, 0.216855f, 0.020457f, 0.835511f, 0.538039f, 0.999742f, 0.620226f,
0.244053f, 0.060399f, 0.323007f, 0.294874f, 0.988899f, 0.384919f, 0.735655f,
0.773428f, 0.549776f, 0.292882f, 0.660611f, 0.593507f, 0.621118f, 0.175269f,
0.682119f, 0.794493f, 0.868197f, 0.632150f, 0.807823f, 0.509656f, 0.482035f,
0.001780f, 0.259126f, 0.358002f, 0.280263f, 0.192985f, 0.290367f, 0.208111f,
0.917633f, 0.114422f, 0.925491f, 0.981110f, 0.255570f, 0.974862f, 0.016629f,
0.552599f, 0.575741f, 0.612978f, 0.615965f, 0.803615f, 0.772334f, 0.089745f,
0.838812f, 0.634542f, 0.113709f, 0.755832f, 0.577589f, 0.667489f, 0.529834f,
0.325660f, 0.817597f, 0.316557f, 0.335093f, 0.737363f, 0.260951f, 0.737073f,
0.049540f, 0.735541f, 0.988891f, 0.299116f, 0.147695f, 0.417271f, 0.940811f,
0.524160f, 0.857968f, 0.176403f, 0.244835f, 0.485759f, 0.033353f, 0.280319f,
0.750688f, 0.755809f, 0.924208f, 0.095956f, 0.962504f, 0.275584f, 0.173715f,
0.942716f, 0.706721f, 0.078464f, 0.576716f, 0.804667f, 0.559249f, 0.900611f,
0.646904f, 0.432111f, 0.927885f, 0.383277f, 0.269973f, 0.114244f, 0.574867f,
0.150703f, 0.241855f, 0.272871f, 0.199950f, 0.079719f, 0.868566f, 0.962833f,
0.789122f, 0.320025f, 0.905554f, 0.234876f, 0.991356f, 0.061913f, 0.732911f,
0.785960f, 0.874074f, 0.069035f, 0.658632f, 0.309901f, 0.023676f, 0.791603f,
0.764661f, 0.661278f, 0.319583f, 0.829650f, 0.117091f, 0.903124f, 0.982098f,
0.161631f, 0.193576f, 0.670428f, 0.857390f, 0.003760f, 0.572578f, 0.222162f,
0.114551f, 0.420118f, 0.530404f, 0.470682f, 0.525527f, 0.764281f, 0.040596f,
0.443275f, 0.501124f, 0.816161f, 0.417467f, 0.332172f, 0.447565f, 0.614591f,
0.559246f, 0.805295f, 0.226342f, 0.155065f, 0.714630f, 0.160925f, 0.760001f,
0.453456f, 0.093869f, 0.406092f, 0.264801f, 0.720370f, 0.743388f, 0.373269f,
0.403098f, 0.911923f, 0.897249f, 0.147038f, 0.753037f, 0.516093f, 0.739257f,
0.175018f, 0.045768f, 0.735857f, 0.801330f, 0.927708f, 0.240977f, 0.591870f,
0.921831f, 0.540733f, 0.149100f, 0.423152f, 0.806876f, 0.397081f, 0.061100f,
0.811630f, 0.044899f, 0.460915f, 0.961202f, 0.822098f, 0.971524f, 0.867608f,
0.773604f, 0.226616f, 0.686286f, 0.926972f, 0.411613f, 0.267873f, 0.081937f,
0.226124f, 0.295664f, 0.374594f, 0.533240f, 0.237876f, 0.669629f, 0.599083f,
0.513081f, 0.878719f, 0.201577f, 0.721296f, 0.495038f, 0.079760f, 0.965959f,
0.233090f, 0.052496f, 0.714748f, 0.887844f, 0.308724f, 0.972885f, 0.723337f,
0.453089f, 0.914474f, 0.704063f, 0.823198f, 0.834769f, 0.906561f, 0.919600f,
0.100601f, 0.307564f, 0.901977f, 0.468879f, 0.265376f, 0.885188f, 0.683875f,
0.868623f, 0.081032f, 0.466835f, 0.199087f, 0.663437f, 0.812241f, 0.311337f,
0.821361f, 0.356628f, 0.898054f, 0.160781f, 0.222539f, 0.714889f, 0.490287f,
0.984915f, 0.951755f, 0.964097f, 0.641795f, 0.815472f, 0.852732f, 0.862074f,
0.051108f, 0.440139f, 0.323207f, 0.517171f, 0.562984f, 0.115295f, 0.743103f,
0.977914f, 0.337596f, 0.440694f, 0.535879f, 0.959427f, 0.351427f, 0.704361f,
0.010826f, 0.131162f, 0.577080f, 0.349572f, 0.774892f, 0.425796f, 0.072697f,
0.500001f, 0.267322f, 0.909654f, 0.206176f, 0.223987f, 0.937698f, 0.323423f,
0.117501f, 0.490308f, 0.474372f, 0.689943f, 0.168671f, 0.719417f, 0.188928f,
0.330464f, 0.265273f, 0.446271f, 0.171933f, 0.176133f, 0.474616f, 0.140182f,
0.114246f, 0.905043f, 0.713870f, 0.555261f, 0.951333f};

__constant unsigned char hash[512]= {
0xA2,0xA0,0x19,0x3B,0xF8,0xEB,0xAA,0xEE,0xF3,0x1C,0x67,0x28,0x1D,0xED,0x0,0xDE,0x95,0x2E,0xDC,0x3F,0x3A,0x82,0x35,0x4D,0x6C,0xBA,0x36,0xD0,0xF6,0xC,0x79,0x32,0xD1,0x59,0xF4,0x8,0x8B,0x63,0x89,0x2F,0xB8,0xB4,0x97,0x83,0xF2,0x8F,0x18,0xC7,0x51,0x14,0x65,0x87,0x48,0x20,0x42,0xA8,0x80,0xB5,0x40,0x13,0xB2,0x22,0x7E,0x57,
0xBC,0x7F,0x6B,0x9D,0x86,0x4C,0xC8,0xDB,0x7C,0xD5,0x25,0x4E,0x5A,0x55,0x74,0x50,0xCD,0xB3,0x7A,0xBB,0xC3,0xCB,0xB6,0xE2,0xE4,0xEC,0xFD,0x98,0xB,0x96,0xD3,0x9E,0x5C,0xA1,0x64,0xF1,0x81,0x61,0xE1,0xC4,0x24,0x72,0x49,0x8C,0x90,0x4B,0x84,0x34,0x38,0xAB,0x78,0xCA,0x1F,0x1,0xD7,0x93,0x11,0xC1,0x58,0xA9,0x31,0xF9,0x44,0x6D,
0xBF,0x33,0x9C,0x5F,0x9,0x94,0xA3,0x85,0x6,0xC6,0x9A,0x1E,0x7B,0x46,0x15,0x30,0x27,0x2B,0x1B,0x71,0x3C,0x5B,0xD6,0x6F,0x62,0xAC,0x4F,0xC2,0xC0,0xE,0xB1,0x23,0xA7,0xDF,0x47,0xB0,0x77,0x69,0x5,0xE9,0xE6,0xE7,0x76,0x73,0xF,0xFE,0x6E,0x9B,0x56,0xEF,0x12,0xA5,0x37,0xFC,0xAE,0xD9,0x3,0x8E,0xDD,0x10,0xB9,0xCE,0xC9,0x8D,
0xDA,0x2A,0xBD,0x68,0x17,0x9F,0xBE,0xD4,0xA,0xCC,0xD2,0xE8,0x43,0x3D,0x70,0xB7,0x2,0x7D,0x99,0xD8,0xD,0x60,0x8A,0x4,0x2C,0x3E,0x92,0xE5,0xAF,0x53,0x7,0xE0,0x29,0xA6,0xC5,0xE3,0xF5,0xF7,0x4A,0x41,0x26,0x6A,0x16,0x5E,0x52,0x2D,0x21,0xAD,0xF0,0x91,0xFF,0xEA,0x54,0xFA,0x66,0x1A,0x45,0x39,0xCF,0x75,0xA4,0x88,0xFB,0x5D,
0xA2,0xA0,0x19,0x3B,0xF8,0xEB,0xAA,0xEE,0xF3,0x1C,0x67,0x28,0x1D,0xED,0x0,0xDE,0x95,0x2E,0xDC,0x3F,0x3A,0x82,0x35,0x4D,0x6C,0xBA,0x36,0xD0,0xF6,0xC,0x79,0x32,0xD1,0x59,0xF4,0x8,0x8B,0x63,0x89,0x2F,0xB8,0xB4,0x97,0x83,0xF2,0x8F,0x18,0xC7,0x51,0x14,0x65,0x87,0x48,0x20,0x42,0xA8,0x80,0xB5,0x40,0x13,0xB2,0x22,0x7E,0x57,
0xBC,0x7F,0x6B,0x9D,0x86,0x4C,0xC8,0xDB,0x7C,0xD5,0x25,0x4E,0x5A,0x55,0x74,0x50,0xCD,0xB3,0x7A,0xBB,0xC3,0xCB,0xB6,0xE2,0xE4,0xEC,0xFD,0x98,0xB,0x96,0xD3,0x9E,0x5C,0xA1,0x64,0xF1,0x81,0x61,0xE1,0xC4,0x24,0x72,0x49,0x8C,0x90,0x4B,0x84,0x34,0x38,0xAB,0x78,0xCA,0x1F,0x1,0xD7,0x93,0x11,0xC1,0x58,0xA9,0x31,0xF9,0x44,0x6D,
0xBF,0x33,0x9C,0x5F,0x9,0x94,0xA3,0x85,0x6,0xC6,0x9A,0x1E,0x7B,0x46,0x15,0x30,0x27,0x2B,0x1B,0x71,0x3C,0x5B,0xD6,0x6F,0x62,0xAC,0x4F,0xC2,0xC0,0xE,0xB1,0x23,0xA7,0xDF,0x47,0xB0,0x77,0x69,0x5,0xE9,0xE6,0xE7,0x76,0x73,0xF,0xFE,0x6E,0x9B,0x56,0xEF,0x12,0xA5,0x37,0xFC,0xAE,0xD9,0x3,0x8E,0xDD,0x10,0xB9,0xCE,0xC9,0x8D,
0xDA,0x2A,0xBD,0x68,0x17,0x9F,0xBE,0xD4,0xA,0xCC,0xD2,0xE8,0x43,0x3D,0x70,0xB7,0x2,0x7D,0x99,0xD8,0xD,0x60,0x8A,0x4,0x2C,0x3E,0x92,0xE5,0xAF,0x53,0x7,0xE0,0x29,0xA6,0xC5,0xE3,0xF5,0xF7,0x4A,0x41,0x26,0x6A,0x16,0x5E,0x52,0x2D,0x21,0xAD,0xF0,0x91,0xFF,0xEA,0x54,0xFA,0x66,0x1A,0x45,0x39,0xCF,0x75,0xA4,0x88,0xFB,0x5D,
};

__constant float hashvectf[768]= {
0.33783f,0.715698f,-0.611206f,-0.944031f,-0.326599f,-0.045624f,-0.101074f,-0.416443f,-0.903503f,0.799286f,0.49411f,-0.341949f,-0.854645f,0.518036f,0.033936f,0.42514f,-0.437866f,-0.792114f,-0.358948f,0.597046f,0.717377f,-0.985413f,0.144714f,0.089294f,-0.601776f,-0.33728f,-0.723907f,-0.449921f,0.594513f,0.666382f,0.208313f,-0.10791f,
0.972076f,0.575317f,0.060425f,0.815643f,0.293365f,-0.875702f,-0.383453f,0.293762f,0.465759f,0.834686f,-0.846008f,-0.233398f,-0.47934f,-0.115814f,0.143036f,-0.98291f,0.204681f,-0.949036f,-0.239532f,0.946716f,-0.263947f,0.184326f,-0.235596f,0.573822f,0.784332f,0.203705f,-0.372253f,-0.905487f,0.756989f,-0.651031f,0.055298f,0.497803f,
0.814697f,-0.297363f,-0.16214f,0.063995f,-0.98468f,-0.329254f,0.834381f,0.441925f,0.703827f,-0.527039f,-0.476227f,0.956421f,0.266113f,0.119781f,0.480133f,0.482849f,0.7323f,-0.18631f,0.961212f,-0.203125f,-0.748474f,-0.656921f,-0.090393f,-0.085052f,-0.165253f,0.982544f,-0.76947f,0.628174f,-0.115234f,0.383148f,0.537659f,0.751068f,
0.616486f,-0.668488f,-0.415924f,-0.259979f,-0.630005f,0.73175f,0.570953f,-0.087952f,0.816223f,-0.458008f,0.023254f,0.888611f,-0.196167f,0.976563f,-0.088287f,-0.263885f,-0.69812f,-0.665527f,0.437134f,-0.892273f,-0.112793f,-0.621674f,-0.230438f,0.748566f,0.232422f,0.900574f,-0.367249f,0.22229f,-0.796143f,0.562744f,-0.665497f,-0.73764f,
0.11377f,0.670135f,0.704803f,0.232605f,0.895599f,0.429749f,-0.114655f,-0.11557f,-0.474243f,0.872742f,0.621826f,0.604004f,-0.498444f,-0.832214f,0.012756f,0.55426f,-0.702484f,0.705994f,-0.089661f,-0.692017f,0.649292f,0.315399f,-0.175995f,-0.977997f,0.111877f,0.096954f,-0.04953f,0.994019f,0.635284f,-0.606689f,-0.477783f,-0.261261f,
-0.607422f,-0.750153f,0.983276f,0.165436f,0.075958f,-0.29837f,0.404083f,-0.864655f,-0.638672f,0.507721f,0.578156f,0.388214f,0.412079f,0.824249f,0.556183f,-0.208832f,0.804352f,0.778442f,0.562012f,0.27951f,-0.616577f,0.781921f,-0.091522f,0.196289f,0.051056f,0.979187f,-0.121216f,0.207153f,-0.970734f,-0.173401f,-0.384735f,0.906555f,
0.161499f,-0.723236f,-0.671387f,0.178497f,-0.006226f,-0.983887f,-0.126038f,0.15799f,0.97934f,0.830475f,-0.024811f,0.556458f,-0.510132f,-0.76944f,0.384247f,0.81424f,0.200104f,-0.544891f,-0.112549f,-0.393311f,-0.912445f,0.56189f,0.152222f,-0.813049f,0.198914f,-0.254517f,-0.946381f,-0.41217f,0.690979f,-0.593811f,-0.407257f,0.324524f,
0.853668f,-0.690186f,0.366119f,-0.624115f,-0.428345f,0.844147f,-0.322296f,-0.21228f,-0.297546f,-0.930756f,-0.273071f,0.516113f,0.811798f,0.928314f,0.371643f,0.007233f,0.785828f,-0.479218f,-0.390778f,-0.704895f,0.058929f,0.706818f,0.173248f,0.203583f,0.963562f,0.422211f,-0.904297f,-0.062469f,-0.363312f,-0.182465f,0.913605f,0.254028f,
-0.552307f,-0.793945f,-0.28891f,-0.765747f,-0.574554f,0.058319f,0.291382f,0.954803f,0.946136f,-0.303925f,0.111267f,-0.078156f,0.443695f,-0.892731f,0.182098f,0.89389f,0.409515f,-0.680298f,-0.213318f,0.701141f,0.062469f,0.848389f,-0.525635f,-0.72879f,-0.641846f,0.238342f,-0.88089f,0.427673f,0.202637f,-0.532501f,-0.21405f,0.818878f,
0.948975f,-0.305084f,0.07962f,0.925446f,0.374664f,0.055817f,0.820923f,0.565491f,0.079102f,0.25882f,0.099792f,-0.960724f,-0.294617f,0.910522f,0.289978f,0.137115f,0.320038f,-0.937408f,-0.908386f,0.345276f,-0.235718f,-0.936218f,0.138763f,0.322754f,0.366577f,0.925934f,-0.090637f,0.309296f,-0.686829f,-0.657684f,0.66983f,0.024445f,
0.742065f,-0.917999f,-0.059113f,-0.392059f,0.365509f,0.462158f,-0.807922f,0.083374f,0.996399f,-0.014801f,0.593842f,0.253143f,-0.763672f,0.974976f,-0.165466f,0.148285f,0.918976f,0.137299f,0.369537f,0.294952f,0.694977f,0.655731f,0.943085f,0.152618f,-0.295319f,0.58783f,-0.598236f,0.544495f,0.203796f,0.678223f,0.705994f,-0.478821f,
-0.661011f,0.577667f,0.719055f,-0.1698f,-0.673828f,-0.132172f,-0.965332f,0.225006f,-0.981873f,-0.14502f,0.121979f,0.763458f,0.579742f,0.284546f,-0.893188f,0.079681f,0.442474f,-0.795776f,-0.523804f,0.303802f,0.734955f,0.67804f,-0.007446f,0.15506f,0.986267f,-0.056183f,0.258026f,0.571503f,-0.778931f,-0.681549f,-0.702087f,-0.206116f,
-0.96286f,-0.177185f,0.203613f,-0.470978f,-0.515106f,0.716095f,-0.740326f,0.57135f,0.354095f,-0.56012f,-0.824982f,-0.074982f,-0.507874f,0.753204f,0.417969f,-0.503113f,0.038147f,0.863342f,0.594025f,0.673553f,-0.439758f,-0.119873f,-0.005524f,-0.992737f,0.098267f,-0.213776f,0.971893f,-0.615631f,0.643951f,0.454163f,0.896851f,-0.441071f,
0.032166f,-0.555023f,0.750763f,-0.358093f,0.398773f,0.304688f,0.864929f,-0.722961f,0.303589f,0.620544f,-0.63559f,-0.621948f,-0.457306f,-0.293243f,0.072327f,0.953278f,-0.491638f,0.661041f,-0.566772f,-0.304199f,-0.572083f,-0.761688f,0.908081f,-0.398956f,0.127014f,-0.523621f,-0.549683f,-0.650848f,-0.932922f,-0.19986f,0.299408f,0.099426f,
0.140869f,0.984985f,-0.020325f,-0.999756f,-0.002319f,0.952667f,0.280853f,-0.11615f,-0.971893f,0.082581f,0.220337f,0.65921f,0.705292f,-0.260651f,0.733063f,-0.175537f,0.657043f,-0.555206f,0.429504f,-0.712189f,0.400421f,-0.89859f,0.179352f,0.750885f,-0.19696f,0.630341f,0.785675f,-0.569336f,0.241821f,-0.058899f,-0.464111f,0.883789f,
0.129608f,-0.94519f,0.299622f,-0.357819f,0.907654f,0.219238f,-0.842133f,-0.439117f,-0.312927f,-0.313477f,0.84433f,0.434479f,-0.241211f,0.053253f,0.968994f,0.063873f,0.823273f,0.563965f,0.476288f,0.862152f,-0.172516f,0.620941f,-0.298126f,0.724915f,0.25238f,-0.749359f,-0.612122f,-0.577545f,0.386566f,0.718994f,-0.406342f,-0.737976f,
0.538696f,0.04718f,0.556305f,0.82959f,-0.802856f,0.587463f,0.101166f,-0.707733f,-0.705963f,0.026428f,0.374908f,0.68457f,0.625092f,0.472137f,0.208405f,-0.856506f,-0.703064f,-0.581085f,-0.409821f,-0.417206f,-0.736328f,0.532623f,-0.447876f,-0.20285f,-0.870728f,0.086945f,-0.990417f,0.107086f,0.183685f,0.018341f,-0.982788f,0.560638f,
-0.428864f,0.708282f,0.296722f,-0.952576f,-0.0672f,0.135773f,0.990265f,0.030243f,-0.068787f,0.654724f,0.752686f,0.762604f,-0.551758f,0.337585f,-0.819611f,-0.407684f,0.402466f,-0.727844f,-0.55072f,-0.408539f,-0.855774f,-0.480011f,0.19281f,0.693176f,-0.079285f,0.716339f,0.226013f,0.650116f,-0.725433f,0.246704f,0.953369f,-0.173553f,
-0.970398f,-0.239227f,-0.03244f,0.136383f,-0.394318f,0.908752f,0.813232f,0.558167f,0.164368f,0.40451f,0.549042f,-0.731323f,-0.380249f,-0.566711f,0.730865f,0.022156f,0.932739f,0.359741f,0.00824f,0.996552f,-0.082306f,0.956635f,-0.065338f,-0.283722f,-0.743561f,0.008209f,0.668579f,-0.859589f,-0.509674f,0.035767f,-0.852234f,0.363678f,
-0.375977f,-0.201965f,-0.970795f,-0.12915f,0.313477f,0.947327f,0.06546f,-0.254028f,-0.528259f,0.81015f,0.628052f,0.601105f,0.49411f,-0.494385f,0.868378f,0.037933f,0.275635f,-0.086426f,0.957336f,-0.197937f,0.468903f,-0.860748f,0.895599f,0.399384f,0.195801f,0.560791f,0.825012f,-0.069214f,0.304199f,-0.849487f,0.43103f,0.096375f,
0.93576f,0.339111f,-0.051422f,0.408966f,-0.911072f,0.330444f,0.942841f,-0.042389f,-0.452362f,-0.786407f,0.420563f,0.134308f,-0.933472f,-0.332489f,0.80191f,-0.566711f,-0.188934f,-0.987946f,-0.105988f,0.112518f,-0.24408f,0.892242f,-0.379791f,-0.920502f,0.229095f,-0.316376f,0.7789f,0.325958f,0.535706f,-0.912872f,0.185211f,-0.36377f,
-0.184784f,0.565369f,-0.803833f,-0.018463f,0.119537f,0.992615f,-0.259247f,-0.935608f,0.239532f,-0.82373f,-0.449127f,-0.345947f,-0.433105f,0.659515f,0.614349f,-0.822754f,0.378845f,-0.423676f,0.687195f,-0.674835f,-0.26889f,-0.246582f,-0.800842f,0.545715f,-0.729187f,-0.207794f,0.651978f,0.653534f,-0.610443f,-0.447388f,0.492584f,-0.023346f,
0.869934f,0.609039f,0.009094f,-0.79306f,0.962494f,-0.271088f,-0.00885f,0.2659f,-0.004913f,0.963959f,0.651245f,0.553619f,-0.518951f,0.280548f,-0.84314f,0.458618f,-0.175293f,-0.983215f,0.049805f,0.035339f,-0.979919f,0.196045f,-0.982941f,0.164307f,-0.082245f,0.233734f,-0.97226f,-0.005005f,-0.747253f,-0.611328f,0.260437f,0.645599f,
0.592773f,0.481384f,0.117706f,-0.949524f,-0.29068f,-0.535004f,-0.791901f,-0.294312f,-0.627167f,-0.214447f,0.748718f,-0.047974f,-0.813477f,-0.57959f,-0.175537f,0.477264f,-0.860992f,0.738556f,-0.414246f,-0.53183f,0.562561f,-0.704071f,0.433289f,-0.754944f,0.64801f,-0.100586f,0.114716f,0.044525f,-0.992371f,0.966003f,0.244873f,-0.082764f
};

float tex_sin(float a) {
    a = 0.5f + 0.5f * sin(a);
    return a;
}

float tex_saw(float a) {
    const float b = 2.f * M_PI_F;
    int n = (int) (a / b);
    a -= n*b;
    if (a < 0.f) a += b;
    return a / b;
}

float tex_tri(float a) {
    const float b = 2.f * M_PI_F;
    const float rmax = 1.f;
    a = rmax - 2.f * fabs(floor((a * (1.f / b)) + .5f) - (a * (1.f / b)));
    return a;
}

/**************************/
/*  IMPROVED PERLIN NOISE */
/**************************/
#define lerp(t, a, b) ((a)+(t)*((b)-(a)))
#define npfade(t) ((t)*(t)*(t)*((t)*((t)*6-15)+10))

float grad(int hash, float x, float y, float z) {
	int h = hash & 15;                     // CONVERT LO 4 BITS OF HASH CODE
	float u = h<8 ? x : y,                 // INTO 12 GRADIENT DIRECTIONS.
				v = h<4 ? y : h==12||h==14 ? x : z;
	return ((h&1) == 0 ? u : -u) + ((h&2) == 0 ? v : -v);
}

/* instead of adding another permutation array, just use hash table defined above */
float newPerlin(float x, float y, float z)
{
	int A, AA, AB, B, BA, BB;
	float u=floor(x), v=floor(y), w=floor(z);
	int X=((int)u) & 255, Y=((int)v) & 255, Z=((int)w) & 255;	// FIND UNIT CUBE THAT CONTAINS POINT
	x -= u;             // FIND RELATIVE X,Y,Z
	y -= v;             // OF POINT IN CUBE.
	z -= w;
	u = npfade(x);      // COMPUTE FADE CURVES
	v = npfade(y);      // FOR EACH OF X,Y,Z.
	w = npfade(z);
	A = hash[X  ]+Y;  AA = hash[A]+Z;  AB = hash[A+1]+Z;      // HASH COORDINATES OF
	B = hash[X+1]+Y;  BA = hash[B]+Z;  BB = hash[B+1]+Z;      // THE 8 CUBE CORNERS,
	return lerp(w, lerp(v, lerp(u, grad(hash[AA  ], x  , y  , z   ),  // AND ADD
																grad(hash[BA  ], x-1, y  , z   )), // BLENDED
												lerp(u, grad(hash[AB  ], x  , y-1, z   ),  // RESULTS
																grad(hash[BB  ], x-1, y-1, z   ))),// FROM  8
								lerp(v, lerp(u, grad(hash[AA+1], x  , y  , z-1 ),  // CORNERS
																grad(hash[BA+1], x-1, y  , z-1 )), // OF CUBE
												lerp(u, grad(hash[AB+1], x  , y-1, z-1 ),
																grad(hash[BB+1], x-1, y-1, z-1 ))));
}

/* for use with BLI_gNoise()/BLI_gTurbulence(), returns unsigned improved perlin noise */
float newPerlinU(float x, float y, float z) {
	return (0.5f+0.5f*newPerlin(x, y, z));
}

/**************************/
/* END OF IMPROVED PERLIN */
/**************************/

float orgBlenderNoise(float x, float y, float z) {
	float cn1, cn2, cn3, cn4, cn5, cn6, i;
	float ox, oy, oz, jx, jy, jz;
	float n= 0.5f;
	int ix, iy, iz, b00, b01, b10, b11, b20, b21;

	ox= (x- (ix= (int)floor(x)) );
	oy= (y- (iy= (int)floor(y)) );
	oz= (z- (iz= (int)floor(z)) );

	jx= ox-1;
	jy= oy-1;
	jz= oz-1;

	cn1=ox*ox; cn2=oy*oy; cn3=oz*oz;
	cn4=jx*jx; cn5=jy*jy; cn6=jz*jz;

	cn1= 1.f-3.f*cn1+2.f*cn1*ox;
	cn2= 1.f-3.f*cn2+2.f*cn2*oy;
	cn3= 1.f-3.f*cn3+2.f*cn3*oz;
	cn4= 1.f-3.f*cn4-2.f*cn4*jx;
	cn5= 1.f-3.f*cn5-2.f*cn5*jy;
	cn6= 1.f-3.f*cn6-2.f*cn6*jz;

	b00= hash[ hash[ix & 255]+(iy & 255)];
	b10= hash[ hash[(ix+1) & 255]+(iy & 255)];
	b01= hash[ hash[ix & 255]+((iy+1) & 255)];
	b11= hash[ hash[(ix+1) & 255]+((iy+1) & 255)];

	b20=iz & 255; b21= (iz+1) & 255;

		/* 0 */
	i= (cn1*cn2*cn3);
		n+= i*(hashvectf[3*hash[b20+b00]]*ox+hashvectf[3*hash[b20+b00]+1]*oy+hashvectf[3*hash[b20+b00]+2]*oz);
		/* 1 */
	i= (cn1*cn2*cn6);
		n+= i*(hashvectf[3*hash[b21+b00]]*ox+hashvectf[3*hash[b21+b00]+1]*oy+hashvectf[3*hash[b21+b00]+2]*jz);
		/* 2 */
	i= (cn1*cn5*cn3);
		n+= i*(hashvectf[3*hash[b20+b01]]*ox+hashvectf[3*hash[b20+b01]+1]*jy+hashvectf[3*hash[b20+b01]+2]*oz);
		/* 3 */
	i= (cn1*cn5*cn6);
		n+= i*(hashvectf[3*hash[b21+b01]]*ox+hashvectf[3*hash[b21+b01]+1]*jy+hashvectf[3*hash[b21+b01]+2]*jz);
		/* 4 */
	i= cn4*cn2*cn3;
		n+= i*(hashvectf[3*hash[b20+b10]]*jx+hashvectf[3*hash[b20+b10]+1]*oy+hashvectf[3*hash[b20+b10]+2]*oz);
		/* 5 */
	i= cn4*cn2*cn6;
		n+= i*(hashvectf[3*hash[b21+b10]]*jx+hashvectf[3*hash[b21+b10]+1]*oy+hashvectf[3*hash[b21+b10]+2]*jz);
		/* 6 */
	i= cn4*cn5*cn3;
		n+=  i*(hashvectf[3*hash[b20+b11]]*jx+hashvectf[3*hash[b20+b11]+1]*jy+hashvectf[3*hash[b20+b11]+2]*oz);
		/* 7 */
	i= (cn4*cn5*cn6);
		n+= i*(hashvectf[3*hash[b21+b11]]*jx+hashvectf[3*hash[b21+b11]+1]*jy+hashvectf[3*hash[b21+b11]+2]*jz);

	if(n<0.f) n=0.f; else if(n>1.f) n=1.f;
	return n;
}

/* as orgBlenderNoise(), returning signed noise */
float orgBlenderNoiseS(float x, float y, float z) {
	return (2.f*orgBlenderNoise(x, y, z)-1.f);
}

/* ********************* FROM PERLIN HIMSELF: ******************** */
__constant unsigned char p[512+2]= {
0xA2,0xA0,0x19,0x3B,0xF8,0xEB,0xAA,0xEE,0xF3,0x1C,0x67,0x28,0x1D,0xED,0x0,0xDE,0x95,0x2E,0xDC,0x3F,0x3A,0x82,0x35,0x4D,0x6C,0xBA,0x36,0xD0,0xF6,0xC,0x79,0x32,0xD1,0x59,0xF4,0x8,0x8B,0x63,0x89,0x2F,0xB8,0xB4,0x97,0x83,0xF2,0x8F,0x18,0xC7,0x51,0x14,0x65,0x87,0x48,0x20,0x42,0xA8,0x80,0xB5,0x40,0x13,0xB2,0x22,0x7E,0x57,
0xBC,0x7F,0x6B,0x9D,0x86,0x4C,0xC8,0xDB,0x7C,0xD5,0x25,0x4E,0x5A,0x55,0x74,0x50,0xCD,0xB3,0x7A,0xBB,0xC3,0xCB,0xB6,0xE2,0xE4,0xEC,0xFD,0x98,0xB,0x96,0xD3,0x9E,0x5C,0xA1,0x64,0xF1,0x81,0x61,0xE1,0xC4,0x24,0x72,0x49,0x8C,0x90,0x4B,0x84,0x34,0x38,0xAB,0x78,0xCA,0x1F,0x1,0xD7,0x93,0x11,0xC1,0x58,0xA9,0x31,0xF9,0x44,0x6D,
0xBF,0x33,0x9C,0x5F,0x9,0x94,0xA3,0x85,0x6,0xC6,0x9A,0x1E,0x7B,0x46,0x15,0x30,0x27,0x2B,0x1B,0x71,0x3C,0x5B,0xD6,0x6F,0x62,0xAC,0x4F,0xC2,0xC0,0xE,0xB1,0x23,0xA7,0xDF,0x47,0xB0,0x77,0x69,0x5,0xE9,0xE6,0xE7,0x76,0x73,0xF,0xFE,0x6E,0x9B,0x56,0xEF,0x12,0xA5,0x37,0xFC,0xAE,0xD9,0x3,0x8E,0xDD,0x10,0xB9,0xCE,0xC9,0x8D,
0xDA,0x2A,0xBD,0x68,0x17,0x9F,0xBE,0xD4,0xA,0xCC,0xD2,0xE8,0x43,0x3D,0x70,0xB7,0x2,0x7D,0x99,0xD8,0xD,0x60,0x8A,0x4,0x2C,0x3E,0x92,0xE5,0xAF,0x53,0x7,0xE0,0x29,0xA6,0xC5,0xE3,0xF5,0xF7,0x4A,0x41,0x26,0x6A,0x16,0x5E,0x52,0x2D,0x21,0xAD,0xF0,0x91,0xFF,0xEA,0x54,0xFA,0x66,0x1A,0x45,0x39,0xCF,0x75,0xA4,0x88,0xFB,0x5D,
0xA2,0xA0,0x19,0x3B,0xF8,0xEB,0xAA,0xEE,0xF3,0x1C,0x67,0x28,0x1D,0xED,0x0,0xDE,0x95,0x2E,0xDC,0x3F,0x3A,0x82,0x35,0x4D,0x6C,0xBA,0x36,0xD0,0xF6,0xC,0x79,0x32,0xD1,0x59,0xF4,0x8,0x8B,0x63,0x89,0x2F,0xB8,0xB4,0x97,0x83,0xF2,0x8F,0x18,0xC7,0x51,0x14,0x65,0x87,0x48,0x20,0x42,0xA8,0x80,0xB5,0x40,0x13,0xB2,0x22,0x7E,0x57,
0xBC,0x7F,0x6B,0x9D,0x86,0x4C,0xC8,0xDB,0x7C,0xD5,0x25,0x4E,0x5A,0x55,0x74,0x50,0xCD,0xB3,0x7A,0xBB,0xC3,0xCB,0xB6,0xE2,0xE4,0xEC,0xFD,0x98,0xB,0x96,0xD3,0x9E,0x5C,0xA1,0x64,0xF1,0x81,0x61,0xE1,0xC4,0x24,0x72,0x49,0x8C,0x90,0x4B,0x84,0x34,0x38,0xAB,0x78,0xCA,0x1F,0x1,0xD7,0x93,0x11,0xC1,0x58,0xA9,0x31,0xF9,0x44,0x6D,
0xBF,0x33,0x9C,0x5F,0x9,0x94,0xA3,0x85,0x6,0xC6,0x9A,0x1E,0x7B,0x46,0x15,0x30,0x27,0x2B,0x1B,0x71,0x3C,0x5B,0xD6,0x6F,0x62,0xAC,0x4F,0xC2,0xC0,0xE,0xB1,0x23,0xA7,0xDF,0x47,0xB0,0x77,0x69,0x5,0xE9,0xE6,0xE7,0x76,0x73,0xF,0xFE,0x6E,0x9B,0x56,0xEF,0x12,0xA5,0x37,0xFC,0xAE,0xD9,0x3,0x8E,0xDD,0x10,0xB9,0xCE,0xC9,0x8D,
0xDA,0x2A,0xBD,0x68,0x17,0x9F,0xBE,0xD4,0xA,0xCC,0xD2,0xE8,0x43,0x3D,0x70,0xB7,0x2,0x7D,0x99,0xD8,0xD,0x60,0x8A,0x4,0x2C,0x3E,0x92,0xE5,0xAF,0x53,0x7,0xE0,0x29,0xA6,0xC5,0xE3,0xF5,0xF7,0x4A,0x41,0x26,0x6A,0x16,0x5E,0x52,0x2D,0x21,0xAD,0xF0,0x91,0xFF,0xEA,0x54,0xFA,0x66,0x1A,0x45,0x39,0xCF,0x75,0xA4,0x88,0xFB,0x5D,
0xA2,0xA0};

__constant float g[512+2][3]= {
	{0.33783f, 0.715698f, -0.611206f},
	{-0.944031f, -0.326599f, -0.045624f},
	{-0.101074f, -0.416443f, -0.903503f},
	{0.799286f, 0.49411f, -0.341949f},
	{-0.854645f, 0.518036f, 0.033936f},
	{0.42514f, -0.437866f, -0.792114f},
	{-0.358948f, 0.597046f, 0.717377f},
	{-0.985413f, 0.144714f, 0.089294f},
	{-0.601776f, -0.33728f, -0.723907f},
	{-0.449921f, 0.594513f, 0.666382f},
	{0.208313f, -0.10791f, 0.972076f},
	{0.575317f, 0.060425f, 0.815643f},
	{0.293365f, -0.875702f, -0.383453f},
	{0.293762f, 0.465759f, 0.834686f},
	{-0.846008f, -0.233398f, -0.47934f},
	{-0.115814f, 0.143036f, -0.98291f},
	{0.204681f, -0.949036f, -0.239532f},
	{0.946716f, -0.263947f, 0.184326f},
	{-0.235596f, 0.573822f, 0.784332f},
	{0.203705f, -0.372253f, -0.905487f},
	{0.756989f, -0.651031f, 0.055298f},
	{0.497803f, 0.814697f, -0.297363f},
	{-0.16214f, 0.063995f, -0.98468f},
	{-0.329254f, 0.834381f, 0.441925f},
	{0.703827f, -0.527039f, -0.476227f},
	{0.956421f, 0.266113f, 0.119781f},
	{0.480133f, 0.482849f, 0.7323f},
	{-0.18631f, 0.961212f, -0.203125f},
	{-0.748474f, -0.656921f, -0.090393f},
	{-0.085052f, -0.165253f, 0.982544f},
	{-0.76947f, 0.628174f, -0.115234f},
	{0.383148f, 0.537659f, 0.751068f},
	{0.616486f, -0.668488f, -0.415924f},
	{-0.259979f, -0.630005f, 0.73175f},
	{0.570953f, -0.087952f, 0.816223f},
	{-0.458008f, 0.023254f, 0.888611f},
	{-0.196167f, 0.976563f, -0.088287f},
	{-0.263885f, -0.69812f, -0.665527f},
	{0.437134f, -0.892273f, -0.112793f},
	{-0.621674f, -0.230438f, 0.748566f},
	{0.232422f, 0.900574f, -0.367249f},
	{0.22229f, -0.796143f, 0.562744f},
	{-0.665497f, -0.73764f, 0.11377f},
	{0.670135f, 0.704803f, 0.232605f},
	{0.895599f, 0.429749f, -0.114655f},
	{-0.11557f, -0.474243f, 0.872742f},
	{0.621826f, 0.604004f, -0.498444f},
	{-0.832214f, 0.012756f, 0.55426f},
	{-0.702484f, 0.705994f, -0.089661f},
	{-0.692017f, 0.649292f, 0.315399f},
	{-0.175995f, -0.977997f, 0.111877f},
	{0.096954f, -0.04953f, 0.994019f},
	{0.635284f, -0.606689f, -0.477783f},
	{-0.261261f, -0.607422f, -0.750153f},
	{0.983276f, 0.165436f, 0.075958f},
	{-0.29837f, 0.404083f, -0.864655f},
	{-0.638672f, 0.507721f, 0.578156f},
	{0.388214f, 0.412079f, 0.824249f},
	{0.556183f, -0.208832f, 0.804352f},
	{0.778442f, 0.562012f, 0.27951f},
	{-0.616577f, 0.781921f, -0.091522f},
	{0.196289f, 0.051056f, 0.979187f},
	{-0.121216f, 0.207153f, -0.970734f},
	{-0.173401f, -0.384735f, 0.906555f},
	{0.161499f, -0.723236f, -0.671387f},
	{0.178497f, -0.006226f, -0.983887f},
	{-0.126038f, 0.15799f, 0.97934f},
	{0.830475f, -0.024811f, 0.556458f},
	{-0.510132f, -0.76944f, 0.384247f},
	{0.81424f, 0.200104f, -0.544891f},
	{-0.112549f, -0.393311f, -0.912445f},
	{0.56189f, 0.152222f, -0.813049f},
	{0.198914f, -0.254517f, -0.946381f},
	{-0.41217f, 0.690979f, -0.593811f},
	{-0.407257f, 0.324524f, 0.853668f},
	{-0.690186f, 0.366119f, -0.624115f},
	{-0.428345f, 0.844147f, -0.322296f},
	{-0.21228f, -0.297546f, -0.930756f},
	{-0.273071f, 0.516113f, 0.811798f},
	{0.928314f, 0.371643f, 0.007233f},
	{0.785828f, -0.479218f, -0.390778f},
	{-0.704895f, 0.058929f, 0.706818f},
	{0.173248f, 0.203583f, 0.963562f},
	{0.422211f, -0.904297f, -0.062469f},
	{-0.363312f, -0.182465f, 0.913605f},
	{0.254028f, -0.552307f, -0.793945f},
	{-0.28891f, -0.765747f, -0.574554f},
	{0.058319f, 0.291382f, 0.954803f},
	{0.946136f, -0.303925f, 0.111267f},
	{-0.078156f, 0.443695f, -0.892731f},
	{0.182098f, 0.89389f, 0.409515f},
	{-0.680298f, -0.213318f, 0.701141f},
	{0.062469f, 0.848389f, -0.525635f},
	{-0.72879f, -0.641846f, 0.238342f},
	{-0.88089f, 0.427673f, 0.202637f},
	{-0.532501f, -0.21405f, 0.818878f},
	{0.948975f, -0.305084f, 0.07962f},
	{0.925446f, 0.374664f, 0.055817f},
	{0.820923f, 0.565491f, 0.079102f},
	{0.25882f, 0.099792f, -0.960724f},
	{-0.294617f, 0.910522f, 0.289978f},
	{0.137115f, 0.320038f, -0.937408f},
	{-0.908386f, 0.345276f, -0.235718f},
	{-0.936218f, 0.138763f, 0.322754f},
	{0.366577f, 0.925934f, -0.090637f},
	{0.309296f, -0.686829f, -0.657684f},
	{0.66983f, 0.024445f, 0.742065f},
	{-0.917999f, -0.059113f, -0.392059f},
	{0.365509f, 0.462158f, -0.807922f},
	{0.083374f, 0.996399f, -0.014801f},
	{0.593842f, 0.253143f, -0.763672f},
	{0.974976f, -0.165466f, 0.148285f},
	{0.918976f, 0.137299f, 0.369537f},
	{0.294952f, 0.694977f, 0.655731f},
	{0.943085f, 0.152618f, -0.295319f},
	{0.58783f, -0.598236f, 0.544495f},
	{0.203796f, 0.678223f, 0.705994f},
	{-0.478821f, -0.661011f, 0.577667f},
	{0.719055f, -0.1698f, -0.673828f},
	{-0.132172f, -0.965332f, 0.225006f},
	{-0.981873f, -0.14502f, 0.121979f},
	{0.763458f, 0.579742f, 0.284546f},
	{-0.893188f, 0.079681f, 0.442474f},
	{-0.795776f, -0.523804f, 0.303802f},
	{0.734955f, 0.67804f, -0.007446f},
	{0.15506f, 0.986267f, -0.056183f},
	{0.258026f, 0.571503f, -0.778931f},
	{-0.681549f, -0.702087f, -0.206116f},
	{-0.96286f, -0.177185f, 0.203613f},
	{-0.470978f, -0.515106f, 0.716095f},
	{-0.740326f, 0.57135f, 0.354095f},
	{-0.56012f, -0.824982f, -0.074982f},
	{-0.507874f, 0.753204f, 0.417969f},
	{-0.503113f, 0.038147f, 0.863342f},
	{0.594025f, 0.673553f, -0.439758f},
	{-0.119873f, -0.005524f, -0.992737f},
	{0.098267f, -0.213776f, 0.971893f},
	{-0.615631f, 0.643951f, 0.454163f},
	{0.896851f, -0.441071f, 0.032166f},
	{-0.555023f, 0.750763f, -0.358093f},
	{0.398773f, 0.304688f, 0.864929f},
	{-0.722961f, 0.303589f, 0.620544f},
	{-0.63559f, -0.621948f, -0.457306f},
	{-0.293243f, 0.072327f, 0.953278f},
	{-0.491638f, 0.661041f, -0.566772f},
	{-0.304199f, -0.572083f, -0.761688f},
	{0.908081f, -0.398956f, 0.127014f},
	{-0.523621f, -0.549683f, -0.650848f},
	{-0.932922f, -0.19986f, 0.299408f},
	{0.099426f, 0.140869f, 0.984985f},
	{-0.020325f, -0.999756f, -0.002319f},
	{0.952667f, 0.280853f, -0.11615f},
	{-0.971893f, 0.082581f, 0.220337f},
	{0.65921f, 0.705292f, -0.260651f},
	{0.733063f, -0.175537f, 0.657043f},
	{-0.555206f, 0.429504f, -0.712189f},
	{0.400421f, -0.89859f, 0.179352f},
	{0.750885f, -0.19696f, 0.630341f},
	{0.785675f, -0.569336f, 0.241821f},
	{-0.058899f, -0.464111f, 0.883789f},
	{0.129608f, -0.94519f, 0.299622f},
	{-0.357819f, 0.907654f, 0.219238f},
	{-0.842133f, -0.439117f, -0.312927f},
	{-0.313477f, 0.84433f, 0.434479f},
	{-0.241211f, 0.053253f, 0.968994f},
	{0.063873f, 0.823273f, 0.563965f},
	{0.476288f, 0.862152f, -0.172516f},
	{0.620941f, -0.298126f, 0.724915f},
	{0.25238f, -0.749359f, -0.612122f},
	{-0.577545f, 0.386566f, 0.718994f},
	{-0.406342f, -0.737976f, 0.538696f},
	{0.04718f, 0.556305f, 0.82959f},
	{-0.802856f, 0.587463f, 0.101166f},
	{-0.707733f, -0.705963f, 0.026428f},
	{0.374908f, 0.68457f, 0.625092f},
	{0.472137f, 0.208405f, -0.856506f},
	{-0.703064f, -0.581085f, -0.409821f},
	{-0.417206f, -0.736328f, 0.532623f},
	{-0.447876f, -0.20285f, -0.870728f},
	{0.086945f, -0.990417f, 0.107086f},
	{0.183685f, 0.018341f, -0.982788f},
	{0.560638f, -0.428864f, 0.708282f},
	{0.296722f, -0.952576f, -0.0672f},
	{0.135773f, 0.990265f, 0.030243f},
	{-0.068787f, 0.654724f, 0.752686f},
	{0.762604f, -0.551758f, 0.337585f},
	{-0.819611f, -0.407684f, 0.402466f},
	{-0.727844f, -0.55072f, -0.408539f},
	{-0.855774f, -0.480011f, 0.19281f},
	{0.693176f, -0.079285f, 0.716339f},
	{0.226013f, 0.650116f, -0.725433f},
	{0.246704f, 0.953369f, -0.173553f},
	{-0.970398f, -0.239227f, -0.03244f},
	{0.136383f, -0.394318f, 0.908752f},
	{0.813232f, 0.558167f, 0.164368f},
	{0.40451f, 0.549042f, -0.731323f},
	{-0.380249f, -0.566711f, 0.730865f},
	{0.022156f, 0.932739f, 0.359741f},
	{0.00824f, 0.996552f, -0.082306f},
	{0.956635f, -0.065338f, -0.283722f},
	{-0.743561f, 0.008209f, 0.668579f},
	{-0.859589f, -0.509674f, 0.035767f},
	{-0.852234f, 0.363678f, -0.375977f},
	{-0.201965f, -0.970795f, -0.12915f},
	{0.313477f, 0.947327f, 0.06546f},
	{-0.254028f, -0.528259f, 0.81015f},
	{0.628052f, 0.601105f, 0.49411f},
	{-0.494385f, 0.868378f, 0.037933f},
	{0.275635f, -0.086426f, 0.957336f},
	{-0.197937f, 0.468903f, -0.860748f},
	{0.895599f, 0.399384f, 0.195801f},
	{0.560791f, 0.825012f, -0.069214f},
	{0.304199f, -0.849487f, 0.43103f},
	{0.096375f, 0.93576f, 0.339111f},
	{-0.051422f, 0.408966f, -0.911072f},
	{0.330444f, 0.942841f, -0.042389f},
	{-0.452362f, -0.786407f, 0.420563f},
	{0.134308f, -0.933472f, -0.332489f},
	{0.80191f, -0.566711f, -0.188934f},
	{-0.987946f, -0.105988f, 0.112518f},
	{-0.24408f, 0.892242f, -0.379791f},
	{-0.920502f, 0.229095f, -0.316376f},
	{0.7789f, 0.325958f, 0.535706f},
	{-0.912872f, 0.185211f, -0.36377f},
	{-0.184784f, 0.565369f, -0.803833f},
	{-0.018463f, 0.119537f, 0.992615f},
	{-0.259247f, -0.935608f, 0.239532f},
	{-0.82373f, -0.449127f, -0.345947f},
	{-0.433105f, 0.659515f, 0.614349f},
	{-0.822754f, 0.378845f, -0.423676f},
	{0.687195f, -0.674835f, -0.26889f},
	{-0.246582f, -0.800842f, 0.545715f},
	{-0.729187f, -0.207794f, 0.651978f},
	{0.653534f, -0.610443f, -0.447388f},
	{0.492584f, -0.023346f, 0.869934f},
	{0.609039f, 0.009094f, -0.79306f},
	{0.962494f, -0.271088f, -0.00885f},
	{0.2659f, -0.004913f, 0.963959f},
	{0.651245f, 0.553619f, -0.518951f},
	{0.280548f, -0.84314f, 0.458618f},
	{-0.175293f, -0.983215f, 0.049805f},
	{0.035339f, -0.979919f, 0.196045f},
	{-0.982941f, 0.164307f, -0.082245f},
	{0.233734f, -0.97226f, -0.005005f},
	{-0.747253f, -0.611328f, 0.260437f},
	{0.645599f, 0.592773f, 0.481384f},
	{0.117706f, -0.949524f, -0.29068f},
	{-0.535004f, -0.791901f, -0.294312f},
	{-0.627167f, -0.214447f, 0.748718f},
	{-0.047974f, -0.813477f, -0.57959f},
	{-0.175537f, 0.477264f, -0.860992f},
	{0.738556f, -0.414246f, -0.53183f},
	{0.562561f, -0.704071f, 0.433289f},
	{-0.754944f, 0.64801f, -0.100586f},
	{0.114716f, 0.044525f, -0.992371f},
	{0.966003f, 0.244873f, -0.082764f},
	{0.33783f, 0.715698f, -0.611206f},
	{-0.944031f, -0.326599f, -0.045624f},
	{-0.101074f, -0.416443f, -0.903503f},
	{0.799286f, 0.49411f, -0.341949f},
	{-0.854645f, 0.518036f, 0.033936f},
	{0.42514f, -0.437866f, -0.792114f},
	{-0.358948f, 0.597046f, 0.717377f},
	{-0.985413f, 0.144714f, 0.089294f},
	{-0.601776f, -0.33728f, -0.723907f},
	{-0.449921f, 0.594513f, 0.666382f},
	{0.208313f, -0.10791f, 0.972076f},
	{0.575317f, 0.060425f, 0.815643f},
	{0.293365f, -0.875702f, -0.383453f},
	{0.293762f, 0.465759f, 0.834686f},
	{-0.846008f, -0.233398f, -0.47934f},
	{-0.115814f, 0.143036f, -0.98291f},
	{0.204681f, -0.949036f, -0.239532f},
	{0.946716f, -0.263947f, 0.184326f},
	{-0.235596f, 0.573822f, 0.784332f},
	{0.203705f, -0.372253f, -0.905487f},
	{0.756989f, -0.651031f, 0.055298f},
	{0.497803f, 0.814697f, -0.297363f},
	{-0.16214f, 0.063995f, -0.98468f},
	{-0.329254f, 0.834381f, 0.441925f},
	{0.703827f, -0.527039f, -0.476227f},
	{0.956421f, 0.266113f, 0.119781f},
	{0.480133f, 0.482849f, 0.7323f},
	{-0.18631f, 0.961212f, -0.203125f},
	{-0.748474f, -0.656921f, -0.090393f},
	{-0.085052f, -0.165253f, 0.982544f},
	{-0.76947f, 0.628174f, -0.115234f},
	{0.383148f, 0.537659f, 0.751068f},
	{0.616486f, -0.668488f, -0.415924f},
	{-0.259979f, -0.630005f, 0.73175f},
	{0.570953f, -0.087952f, 0.816223f},
	{-0.458008f, 0.023254f, 0.888611f},
	{-0.196167f, 0.976563f, -0.088287f},
	{-0.263885f, -0.69812f, -0.665527f},
	{0.437134f, -0.892273f, -0.112793f},
	{-0.621674f, -0.230438f, 0.748566f},
	{0.232422f, 0.900574f, -0.367249f},
	{0.22229f, -0.796143f, 0.562744f},
	{-0.665497f, -0.73764f, 0.11377f},
	{0.670135f, 0.704803f, 0.232605f},
	{0.895599f, 0.429749f, -0.114655f},
	{-0.11557f, -0.474243f, 0.872742f},
	{0.621826f, 0.604004f, -0.498444f},
	{-0.832214f, 0.012756f, 0.55426f},
	{-0.702484f, 0.705994f, -0.089661f},
	{-0.692017f, 0.649292f, 0.315399f},
	{-0.175995f, -0.977997f, 0.111877f},
	{0.096954f, -0.04953f, 0.994019f},
	{0.635284f, -0.606689f, -0.477783f},
	{-0.261261f, -0.607422f, -0.750153f},
	{0.983276f, 0.165436f, 0.075958f},
	{-0.29837f, 0.404083f, -0.864655f},
	{-0.638672f, 0.507721f, 0.578156f},
	{0.388214f, 0.412079f, 0.824249f},
	{0.556183f, -0.208832f, 0.804352f},
	{0.778442f, 0.562012f, 0.27951f},
	{-0.616577f, 0.781921f, -0.091522f},
	{0.196289f, 0.051056f, 0.979187f},
	{-0.121216f, 0.207153f, -0.970734f},
	{-0.173401f, -0.384735f, 0.906555f},
	{0.161499f, -0.723236f, -0.671387f},
	{0.178497f, -0.006226f, -0.983887f},
	{-0.126038f, 0.15799f, 0.97934f},
	{0.830475f, -0.024811f, 0.556458f},
	{-0.510132f, -0.76944f, 0.384247f},
	{0.81424f, 0.200104f, -0.544891f},
	{-0.112549f, -0.393311f, -0.912445f},
	{0.56189f, 0.152222f, -0.813049f},
	{0.198914f, -0.254517f, -0.946381f},
	{-0.41217f, 0.690979f, -0.593811f},
	{-0.407257f, 0.324524f, 0.853668f},
	{-0.690186f, 0.366119f, -0.624115f},
	{-0.428345f, 0.844147f, -0.322296f},
	{-0.21228f, -0.297546f, -0.930756f},
	{-0.273071f, 0.516113f, 0.811798f},
	{0.928314f, 0.371643f, 0.007233f},
	{0.785828f, -0.479218f, -0.390778f},
	{-0.704895f, 0.058929f, 0.706818f},
	{0.173248f, 0.203583f, 0.963562f},
	{0.422211f, -0.904297f, -0.062469f},
	{-0.363312f, -0.182465f, 0.913605f},
	{0.254028f, -0.552307f, -0.793945f},
	{-0.28891f, -0.765747f, -0.574554f},
	{0.058319f, 0.291382f, 0.954803f},
	{0.946136f, -0.303925f, 0.111267f},
	{-0.078156f, 0.443695f, -0.892731f},
	{0.182098f, 0.89389f, 0.409515f},
	{-0.680298f, -0.213318f, 0.701141f},
	{0.062469f, 0.848389f, -0.525635f},
	{-0.72879f, -0.641846f, 0.238342f},
	{-0.88089f, 0.427673f, 0.202637f},
	{-0.532501f, -0.21405f, 0.818878f},
	{0.948975f, -0.305084f, 0.07962f},
	{0.925446f, 0.374664f, 0.055817f},
	{0.820923f, 0.565491f, 0.079102f},
	{0.25882f, 0.099792f, -0.960724f},
	{-0.294617f, 0.910522f, 0.289978f},
	{0.137115f, 0.320038f, -0.937408f},
	{-0.908386f, 0.345276f, -0.235718f},
	{-0.936218f, 0.138763f, 0.322754f},
	{0.366577f, 0.925934f, -0.090637f},
	{0.309296f, -0.686829f, -0.657684f},
	{0.66983f, 0.024445f, 0.742065f},
	{-0.917999f, -0.059113f, -0.392059f},
	{0.365509f, 0.462158f, -0.807922f},
	{0.083374f, 0.996399f, -0.014801f},
	{0.593842f, 0.253143f, -0.763672f},
	{0.974976f, -0.165466f, 0.148285f},
	{0.918976f, 0.137299f, 0.369537f},
	{0.294952f, 0.694977f, 0.655731f},
	{0.943085f, 0.152618f, -0.295319f},
	{0.58783f, -0.598236f, 0.544495f},
	{0.203796f, 0.678223f, 0.705994f},
	{-0.478821f, -0.661011f, 0.577667f},
	{0.719055f, -0.1698f, -0.673828f},
	{-0.132172f, -0.965332f, 0.225006f},
	{-0.981873f, -0.14502f, 0.121979f},
	{0.763458f, 0.579742f, 0.284546f},
	{-0.893188f, 0.079681f, 0.442474f},
	{-0.795776f, -0.523804f, 0.303802f},
	{0.734955f, 0.67804f, -0.007446f},
	{0.15506f, 0.986267f, -0.056183f},
	{0.258026f, 0.571503f, -0.778931f},
	{-0.681549f, -0.702087f, -0.206116f},
	{-0.96286f, -0.177185f, 0.203613f},
	{-0.470978f, -0.515106f, 0.716095f},
	{-0.740326f, 0.57135f, 0.354095f},
	{-0.56012f, -0.824982f, -0.074982f},
	{-0.507874f, 0.753204f, 0.417969f},
	{-0.503113f, 0.038147f, 0.863342f},
	{0.594025f, 0.673553f, -0.439758f},
	{-0.119873f, -0.005524f, -0.992737f},
	{0.098267f, -0.213776f, 0.971893f},
	{-0.615631f, 0.643951f, 0.454163f},
	{0.896851f, -0.441071f, 0.032166f},
	{-0.555023f, 0.750763f, -0.358093f},
	{0.398773f, 0.304688f, 0.864929f},
	{-0.722961f, 0.303589f, 0.620544f},
	{-0.63559f, -0.621948f, -0.457306f},
	{-0.293243f, 0.072327f, 0.953278f},
	{-0.491638f, 0.661041f, -0.566772f},
	{-0.304199f, -0.572083f, -0.761688f},
	{0.908081f, -0.398956f, 0.127014f},
	{-0.523621f, -0.549683f, -0.650848f},
	{-0.932922f, -0.19986f, 0.299408f},
	{0.099426f, 0.140869f, 0.984985f},
	{-0.020325f, -0.999756f, -0.002319f},
	{0.952667f, 0.280853f, -0.11615f},
	{-0.971893f, 0.082581f, 0.220337f},
	{0.65921f, 0.705292f, -0.260651f},
	{0.733063f, -0.175537f, 0.657043f},
	{-0.555206f, 0.429504f, -0.712189f},
	{0.400421f, -0.89859f, 0.179352f},
	{0.750885f, -0.19696f, 0.630341f},
	{0.785675f, -0.569336f, 0.241821f},
	{-0.058899f, -0.464111f, 0.883789f},
	{0.129608f, -0.94519f, 0.299622f},
	{-0.357819f, 0.907654f, 0.219238f},
	{-0.842133f, -0.439117f, -0.312927f},
	{-0.313477f, 0.84433f, 0.434479f},
	{-0.241211f, 0.053253f, 0.968994f},
	{0.063873f, 0.823273f, 0.563965f},
	{0.476288f, 0.862152f, -0.172516f},
	{0.620941f, -0.298126f, 0.724915f},
	{0.25238f, -0.749359f, -0.612122f},
	{-0.577545f, 0.386566f, 0.718994f},
	{-0.406342f, -0.737976f, 0.538696f},
	{0.04718f, 0.556305f, 0.82959f},
	{-0.802856f, 0.587463f, 0.101166f},
	{-0.707733f, -0.705963f, 0.026428f},
	{0.374908f, 0.68457f, 0.625092f},
	{0.472137f, 0.208405f, -0.856506f},
	{-0.703064f, -0.581085f, -0.409821f},
	{-0.417206f, -0.736328f, 0.532623f},
	{-0.447876f, -0.20285f, -0.870728f},
	{0.086945f, -0.990417f, 0.107086f},
	{0.183685f, 0.018341f, -0.982788f},
	{0.560638f, -0.428864f, 0.708282f},
	{0.296722f, -0.952576f, -0.0672f},
	{0.135773f, 0.990265f, 0.030243f},
	{-0.068787f, 0.654724f, 0.752686f},
	{0.762604f, -0.551758f, 0.337585f},
	{-0.819611f, -0.407684f, 0.402466f},
	{-0.727844f, -0.55072f, -0.408539f},
	{-0.855774f, -0.480011f, 0.19281f},
	{0.693176f, -0.079285f, 0.716339f},
	{0.226013f, 0.650116f, -0.725433f},
	{0.246704f, 0.953369f, -0.173553f},
	{-0.970398f, -0.239227f, -0.03244f},
	{0.136383f, -0.394318f, 0.908752f},
	{0.813232f, 0.558167f, 0.164368f},
	{0.40451f, 0.549042f, -0.731323f},
	{-0.380249f, -0.566711f, 0.730865f},
	{0.022156f, 0.932739f, 0.359741f},
	{0.00824f, 0.996552f, -0.082306f},
	{0.956635f, -0.065338f, -0.283722f},
	{-0.743561f, 0.008209f, 0.668579f},
	{-0.859589f, -0.509674f, 0.035767f},
	{-0.852234f, 0.363678f, -0.375977f},
	{-0.201965f, -0.970795f, -0.12915f},
	{0.313477f, 0.947327f, 0.06546f},
	{-0.254028f, -0.528259f, 0.81015f},
	{0.628052f, 0.601105f, 0.49411f},
	{-0.494385f, 0.868378f, 0.037933f},
	{0.275635f, -0.086426f, 0.957336f},
	{-0.197937f, 0.468903f, -0.860748f},
	{0.895599f, 0.399384f, 0.195801f},
	{0.560791f, 0.825012f, -0.069214f},
	{0.304199f, -0.849487f, 0.43103f},
	{0.096375f, 0.93576f, 0.339111f},
	{-0.051422f, 0.408966f, -0.911072f},
	{0.330444f, 0.942841f, -0.042389f},
	{-0.452362f, -0.786407f, 0.420563f},
	{0.134308f, -0.933472f, -0.332489f},
	{0.80191f, -0.566711f, -0.188934f},
	{-0.987946f, -0.105988f, 0.112518f},
	{-0.24408f, 0.892242f, -0.379791f},
	{-0.920502f, 0.229095f, -0.316376f},
	{0.7789f, 0.325958f, 0.535706f},
	{-0.912872f, 0.185211f, -0.36377f},
	{-0.184784f, 0.565369f, -0.803833f},
	{-0.018463f, 0.119537f, 0.992615f},
	{-0.259247f, -0.935608f, 0.239532f},
	{-0.82373f, -0.449127f, -0.345947f},
	{-0.433105f, 0.659515f, 0.614349f},
	{-0.822754f, 0.378845f, -0.423676f},
	{0.687195f, -0.674835f, -0.26889f},
	{-0.246582f, -0.800842f, 0.545715f},
	{-0.729187f, -0.207794f, 0.651978f},
	{0.653534f, -0.610443f, -0.447388f},
	{0.492584f, -0.023346f, 0.869934f},
	{0.609039f, 0.009094f, -0.79306f},
	{0.962494f, -0.271088f, -0.00885f},
	{0.2659f, -0.004913f, 0.963959f},
	{0.651245f, 0.553619f, -0.518951f},
	{0.280548f, -0.84314f, 0.458618f},
	{-0.175293f, -0.983215f, 0.049805f},
	{0.035339f, -0.979919f, 0.196045f},
	{-0.982941f, 0.164307f, -0.082245f},
	{0.233734f, -0.97226f, -0.005005f},
	{-0.747253f, -0.611328f, 0.260437f},
	{0.645599f, 0.592773f, 0.481384f},
	{0.117706f, -0.949524f, -0.29068f},
	{-0.535004f, -0.791901f, -0.294312f},
	{-0.627167f, -0.214447f, 0.748718f},
	{-0.047974f, -0.813477f, -0.57959f},
	{-0.175537f, 0.477264f, -0.860992f},
	{0.738556f, -0.414246f, -0.53183f},
	{0.562561f, -0.704071f, 0.433289f},
	{-0.754944f, 0.64801f, -0.100586f},
	{0.114716f, 0.044525f, -0.992371f},
	{0.966003f, 0.244873f, -0.082764f},
	{0.33783f, 0.715698f, -0.611206f},
	{-0.944031f, -0.326599f, -0.045624f},
};

#define DOT(a,b) (a[0] * b[0] + a[1] * b[1] + a[2] * b[2])

#define setup(i,b0,b1,r0,r1) \
        t = vec[i] + 10000.; \
        b0 = ((int)t) & 255; \
        b1 = (b0+1) & 255; \
        r0 = t - (int)t; \
        r1 = r0 - 1.;

float noise3_perlin(float vec[3]) {
	int bx0, bx1, by0, by1, bz0, bz1, b00, b10, b01, b11;
	float rx0, rx1, ry0, ry1, rz0, rz1, q0, q1, q2, sx, sy, sz, a, b, c, d, t, u, v;
	int i, j;

	setup(0, bx0,bx1, rx0,rx1);
	setup(1, by0,by1, ry0,ry1);
	setup(2, bz0,bz1, rz0,rz1);

	i = p[ bx0 ];
	j = p[ bx1 ];

	b00 = p[ i + by0 ];
	b10 = p[ j + by0 ];
	b01 = p[ i + by1 ];
	b11 = p[ j + by1 ];

#define at(rx,ry,rz) ( rx * q0 + ry * q1 + rz * q2 )

#define surve(t) ( t * t * (3.f - 2.f * t) )

/* lerp moved to improved perlin above */

	sx = surve(rx0);
	sy = surve(ry0);
	sz = surve(rz0);

	q0 = g[ b00 + bz0 ][0]; q1 = g[ b00 + bz0 ][1]; q2 = g[ b00 + bz0 ][2];
	u = at(rx0,ry0,rz0);

	q0 = g[ b10 + bz0 ][0]; q1 = g[ b10 + bz0 ][1]; q2 = g[ b10 + bz0 ][2];
	v = at(rx1,ry0,rz0);

	a = lerp(sx, u, v);

	q0 = g[ b01 + bz0 ][0]; q1 = g[ b01 + bz0 ][1]; q2 = g[ b01 + bz0 ][2];
	u = at(rx0,ry1,rz0);

	q0 = g[ b11 + bz0 ][0]; q1 = g[ b11 + bz0 ][1]; q2 = g[ b11 + bz0 ][2];
	v = at(rx1,ry1,rz0);
	b = lerp(sx, u, v);

	c = lerp(sy, a, b);          /* interpolate in y at lo x */

	q0 = g[ b00 + bz1 ][0]; q1 = g[ b00 + bz1 ][1]; q2 = g[ b00 + bz1 ][2];
	u = at(rx0,ry0,rz1);

	q0 = g[ b10 + bz1 ][0]; q1 = g[ b10 + bz1 ][1]; q2 = g[ b10 + bz1 ][2];
	v = at(rx1,ry0,rz1);
	a = lerp(sx, u, v);

	q0 = g[ b01 + bz1 ][0]; q1 = g[ b01 + bz1 ][1]; q2 = g[ b01 + bz1 ][2];
	u = at(rx0,ry1,rz1);

	q0 = g[ b11 + bz1 ][0]; q1 = g[ b11 + bz1 ][1]; q2 = g[ b11 + bz1 ][2];
	v = at(rx1,ry1,rz1);
	b = lerp(sx, u, v);

	d = lerp(sy, a, b);          /* interpolate in y at hi x */

	return 1.5f * lerp(sz, c, d); /* interpolate in z */
}

float turbulence_perlin(float *point, float lofreq, float hifreq) {
	float freq, t, p[3];

	p[0] = point[0] + 123.456f;
	p[1] = point[1];
	p[2] = point[2];

	t = 0.f;
	for (freq = lofreq ; freq < hifreq ; freq *= 2.f) {
		t += fabs(noise3_perlin(p)) / freq;
		p[0] *= 2.f;
		p[1] *= 2.f;
		p[2] *= 2.f;
	}
	return t - 0.3f; /* readjust to make mean value = 0.0 */
}

/* for use with BLI_gNoise/gTurbulence, returns signed noise */
float orgPerlinNoise(float x, float y, float z) {
	float v[3];

	v[0] = x;
	v[1] = y;
	v[2] = z;
	return noise3_perlin(v);
}

/* for use with BLI_gNoise/gTurbulence, returns unsigned noise */
float orgPerlinNoiseU(float x, float y, float z) {
	float v[3];

	v[0] = x;
	v[1] = y;
	v[2] = z;
	return (0.5f+0.5f*noise3_perlin(v));
}

/* *************** CALL AS: *************** */
float BLI_hnoisep(float noisesize, float x, float y, float z) {
	float vec[3];

	vec[0]= x/noisesize;
	vec[1]= y/noisesize;
	vec[2]= z/noisesize;

	return noise3_perlin(vec);
}

float turbulencep(float noisesize, float x, float y, float z, int nr) {
	float vec[3];

	vec[0]= x/noisesize;
	vec[1]= y/noisesize;
	vec[2]= z/noisesize;
	nr++;
	return turbulence_perlin(vec, 1.f, (float)(1<<nr));
}
#line 2 "texture_blender_noise_funcs2.cl"

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

//------------------------------------------------------------------------------
// Blender Texture utility functions
//------------------------------------------------------------------------------
/******************/
/* VORONOI/WORLEY */
/******************/

/* distance metrics for voronoi, e parameter only used in Minkovsky */
/* Camberra omitted, didn't seem useful */

/* distance squared */
float dist_Squared(float x, float y, float z, float e) { return (x*x + y*y + z*z); }
/* real distance */
float dist_Real(float x, float y, float z, float e) { return sqrt(x*x + y*y + z*z); }
/* manhattan/taxicab/cityblock distance */
float dist_Manhattan(float x, float y, float z, float e) { return (fabs(x) + fabs(y) + fabs(z)); }
/* Chebychev */
float dist_Chebychev(float x, float y, float z, float e) {
	float t;
	x = fabs(x);
	y = fabs(y);
	z = fabs(z);
	t = (x>y)?x:y;
	return ((z>t)?z:t);
}

/* minkovsky preset exponent 0.5 */
float dist_MinkovskyH(float x, float y, float z, float e) {
	float d = sqrt(fabs(x)) + sqrt(fabs(y)) + sqrt(fabs(z));
	return (d*d);
}

/* minkovsky preset exponent 4 */
float dist_Minkovsky4(float x, float y, float z, float e) {
	x *= x;
	y *= y;
	z *= z;
	return sqrt(sqrt(x*x + y*y + z*z));
}

/* Minkovsky, general case, slow, maybe too slow to be useful */
float dist_Minkovsky(float x, float y, float z, float e) {
	return pow(pow(fabs(x), e) + pow(fabs(y), e) + pow(fabs(z), e), 1.f/e);
}

/* Not 'pure' Worley, but the results are virtually the same.
	 Returns distances in da and point coords in pa */
void voronoi(float x, float y, float z, float* da, float* pa, float me, DistanceMetric dtype) {
	int xx, yy, zz, xi, yi, zi;
	float xd, yd, zd, d, p0, p1, p2;

	xi = (int)(floor(x));
	yi = (int)(floor(y));
	zi = (int)(floor(z));
	da[0] = da[1] = da[2] = da[3] = 1e10f;
	for (xx=xi-1;xx<=xi+1;xx++) {
		for (yy=yi-1;yy<=yi+1;yy++) {
			for (zz=zi-1;zz<=zi+1;zz++) {

				p0 = hashpntf[3*hash[ (hash[ (hash[(zz) & 255]+(yy)) & 255]+(xx)) & 255]];
				p1 = hashpntf[3*hash[ (hash[ (hash[(zz) & 255]+(yy)) & 255]+(xx)) & 255]+1];
				p2 = hashpntf[3*hash[ (hash[ (hash[(zz) & 255]+(yy)) & 255]+(xx)) & 255]+2];
				xd = x - (p0 + xx);
				yd = y - (p1 + yy);
				zd = z - (p2 + zz);
				switch (dtype) {
					case DISTANCE_SQUARED:
						d = dist_Squared(xd, yd, zd, me);
						break;
					case MANHATTAN:
						d = dist_Manhattan(xd, yd, zd, me);
						break;
					case CHEBYCHEV:
						d = dist_Chebychev(xd, yd, zd, me);
						break;
					case MINKOWSKI_HALF:
						d = dist_MinkovskyH(xd, yd, zd, me);
						break;
					case MINKOWSKI_FOUR:
						d = dist_Minkovsky4(xd, yd, zd, me);
						break;
					case MINKOWSKI:
						d = dist_Minkovsky(xd, yd, zd, me);
						break;
					case ACTUAL_DISTANCE:
					default:
						d = dist_Real(xd, yd, zd, me);
				}

				if (d<da[0]) {
					da[3]=da[2];  da[2]=da[1];  da[1]=da[0];  da[0]=d;
					pa[9]=pa[6];  pa[10]=pa[7];  pa[11]=pa[8];
					pa[6]=pa[3];  pa[7]=pa[4];  pa[8]=pa[5];
					pa[3]=pa[0];  pa[4]=pa[1];  pa[5]=pa[2];
					pa[0]=p0+xx;  pa[1]=p1+yy;  pa[2]=p2+zz;
				}
				else if (d<da[1]) {
					da[3]=da[2];  da[2]=da[1];  da[1]=d;
					pa[9]=pa[6];  pa[10]=pa[7];  pa[11]=pa[8];
					pa[6]=pa[3];  pa[7]=pa[4];  pa[8]=pa[5];
					pa[3]=p0+xx;  pa[4]=p1+yy;  pa[5]=p2+zz;
				}
				else if (d<da[2]) {
					da[3]=da[2];  da[2]=d;
					pa[9]=pa[6];  pa[10]=pa[7];  pa[11]=pa[8];
					pa[6]=p0+xx;  pa[7]=p1+yy;  pa[8]=p2+zz;
				}
				else if (d<da[3]) {
					da[3]=d;
					pa[9]=p0+xx;  pa[10]=p1+yy;  pa[11]=p2+zz;
				}
			}
		}
	}
}

/* returns different feature points for use in BLI_gNoise() */
float voronoi_F1(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return da[0];
}

float voronoi_F2(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return da[1];
}

float voronoi_F3(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return da[2];
}

float voronoi_F4(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return da[3];
}

float voronoi_F1F2(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return (da[1]-da[0]);
}

/* Crackle type pattern, just a scale/clamp of F2-F1 */
float voronoi_Cr(float x, float y, float z) {
	float t = 10.f*voronoi_F1F2(x, y, z);
	if (t>1.f) return 1.f;
	return t;
}

/* Signed version of all 6 of the above, just 2x-1, not really correct though (range is potentially (0, sqrt(6)).
   Used in the musgrave functions */
float voronoi_F1S(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return (2.f*da[0]-1.f);
}

float voronoi_F2S(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return (2.f*da[1]-1.f);
}

float voronoi_F3S(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return (2.f*da[2]-1.f);
}

float voronoi_F4S(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return (2.f*da[3]-1.f);
}

float voronoi_F1F2S(float x, float y, float z) {
	float da[4], pa[12];
	voronoi(x, y, z, da, pa, 1.f, ACTUAL_DISTANCE);
	return (2.f*(da[1]-da[0])-1.f);
}

/* Crackle type pattern, just a scale/clamp of F2-F1 */
float voronoi_CrS(float x, float y, float z) {
	float t = 10.f*voronoi_F1F2(x, y, z);
	if (t>1.f) return 1.f;
	return (2.f*t-1.f);
}

/***************/
/* voronoi end */
/***************/

/*************/
/* CELLNOISE */
/*************/

/* returns unsigned cellnoise */
float cellNoiseU(float x, float y, float z) {
  int xi = (int)(floor(x));
  int yi = (int)(floor(y));
  int zi = (int)(floor(z));
  unsigned int n = xi + yi*1301 + zi*314159;
  n ^= (n<<13);
  return ((float)(n*(n*n*15731 + 789221) + 1376312589) / 4294967296.f);
}

/* idem, signed */
float cellNoise(float x, float y, float z) {
  return (2.f*cellNoiseU(x, y, z)-1.f);
}

/* returns a vector/point/color in ca, using point hasharray directly */
void cellNoiseV(float x, float y, float z, float *ca) {
	int xi = (int)(floor(x));
	int yi = (int)(floor(y));
	int zi = (int)(floor(z));

	ca[0] = hashpntf[3*hash[ (hash[ (hash[(zi) & 255]+(yi)) & 255]+(xi)) & 255]];
	ca[1] = hashpntf[3*hash[ (hash[ (hash[(zi) & 255]+(yi)) & 255]+(xi)) & 255]+1];
	ca[2] = hashpntf[3*hash[ (hash[ (hash[(zi) & 255]+(yi)) & 255]+(xi)) & 255]+2];
}

/*****************/
/* end cellnoise */
/*****************/

float noisefuncS(BlenderNoiseBasis noisebasis, float x, float y, float z) {
	float result;
	switch (noisebasis) {
		case ORIGINAL_PERLIN:
			result = orgPerlinNoise(x, y, z);
			break;
		case IMPROVED_PERLIN:
			result = newPerlin(x, y, z);
			break;
		case VORONOI_F1:
			result = voronoi_F1S(x, y, z);
			break;
		case VORONOI_F2:
			result = voronoi_F2S(x, y, z);
			break;
		case VORONOI_F3:
			result = voronoi_F3S(x, y, z);
			break;
		case VORONOI_F4:
			result = voronoi_F4S(x, y, z);
			break;
		case VORONOI_F2_F1:
			result = voronoi_F1F2S(x, y, z);
			break;
		case VORONOI_CRACKLE:
			result = voronoi_CrS(x, y, z);
			break;
		case CELL_NOISE:
			result = cellNoise(x, y, z);
			break;
		case BLENDER_ORIGINAL:
		default: {
			result = orgBlenderNoiseS(x, y, z);
		}
	}
	return result;
}

/*
 * The following code is based on Ken Musgrave's explanations and sample
 * source code in the book "Texturing and Modelling: A procedural approach"
 */

/*
 * Procedural fBm evaluated at "point"; returns value stored in "value".
 *
 * Parameters:
 *    ``H''  is the fractal increment parameter
 *    ``lacunarity''  is the gap between successive frequencies
 *    ``octaves''  is the number of frequencies in the fBm
 */
float mg_fBm(float x, float y, float z, float H, float lacunarity, float octaves, BlenderNoiseBasis noisebasis)
{
	float rmd, value=0.f, pwr=1.f, pwHL=pow(lacunarity, -H);
	int	i;

	for (i=0; i<(int)octaves; i++) {
		value +=noisefuncS(noisebasis, x, y, z)*pwr;
		pwr *= pwHL;
		x *= lacunarity;
		y *= lacunarity;
		z *= lacunarity;
	}

	rmd = octaves - floor(octaves);
	if (rmd!=0.f) value += rmd * noisefuncS(noisebasis, x, y, z) * pwr;

	return value;

} /* fBm() */

/*
 * Procedural multifractal evaluated at "point";
 * returns value stored in "value".
 *
 * Parameters:
 *    ``H''  determines the highest fractal dimension
 *    ``lacunarity''  is gap between successive frequencies
 *    ``octaves''  is the number of frequencies in the fBm
 *    ``offset''  is the zero offset, which determines multifractality (NOT USED?!?)
 */
 /* this one is in fact rather confusing,
 	* there seem to be errors in the original source code (in all three versions of proc.text&mod),
	* I modified it to something that made sense to me, so it might be wrong... */

float mg_MultiFractal(float x, float y, float z, float H, float lacunarity, float octaves, BlenderNoiseBasis noisebasis) {
	float rmd, value=1.f, pwr=1.f, pwHL=pow(lacunarity, -H);
	int i;

	for (i=0; i<(int)octaves; i++) {
		value *= (pwr * noisefuncS(noisebasis, x, y, z) + 1.f);
		pwr *= pwHL;
		x *= lacunarity;
		y *= lacunarity;
		z *= lacunarity;
	}

	rmd = octaves - floor(octaves);
	if (rmd!=0.f) value *= (rmd * noisefuncS(noisebasis, x, y, z) * pwr + 1.f);

	return value;

} /* multifractal() */

/*
 * Heterogeneous procedural terrain function: stats by altitude method.
 * Evaluated at "point"; returns value stored in "value".
 *
 * Parameters:
 *       ``H''  determines the fractal dimension of the roughest areas
 *       ``lacunarity''  is the gap between successive frequencies
 *       ``octaves''  is the number of frequencies in the fBm
 *       ``offset''  raises the terrain from `sea level'
 */
float mg_HeteroTerrain(float x, float y, float z, float H, float lacunarity, float octaves, float offset, BlenderNoiseBasis noisebasis)
{
	float	value, increment, rmd;
	int i;
	float pwHL = pow(lacunarity, -H);
	float pwr = pwHL;	/* starts with i=1 instead of 0 */

	/* first unscaled octave of function; later octaves are scaled */
	value = offset + noisefuncS(noisebasis, x, y, z);

	x *= lacunarity;
	y *= lacunarity;
	z *= lacunarity;

	for (i=1; i<(int)octaves; i++) {
		increment = (noisefuncS(noisebasis, x, y, z) + offset) * pwr * value;
		value += increment;
		pwr *= pwHL;
		x *= lacunarity;
		y *= lacunarity;
		z *= lacunarity;
	}

	rmd = octaves - floor(octaves);

	if (rmd!=0.f) {
		increment = (noisefuncS(noisebasis, x, y, z) + offset) * pwr * value;
		value += rmd * increment;
	}
	return value;
}

/* Hybrid additive/multiplicative multifractal terrain model.
 *
 * Some good parameter values to start with:
 *
 *      H:           0.25
 *      offset:      0.7
 */
float mg_HybridMultiFractal(float x, float y, float z, float H, float lacunarity, float octaves, float offset, float gain, BlenderNoiseBasis noisebasis)
{
	float result, signal, weight, rmd;
	int i;
	float pwHL = pow(lacunarity, -H);
	float pwr = pwHL;	/* starts with i=1 instead of 0 */

	result = noisefuncS(noisebasis, x, y, z) + offset;
	weight = gain * result;
	x *= lacunarity;
	y *= lacunarity;
	z *= lacunarity;

	for (i=1; (weight>0.001f) && (i<(int)octaves); i++) {
		if (weight>1.f)  weight=1.f;
		signal = (noisefuncS(noisebasis, x, y, z) + offset) * pwr;
		pwr *= pwHL;
		result += weight * signal;
		weight *= gain * signal;
		x *= lacunarity;
		y *= lacunarity;
		z *= lacunarity;
	}

	rmd = octaves - floor(octaves);
	if (rmd!=0.f) result += rmd * ((noisefuncS(noisebasis, x, y, z) + offset) * pwr);

	return result;

} /* HybridMultifractal() */


/* Ridged multifractal terrain model.
 *
 * Some good parameter values to start with:
 *
 *      H:           1.0
 *      offset:      1.0
 *      gain:        2.0
 */
float mg_RidgedMultiFractal(float x, float y, float z, float H, float lacunarity, float octaves, float offset, float gain, BlenderNoiseBasis noisebasis)
{
	float result, signal, weight;
	int	i;
	float pwHL = pow(lacunarity, -H);
	float pwr = pwHL;	/* starts with i=1 instead of 0 */

	signal = offset - fabs(noisefuncS(noisebasis, x, y, z));
	signal *= signal;
	result = signal;
	weight = 1.f;

	for( i=1; i<(int)octaves; i++ ) {
		x *= lacunarity;
		y *= lacunarity;
		z *= lacunarity;
		weight = signal * gain;
		if (weight>1.f) weight=1.f; else if (weight<0.f) weight=0.f;

		signal = offset - fabs(noisefuncS(noisebasis, x, y, z));
		signal *= signal;
		signal *= weight;
		result += signal * pwr;
		pwr *= pwHL;
	}

	return result;
} /* RidgedMultifractal() */

/* "Variable Lacunarity Noise"
 * A distorted variety of Perlin noise.
 */
float mg_VLNoise(float x, float y, float z, float distortion, BlenderNoiseBasis nbas1, BlenderNoiseBasis nbas2)
{
	float3 rv;
	float result;

	/* get a random vector and scale the randomization */
	rv.x = noisefuncS(nbas1, x+13.5f, y+13.5f, z+13.5f) * distortion;
	rv.y = noisefuncS(nbas1, x, y, z) * distortion;
	rv.z = noisefuncS(nbas1, x-13.5f, y-13.5f, z-13.5f) * distortion;

	result = noisefuncS(nbas2, x+rv.x, y+rv.y, z+rv.z);

	return result;
}

/****************/
/* musgrave end */
/****************/

/* newnoise: generic noise function for use with different noisebases */
float BLI_gNoise(float noisesize, float x, float y, float z, int hard, BlenderNoiseBasis noisebasis) {
	float result = 0.f;

	if(noisebasis == BLENDER_ORIGINAL) {
		// add one to make return value same as BLI_hnoise
		x += 1.f;
		y += 1.f;
		z += 1.f;
	}

	if (noisesize!=0.f) {
		noisesize = 1.f/noisesize;
		x *= noisesize;
		y *= noisesize;
		z *= noisesize;
	}

	switch (noisebasis) {
		case ORIGINAL_PERLIN:
			result = orgPerlinNoiseU(x, y, z);
			break;
		case IMPROVED_PERLIN:
			result = newPerlinU(x, y, z);
			break;
		case VORONOI_F1:
			result = voronoi_F1(x, y, z);
			break;
		case VORONOI_F2:
			result = voronoi_F2(x, y, z);
			break;
		case VORONOI_F3:
			result = voronoi_F3(x, y, z);
			break;
		case VORONOI_F4:
			result = voronoi_F4(x, y, z);
			break;
		case VORONOI_F2_F1:
			result = voronoi_F1F2(x, y, z);
			break;
		case VORONOI_CRACKLE:
			result = voronoi_Cr(x, y, z);
			break;
		case CELL_NOISE:
			result = cellNoiseU(x, y, z);
			break;
		case BLENDER_ORIGINAL:
		default:
			result = orgBlenderNoise(x, y, z);
	}

	if (hard) return fabs(2.f*result-1.f);
	return result;
}

/* newnoise: generic turbulence function for use with different noisebasis */
float BLI_gTurbulence(float noisesize, float x, float y, float z, int oct, int hard, BlenderNoiseBasis noisebasis) {
	float sum=0.f, t, amp=1.f, fscale=1.f;
	int i;

	if(noisebasis == BLENDER_ORIGINAL) {
		// add one to make return value same as BLI_hnoise
		x += 1.f;
		y += 1.f;
		z += 1.f;
	}

	if (noisesize!=0.f) {
		noisesize = 1.f/noisesize;
		x *= noisesize;
		y *= noisesize;
		z *= noisesize;
	}

	for (i=0;i<=oct;i++, amp*=0.5f, fscale*=2.f) {
		switch (noisebasis) {
			case ORIGINAL_PERLIN:
				t = orgPerlinNoise(fscale*x, fscale*y, fscale*z);
				break;
			case IMPROVED_PERLIN:
				t = newPerlin(fscale*x, fscale*y, fscale*z);
				break;
			case VORONOI_F1:
				t = voronoi_F1(fscale*x, fscale*y, fscale*z);
				break;
			case VORONOI_F2:
				t = voronoi_F2(fscale*x, fscale*y, fscale*z);
				break;
			case VORONOI_F3:
				t = voronoi_F3(fscale*x, fscale*y, fscale*z);
				break;
			case VORONOI_F4:
				t = voronoi_F4(fscale*x, fscale*y, fscale*z);
				break;
			case VORONOI_F2_F1:
				t = voronoi_F1F2(fscale*x, fscale*y, fscale*z);
				break;
			case VORONOI_CRACKLE:
				t = voronoi_Cr(fscale*x, fscale*y, fscale*z);
				break;
			case CELL_NOISE:
				t = cellNoiseU(fscale*x, fscale*y, fscale*z);
				break;
			case BLENDER_ORIGINAL:
			default:
				t = orgBlenderNoise(fscale*x, fscale*y, fscale*z);
		}

		if (hard) t = fabs(2.f*t-1.f);
		sum += t * amp;
	}

	sum *= ((float)(1<<oct)/(float)((1<<(oct+1))-1));

	return sum;

}
#line 2 "texture_blender_funcs.cl"

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

#ifndef TEXTURE_STACK_SIZE
#define TEXTURE_STACK_SIZE 16
#endif

//------------------------------------------------------------------------------
// Blender blend texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_BLEND)

float BlenderBlendTexture_Evaluate(__global HitPoint *hitPoint,
		const ProgressionType type, const bool direction,
 		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	const float3 P = TextureMapping3D_Map(mapping, hitPoint);

	float result = 0.f;
	float x, y, t;

	if(!direction) {
		//horizontal
		x = P.x;
		y = P.y;
	} else {
		//vertical
		x = P.y;
		y = P.x;
	};

    if (type == TEX_LIN) { /* lin */
		result = (1.f + x) / 2.f;
	} else if (type == TEX_QUAD) { /* quad */
		result = (1.f + x) / 2.f;
		if (result < 0.f) result = 0.f;
		else result *= result;
	} else if (type == TEX_EASE) { /* ease */
		result = (1.f + x) / 2.f;
        if (result <= 0.f) result = 0.f;
        else if (result >= 1.f) result = 1.f;
        else {
			t = result * result;
            result = (3.f * t - 2.f * t * result);
        }
    } else if (type == TEX_DIAG) { /* diag */
		result = (2.f + x + y) / 4.f;
    } else if (type == TEX_RAD) { /* radial */
        result = (atan2(y, x) / (2.f * M_PI) + 0.5f);
    } else { /* sphere TEX_SPHERE */
        result = 1.f - sqrt(x * x + y * y + P.z * P.z);
        if (result < 0.f) result = 0.f;
	    if (type == TEX_HALO) result *= result; /* halo */
    }

	result = (result - 0.5f) * contrast + bright - 0.5f;
    if(result < 0.f) result = 0.f;
	else if(result > 1.f) result = 1.f;

	return result;
}

float BlenderBlendTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const ProgressionType type, const bool direction,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderBlendTexture_Evaluate(hitPoint, type, direction, contrast, bright, mapping);
}

float3 BlenderBlendTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const ProgressionType type, const bool direction,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderBlendTexture_Evaluate(hitPoint, type, direction, contrast, bright, mapping);
}

#endif

//------------------------------------------------------------------------------
// Blender clouds texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_CLOUDS)

float BlenderCloudsTexture_Evaluate(__global HitPoint *hitPoint,
		const BlenderNoiseBasis noisebasis, const float noisesize, const int noisedepth,
		const float contrast, const float bright, const bool hard, __global const TextureMapping3D *mapping) {
	const float3 P = TextureMapping3D_Map(mapping, hitPoint);

	float clouds = BLI_gTurbulence(noisesize, P.x, P.y, P.z, noisedepth, hard, noisebasis);

	clouds = (clouds - 0.5f) * contrast + bright - 0.5f;
	clouds = clamp(clouds, 0.f, 1.f);

	return clouds;
}

float BlenderCloudsTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const BlenderNoiseBasis noisebasis, const float noisesize, const int noisedepth,
		const float contrast, const float bright, const bool hard, __global const TextureMapping3D *mapping) {
	return BlenderCloudsTexture_Evaluate(hitPoint, noisebasis, noisesize, noisedepth,
			contrast, bright, hard, mapping);
}

float3 BlenderCloudsTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const BlenderNoiseBasis noisebasis, const float noisesize, const int noisedepth,
		const float contrast, const float bright, const bool hard, __global const TextureMapping3D *mapping) {
	return BlenderCloudsTexture_Evaluate(hitPoint, noisebasis, noisesize, noisedepth,
			contrast, bright, hard, mapping);
}

#endif

//------------------------------------------------------------------------------
// Blender distorted noise texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_DISTORTED_NOISE)

float BlenderDistortedNoiseTexture_Evaluate(__global HitPoint *hitPoint,
		const BlenderNoiseBasis noisedistortion, const BlenderNoiseBasis noisebasis, const float distortion, const float noisesize,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	float3 P = TextureMapping3D_Map(mapping, hitPoint);

	float result = 0.f;
	float scale = 1.f;

	if(fabs(noisesize) > 0.00001f) scale = (1.f/noisesize);
	P = scale*P;
	result = mg_VLNoise(P.x, P.y, P.z, distortion, noisebasis, noisedistortion);

	result = (result - 0.5f) * contrast + bright - 0.5f;
    if(result < 0.f) result = 0.f;
	else if(result > 1.f) result = 1.f;

	return result;
}

float BlenderDistortedNoiseTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const BlenderNoiseBasis noisedistortion, const BlenderNoiseBasis noisebasis, const float distortion, const float noisesize,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderDistortedNoiseTexture_Evaluate(hitPoint, noisedistortion, noisebasis, distortion, noisesize,
			contrast, bright, mapping);
}

float3 BlenderDistortedNoiseTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const BlenderNoiseBasis noisedistortion, const BlenderNoiseBasis noisebasis, const float distortion, const float noisesize,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderDistortedNoiseTexture_Evaluate(hitPoint, noisedistortion, noisebasis, distortion, noisesize,
			contrast, bright, mapping);
}

#endif

//------------------------------------------------------------------------------
// Blender magic texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_MAGIC)
float3 BlenderMagicTexture_Evaluate(__global HitPoint *hitPoint, const int noisedepth, const float turbulence,
			const float contrast, const float bright, __global const TextureMapping3D *mapping) {

	const float3 P = TextureMapping3D_Map(mapping, hitPoint);
	float3 s;

    float x, y, z, turb = 1.f;
    float r, g, b;
    int n;

    n = noisedepth;
    turb = turbulence / 5.f;

    x = sin((P.x + P.y + P.z)*5.f);
    y = cos((-P.x + P.y - P.z)*5.f);
    z = -cos((-P.x - P.y + P.z)*5.f);
    if (n > 0) {
        x *= turb;
        y *= turb;
        z *= turb;
        y = -cos(x - y + z);
        y *= turb;
        if (n > 1) {
            x = cos(x - y - z);
            x *= turb;
            if (n > 2) {
                z = sin(-x - y - z);
                z *= turb;
                if (n > 3) {
                    x = -cos(-x + y - z);
                    x *= turb;
                    if (n > 4) {
                        y = -sin(-x + y + z);
                        y *= turb;
                        if (n > 5) {
                            y = -cos(-x + y + z);
                            y *= turb;
                            if (n > 6) {
                                x = cos(x + y + z);
                                x *= turb;
                                if (n > 7) {
                                    z = sin(x + y - z);
                                    z *= turb;
                                    if (n > 8) {
                                        x = -cos(-x - y + z);
                                        x *= turb;
                                        if (n > 9) {
                                            y = -sin(x - y + z);
                                            y *= turb;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    if (turb != 0.f) {
        turb *= 2.f;
        x /= turb;
        y /= turb;
        z /= turb;
    }
    r = 0.5f - x;
    g = 0.5f - y;
    b = 0.5f - z;

	r = (r - 0.5f) * contrast + bright - 0.5f;
    if(r < 0.f) r = 0.f;
	else if(r > 1.f) r = 1.f;

	g = (g - 0.5f) * contrast + bright - 0.5f;
    if(g < 0.f) g = 0.f;
	else if(g > 1.f) g = 1.f;

	b = (b - 0.5f) * contrast + bright - 0.5f;
    if(b < 0.f) b = 0.f;
	else if(b > 1.f) b = 1.f;

	s.x = r;
	s.y = g;
	s.z = b;

	return s;
}

float BlenderMagicTexture_ConstEvaluateFloat(__global HitPoint *hitPoint, const int noisedepth, const float turbulence,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	float3 result = BlenderMagicTexture_Evaluate(hitPoint, noisedepth, turbulence, contrast, bright, mapping);
	return (0.212671f * result.x + 0.715160f * result.y + 0.072169f * result.z);
}

float3 BlenderMagicTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint, const int noisedepth, const float turbulence,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderMagicTexture_Evaluate(hitPoint, noisedepth, turbulence, contrast, bright, mapping);
}

#endif

//------------------------------------------------------------------------------
// Blender marble texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_MARBLE)
float BlenderMarbleTexture_Evaluate(__global HitPoint *hitPoint, const BlenderMarbleType type,
		const BlenderNoiseBasis noisebasis, const BlenderNoiseBase noisebasis2, const float noisesize,
		const float turbulence, const int noisedepth, const float contrast, const float bright,
		const bool hard, __global const TextureMapping3D *mapping) {

	const float3 P = TextureMapping3D_Map(mapping, hitPoint);

	float result = 0.f;
    float n = 5.f * (P.x + P.y + P.z);
    result = n + turbulence * BLI_gTurbulence(noisesize, P.x, P.y, P.z, noisedepth, hard, noisebasis);


	if(noisebasis2 == TEX_SIN) {
		result = tex_sin(result);
	} else if(noisebasis2 == TEX_SAW) {
		result = tex_saw(result);
	} else {
		result = tex_tri(result);
	}

	if (type == TEX_SHARP) {
		result = sqrt(result);
	} else if (type == TEX_SHARPER) {
		result = sqrt(sqrt(result));
	}

	result = (result - 0.5f) * contrast + bright - 0.5f;
    if(result < 0.f) result = 0.f;
	else if(result > 1.f) result = 1.f;

    return result;
}

float BlenderMarbleTexture_ConstEvaluateFloat(__global HitPoint *hitPoint, const BlenderMarbleType type,
		const BlenderNoiseBasis noisebasis, const BlenderNoiseBase noisebasis2, const float noisesize,
		const float turbulence, const int noisedepth, const float contrast, const float bright,
		const bool hard, __global const TextureMapping3D *mapping) {
	return BlenderMarbleTexture_Evaluate(hitPoint, type, noisebasis, noisebasis2, noisesize, turbulence, noisedepth, contrast, bright, hard, mapping);
}


float3 BlenderMarbleTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint, const BlenderMarbleType type,
		const BlenderNoiseBasis noisebasis, const BlenderNoiseBase noisebasis2, const float noisesize,
		const float turbulence, const int noisedepth, const float contrast, const float bright,
		const bool hard, __global const TextureMapping3D *mapping) {
	return BlenderMarbleTexture_Evaluate(hitPoint, type, noisebasis, noisebasis2, noisesize, turbulence, noisedepth, contrast, bright, hard, mapping);
}

#endif

//------------------------------------------------------------------------------
// Blender musgrave texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_MUSGRAVE)
float BlenderMusgraveTexture_Evaluate(__global HitPoint *hitPoint, const BlenderMusgraveType type,
		const BlenderNoiseBasis noisebasis, const float dimension, const float intensity, const float lacunarity,
		const float offset, const float gain, const float octaves, const float noisesize,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {

	float scale = 1.f;
	if(fabs(noisesize) > 0.00001f) scale = (1.f/noisesize);
	const float3 P = scale*TextureMapping3D_Map(mapping, hitPoint);

	float result = 0.f;

	switch (type) {
		case TEX_MULTIFRACTAL:
			result = mg_MultiFractal(P.x, P.y, P.z, dimension, lacunarity, octaves, noisebasis);
			break;
		case TEX_FBM:
			result = mg_fBm(P.x, P.y, P.z, dimension, lacunarity, octaves, noisebasis);
            break;
		case TEX_RIDGED_MULTIFRACTAL:
			result = mg_RidgedMultiFractal(P.x, P.y, P.z, dimension, lacunarity, octaves, offset, gain, noisebasis);
			break;
        case TEX_HYBRID_MULTIFRACTAL:
			result = mg_HybridMultiFractal(P.x, P.y, P.z, dimension, lacunarity, octaves, offset, gain, noisebasis);
			break;
        case TEX_HETERO_TERRAIN:
			result = mg_HeteroTerrain(P.x, P.y, P.z, dimension, lacunarity, octaves, offset, noisebasis);
			break;
    };

	result *= intensity;

	result = (result - 0.5f) * contrast + bright - 0.5f;
    if(result < 0.f) result = 0.f;
	else if(result > 1.f) result = 1.f;

	return result;
}

float BlenderMusgraveTexture_ConstEvaluateFloat(__global HitPoint *hitPoint, const BlenderMusgraveType type,
		const BlenderNoiseBasis noisebasis, const float dimension, const float intensity, const float lacunarity,
		const float offset, const float gain, const float octaves, const float noisesize,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderMusgraveTexture_Evaluate(hitPoint, type, noisebasis, dimension, intensity, lacunarity,
			offset, gain, octaves, noisesize, contrast, bright, mapping);
}

float3 BlenderMusgraveTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint, const BlenderMusgraveType type,
		const BlenderNoiseBasis noisebasis, const float dimension, const float intensity, const float lacunarity,
		const float offset, const float gain, const float octaves, const float noisesize,
		const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderMusgraveTexture_Evaluate(hitPoint, type, noisebasis, dimension, intensity, lacunarity,
			offset, gain, octaves, noisesize, contrast, bright, mapping);
}

#endif

//------------------------------------------------------------------------------
// Blender stucci texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_STUCCI)
float BlenderStucciTexture_Evaluate(__global HitPoint *hitPoint, const BlenderStucciType type,
		const BlenderNoiseBasis noisebasis, const float noisesize, const float turbulence, const float contrast,
		const float bright, const bool hard, __global const TextureMapping3D *mapping) {

	const float3 P = TextureMapping3D_Map(mapping, hitPoint);

	float result = 0.f;
//	neo2068: only nor[2] is used, so normal float variable is sufficient
//	float nor[3], b2, ofs;
	float b2, ofs;

	b2 = BLI_gNoise(noisesize, P.x, P.y, P.z, hard, noisebasis);
	ofs = turbulence / 200.f;

	if (type != TEX_PLASTIC) ofs *= (b2 * b2);
//	neo2068: only nor[2] is used
//    nor[0] = BLI_gNoise(noisesize, P.x + ofs, P.y, P.z, hard, noisebasis);
//    nor[1] = BLI_gNoise(noisesize, P.x, P.y + ofs, P.z, hard, noisebasis);
//    nor[2] = BLI_gNoise(noisesize, P.x, P.y, P.z + ofs, hard, noisebasis);
    result = BLI_gNoise(noisesize, P.x, P.y, P.z + ofs, hard, noisebasis);

//    result = nor[2];

    if (type == TEX_WALL_OUT)
        result = 1.f - result;

	result = (result - 0.5f) * contrast + bright - 0.5f;
    if(result < 0.f) result = 0.f;
	else if(result > 1.f) result = 1.f;

	return result;
}

float BlenderStucciTexture_ConstEvaluateFloat(__global HitPoint *hitPoint, const BlenderStucciType type,
		const BlenderNoiseBasis noisebasis, const float noisesize, const float turbulence, const float contrast,
		const float bright, const bool hard, __global const TextureMapping3D *mapping) {
	return BlenderStucciTexture_Evaluate(hitPoint, type, noisebasis, noisesize, turbulence,
			contrast, bright, hard, mapping);
}

float3 BlenderStucciTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint, const BlenderStucciType type,
		const BlenderNoiseBasis noisebasis, const float noisesize, const float turbulence, const float contrast,
		const float bright, const bool hard, __global const TextureMapping3D *mapping) {
	return BlenderStucciTexture_Evaluate(hitPoint, type, noisebasis, noisesize, turbulence,
			contrast, bright, hard, mapping);
}

#endif

//------------------------------------------------------------------------------
// Blender wood texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_WOOD)

float BlenderWoodTexture_Evaluate(__global HitPoint *hitPoint,
		const BlenderWoodType type, const BlenderNoiseBase noisebasis2,
		const BlenderNoiseBasis noisebasis, const float noisesize, const float turbulence,
		const float contrast, const float bright, const bool hard,
		__global const TextureMapping3D *mapping) {
	const float3 P = TextureMapping3D_Map(mapping, hitPoint);

	float wood = 0.f;
	switch(type) {
		default:
		case BANDS:
			if(noisebasis2 == TEX_SIN) {
				wood = tex_sin((P.x + P.y + P.z) * 10.f);
			} else if(noisebasis2 == TEX_SAW) {
				wood = tex_saw((P.x + P.y + P.z) * 10.f);
			} else {
				wood = tex_tri((P.x + P.y + P.z) * 10.f);
			}
			break;
		case RINGS:
			if(noisebasis2 == TEX_SIN) {
				wood = tex_sin(sqrt(P.x*P.x + P.y*P.y + P.z*P.z) * 20.f);
			} else if(noisebasis2 == TEX_SAW) {
				wood = tex_saw(sqrt(P.x*P.x + P.y*P.y + P.z*P.z) * 20.f);
			} else {
				wood = tex_tri(sqrt(P.x*P.x + P.y*P.y + P.z*P.z) * 20.f);
			}
			break;
		case BANDNOISE:
			if(hard)
				wood = turbulence * fabs(2.f * BLI_gNoise(noisesize, P.x, P.y, P.z, hard, noisebasis) - 1.f);
			else
				wood = turbulence * BLI_gNoise(noisesize, P.x, P.y, P.z, hard, noisebasis);

			if(noisebasis2 == TEX_SIN) {
				wood = tex_sin((P.x + P.y + P.z) * 10.f + wood);
			} else if(noisebasis2 == TEX_SAW) {
				wood = tex_saw((P.x + P.y + P.z) * 10.f + wood);
			} else {
				wood = tex_tri((P.x + P.y + P.z) * 10.f + wood);
			}
			break;
		case RINGNOISE:
			if(hard)
				wood = turbulence * fabs(2.f * BLI_gNoise(noisesize, P.x, P.y, P.z, hard, noisebasis) - 1.f);
			else
				wood = turbulence * BLI_gNoise(noisesize, P.x, P.y, P.z, hard, noisebasis);

			if(noisebasis2 == TEX_SIN) {
				wood = tex_sin(sqrt(P.x*P.x + P.y*P.y + P.z*P.z) * 20.f + wood);
			} else if(noisebasis2 == TEX_SAW) {
				wood = tex_saw(sqrt(P.x*P.x + P.y*P.y + P.z*P.z) * 20.f + wood);
			} else {
				wood = tex_tri(sqrt(P.x*P.x + P.y*P.y + P.z*P.z) * 20.f + wood);
			}
			break;
	}
	wood = (wood - 0.5f) * contrast + bright - 0.5f;
	wood = clamp(wood, 0.f, 1.f);

	return wood;
}

float BlenderWoodTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const BlenderWoodType type, const BlenderNoiseBase noisebasis2,
		const BlenderNoiseBasis noisebasis, const float noisesize, const float turbulence,
		const float contrast, const float bright, const bool hard,
		__global const TextureMapping3D *mapping) {
	return BlenderWoodTexture_Evaluate(hitPoint, type, noisebasis2, noisebasis,
		noisesize, turbulence, contrast, bright, hard, mapping);
}

float3 BlenderWoodTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const BlenderWoodType type, const BlenderNoiseBase noisebasis2,
		const BlenderNoiseBasis noisebasis, const float noisesize, const float turbulence,
		const float contrast, const float bright, const bool hard,
		__global const TextureMapping3D *mapping) {
    return BlenderWoodTexture_Evaluate(hitPoint, type, noisebasis2, noisebasis,
		noisesize, turbulence, contrast, bright, hard, mapping);
}

#endif

//------------------------------------------------------------------------------
// Blender voronoi texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BLENDER_VORONOI)

float BlenderVoronoiTexture_Evaluate(__global HitPoint *hitPoint,
		const DistanceMetric distancemetric, const float feature_weight1, const float feature_weight2,
		const float feature_weight3, const float feature_weight4, const float noisesize, const float intensity,
		const float exponent, const float contrast, const float bright, __global const TextureMapping3D *mapping) {

    float da[4], pa[12]; /* distance and point coordinate arrays of 4 nearest neighbours */
	float scale = 1.f;
	if(fabs(noisesize) > 0.00001f) scale = (1.f/noisesize);
	const float3 P = scale*TextureMapping3D_Map(mapping, hitPoint);

	const float aw1 = fabs(feature_weight1);
    const float aw2 = fabs(feature_weight2);
    const float aw3 = fabs(feature_weight3);
    const float aw4 = fabs(feature_weight4);

    float sc = (aw1 + aw2 + aw3 + aw4);

    if (sc > 0.00001f) sc = intensity / sc;

    float result = 1.f;

	voronoi(P.x, P.y, P.z, da, pa, exponent, distancemetric);
    result = sc * fabs(feature_weight1 * da[0] + feature_weight2 * da[1] + feature_weight3 * da[2] + feature_weight4 * da[3]);

	result = (result - 0.5f) * contrast + bright - 0.5f;
    if(result < 0.f) result = 0.f;
	else if(result > 1.f) result = 1.f;

    return result;
}

float BlenderVoronoiTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,	const DistanceMetric distancemetric, const float feature_weight1,
		const float feature_weight2, const float feature_weight3, const float feature_weight4, const float noisesize, const float intensity,
		const float exponent, const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderVoronoiTexture_Evaluate(hitPoint, distancemetric, feature_weight1, feature_weight2, feature_weight3, feature_weight4,
		noisesize, intensity, exponent, contrast, bright, mapping);
}

float3 BlenderVoronoiTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint, const DistanceMetric distancemetric, const float feature_weight1,
		const float feature_weight2, const float feature_weight3, const float feature_weight4, const float noisesize, const float intensity,
		const float exponent, const float contrast, const float bright, __global const TextureMapping3D *mapping) {
	return BlenderVoronoiTexture_Evaluate(hitPoint, distancemetric, feature_weight1, feature_weight2, feature_weight3, feature_weight4,
		noisesize, intensity, exponent, contrast, bright, mapping);
}

#endif
#line 2 "texture_funcs.cl"

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

//------------------------------------------------------------------------------
// Abs texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_ABS)

float AbsTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float v) {
	return fabs(v);
}

float3 AbsTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 v) {
	return fabs(v);
}

#endif
#line 2 "texture_funcs.cl"

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

//------------------------------------------------------------------------------
// BlackBody texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_BLACKBODY)

float BlackBodyTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float3 rgb) {
	return Spectrum_Y(rgb);
}

float3 BlackBodyTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 rgb) {
	return rgb;
}

#endif
#line 2 "texture_funcs.cl"

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

//------------------------------------------------------------------------------
// Clamp texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_CLAMP)

float ClampTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float v, const float minVal, const float maxVal) {
	return clamp(v, minVal, maxVal);
}

float3 ClampTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 v, const float minVal, const float maxVal) {
	return clamp(v, minVal, maxVal);
}

#endif
#line 2 "texture_funcs.cl"

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

float FresnelApproxN(const float Fr) {
	const float sqrtReflectance = sqrt(clamp(Fr, 0.f, .999f));

	return (1.f + sqrtReflectance) /
		(1.f - sqrtReflectance);
}

float3 FresnelApproxN3(const float3 Fr) {
	const float3 sqrtReflectance = Spectrum_Sqrt(clamp(Fr, 0.f, .999f));

	return (WHITE + sqrtReflectance) /
		(WHITE - sqrtReflectance);
}

float FresnelApproxK(const float Fr) {
	const float reflectance = clamp(Fr, 0.f, .999f);

	return 2.f * sqrt(reflectance /
		(1.f - reflectance));
}

float3 FresnelApproxK3(const float3 Fr) {
	const float3 reflectance = clamp(Fr, 0.f, .999f);

	return 2.f * Spectrum_Sqrt(reflectance /
		(WHITE - reflectance));
}

//------------------------------------------------------------------------------
// FresnelColor texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_FRESNELCOLOR)

float FresnelColorTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float3 kr) {
	return Spectrum_Y(kr);
}

float3 FresnelColorTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 kr) {
	return kr;
}

#endif
#line 2 "texture_funcs.cl"

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

//------------------------------------------------------------------------------
// FresnelConst texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_FRESNELCONST)

float FresnelConstTexture_ConstEvaluateFloat(__global HitPoint *hitPoint) {
	return 0.f;
}

float3 FresnelConstTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint) {
	return 0.f;
}

#endif
#line 2 "texture_funcs.cl"

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

//------------------------------------------------------------------------------
// IrregularData texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_IRREGULARDATA)

float IrregularDataTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float3 rgb) {
	return Spectrum_Y(rgb);
}

float3 IrregularDataTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 rgb) {
	return rgb;
}

#endif
#line 2 "texture_funcs.cl"

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

//------------------------------------------------------------------------------
// ConstFloat texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_CONST_FLOAT)

float ConstFloatTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float value) {
	return value;
}

float3 ConstFloatTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float value) {
	return value;
}

#endif

//------------------------------------------------------------------------------
// ConstFloat3 texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_CONST_FLOAT3)

float ConstFloat3Texture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float3 value) {
	return Spectrum_Y(value);
}

float3 ConstFloat3Texture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 value) {
	return value;
}

#endif

//------------------------------------------------------------------------------
// ImageMap texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_IMAGEMAP)

float ImageMapTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float gain, const uint imageMapIndex, __global const TextureMapping2D *mapping
		IMAGEMAPS_PARAM_DECL) {
	__global const ImageMap *imageMap = &imageMapDescs[imageMapIndex];

	const float2 uv = VLOAD2F(&hitPoint->uv.u);
	const float2 mapUV = TextureMapping2D_Map(mapping, hitPoint);

	return gain * ImageMap_GetFloat(
			imageMap,
			mapUV.s0, mapUV.s1
			IMAGEMAPS_PARAM);
}

float3 ImageMapTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float gain, const uint imageMapIndex, __global const TextureMapping2D *mapping
		IMAGEMAPS_PARAM_DECL) {
	__global const ImageMap *imageMap = &imageMapDescs[imageMapIndex];
	__global const float *pixels = ImageMap_GetPixelsAddress(
			imageMapBuff, imageMap->pageIndex, imageMap->pixelsIndex);

	const float2 uv = VLOAD2F(&hitPoint->uv.u);
	const float2 mapUV = TextureMapping2D_Map(mapping, hitPoint);

	return gain * ImageMap_GetSpectrum(
			imageMap,
			mapUV.s0, mapUV.s1
			IMAGEMAPS_PARAM);
}

#endif

//------------------------------------------------------------------------------
// Scale texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_SCALE)

float ScaleTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float tex1, const float tex2) {
	return tex1 * tex2;
}

float3 ScaleTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 tex1, const float3 tex2) {
	return tex1 * tex2;
}

#endif

//------------------------------------------------------------------------------
// FresnelApproxN & FresnelApproxK texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_FRESNEL_APPROX_N)

float FresnelApproxNTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float value) {
	return FresnelApproxN(value);
}

float3 FresnelApproxNTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 value) {
	return FresnelApproxN3(value);
}

#endif

#if defined(PARAM_ENABLE_FRESNEL_APPROX_K)

float FresnelApproxKTexture_ConstEvaluateFloat( __global HitPoint *hitPoint,
		const float value) {
	return FresnelApproxK(value);
}

float3 FresnelApproxKTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 value) {
	return FresnelApproxK3(value);
}

#endif

//------------------------------------------------------------------------------
// Mix texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_MIX)

float MixTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float amt, const float value1, const float value2) {
	return Lerp(clamp(amt, 0.f, 1.f), value1, value2);
}

float3 MixTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 amt, const float3 value1, const float3 value2) {
	return mix(value1, value2, clamp(amt, 0.f, 1.f));
}

#endif

//------------------------------------------------------------------------------
// CheckerBoard 2D & 3D texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_CHECKERBOARD2D)

float CheckerBoard2DTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float value1, const float value2, __global const TextureMapping2D *mapping) {
	const float2 uv = VLOAD2F(&hitPoint->uv.u);
	const float2 mapUV = TextureMapping2D_Map(mapping, hitPoint);

	return ((Floor2Int(mapUV.s0) + Floor2Int(mapUV.s1)) % 2 == 0) ? value1 : value2;
}

float3 CheckerBoard2DTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 value1, const float3 value2, __global const TextureMapping2D *mapping) {
	const float2 uv = VLOAD2F(&hitPoint->uv.u);
	const float2 mapUV = TextureMapping2D_Map(mapping, hitPoint);

	return ((Floor2Int(mapUV.s0) + Floor2Int(mapUV.s1)) % 2 == 0) ? value1 : value2;
}

#endif

#if defined(PARAM_ENABLE_CHECKERBOARD3D)

float CheckerBoard3DTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float value1, const float value2, __global const TextureMapping3D *mapping) {
	const float3 mapP = TextureMapping3D_Map(mapping, hitPoint);

	return ((Floor2Int(mapP.x) + Floor2Int(mapP.y) + Floor2Int(mapP.z)) % 2 == 0) ? value1 : value2;
}

float3 CheckerBoard3DTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 value1, const float3 value2, __global const TextureMapping3D *mapping) {
	const float3 mapP = TextureMapping3D_Map(mapping, hitPoint);

	return ((Floor2Int(mapP.x) + Floor2Int(mapP.y) + Floor2Int(mapP.z)) % 2 == 0) ? value1 : value2;
}

#endif

//------------------------------------------------------------------------------
// Cloud texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_CLOUD_TEX)

float CloudTexture_CloudNoise(const float3 p, const float omegaValue, const uint octaves) {
	// Compute sum of octaves of noise
	float sum = 0.f, lambda = 1.f, o = 1.f;
	for (uint i = 0; i < octaves; ++i) {
		sum += o * Noise3(lambda * p);
		lambda *= 1.99f;
		o *= omegaValue;
	}
	return sum;
}

float CloudTexture_NoiseMask(const float3 p, const float radius, const float omega) {
	return CloudTexture_CloudNoise(p / radius * 1.4f, omega, 1);
}

float3 CloudTexture_Turbulence(const float3 p, const float noiseScale, const float noiseOffset, const float variability,
                               const uint octaves, const float radius, const float omega, const float baseFlatness, const float3 sphereCentre) {
	float3 noiseCoords[3];
	const float baseFadeDistance = 1.f - baseFlatness;

	noiseCoords[0] = p / noiseScale;
	noiseCoords[1] = noiseCoords[0] + (float3)(noiseOffset, noiseOffset, noiseOffset);
	noiseCoords[2] = noiseCoords[1] + (float3)(noiseOffset, noiseOffset, noiseOffset);

	float noiseAmount = 1.f;

	if (variability < 1.f)
		noiseAmount = Lerp(variability, 1.f, CloudTexture_NoiseMask(p + (float3)(noiseOffset * 4.f, 0.f, 0.f), radius, omega));


	noiseAmount = clamp(noiseAmount, 0.f, 1.f);

	float3 turbulence;

	turbulence.x = CloudTexture_CloudNoise(noiseCoords[0], omega, octaves) - 0.15f;
	turbulence.y = CloudTexture_CloudNoise(noiseCoords[1], omega, octaves) - 0.15f;
	turbulence.z = -CloudTexture_CloudNoise(noiseCoords[2], omega, octaves);
	if (p.z < sphereCentre.z + baseFadeDistance)
		turbulence.z *= (p.z - sphereCentre.z) / (2.f * baseFadeDistance);

	turbulence *= noiseAmount;

	return turbulence;
}

float CloudTexture_CloudShape(const float3 p, const float baseFadeDistance, const float3 sphereCentre, const uint numSpheres, const float radius) {
/*	if (numSpheres > 0) {
		if (SphereFunction(p, numSpheres))		//shows cumulus spheres
			return 1.f;
		else
			return 0.f;
	}
*/
	const float3 fromCentre = p - sphereCentre;

	float amount = 1.f - sqrt(fromCentre.x*fromCentre.x + fromCentre.y*fromCentre.y + fromCentre.z*fromCentre.z) / radius;
	if (amount < 0.f)
		return 0.f;

	// The base below the cloud's height fades out
	if (p.z < sphereCentre.z) {
		if (p.z < sphereCentre.z - radius * 0.4f)
			return 0.f;

		amount *= 1.f - cos((fromCentre.z + baseFadeDistance) /
			baseFadeDistance * M_PI_F * 0.5f);
	}
	return max(amount, 0.f);
}

/*
bool CloudTexture_SphereFunction(const float3 p, uint numSpheres) const {
// Returns whether a point is inside one of the cumulus spheres
	for (uint i = 0; i < numSpheres; ++i) {
		if ((p - spheres[i].position).Length() < spheres[i].radius)
			return true;
	}
	return false;
}
*/

float CloudTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float radius, const uint numSpheres, const uint spheresize, const float sharpness,
		const float baseFadeDistance, const float baseFlatness, const float variability,
		const float omega, const float firstNoiseScale, const float noiseOffset, const float turbulenceAmount,
		const uint numOctaves, __global const TextureMapping3D *mapping) {

	const float3 mapP = TextureMapping3D_Map(mapping, hitPoint);
	const float3 sphereCentre = (float3)(.5f, .5f, 1.f / 3.f);
	const float amount = CloudTexture_CloudShape(mapP + turbulenceAmount * CloudTexture_Turbulence(mapP, firstNoiseScale, noiseOffset, variability, numOctaves, radius, omega, baseFlatness, sphereCentre), baseFadeDistance, sphereCentre, numSpheres, radius);
	const float finalValue = pow(amount * pow(10.f, .7f), sharpness);

	return min(finalValue, 1.f);
}

float3 CloudTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float radius, const uint numSpheres, const uint spheresize, const float sharpness,
		const float baseFadeDistance, const float baseFlatness, const float variability,
		const float omega, const float firstNoiseScale, const float noiseOffset, const float turbulenceAmount,
		const uint numOctaves, __global const TextureMapping3D *mapping) {

	const float3 mapP = TextureMapping3D_Map(mapping, hitPoint);
	const float3 sphereCentre = (float3)(.5f, .5f, 1.f / 3.f);
	const float amount = CloudTexture_CloudShape(mapP + turbulenceAmount * CloudTexture_Turbulence(mapP, firstNoiseScale, noiseOffset, variability, numOctaves, radius, omega, baseFlatness, sphereCentre), baseFadeDistance, sphereCentre, numSpheres, radius);
	const float finalValue = pow(amount * pow(10.f, .7f), sharpness);

	return min(finalValue, 1.f);
}


#endif

//------------------------------------------------------------------------------
// FBM texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_FBM_TEX)

float FBMTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
	const float omega, const int octaves, __global const TextureMapping3D *mapping) {
	const float3 mapP = TextureMapping3D_Map(mapping, hitPoint);

	return FBm(mapP, omega, octaves);
}

float3 FBMTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
	const float omega, const int octaves, __global const TextureMapping3D *mapping) {
	const float3 mapP = TextureMapping3D_Map(mapping, hitPoint);

	return FBm(mapP, omega, octaves);
}

#endif

//------------------------------------------------------------------------------
// Marble texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_MARBLE)

// Evaluate marble spline at _t_
__constant float MarbleTexture_c[9][3] = {
	{ .58f, .58f, .6f},
	{ .58f, .58f, .6f},
	{ .58f, .58f, .6f},
	{ .5f, .5f, .5f},
	{ .6f, .59f, .58f},
	{ .58f, .58f, .6f},
	{ .58f, .58f, .6f},
	{.2f, .2f, .33f},
	{ .58f, .58f, .6f}
};

float3 MarbleTexture_Evaluate(__global HitPoint *hitPoint, const float scale,
		const float omega, const int octaves, const float variation,
		__global const TextureMapping3D *mapping) {
	const float3 P = scale * TextureMapping3D_Map(mapping, hitPoint);

	float marble = P.y + variation * FBm(P, omega, octaves);
	float t = .5f + .5f * sin(marble);
#define NC  sizeof(MarbleTexture_c) / sizeof(MarbleTexture_c[0])
#define NSEG (NC-3)
	const int first = Floor2Int(t * NSEG);
	t = (t * NSEG - first);
#undef NC
#undef NSEG
#define ASSIGN_CF3(a) (float3)(a[0], a[1], a[2])
	const float3 c0 = ASSIGN_CF3(MarbleTexture_c[first]);
	const float3 c1 = ASSIGN_CF3(MarbleTexture_c[first + 1]);
	const float3 c2 = ASSIGN_CF3(MarbleTexture_c[first + 2]);
	const float3 c3 = ASSIGN_CF3(MarbleTexture_c[first + 3]);
#undef ASSIGN_CF3
	// Bezier spline evaluated with de Castilejau's algorithm
	float3 s0 = mix(c0, c1, t);
	float3 s1 = mix(c1, c2, t);
	float3 s2 = mix(c2, c3, t);
	s0 = mix(s0, s1, t);
	s1 = mix(s1, s2, t);
	// Extra scale of 1.5 to increase variation among colors
	return 1.5f * mix(s0, s1, t);
}

float MarbleTexture_ConstEvaluateFloat(__global HitPoint *hitPoint, const float scale,
		const float omega, const int octaves, const float variation,
		__global const TextureMapping3D *mapping) {
	return Spectrum_Y(MarbleTexture_Evaluate(hitPoint, scale, omega, octaves,
			variation, mapping));
}

float3 MarbleTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint, const float scale,
		const float omega, const int octaves, const float variation,
		__global const TextureMapping3D *mapping) {
	return MarbleTexture_Evaluate(hitPoint, scale, omega, octaves,
			variation, mapping);
}

#endif

//------------------------------------------------------------------------------
// Dots texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_DOTS)

bool DotsTexture_Evaluate(__global HitPoint *hitPoint, __global const TextureMapping2D *mapping) {
	const float2 uv = TextureMapping2D_Map(mapping, hitPoint);

	const int sCell = Floor2Int(uv.s0 + .5f);
	const int tCell = Floor2Int(uv.s1 + .5f);
	// Return _insideDot_ result if point is inside dot
	if (Noise(sCell + .5f, tCell + .5f, .5f) > 0.f) {
		const float radius = .35f;
		const float maxShift = 0.5f - radius;
		const float sCenter = sCell + maxShift *
			Noise(sCell + 1.5f, tCell + 2.8f, .5f);
		const float tCenter = tCell + maxShift *
			Noise(sCell + 4.5f, tCell + 9.8f, .5f);
		const float ds = uv.s0 - sCenter, dt = uv.s1 - tCenter;
		if (ds * ds + dt * dt < radius * radius)
			return true;
	}

	return false;
}

float DotsTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float value1, const float value2, __global const TextureMapping2D *mapping) {
	return DotsTexture_Evaluate(hitPoint, mapping) ? value1 : value2;
}

float3 DotsTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 value1, const float3 value2, __global const TextureMapping2D *mapping) {
	return DotsTexture_Evaluate(hitPoint, mapping) ? value1 : value2;
}

#endif

//------------------------------------------------------------------------------
// Brick texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_BRICK)

bool BrickTexture_RunningAlternate(const float3 p, float3 *i, float3 *b,
		const float run, const float mortarwidth,
		const float mortarheight, const float mortardepth,
		int nWhole) {
	const float sub = nWhole + 0.5f;
	const float rsub = ceil(sub);
	(*i).z = floor(p.z);
	(*b).x = (p.x + (*i).z * run) / sub;
	(*b).y = (p.y + (*i).z * run) / sub;
	(*i).x = floor((*b).x);
	(*i).y = floor((*b).y);
	(*b).x = ((*b).x - (*i).x) * sub;
	(*b).y = ((*b).y - (*i).y) * sub;
	(*b).z = (p.z - (*i).z) * sub;
	(*i).x += floor((*b).x) / rsub;
	(*i).y += floor((*b).y) / rsub;
	(*b).x -= floor((*b).x);
	(*b).y -= floor((*b).y);
	return (*b).z > mortarheight && (*b).y > mortardepth &&
		(*b).x > mortarwidth;
}

bool BrickTexture_Basket(const float3 p, float3 *i,
		const float mortarwidth, const float mortardepth,
		const float proportion, const float invproportion) {
	(*i).x = floor(p.x);
	(*i).y = floor(p.y);
	float bx = p.x - (*i).x;
	float by = p.y - (*i).y;
	(*i).x += (*i).y - 2.f * floor(0.5f * (*i).y);
	const bool split = ((*i).x - 2.f * floor(0.5f * (*i).x)) < 1.f;
	if (split) {
		bx = fmod(bx, invproportion);
		(*i).x = floor(proportion * p.x) * invproportion;
	} else {
		by = fmod(by, invproportion);
		(*i).y = floor(proportion * p.y) * invproportion;
	}
	return by > mortardepth && bx > mortarwidth;
}

bool BrickTexture_Herringbone(const float3 p, float3 *i,
		const float mortarwidth, const float mortarheight,
		const float proportion, const float invproportion) {
	(*i).y = floor(proportion * p.y);
	const float px = p.x + (*i).y * invproportion;
	(*i).x = floor(px);
	float bx = 0.5f * px - floor(px * 0.5f);
	bx *= 2.f;
	float by = proportion * p.y - floor(proportion * p.y);
	by *= invproportion;
	if (bx > 1.f + invproportion) {
		bx = proportion * (bx - 1.f);
		(*i).y -= floor(bx - 1.f);
		bx -= floor(bx);
		bx *= invproportion;
		by = 1.f;
	} else if (bx > 1.f) {
		bx = proportion * (bx - 1.f);
		(*i).y -= floor(bx - 1.f);
		bx -= floor(bx);
		bx *= invproportion;
	}
	return by > mortarheight && bx > mortarwidth;
}

bool BrickTexture_Running(const float3 p, float3 *i, float3 *b,
		const float run, const float mortarwidth,
		const float mortarheight, const float mortardepth) {
	(*i).z = floor(p.z);
	(*b).x = p.x + (*i).z * run;
	(*b).y = p.y - (*i).z * run;
	(*i).x = floor((*b).x);
	(*i).y = floor((*b).y);
	(*b).z = p.z - (*i).z;
	(*b).x -= (*i).x;
	(*b).y -= (*i).y;
	return (*b).z > mortarheight && (*b).y > mortardepth &&
		(*b).x > mortarwidth;
}

bool BrickTexture_English(const float3 p, float3 *i, float3 *b,
		const float run, const float mortarwidth,
		const float mortarheight, const float mortardepth) {
	(*i).z = floor(p.z);
	(*b).x = p.x + (*i).z * run;
	(*b).y = p.y - (*i).z * run;
	(*i).x = floor((*b).x);
	(*i).y = floor((*b).y);
	(*b).z = p.z - (*i).z;
	const float divider = floor(fmod(fabs((*i).z), 2.f)) + 1.f;
	(*b).x = (divider * (*b).x - floor(divider * (*b).x)) / divider;
	(*b).y = (divider * (*b).y - floor(divider * (*b).y)) / divider;
	return (*b).z > mortarheight && (*b).y > mortardepth &&
		(*b).x > mortarwidth;
}

bool BrickTexture_Evaluate(__global HitPoint *hitPoint,
		const MasonryBond bond,
		const float brickwidth, const float brickheight,
		const float brickdepth, const float mortarsize,
		const float3 offset,
		const float run, const float mortarwidth,
		const float mortarheight, const float mortardepth,
		const float proportion, const float invproportion,
		__global const TextureMapping3D *mapping) {
#define BRICK_EPSILON 1e-3f
	const float3 P = TextureMapping3D_Map(mapping, hitPoint);

	const float offs = BRICK_EPSILON + mortarsize;
	float3 bP = P + (float3)(offs, offs, offs);

	// Normalize coordinates according brick dimensions
	bP.x /= brickwidth;
	bP.y /= brickdepth;
	bP.z /= brickheight;

	bP += offset;

	float3 brickIndex;
	float3 bevel;
	bool b;
	switch (bond) {
		case FLEMISH:
			b = BrickTexture_RunningAlternate(bP, &brickIndex, &bevel,
					run , mortarwidth, mortarheight, mortardepth, 1);
			break;
		case RUNNING:
			b = BrickTexture_Running(bP, &brickIndex, &bevel,
					run, mortarwidth, mortarheight, mortardepth);
			break;
		case ENGLISH:
			b = BrickTexture_English(bP, &brickIndex, &bevel,
					run, mortarwidth, mortarheight, mortardepth);
			break;
		case HERRINGBONE:
			b = BrickTexture_Herringbone(bP, &brickIndex,
					mortarwidth, mortarheight, proportion, invproportion);
			break;
		case BASKET:
			b = BrickTexture_Basket(bP, &brickIndex,
					mortarwidth, mortardepth, proportion, invproportion);
			break;
		case KETTING:
			b = BrickTexture_RunningAlternate(bP, &brickIndex, &bevel,
					run, mortarwidth, mortarheight, mortardepth, 2);
			break;
		default:
			b = true;
			break;
	}

	return b;
#undef BRICK_EPSILON
}

float BrickTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float value1, const float value2, const float value3,
		const MasonryBond bond,
		const float brickwidth, const float brickheight,
		const float brickdepth, const float mortarsize,
		const float3 offset,
		const float run, const float mortarwidth,
		const float mortarheight, const float mortardepth,
		const float proportion, const float invproportion,
		__global const TextureMapping3D *mapping) {
	return BrickTexture_Evaluate(hitPoint,
			bond,
			brickwidth, brickheight,
			brickdepth, mortarsize,
			offset,
			run, mortarwidth,
			mortarheight, mortardepth,
			proportion, invproportion,
			mapping) ? (value1 * value3) : value2;
}

float3 BrickTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 value1, const float3 value2, const float3 value3,
		const MasonryBond bond,
		const float brickwidth, const float brickheight,
		const float brickdepth, const float mortarsize,
		const float3 offset,
		const float run, const float mortarwidth,
		const float mortarheight, const float mortardepth,
		const float proportion, const float invproportion,
		__global const TextureMapping3D *mapping) {
	return BrickTexture_Evaluate(hitPoint,
			bond,
			brickwidth, brickheight,
			brickdepth, mortarsize,
			offset,
			run , mortarwidth,
			mortarheight, mortardepth,
			proportion, invproportion,
			mapping) ? (value1 * value3) : value2;
}

#endif

//------------------------------------------------------------------------------
// Add texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_ADD)

float AddTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float value1, const float value2) {
	return value1 + value2;
}

float3 AddTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float3 value1, const float3 value2) {
	return value1 + value2;
}

#endif

//------------------------------------------------------------------------------
// Subtract texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_SUBTRACT)

float SubtractTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
const float value1, const float value2) {
	return value1 - value2;
}

float3 SubtractTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
const float3 value1, const float3 value2) {
	return value1 - value2;
}

#endif

//------------------------------------------------------------------------------
// Windy texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_WINDY)

float WindyTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		__global const TextureMapping3D *mapping) {
	const float3 mapP = TextureMapping3D_Map(mapping, hitPoint);

	const float windStrength = FBm(.1f * mapP, .5f, 3);
	const float waveHeight = FBm(mapP, .5f, 6);

	return fabs(windStrength) * waveHeight;
}

float3 WindyTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		__global const TextureMapping3D *mapping) {
	return WindyTexture_ConstEvaluateFloat(hitPoint, mapping);
}

#endif

//------------------------------------------------------------------------------
// Wrinkled texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_WRINKLED)

float WrinkledTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const float omega, const int octaves,
		__global const TextureMapping3D *mapping) {
	const float3 mapP = TextureMapping3D_Map(mapping, hitPoint);

	return Turbulence(mapP, omega, octaves);
}

float3 WrinkledTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const float omega, const int octaves,
		__global const TextureMapping3D *mapping) {
	return WrinkledTexture_ConstEvaluateFloat(hitPoint, omega, octaves, mapping);
}

#endif

//------------------------------------------------------------------------------
// UV texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_UV)

float UVTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		__global const TextureMapping2D *mapping) {
	const float2 uv = TextureMapping2D_Map(mapping, hitPoint);

	return Spectrum_Y((float3)(uv.s0 - Floor2Int(uv.s0), uv.s1 - Floor2Int(uv.s1), 0.f));
}

float3 UVTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		__global const TextureMapping2D *mapping) {
	const float2 uv = TextureMapping2D_Map(mapping, hitPoint);

	return (float3)(uv.s0 - Floor2Int(uv.s0), uv.s1 - Floor2Int(uv.s1), 0.f);
}

#endif

//------------------------------------------------------------------------------
// Band texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_BAND)

float3 BandTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint,
		const InterpolationType interpType,
		const uint size, __global float *offsets,
		__global Spectrum *values, const float3 amt) {
	const float a = clamp(Spectrum_Y(amt), 0.f, 1.f);

	const uint last = size - 1;
	if (a < offsets[0])
		return VLOAD3F(values[0].c);
	else if (a >= offsets[last])
		return VLOAD3F(values[last].c);
	else {
		int p = 0;
		for (; p <= last; ++p) {
			if (a < offsets[p])
				break;
		}

		const float o1 = offsets[p - 1];
		const float o0 = offsets[p];
		const float factor = (a - o1) / (o0 - o1);

		if (interpType == INTERP_NONE)
			return VLOAD3F(values[p - 1].c);
		else if (interpType == INTERP_LINEAR) {
			const float3 p0 = VLOAD3F(values[p - 1].c);
			const float3 p1 = VLOAD3F(values[p].c);

			return Lerp3(factor, p0, p1);
		} else if (interpType == INTERP_CUBIC) {
			const float3 p0 = VLOAD3F(values[max(p - 2, 0)].c);
			const float3 p1 = VLOAD3F(values[p - 1].c);
			const float3 p2 = VLOAD3F(values[p].c);
			const float3 p3 = VLOAD3F(values[min(p + 1, (int)last)].c);

			return Cerp3(factor, p0, p1, p2, p3);
		} else
			return 0.f;
	}
}

float BandTexture_ConstEvaluateFloat(__global HitPoint *hitPoint,
		const InterpolationType interpType,
		const uint size, __global float *offsets,
		__global Spectrum *values, const float amt) {
	return Spectrum_Y(BandTexture_ConstEvaluateSpectrum(hitPoint,
			interpType, size, offsets, values, amt));
}

#endif

//------------------------------------------------------------------------------
// HitPointColor texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_HITPOINTCOLOR)

float HitPointColorTexture_ConstEvaluateFloat(__global HitPoint *hitPoint) {
	return Spectrum_Y(VLOAD3F(hitPoint->color.c));
}

float3 HitPointColorTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint) {
	return VLOAD3F(hitPoint->color.c);
}

#endif

//------------------------------------------------------------------------------
// HitPointAlpha texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_HITPOINTALPHA)

float HitPointAlphaTexture_ConstEvaluateFloat(__global HitPoint *hitPoint) {
	return hitPoint->alpha;
}

float3 HitPointAlphaTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint) {
	const float alpha = hitPoint->alpha;
	return (float3)(alpha, alpha, alpha);
}

#endif

//------------------------------------------------------------------------------
// HitPointGrey texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_HITPOINTGREY)

float HitPointGreyTexture_ConstEvaluateFloat(__global HitPoint *hitPoint, const uint channel) {
	switch (channel) {
		case 0:
			return hitPoint->color.c[0];
		case 1:
			return hitPoint->color.c[1];
		case 2:
			return hitPoint->color.c[2];
		default:
			return Spectrum_Y(VLOAD3F(hitPoint->color.c));
	}
}

float3 HitPointGreyTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint, const uint channel) {
	float v;
	switch (channel) {
		case 0:
			v = hitPoint->color.c[0];
			break;
		case 1:
			v = hitPoint->color.c[1];
			break;
		case 2:
			v = hitPoint->color.c[2];
			break;
		default:
			v = Spectrum_Y(VLOAD3F(hitPoint->color.c));
			break;
	}

	return (float3)(v, v, v);
}

#endif

//------------------------------------------------------------------------------
// NormalMap texture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_NORMALMAP)

float NormalMapTexture_ConstEvaluateFloat(__global HitPoint *hitPoint) {
    return 0.f;
}

float3 NormalMapTexture_ConstEvaluateSpectrum(__global HitPoint *hitPoint) {
	return (float3)(0.f, 0.f, 0.f);
}

#endif
#line 2 "Texture evaluation code form CompiledScene::GetTexturesEvaluationSourceCode()"
float Texture_Index0_EvaluateFloat(__global const Texture *texture,
		__global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	return ImageMapTexture_ConstEvaluateFloat(hitPoint, 1.1, 0, &texture->imageMapTex.mapping IMAGEMAPS_PARAM);
}
float3 Texture_Index0_EvaluateSpectrum(__global const Texture *texture,
		__global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	return ImageMapTexture_ConstEvaluateSpectrum(hitPoint, 1.1, 0, &texture->imageMapTex.mapping IMAGEMAPS_PARAM);
}
float Texture_Index1_EvaluateFloat(__global const Texture *texture,
		__global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	return ConstFloat3Texture_ConstEvaluateFloat(hitPoint, (float3)(0.8, 0.8, 0.8));
}
float3 Texture_Index1_EvaluateSpectrum(__global const Texture *texture,
		__global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	return ConstFloat3Texture_ConstEvaluateSpectrum(hitPoint, (float3)(0.8, 0.8, 0.8));
}
float Texture_Index2_EvaluateFloat(__global const Texture *texture,
		__global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	return ConstFloat3Texture_ConstEvaluateFloat(hitPoint, (float3)(0.25, 0.25, 0.25));
}
float3 Texture_Index2_EvaluateSpectrum(__global const Texture *texture,
		__global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	return ConstFloat3Texture_ConstEvaluateSpectrum(hitPoint, (float3)(0.25, 0.25, 0.25));
}
float Texture_Index3_EvaluateFloat(__global const Texture *texture,
		__global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	return ConstFloat3Texture_ConstEvaluateFloat(hitPoint, (float3)(0.75, 0.75, 0.75));
}
float3 Texture_Index3_EvaluateSpectrum(__global const Texture *texture,
		__global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	return ConstFloat3Texture_ConstEvaluateSpectrum(hitPoint, (float3)(0.75, 0.75, 0.75));
}
float Texture_GetFloatValue(const uint texIndex, __global HitPoint *hitPoint TEXTURES_PARAM_DECL) {
	 __global const Texture *tex = &texs[texIndex];
	switch (texIndex) {
		case 0: return Texture_Index0_EvaluateFloat(tex, hitPoint TEXTURES_PARAM);
		case 1: return Texture_Index1_EvaluateFloat(tex, hitPoint TEXTURES_PARAM);
		case 2: return Texture_Index2_EvaluateFloat(tex, hitPoint TEXTURES_PARAM);
		case 3: return Texture_Index3_EvaluateFloat(tex, hitPoint TEXTURES_PARAM);
		default: return 0.f;
	}
}
float3 Texture_GetSpectrumValue(const uint texIndex, __global HitPoint *hitPoint TEXTURES_PARAM_DECL) {
	 __global const Texture *tex = &texs[texIndex];
	switch (texIndex) {
		case 0: return Texture_Index0_EvaluateSpectrum(tex, hitPoint TEXTURES_PARAM);
		case 1: return Texture_Index1_EvaluateSpectrum(tex, hitPoint TEXTURES_PARAM);
		case 2: return Texture_Index2_EvaluateSpectrum(tex, hitPoint TEXTURES_PARAM);
		case 3: return Texture_Index3_EvaluateSpectrum(tex, hitPoint TEXTURES_PARAM);
		default: return BLACK;
	}
}
#line 2 "texture_bump_funcs.cl"

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

//------------------------------------------------------------------------------
// Texture bump/normal mapping
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_BUMPMAPS)

//------------------------------------------------------------------------------
// Generic texture bump mapping
//------------------------------------------------------------------------------

float3 GenericTexture_Bump(
		const uint texIndex,
		__global HitPoint *hitPoint,
		const float sampleDistance
		TEXTURES_PARAM_DECL) {
	const float3 dpdu = VLOAD3F(&hitPoint->dpdu.x);
	const float3 dpdv = VLOAD3F(&hitPoint->dpdv.x);
	const float3 dndu = VLOAD3F(&hitPoint->dndu.x);
	const float3 dndv = VLOAD3F(&hitPoint->dndv.x);

	// Calculate bump map value at intersection point
	const float base = Texture_GetFloatValue(texIndex, hitPoint
			TEXTURES_PARAM);

	// Compute offset positions and evaluate displacement texIndex
	const float3 origP = VLOAD3F(&hitPoint->p.x);
	const float3 origShadeN = VLOAD3F(&hitPoint->shadeN.x);
	const float2 origUV = VLOAD2F(&hitPoint->uv.u);

	float2 duv;

	// Shift hitPointTmp.du in the u direction and calculate value
	const float uu = sampleDistance / length(dpdu);
	VSTORE3F(origP + uu * dpdu, &hitPoint->p.x);
	hitPoint->uv.u += uu;
	VSTORE3F(normalize(origShadeN + uu * dndu), &hitPoint->shadeN.x);
	const float duValue = Texture_GetFloatValue(texIndex, hitPoint
			TEXTURES_PARAM);
	duv.s0 = (duValue - base) / uu;

	// Shift hitPointTmp.dv in the v direction and calculate value
	const float vv = sampleDistance / length(dpdv);
	VSTORE3F(origP + vv * dpdv, &hitPoint->p.x);
	hitPoint->uv.u = origUV.s0;
	hitPoint->uv.v += vv;
	VSTORE3F(normalize(origShadeN + vv * dndv), &hitPoint->shadeN.x);
	const float dvValue = Texture_GetFloatValue(texIndex, hitPoint
			TEXTURES_PARAM);
	duv.s1 = (dvValue - base) / vv;

	// Restore HitPoint
	VSTORE3F(origP, &hitPoint->p.x);
	VSTORE2F(origUV, &hitPoint->uv.u);

	// Compute the new dpdu and dpdv
	const float3 bumpDpdu = dpdu + duv.s0 * origShadeN;
	const float3 bumpDpdv = dpdv + duv.s1 * origShadeN;
	float3 newShadeN = normalize(cross(bumpDpdu, bumpDpdv));

	// The above transform keeps the normal in the original normal
	// hemisphere. If they are opposed, it means UVN was indirect and
	// the normal needs to be reversed
	newShadeN *= (dot(origShadeN, newShadeN) < 0.f) ? -1.f : 1.f;

	return newShadeN;
}

//------------------------------------------------------------------------------
// ImageMapTexture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_IMAGEMAP)
float3 ImageMapTexture_Bump(__global HitPoint *hitPoint,
		const float sampleDistance, const float gain,
		const uint imageMapIndex, __global const TextureMapping2D *mapping
		IMAGEMAPS_PARAM_DECL) {
	float2 du, dv;
	const float2 uv = TextureMapping2D_MapDuv(mapping, hitPoint, &du, &dv);
	__global const ImageMap *imageMap = &imageMapDescs[imageMapIndex];
	const float2 dst = ImageMap_GetDuv(imageMap, uv.x, uv.y IMAGEMAPS_PARAM);
	const float2 duv = gain * (float2)(dot(dst, du), dot(dst, dv));
	const float3 shadeN = VLOAD3F(&hitPoint->shadeN.x);
	const float3 n = normalize(cross(VLOAD3F(&hitPoint->dpdu.x) + duv.x * shadeN, VLOAD3F(&hitPoint->dpdv.x) + duv.y * shadeN));
	if (dot(n, shadeN) < 0.f)
		return -n;
	else
		return n;
}
#endif

//------------------------------------------------------------------------------
// NormalMapTexture
//------------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_NORMALMAP)
float3 NormalMapTexture_Bump(
		const uint texIndex,
		__global HitPoint *hitPoint,
		const float sampleDistance
		TEXTURES_PARAM_DECL) {
	// Normal from normal map
	const __global Texture *texture = &texs[texIndex];
	float3 rgb = Texture_GetSpectrumValue(texture->normalMap.texIndex, hitPoint
			TEXTURES_PARAM);
	rgb = clamp(rgb, -1.f, 1.f);

	// Normal from normal map
	float3 n = 2.f * rgb - (float3)(1.f, 1.f, 1.f);

	const float3 oldShadeN = VLOAD3F(&hitPoint->shadeN.x);
	float3 dpdu = VLOAD3F(&hitPoint->dpdu.x);
	float3 dpdv = VLOAD3F(&hitPoint->dpdv.x);

	Frame frame;
	Frame_Set_Private(&frame, dpdu, dpdv, oldShadeN);

	// Transform n from tangent to object space
	float3 shadeN = normalize(Frame_ToWorld_Private(&frame, n));
	shadeN *= (dot(oldShadeN, shadeN) < 0.f) ? -1.f : 1.f;

	return shadeN;
}
#endif

#endif
#if defined(PARAM_HAS_BUMPMAPS)
#if defined(PARAM_ENABLE_TEX_IMAGEMAP)
float3 Texture_Index0_Bump(__global HitPoint *hitPoint,
		const float sampleDistance
		TEXTURES_PARAM_DECL) {
	const __global Texture *texture = &texs[0];
	return ImageMapTexture_Bump(hitPoint, sampleDistance,
1.1, 0, &texture->imageMapTex.mapping IMAGEMAPS_PARAM);
}
#endif
float3 Texture_Index1_Bump(__global HitPoint *hitPoint,
		const float sampleDistance
		TEXTURES_PARAM_DECL) {
	return VLOAD3F(&hitPoint->shadeN.x);
}
float3 Texture_Index2_Bump(__global HitPoint *hitPoint,
		const float sampleDistance
		TEXTURES_PARAM_DECL) {
	return VLOAD3F(&hitPoint->shadeN.x);
}
float3 Texture_Index3_Bump(__global HitPoint *hitPoint,
		const float sampleDistance
		TEXTURES_PARAM_DECL) {
	return VLOAD3F(&hitPoint->shadeN.x);
}
#endif

#line 2 "materialdefs_funcs_generic.cl"

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

//------------------------------------------------------------------------------
// Generic material related functions
//------------------------------------------------------------------------------

float SchlickDistribution_SchlickZ(const float roughness, float cosNH) {
	if (roughness > 0.f) {
		const float cosNH2 = cosNH * cosNH;
		// expanded for increased numerical stability
		const float d = cosNH2 * roughness + (1.f - cosNH2);
		// use double division to avoid overflow in d*d product
		return (roughness / d) / d;
	}
	return 0.f;
}

float SchlickDistribution_SchlickA(const float3 H, const float anisotropy) {
	const float h = sqrt(H.x * H.x + H.y * H.y);
	if (h > 0.f) {
		const float w = (anisotropy > 0.f ? H.x : H.y) / h;
		const float p = 1.f - fabs(anisotropy);
		return sqrt(p / (p * p + w * w * (1.f - p * p)));
	}

	return 1.f;
}

float SchlickDistribution_D(const float roughness, const float3 wh, const float anisotropy) {
	const float cosTheta = fabs(wh.z);
	return SchlickDistribution_SchlickZ(roughness, cosTheta) * SchlickDistribution_SchlickA(wh, anisotropy) * M_1_PI_F;
}

float SchlickDistribution_SchlickG(const float roughness, const float costheta) {
	return costheta / (costheta * (1.f - roughness) + roughness);
}

float SchlickDistribution_G(const float roughness, const float3 fixedDir, const float3 sampledDir) {
	return SchlickDistribution_SchlickG(roughness, fabs(fixedDir.z)) *
			SchlickDistribution_SchlickG(roughness, fabs(sampledDir.z));
}

float GetPhi(const float a, const float b) {
	return M_PI_F * .5f * sqrt(a * b / (1.f - a * (1.f - b)));
}

void SchlickDistribution_SampleH(const float roughness, const float anisotropy,
		const float u0, const float u1, float3 *wh, float *d, float *pdf) {
	float u1x4 = u1 * 4.f;
	// Values of roughness < .0001f seems to trigger some kind of exceptions with
	// AMD OpenCL on GPUs. The result is a nearly freeze of the PC.
	const float cos2Theta = (roughness < .0001f) ? 1.f : (u0 / (roughness * (1.f - u0) + u0));
	const float cosTheta = sqrt(cos2Theta);
	const float sinTheta = sqrt(1.f - cos2Theta);
	const float p = 1.f - fabs(anisotropy);
	float phi;
	if (u1x4 < 1.f) {
		phi = GetPhi(u1x4 * u1x4, p * p);
	} else if (u1x4 < 2.f) {
		u1x4 = 2.f - u1x4;
		phi = M_PI_F - GetPhi(u1x4 * u1x4, p * p);
	} else if (u1x4 < 3.f) {
		u1x4 -= 2.f;
		phi = M_PI_F + GetPhi(u1x4 * u1x4, p * p);
	} else {
		u1x4 = 4.f - u1x4;
		phi = M_PI_F * 2.f - GetPhi(u1x4 * u1x4, p * p);
	}

	if (anisotropy > 0.f)
		phi += M_PI_F * .5f;

	*wh = (float3)(sinTheta * cos(phi), sinTheta * sin(phi), cosTheta);
	*d = SchlickDistribution_SchlickZ(roughness, cosTheta) * SchlickDistribution_SchlickA(*wh, anisotropy) * M_1_PI_F;
	*pdf = *d;
}

float SchlickDistribution_Pdf(const float roughness, const float3 wh,
		const float anisotropy) {
	return SchlickDistribution_D(roughness, wh, anisotropy);
}

float3 FresnelSchlick_Evaluate(const float3 normalIncidence, const float cosi) {
	return normalIncidence + (WHITE - normalIncidence) *
		pow(1.f - cosi, 5.f);
}

float3 CoatingAbsorption(const float cosi, const float coso,
		const float3 alpha, const float depth) {
	if (depth > 0.f) {
		// 1/cosi+1/coso=(cosi+coso)/(cosi*coso)
		const float depthFactor = depth * (cosi + coso) / (cosi * coso);
		return Spectrum_Exp(alpha * -depthFactor);
	} else
		return WHITE;
}

float SchlickBSDF_CoatingWeight(const float3 ks, const float3 fixedDir) {
	// Approximate H by using reflection direction for wi
	const float u = fabs(fixedDir.z);
	const float3 S = FresnelSchlick_Evaluate(ks, u);

	// Ensures coating is never sampled less than half the time
	return .5f * (1.f + Spectrum_Filter(S));
}

float3 SchlickBSDF_CoatingF(const float3 ks, const float roughness,
		const float anisotropy, const int multibounce, const float3 fixedDir,
		const float3 sampledDir) {
	const float coso = fabs(fixedDir.z);
	const float cosi = fabs(sampledDir.z);

	const float3 wh = normalize(fixedDir + sampledDir);
	const float3 S = FresnelSchlick_Evaluate(ks, fabs(dot(sampledDir, wh)));

	const float G = SchlickDistribution_G(roughness, fixedDir, sampledDir);

	// Multibounce - alternative with interreflection in the coating creases
	float factor = SchlickDistribution_D(roughness, wh, anisotropy) * G;
	//if (!fromLight)
		factor = factor / 4.f * coso +
				(multibounce ? cosi * clamp((1.f - G) / (4.f * coso * cosi), 0.f, 1.f) : 0.f);
	//else
	//	factor = factor / (4.f * cosi) +
	//			(multibounce ? coso * Clamp((1.f - G) / (4.f * cosi * coso), 0.f, 1.f) : 0.f);

	return factor * S;
}

float3 SchlickBSDF_CoatingSampleF(const float3 ks,
		const float roughness, const float anisotropy, const int multibounce,
		const float3 fixedDir, float3 *sampledDir,
		float u0, float u1, float *pdf) {
	float3 wh;
	float d, specPdf;
	SchlickDistribution_SampleH(roughness, anisotropy, u0, u1, &wh, &d, &specPdf);
	const float cosWH = dot(fixedDir, wh);
	*sampledDir = 2.f * cosWH * wh - fixedDir;

	if ((fabs((*sampledDir).z) < DEFAULT_COS_EPSILON_STATIC) || (fixedDir.z * (*sampledDir).z < 0.f))
		return BLACK;

	const float coso = fabs(fixedDir.z);
	const float cosi = fabs((*sampledDir).z);

	*pdf = specPdf / (4.f * cosWH);
	if (*pdf <= 0.f)
		return BLACK;

	float3 S = FresnelSchlick_Evaluate(ks, fabs(cosWH));

	const float G = SchlickDistribution_G(roughness, fixedDir, *sampledDir);

	//CoatingF(sw, *wi, wo, f_);
	S *= (d / *pdf) * G / (4.f * coso) +
			(multibounce ? cosi * clamp((1.f - G) / (4.f * coso * cosi), 0.f, 1.f) / *pdf : 0.f);

	return S;
}

float SchlickBSDF_CoatingPdf(const float roughness, const float anisotropy,
		const float3 fixedDir, const float3 sampledDir) {
	const float3 wh = normalize(fixedDir + sampledDir);
	return SchlickDistribution_Pdf(roughness, wh, anisotropy) / (4.f * fabs(dot(fixedDir, wh)));
}

float3 FrDiel2(const float cosi, const float3 cost, const float3 eta) {
	float3 Rparl = eta * cosi;
	Rparl = (cost - Rparl) / (cost + Rparl);
	float3 Rperp = eta * cost;
	Rperp = (cosi - Rperp) / (cosi + Rperp);

	return (Rparl * Rparl + Rperp * Rperp) * .5f;
}

float3 FrFull(const float cosi, const float3 cost, const float3 eta, const float3 k) {
	const float3 tmp = (eta * eta + k * k) * (cosi * cosi) + (cost * cost);
	const float3 Rparl2 = (tmp - (2.f * cosi * cost) * eta) /
		(tmp + (2.f * cosi * cost) * eta);
	const float3 tmp_f = (eta * eta + k * k) * (cost * cost) + (cosi * cosi);
	const float3 Rperp2 = (tmp_f - (2.f * cosi * cost) * eta) /
		(tmp_f + (2.f * cosi * cost) * eta);
	return (Rparl2 + Rperp2) * 0.5f;
}

float3 FresnelGeneral_Evaluate(const float3 eta, const float3 k, const float cosi) {
	float3 sint2 = fmax(0.f, 1.f - cosi * cosi);
	if (cosi > 0.f)
		sint2 /= eta * eta;
	else
		sint2 *= eta * eta;
	sint2 = Spectrum_Clamp(sint2);

	const float3 cost2 = 1.f - sint2;
	if (cosi > 0.f) {
		const float3 a = 2.f * k * k * sint2;
		return FrFull(cosi, Spectrum_Sqrt((cost2 + Spectrum_Sqrt(cost2 * cost2 + a * a)) / 2.f), eta, k);
	} else {
		const float3 a = 2.f * k * k * sint2;
		const float3 d2 = eta * eta + k * k;
		return FrFull(-cosi, Spectrum_Sqrt((cost2 + Spectrum_Sqrt(cost2 * cost2 + a * a)) / 2.f), eta / d2, -k / d2);
	}
}

float3 FresnelCauchy_Evaluate(const float eta, const float cosi) {
	// Compute indices of refraction for dielectric
	const bool entering = (cosi > 0.f);

	// Compute _sint_ using Snell's law
	const float eta2 = eta * eta;
	const float sint2 = (entering ? 1.f / eta2 : eta2) *
		fmax(0.f, 1.f - cosi * cosi);
	// Handle total internal reflection
	if (sint2 >= 1.f)
		return WHITE;
	else
		return FrDiel2(fabs(cosi), sqrt(fmax(0.f, 1.f - sint2)),
			entering ? eta : 1.f / eta);
}
#line 2 "materialdefs_funcs_archglass.cl"

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

#if defined(PARAM_HAS_VOLUMES)
float ExtractExteriorIors(__global HitPoint *hitPoint, const uint exteriorIorTexIndex
		TEXTURES_PARAM_DECL) {
	uint extIndex = NULL_INDEX;
	if (exteriorIorTexIndex != NULL_INDEX)
		extIndex = exteriorIorTexIndex;
	else {
		const uint hitPointExteriorIorTexIndex = hitPoint->exteriorIorTexIndex;
		if (hitPointExteriorIorTexIndex != NULL_INDEX)
			extIndex = hitPointExteriorIorTexIndex;
	}
	return (extIndex == NULL_INDEX) ? 1.f : Texture_GetFloatValue(extIndex, hitPoint
			TEXTURES_PARAM);
}

float ExtractInteriorIors(__global HitPoint *hitPoint, const uint interiorIorTexIndex
		TEXTURES_PARAM_DECL) {
	uint intIndex = NULL_INDEX;
	if (interiorIorTexIndex != NULL_INDEX)
		intIndex = interiorIorTexIndex;
	else {
		const uint hitPointInteriorIorTexIndex = hitPoint->interiorIorTexIndex;
		if (hitPointInteriorIorTexIndex != NULL_INDEX)
			intIndex = hitPointInteriorIorTexIndex;
	}
	return (intIndex == NULL_INDEX) ? 1.f : Texture_GetFloatValue(intIndex, hitPoint
			TEXTURES_PARAM);
}
#endif

//------------------------------------------------------------------------------
// ArchGlass material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_ARCHGLASS)

BSDFEvent ArchGlassMaterial_GetEventTypes() {
	return SPECULAR | REFLECT | TRANSMIT;
}

bool ArchGlassMaterial_IsDelta() {
	return true;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 ArchGlassMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	const float3 kt = Spectrum_Clamp(Texture_GetSpectrumValue(material->archglass.ktTexIndex, hitPoint
		TEXTURES_PARAM));
	const float3 kr = Spectrum_Clamp(Texture_GetSpectrumValue(material->archglass.krTexIndex, hitPoint
		TEXTURES_PARAM));

	const bool isKtBlack = Spectrum_IsBlack(kt);
	const bool isKrBlack = Spectrum_IsBlack(kr);
	if (isKtBlack && isKrBlack)
		return BLACK;

	const bool entering = (CosTheta(localFixedDir) > 0.f);

	const float nc = ExtractExteriorIors(hitPoint,
			material->archglass.exteriorIorTexIndex
			TEXTURES_PARAM);
	const float nt = ExtractInteriorIors(hitPoint,
			material->archglass.interiorIorTexIndex
			TEXTURES_PARAM);
	const float ntc = nt / nc;
	const float costheta = CosTheta(localFixedDir);

	// Decide to transmit or reflect
	const float threshold = isKrBlack ? 1.f : (isKtBlack ? 0.f : .5f);
	if (passThroughEvent < threshold) {
		// Transmit

		// Compute transmitted ray direction
		const float sini2 = SinTheta2(localFixedDir);
		const float eta = nc / nt;
		const float eta2 = eta * eta;
		const float sint2 = eta2 * sini2;

		// Handle total internal reflection for transmission
		if (sint2 >= 1.f)
			return BLACK;

		float3 result;
		//if (!hitPoint.fromLight) {
			if (entering)
				result = BLACK;
			else
				result = FresnelCauchy_Evaluate(ntc, -costheta);
		//} else {
		//	if (entering)
		//		result = FresnelCauchy_Evaluate(ntc, costheta);
		//	else
		//		result = BLACK;
		//}
		result *= 1.f + (1.f - result) * (1.f - result);
		result = 1.f - result;

		// The "2.f*" is there in place of "/threshold" (aka "/pdf")
		return 2.f * kt * result;
	} else
		return BLACK;
}
#endif

float3 ArchGlassMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 ktTexVal, const float3 krTexVal,
		const float nc, const float nt) {
	return BLACK;
}

float3 ArchGlassMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 localFixedDir, float3 *localSampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *absCosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 ktTexVal, const float3 krTexVal,
		const float nc, const float nt) {
	if (!(requestedEvent & SPECULAR))
		return BLACK;

	const float3 kt = Spectrum_Clamp(ktTexVal);
	const float3 kr = Spectrum_Clamp(krTexVal);

	const bool isKtBlack = Spectrum_IsBlack(kt);
	const bool isKrBlack = Spectrum_IsBlack(kr);
	if (isKtBlack && isKrBlack)
		return BLACK;

	const bool entering = (CosTheta(localFixedDir) > 0.f);
	const float ntc = nt / nc;
	const float eta = nc / nt;
	const float costheta = CosTheta(localFixedDir);

	// Decide to transmit or reflect
	float threshold;
	if ((requestedEvent & REFLECT) && !isKrBlack) {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = .5f;
		else
			threshold = 0.f;
	} else {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = 1.f;
		else
			return BLACK;
	}

	float3 result;
	if (passThroughEvent < threshold) {
		// Transmit

		// Compute transmitted ray direction
		const float sini2 = SinTheta2(localFixedDir);
		const float eta2 = eta * eta;
		const float sint2 = eta2 * sini2;

		// Handle total internal reflection for transmission
		if (sint2 >= 1.f)
			return BLACK;

		*localSampledDir = -localFixedDir;
		*absCosSampledDir = fabs(CosTheta(*localSampledDir));

		*event = SPECULAR | TRANSMIT;
		*pdfW = threshold;

		//if (!hitPoint.fromLight) {
			if (entering)
				result = BLACK;
			else
				result = FresnelCauchy_Evaluate(ntc, -costheta);
		//} else {
		//	if (entering)
		//		result = FresnelCauchy_Evaluate(ntc, costheta);
		//	else
		//		result = BLACK;
		//}
		result *= 1.f + (1.f - result) * (1.f - result);
		result = 1.f - result;

		result *= kt;
	} else {
		// Reflect
		if (costheta <= 0.f)
			return BLACK;

		*localSampledDir = (float3)(-localFixedDir.x, -localFixedDir.y, localFixedDir.z);
		*absCosSampledDir = fabs(CosTheta(*localSampledDir));

		*event = SPECULAR | REFLECT;
		*pdfW = 1.f - threshold;

		result = kr * FresnelCauchy_Evaluate(ntc, costheta);
	}

	return result / *pdfW;
}

#endif
#line 2 "materialdefs_funcs_carpaint.cl"

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

//------------------------------------------------------------------------------
// CarPaint material
//
// LuxRender carpaint material porting.
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_CARPAINT)

BSDFEvent CarPaintMaterial_GetEventTypes() {
	return GLOSSY | REFLECT;
}

bool CarPaintMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 CarPaintMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 CarPaintMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 kaVal, const float d, const float3 kdVal,
		const float3 ks1Val, const float m1, const float r1,
		const float3 ks2Val, const float m2, const float r2,
		const float3 ks3Val, const float m3, const float r3) {
	float3 H = normalize(lightDir + eyeDir);
	if (all(H == 0.f))
	{
		if (directPdfW)
			*directPdfW = 0.f;
		return BLACK;
	}
	if (H.z < 0.f)
		H = -H;

	float pdf = 0.f;
	int n = 1; // already counts the diffuse layer

	// Absorption
	const float cosi = fabs(lightDir.z);
	const float coso = fabs(eyeDir.z);
	const float3 alpha = Spectrum_Clamp(kaVal);
	const float3 absorption = CoatingAbsorption(cosi, coso, alpha, d);

	// Diffuse layer
	float3 result = absorption * Spectrum_Clamp(kdVal) * M_1_PI_F * fabs(lightDir.z);

	// 1st glossy layer
	const float3 ks1 = Spectrum_Clamp(ks1Val);
	if (Spectrum_Filter(ks1) > 0.f && m1 > 0.f)
	{
		const float rough1 = m1 * m1;
		result += (SchlickDistribution_D(rough1, H, 0.f) * SchlickDistribution_G(rough1, lightDir, eyeDir) / (4.f * coso)) * (ks1 * FresnelSchlick_Evaluate(r1, dot(eyeDir, H)));
		pdf += SchlickDistribution_Pdf(rough1, H, 0.f);
		++n;
	}
	const float3 ks2 = Spectrum_Clamp(ks2Val);
	if (Spectrum_Filter(ks2) > 0.f && m2 > 0.f)
	{
		const float rough2 = m2 * m2;
		result += (SchlickDistribution_D(rough2, H, 0.f) * SchlickDistribution_G(rough2, lightDir, eyeDir) / (4.f * coso)) * (ks2 * FresnelSchlick_Evaluate(r2, dot(eyeDir, H)));
		pdf += SchlickDistribution_Pdf(rough2, H, 0.f);
		++n;
	}
	const float3 ks3 = Spectrum_Clamp(ks3Val);
	if (Spectrum_Filter(ks3) > 0.f && m3 > 0.f)
	{
		const float rough3 = m3 * m3;
		result += (SchlickDistribution_D(rough3, H, 0.f) * SchlickDistribution_G(rough3, lightDir, eyeDir) / (4.f * coso)) * (ks3 * FresnelSchlick_Evaluate(r3, dot(eyeDir, H)));
		pdf += SchlickDistribution_Pdf(rough3, H, 0.f);
		++n;
	}

	// Front face: coating+base
	*event = GLOSSY | REFLECT;

	// Finish pdf computation
	pdf /= 4.f * fabs(dot(lightDir, H));
	if (directPdfW)
		*directPdfW = (pdf + fabs(lightDir.z) * M_1_PI_F) / n;

	return result;
}

float3 CarPaintMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 kaVal, const float d, const float3 kdVal,
		const float3 ks1Val, const float m1, const float r1,
		const float3 ks2Val, const float m2, const float r2,
		const float3 ks3Val, const float m3, const float r3) {
	if (!(requestedEvent & (GLOSSY | REFLECT)) ||
		(fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	// Test presence of components
	int n = 1; // already count the diffuse layer
	int sampled = 0; // sampled layer
	float3 result = BLACK;
	float pdf = 0.f;
	bool l1 = false, l2 = false, l3 = false;
	// 1st glossy layer
	const float3 ks1 = Spectrum_Clamp(ks1Val);
	if (Spectrum_Filter(ks1) > 0.f && m1 > 0.f)
	{
		l1 = true;
		++n;
	}
	// 2nd glossy layer
	const float3 ks2 = Spectrum_Clamp(ks2Val);
	if (Spectrum_Filter(ks2) > 0.f && m2 > 0.f)
	{
		l2 = true;
		++n;
	}
	// 3rd glossy layer
	const float3 ks3 = Spectrum_Clamp(ks3Val);
	if (Spectrum_Filter(ks3) > 0.f && m3 > 0.f)
	{
		l3 = true;
		++n;
	}

	float3 wh;
	float cosWH;
	if (passThroughEvent < 1.f / n) {
		// Sample diffuse layer
		*sampledDir = (signbit(fixedDir.z) ? -1.f : 1.f) * CosineSampleHemisphereWithPdf(u0, u1, &pdf);

		*cosSampledDir = fabs((*sampledDir).z);
		if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
			return BLACK;

		// Absorption
		const float cosi = fabs(fixedDir.z);
		const float coso = fabs((*sampledDir).z);
		const float3 alpha = Spectrum_Clamp(kaVal);
		const float3 absorption = CoatingAbsorption(cosi, coso, alpha, d);

		// Evaluate base BSDF
		result = absorption * Spectrum_Clamp(kdVal) * pdf;

		wh = normalize(*sampledDir + fixedDir);
		if (wh.z < 0.f)
			wh = -wh;
		cosWH = fabs(dot(fixedDir, wh));
	} else if (passThroughEvent < 2.f / n && l1) {
		// Sample 1st glossy layer
		sampled = 1;
		const float rough1 = m1 * m1;
		float d;
		SchlickDistribution_SampleH(rough1, 0.f, u0, u1, &wh, &d, &pdf);
		cosWH = dot(fixedDir, wh);
		*sampledDir = 2.f * cosWH * wh - fixedDir;
		*cosSampledDir = fabs((*sampledDir).z);
		cosWH = fabs(cosWH);

		if (((*sampledDir).z < DEFAULT_COS_EPSILON_STATIC) ||
			(fixedDir.z * (*sampledDir).z < 0.f))
			return BLACK;

		pdf /= 4.f * cosWH;
		if (pdf <= 0.f)
			return BLACK;

		result = FresnelSchlick_Evaluate(r1, cosWH);

		const float G = SchlickDistribution_G(rough1, fixedDir, *sampledDir);
		result *= d * G / (4.f * fabs(fixedDir.z));
	} else if ((passThroughEvent < 2.f / n  ||
		(!l1 && passThroughEvent < 3.f / n)) && l2) {
		// Sample 2nd glossy layer
		sampled = 2;
		const float rough2 = m2 * m2;
		float d;
		SchlickDistribution_SampleH(rough2, 0.f, u0, u1, &wh, &d, &pdf);
		cosWH = dot(fixedDir, wh);
		*sampledDir = 2.f * cosWH * wh - fixedDir;
		*cosSampledDir = fabs((*sampledDir).z);
		cosWH = fabs(cosWH);

		if (((*sampledDir).z < DEFAULT_COS_EPSILON_STATIC) ||
			(fixedDir.z * (*sampledDir).z < 0.f))
			return BLACK;

		pdf /= 4.f * cosWH;
		if (pdf <= 0.f)
			return BLACK;

		result = FresnelSchlick_Evaluate(r2, cosWH);

		const float G = SchlickDistribution_G(rough2, fixedDir, *sampledDir);
		result *= d * G / (4.f * fabs(fixedDir.z));
	} else if (l3) {
		// Sample 3rd glossy layer
		sampled = 3;
		const float rough3 = m3 * m3;
		float d;
		SchlickDistribution_SampleH(rough3, 0.f, u0, u1, &wh, &d, &pdf);
		cosWH = dot(fixedDir, wh);
		*sampledDir = 2.f * cosWH * wh - fixedDir;
		*cosSampledDir = fabs((*sampledDir).z);
		cosWH = fabs(cosWH);

		if (((*sampledDir).z < DEFAULT_COS_EPSILON_STATIC) ||
			(fixedDir.z * (*sampledDir).z < 0.f))
			return BLACK;

		pdf /= 4.f * cosWH;
		if (pdf <= 0.f)
			return BLACK;

		result = FresnelSchlick_Evaluate(r3, cosWH);

		const float G = SchlickDistribution_G(rough3, fixedDir, *sampledDir);
		result *= d * G / (4.f * fabs(fixedDir.z));
	} else {
		// Sampling issue
		return BLACK;
	}
	*event = GLOSSY | REFLECT;
	// Add other components
	// Diffuse
	if (sampled != 0) {
		// Absorption
		const float cosi = fabs(fixedDir.z);
		const float coso = fabs((*sampledDir).z);
		const float3 alpha = Spectrum_Clamp(kaVal);
		const float3 absorption = CoatingAbsorption(cosi, coso, alpha, d);

		const float pdf0 = fabs((*sampledDir).z) * M_1_PI_F;
		pdf += pdf0;
		result = absorption * Spectrum_Clamp(kdVal) * pdf0;
	}
	// 1st glossy
	if (l1 && sampled != 1) {
		const float rough1 = m1 * m1;
		const float d1 = SchlickDistribution_D(rough1, wh, 0.f);
		const float pdf1 = SchlickDistribution_Pdf(rough1, wh, 0.f) / (4.f * cosWH);
		if (pdf1 > 0.f) {
			result += (d1 *
				SchlickDistribution_G(rough1, fixedDir, *sampledDir) /
				(4.f * fabs(fixedDir.z))) *
				FresnelSchlick_Evaluate(r1, cosWH);
			pdf += pdf1;
		}
	}
	// 2nd glossy
	if (l2 && sampled != 2) {
		const float rough2 = m2 * m2;
		const float d2 = SchlickDistribution_D(rough2, wh, 0.f);
		const float pdf2 = SchlickDistribution_Pdf(rough2, wh, 0.f) / (4.f * cosWH);
		if (pdf2 > 0.f) {
			result += (d2 *
				SchlickDistribution_G(rough2, fixedDir, *sampledDir) /
				(4.f * fabs(fixedDir.z))) *
				FresnelSchlick_Evaluate(r2, cosWH);
			pdf += pdf2;
		}
	}
	// 3rd glossy
	if (l3 && sampled != 3) {
		const float rough3 = m3 * m3;
		const float d3 = SchlickDistribution_D(rough3, wh, 0.f);
		const float pdf3 = SchlickDistribution_Pdf(rough3, wh, 0.f) / (4.f * cosWH);
		if (pdf3 > 0.f) {
			result += (d3 *
				SchlickDistribution_G(rough3, fixedDir, *sampledDir) /
				(4.f * fabs(fixedDir.z))) *
				FresnelSchlick_Evaluate(r3, cosWH);
			pdf += pdf3;
		}
	}
	// Adjust pdf and result
	*pdfW = pdf / n;
	return result / *pdfW;
}

#endif
#line 2 "materialdefs_funcs_clearvol.cl"

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

//------------------------------------------------------------------------------
// ClearVol material
//
// ClearVol hasn't scattering so none of the below functions is really used.
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_CLEAR_VOL)

BSDFEvent ClearVolMaterial_GetEventTypes() {
	return DIFFUSE | REFLECT;
}

bool ClearVolMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 ClearVolMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 ClearVolMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW) {
	return BLACK;
}

float3 ClearVolMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent) {
	return BLACK;
}

#endif
#line 2 "materialdefs_funcs_cloth.cl"

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

//------------------------------------------------------------------------------
// Cloth material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_CLOTH)

BSDFEvent ClothMaterial_GetEventTypes() {
	return GLOSSY | REFLECT;
}

bool ClothMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 ClothMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

__constant WeaveConfig ClothWeaves[] = {
    // DenimWeave
    {
        3, 6,
        0.01f, 4.0f,
        0.0f, 0.5f,
        5.0f, 1.0f, 3.0f,
        0.0f, 0.0f, 0.0f, 0.0f,
        0.0f
    },
    // SilkShantungWeave
    {
        6, 8,
        0.02f, 1.5f,
        0.5f, 0.5f,
        8.0f, 16.0f, 0.0f,
        20.0f, 20.0f, 10.0f, 10.0f,
        500.0f
    },
    // SilkCharmeuseWeave
    {
        5, 10,
        0.02f, 7.3f,
        0.5f, 0.5f,
        9.0f, 1.0f, 3.0f,
        0.0f, 0.0f, 0.0f, 0.0f,
        0.0f
    },
    // CottonTwillWeave
    {
        4, 8,
        0.01f, 4.0f,
        0.0f, 0.5f,
        6.0f, 2.0f, 4.0f,
        0.0f, 0.0f, 0.0f, 0.0f,
        0.0f
    },
    // WoolGarbardineWeave
    {
        6, 9,
        0.01f, 4.0f,
        0.0f, 0.5f,
        12.0f, 6.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 0.0f,
        0.0f
    },
    // PolyesterWeave
    {
        2, 2,
        0.015f, 4.0f,
        0.5f, 0.5f,
        1.0f, 1.0f, 0.0f,
        8.0f, 8.0f, 6.0f, 6.0f,
        50.0f
    }
};

__constant Yarn ClothYarns[][14] = {
    // DenimYarn[8]
    {
        {-30, 12, 0, 1, 5, 0.1667f, 0.75f, WARP},
        {-30, 12, 0, 1, 5, 0.1667f, -0.25f, WARP},
        {-30, 12, 0, 1, 5, 0.5f, 1.0833f, WARP},
        {-30, 12, 0, 1, 5, 0.5f, 0.0833f, WARP},
        {-30, 12, 0, 1, 5, 0.8333f, 0.4167f, WARP},
        {-30, 38, 0, 1, 1, 0.1667f, 0.25f, WEFT},
        {-30, 38, 0, 1, 1, 0.5f, 0.5833f, WEFT},
        {-30, 38, 0, 1, 1, 0.8333f, 0.9167f, WEFT}
    },
    // SilkShantungYarn[5]
    {
        {0, 50, -0.5, 2, 4,  0.3333f, 0.25f, WARP},
        {0, 50, -0.5, 2, 4,  0.8333f, 0.75f, WARP},
        {0, 23, -0.3, 4, 4,  0.3333f, 0.75f, WEFT},
        {0, 23, -0.3, 4, 4, -0.1667f, 0.25f, WEFT},
        {0, 23, -0.3, 4, 4,  0.8333f, 0.25f, WEFT}
    },
    // SilkCharmeuseYarn[14]
    {
        {0, 40, 2, 1, 9, 0.1, 0.45, WARP},
        {0, 40, 2, 1, 9, 0.3, 1.05, WARP},
        {0, 40, 2, 1, 9, 0.3, 0.05, WARP},
        {0, 40, 2, 1, 9, 0.5, 0.65, WARP},
        {0, 40, 2, 1, 9, 0.5, -0.35, WARP},
        {0, 40, 2, 1, 9, 0.7, 1.25, WARP},
        {0, 40, 2, 1, 9, 0.7, 0.25, WARP},
        {0, 40, 2, 1, 9, 0.9, 0.85, WARP},
        {0, 40, 2, 1, 9, 0.9, -0.15, WARP},
        {0, 60, 0, 1, 1, 0.1, 0.95, WEFT},
        {0, 60, 0, 1, 1, 0.3, 0.55, WEFT},
        {0, 60, 0, 1, 1, 0.5, 0.15, WEFT},
        {0, 60, 0, 1, 1, 0.7, 0.75, WEFT},
        {0, 60, 0, 1, 1, 0.9, 0.35, WEFT}
    },
    // CottonTwillYarn[10]
    {
        {-30, 24, 0, 1, 6, 0.125,  0.375, WARP},
        {-30, 24, 0, 1, 6, 0.375,  1.125, WARP},
        {-30, 24, 0, 1, 6, 0.375,  0.125, WARP},
        {-30, 24, 0, 1, 6, 0.625,  0.875, WARP},
        {-30, 24, 0, 1, 6, 0.625, -0.125, WARP},
        {-30, 24, 0, 1, 6, 0.875,  0.625, WARP},
        {-30, 36, 0, 2, 1, 0.125,  0.875, WEFT},
        {-30, 36, 0, 2, 1, 0.375,  0.625, WEFT},
        {-30, 36, 0, 2, 1, 0.625,  0.375, WEFT},
        {-30, 36, 0, 2, 1, 0.875,  0.125, WEFT}
    },
    // WoolGarbardineYarn[7]
    {
        {30, 30, 0, 2, 6, 0.167, 0.667, WARP},
        {30, 30, 0, 2, 6, 0.500, 1.000, WARP},
        {30, 30, 0, 2, 6, 0.500, 0.000, WARP},
        {30, 30, 0, 2, 6, 0.833, 0.333, WARP},
        {30, 30, 0, 3, 2, 0.167, 0.167, WEFT},
        {30, 30, 0, 3, 2, 0.500, 0.500, WEFT},
        {30, 30, 0, 3, 2, 0.833, 0.833, WEFT}
    },
    // PolyesterYarn[4]
    {
        {0, 22, -0.7, 1, 1, 0.25, 0.25, WARP},
        {0, 22, -0.7, 1, 1, 0.75, 0.75, WARP},
        {0, 16, -0.7, 1, 1, 0.25, 0.75, WEFT},
        {0, 16, -0.7, 1, 1, 0.75, 0.25, WEFT}
    }
};

__constant int ClothPatterns[][6 * 9] = {
    // DenimPattern[3 * 6]
    {
        1, 3, 8,  1, 3, 5,  1, 7, 5,  1, 4, 5,  6, 4, 5,  2, 4, 5
    },
    // SilkShantungPattern[6 * 8]
    {
        3, 3, 3, 3, 2, 2,  3, 3, 3, 3, 2, 2,  3, 3, 3, 3, 2, 2,  3, 3, 3, 3, 2, 2,
        4, 1, 1, 5, 5, 5,  4, 1, 1, 5, 5, 5,  4, 1, 1, 5, 5, 5,  4, 1, 1, 5, 5, 5
    },
    // SilkCharmeusePattern[5 * 10]
    {
        10, 2, 4, 6, 8,   1, 2, 4, 6,  8,  1, 2, 4, 13, 8,  1, 2,  4, 7, 8,  1, 11, 4, 7, 8,
        1, 3, 4, 7, 8,   1, 3, 4, 7, 14,  1, 3, 4,  7, 9,  1, 3, 12, 7, 9,  1,  3, 5, 7, 9
    },
    // CottonTwillPattern[4 * 8]
    {
        7, 2, 4, 6,  7, 2, 4, 6,  1, 8, 4,  6,  1, 8, 4,  6,
        1, 3, 9, 6,  1, 3, 9, 6,  1, 3, 5, 10,  1, 3, 5, 10
    },
    // WoolGarbardinePattern[6 * 9]
    {
        1, 1, 2, 2, 7, 7,  1, 1, 2, 2, 7, 7,  1, 1, 2, 2, 7, 7,
        1, 1, 6, 6, 4, 4,  1, 1, 6, 6, 4, 4,  1, 1, 6, 6, 4, 4,
        5, 5, 3, 3, 4, 4,  5, 5, 3, 3, 4, 4,  5, 5, 3, 3, 4, 4
    },
    // PolyesterPattern[2 * 2]
    {
        3, 2, 1, 4
    }
};

ulong sampleTEA(uint v0, uint v1, uint rounds) {
	uint sum = 0;

	for (uint i = 0; i < rounds; ++i) {
		sum += 0x9e3779b9;
		v0 += ((v1 << 4) + 0xA341316C) ^ (v1 + sum) ^ ((v1 >> 5) + 0xC8013EA4);
		v1 += ((v0 << 4) + 0xAD90777D) ^ (v0 + sum) ^ ((v0 >> 5) + 0x7E95761E);
	}

	return ((ulong) v1 << 32) + v0;
}

float sampleTEAfloat(uint v0, uint v1, uint rounds) {
	/* Trick from MTGP: generate an uniformly distributed
	   single precision number in [1,2) and subtract 1. */
	union {
		uint u;
		float f;
	} x;
	x.u = ((sampleTEA(v0, v1, rounds) & 0xFFFFFFFF) >> 9) | 0x3f800000UL;
	return x.f - 1.0f;
}

// von Mises Distribution
float vonMises(float cos_x, float b) {
	// assumes a = 0, b > 0 is a concentration parameter.

	const float factor = exp(b * cos_x) * (.5f * M_1_PI_F);
	const float absB = fabs(b);
	if (absB <= 3.75f) {
		const float t0 = absB / 3.75f;
		const float t = t0 * t0;
		return factor / (1.0f + t * (3.5156229f + t * (3.0899424f +
			t * (1.2067492f + t * (0.2659732f + t * (0.0360768f +
			t * 0.0045813f))))));
	} else {
		const float t = 3.75f / absB;
		return factor * sqrt(absB) / (exp(absB) * (0.39894228f +
			t * (0.01328592f + t * (0.00225319f +
			t * (-0.00157565f + t * (0.00916281f +
			t * (-0.02057706f + t * (0.02635537f +
			t * (-0.01647633f + t * 0.00392377f)))))))));
	}
}

// Attenuation term
float seeliger(float cos_th1, float cos_th2, float sg_a, float sg_s) {
	const float al = sg_s / (sg_a + sg_s); // albedo
	const float c1 = fmax(0.f, cos_th1);
	const float c2 = fmax(0.f, cos_th2);
	if (c1 == 0.0f || c2 == 0.0f)
		return 0.0f;
	return al * (.5f * M_1_PI_F) * .5f * c1 * c2 / (c1 + c2);
}

void GetYarnUV(__constant WeaveConfig *Weave, __constant Yarn *yarn,
        const float Repeat_U, const float Repeat_V,
        const float3 center, const float3 xy, float2 *uv, float *umaxMod) {
	*umaxMod = Radians(yarn->umax);
	if (Weave->period > 0.f) {
		/* Number of TEA iterations (the more, the better the
		   quality of the pseudorandom floats) */
		const int teaIterations = 8;

		// Correlated (Perlin) noise.
		// generate 1 seed per yarn segment
		const float random1 = Noise((center.x *
			(Weave->tileHeight * Repeat_V +
			sampleTEAfloat(center.x, 2.f * center.y,
			teaIterations)) + center.y) / Weave->period, 0.0, 0.0);
		const float random2 = Noise((center.y *
			(Weave->tileWidth * Repeat_U +
			sampleTEAfloat(center.x, 2.f * center.y + 1.f,
			teaIterations)) + center.x) / Weave->period, 0.0, 0.0);

		if (yarn->yarn_type == WARP)
	  		*umaxMod += random1 * Radians(Weave->dWarpUmaxOverDWarp) +
				random2 * Radians(Weave->dWarpUmaxOverDWeft);
		else
			*umaxMod += random1 * Radians(Weave->dWeftUmaxOverDWarp) +
				random2 * Radians(Weave->dWeftUmaxOverDWeft);
	}


	// Compute u and v.
	// See Chapter 6.
	// Rotate pi/2 radians around z axis
	if (yarn->yarn_type == WARP) {
		(*uv).s0 = xy.y * 2.f * *umaxMod / yarn->length;
		(*uv).s1 = xy.x * M_PI_F / yarn->width;
	} else {
		(*uv).s0 = xy.x * 2.f * *umaxMod / yarn->length;
		(*uv).s1 = -xy.y * M_PI_F / yarn->width;
	}
}

__constant Yarn *GetYarn(const ClothPreset Preset, __constant WeaveConfig *Weave,
        const float Repeat_U, const float Repeat_V,
        const float u_i, const float v_i,
        float2 *uv, float *umax, float *scale) {
	const float u = u_i * Repeat_U;
	const int bu = Floor2Int(u);
	const float ou = u - bu;
	const float v = v_i * Repeat_V;
	const int bv = Floor2Int(v);
	const float ov = v - bv;
	const uint lx = min(Weave->tileWidth - 1, Floor2UInt(ou * Weave->tileWidth));
	const uint ly = Weave->tileHeight - 1 -
		min(Weave->tileHeight - 1, Floor2UInt(ov * Weave->tileHeight));

	const int yarnID = ClothPatterns[Preset][lx + Weave->tileWidth * ly] - 1;
	__constant Yarn *yarn = &ClothYarns[Preset][yarnID];

	const float3 center = (float3)((bu + yarn->centerU) * Weave->tileWidth,
		(bv + yarn->centerV) * Weave->tileHeight, 0.f);
	const float3 xy = (float3)((ou - yarn->centerU) * Weave->tileWidth,
		(ov - yarn->centerV) * Weave->tileHeight, 0.f);

	GetYarnUV(Weave, yarn, Repeat_U, Repeat_V, center, xy, uv, umax);

	/* Number of TEA iterations (the more, the better the
	   quality of the pseudorandom floats) */
	const int teaIterations = 8;

	// Compute random variation and scale specular component.
	if (Weave->fineness > 0.0f) {
		// Initialize random number generator based on texture location.
		// Generate fineness^2 seeds per 1 unit of texture.
		const uint index1 = (uint) ((center.x + xy.x) * Weave->fineness);
		const uint index2 = (uint) ((center.y + xy.y) * Weave->fineness);

		const float xi = sampleTEAfloat(index1, index2, teaIterations);

		*scale *= fmin(-log(xi), 10.0f);
	}

	return yarn;
}

float RadiusOfCurvature(__constant Yarn *yarn, float u, float umaxMod) {
	// rhat determines whether the spine is a segment
	// of an ellipse, a parabole, or a hyperbola.
	// See Section 5.3.
	const float rhat = 1.0f + yarn->kappa * (1.0f + 1.0f / tan(umaxMod));
	const float a = 0.5f * yarn->width;

	if (rhat == 1.0f) { // circle; see Subsection 5.3.1.
		return 0.5f * yarn->length / sin(umaxMod) - a;
	} else if (rhat > 0.0f) { // ellipsis
		const float tmax = atan(rhat * tan(umaxMod));
		const float bhat = (0.5f * yarn->length - a * sin(umaxMod)) / sin(tmax);
		const float ahat = bhat / rhat;
		const float t = atan(rhat * tan(u));
		return pow(bhat * bhat * cos(t) * cos(t) +
			ahat * ahat * sin(t) * sin(t), 1.5f) / (ahat * bhat);
	} else if (rhat < 0.0f) { // hyperbola; see Subsection 5.3.3.
		const float tmax = -atanh(rhat * tan(umaxMod));
		const float bhat = (0.5f * yarn->length - a * sin(umaxMod)) / sinh(tmax);
		const float ahat = bhat / rhat;
		const float t = -atanh(rhat * tan(u));
		return -pow(bhat * bhat * cosh(t) * cosh(t) +
			ahat * ahat * sinh(t) * sinh(t), 1.5f) / (ahat * bhat);
	} else { // rhat == 0  // parabola; see Subsection 5.3.2.
		const float tmax = tan(umaxMod);
		const float ahat = (0.5f * yarn->length - a * sin(umaxMod)) / (2.f * tmax);
		const float t = tan(u);
		return 2.f * ahat * pow(1.f + t * t, 1.5f);
	}
}

float EvalFilamentIntegrand(__constant WeaveConfig *Weave, __constant Yarn *yarn, const float3 om_i,
        const float3 om_r, float u, float v, float umaxMod) {
	// 0 <= ss < 1.0
	if (Weave->ss < 0.0f || Weave->ss >= 1.0f)
		return 0.0f;

	// w * sin(umax) < l
	if (yarn->width * sin(umaxMod) >= yarn->length)
		return 0.0f;

	// -1 < kappa < inf
	if (yarn->kappa < -1.0f)
		return 0.0f;

	// h is the half vector
	const float3 h = normalize(om_r + om_i);

	// u_of_v is location of specular reflection.
	const float u_of_v = atan2(h.y, h.z);

	// Check if u_of_v within the range of valid u values
	if (fabs(u_of_v) >= umaxMod)
		return 0.f;

	// Highlight has constant width delta_u
	const float delta_u = umaxMod * Weave->hWidth;

	// Check if |u(v) - u| < delta_u.
	if (fabs(u_of_v - u) >= delta_u)
		return 0.f;


	// n is normal to the yarn surface
	// t is tangent of the fibers.
	const float3 n = normalize((float3)(sin(v), sin(u_of_v) * cos(v),
		cos(u_of_v) * cos(v)));
	const float3 t = normalize((float3)(0.0f, cos(u_of_v), -sin(u_of_v)));

	// R is radius of curvature.
	const float R = RadiusOfCurvature(yarn, fmin(fabs(u_of_v),
		(1.f - Weave->ss) * umaxMod), (1.f - Weave->ss) * umaxMod);

	// G is geometry factor.
	const float a = 0.5f * yarn->width;
	const float3 om_i_plus_om_r = om_i + om_r;
    const float3 t_cross_h = cross(t, h);
	const float Gu = a * (R + a * cos(v)) /
		(length(om_i_plus_om_r) * fabs(t_cross_h.x));


	// fc is phase function
	const float fc = Weave->alpha + vonMises(-dot(om_i, om_r), Weave->beta);

	// attenuation function without smoothing.
	float As = seeliger(dot(n, om_i), dot(n, om_r), 0, 1);
	// As is attenuation function with smoothing.
	if (Weave->ss > 0.0f)
		As *= SmoothStep(0.f, 1.f, (umaxMod - fabs(u_of_v)) /
			(Weave->ss * umaxMod));

	// fs is scattering function.
	const float fs = Gu * fc * As;

	// Domain transform.
	return fs * M_PI_F / Weave->hWidth;
}

float EvalStapleIntegrand(__constant WeaveConfig *Weave, __constant Yarn *yarn,
        const float3 om_i, const float3 om_r, float u, float v, float umaxMod) {
	// w * sin(umax) < l
	if (yarn->width * sin(umaxMod) >= yarn->length)
		return 0.0f;

	// -1 < kappa < inf
	if (yarn->kappa < -1.0f)
		return 0.0f;

	// h is the half vector
	const float3 h = normalize(om_i + om_r);

	// v_of_u is location of specular reflection.
	const float D = (h.y * cos(u) - h.z * sin(u)) /
		(sqrt(h.x * h.x + pow(h.y * sin(u) + h.z * cos(u),
		2.0f)) * tan(Radians(yarn->psi)));
	if (!(fabs(D) < 1.f))
		return 0.f;
	const float v_of_u = atan2(-h.y * sin(u) - h.z * cos(u), h.x) +
		acos(D);

	// Highlight has constant width delta_x on screen.
	const float delta_v = .5f * M_PI_F * Weave->hWidth;

	// Check if |x(v(u)) - x(v)| < delta_x/2.
	if (fabs(v_of_u - v) >= delta_v)
		return 0.f;

	// n is normal to the yarn surface.
	const float3 n = normalize((float3)(sin(v_of_u), sin(u) * cos(v_of_u),
		cos(u) * cos(v_of_u)));

	// R is radius of curvature.
	const float R = RadiusOfCurvature(yarn, fabs(u), umaxMod);

	// G is geometry factor.
	const float a = 0.5f * yarn->width;
	const float3 om_i_plus_om_r = om_i + om_r;
	const float Gv = a * (R + a * cos(v_of_u)) /
		(length(om_i_plus_om_r) * dot(n, h) * fabs(sin(Radians(yarn->psi))));

	// fc is phase function.
	const float fc = Weave->alpha + vonMises(-dot(om_i, om_r), Weave->beta);

	// A is attenuation function without smoothing.
	const float A = seeliger(dot(n, om_i), dot(n, om_r), 0, 1);

	// fs is scattering function.
	const float fs = Gv * fc * A;

	// Domain transform.
	return fs * 2.0f * umaxMod / Weave->hWidth;
}

float EvalIntegrand(__constant WeaveConfig *Weave, __constant Yarn *yarn,
        const float2 uv, float umaxMod, float3 *om_i, float3 *om_r) {
	if (yarn->yarn_type == WARP) {
		if (yarn->psi != 0.0f)
			return EvalStapleIntegrand(Weave, yarn, *om_i, *om_r, uv.s0, uv.s1,
				umaxMod) * (Weave->warpArea + Weave->weftArea) /
				Weave->warpArea;
		else
			return EvalFilamentIntegrand(Weave, yarn, *om_i, *om_r, uv.s0, uv.s1,
				umaxMod) * (Weave->warpArea + Weave->weftArea) /
				Weave->warpArea;
	} else {
		// Rotate pi/2 radians around z axis
        //swap((*om_i).x, (*om_i).y);
        float tmp = (*om_i).x;
        (*om_i).x = (*om_i).y;
        (*om_i).y = tmp;
		(*om_i).x = -(*om_i).x;

		//swap((*om_r).x, (*om_r).y);
        tmp = (*om_r).x;
        (*om_r).x = (*om_r).y;
        (*om_r).y = tmp;
		(*om_r).x = -(*om_r).x;

		if (yarn->psi != 0.0f)
			return EvalStapleIntegrand(Weave, yarn, *om_i, *om_r, uv.s0, uv.s1,
				umaxMod) * (Weave->warpArea + Weave->weftArea) /
				Weave->weftArea;
		else
			return EvalFilamentIntegrand(Weave, yarn, *om_i, *om_r, uv.s0, uv.s1,
				umaxMod) * (Weave->warpArea + Weave->weftArea) /
				Weave->weftArea;
	}
}

float EvalSpecular(__constant WeaveConfig *Weave, __constant Yarn *yarn, const float2 uv,
        float umax, const float3 wo, const float3 wi) {
	// Get incident and exitant directions.
	float3 om_i = wi;
	if (om_i.z < 0.f)
		om_i = -om_i;
	float3 om_r = wo;
	if (om_r.z < 0.f)
		om_r = -om_r;

	// Compute specular contribution.
	return EvalIntegrand(Weave, yarn, uv, umax, &om_i, &om_r);
}

float3 ClothMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 localLightDir, const float3 localEyeDir,
		BSDFEvent *event, float *directPdfW,
		const ClothPreset Preset, const float Repeat_U, const float Repeat_V,
		const float s, const float3 Warp_Ks, const float3 Weft_Ks,
		const float3 Warp_Kd, const float3 Weft_Kd) {
    *directPdfW = fabs(localLightDir.z * M_1_PI_F);

    *event = GLOSSY | REFLECT;

    __constant WeaveConfig *Weave = &ClothWeaves[Preset];

	float2 uv;
	float umax, scale = s;
	__constant Yarn *yarn = GetYarn(Preset, Weave, Repeat_U, Repeat_V,
            hitPoint->uv.u, hitPoint->uv.v, &uv, &umax, &scale);

    scale = scale * EvalSpecular(Weave, yarn, uv, umax, localLightDir, localEyeDir);

	const float3 ks = (yarn->yarn_type == WARP) ? Warp_Ks : Weft_Ks;
	const float3 kd = (yarn->yarn_type == WARP) ? Warp_Kd : Weft_Kd;

    const float3 ksVal = Spectrum_Clamp(ks);
    const float3 kdVal = Spectrum_Clamp(kd);

	return (kdVal + ksVal * scale) * M_1_PI_F * fabs(localLightDir.z);
}

float3 ClothMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 localFixedDir, float3 *localSampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *absCosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const ClothPreset Preset, const float Repeat_U, const float Repeat_V,
		const float s, const float3 Warp_Ks, const float3 Weft_Ks,
		const float3 Warp_Kd, const float3 Weft_Kd) {
	if (!(requestedEvent & (GLOSSY | REFLECT)) ||
			(fabs(localFixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	*localSampledDir = (signbit(localFixedDir.z) ? -1.f : 1.f) * CosineSampleHemisphereWithPdf(u0, u1, pdfW);

	*absCosSampledDir = fabs((*localSampledDir).z);
	if (*absCosSampledDir < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	*event = GLOSSY | REFLECT;

    __constant WeaveConfig *Weave = &ClothWeaves[Preset];

	float2 uv;
	float umax, scale = s;
	__constant Yarn *yarn = GetYarn(Preset, Weave, Repeat_U, Repeat_V,
            hitPoint->uv.u, hitPoint->uv.v, &uv, &umax, &scale);

//	if (!hitPoint.fromLight)
	    scale = scale * EvalSpecular(Weave, yarn, uv, umax, localFixedDir, *localSampledDir);
//	else
//	    scale = scale * EvalSpecular(Weave, yarn, uv, umax, *localSampledDir, localFixedDir);

    const float3 ks = (yarn->yarn_type == WARP) ? Warp_Ks : Weft_Ks;
	const float3 kd = (yarn->yarn_type == WARP) ? Warp_Kd : Weft_Kd;

    const float3 ksVal = Spectrum_Clamp(ks);
    const float3 kdVal = Spectrum_Clamp(kd);

	return kdVal + ksVal * scale;
}

#endif
#line 2 "materialdefs_funcs_glass.cl"

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

//------------------------------------------------------------------------------
// Glass material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_GLASS)

BSDFEvent GlassMaterial_GetEventTypes() {
	return SPECULAR | REFLECT | TRANSMIT;
}

bool GlassMaterial_IsDelta() {
	return true;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 GlassMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 GlassMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 ktTexVal, const float3 krTexVal,
		const float nc, const float nt) {
	return BLACK;
}

float3 GlassMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 localFixedDir, float3 *localSampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *absCosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 ktTexVal, const float3 krTexVal,
		const float nc, const float nt) {
	if (!(requestedEvent & SPECULAR))
		return BLACK;

	const float3 kt = Spectrum_Clamp(ktTexVal);
	const float3 kr = Spectrum_Clamp(krTexVal);

	const bool isKtBlack = Spectrum_IsBlack(kt);
	const bool isKrBlack = Spectrum_IsBlack(kr);
	if (isKtBlack && isKrBlack)
		return BLACK;

	const bool entering = (CosTheta(localFixedDir) > 0.f);
	const float ntc = nt / nc;
	const float costheta = CosTheta(localFixedDir);

	// Decide to transmit or reflect
	float threshold;
	if ((requestedEvent & REFLECT) && !isKrBlack) {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = .5f;
		else
			threshold = 0.f;
	} else {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = 1.f;
		else
			return BLACK;
	}

	float3 result;
	if (passThroughEvent < threshold) {
		// Transmit

		// Compute transmitted ray direction
		const float sini2 = SinTheta2(localFixedDir);
		const float eta = entering ? (nc / nt) : ntc;
		const float eta2 = eta * eta;
		const float sint2 = eta2 * sini2;

		// Handle total internal reflection for transmission
		if (sint2 >= 1.f)
			return BLACK;

		const float cost = sqrt(fmax(0.f, 1.f - sint2)) * (entering ? -1.f : 1.f);
		*localSampledDir = (float3)(-eta * localFixedDir.x, -eta * localFixedDir.y, cost);
		*absCosSampledDir = fabs(CosTheta(*localSampledDir));

		*event = SPECULAR | TRANSMIT;
		*pdfW = threshold;

		//if (!hitPoint.fromLight)
			result = (1.f - FresnelCauchy_Evaluate(ntc, cost)) * eta2;
		//else
		//	result = (1.f - FresnelCauchy_Evaluate(ntc, costheta));

		result *= kt;
	} else {
		// Reflect
		*localSampledDir = (float3)(-localFixedDir.x, -localFixedDir.y, localFixedDir.z);
		*absCosSampledDir = fabs(CosTheta(*localSampledDir));

		*event = SPECULAR | REFLECT;
		*pdfW = 1.f - threshold;

		result = kr * FresnelCauchy_Evaluate(ntc, costheta);
	}

	return result / *pdfW;
}

#endif
#line 2 "materialdefs_funcs_glossy2.cl"

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

//------------------------------------------------------------------------------
// Glossy2 material
//
// LuxRender Glossy2 material porting.
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_GLOSSY2)

BSDFEvent Glossy2Material_GetEventTypes() {
	return GLOSSY | REFLECT;
}

bool Glossy2Material_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 Glossy2Material_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 Glossy2Material_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
#if defined(PARAM_ENABLE_MAT_GLOSSY2_INDEX)
		const float i,
#endif
		const float nuVal,
#if defined(PARAM_ENABLE_MAT_GLOSSY2_ANISOTROPIC)
		const float nvVal,
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSY2_ABSORPTION)
		const float3 kaVal,
		const float d,
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSY2_MULTIBOUNCE)
		const int multibounceVal,
#endif
		const float3 kdVal, const float3 ksVal) {
	const float3 fixedDir = eyeDir;
	const float3 sampledDir = lightDir;

	const float3 baseF = Spectrum_Clamp(kdVal) * M_1_PI_F * fabs(lightDir.z);
	if (eyeDir.z <= 0.f) {
		// Back face: no coating

		if (directPdfW)
			*directPdfW = fabs(sampledDir.z * M_1_PI_F);

		*event = DIFFUSE | REFLECT;
		return baseF;
	}

	// Front face: coating+base
	*event = GLOSSY | REFLECT;

	float3 ks = ksVal;
#if defined(PARAM_ENABLE_MAT_GLOSSY2_INDEX)
	if (i > 0.f) {
		const float ti = (i - 1.f) / (i + 1.f);
		ks *= ti * ti;
	}
#endif
	ks = Spectrum_Clamp(ks);

	const float u = clamp(nuVal, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_GLOSSY2_ANISOTROPIC)
	const float v = clamp(nvVal, 0.f, 1.f);
	const float u2 = u * u;
	const float v2 = v * v;
	const float anisotropy = (u2 < v2) ? (1.f - u2 / v2) : u2 > 0.f ? (v2 / u2 - 1.f) : 0.f;
	const float roughness = u * v;
#else
	const float anisotropy = 0.f;
	const float roughness = u * u;
#endif

	if (directPdfW) {
		const float wCoating = SchlickBSDF_CoatingWeight(ks, fixedDir);
		const float wBase = 1.f - wCoating;

		*directPdfW = wBase * fabs(sampledDir.z * M_1_PI_F) +
			wCoating * SchlickBSDF_CoatingPdf(roughness, anisotropy, fixedDir, sampledDir);
	}

#if defined(PARAM_ENABLE_MAT_GLOSSY2_ABSORPTION)
	// Absorption
	const float cosi = fabs(sampledDir.z);
	const float coso = fabs(fixedDir.z);

	const float3 alpha = Spectrum_Clamp(kaVal);
	const float3 absorption = CoatingAbsorption(cosi, coso, alpha, d);
#else
	const float3 absorption = WHITE;
#endif

	// Coating fresnel factor
	const float3 H = normalize(fixedDir + sampledDir);
	const float3 S = FresnelSchlick_Evaluate(ks, fabs(dot(sampledDir, H)));

#if defined(PARAM_ENABLE_MAT_GLOSSY2_MULTIBOUNCE)
	const int multibounce = multibounceVal;
#else
	const int multibounce = 0;
#endif
	const float3 coatingF = SchlickBSDF_CoatingF(ks, roughness, anisotropy, multibounce,
			fixedDir, sampledDir);

	// Blend in base layer Schlick style
	// assumes coating bxdf takes fresnel factor S into account

	return coatingF + absorption * (WHITE - S) * baseF;
}

float3 Glossy2Material_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
#if defined(PARAM_ENABLE_MAT_GLOSSY2_INDEX)
		const float i,
#endif
		const float nuVal,
#if defined(PARAM_ENABLE_MAT_GLOSSY2_ANISOTROPIC)
		const float nvVal,
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSY2_ABSORPTION)
		const float3 kaVal,
		const float d,
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSY2_MULTIBOUNCE)
		const int multibounceVal,
#endif
		const float3 kdVal, const float3 ksVal) {
	if ((!(requestedEvent & (GLOSSY | REFLECT)) && fixedDir.z > 0.f) ||
		(!(requestedEvent & (DIFFUSE | REFLECT)) && fixedDir.z <= 0.f) ||
		(fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	if (fixedDir.z <= 0.f) {
		// Back Face
		*sampledDir = -1.f * CosineSampleHemisphereWithPdf(u0, u1, pdfW);
		*cosSampledDir = fabs((*sampledDir).z);
		if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
			return BLACK;
		*event = DIFFUSE | REFLECT;
		return Spectrum_Clamp(kdVal);
	}

	float3 ks = ksVal;
#if defined(PARAM_ENABLE_MAT_GLOSSY2_INDEX)
	if (i > 0.f) {
		const float ti = (i - 1.f) / (i + 1.f);
		ks *= ti * ti;
	}
#endif
	ks = Spectrum_Clamp(ks);

	const float u = clamp(nuVal, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_GLOSSY2_ANISOTROPIC)
	const float v = clamp(nvVal, 0.f, 1.f);
	const float u2 = u * u;
	const float v2 = v * v;
	const float anisotropy = (u2 < v2) ? (1.f - u2 / v2) : u2 > 0.f ? (v2 / u2 - 1.f) : 0.f;
	const float roughness = u * v;
#else
	const float anisotropy = 0.f;
	const float roughness = u * u;
#endif

	// Coating is used only on the front face
	const float wCoating = SchlickBSDF_CoatingWeight(ks, fixedDir);
	const float wBase = 1.f - wCoating;

	const float3 baseF = Spectrum_Clamp(kdVal) * M_1_PI_F;

#if defined(PARAM_ENABLE_MAT_GLOSSY2_MULTIBOUNCE)
	const int multibounce = multibounceVal;
#else
	const int multibounce = 0;
#endif

	float basePdf, coatingPdf;
	float3 coatingF;
	if (passThroughEvent < wBase) {
		// Sample base BSDF (Matte BSDF)
		*sampledDir = (signbit(fixedDir.z) ? -1.f : 1.f) * CosineSampleHemisphereWithPdf(u0, u1, &basePdf);

		*cosSampledDir = fabs((*sampledDir).z);
		if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
			return BLACK;

		// Evaluate coating BSDF (Schlick BSDF)
		coatingF = SchlickBSDF_CoatingF(ks, roughness, anisotropy, multibounce,
				fixedDir, *sampledDir);
		coatingPdf = SchlickBSDF_CoatingPdf(roughness, anisotropy, fixedDir, *sampledDir);

		*event = GLOSSY | REFLECT;
	} else {
		// Sample coating BSDF (Schlick BSDF)
		coatingF = SchlickBSDF_CoatingSampleF(ks, roughness, anisotropy,
				multibounce, fixedDir, sampledDir, u0, u1, &coatingPdf);
		if (Spectrum_IsBlack(coatingF))
			return BLACK;

		*cosSampledDir = fabs((*sampledDir).z);
		if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
			return BLACK;

		coatingF *= coatingPdf;

		// Evaluate base BSDF (Matte BSDF)
		basePdf = *cosSampledDir * M_1_PI_F;

		*event = GLOSSY | REFLECT;
	}

	*pdfW = coatingPdf * wCoating + basePdf * wBase;

#if defined(PARAM_ENABLE_MAT_GLOSSY2_ABSORPTION)
	// Absorption
	const float cosi = fabs((*sampledDir).z);
	const float coso = fabs(fixedDir.z);

	const float3 alpha = Spectrum_Clamp(kaVal);
	const float3 absorption = CoatingAbsorption(cosi, coso, alpha, d);
#else
	const float3 absorption = WHITE;
#endif

	// Coating fresnel factor
	const float3 H = normalize(fixedDir + *sampledDir);
	const float3 S = FresnelSchlick_Evaluate(ks, fabs(dot(*sampledDir, H)));

	// Blend in base layer Schlick style
	// coatingF already takes fresnel factor S into account

	return (coatingF + absorption * (WHITE - S) * baseF * *cosSampledDir) / *pdfW;
}

#endif
#line 2 "materialdefs_funcs_heterogenousvol.cl"

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

#if defined(PARAM_HAS_VOLUMES)
float3 SchlickScatter_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 localEyeDir, const float3 localLightDir,
		BSDFEvent *event, float *directPdfW,
		const float3 sigmaS, const float3 sigmaA, const float3 g) {
	float3 r = sigmaS;
	if (r.x > 0.f)
		r.x /= r.x + sigmaA.x;
	else
		r.x = 1.f;
	if (r.y > 0.f)
		r.y /= r.y + sigmaA.y;
	else
		r.y = 1.f;
	if (r.z > 0.f)
		r.z /= r.z + sigmaA.z;
	else
		r.z = 1.f;

	const float3 gValue = clamp(g, -1.f, 1.f);
	const float3 k = gValue * (1.55f - .55f * gValue * gValue);

	*event = DIFFUSE | REFLECT;

	const float dotEyeLight = dot(localEyeDir, localLightDir);
	const float kFilter = Spectrum_Filter(k);
	// 1+k*cos instead of 1-k*cos because localEyeDir is reversed compared to the
	// standard phase function definition
	const float compcostFilter = 1.f + kFilter * dotEyeLight;
	const float pdf = (1.f - kFilter * kFilter) / (compcostFilter * compcostFilter * (4.f * M_PI_F));

	if (directPdfW)
		*directPdfW = pdf;

	// 1+k*cos instead of 1-k*cos because localEyeDir is reversed compared to the
	// standard phase function definition
	const float3 compcostValue = 1.f + k * dotEyeLight;

	return r * (1.f - k * k) / (compcostValue * compcostValue * (4.f * M_PI_F));
}

float3 SchlickScatter_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 sigmaS, const float3 sigmaA, const float3 g) {
	if (!(requestedEvent & (DIFFUSE | REFLECT)))
		return BLACK;

	const float3 gValue = clamp(g, -1.f, 1.f);
	const float3 k = gValue * (1.55f - .55f * gValue * gValue);
	const float gFilter = Spectrum_Filter(k);

	// Add a - because localEyeDir is reversed compared to the standard phase
	// function definition
	const float cost = -(2.f * u0 + gFilter - 1.f) / (2.f * gFilter * u0 - gFilter + 1.f);

	float3 x, y;
	CoordinateSystem(fixedDir, &x, &y);
	*sampledDir = SphericalDirectionWithFrame(sqrt(fmax(0.f, 1.f - cost * cost)), cost,
			2.f * M_PI_F * u1, x, y, fixedDir);

	// The - becomes a + because cost has been reversed above
	const float compcost = 1.f + gFilter * cost;
	*pdfW = (1.f - gFilter * gFilter) / (compcost * compcost * (4.f * M_PI_F));
	if (*pdfW <= 0.f)
		return BLACK;

	*cosSampledDir = fabs((*sampledDir).z);
	*event = DIFFUSE | REFLECT;

	float3 r = sigmaS;
	if (r.x > 0.f)
		r.x /= r.x + sigmaA.x;
	else
		r.x = 1.f;
	if (r.y > 0.f)
		r.y /= r.y + sigmaA.y;
	else
		r.y = 1.f;
	if (r.z > 0.f)
		r.z /= r.z + sigmaA.z;
	else
		r.z = 1.f;

	return r;
}
#endif

//------------------------------------------------------------------------------
// HeterogeneousVol material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_HETEROGENEOUS_VOL)

BSDFEvent HeterogeneousVolMaterial_GetEventTypes() {
	return DIFFUSE | REFLECT;
}

bool HeterogeneousVolMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 HeterogeneousVolMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 HeterogeneousVolMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 sigmaSTexVal, const float3 sigmaATexVal, const float3 gTexVal) {
	return SchlickScatter_ConstEvaluate(
			hitPoint, eyeDir, lightDir,
			event, directPdfW,
			clamp(sigmaSTexVal, 0.f, INFINITY), clamp(sigmaATexVal, 0.f, INFINITY), gTexVal);
}

float3 HeterogeneousVolMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 sigmaSTexVal, const float3 sigmaATexVal, const float3 gTexVal) {
	return SchlickScatter_ConstSample(
			hitPoint, fixedDir, sampledDir,
			u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
			passThroughEvent,
#endif
			pdfW, cosSampledDir, event,
			requestedEvent,
			clamp(sigmaSTexVal, 0.f, INFINITY), clamp(sigmaATexVal, 0.f, INFINITY), gTexVal);
}

#endif
#line 2 "materialdefs_funcs_homogenousvol.cl"

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

//------------------------------------------------------------------------------
// HomogeneousVol material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_HOMOGENEOUS_VOL)

BSDFEvent HomogeneousVolMaterial_GetEventTypes() {
	return DIFFUSE | REFLECT;
}

bool HomogeneousVolMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 HomogeneousVolMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 HomogeneousVolMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 sigmaSTexVal, const float3 sigmaATexVal, const float3 gTexVal) {
	return SchlickScatter_ConstEvaluate(
			hitPoint, eyeDir, lightDir,
			event, directPdfW,
			clamp(sigmaSTexVal, 0.f, INFINITY), clamp(sigmaATexVal, 0.f, INFINITY), gTexVal);
}

float3 HomogeneousVolMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 sigmaSTexVal, const float3 sigmaATexVal, const float3 gTexVal) {
	return SchlickScatter_ConstSample(
			hitPoint, fixedDir, sampledDir,
			u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
			passThroughEvent,
#endif
			pdfW, cosSampledDir, event,
			requestedEvent,
			clamp(sigmaSTexVal, 0.f, INFINITY), clamp(sigmaATexVal, 0.f, INFINITY), gTexVal);
}

#endif
#line 2 "materialdefs_funcs_matte.cl"

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

//------------------------------------------------------------------------------
// Matte material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_MATTE)

BSDFEvent MatteMaterial_GetEventTypes() {
	return DIFFUSE | REFLECT;
}

bool MatteMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 MatteMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 MatteMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 kdVal) {
	if (directPdfW)
		*directPdfW = fabs(lightDir.z * M_1_PI_F);

	*event = DIFFUSE | REFLECT;

	return Spectrum_Clamp(kdVal) * fabs(lightDir.z * M_1_PI_F);
}

float3 MatteMaterial_ConstSample(__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 kdVal) {
	if (!(requestedEvent & (DIFFUSE | REFLECT)) ||
			(fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	*sampledDir = (signbit(fixedDir.z) ? -1.f : 1.f) * CosineSampleHemisphereWithPdf(u0, u1, pdfW);

	*cosSampledDir = fabs((*sampledDir).z);
	if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	*event = DIFFUSE | REFLECT;

	return Spectrum_Clamp(kdVal);
}

#endif

//------------------------------------------------------------------------------
// Rough matte material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_ROUGHMATTE)

BSDFEvent RoughMatteMaterial_GetEventTypes() {
	return DIFFUSE | REFLECT;
}

bool RoughMatteMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 RoughMatteMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 RoughMatteMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float s, const float3 kdVal) {
	if (directPdfW)
		*directPdfW = fabs(lightDir.z * M_1_PI_F);

	*event = DIFFUSE | REFLECT;

	const float sigma2 = s * s;
	const float A = 1.f - (sigma2 / (2.f * (sigma2 + 0.33f)));
	const float B = 0.45f * sigma2 / (sigma2 + 0.09f);
	const float sinthetai = SinTheta(eyeDir);
	const float sinthetao = SinTheta(lightDir);
	float maxcos = 0.f;
	if (sinthetai > 1e-4f && sinthetao > 1e-4f) {
			const float dcos = CosPhi(lightDir) * CosPhi(eyeDir) +
					SinPhi(lightDir) * SinPhi(eyeDir);
			maxcos = fmax(0.f, dcos);
	}
	return Spectrum_Clamp(kdVal) * fabs(lightDir.z * M_1_PI_F) *
		(A + B * maxcos * sinthetai * sinthetao / fmax(fabs(CosTheta(lightDir)), fabs(CosTheta(eyeDir))));
}

float3 RoughMatteMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float s, const float3 kdVal) {
	if (!(requestedEvent & (DIFFUSE | REFLECT)) ||
			(fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	*sampledDir = (signbit(fixedDir.z) ? -1.f : 1.f) * CosineSampleHemisphereWithPdf(u0, u1, pdfW);

	*cosSampledDir = fabs((*sampledDir).z);
	if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	*event = DIFFUSE | REFLECT;

	const float sigma2 = s * s;
	const float A = 1.f - (sigma2 / (2.f * (sigma2 + 0.33f)));
	const float B = 0.45f * sigma2 / (sigma2 + 0.09f);
	const float sinthetai = SinTheta(fixedDir);
	const float sinthetao = SinTheta(*sampledDir);
	float maxcos = 0.f;
	if (sinthetai > 1e-4f && sinthetao > 1e-4f) {
			const float dcos = CosPhi(*sampledDir) * CosPhi(fixedDir) +
					SinPhi(*sampledDir) * SinPhi(fixedDir);
			maxcos = fmax(0.f, dcos);
	}

	return Spectrum_Clamp(kdVal) *
		(A + B * maxcos * sinthetai * sinthetao / fmax(fabs(CosTheta(*sampledDir)), fabs(CosTheta(fixedDir))));
}

#endif
#line 2 "materialdefs_funcs_matte_translucent.cl"

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

//------------------------------------------------------------------------------
// MatteTranslucent material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_MATTETRANSLUCENT)

BSDFEvent MatteTranslucentMaterial_GetEventTypes() {
	return DIFFUSE | REFLECT | TRANSMIT;
}

bool MatteTranslucentMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 MatteTranslucentMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 MatteTranslucentMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 krVal, const float3 ktVal) {
	const float3 r = Spectrum_Clamp(krVal);
	const float3 t = Spectrum_Clamp(ktVal) *
		// Energy conservation
		(1.f - r);

	const bool isKtBlack = Spectrum_IsBlack(t);
	const bool isKrBlack = Spectrum_IsBlack(r);

	// Decide to transmit or reflect
	float threshold;
	if (!isKrBlack) {
		if (!isKtBlack)
			threshold = .5f;
		else
			threshold = 1.f;
	} else {
		if (!isKtBlack)
			threshold = 0.f;
		else {
			if (directPdfW)
				*directPdfW = 0.f;
			return BLACK;
		}
	}

	const bool relfected = (CosTheta(lightDir) * CosTheta(eyeDir) > 0.f);
	const float weight = (lightDir.z * eyeDir.z > 0.f) ? threshold : (1.f - threshold);

	if (directPdfW)
		*directPdfW = weight * fabs(lightDir.z * M_1_PI_F);

	if (lightDir.z * eyeDir.z > 0.f) {
		*event = DIFFUSE | REFLECT;
		return r * fabs(lightDir.z * M_1_PI_F);
	} else {
		*event = DIFFUSE | TRANSMIT;
		return t * fabs(lightDir.z * M_1_PI_F);
	}
}

float3 MatteTranslucentMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 krVal, const float3 ktVal) {
	if (!(requestedEvent & (DIFFUSE | REFLECT | TRANSMIT)) ||
			(fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	*sampledDir = CosineSampleHemisphereWithPdf(u0, u1, pdfW);
	*cosSampledDir = fabs((*sampledDir).z);
	if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	const float3 kr = Spectrum_Clamp(krVal);
	const float3 kt = Spectrum_Clamp(ktVal) *
		// Energy conservation
		(1.f - kr);

	const bool isKtBlack = Spectrum_IsBlack(kt);
	const bool isKrBlack = Spectrum_IsBlack(kr);
	if (isKtBlack && isKrBlack)
		return BLACK;

	// Decide to transmit or reflect
	float threshold;
	if ((requestedEvent & REFLECT) && !isKrBlack) {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = .5f;
		else
			threshold = 1.f;
	} else {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = 0.f;
		else
			return BLACK;
	}

	if (passThroughEvent < threshold) {
		*sampledDir *= (signbit(fixedDir.z) ? -1.f : 1.f);
		*event = DIFFUSE | REFLECT;
		*pdfW *= threshold;

		return kr / threshold;
	} else {
		*sampledDir *= -(signbit(fixedDir.z) ? -1.f : 1.f);
		*event = DIFFUSE | TRANSMIT;
		*pdfW *= (1.f - threshold);

		return kt / (1.f - threshold);
	}
}

#endif
#line 2 "materialdefs_funcs_metal2.cl"

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

//------------------------------------------------------------------------------
// Metal2 material
//
// LuxRender Metal2 material porting.
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_METAL2)

BSDFEvent Metal2Material_GetEventTypes() {
	return GLOSSY | REFLECT;
}

bool Metal2Material_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 Metal2Material_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 Metal2Material_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float uVal,
#if defined(PARAM_ENABLE_MAT_METAL2_ANISOTROPIC)
		const float vVal,
#endif
		const float3 nVal, const float3 kVal) {
	const float u = clamp(uVal, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_METAL2_ANISOTROPIC)
	const float v = clamp(vVal, 0.f, 1.f);
	const float u2 = u * u;
	const float v2 = v * v;
	const float anisotropy = (u2 < v2) ? (1.f - u2 / v2) : u2 > 0.f ? (v2 / u2 - 1.f) : 0.f;
	const float roughness = u * v;
#else
	const float anisotropy = 0.f;
	const float roughness = u * u;
#endif

	const float3 wh = normalize(lightDir + eyeDir);
	const float cosWH = dot(lightDir, wh);

	if (directPdfW)
		*directPdfW = SchlickDistribution_Pdf(roughness, wh, anisotropy) / (4.f * cosWH);

	const float3 F = FresnelGeneral_Evaluate(nVal, kVal, cosWH);

	const float G = SchlickDistribution_G(roughness, lightDir, eyeDir);

	*event = GLOSSY | REFLECT;
	return SchlickDistribution_D(roughness, wh, anisotropy) * G / (4.f * fabs(eyeDir.z)) * F;
}

float3 Metal2Material_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float uVal,
#if defined(PARAM_ENABLE_MAT_METAL2_ANISOTROPIC)
		const float vVal,
#endif
		const float3 nVal, const float3 kVal) {
	if (!(requestedEvent & (GLOSSY | REFLECT)) ||
			(fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	const float u = clamp(uVal, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_METAL2_ANISOTROPIC)
	const float v = clamp(vVal, 0.f, 1.f);
	const float u2 = u * u;
	const float v2 = v * v;
	const float anisotropy = (u2 < v2) ? (1.f - u2 / v2) : u2 > 0.f ? (v2 / u2 - 1.f) : 0.f;
	const float roughness = u * v;
#else
	const float anisotropy = 0.f;
	const float roughness = u * u;
#endif

	float3 wh;
	float d, specPdf;
	SchlickDistribution_SampleH(roughness, anisotropy, u0, u1, &wh, &d, &specPdf);
	const float cosWH = dot(fixedDir, wh);
	*sampledDir = 2.f * cosWH * wh - fixedDir;

	const float coso = fabs(fixedDir.z);
	const float cosi = fabs((*sampledDir).z);
	*cosSampledDir = cosi;
	if ((*cosSampledDir < DEFAULT_COS_EPSILON_STATIC) || (fixedDir.z * (*sampledDir).z < 0.f))
		return BLACK;

	*pdfW = specPdf / (4.f * fabs(cosWH));
	if (*pdfW <= 0.f)
		return BLACK;

	const float G = SchlickDistribution_G(roughness, fixedDir, *sampledDir);

	const float3 F = FresnelGeneral_Evaluate(nVal, kVal, cosWH);

	float factor = (d / specPdf) * G * fabs(cosWH);
	//if (!fromLight)
		factor /= coso;
	//else
	//	factor /= cosi;

	*event = GLOSSY | REFLECT;

	return factor * F;
}

#endif
#line 2 "materialdefs_funcs_mirror.cl"

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

//------------------------------------------------------------------------------
// Mirror material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_MIRROR)

BSDFEvent MirrorMaterial_GetEventTypes() {
	return SPECULAR | REFLECT;
}

bool MirrorMaterial_IsDelta() {
	return true;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 MirrorMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 MirrorMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 krVal) {
	return BLACK;
}

float3 MirrorMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 krVal) {
	if (!(requestedEvent & (SPECULAR | REFLECT)))
		return BLACK;

	*event = SPECULAR | REFLECT;

	*sampledDir = (float3)(-fixedDir.x, -fixedDir.y, fixedDir.z);
	*pdfW = 1.f;

	*cosSampledDir = fabs((*sampledDir).z);

	return Spectrum_Clamp(krVal);
}

#endif
#line 2 "materialdefs_funcs_null.cl"

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

//------------------------------------------------------------------------------
// NULL material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_NULL)

BSDFEvent NullMaterial_GetEventTypes() {
	return SPECULAR | TRANSMIT;
}

bool NullMaterial_IsDelta() {
	return true;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 NullMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return WHITE;
}
#endif

float3 NullMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW) {
	return BLACK;
}

float3 NullMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent) {
	if (!(requestedEvent & (SPECULAR | TRANSMIT)))
		return BLACK;

	*sampledDir = -fixedDir;
	*cosSampledDir = 1.f;

	*pdfW = 1.f;
	*event = SPECULAR | TRANSMIT;
	return WHITE;
}

#endif
#line 2 "materialdefs_funcs_roughglass.cl"

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

//------------------------------------------------------------------------------
// RoughGlass material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_ROUGHGLASS)

BSDFEvent RoughGlassMaterial_GetEventTypes() {
	return GLOSSY | REFLECT | TRANSMIT;
}

bool RoughGlassMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 RoughGlassMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 RoughGlassMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 localLightDir, const float3 localEyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 ktVal, const float3 krVal,
		const float nuVal,
#if defined(PARAM_ENABLE_MAT_ROUGHGLASS_ANISOTROPIC)
		const float nvVal,
#endif
		const float nc, const float nt
		) {
	const float3 kt = Spectrum_Clamp(ktVal);
	const float3 kr = Spectrum_Clamp(ktVal);

	const bool isKtBlack = Spectrum_IsBlack(kt);
	const bool isKrBlack = Spectrum_IsBlack(kr);
	if (isKtBlack && isKrBlack)
		return BLACK;

	const float ntc = nt / nc;

	const float u = clamp(nuVal, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_ROUGHGLASS_ANISOTROPIC)
	const float v = clamp(nvVal, 0.f, 1.f);
	const float u2 = u * u;
	const float v2 = v * v;
	const float anisotropy = (u2 < v2) ? (1.f - u2 / v2) : u2 > 0.f ? (v2 / u2 - 1.f) : 0.f;
	const float roughness = u * v;
#else
	const float anisotropy = 0.f;
	const float roughness = u * u;
#endif

	const float threshold = isKrBlack ? 1.f : (isKtBlack ? 0.f : .5f);
	if (localLightDir.z * localEyeDir.z < 0.f) {
		// Transmit

		const bool entering = (CosTheta(localLightDir) > 0.f);
		const float eta = entering ? (nc / nt) : ntc;

		float3 wh = eta * localLightDir + localEyeDir;
		if (wh.z < 0.f)
			wh = -wh;

		const float lengthSquared = dot(wh, wh);
		if (!(lengthSquared > 0.f))
			return BLACK;
		wh /= sqrt(lengthSquared);
		const float cosThetaI = fabs(CosTheta(localEyeDir));
		const float cosThetaIH = fabs(dot(localEyeDir, wh));
		const float cosThetaOH = dot(localLightDir, wh);

		const float D = SchlickDistribution_D(roughness, wh, anisotropy);
		const float G = SchlickDistribution_G(roughness, localLightDir, localEyeDir);
		const float specPdf = SchlickDistribution_Pdf(roughness, wh, anisotropy);
		const float3 F = FresnelCauchy_Evaluate(ntc, cosThetaOH);

		if (directPdfW)
			*directPdfW = threshold * specPdf * (fabs(cosThetaOH) * eta * eta) / lengthSquared;

		//if (reversePdfW)
		//	*reversePdfW = threshold * specPdf * cosThetaIH / lengthSquared;

		float3 result = (fabs(cosThetaOH) * cosThetaIH * D *
			G / (cosThetaI * lengthSquared)) *
			kt * (1.f - F);

        *event = DIFFUSE | TRANSMIT;

		return result;
	} else {
		// Reflect
		const float cosThetaO = fabs(CosTheta(localLightDir));
		const float cosThetaI = fabs(CosTheta(localEyeDir));
		if (cosThetaO == 0.f || cosThetaI == 0.f)
			return BLACK;
		float3 wh = localLightDir + localEyeDir;
		if (all(isequal(wh, BLACK)))
			return BLACK;
		wh = normalize(wh);
		if (wh.z < 0.f)
			wh = -wh;

		float cosThetaH = dot(localEyeDir, wh);
		const float D = SchlickDistribution_D(roughness, wh, anisotropy);
		const float G = SchlickDistribution_G(roughness, localLightDir, localEyeDir);
		const float specPdf = SchlickDistribution_Pdf(roughness, wh, anisotropy);
		const float3 F = FresnelCauchy_Evaluate(ntc, cosThetaH);

		if (directPdfW)
			*directPdfW = (1.f - threshold) * specPdf / (4.f * fabs(dot(localLightDir, wh)));

		//if (reversePdfW)
		//	*reversePdfW = (1.f - threshold) * specPdf / (4.f * fabs(dot(localLightDir, wh));

		float3 result = (D * G / (4.f * cosThetaI)) * kr * F;

        *event = DIFFUSE | REFLECT;

		return result;
	}
}

float3 RoughGlassMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 localFixedDir, float3 *localSampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *absCosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 ktVal, const float3 krVal,
		const float nuVal,
#if defined(PARAM_ENABLE_MAT_ROUGHGLASS_ANISOTROPIC)
		const float nvVal,
#endif
		const float nc, const float nt
		) {
	if (!(requestedEvent & (GLOSSY | REFLECT | TRANSMIT)) ||
			(fabs(localFixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	const float3 kt = Spectrum_Clamp(ktVal);
	const float3 kr = Spectrum_Clamp(ktVal);

	const bool isKtBlack = Spectrum_IsBlack(kt);
	const bool isKrBlack = Spectrum_IsBlack(kr);
	if (isKtBlack && isKrBlack)
		return BLACK;

	const float u = clamp(nuVal, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_ROUGHGLASS_ANISOTROPIC)
	const float v = clamp(nvVal, 0.f, 1.f);
	const float u2 = u * u;
	const float v2 = v * v;
	const float anisotropy = (u2 < v2) ? (1.f - u2 / v2) : u2 > 0.f ? (v2 / u2 - 1.f);
	const float roughness = u * v;
#else
	const float anisotropy = 0.f;
	const float roughness = u * u;
#endif

	float3 wh;
	float d, specPdf;
	SchlickDistribution_SampleH(roughness, anisotropy, u0, u1, &wh, &d, &specPdf);
	if (wh.z < 0.f)
		wh = -wh;
	const float cosThetaOH = dot(localFixedDir, wh);

	const float ntc = nt / nc;

	const float coso = fabs(localFixedDir.z);

	// Decide to transmit or reflect
	float threshold;
	if ((requestedEvent & REFLECT) && !isKrBlack) {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = .5f;
		else
			threshold = 0.f;
	} else {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = 1.f;
		else
			return BLACK;
	}

	float3 result;
	if (passThroughEvent < threshold) {
		// Transmit

		const bool entering = (CosTheta(localFixedDir) > 0.f);
		const float eta = entering ? (nc / nt) : ntc;
		const float eta2 = eta * eta;
		const float sinThetaIH2 = eta2 * fmax(0.f, 1.f - cosThetaOH * cosThetaOH);
		if (sinThetaIH2 >= 1.f)
			return BLACK;
		float cosThetaIH = sqrt(1.f - sinThetaIH2);
		if (entering)
			cosThetaIH = -cosThetaIH;
		const float length = eta * cosThetaOH + cosThetaIH;
		*localSampledDir = length * wh - eta * localFixedDir;

		const float lengthSquared = length * length;
		*pdfW = specPdf * fabs(cosThetaIH) / lengthSquared;
		if (*pdfW <= 0.f)
			return BLACK;

		const float cosi = fabs((*localSampledDir).z);
		*absCosSampledDir = cosi;

		const float G = SchlickDistribution_G(roughness, localFixedDir, *localSampledDir);
		float factor = (d / specPdf) * G * fabs(cosThetaOH) / threshold;

		//if (!hitPoint.fromLight) {
			const float3 F = FresnelCauchy_Evaluate(ntc, cosThetaIH);
			result = (factor / coso) * kt * (1.f - F);
		//} else {
		//	const Spectrum F = FresnelCauchy_Evaluate(ntc, cosThetaOH);
		//	result = (factor / cosi) * kt * (Spectrum(1.f) - F);
		//}

		*pdfW *= threshold;
		*event = GLOSSY | TRANSMIT;
	} else {
		// Reflect
		*pdfW = specPdf / (4.f * fabs(cosThetaOH));
		if (*pdfW <= 0.f)
			return BLACK;

		*localSampledDir = 2.f * cosThetaOH * wh - localFixedDir;

		const float cosi = fabs((*localSampledDir).z);
		*absCosSampledDir = cosi;
		if ((*absCosSampledDir < DEFAULT_COS_EPSILON_STATIC) || (localFixedDir.z * (*localSampledDir).z < 0.f))
			return BLACK;

		const float G = SchlickDistribution_G(roughness, localFixedDir, *localSampledDir);
		float factor = (d / specPdf) * G * fabs(cosThetaOH) / (1.f - threshold);

		const float3 F = FresnelCauchy_Evaluate(ntc, cosThetaOH);
		//factor /= (!hitPoint.fromLight) ? coso : cosi;
		factor /= coso;
		result = factor * F * kr;

		*pdfW *= (1.f - threshold);
		*event = GLOSSY | REFLECT;
	}

	return result;
}

#endif
#line 2 "materialdefs_funcs_roughmatte_translucent.cl"

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

//------------------------------------------------------------------------------
// MatteTranslucent material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_ROUGHMATTETRANSLUCENT)

BSDFEvent RoughMatteTranslucentMaterial_GetEventTypes() {
	return DIFFUSE | REFLECT | TRANSMIT;
}

bool RoughMatteTranslucentMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 RoughMatteTranslucentMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 RoughMatteTranslucentMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 krVal, const float3 ktVal, const float sigma) {
	const float3 r = Spectrum_Clamp(krVal);
	const float3 t = Spectrum_Clamp(ktVal) *
		// Energy conservation
		(1.f - r);

	const bool isKtBlack = Spectrum_IsBlack(t);
	const bool isKrBlack = Spectrum_IsBlack(r);

	// Decide to transmit or reflect
	float threshold;
	if (!isKrBlack) {
		if (!isKtBlack)
			threshold = .5f;
		else
			threshold = 1.f;
	} else {
		if (!isKtBlack)
			threshold = 0.f;
		else {
			if (directPdfW)
				*directPdfW = 0.f;
			return BLACK;
		}
	}

	const bool relfected = (CosTheta(lightDir) * CosTheta(eyeDir) > 0.f);
	const float weight = (lightDir.z * eyeDir.z > 0.f) ? threshold : (1.f - threshold);

	if (directPdfW)
		*directPdfW = weight * fabs(lightDir.z * M_1_PI_F);

	const float sigma2 = sigma * sigma;
	const float A = 1.f - (sigma2 / (2.f * (sigma2 + 0.33f)));
	const float B = 0.45f * sigma2 / (sigma2 + 0.09f);
	const float sinthetai = SinTheta(eyeDir);
	const float sinthetao = SinTheta(lightDir);
	float maxcos = 0.f;
	if (sinthetai > 1e-4f && sinthetao > 1e-4f) {
		const float dcos = CosPhi(lightDir) * CosPhi(eyeDir) +
			SinPhi(lightDir) * SinPhi(eyeDir);
		maxcos = fmax(0.f, dcos);
	}

	const float3 result = (M_1_PI_F * fabs(lightDir.z) *
		(A + B * maxcos * sinthetai * sinthetao / fmax(fabs(CosTheta(lightDir)), fabs(CosTheta(eyeDir)))));

	if (lightDir.z * eyeDir.z > 0.f) {
		*event = DIFFUSE | REFLECT;
		return r * result;
	} else {
		*event = DIFFUSE | TRANSMIT;
		return t * result;
	}
}

float3 RoughMatteTranslucentMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 krVal, const float3 ktVal, const float sigma) {
	if (!(requestedEvent & (DIFFUSE | REFLECT | TRANSMIT)) ||
			(fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	*sampledDir = CosineSampleHemisphereWithPdf(u0, u1, pdfW);
	*cosSampledDir = fabs((*sampledDir).z);
	if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	const float3 kr = Spectrum_Clamp(krVal);
	const float3 kt = Spectrum_Clamp(ktVal) *
		// Energy conservation
		(1.f - kr);

	const bool isKtBlack = Spectrum_IsBlack(kt);
	const bool isKrBlack = Spectrum_IsBlack(kr);
	if (isKtBlack && isKrBlack)
		return BLACK;

	// Decide to transmit or reflect
	float threshold;
	if ((requestedEvent & REFLECT) && !isKrBlack) {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = .5f;
		else
			threshold = 1.f;
	} else {
		if ((requestedEvent & TRANSMIT) && !isKtBlack)
			threshold = 0.f;
		else
			return BLACK;
	}

	const float sigma2 = sigma * sigma;
	const float A = 1.f - (sigma2 / (2.f * (sigma2 + 0.33f)));
	const float B = 0.45f * sigma2 / (sigma2 + 0.09f);
	const float sinthetai = SinTheta(fixedDir);
	const float sinthetao = SinTheta(*sampledDir);
	float maxcos = 0.f;
	if (sinthetai > 1e-4f && sinthetao > 1e-4f) {
		const float dcos = CosPhi(*sampledDir) * CosPhi(fixedDir) +
			SinPhi(*sampledDir) * SinPhi(fixedDir);
		maxcos = max(0.f, dcos);
	}
	const float coef = (A + B * maxcos * sinthetai * sinthetao / max(fabs(CosTheta(*sampledDir)), fabs(CosTheta(fixedDir))));

	if (passThroughEvent < threshold) {
		*sampledDir *= (signbit(fixedDir.z) ? -1.f : 1.f);
		*event = DIFFUSE | REFLECT;
		*pdfW *= threshold;

		return kr * (coef / threshold);
	} else {
		*sampledDir *= -(signbit(fixedDir.z) ? -1.f : 1.f);
		*event = DIFFUSE | TRANSMIT;
		*pdfW *= (1.f - threshold);

		return kt * (coef / (1.f - threshold));
	}
}

#endif
#line 2 "materialdefs_funcs_velvet.cl"

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

//------------------------------------------------------------------------------
// Velvet material
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_VELVET)

BSDFEvent VelvetMaterial_GetEventTypes() {
	return DIFFUSE | REFLECT;
}

bool VelvetMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 VelvetMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 VelvetMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
		const float3 kdVal,
		const float A1, const float A2, const float A3,
		const float delta) {
	if (directPdfW)
		*directPdfW = fabs(lightDir.z * M_1_PI_F);

	*event = DIFFUSE | REFLECT;

	const float3 kd = Spectrum_Clamp(kdVal);
	const float cosv = -dot(lightDir, eyeDir);

	// Compute phase function

	const float B = 3.0f * cosv;

	float p = 1.0f + A1 * cosv + A2 * 0.5f * (B * cosv - 1.0f) + A3 * 0.5 * (5.0f * cosv * cosv * cosv - B);
	p = p / (4.0f * M_PI_F);

	p = (p * delta) / fabs(eyeDir.z);

	// Clamp the BRDF (page 7)
	if (p > 1.0f)
		p = 1.0f;
	else if (p < 0.0f)
		p = 0.0f;

	return p * kd;
}

float3 VelvetMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
		const float3 kdVal,
		const float A1, const float A2, const float A3,
		const float delta) {
	if (!(requestedEvent & (DIFFUSE | REFLECT)) ||
			(fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC))
		return BLACK;

	*sampledDir = (signbit(fixedDir.z) ? -1.f : 1.f) * CosineSampleHemisphereWithPdf(u0, u1, pdfW);

	*cosSampledDir = fabs((*sampledDir).z);
	if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	*event = DIFFUSE | REFLECT;

	const float3 kd = Spectrum_Clamp(kdVal);
	const float cosv = dot(-fixedDir, *sampledDir);;

	// Compute phase function

	const float B = 3.0f * cosv;

	float p = 1.0f + A1 * cosv + A2 * 0.5f * (B * cosv - 1.0f) + A3 * 0.5 * (5.0f * cosv * cosv * cosv - B);
	p = p / (4.0f * M_PI_F);

	p = (p * delta) / fabs(fixedDir.z);

	// Clamp the BRDF (page 7)
	if (p > 1.0f)
		p = 1.0f;
	else if (p < 0.0f)
		p = 0.0f;

	return kd * (p / *pdfW);
}

#endif
#line 2 "materialdefs_funcs_glossy2.cl"

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

//------------------------------------------------------------------------------
// GlossyTranslucent material
//
// LuxRender GlossyTranslucent material porting.
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT)

BSDFEvent GlossyTranslucentMaterial_GetEventTypes() {
	return GLOSSY | DIFFUSE | REFLECT | TRANSMIT;
}

bool GlossyTranslucentMaterial_IsDelta() {
	return false;
}

#if defined(PARAM_HAS_PASSTHROUGH)
float3 GlossyTranslucentMaterial_GetPassThroughTransparency(__global const Material *material,
		__global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent
		TEXTURES_PARAM_DECL) {
	return BLACK;
}
#endif

float3 GlossyTranslucentMaterial_ConstEvaluate(
		__global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir,
		BSDFEvent *event, float *directPdfW,
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		const float i, const float i_bf,
#endif
		const float nuVal, const float nuVal_bf,
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
		const float nvVal, const float nvVal_bf,
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
		const float3 kaVal, const float3 kaVal_bf,
		const float d, const float d_bf,
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_MULTIBOUNCE)
		const int multibounceVal, const int multibounceVal_bf,
#endif
		const float3 kdVal, const float3 ktVal, const float3 ksVal, const float3 ksVal_bf) {
	const float3 fixedDir = eyeDir;
	const float3 sampledDir = lightDir;

	const float cosi = fabs(sampledDir.z);
	const float coso = fabs(fixedDir.z);

	const float3 geometryN = VLOAD3F(&hitPoint->geometryN.x);
	Frame frame;
	Frame_SetFromZ_Private(&frame, geometryN);

	const float sideTest = dot(Frame_ToWorld_Private(&frame, fixedDir), geometryN) * dot(Frame_ToWorld_Private(&frame, sampledDir), geometryN);
	if (sideTest < -DEFAULT_COS_EPSILON_STATIC) {
		// Transmition
		*event = DIFFUSE | TRANSMIT;

		if (directPdfW)
			*directPdfW = fabs(sampledDir.z) * M_1_PI_F * 0.5f;

		const float3 H = normalize((float3)(lightDir.x + eyeDir.x, lightDir.y + eyeDir.y,
			lightDir.z - eyeDir.z));
		const float u = fabs(dot(lightDir, H));
		float3 ks = ksVal;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		if (i > 0.f) {
			const float ti = (i - 1.f) / (i + 1.f);
			ks *= ti * ti;
		}
#endif
		ks = Spectrum_Clamp(ks);
		const float3 S1 = FresnelSchlick_Evaluate(ks, u);

		ks = ksVal_bf;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		if (i_bf > 0.f) {
			const float ti = (i_bf - 1.f) / (i_bf + 1.f);
			ks *= ti * ti;
		}
#endif
		ks = Spectrum_Clamp(ks);
		const float3 S2 = FresnelSchlick_Evaluate(ks, u);
		float3 S = Spectrum_Sqrt((WHITE - S1) * (WHITE - S2));
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
		if (lightDir.z > 0.f) {
			S *= Spectrum_Exp(Spectrum_Clamp(kaVal) * -(d / cosi) +
				Spectrum_Clamp(kaVal_bf) * -(d_bf / coso));
		} else {
			S *= Spectrum_Exp(Spectrum_Clamp(kaVal) * -(d / coso) +
				Spectrum_Clamp(kaVal_bf) * -(d_bf / cosi));
		}
#endif
		return (M_1_PI_F * coso) * S * Spectrum_Clamp(ktVal) *
			(WHITE - Spectrum_Clamp(kdVal));
	} else if (sideTest > DEFAULT_COS_EPSILON_STATIC) {
		// Reflection
		*event = GLOSSY | REFLECT;

		const float3 baseF = Spectrum_Clamp(kdVal) * M_1_PI_F * cosi;
		float3 ks;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		float index;
#endif
		float u;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
		float v;
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
		float3 alpha;
		float depth;
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_MULTIBOUNCE)
		int mbounce;
#else
		int mbounce = 0;
#endif
		if (eyeDir.z >= 0.f) {
			ks = ksVal;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
			index = i;
#endif
			u = clamp(nuVal, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
			v = clamp(nvVal, 0.f, 1.f);
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
			alpha = Spectrum_Clamp(kaVal);
			depth = d;
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_MULTIBOUNCE)
			mbounce = multibounceVal;
#endif
		} else {
			ks = ksVal_bf;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
			index = i_bf;
#endif
			u = clamp(nuVal_bf, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
			v = clamp(nvVal_bf, 0.f, 1.f);
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
			alpha = Spectrum_Clamp(kaVal_bf);
			depth = d_bf;
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_MULTIBOUNCE)
			mbounce = multibounceVal_bf;
#endif
		}

#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		if (index > 0.f) {
			const float ti = (index - 1.f) / (index + 1.f);
			ks *= ti * ti;
		}
#endif
		ks = Spectrum_Clamp(ks);

#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
		const float u2 = u * u;
		const float v2 = v * v;
		const float anisotropy = (u2 < v2) ? (1.f - u2 / v2) : u2 > 0.f ? (v2 / u2 - 1.f) : 0.f;
		const float roughness = u * v;
#else
		const float anisotropy = 0.f;
		const float roughness = u * u;
#endif

		if (directPdfW) {
			const float wCoating = SchlickBSDF_CoatingWeight(ks, fixedDir);
			const float wBase = 1.f - wCoating;

			*directPdfW = 0.5f * (wBase * fabs(sampledDir.z * M_1_PI_F) +
				wCoating * SchlickBSDF_CoatingPdf(roughness, anisotropy, fixedDir, sampledDir));
		}

		// Absorption
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
		const float3 absorption = CoatingAbsorption(cosi, coso, alpha, depth);
#else
		const float3 absorption = WHITE;
#endif

		// Coating fresnel factor
		const float3 H = normalize(fixedDir + sampledDir);
		const float3 S = FresnelSchlick_Evaluate(ks, fabs(dot(sampledDir, H)));

		const float3 coatingF = SchlickBSDF_CoatingF(ks, roughness, anisotropy, mbounce, fixedDir, sampledDir);

		// Blend in base layer Schlick style
		// assumes coating bxdf takes fresnel factor S into account

		return coatingF + absorption * (WHITE - S) * baseF;
	} else {
		return BLACK;
	}
}

float3 GlossyTranslucentMaterial_ConstSample(
		__global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent,
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		const float i, const float i_bf,
#endif
		const float nuVal, const float nuVal_bf,
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
		const float nvVal, const float nvVal_bf,
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
		const float3 kaVal, const float3 kaVal_bf,
		const float d, const float d_bf,
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_MULTIBOUNCE)
		const int multibounceVal, const int multibounceVal_bf,
#endif
		const float3 kdVal, const float3 ktVal, const float3 ksVal, const float3 ksVal_bf) {
	if (fabs(fixedDir.z) < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	if (passThroughEvent < 0.5f && (requestedEvent & (GLOSSY | REFLECT))) {
		// Reflection
		float3 ks;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		float index;
#endif
		float u;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
		float v;
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
		float3 alpha;
		float depth;
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_MULTIBOUNCE)
		int mbounce;
#else
		int mbounce = 0;
#endif
		if (fixedDir.z >= 0.f) {
			ks = ksVal;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
			index = i;
#endif
			u = clamp(nuVal, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
			v = clamp(nvVal, 0.f, 1.f);
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
			alpha = Spectrum_Clamp(kaVal);
			depth = d;
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_MULTIBOUNCE)
			mbounce = multibounceVal;
#endif
		} else {
			ks = ksVal_bf;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
			index = i_bf;
#endif
			u = clamp(nuVal_bf, 0.f, 1.f);
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
			v = clamp(nvVal_bf, 0.f, 1.f);
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
			alpha = Spectrum_Clamp(kaVal_bf);
			depth = d_bf;
#endif
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_MULTIBOUNCE)
			mbounce = multibounceVal_bf;
#endif
		}

#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		if (index > 0.f) {
			const float ti = (index - 1.f) / (index + 1.f);
			ks *= ti * ti;
		}
#endif
		ks = Spectrum_Clamp(ks);

#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ANISOTROPIC)
		const float u2 = u * u;
		const float v2 = v * v;
		const float anisotropy = (u2 < v2) ? (1.f - u2 / v2) : u2 > 0.f ? (v2 / u2 - 1.f) : 0.f;
		const float roughness = u * v;
#else
		const float anisotropy = 0.f;
		const float roughness = u * u;
#endif

		const float wCoating = SchlickBSDF_CoatingWeight(ks, fixedDir);
		const float wBase = 1.f - wCoating;

		float basePdf, coatingPdf;
		float3 baseF, coatingF;

		if (2.f * passThroughEvent < wBase) {
			// Sample base BSDF (Matte BSDF)
			*sampledDir = CosineSampleHemisphereWithPdf(u0, u1, &basePdf);
			*sampledDir *= signbit(fixedDir.z) ? -1.f : 1.f;

			*cosSampledDir = fabs((*sampledDir).z);
			if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
				return BLACK;

			baseF = Spectrum_Clamp(kdVal) * M_1_PI_F * *cosSampledDir;

			// Evaluate coating BSDF (Schlick BSDF)
			coatingF = SchlickBSDF_CoatingF(ks, roughness, anisotropy, mbounce,
				fixedDir, *sampledDir);
			coatingPdf = SchlickBSDF_CoatingPdf(roughness, anisotropy, fixedDir, *sampledDir);

			*event = GLOSSY | REFLECT;
		} else {
			// Sample coating BSDF (Schlick BSDF)
			coatingF = SchlickBSDF_CoatingSampleF(ks, roughness, anisotropy, mbounce,
				fixedDir, sampledDir, u0, u1, &coatingPdf);
			if (Spectrum_IsBlack(coatingF))
				return BLACK;

			*cosSampledDir = fabs((*sampledDir).z);
			if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
				return BLACK;

			coatingF *= coatingPdf;

			// Evaluate base BSDF (Matte BSDF)
			basePdf = *cosSampledDir * M_1_PI_F;
			baseF = Spectrum_Clamp(kdVal) * M_1_PI_F * *cosSampledDir;

			*event = GLOSSY | REFLECT;
		}

		const float3 geometryN = VLOAD3F(&hitPoint->geometryN.x);
		Frame frame;
		Frame_SetFromZ_Private(&frame, geometryN);
		if (!(dot(Frame_ToWorld_Private(&frame, fixedDir), geometryN) * dot(Frame_ToWorld_Private(&frame, *sampledDir), geometryN) > DEFAULT_COS_EPSILON_STATIC))
			return BLACK;

		*pdfW = 0.5f * (coatingPdf * wCoating + basePdf * wBase);

		// Absorption
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
		const float cosi = fabs((*sampledDir).z);
		const float coso = fabs(fixedDir.z);
		const float3 absorption = CoatingAbsorption(cosi, coso, alpha, d);
#else
		const float3 absorption = WHITE;
#endif

		// Coating fresnel factor
		const float3 H = normalize(fixedDir + *sampledDir);
		const float3 S = FresnelSchlick_Evaluate(ks, fabs(dot(*sampledDir, H)));

		// Blend in base layer Schlick style
		// coatingF already takes fresnel factor S into account

		return (coatingF + absorption * (WHITE - S) * baseF) / *pdfW;
	} else if (passThroughEvent >= .5f && (requestedEvent & (DIFFUSE | TRANSMIT))) {
		// Transmition
		*sampledDir = CosineSampleHemisphereWithPdf(u0, u1, pdfW);
		*sampledDir *= signbit(fixedDir.z) ? 1.f : -1.f;

		const float3 geometryN = VLOAD3F(&hitPoint->geometryN.x);
		Frame frame;
		Frame_SetFromZ_Private(&frame, geometryN);
		if (!(dot(Frame_ToWorld_Private(&frame, fixedDir), geometryN) * dot(Frame_ToWorld_Private(&frame, *sampledDir), geometryN) < -DEFAULT_COS_EPSILON_STATIC))
			return BLACK;

		*pdfW *= 0.5f;

		*cosSampledDir = fabs((*sampledDir).z);
		if (*cosSampledDir < DEFAULT_COS_EPSILON_STATIC)
			return BLACK;

		*event = DIFFUSE | TRANSMIT;

		const float cosi = fabs((*sampledDir).z);
		const float coso = fabs(fixedDir.z);

		const float3 H = normalize((float3)((*sampledDir).x + fixedDir.x, (*sampledDir).y + fixedDir.y,
			(*sampledDir).z - fixedDir.z));
		const float u = fabs(dot(*sampledDir, H));
		float3 ks = ksVal;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		if (i > 0.f) {
			const float ti = (i - 1.f) / (i + 1.f);
			ks *= ti * ti;
		}
#endif
		ks = Spectrum_Clamp(ks);
		const float3 S1 = FresnelSchlick_Evaluate(ks, u);

		ks = ksVal_bf;
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_INDEX)
		if (i_bf > 0.f) {
			const float ti = (i_bf - 1.f) / (i_bf + 1.f);
			ks *= ti * ti;
		}
#endif
		ks = Spectrum_Clamp(ks);
		const float3 S2 = FresnelSchlick_Evaluate(ks, u);
		float3 S = Spectrum_Sqrt((WHITE - S1) * (WHITE - S2));
#if defined(PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT_ABSORPTION)
		if ((*sampledDir).z > 0.f) {
			S *= Spectrum_Exp(Spectrum_Clamp(kaVal) * -(d / cosi) +
				Spectrum_Clamp(kaVal_bf) * -(d_bf / coso));
		} else {
			S *= Spectrum_Exp(Spectrum_Clamp(kaVal) * -(d / coso) +
				Spectrum_Clamp(kaVal_bf) * -(d_bf / cosi));
		}
#endif
		return (M_1_PI_F * coso / *pdfW) * S * Spectrum_Clamp(ktVal) *
			(WHITE - Spectrum_Clamp(kdVal));
	} else {
		return BLACK;
	}
}

#endif
#line 2 "material_funcs.cl"

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

//------------------------------------------------------------------------------
// Generic material functions
//
// They include the support for all material but Mix
// (because OpenCL doesn't support recursion)
//------------------------------------------------------------------------------

float3 Material_GetEmittedRadianceNoMix(__global const Material *material, __global HitPoint *hitPoint
		TEXTURES_PARAM_DECL) {
	const uint emitTexIndex = material->emitTexIndex;
	if (emitTexIndex == NULL_INDEX)
		return BLACK;

	return
#if defined(PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR)
		VLOAD3F(hitPoint->color.c) *
#endif
		Texture_GetSpectrumValue(emitTexIndex, hitPoint
				TEXTURES_PARAM);
}

#if defined(PARAM_HAS_VOLUMES)
uint Material_GetInteriorVolumeNoMix(__global const Material *material) {
	return material->interiorVolumeIndex;
}

uint Material_GetExteriorVolumeNoMix(__global const Material *material) {
	return material->exteriorVolumeIndex;
}
#endif
#line 2 "Material evaluation code form CompiledScene::GetMaterialsEvaluationSourceCode()"
BSDFEvent Material_Index0_GetEventTypes(__global const Material *material MATERIALS_PARAM_DECL) {
	return MatteMaterial_GetEventTypes();
}
bool Material_Index0_IsDelta(__global const Material *material MATERIALS_PARAM_DECL) {
	return MatteMaterial_IsDelta();
}
float3 Material_Index0_Evaluate(__global const Material *material, __global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir, BSDFEvent *event, float *directPdfW MATERIALS_PARAM_DECL) {
	return MatteMaterial_ConstEvaluate(hitPoint, lightDir, eyeDir, event, directPdfW, Texture_Index0_EvaluateSpectrum(&texs[0], hitPoint TEXTURES_PARAM));
}
float3 Material_Index0_Sample(__global const Material *material, __global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir, const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
	const float passThroughEvent,
#endif
	float *pdfW, float *cosSampledDir, BSDFEvent *event, const BSDFEvent requestedEvent MATERIALS_PARAM_DECL) {
	return MatteMaterial_ConstSample(hitPoint, fixedDir, sampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		passThroughEvent,
#endif
		pdfW,  cosSampledDir, event, requestedEvent, Texture_Index0_EvaluateSpectrum(&texs[0], hitPoint TEXTURES_PARAM));
}
#if defined(PARAM_HAS_PASSTHROUGH)
float3 Material_Index0_GetPassThroughTransparency(__global const Material *material, __global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return MatteMaterial_GetPassThroughTransparency(material, hitPoint, localFixedDir, passThroughEvent TEXTURES_PARAM);
}
#endif
float3 Material_Index0_GetEmittedRadiance(__global const Material *material, __global HitPoint *hitPoint, const float oneOverPrimitiveArea MATERIALS_PARAM_DECL) {
	return Material_GetEmittedRadianceNoMix(material, hitPoint TEXTURES_PARAM);
}
#if defined(PARAM_HAS_VOLUMES)
uint Material_Index0_GetInteriorVolume(__global const Material *material, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return Material_GetInteriorVolumeNoMix(material);
}
uint Material_Index0_GetExteriorVolume(__global const Material *material, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return Material_GetExteriorVolumeNoMix(material);
}
#endif
BSDFEvent Material_Index1_GetEventTypes(__global const Material *material MATERIALS_PARAM_DECL) {
	return MirrorMaterial_GetEventTypes();
}
bool Material_Index1_IsDelta(__global const Material *material MATERIALS_PARAM_DECL) {
	return MirrorMaterial_IsDelta();
}
float3 Material_Index1_Evaluate(__global const Material *material, __global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir, BSDFEvent *event, float *directPdfW MATERIALS_PARAM_DECL) {
	return MirrorMaterial_ConstEvaluate(hitPoint, lightDir, eyeDir, event, directPdfW, Texture_Index1_EvaluateSpectrum(&texs[1], hitPoint TEXTURES_PARAM));
}
float3 Material_Index1_Sample(__global const Material *material, __global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir, const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
	const float passThroughEvent,
#endif
	float *pdfW, float *cosSampledDir, BSDFEvent *event, const BSDFEvent requestedEvent MATERIALS_PARAM_DECL) {
	return MirrorMaterial_ConstSample(hitPoint, fixedDir, sampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		passThroughEvent,
#endif
		pdfW,  cosSampledDir, event, requestedEvent, Texture_Index1_EvaluateSpectrum(&texs[1], hitPoint TEXTURES_PARAM));
}
#if defined(PARAM_HAS_PASSTHROUGH)
float3 Material_Index1_GetPassThroughTransparency(__global const Material *material, __global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return MirrorMaterial_GetPassThroughTransparency(material, hitPoint, localFixedDir, passThroughEvent TEXTURES_PARAM);
}
#endif
float3 Material_Index1_GetEmittedRadiance(__global const Material *material, __global HitPoint *hitPoint, const float oneOverPrimitiveArea MATERIALS_PARAM_DECL) {
	return Material_GetEmittedRadianceNoMix(material, hitPoint TEXTURES_PARAM);
}
#if defined(PARAM_HAS_VOLUMES)
uint Material_Index1_GetInteriorVolume(__global const Material *material, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return Material_GetInteriorVolumeNoMix(material);
}
uint Material_Index1_GetExteriorVolume(__global const Material *material, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return Material_GetExteriorVolumeNoMix(material);
}
#endif
BSDFEvent Material_Index2_GetEventTypes(__global const Material *material MATERIALS_PARAM_DECL) {
	return MatteMaterial_GetEventTypes();
}
bool Material_Index2_IsDelta(__global const Material *material MATERIALS_PARAM_DECL) {
	return MatteMaterial_IsDelta();
}
float3 Material_Index2_Evaluate(__global const Material *material, __global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir, BSDFEvent *event, float *directPdfW MATERIALS_PARAM_DECL) {
	return MatteMaterial_ConstEvaluate(hitPoint, lightDir, eyeDir, event, directPdfW, Texture_Index2_EvaluateSpectrum(&texs[2], hitPoint TEXTURES_PARAM));
}
float3 Material_Index2_Sample(__global const Material *material, __global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir, const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
	const float passThroughEvent,
#endif
	float *pdfW, float *cosSampledDir, BSDFEvent *event, const BSDFEvent requestedEvent MATERIALS_PARAM_DECL) {
	return MatteMaterial_ConstSample(hitPoint, fixedDir, sampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		passThroughEvent,
#endif
		pdfW,  cosSampledDir, event, requestedEvent, Texture_Index2_EvaluateSpectrum(&texs[2], hitPoint TEXTURES_PARAM));
}
#if defined(PARAM_HAS_PASSTHROUGH)
float3 Material_Index2_GetPassThroughTransparency(__global const Material *material, __global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return MatteMaterial_GetPassThroughTransparency(material, hitPoint, localFixedDir, passThroughEvent TEXTURES_PARAM);
}
#endif
float3 Material_Index2_GetEmittedRadiance(__global const Material *material, __global HitPoint *hitPoint, const float oneOverPrimitiveArea MATERIALS_PARAM_DECL) {
	return Material_GetEmittedRadianceNoMix(material, hitPoint TEXTURES_PARAM);
}
#if defined(PARAM_HAS_VOLUMES)
uint Material_Index2_GetInteriorVolume(__global const Material *material, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return Material_GetInteriorVolumeNoMix(material);
}
uint Material_Index2_GetExteriorVolume(__global const Material *material, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return Material_GetExteriorVolumeNoMix(material);
}
#endif
BSDFEvent Material_Index3_GetEventTypes(__global const Material *material MATERIALS_PARAM_DECL) {
	return MatteMaterial_GetEventTypes();
}
bool Material_Index3_IsDelta(__global const Material *material MATERIALS_PARAM_DECL) {
	return MatteMaterial_IsDelta();
}
float3 Material_Index3_Evaluate(__global const Material *material, __global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir, BSDFEvent *event, float *directPdfW MATERIALS_PARAM_DECL) {
	return MatteMaterial_ConstEvaluate(hitPoint, lightDir, eyeDir, event, directPdfW, Texture_Index3_EvaluateSpectrum(&texs[3], hitPoint TEXTURES_PARAM));
}
float3 Material_Index3_Sample(__global const Material *material, __global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir, const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
	const float passThroughEvent,
#endif
	float *pdfW, float *cosSampledDir, BSDFEvent *event, const BSDFEvent requestedEvent MATERIALS_PARAM_DECL) {
	return MatteMaterial_ConstSample(hitPoint, fixedDir, sampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		passThroughEvent,
#endif
		pdfW,  cosSampledDir, event, requestedEvent, Texture_Index3_EvaluateSpectrum(&texs[3], hitPoint TEXTURES_PARAM));
}
#if defined(PARAM_HAS_PASSTHROUGH)
float3 Material_Index3_GetPassThroughTransparency(__global const Material *material, __global HitPoint *hitPoint, const float3 localFixedDir, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return MatteMaterial_GetPassThroughTransparency(material, hitPoint, localFixedDir, passThroughEvent TEXTURES_PARAM);
}
#endif
float3 Material_Index3_GetEmittedRadiance(__global const Material *material, __global HitPoint *hitPoint, const float oneOverPrimitiveArea MATERIALS_PARAM_DECL) {
	return Material_GetEmittedRadianceNoMix(material, hitPoint TEXTURES_PARAM);
}
#if defined(PARAM_HAS_VOLUMES)
uint Material_Index3_GetInteriorVolume(__global const Material *material, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return Material_GetInteriorVolumeNoMix(material);
}
uint Material_Index3_GetExteriorVolume(__global const Material *material, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	return Material_GetExteriorVolumeNoMix(material);
}
#endif
BSDFEvent Material_GetEventTypes(const uint index MATERIALS_PARAM_DECL) {
	__global const Material *mat = &mats[index];
	switch (index) {
		case 0:
			return Material_Index0_GetEventTypes(mat MATERIALS_PARAM);
		case 1:
			return Material_Index1_GetEventTypes(mat MATERIALS_PARAM);
		case 2:
			return Material_Index2_GetEventTypes(mat MATERIALS_PARAM);
		case 3:
			return Material_Index3_GetEventTypes(mat MATERIALS_PARAM);
		default:
			return NONE;
	}
}
bool Material_IsDelta(const uint index MATERIALS_PARAM_DECL) {
	__global const Material *mat = &mats[index];
	switch (index) {
		case 0:
			return Material_Index0_IsDelta(mat MATERIALS_PARAM);
		case 1:
			return Material_Index1_IsDelta(mat MATERIALS_PARAM);
		case 2:
			return Material_Index2_IsDelta(mat MATERIALS_PARAM);
		case 3:
			return Material_Index3_IsDelta(mat MATERIALS_PARAM);
		default:
			return true;
	}
}
float3 Material_GetEmittedRadianceWithMix(const uint index, __global HitPoint *hitPoint, const float oneOverPrimitiveArea MATERIALS_PARAM_DECL) {
	__global const Material *mat = &mats[index];
	switch (index) {
		case 0:
			return Material_Index0_GetEmittedRadiance(mat, hitPoint, oneOverPrimitiveArea MATERIALS_PARAM);
		case 1:
			return Material_Index1_GetEmittedRadiance(mat, hitPoint, oneOverPrimitiveArea MATERIALS_PARAM);
		case 2:
			return Material_Index2_GetEmittedRadiance(mat, hitPoint, oneOverPrimitiveArea MATERIALS_PARAM);
		case 3:
			return Material_Index3_GetEmittedRadiance(mat, hitPoint, oneOverPrimitiveArea MATERIALS_PARAM);
		default:
			return BLACK;
	}
}
float3 Material_Evaluate(const uint index, __global HitPoint *hitPoint, const float3 lightDir, const float3 eyeDir, BSDFEvent *event, float *directPdfW MATERIALS_PARAM_DECL) {
	__global const Material *mat = &mats[index];
	switch (index) {
		case 0:
			return Material_Index0_Evaluate(mat, hitPoint, lightDir, eyeDir, event, directPdfW MATERIALS_PARAM);
		case 1:
			return Material_Index1_Evaluate(mat, hitPoint, lightDir, eyeDir, event, directPdfW MATERIALS_PARAM);
		case 2:
			return Material_Index2_Evaluate(mat, hitPoint, lightDir, eyeDir, event, directPdfW MATERIALS_PARAM);
		case 3:
			return Material_Index3_Evaluate(mat, hitPoint, lightDir, eyeDir, event, directPdfW MATERIALS_PARAM);
		default:
			return BLACK;
	}
}
float3 Material_Sample(const uint index, __global HitPoint *hitPoint, const float3 fixedDir, float3 *sampledDir, const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
	const float passThroughEvent,
#endif
	float *pdfW, float *cosSampledDir, BSDFEvent *event, const BSDFEvent requestedEvent MATERIALS_PARAM_DECL) {
	__global const Material *mat = &mats[index];
	switch (index) {
		case 0:
			return Material_Index0_Sample(mat, hitPoint, fixedDir, sampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
			passThroughEvent,
#endif
			pdfW,  cosSampledDir, event, requestedEvent MATERIALS_PARAM);
		case 1:
			return Material_Index1_Sample(mat, hitPoint, fixedDir, sampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
			passThroughEvent,
#endif
			pdfW,  cosSampledDir, event, requestedEvent MATERIALS_PARAM);
		case 2:
			return Material_Index2_Sample(mat, hitPoint, fixedDir, sampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
			passThroughEvent,
#endif
			pdfW,  cosSampledDir, event, requestedEvent MATERIALS_PARAM);
		case 3:
			return Material_Index3_Sample(mat, hitPoint, fixedDir, sampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
			passThroughEvent,
#endif
			pdfW,  cosSampledDir, event, requestedEvent MATERIALS_PARAM);
		default:
			return BLACK;
	}
}
#if defined(PARAM_HAS_BUMPMAPS)
void Material_Bump(const uint index,
		__global HitPoint *hitPoint
		MATERIALS_PARAM_DECL) {
	float3 shadeN = VLOAD3F(&hitPoint->shadeN.x);
	switch (index) {
		default:
			return;
	}

	// Update dpdu and dpdv so they are still orthogonal to shadeN
	float3 dpdu = VLOAD3F(&hitPoint->dpdu.x);
	float3 dpdv = VLOAD3F(&hitPoint->dpdv.x);
	dpdu = cross(shadeN, cross(dpdu, shadeN));
	dpdv = cross(shadeN, cross(dpdv, shadeN));
	// Update HitPoint structure
	VSTORE3F(shadeN, &hitPoint->shadeN.x);
	VSTORE3F(dpdu, &hitPoint->dpdu.x);
	VSTORE3F(dpdv, &hitPoint->dpdv.x);
}
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
float3 Material_GetPassThroughTransparency(const uint index, __global HitPoint *hitPoint, const float3 localFixedDir, const float oneOverPrimitiveArea MATERIALS_PARAM_DECL) {
	__global const Material *mat = &mats[index];
	switch (index) {
		case 0:
			return Material_Index0_GetPassThroughTransparency(mat, hitPoint, localFixedDir, oneOverPrimitiveArea MATERIALS_PARAM);
		case 1:
			return Material_Index1_GetPassThroughTransparency(mat, hitPoint, localFixedDir, oneOverPrimitiveArea MATERIALS_PARAM);
		case 2:
			return Material_Index2_GetPassThroughTransparency(mat, hitPoint, localFixedDir, oneOverPrimitiveArea MATERIALS_PARAM);
		case 3:
			return Material_Index3_GetPassThroughTransparency(mat, hitPoint, localFixedDir, oneOverPrimitiveArea MATERIALS_PARAM);
		default:
			return BLACK;
	}
}
#endif
#if defined(PARAM_HAS_VOLUMES)
uint Material_GetInteriorVolumeWithMix(const uint index, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	__global const Material *mat = &mats[index];
	switch (index) {
		case 0:
			return Material_Index0_GetInteriorVolume(mat, hitPoint, passThroughEvent MATERIALS_PARAM);
		case 1:
			return Material_Index1_GetInteriorVolume(mat, hitPoint, passThroughEvent MATERIALS_PARAM);
		case 2:
			return Material_Index2_GetInteriorVolume(mat, hitPoint, passThroughEvent MATERIALS_PARAM);
		case 3:
			return Material_Index3_GetInteriorVolume(mat, hitPoint, passThroughEvent MATERIALS_PARAM);
		default:
			return NULL_INDEX;
	}
}
uint Material_GetExteriorVolumeWithMix(const uint index, __global HitPoint *hitPoint, const float passThroughEvent MATERIALS_PARAM_DECL) {
	__global const Material *mat = &mats[index];
	switch (index) {
		case 0:
			return Material_Index0_GetExteriorVolume(mat, hitPoint, passThroughEvent MATERIALS_PARAM);
		case 1:
			return Material_Index1_GetExteriorVolume(mat, hitPoint, passThroughEvent MATERIALS_PARAM);
		case 2:
			return Material_Index2_GetExteriorVolume(mat, hitPoint, passThroughEvent MATERIALS_PARAM);
		case 3:
			return Material_Index3_GetExteriorVolume(mat, hitPoint, passThroughEvent MATERIALS_PARAM);
		default:
			return NULL_INDEX;
	}
}
#endif
float3 Material_GetEmittedRadiance(const uint matIndex,
		__global HitPoint *hitPoint, const float oneOverPrimitiveArea
		MATERIALS_PARAM_DECL) {
	__global const Material *material = &mats[matIndex];
	float3 result;
#if defined (PARAM_ENABLE_MAT_MIX)
	if (material->type == MIX)
		result = Material_GetEmittedRadianceWithMix(matIndex, hitPoint, oneOverPrimitiveArea
				MATERIALS_PARAM);
	else
#endif
#if defined (PARAM_ENABLE_MAT_MIX)
	if (material->type == GLOSSYCOATING)
		result = Material_GetEmittedRadianceWithMix(matIndex, hitPoint, oneOverPrimitiveArea
				MATERIALS_PARAM);
	else
#endif
		result = Material_GetEmittedRadianceNoMix(material, hitPoint
				TEXTURES_PARAM);
	return 	VLOAD3F(material->emittedFactor.c) * (material->usePrimitiveArea ? oneOverPrimitiveArea : 1.f) * result;
}
#if defined(PARAM_HAS_VOLUMES)
uint Material_GetInteriorVolume(const uint matIndex,
		__global HitPoint *hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
		, const float passThroughEvent
#endif
		MATERIALS_PARAM_DECL) {
	__global const Material *material = &mats[matIndex];
#if defined (PARAM_ENABLE_MAT_MIX)
	if (material->type == MIX)
		return Material_GetInteriorVolumeWithMix(matIndex, hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
			, passThroughEvent
#endif
			MATERIALS_PARAM);
	else
#endif
#if defined (PARAM_ENABLE_MAT_GLOSSYCOATING)
	if (material->type == GLOSSYCOATING)
		return Material_GetInteriorVolumeWithMix(matIndex, hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
			, passThroughEvent
#endif
			MATERIALS_PARAM);
	else
#endif
		return Material_GetInteriorVolumeNoMix(material);
}
uint Material_GetExteriorVolume(const uint matIndex,
		__global HitPoint *hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
		, const float passThroughEvent
#endif
		MATERIALS_PARAM_DECL) {
	__global const Material *material = &mats[matIndex];
#if defined (PARAM_ENABLE_MAT_MIX)
	if (material->type == MIX)
		return Material_GetExteriorVolumeWithMix(matIndex, hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
			, passThroughEvent
#endif
			MATERIALS_PARAM);
	else
#endif
#if defined (PARAM_ENABLE_MAT_GLOSSYCOATING)
	if (material->type == GLOSSYCOATING)
		return Material_GetExteriorVolumeWithMix(matIndex, hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
			, passThroughEvent
#endif
			MATERIALS_PARAM);
	else
#endif
		return Material_GetExteriorVolumeNoMix(material);
}
#endif

#line 2 "bsdfutils_funcs.cl"

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

BSDFEvent BSDF_GetEventTypes(__global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	return Material_GetEventTypes(bsdf->materialIndex
			MATERIALS_PARAM);
}

bool BSDF_IsDelta(__global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	return Material_IsDelta(bsdf->materialIndex
			MATERIALS_PARAM);
}

uint BSDF_GetMaterialID(__global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	return mats[bsdf->materialIndex].matID;
}

uint BSDF_GetLightID(__global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	return mats[bsdf->materialIndex].lightID;
}

#if defined(PARAM_HAS_VOLUMES)
uint BSDF_GetMaterialInteriorVolume(__global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	return Material_GetInteriorVolume(bsdf->materialIndex, &bsdf->hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
			, bsdf->hitPoint.passThroughEvent
#endif
			MATERIALS_PARAM);
}

uint BSDF_GetMaterialExteriorVolume(__global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	return Material_GetExteriorVolume(bsdf->materialIndex, &bsdf->hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
			, bsdf->hitPoint.passThroughEvent
#endif
			MATERIALS_PARAM);
}
#endif
#line 2 "volume_funcs.cl"

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

#if defined(PARAM_HAS_VOLUMES)

//------------------------------------------------------------------------------
// ClearVolume scatter
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_CLEAR_VOL)
float3 ClearVolume_SigmaA(__global const Volume *vol, __global HitPoint *hitPoint
	TEXTURES_PARAM_DECL) {
	const float3 sigmaA = Texture_GetSpectrumValue(vol->volume.clear.sigmaATexIndex, hitPoint
		TEXTURES_PARAM);

	return clamp(sigmaA, 0.f, INFINITY);
}

float3 ClearVolume_SigmaS(__global const Volume *vol, __global HitPoint *hitPoint
	TEXTURES_PARAM_DECL) {
	return BLACK;
}

float3 ClearVolume_SigmaT(__global const Volume *vol, __global HitPoint *hitPoint
	TEXTURES_PARAM_DECL) {
	return
			ClearVolume_SigmaA(vol, hitPoint
				TEXTURES_PARAM) +
			ClearVolume_SigmaS(vol, hitPoint
				TEXTURES_PARAM);
}

float ClearVolume_Scatter(__global const Volume *vol,
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		Ray *ray, const float hitT,
		const float passThroughEvent,
		const bool scatteredStart, float3 *connectionThroughput,
		float3 *connectionEmission, __global HitPoint *tmpHitPoint
		TEXTURES_PARAM_DECL) {
	// Initialize tmpHitPoint
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
	const float3 rayOrig = VLOAD3F(&ray->o.x);
	const float3 rayDir = VLOAD3F(&ray->d.x);
#else
	const float3 rayOrig = (float3)(ray->o.x, ray->o.y, ray->o.z);
	const float3 rayDir = (float3)(ray->d.x, ray->d.y, ray->d.z);
#endif
	VSTORE3F(rayDir, &tmpHitPoint->fixedDir.x);
	VSTORE3F(rayOrig, &tmpHitPoint->p.x);
	VSTORE2F((float2)(0.f, 0.f), &tmpHitPoint->uv.u);
	VSTORE3F(-rayDir, &tmpHitPoint->geometryN.x);
	VSTORE3F(-rayDir, &tmpHitPoint->shadeN.x);
#if defined(PARAM_HAS_BUMPMAPS)
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dpdu.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dpdv.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dndu.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dndv.x);
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTCOLOR) || defined(PARAM_ENABLE_TEX_HITPOINTGREY) || defined(PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR)
	VSTORE3F(WHITE, tmpHitPoint->color.c);
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTALPHA)
	VSTORE2F(1.f, &tmpHitPoint->alpha);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	tmpHitPoint->passThroughEvent = passThroughEvent;
#endif
	tmpHitPoint->interiorVolumeIndex = NULL_INDEX;
	tmpHitPoint->exteriorVolumeIndex = NULL_INDEX;
	tmpHitPoint->intoObject = true;

	const float distance = hitT - ray->mint;
	float3 transmittance = WHITE;

	const float3 sigmaT = ClearVolume_SigmaT(vol, tmpHitPoint
			TEXTURES_PARAM);
	if (!Spectrum_IsBlack(sigmaT)) {
		const float3 tau = clamp(distance * sigmaT, 0.f, INFINITY);
		transmittance = Spectrum_Exp(-tau);
	}

	// Apply volume transmittance
	*connectionThroughput *= transmittance;

	// Apply volume emission
	const uint emiTexIndex = vol->volume.volumeEmissionTexIndex;
	if (emiTexIndex != NULL_INDEX) {
		const float3 emiTex = Texture_GetSpectrumValue(emiTexIndex, tmpHitPoint
			TEXTURES_PARAM);
		*connectionEmission += *connectionThroughput * distance * clamp(emiTex, 0.f, INFINITY);
	}

	return -1.f;
}
#endif

//------------------------------------------------------------------------------
// HomogeneousVolume scatter
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_HOMOGENEOUS_VOL)
float3 HomogeneousVolume_SigmaA(__global const Volume *vol, __global HitPoint *hitPoint
	TEXTURES_PARAM_DECL) {
	const float3 sigmaA = Texture_GetSpectrumValue(vol->volume.homogenous.sigmaATexIndex, hitPoint
		TEXTURES_PARAM);

	return clamp(sigmaA, 0.f, INFINITY);
}

float3 HomogeneousVolume_SigmaS(__global const Volume *vol, __global HitPoint *hitPoint
	TEXTURES_PARAM_DECL) {
	const float3 sigmaS = Texture_GetSpectrumValue(vol->volume.homogenous.sigmaSTexIndex, hitPoint
		TEXTURES_PARAM);

	return clamp(sigmaS, 0.f, INFINITY);
}

float HomogeneousVolume_Scatter(__global const Volume *vol,
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		Ray *ray, const float hitT,
		const float passThroughEvent,
		const bool scatteredStart, float3 *connectionThroughput,
		float3 *connectionEmission, __global HitPoint *tmpHitPoint
		TEXTURES_PARAM_DECL) {
	// Initialize tmpHitPoint
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
	const float3 rayOrig = VLOAD3F(&ray->o.x);
	const float3 rayDir = VLOAD3F(&ray->d.x);
#else
	const float3 rayOrig = (float3)(ray->o.x, ray->o.y, ray->o.z);
	const float3 rayDir = (float3)(ray->d.x, ray->d.y, ray->d.z);
#endif
	VSTORE3F(rayDir, &tmpHitPoint->fixedDir.x);
	VSTORE3F(rayOrig, &tmpHitPoint->p.x);
	VSTORE2F((float2)(0.f, 0.f), &tmpHitPoint->uv.u);
	VSTORE3F(-rayDir, &tmpHitPoint->geometryN.x);
	VSTORE3F(-rayDir, &tmpHitPoint->shadeN.x);
#if defined(PARAM_HAS_BUMPMAPS)
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dpdu.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dpdv.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dndu.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dndv.x);
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTCOLOR) || defined(PARAM_ENABLE_TEX_HITPOINTGREY) || defined(PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR)
	VSTORE3F(WHITE, tmpHitPoint->color.c);
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTALPHA)
	VSTORE2F(1.f, &tmpHitPoint->alpha);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	tmpHitPoint->passThroughEvent = passThroughEvent;
#endif
	tmpHitPoint->interiorVolumeIndex = NULL_INDEX;
	tmpHitPoint->exteriorVolumeIndex = NULL_INDEX;
	tmpHitPoint->intoObject = true;

	const float maxDistance = hitT - ray->mint;

	// Check if I have to support multi-scattering
	const bool scatterAllowed = (!scatteredStart || vol->volume.homogenous.multiScattering);

	bool scatter = false;
	float distance = maxDistance;
	// I'm missing Texture::Filter() in OpenCL
	//const float k = sigmaS->Filter();
	const float3 sigmaS = HomogeneousVolume_SigmaS(vol, tmpHitPoint
			TEXTURES_PARAM);
	const float k = Spectrum_Filter(sigmaS);
	if (scatterAllowed && (k > 0.f)) {
		// Determine scattering distance
		const float scatterDistance = -log(1.f - passThroughEvent) / k;

		scatter = scatterAllowed && (scatterDistance < maxDistance);
		distance = scatter ? scatterDistance : maxDistance;

		// Note: distance can not be infinity because otherwise there would
		// have been a scatter event before.
		const float pdf = exp(-distance * k) * (scatter ? k : 1.f);
		*connectionThroughput /= pdf;
	}

	const float3 sigmaT = HomogeneousVolume_SigmaA(vol, tmpHitPoint
			TEXTURES_PARAM) + sigmaS;
	if (!Spectrum_IsBlack(sigmaT)) {
		const float3 tau = clamp(distance * sigmaT, 0.f, INFINITY);
		const float3 transmittance = Spectrum_Exp(-tau);

		// Apply volume transmittance
		*connectionThroughput *= transmittance * (scatter ? sigmaT : WHITE);
	}

	// Apply volume emission
	const uint emiTexIndex = vol->volume.volumeEmissionTexIndex;
	if (emiTexIndex != NULL_INDEX) {
		const float3 emiTex = Texture_GetSpectrumValue(emiTexIndex, tmpHitPoint
			TEXTURES_PARAM);
		*connectionEmission += *connectionThroughput * distance * clamp(emiTex, 0.f, INFINITY);
	}

	return scatter ? (ray->mint + distance) : -1.f;
}
#endif

//------------------------------------------------------------------------------
// HomogeneousVolume scatter
//------------------------------------------------------------------------------

#if defined (PARAM_ENABLE_MAT_HETEROGENEOUS_VOL)
float3 HeterogeneousVolume_SigmaA(__global const Volume *vol, __global HitPoint *hitPoint
	TEXTURES_PARAM_DECL) {
	const float3 sigmaA = Texture_GetSpectrumValue(vol->volume.heterogenous.sigmaATexIndex, hitPoint
		TEXTURES_PARAM);

	return clamp(sigmaA, 0.f, INFINITY);
}

float3 HeterogeneousVolume_SigmaS(__global const Volume *vol, __global HitPoint *hitPoint
	TEXTURES_PARAM_DECL) {
	const float3 sigmaS = Texture_GetSpectrumValue(vol->volume.heterogenous.sigmaSTexIndex, hitPoint
		TEXTURES_PARAM);

	return clamp(sigmaS, 0.f, INFINITY);
}

float3 HeterogeneousVolume_SigmaT(__global const Volume *vol, __global HitPoint *hitPoint
	TEXTURES_PARAM_DECL) {
	return HeterogeneousVolume_SigmaA(vol, hitPoint TEXTURES_PARAM) +
			HeterogeneousVolume_SigmaS(vol, hitPoint TEXTURES_PARAM);
}

float HeterogeneousVolume_Scatter(__global const Volume *vol,
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		Ray *ray, const float hitT,
		const float passThroughEvent,
		const bool scatteredStart, float3 *connectionThroughput,
		float3 *connectionEmission, __global HitPoint *tmpHitPoint
		TEXTURES_PARAM_DECL) {
	// Compute the number of steps to evaluate the volume
	// Integrates in steps of at most stepSize
	// unless stepSize is too small compared to the total length
	const float mint = ray->mint;
	const float rayLen = hitT - mint;

	//--------------------------------------------------------------------------
	// Handle the case when hitT is infinity or a very large number
	//--------------------------------------------------------------------------

	const float stepSize = vol->volume.heterogenous.stepSize;
	const uint maxStepsCount = vol->volume.heterogenous.maxStepsCount;
	uint steps;
	float ss;
	if (rayLen == INFINITY) {
		steps = maxStepsCount;
		ss = stepSize;
	} else {
		// Note: Ceil2UInt() of an out of range number is 0
		const float fsteps = rayLen / fmax(MachineEpsilon_E(rayLen), stepSize);
		if (fsteps >= maxStepsCount)
			steps = maxStepsCount;
		else
			steps = Ceil2UInt(fsteps);

		ss = rayLen / steps; // Effective step size
	}

	const float totalDistance = ss * steps;

	// Evaluate the scattering at the path origin

	// Initialize tmpHitPoint
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
	const float3 rayOrig = VLOAD3F(&ray->o.x);
	const float3 rayDir = VLOAD3F(&ray->d.x);
#else
	const float3 rayOrig = (float3)(ray->o.x, ray->o.y, ray->o.z);
	const float3 rayDir = (float3)(ray->d.x, ray->d.y, ray->d.z);
#endif
	VSTORE3F(rayDir, &tmpHitPoint->fixedDir.x);
	VSTORE3F(rayOrig + mint * rayDir, &tmpHitPoint->p.x);
	VSTORE2F((float2)(0.f, 0.f), &tmpHitPoint->uv.u);
	VSTORE3F(-rayDir, &tmpHitPoint->geometryN.x);
	VSTORE3F(-rayDir, &tmpHitPoint->shadeN.x);
#if defined(PARAM_HAS_BUMPMAPS)
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dpdu.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dpdv.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dndu.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &tmpHitPoint->dndv.x);
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTCOLOR) || defined(PARAM_ENABLE_TEX_HITPOINTGREY) || defined(PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR)
	VSTORE3F(WHITE, tmpHitPoint->color.c);
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTALPHA)
	VSTORE2F(1.f, &tmpHitPoint->alpha);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	tmpHitPoint->passThroughEvent = passThroughEvent;
#endif
	tmpHitPoint->interiorVolumeIndex = NULL_INDEX;
	tmpHitPoint->exteriorVolumeIndex = NULL_INDEX;
	tmpHitPoint->intoObject = true;

	const bool scatterAllowed = (!scatteredStart || vol->volume.heterogenous.multiScattering);

	//--------------------------------------------------------------------------
	// Find the scattering point if there is one
	//--------------------------------------------------------------------------

	float oldSigmaS = Spectrum_Filter(HeterogeneousVolume_SigmaS(vol, tmpHitPoint
			TEXTURES_PARAM));
	float u = passThroughEvent;
	float scatterDistance = totalDistance;
	float t = -1.f;
	float pdf = 1.f;
	for (uint s = 1; s <= steps; ++s) {
		// Compute the mean scattering over the current step
		VSTORE3F(rayOrig + (mint + s * ss) * rayDir, &tmpHitPoint->p.x);

		// Check if there is a scattering event
		const float newSigmaS = Spectrum_Filter(HeterogeneousVolume_SigmaS(vol, tmpHitPoint
			TEXTURES_PARAM));
		const float halfWaySigmaS = (oldSigmaS + newSigmaS) * .5f;
		oldSigmaS = newSigmaS;

		// Skip the step if no scattering can occur
		if (halfWaySigmaS <= 0.f)
			continue;

		// Determine scattering distance
		const float d = log(1.f - u) / halfWaySigmaS; // The real distance is ray.mint-d
		const bool scatter = scatterAllowed && (d > (s - 1U) * ss - totalDistance);
		if (!scatter) {
			if (scatterAllowed)
				pdf *= exp(-ss * halfWaySigmaS);

			// Update the random variable to account for
			// the current step
			u -= (1.f - u) * (exp(oldSigmaS * ss) - 1.f);
			continue;
		}

		// The ray is scattered
		scatterDistance = (s - 1U) * ss - d;
		t = mint + scatterDistance;
		pdf *= exp(d * halfWaySigmaS) * oldSigmaS;

		VSTORE3F(rayOrig + t * rayDir, &tmpHitPoint->p.x);
		*connectionThroughput *= HeterogeneousVolume_SigmaT(vol, tmpHitPoint
				TEXTURES_PARAM);
		break;
	}

	//--------------------------------------------------------------------------
	// Now I know the distance of the scattering point (if there is one) and
	// I can calculate transmittance and emission
	//--------------------------------------------------------------------------

	steps = Ceil2UInt(scatterDistance / fmax(MachineEpsilon_E(scatterDistance), stepSize));
	ss = scatterDistance / steps;

	float3 tau = BLACK;
	float3 emission = BLACK;
	VSTORE3F(rayOrig + mint * rayDir, &tmpHitPoint->p.x);
	float3 oldSigmaT = HeterogeneousVolume_SigmaT(vol, tmpHitPoint
			TEXTURES_PARAM);
	const uint emiTexIndex = vol->volume.volumeEmissionTexIndex;
	for (uint s = 1; s <= steps; ++s) {
		VSTORE3F(rayOrig + (mint + s * ss) * rayDir, &tmpHitPoint->p.x);

		// Accumulate tau values
		const float3 newSigmaT = HeterogeneousVolume_SigmaT(vol, tmpHitPoint
				TEXTURES_PARAM);
		const float3 halfWaySigmaT = (oldSigmaT + newSigmaT) * .5f;
		tau += clamp(ss * halfWaySigmaT, 0.f, INFINITY);
		oldSigmaT = newSigmaT;

		// Accumulate volume emission
		if (emiTexIndex != NULL_INDEX) {
			const float3 emiTex = Texture_GetSpectrumValue(emiTexIndex, tmpHitPoint
				TEXTURES_PARAM);
			emission += Spectrum_Exp(-tau) * (ss * clamp(emiTex, 0.f, INFINITY));
		}
	}

	// Apply volume transmittance
	const float3 transmittance = Spectrum_Exp(-tau);
	*connectionThroughput *= transmittance / pdf;

	// Add volume emission
	*connectionEmission += *connectionThroughput * emission;

	return t;
}
#endif

//------------------------------------------------------------------------------
// Volume scatter
//------------------------------------------------------------------------------

float Volume_Scatter(__global const Volume *vol,
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		Ray *ray, const float hitT,
		const float passThrough,
		const bool scatteredStart, float3 *connectionThroughput,
		float3 *connectionEmission, __global HitPoint *tmpHitPoint
		TEXTURES_PARAM_DECL) {
	switch (vol->type) {
#if defined (PARAM_ENABLE_MAT_CLEAR_VOL)
		case CLEAR_VOL:
			return ClearVolume_Scatter(vol, ray, hitT,
					passThrough, scatteredStart,
					connectionThroughput, connectionEmission, tmpHitPoint
					TEXTURES_PARAM);
#endif
#if defined (PARAM_ENABLE_MAT_HOMOGENEOUS_VOL)
		case HOMOGENEOUS_VOL:
			return HomogeneousVolume_Scatter(vol, ray, hitT,
					passThrough, scatteredStart,
					connectionThroughput, connectionEmission, tmpHitPoint
					TEXTURES_PARAM);
#endif
#if defined (PARAM_ENABLE_MAT_HETEROGENEOUS_VOL)
		case HETEROGENEOUS_VOL:
			return HeterogeneousVolume_Scatter(vol, ray, hitT,
					passThrough, scatteredStart,
					connectionThroughput, connectionEmission, tmpHitPoint
					TEXTURES_PARAM);
#endif
		default:
			return -1.f;
	}
}

#endif
#line 2 "volumeinfo_funcs.cl"

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

#if defined(PARAM_HAS_VOLUMES)

//------------------------------------------------------------------------------
// PathVolumeInfo
//------------------------------------------------------------------------------

void PathVolumeInfo_Init(__global PathVolumeInfo *pvi) {
	pvi->currentVolumeIndex = NULL_INDEX;
	pvi->volumeIndexListSize = 0;

	pvi->scatteredStart = false;
}

void PathVolumeInfo_AddVolume(__global PathVolumeInfo *pvi, const uint volIndex
		MATERIALS_PARAM_DECL) {
	if ((volIndex == NULL_INDEX) || (pvi->volumeIndexListSize == OPENCL_PATHVOLUMEINFO_SIZE)) {
		// NULL volume or out of space, I just ignore the volume
		return;
	}

	// Update the current volume. ">=" because I want to catch the last added volume.
	if ((pvi->currentVolumeIndex == NULL_INDEX) ||
			(mats[volIndex].volume.priority >= mats[pvi->currentVolumeIndex].volume.priority))
		pvi->currentVolumeIndex = volIndex;

	// Add the volume to the list
	pvi->volumeIndexList[(pvi->volumeIndexListSize)++] = volIndex;
}

void PathVolumeInfo_RemoveVolume(__global PathVolumeInfo *pvi, const uint volIndex
		MATERIALS_PARAM_DECL) {
	if ((volIndex == NULL_INDEX) || (pvi->volumeIndexListSize == 0)) {
		// NULL volume or empty volume list
		return;
	}

	// Update the current volume and the list
	bool found = false;
	uint newCurrentVolumeIndex = NULL_INDEX;
	for (uint i = 0; i < pvi->volumeIndexListSize; ++i) {
		if (found) {
			// Re-compact the list
			pvi->volumeIndexList[i - 1] = pvi->volumeIndexList[i];
		} else if (pvi->volumeIndexList[i] == volIndex) {
			// Found the volume to remove
			found = true;
			continue;
		}

		// Update currentVolume. ">=" because I want to catch the last added volume.
		if ((newCurrentVolumeIndex == NULL_INDEX) ||
				(mats[pvi->volumeIndexList[i]].volume.priority >= mats[newCurrentVolumeIndex].volume.priority))
			newCurrentVolumeIndex = pvi->volumeIndexList[i];
	}
	pvi->currentVolumeIndex = newCurrentVolumeIndex;

	// Update the list size
	--(pvi->volumeIndexListSize);
}

uint PathVolumeInfo_SimulateAddVolume(__global PathVolumeInfo *pvi, const uint volIndex
		MATERIALS_PARAM_DECL) {
	// A volume wins over current if and only if it is the same volume or has an
	// higher priority

	const uint currentVolumeIndex = pvi->currentVolumeIndex;
	if (currentVolumeIndex != NULL_INDEX) {
		if (volIndex != NULL_INDEX) {
			return (mats[currentVolumeIndex].volume.priority > mats[volIndex].volume.priority) ? currentVolumeIndex : volIndex;
		} else
			return pvi->currentVolumeIndex;
	} else
		return volIndex;
}

uint PathVolumeInfo_SimulateRemoveVolume(__global PathVolumeInfo *pvi, const uint volIndex
		MATERIALS_PARAM_DECL) {
	if ((volIndex == NULL_INDEX) || (pvi->volumeIndexListSize == 0)) {
		// NULL volume or empty volume list
		return pvi->currentVolumeIndex;
	}

	// Update the current volume
	bool found = false;
	uint newCurrentVolumeIndex = NULL_INDEX;
	for (uint i = 0; i < pvi->volumeIndexListSize; ++i) {
		if ((!found) && (pvi->volumeIndexList[i] == volIndex)) {
			// Found the volume to remove
			found = true;
			continue;
		}

		// Update currentVolume. ">=" because I want to catch the last added volume.
		if ((newCurrentVolumeIndex == NULL_INDEX) ||
				(mats[pvi->volumeIndexList[i]].volume.priority >= mats[newCurrentVolumeIndex].volume.priority))
			newCurrentVolumeIndex = pvi->volumeIndexList[i];
	}

	return newCurrentVolumeIndex;
}

void PathVolumeInfo_Update(__global PathVolumeInfo *pvi, const BSDFEvent eventType,
		__global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	// Update only if it isn't a volume scattering and the material can TRANSMIT
	if (bsdf->isVolume)
		pvi->scatteredStart = true;
	else {
		pvi->scatteredStart = false;

		if(eventType & TRANSMIT) {
			const uint volIndex = BSDF_GetMaterialInteriorVolume(bsdf
					MATERIALS_PARAM);

			if (bsdf->hitPoint.intoObject)
				PathVolumeInfo_AddVolume(pvi, volIndex
						MATERIALS_PARAM);
			else
				PathVolumeInfo_RemoveVolume(pvi, volIndex
						MATERIALS_PARAM);
		}
	}
}

bool PathVolumeInfo_CompareVolumePriorities(const uint vol1Index, const uint vol2Index
	MATERIALS_PARAM_DECL) {
	// A volume wins over another if and only if it is the same volume or has an
	// higher priority

	if (vol1Index != NULL_INDEX) {
		if (vol2Index != NULL_INDEX) {
			if (vol1Index == vol2Index)
				return true;
			else
				return (mats[vol1Index].volume.priority > mats[vol2Index].volume.priority);
		} else
			return false;
	} else
		return false;
}

bool PathVolumeInfo_ContinueToTrace(__global PathVolumeInfo *pvi, __global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	// Check if the volume priority system has to be applied
	if (BSDF_GetEventTypes(bsdf
			MATERIALS_PARAM) & TRANSMIT) {
		// Ok, the surface can transmit so check if volume priority
		// system is telling me to continue to trace the ray

		// I have to continue to trace the ray if:
		//
		// 1) I'm entering an object and the interior volume has a
		// lower priority than the current one (or is the same volume).
		//
		// 2) I'm exiting an object and I'm not leaving the current volume.

		const bool intoObject = bsdf->hitPoint.intoObject;
		const uint bsdfInteriorVolIndex = BSDF_GetMaterialInteriorVolume(bsdf
			MATERIALS_PARAM);

		// Condition #1
		if (intoObject && PathVolumeInfo_CompareVolumePriorities(pvi->currentVolumeIndex, bsdfInteriorVolIndex
				MATERIALS_PARAM))
			return true;

		// Condition #2
		//
		// I have to calculate the potentially new currentVolume in order
		// to check if I'm leaving the current one
		if ((!intoObject) && (pvi->currentVolumeIndex != NULL_INDEX) &&
				(PathVolumeInfo_SimulateRemoveVolume(pvi, bsdfInteriorVolIndex
					MATERIALS_PARAM) == pvi->currentVolumeIndex))
			return true;
	}

	return false;
}

void PathVolumeInfo_SetHitPointVolumes(__global PathVolumeInfo *pvi,
		__global HitPoint *hitPoint,
		const uint matInteriorVolumeIndex,
		const uint matExteriorVolumeIndex
		MATERIALS_PARAM_DECL) {
	// Set interior and exterior volumes

	uint interiorVolumeIndex, exteriorVolumeIndex;
	const uint currentVolumeIndex = pvi->currentVolumeIndex;
	if (hitPoint->intoObject) {
		// From outside to inside the object

		interiorVolumeIndex = PathVolumeInfo_SimulateAddVolume(pvi, matInteriorVolumeIndex
				MATERIALS_PARAM);

		if (currentVolumeIndex == NULL_INDEX)
			exteriorVolumeIndex = matExteriorVolumeIndex;
		else {
			// if (!material->GetExteriorVolume()) there may be conflict here
			// between the material definition and the currentVolume value.
			// The currentVolume value wins.
			exteriorVolumeIndex = currentVolumeIndex;
		}

		if (exteriorVolumeIndex == NULL_INDEX) {
			// No volume information, I use the default volume
			exteriorVolumeIndex = SCENE_DEFAULT_VOLUME_INDEX;
		}
	} else {
		// From inside to outside the object

		if (currentVolumeIndex == NULL_INDEX)
			interiorVolumeIndex = matInteriorVolumeIndex;
		else {
			// if (!material->GetInteriorVolume()) there may be conflict here
			// between the material definition and the currentVolume value.
			// The currentVolume value wins.
			interiorVolumeIndex = currentVolumeIndex;
		}

		if (interiorVolumeIndex == NULL_INDEX) {
			// No volume information, I use the default volume
			interiorVolumeIndex = SCENE_DEFAULT_VOLUME_INDEX;
		}

		exteriorVolumeIndex = PathVolumeInfo_SimulateRemoveVolume(pvi, matInteriorVolumeIndex
				MATERIALS_PARAM);
	}

	hitPoint->interiorVolumeIndex = interiorVolumeIndex;
	hitPoint->exteriorVolumeIndex = exteriorVolumeIndex;

	hitPoint->interiorIorTexIndex = (interiorVolumeIndex != NULL_INDEX) ?
		mats[interiorVolumeIndex].volume.iorTexIndex : NULL_INDEX;
	hitPoint->exteriorIorTexIndex = (exteriorVolumeIndex != NULL_INDEX) ?
		mats[exteriorVolumeIndex].volume.iorTexIndex : NULL_INDEX;
}

#endif
#line 2 "camera_funcs.cl"

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

#if defined(PARAM_CAMERA_ENABLE_OCULUSRIFT_BARREL)
void Camera_OculusRiftBarrelPostprocess(const float x, const float y, float *barrelX, float *barrelY) {
	// Express the sample in coordinates relative to the eye center
	float ex = x * 2.f - 1.f;
	float ey = y * 2.f - 1.f;

	if ((ex == 0.f) && (ey == 0.f)) {
		*barrelX = 0.f;
		*barrelY = 0.f;
		return;
	}

	// Distance from the eye center
	const float distance = sqrt(ex * ex + ey * ey);

	// "Push" the sample away base on the distance from the center
	const float scale = 1.f / 1.4f;
	const float k0 = 1.f;
	const float k1 = .22f;
	const float k2 = .23f;
	const float k3 = 0.f;
	const float distance2 = distance * distance;
	const float distance4 = distance2 * distance2;
	const float distance6 = distance2 * distance4;
	const float fr = scale * (k0 + k1 * distance2 + k2 * distance4 + k3 * distance6);

	ex *= fr;
	ey *= fr;

	// Clamp the coordinates
	ex = clamp(ex, -1.f, 1.f);
	ey = clamp(ey, -1.f, 1.f);

	*barrelX = (ex + 1.f) * .5f;
	*barrelY = (ey + 1.f) * .5f;
}
#endif

#if defined(PARAM_CAMERA_ENABLE_CLIPPING_PLANE)
void Camera_ApplyArbitraryClippingPlane(
		__global const Camera* restrict camera,
#if !defined(CAMERA_GENERATERAY_PARAM_MEM_SPACE_PRIVATE)
		__global
#endif
		Ray *ray) {
	const float3 rayOrig = (float3)(ray->o.x, ray->o.y, ray->o.z);
	const float3 rayDir = (float3)(ray->d.x, ray->d.y, ray->d.z);

	const float3 clippingPlaneCenter = (float3)(camera->clippingPlaneCenter.x, camera->clippingPlaneCenter.y, camera->clippingPlaneCenter.z);
	const float3 clippingPlaneNormal = (float3)(camera->clippingPlaneNormal.x, camera->clippingPlaneNormal.y, camera->clippingPlaneNormal.z);

	// Intersect the ray with clipping plane
	const float denom = dot(clippingPlaneNormal, rayDir);
	const float3 pr = clippingPlaneCenter - rayOrig;
	float d = dot(pr, clippingPlaneNormal);

	if (fabs(denom) > DEFAULT_COS_EPSILON_STATIC) {
		// There is a valid intersection
		d /= denom;

		if (d > 0.f) {
			// The plane is in front of the camera
			if (denom < 0.f) {
				// The plane points toward the camera
				ray->maxt = clamp(d, ray->mint, ray->maxt);
			} else {
				// The plane points away from the camera
				ray->mint = clamp(d, ray->mint, ray->maxt);
			}
		} else {
			if ((denom < 0.f) && (d < 0.f)) {
				// No intersection possible, I use a trick here to avoid any
				// intersection by setting mint=maxt
				ray->mint = ray->maxt;
			} else {
				// Nothing to do
			}
		}
	} else {
		// The plane is parallel to the view directions. Check if I'm on the
		// visible side of the plane or not
		if (d >= 0.f) {
			// No intersection possible, I use a trick here to avoid any
			// intersection by setting mint=maxt
			ray->mint = ray->maxt;
		} else {
			// Nothing to do
		}
	}
}
#endif

//------------------------------------------------------------------------------
// Perspective camera
//------------------------------------------------------------------------------

#if (PARAM_CAMERA_TYPE == 0)

void Camera_GenerateRay(
		__global const Camera* restrict camera,
		const uint filmWidth, const uint filmHeight,
#if !defined(CAMERA_GENERATERAY_PARAM_MEM_SPACE_PRIVATE)
		__global
#endif
		Ray *ray,
		const float filmX, const float filmY, const float timeSample
#if defined(PARAM_CAMERA_HAS_DOF)
		, const float dofSampleX, const float dofSampleY
#endif
		) {
#if defined(PARAM_CAMERA_ENABLE_OCULUSRIFT_BARREL)
	float ssx, ssy;
	Camera_OculusRiftBarrelPostprocess(filmX / filmWidth, (filmHeight - filmY - 1.f) / filmHeight, &ssx, &ssy);
	const float3 Pras = (float3) (min(ssx * filmWidth, (float) (filmWidth - 1)), min(ssy * filmHeight, (float) (filmHeight - 1)), 0.f);
#else
	const float3 Pras = (float3) (filmX, filmHeight - filmY - 1.f, 0.f);
#endif

	float3 rayOrig = Transform_ApplyPoint(&camera->base.rasterToCamera, Pras);
	float3 rayDir = rayOrig;

	const float hither = camera->base.hither;

#if defined(PARAM_CAMERA_HAS_DOF)
	// Sample point on lens
	float lensU, lensV;
	ConcentricSampleDisk(dofSampleX, dofSampleY, &lensU, &lensV);
	const float lensRadius = camera->persp.projCamera.lensRadius;
	lensU *= lensRadius;
	lensV *= lensRadius;

	// Compute point on plane of focus
	const float focalDistance = camera->persp.projCamera.focalDistance;
	const float dist = focalDistance - hither;

	const float ft = dist / rayDir.z;
	const float3 Pfocus = rayOrig + rayDir * ft;

	// Update ray for effect of lens
	const float k = dist / focalDistance;
	rayOrig.x += lensU * k;
	rayOrig.y += lensV * k;

	rayDir = Pfocus - rayOrig;
#endif

	rayDir = normalize(rayDir);

	const float maxt = (camera->base.yon - hither) / rayDir.z;
	const float time = mix(camera->base.shutterOpen, camera->base.shutterClose, timeSample);

	// Transform ray in world coordinates
	rayOrig = Transform_ApplyPoint(&camera->base.cameraToWorld, rayOrig);
	rayDir = Transform_ApplyVector(&camera->base.cameraToWorld, rayDir);

	const uint interpolatedTransformFirstIndex = camera->base.motionSystem.interpolatedTransformFirstIndex;
	if (interpolatedTransformFirstIndex != NULL_INDEX) {
		Matrix4x4 m;
		MotionSystem_Sample(&camera->base.motionSystem, time, camera->base.interpolatedTransforms, &m);

		rayOrig = Matrix4x4_ApplyPoint_Private(&m, rayOrig);
		rayDir = Matrix4x4_ApplyVector_Private(&m, rayDir);
	}

#if defined(CAMERA_GENERATERAY_PARAM_MEM_SPACE_PRIVATE)
	Ray_Init3_Private(ray, rayOrig, rayDir, maxt, time);
#else
	Ray_Init3(ray, rayOrig, rayDir, maxt, time);
#endif

#if defined(PARAM_CAMERA_ENABLE_CLIPPING_PLANE)
	Camera_ApplyArbitraryClippingPlane(camera, ray);
#endif

	/*printf("(%f, %f, %f) (%f, %f, %f) [%f, %f]\n",
		ray->o.x, ray->o.y, ray->o.z, ray->d.x, ray->d.y, ray->d.z,
		ray->mint, ray->maxt);*/
}

#endif

//------------------------------------------------------------------------------
// Orthographic camera
//------------------------------------------------------------------------------

#if (PARAM_CAMERA_TYPE == 1)

void Camera_GenerateRay(
		__global const Camera* restrict camera,
		const uint filmWidth, const uint filmHeight,
#if !defined(CAMERA_GENERATERAY_PARAM_MEM_SPACE_PRIVATE)
		__global
#endif
		Ray *ray,
		const float filmX, const float filmY, const float timeSample
#if defined(PARAM_CAMERA_HAS_DOF)
		, const float dofSampleX, const float dofSampleY
#endif
		) {
	const float3 Pras = (float3) (filmX, filmHeight - filmY - 1.f, 0.f);
	float3 rayOrig = Transform_ApplyPoint(&camera->base.rasterToCamera, Pras);
	float3 rayDir = (float3)(0.f, 0.f, 1.f);

	const float hither = camera->base.hither;

#if defined(PARAM_CAMERA_HAS_DOF)
	// Sample point on lens
	float lensU, lensV;
	ConcentricSampleDisk(dofSampleX, dofSampleY, &lensU, &lensV);
	const float lensRadius = camera->ortho.projCamera.lensRadius;
	lensU *= lensRadius;
	lensV *= lensRadius;

	// Compute point on plane of focus
	const float focalDistance = camera->ortho.projCamera.focalDistance;
	const float dist = focalDistance - hither;

	const float ft = dist;
	const float3 Pfocus = rayOrig + rayDir * ft;

	// Update ray for effect of lens
	const float k = dist / focalDistance;
	rayOrig.x += lensU * k;
	rayOrig.y += lensV * k;

	rayDir = Pfocus - rayOrig;
#endif

	rayDir = normalize(rayDir);

	const float maxt = (camera->base.yon - hither);
	const float time = mix(camera->base.shutterOpen, camera->base.shutterClose, timeSample);

	// Transform ray in world coordinates
	rayOrig = Transform_ApplyPoint(&camera->base.cameraToWorld, rayOrig);
	rayDir = Transform_ApplyVector(&camera->base.cameraToWorld, rayDir);

	const uint interpolatedTransformFirstIndex = camera->base.motionSystem.interpolatedTransformFirstIndex;
	if (interpolatedTransformFirstIndex != NULL_INDEX) {
		Matrix4x4 m;
		MotionSystem_Sample(&camera->base.motionSystem, time, camera->base.interpolatedTransforms, &m);

		rayOrig = Matrix4x4_ApplyPoint_Private(&m, rayOrig);
		rayDir = Matrix4x4_ApplyVector_Private(&m, rayDir);
	}

#if defined(CAMERA_GENERATERAY_PARAM_MEM_SPACE_PRIVATE)
	Ray_Init3_Private(ray, rayOrig, rayDir, maxt, time);
#else
	Ray_Init3(ray, rayOrig, rayDir, maxt, time);
#endif

#if defined(PARAM_CAMERA_ENABLE_CLIPPING_PLANE)
	Camera_ApplyArbitraryClippingPlane(camera, ray);
#endif

	/*printf("(%f, %f, %f) (%f, %f, %f) [%f, %f]\n",
		ray->o.x, ray->o.y, ray->o.z, ray->d.x, ray->d.y, ray->d.z,
		ray->mint, ray->maxt);*/
}

#endif

//------------------------------------------------------------------------------
// Stereo camera
//------------------------------------------------------------------------------

#if (PARAM_CAMERA_TYPE == 2)

void Camera_GenerateRay(
		__global const Camera* restrict camera,
		const uint origFilmWidth, const uint filmHeight,
#if !defined(CAMERA_GENERATERAY_PARAM_MEM_SPACE_PRIVATE)
		__global
#endif
		Ray *ray,
		const float origFilmX, const float filmY, const float timeSample
#if defined(PARAM_CAMERA_HAS_DOF)
		, const float dofSampleX, const float dofSampleY
#endif
		) {
	__global const Transform* restrict rasterToCamera;
	__global const Transform* restrict cameraToWorld;
	float filmX;
	const float filmWidth = origFilmWidth /2 ;
	if (origFilmX < filmWidth) {
		rasterToCamera = &camera->stereo.leftEyeRasterToCamera;
		cameraToWorld = &camera->stereo.leftEyeCameraToWorld;
		filmX = origFilmX;
	} else {
		rasterToCamera = &camera->stereo.rightEyeRasterToCamera;
		cameraToWorld = &camera->stereo.rightEyeCameraToWorld;
		filmX = origFilmX - filmWidth;
	}

#if defined(PARAM_CAMERA_ENABLE_OCULUSRIFT_BARREL)
	float ssx, ssy;
	Camera_OculusRiftBarrelPostprocess(filmX / filmWidth, (filmHeight - filmY - 1.f) / filmHeight, &ssx, &ssy);
	const float3 Pras = (float3) (min(ssx * filmWidth, (float) (filmWidth - 1)), min(ssy * filmHeight, (float) (filmHeight - 1)), 0.f);
#else
	const float3 Pras = (float3) (filmX, filmHeight - filmY - 1.f, 0.f);
#endif

	float3 rayOrig = Transform_ApplyPoint(rasterToCamera, Pras);
	float3 rayDir = rayOrig;

	const float hither = camera->base.hither;

#if defined(PARAM_CAMERA_HAS_DOF)
	// Sample point on lens
	float lensU, lensV;
	ConcentricSampleDisk(dofSampleX, dofSampleY, &lensU, &lensV);
	const float lensRadius = camera->persp.projCamera.lensRadius;
	lensU *= lensRadius;
	lensV *= lensRadius;

	// Compute point on plane of focus
	const float focalDistance = camera->persp.projCamera.focalDistance;
	const float dist = focalDistance - hither;

	const float ft = dist / rayDir.z;
	const float3 Pfocus = rayOrig + rayDir * ft;

	// Update ray for effect of lens
	const float k = dist / focalDistance;
	rayOrig.x += lensU * k;
	rayOrig.y += lensV * k;

	rayDir = Pfocus - rayOrig;
#endif

	rayDir = normalize(rayDir);

	const float maxt = (camera->base.yon - hither) / rayDir.z;
	const float time = mix(camera->base.shutterOpen, camera->base.shutterClose, timeSample);

	// Transform ray in world coordinates
	rayOrig = Transform_ApplyPoint(cameraToWorld, rayOrig);
	rayDir = Transform_ApplyVector(cameraToWorld, rayDir);

	const uint interpolatedTransformFirstIndex = camera->base.motionSystem.interpolatedTransformFirstIndex;
	if (interpolatedTransformFirstIndex != NULL_INDEX) {
		Matrix4x4 m;
		MotionSystem_Sample(&camera->base.motionSystem, time, camera->base.interpolatedTransforms, &m);

		rayOrig = Matrix4x4_ApplyPoint_Private(&m, rayOrig);
		rayDir = Matrix4x4_ApplyVector_Private(&m, rayDir);
	}

#if defined(CAMERA_GENERATERAY_PARAM_MEM_SPACE_PRIVATE)
	Ray_Init3_Private(ray, rayOrig, rayDir, maxt, time);
#else
	Ray_Init3(ray, rayOrig, rayDir, maxt, time);
#endif

#if defined(PARAM_CAMERA_ENABLE_CLIPPING_PLANE)
	Camera_ApplyArbitraryClippingPlane(camera, ray);
#endif

	/*printf("(%f, %f, %f) (%f, %f, %f) [%f, %f]\n",
		ray->o.x, ray->o.y, ray->o.z, ray->d.x, ray->d.y, ray->d.z,
		ray->mint, ray->maxt);*/
}

#endif
#line 2 "light_funcs.cl"

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

float InfiniteLightSource_GetEnvRadius(const float sceneRadius) {
	// This is used to scale the world radius in sun/sky/infinite lights in order to
	// avoid problems with objects that are near the borderline of the world bounding sphere
	return PARAM_LIGHT_WORLD_RADIUS_SCALE * sceneRadius;
}

//------------------------------------------------------------------------------
// ConstantInfiniteLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_CONSTANTINFINITELIGHT)

float3 ConstantInfiniteLight_GetRadiance(__global const LightSource *constantInfiniteLight,
		const float3 dir, float *directPdfA) {
	*directPdfA = 1.f / (4.f * M_PI_F);

	return VLOAD3F(constantInfiniteLight->notIntersectable.gain.c) *
			VLOAD3F(constantInfiniteLight->notIntersectable.constantInfinite.color.c);
}

float3 ConstantInfiniteLight_Illuminate(__global const LightSource *constantInfiniteLight,
		const float worldCenterX, const float worldCenterY, const float worldCenterZ,
		const float sceneRadius,
		const float u0, const float u1, const float3 p,
		float3 *dir, float *distance, float *directPdfW) {
	const float phi = u0 * 2.f * M_PI_F;
	const float theta = u1 * M_PI_F;
	*dir = SphericalDirection(sin(theta), cos(theta), phi);

	const float3 worldCenter = (float3)(worldCenterX, worldCenterY, worldCenterZ);
	const float envRadius = InfiniteLightSource_GetEnvRadius(sceneRadius);

	const float3 toCenter = worldCenter - p;
	const float centerDistance = dot(toCenter, toCenter);
	const float approach = dot(toCenter, *dir);
	*distance = approach + sqrt(max(0.f, envRadius * envRadius -
		centerDistance + approach * approach));

	const float3 emisPoint = p + (*distance) * (*dir);
	const float3 emisNormal = normalize(worldCenter - emisPoint);

	const float cosAtLight = dot(emisNormal, -(*dir));
	if (cosAtLight < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	*directPdfW = 1.f / (4.f * M_PI_F);

	return VLOAD3F(constantInfiniteLight->notIntersectable.gain.c) *
			VLOAD3F(constantInfiniteLight->notIntersectable.constantInfinite.color.c);
}

#endif

//------------------------------------------------------------------------------
// InfiniteLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_INFINITELIGHT)

float3 InfiniteLight_GetRadiance(__global const LightSource *infiniteLight,
		__global const float *infiniteLightDistirbution,
		const float3 dir, float *directPdfA
		IMAGEMAPS_PARAM_DECL) {
	__global const ImageMap *imageMap = &imageMapDescs[infiniteLight->notIntersectable.infinite.imageMapIndex];

	const float3 localDir = normalize(Transform_InvApplyVector(&infiniteLight->notIntersectable.light2World, -dir));
	const float2 uv = (float2)(
		SphericalPhi(localDir) * (1.f / (2.f * M_PI_F)),
		SphericalTheta(localDir) * M_1_PI_F);

	// TextureMapping2D_Map() is expended here
	const float2 scale = VLOAD2F(&infiniteLight->notIntersectable.infinite.mapping.uvMapping2D.uScale);
	const float2 delta = VLOAD2F(&infiniteLight->notIntersectable.infinite.mapping.uvMapping2D.uDelta);
	const float2 mapUV = uv * scale + delta;

	const float distPdf = Distribution2D_Pdf(infiniteLightDistirbution, mapUV.s0, mapUV.s1);
	*directPdfA = distPdf / (4.f * M_PI_F);

	return VLOAD3F(infiniteLight->notIntersectable.gain.c) * ImageMap_GetSpectrum(
			imageMap,
			mapUV.s0, mapUV.s1
			IMAGEMAPS_PARAM);
}

float3 InfiniteLight_Illuminate(__global const LightSource *infiniteLight,
		__global const float *infiniteLightDistirbution,
		const float worldCenterX, const float worldCenterY, const float worldCenterZ,
		const float sceneRadius,
		const float u0, const float u1, const float3 p,
		float3 *dir, float *distance, float *directPdfW
		IMAGEMAPS_PARAM_DECL) {
	float2 sampleUV;
	float distPdf;
	Distribution2D_SampleContinuous(infiniteLightDistirbution, u0, u1, &sampleUV, &distPdf);

	const float phi = sampleUV.s0 * 2.f * M_PI_F;
	const float theta = sampleUV.s1 * M_PI_F;
	*dir = normalize(Transform_ApplyVector(&infiniteLight->notIntersectable.light2World,
			SphericalDirection(sin(theta), cos(theta), phi)));

	const float3 worldCenter = (float3)(worldCenterX, worldCenterY, worldCenterZ);
	const float envRadius = InfiniteLightSource_GetEnvRadius(sceneRadius);

	const float3 toCenter = worldCenter - p;
	const float centerDistance = dot(toCenter, toCenter);
	const float approach = dot(toCenter, *dir);
	*distance = approach + sqrt(max(0.f, envRadius * envRadius -
		centerDistance + approach * approach));

	const float3 emisPoint = p + (*distance) * (*dir);
	const float3 emisNormal = normalize(worldCenter - emisPoint);

	const float cosAtLight = dot(emisNormal, -(*dir));
	if (cosAtLight < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	*directPdfW = distPdf / (4.f * M_PI_F);

	// InfiniteLight_GetRadiance is expended here
	__global const ImageMap *imageMap = &imageMapDescs[infiniteLight->notIntersectable.infinite.imageMapIndex];

	const float2 uv = (float2)(sampleUV.s0, sampleUV.s1);

	// TextureMapping2D_Map() is expended here
	const float2 scale = VLOAD2F(&infiniteLight->notIntersectable.infinite.mapping.uvMapping2D.uScale);
	const float2 delta = VLOAD2F(&infiniteLight->notIntersectable.infinite.mapping.uvMapping2D.uDelta);
	const float2 mapUV = uv * scale + delta;

	return VLOAD3F(infiniteLight->notIntersectable.gain.c) * ImageMap_GetSpectrum(
			imageMap,
			mapUV.s0, mapUV.s1
			IMAGEMAPS_PARAM);
}

#endif

//------------------------------------------------------------------------------
// SkyLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_SKYLIGHT)

float SkyLight_PerezBase(__global float *lam, const float theta, const float gamma) {
	return (1.f + lam[1] * exp(lam[2] / cos(theta))) *
		(1.f + lam[3] * exp(lam[4] * gamma)  + lam[5] * cos(gamma) * cos(gamma));
}

float SkyLight_RiAngleBetween(const float thetav, const float phiv, const float theta, const float phi) {
	const float cospsi = sin(thetav) * sin(theta) * cos(phi - phiv) + cos(thetav) * cos(theta);
	if (cospsi >= 1.f)
		return 0.f;
	if (cospsi <= -1.f)
		return M_PI_F;
	return acos(cospsi);
}

float3 SkyLight_ChromaticityToSpectrum(float Y, float x, float y) {
	float X, Z;

	if (y != 0.f)
		X = (x / y) * Y;
	else
		X = 0.f;

	if (y != 0.f && Y != 0.f)
		Z = (1.f - x - y) / y * Y;
	else
		Z = 0.f;

	// Assuming sRGB (D65 illuminant)
	return (float3)(3.2410f * X - 1.5374f * Y - 0.4986f * Z,
			-0.9692f * X + 1.8760f * Y + 0.0416f * Z,
			0.0556f * X - 0.2040f * Y + 1.0570f * Z);
}

float3 SkyLight_GetSkySpectralRadiance(__global const LightSource *skyLight,
		const float theta, const float phi) {
	// Add bottom half of hemisphere with horizon colour
	const float theta_fin = fmin(theta, (M_PI_F * .5f) - .001f);
	const float gamma = SkyLight_RiAngleBetween(theta, phi,
			skyLight->notIntersectable.sky.absoluteTheta, skyLight->notIntersectable.sky.absolutePhi);

	// Compute xyY values
	const float x = skyLight->notIntersectable.sky.zenith_x * SkyLight_PerezBase(
			skyLight->notIntersectable.sky.perez_x, theta_fin, gamma);
	const float y = skyLight->notIntersectable.sky.zenith_y * SkyLight_PerezBase(
			skyLight->notIntersectable.sky.perez_y, theta_fin, gamma);
	const float Y = skyLight->notIntersectable.sky.zenith_Y * SkyLight_PerezBase(
			skyLight->notIntersectable.sky.perez_Y, theta_fin, gamma);

	return SkyLight_ChromaticityToSpectrum(Y, x, y);
}

float3 SkyLight_GetRadiance(__global const LightSource *skyLight, const float3 dir,
		float *directPdfA) {
	*directPdfA = 1.f / (4.f * M_PI_F);

	const float theta = SphericalTheta(-dir);
	const float phi = SphericalPhi(-dir);
	const float3 s = SkyLight_GetSkySpectralRadiance(skyLight, theta, phi);

	return VLOAD3F(skyLight->notIntersectable.gain.c) * s;
}

float3 SkyLight_Illuminate(__global const LightSource *skyLight,
		const float worldCenterX, const float worldCenterY, const float worldCenterZ,
		const float sceneRadius,
		const float u0, const float u1, const float3 p,
		float3 *dir, float *distance, float *directPdfW) {
	const float3 worldCenter = (float3)(worldCenterX, worldCenterY, worldCenterZ);
	const float envRadius = InfiniteLightSource_GetEnvRadius(sceneRadius);

	const float3 localDir = normalize(Transform_ApplyVector(&skyLight->notIntersectable.light2World, -(*dir)));
	*dir = normalize(Transform_ApplyVector(&skyLight->notIntersectable.light2World,  UniformSampleSphere(u0, u1)));

	const float3 toCenter = worldCenter - p;
	const float centerDistance = dot(toCenter, toCenter);
	const float approach = dot(toCenter, *dir);
	*distance = approach + sqrt(max(0.f, envRadius * envRadius -
		centerDistance + approach * approach));

	const float3 emisPoint = p + (*distance) * (*dir);
	const float3 emisNormal = normalize(worldCenter - emisPoint);

	const float cosAtLight = dot(emisNormal, -(*dir));
	if (cosAtLight < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	return SkyLight_GetRadiance(skyLight, -(*dir), directPdfW);
}

#endif

//------------------------------------------------------------------------------
// Sky2Light
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_SKYLIGHT2)

float RiCosBetween(const float3 w1, const float3 w2) {
	return clamp(dot(w1, w2), -1.f, 1.f);
}

float3 SkyLight2_ComputeRadiance(__global const LightSource *skyLight2, const float3 w) {
	const float3 absoluteSunDir = VLOAD3F(&skyLight2->notIntersectable.sky2.absoluteSunDir.x);
	const float cosG = RiCosBetween(w, absoluteSunDir);
	const float cosG2 = cosG * cosG;
	const float gamma = acos(cosG);
	const float cosT = fmax(0.f, CosTheta(w));

	const float3 aTerm = VLOAD3F(skyLight2->notIntersectable.sky2.aTerm.c);
	const float3 bTerm = VLOAD3F(skyLight2->notIntersectable.sky2.bTerm.c);
	const float3 cTerm = VLOAD3F(skyLight2->notIntersectable.sky2.cTerm.c);
	const float3 dTerm = VLOAD3F(skyLight2->notIntersectable.sky2.dTerm.c);
	const float3 eTerm = VLOAD3F(skyLight2->notIntersectable.sky2.eTerm.c);
	const float3 fTerm = VLOAD3F(skyLight2->notIntersectable.sky2.fTerm.c);
	const float3 gTerm = VLOAD3F(skyLight2->notIntersectable.sky2.gTerm.c);
	const float3 hTerm = VLOAD3F(skyLight2->notIntersectable.sky2.hTerm.c);
	const float3 iTerm = VLOAD3F(skyLight2->notIntersectable.sky2.iTerm.c);
	const float3 radianceTerm = VLOAD3F(skyLight2->notIntersectable.sky2.radianceTerm.c);

	const float3 expTerm = dTerm * Spectrum_Exp(eTerm * gamma);
	const float3 rayleighTerm = fTerm * cosG2;
	const float3 mieTerm = gTerm * (1.f + cosG2) /
		Spectrum_Pow(1.f + iTerm * (iTerm - (2.f * cosG)), 1.5f);
	const float3 zenithTerm = hTerm * sqrt(cosT);

	// 683 is a scaling factor to convert W to lm
	return 683.f * (1.f + aTerm * Spectrum_Exp(bTerm / (cosT + .01f))) *
		(cTerm + expTerm + rayleighTerm + mieTerm + zenithTerm) * radianceTerm;
}

float3 SkyLight2_GetRadiance(__global const LightSource *skyLight2, const float3 dir,
		float *directPdfA) {
	*directPdfA = 1.f / (4.f * M_PI_F);
	const float3 s = SkyLight2_ComputeRadiance(skyLight2, -dir);

	return VLOAD3F(skyLight2->notIntersectable.gain.c) * s;
}

float3 SkyLight2_Illuminate(__global const LightSource *skyLight2,
		const float worldCenterX, const float worldCenterY, const float worldCenterZ,
		const float sceneRadius,
		const float u0, const float u1, const float3 p,
		float3 *dir, float *distance, float *directPdfW) {
	const float3 worldCenter = (float3)(worldCenterX, worldCenterY, worldCenterZ);
	const float envRadius = InfiniteLightSource_GetEnvRadius(sceneRadius);

	const float3 localDir = normalize(Transform_ApplyVector(&skyLight2->notIntersectable.light2World, -(*dir)));
	*dir = normalize(Transform_ApplyVector(&skyLight2->notIntersectable.light2World,  UniformSampleSphere(u0, u1)));

	const float3 toCenter = worldCenter - p;
	const float centerDistance = dot(toCenter, toCenter);
	const float approach = dot(toCenter, *dir);
	*distance = approach + sqrt(max(0.f, envRadius * envRadius -
		centerDistance + approach * approach));

	const float3 emisPoint = p + (*distance) * (*dir);
	const float3 emisNormal = normalize(worldCenter - emisPoint);

	const float cosAtLight = dot(emisNormal, -(*dir));
	if (cosAtLight < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	return SkyLight2_GetRadiance(skyLight2, -(*dir), directPdfW);
}

#endif

//------------------------------------------------------------------------------
// SunLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_SUNLIGHT)

float3 SunLight_Illuminate(__global const LightSource *sunLight,
		const float worldCenterX, const float worldCenterY, const float worldCenterZ,
		const float sceneRadius,
		const float3 p, const float u0, const float u1,
		float3 *dir, float *distance, float *directPdfW) {
	const float cosThetaMax = sunLight->notIntersectable.sun.cosThetaMax;
	const float3 sunDir = VLOAD3F(&sunLight->notIntersectable.sun.absoluteDir.x);
	*dir = UniformSampleCone(u0, u1, cosThetaMax, VLOAD3F(&sunLight->notIntersectable.sun.x.x), VLOAD3F(&sunLight->notIntersectable.sun.y.x), sunDir);

	// Check if the point can be inside the sun cone of light
	const float cosAtLight = dot(sunDir, *dir);
	if (cosAtLight <= cosThetaMax)
		return BLACK;

	const float3 worldCenter = (float3)(worldCenterX, worldCenterY, worldCenterZ);
	const float envRadius = InfiniteLightSource_GetEnvRadius(sceneRadius);
	const float3 toCenter = worldCenter - p;
	const float centerDistance = dot(toCenter, toCenter);
	const float approach = dot(toCenter, *dir);
	*distance = approach + sqrt(max(0.f, envRadius * envRadius -
		centerDistance + approach * approach));

	*directPdfW = UniformConePdf(cosThetaMax);

	return VLOAD3F(sunLight->notIntersectable.sun.color.c);
}

float3 SunLight_GetRadiance(__global const LightSource *sunLight, const float3 dir, float *directPdfA) {
	const float cosThetaMax = sunLight->notIntersectable.sun.cosThetaMax;
	const float sin2ThetaMax = sunLight->notIntersectable.sun.sin2ThetaMax;
	const float3 x = VLOAD3F(&sunLight->notIntersectable.sun.x.x);
	const float3 y = VLOAD3F(&sunLight->notIntersectable.sun.y.x);
	const float3 absoluteSunDir = VLOAD3F(&sunLight->notIntersectable.sun.absoluteDir.x);

	const float xD = dot(-dir, x);
	const float yD = dot(-dir, y);
	const float zD = dot(-dir, absoluteSunDir);
	if ((cosThetaMax == 1.f) || (zD < 0.f) || ((xD * xD + yD * yD) > sin2ThetaMax))
		return BLACK;

	if (directPdfA)
		*directPdfA = UniformConePdf(cosThetaMax);

	return VLOAD3F(sunLight->notIntersectable.sun.color.c);
}

#endif

//------------------------------------------------------------------------------
// TriangleLight
//------------------------------------------------------------------------------

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)

float3 TriangleLight_Illuminate(__global const LightSource *triLight,
		__global HitPoint *tmpHitPoint,
		const float3 p, const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
		float3 *dir, float *distance, float *directPdfW
		MATERIALS_PARAM_DECL) {
	const float3 p0 = VLOAD3F(&triLight->triangle.v0.x);
	const float3 p1 = VLOAD3F(&triLight->triangle.v1.x);
	const float3 p2 = VLOAD3F(&triLight->triangle.v2.x);
	float b0, b1, b2;
	const float3 samplePoint = Triangle_Sample(
			p0, p1, p2,
			u0, u1,
			&b0, &b1, &b2);
	*dir = samplePoint - p;
	const float distanceSquared = dot(*dir, *dir);;
	*distance = sqrt(distanceSquared);
	*dir /= (*distance);

	const float3 sampleN = Triangle_GetGeometryNormal(p0, p1, p2); // Light sources are supposed to be flat

	const float cosAtLight = dot(sampleN, -(*dir));
	if (cosAtLight < DEFAULT_COS_EPSILON_STATIC)
		return BLACK;

	// FIXME: use correct shading normal
//	float3 shadeN;
//#if defined(PARAM_HAS_NORMALS_BUFFER)
//	if (meshDesc->normalsOffset != NULL_INDEX) {
//		__global const Vector *iVertNormals = &vertNormals[meshDesc->normalsOffset];
//		// Shading normal expressed in local coordinates
//		shadeN = Mesh_InterpolateNormal(iVertNormals, iTriangles, triangleIndex, b1, b2);
//		// Transform to global coordinates
//		shadeN = normalize(Transform_InvApplyNormal(&meshDesc->trans, shadeN));
//	} else
//#endif
//		shadeN = geometryN;

	VSTORE3F(samplePoint, &tmpHitPoint->p.x);

#if defined(PARAM_HAS_PASSTHROUGH)
	tmpHitPoint->passThroughEvent = passThroughEvent;
#endif

	VSTORE3F(sampleN, &tmpHitPoint->geometryN.x);
    VSTORE3F(sampleN, &tmpHitPoint->shadeN.x);
	VSTORE3F(-sampleN, &tmpHitPoint->fixedDir.x);

#if defined(PARAM_ENABLE_TEX_HITPOINTCOLOR) || defined(PARAM_ENABLE_TEX_HITPOINTGREY) || defined(PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR)
	const float3 rgb0 = VLOAD3F(triLight->triangle.rgb0.c);
	const float3 rgb1 = VLOAD3F(triLight->triangle.rgb1.c);
	const float3 rgb2 = VLOAD3F(triLight->triangle.rgb2.c);
	const float3 triColor = Triangle_InterpolateColor(rgb0, rgb1, rgb2, b0, b1, b2);

	VSTORE3F(triColor, tmpHitPoint->color.c);
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTALPHA)
	VSTORE2F(1.f, &tmpHitPoint->alpha);
#endif
#if defined(PARAM_HAS_VOLUMES)
	tmpHitPoint->interiorVolumeIndex = NULL_INDEX;
	tmpHitPoint->exteriorVolumeIndex = NULL_INDEX;
	tmpHitPoint->intoObject = true;
#endif

	const float2 uv0 = VLOAD2F(&triLight->triangle.uv0.u);
	const float2 uv1 = VLOAD2F(&triLight->triangle.uv1.u);
	const float2 uv2 = VLOAD2F(&triLight->triangle.uv2.u);
	const float2 triUV = Triangle_InterpolateUV(uv0, uv1, uv2, b0, b1, b2);
	VSTORE2F(triUV, &tmpHitPoint->uv.u);

	// Apply Bump mapping and get proper differentials?
#if defined(PARAM_HAS_BUMPMAPS)
	float3 dpdu, dpdv;
	CoordinateSystem(sampleN, &dpdu, &dpdv);
	VSTORE3F(dpdu, &tmpHitPoint->dpdu.x);
	VSTORE3F(dpdv, &tmpHitPoint->dpdv.x);
#endif

	float3 emissionColor = WHITE;
#if defined(PARAM_HAS_IMAGEMAPS)
	if (triLight->triangle.imageMapIndex != NULL_INDEX) {
		// Build the local frame
		float3 X, Y;
		CoordinateSystem(sampleN, &X, &Y);

		const float3 localFromLight = ToLocal(X, Y, sampleN, -(*dir));

		// Retrieve the image map information
		__global const ImageMap *imageMap = &imageMapDescs[triLight->triangle.imageMapIndex];
		const float2 uv = (float2)(SphericalPhi(localFromLight) * (1.f / (2.f * M_PI_F)), SphericalTheta(localFromLight) * M_1_PI_F);
		emissionColor = ImageMap_GetSpectrum(
				imageMap,
				uv.s0, uv.s1
				IMAGEMAPS_PARAM) / triLight->triangle.avarage;

		*directPdfW = triLight->triangle.invTriangleArea * distanceSquared ;
	} else
#endif
		*directPdfW = triLight->triangle.invTriangleArea * distanceSquared / cosAtLight;

	return Material_GetEmittedRadiance(triLight->triangle.materialIndex,
			tmpHitPoint, triLight->triangle.invMeshArea
			MATERIALS_PARAM) * emissionColor;
}

float3 TriangleLight_GetRadiance(__global const LightSource *triLight,
		 __global HitPoint *hitPoint, float *directPdfA
		MATERIALS_PARAM_DECL) {
	const float3 dir = VLOAD3F(&hitPoint->fixedDir.x);
	const float3 hitPointNormal = VLOAD3F(&hitPoint->geometryN.x);
	const float cosOutLight = dot(hitPointNormal, dir);
	if (cosOutLight <= 0.f)
		return BLACK;

	if (directPdfA)
		*directPdfA = triLight->triangle.invTriangleArea;

	float3 emissionColor = WHITE;
#if defined(PARAM_HAS_IMAGEMAPS)
	if (triLight->triangle.imageMapIndex != NULL_INDEX) {
		// Build the local frame
		float3 X, Y;
		CoordinateSystem(hitPointNormal, &X, &Y);

		const float3 localFromLight = ToLocal(X, Y, hitPointNormal, dir);

		// Retrieve the image map information
		__global const ImageMap *imageMap = &imageMapDescs[triLight->triangle.imageMapIndex];
		const float2 uv = (float2)(SphericalPhi(localFromLight) * (1.f / (2.f * M_PI_F)), SphericalTheta(localFromLight) * M_1_PI_F);
		emissionColor = ImageMap_GetSpectrum(
				imageMap,
				uv.s0, uv.s1
				IMAGEMAPS_PARAM) / triLight->triangle.avarage;
	}
#endif

	return Material_GetEmittedRadiance(triLight->triangle.materialIndex,
			hitPoint, triLight->triangle.invMeshArea
			MATERIALS_PARAM) * emissionColor;
}

#endif

//------------------------------------------------------------------------------
// PointLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_POINTLIGHT)

float3 PointLight_Illuminate(__global const LightSource *pointLight,
		const float3 p,	float3 *dir, float *distance, float *directPdfW) {
	const float3 toLight = VLOAD3F(&pointLight->notIntersectable.point.absolutePos.x) - p;
	const float distanceSquared = dot(toLight, toLight);
	*distance = sqrt(distanceSquared);
	*dir = toLight / *distance;

	*directPdfW = distanceSquared;

	return VLOAD3F(pointLight->notIntersectable.point.emittedFactor.c);
}

#endif

//------------------------------------------------------------------------------
// MapPointLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_MAPPOINTLIGHT)

float3 MapPointLight_Illuminate(__global const LightSource *mapPointLight,
		const float3 p,	float3 *dir, float *distance, float *directPdfW
		IMAGEMAPS_PARAM_DECL) {
	const float3 toLight = VLOAD3F(&mapPointLight->notIntersectable.mapPoint.absolutePos.x) - p;
	const float distanceSquared = dot(toLight, toLight);
	*distance = sqrt(distanceSquared);
	*dir = toLight / *distance;

	*directPdfW = distanceSquared;

	// Retrieve the image map information
	__global const ImageMap *imageMap = &imageMapDescs[mapPointLight->notIntersectable.mapPoint.imageMapIndex];

	const float3 localFromLight = normalize(Transform_InvApplyVector(&mapPointLight->notIntersectable.light2World, p) -
		VLOAD3F(&mapPointLight->notIntersectable.mapPoint.localPos.x));
	const float2 uv = (float2)(SphericalPhi(localFromLight) * (1.f / (2.f * M_PI_F)), SphericalTheta(localFromLight) * M_1_PI_F);
	const float3 emissionColor = ImageMap_GetSpectrum(
			imageMap,
			uv.s0, uv.s1
			IMAGEMAPS_PARAM) / mapPointLight->notIntersectable.mapPoint.avarage;

	return VLOAD3F(mapPointLight->notIntersectable.mapPoint.emittedFactor.c) * emissionColor;
}

#endif

//------------------------------------------------------------------------------
// SpotLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_SPOTLIGHT)

float SpotLight_LocalFalloff(const float3 w, const float cosTotalWidth, const float cosFalloffStart) {
	if (CosTheta(w) < cosTotalWidth)
		return 0.f;
 	if (CosTheta(w) > cosFalloffStart)
		return 1.f;

	// Compute falloff inside spotlight cone
	const float delta = (CosTheta(w) - cosTotalWidth) / (cosFalloffStart - cosTotalWidth);
	return pow(delta, 4);
}

float3 SpotLight_Illuminate(__global const LightSource *spotLight,
		const float3 p,	float3 *dir, float *distance, float *directPdfW) {
	const float3 toLight = VLOAD3F(&spotLight->notIntersectable.spot.absolutePos.x) - p;
	const float distanceSquared = dot(toLight, toLight);
	*distance = sqrt(distanceSquared);
	*dir = toLight / *distance;

	const float3 localFromLight = normalize(Transform_InvApplyVector(
			&spotLight->notIntersectable.light2World, -(*dir)));
	const float falloff = SpotLight_LocalFalloff(localFromLight,
			spotLight->notIntersectable.spot.cosTotalWidth,
			spotLight->notIntersectable.spot.cosFalloffStart);
	if (falloff == 0.f)
		return BLACK;

	*directPdfW = distanceSquared;

	return VLOAD3F(spotLight->notIntersectable.spot.emittedFactor.c) *
			(falloff / fabs(CosTheta(localFromLight)));
}

#endif

//------------------------------------------------------------------------------
// ProjectionLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_PROJECTIONLIGHT)

float3 ProjectionLight_Illuminate(__global const LightSource *projectionLight,
		const float3 p,	float3 *dir, float *distance, float *directPdfW
		IMAGEMAPS_PARAM_DECL) {
	const float3 toLight = VLOAD3F(&projectionLight->notIntersectable.projection.absolutePos.x) - p;
	const float distanceSquared = dot(toLight, toLight);
	*distance = sqrt(distanceSquared);
	*dir = toLight / *distance;

	// Check the side
	if (dot(-(*dir), VLOAD3F(&projectionLight->notIntersectable.projection.lightNormal.x)) < 0.f)
		return BLACK;

	// Check if the point is inside the image plane
	const float3 localFromLight = normalize(Transform_InvApplyVector(
			&projectionLight->notIntersectable.light2World, -(*dir)));
	const float3 p0 = Matrix4x4_ApplyPoint(
			&projectionLight->notIntersectable.projection.lightProjection, localFromLight);

	const float screenX0 = projectionLight->notIntersectable.projection.screenX0;
	const float screenX1 = projectionLight->notIntersectable.projection.screenX1;
	const float screenY0 = projectionLight->notIntersectable.projection.screenY0;
	const float screenY1 = projectionLight->notIntersectable.projection.screenY1;
	if ((p0.x < screenX0) || (p0.x >= screenX1) || (p0.y < screenY0) || (p0.y >= screenY1))
		return BLACK;

	*directPdfW = distanceSquared;

	float3 c = VLOAD3F(projectionLight->notIntersectable.projection.emittedFactor.c);
#if defined(PARAM_HAS_IMAGEMAPS)
	const uint imageMapIndex = projectionLight->notIntersectable.projection.imageMapIndex;
	if (imageMapIndex != NULL_INDEX) {
		const float u = (p0.x - screenX0) / (screenX1 - screenX0);
		const float v = (p0.y - screenY0) / (screenY1 - screenY0);

		// Retrieve the image map information
		__global const ImageMap *imageMap = &imageMapDescs[imageMapIndex];

		c *= ImageMap_GetSpectrum(
				imageMap,
				u, v
				IMAGEMAPS_PARAM);
	}
#endif

	return c;
}

#endif

//------------------------------------------------------------------------------
// SharpDistantLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_SHARPDISTANTLIGHT)

float3 SharpDistantLight_Illuminate(__global const LightSource *sharpDistantLight,
		const float worldCenterX, const float worldCenterY, const float worldCenterZ,
		const float sceneRadius,
		const float3 p,	float3 *dir, float *distance, float *directPdfW) {
	*dir = -VLOAD3F(&sharpDistantLight->notIntersectable.sharpDistant.absoluteLightDir.x);

	const float3 worldCenter = (float3)(worldCenterX, worldCenterY, worldCenterZ);
	const float envRadius = InfiniteLightSource_GetEnvRadius(sceneRadius);
	const float3 toCenter = worldCenter - p;
	const float centerDistance = dot(toCenter, toCenter);
	const float approach = dot(toCenter, *dir);
	*distance = approach + sqrt(max(0.f, envRadius * envRadius -
		centerDistance + approach * approach));

	*directPdfW = 1.f;

	return VLOAD3F(sharpDistantLight->notIntersectable.gain.c) *
			VLOAD3F(sharpDistantLight->notIntersectable.sharpDistant.color.c);
}

#endif

//------------------------------------------------------------------------------
// DistantLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_DISTANTLIGHT)

float3 DistantLight_Illuminate(__global const LightSource *distantLight,
		const float worldCenterX, const float worldCenterY, const float worldCenterZ,
		const float sceneRadius,
		const float3 p,	const float u0, const float u1,
		float3 *dir, float *distance, float *directPdfW) {
	const float3 absoluteLightDir = VLOAD3F(&distantLight->notIntersectable.distant.absoluteLightDir.x);
	const float3 x = VLOAD3F(&distantLight->notIntersectable.distant.x.x);
	const float3 y = VLOAD3F(&distantLight->notIntersectable.distant.y.x);
	const float cosThetaMax = distantLight->notIntersectable.distant.cosThetaMax;
	*dir = -UniformSampleCone(u0, u1, cosThetaMax, x, y, absoluteLightDir);

	const float3 worldCenter = (float3)(worldCenterX, worldCenterY, worldCenterZ);
	const float envRadius = InfiniteLightSource_GetEnvRadius(sceneRadius);
	const float3 toCenter = worldCenter - p;
	const float centerDistance = dot(toCenter, toCenter);
	const float approach = dot(toCenter, *dir);
	*distance = approach + sqrt(max(0.f, envRadius * envRadius -
		centerDistance + approach * approach));

	const float uniformConePdf = UniformConePdf(cosThetaMax);
	*directPdfW = uniformConePdf;

	return VLOAD3F(distantLight->notIntersectable.gain.c) *
			VLOAD3F(distantLight->notIntersectable.sharpDistant.color.c);
}

#endif

//------------------------------------------------------------------------------
// LaserLight
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_LASERLIGHT)

float3 LaserLight_Illuminate(__global const LightSource *laserLight,
		const float3 p,	float3 *dir, float *distance, float *directPdfW) {
	const float3 absoluteLightPos = VLOAD3F(&laserLight->notIntersectable.laser.absoluteLightPos.x);
	const float3 absoluteLightDir = VLOAD3F(&laserLight->notIntersectable.laser.absoluteLightDir.x);

	*dir = -absoluteLightDir;

	const float3 rayOrig = p;
	const float3 rayDir = *dir;
	const float3 planeCenter = absoluteLightPos;
	const float3 planeNormal = absoluteLightDir;

	// Intersect the shadow ray with light plane
	const float denom = dot(planeNormal, rayDir);
	const float3 pr = planeCenter - rayOrig;
	float d = dot(pr, planeNormal);

	if (fabs(denom) > DEFAULT_COS_EPSILON_STATIC) {
		// There is a valid intersection
		d /= denom;

		if ((d <= 0.f) || (denom >= 0.f))
			return BLACK;
	} else
		return BLACK;

	const float3 lightPoint = rayOrig + d * rayDir;

	// Check if the point is inside the emitting circle
	const float radius = laserLight->notIntersectable.laser.radius;
	const float3 dist = lightPoint - absoluteLightPos;
	if (dot(dist, dist) > radius * radius)
		return BLACK;

	// Ok, the light is visible

	*distance = d;
	*directPdfW = 1.f;

	return VLOAD3F(laserLight->notIntersectable.laser.emittedFactor.c);
}

#endif

//------------------------------------------------------------------------------
// Generic light functions
//------------------------------------------------------------------------------

float3 EnvLight_GetRadiance(__global const LightSource *light, const float3 dir, float *directPdfA
				LIGHTS_PARAM_DECL) {
	switch (light->type) {
#if defined(PARAM_HAS_CONSTANTINFINITELIGHT)
		case TYPE_IL_CONSTANT:
			return ConstantInfiniteLight_GetRadiance(light,
					dir, directPdfA);
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
		case TYPE_IL:
			return InfiniteLight_GetRadiance(light,
					&infiniteLightDistribution[light->notIntersectable.infinite.distributionOffset],
					dir, directPdfA
					IMAGEMAPS_PARAM);
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		case TYPE_IL_SKY:
			return SkyLight_GetRadiance(light,
					dir, directPdfA);
#endif
#if defined(PARAM_HAS_SKYLIGHT2)
		case TYPE_IL_SKY2:
			return SkyLight2_GetRadiance(light,
					dir, directPdfA);
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		case TYPE_SUN:
			return SunLight_GetRadiance(light,
					dir, directPdfA);
#endif
#if defined(PARAM_HAS_SHARPDISTANTLIGHT)
		case TYPE_SHARPDISTANT:
			// Just return Black
#endif
#if defined(PARAM_HAS_DISTANTLIGHT)
		case TYPE_DISTANT:
			// Just return Black
#endif

		default:
			return BLACK;
	}
}

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
float3 IntersectableLight_GetRadiance(__global const LightSource *light,
		 __global HitPoint *hitPoint, float *directPdfA
		LIGHTS_PARAM_DECL) {
	return TriangleLight_GetRadiance(light, hitPoint, directPdfA
			MATERIALS_PARAM);
}
#endif

float3 Light_Illuminate(
		__global const LightSource *light,
		const float3 point,
		const float u0, const float u1,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThroughEvent,
#endif
#if defined(PARAM_HAS_INFINITELIGHTS)
		const float worldCenterX,
		const float worldCenterY,
		const float worldCenterZ,
		const float envRadius,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		__global HitPoint *tmpHitPoint,
#endif
		float3 *lightRayDir, float *distance, float *directPdfW
		LIGHTS_PARAM_DECL) {
	switch (light->type) {
#if defined(PARAM_HAS_CONSTANTINFINITELIGHT)
		case TYPE_IL_CONSTANT:
			return ConstantInfiniteLight_Illuminate(
				light,
				worldCenterX, worldCenterY, worldCenterZ, envRadius,
				u0, u1,
				point,
				lightRayDir, distance, directPdfW);
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
		case TYPE_IL:
			return InfiniteLight_Illuminate(
				light,
				&infiniteLightDistribution[light->notIntersectable.infinite.distributionOffset],
				worldCenterX, worldCenterY, worldCenterZ, envRadius,
				u0, u1,
				point,
				lightRayDir, distance, directPdfW
				IMAGEMAPS_PARAM);
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		case TYPE_IL_SKY:
			return SkyLight_Illuminate(
				light,
				worldCenterX, worldCenterY, worldCenterZ, envRadius,
				u0, u1,
				point,
				lightRayDir, distance, directPdfW);
#endif
#if defined(PARAM_HAS_SKYLIGHT2)
		case TYPE_IL_SKY2:
			return SkyLight2_Illuminate(
				light,
				worldCenterX, worldCenterY, worldCenterZ, envRadius,
				u0, u1,
				point,
				lightRayDir, distance, directPdfW);
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		case TYPE_SUN:
			return SunLight_Illuminate(
				light,
				worldCenterX, worldCenterY, worldCenterZ, envRadius,
				point, u0, u1, lightRayDir, distance, directPdfW);
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		case TYPE_TRIANGLE:
			return TriangleLight_Illuminate(
					light,
					tmpHitPoint,
					point,
					u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
					passThroughEvent,
#endif
					lightRayDir, distance, directPdfW
					MATERIALS_PARAM);
#endif
#if defined(PARAM_HAS_POINTLIGHT)
		case TYPE_POINT:
			return PointLight_Illuminate(
					light, point,
					lightRayDir, distance, directPdfW);
#endif
#if defined(PARAM_HAS_MAPPOINTLIGHT)
		case TYPE_MAPPOINT:
			return MapPointLight_Illuminate(
					light, point,
					lightRayDir, distance, directPdfW
					IMAGEMAPS_PARAM);
#endif
#if defined(PARAM_HAS_SPOTLIGHT)
		case TYPE_SPOT:
			return SpotLight_Illuminate(
					light, point,
					lightRayDir, distance, directPdfW);
#endif
#if defined(PARAM_HAS_PROJECTIONLIGHT)
		case TYPE_PROJECTION:
			return ProjectionLight_Illuminate(
					light, point,
					lightRayDir, distance, directPdfW
					IMAGEMAPS_PARAM);
#endif
#if defined(PARAM_HAS_SHARPDISTANTLIGHT)
		case TYPE_SHARPDISTANT:
			return SharpDistantLight_Illuminate(
				light,
				worldCenterX, worldCenterY, worldCenterZ, envRadius,
				point, lightRayDir, distance, directPdfW);
#endif
#if defined(PARAM_HAS_DISTANTLIGHT)
		case TYPE_DISTANT:
			return DistantLight_Illuminate(
				light,
				worldCenterX, worldCenterY, worldCenterZ, envRadius,
				point, u0, u1, lightRayDir, distance, directPdfW);
#endif
#if defined(PARAM_HAS_LASERLIGHT)
		case TYPE_LASER:
			return LaserLight_Illuminate(
					light, point,
					lightRayDir, distance, directPdfW);
#endif
		default:
			return BLACK;
	}
}

bool Light_IsEnvOrIntersectable(__global const LightSource *light) {
	switch (light->type) {
#if defined(PARAM_HAS_CONSTANTINFINITELIGHT)
		case TYPE_IL_CONSTANT:
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
		case TYPE_IL:
#endif
#if defined(PARAM_HAS_SKYLIGHT)
		case TYPE_IL_SKY:
#endif
#if defined(PARAM_HAS_SKYLIGHT2)
		case TYPE_IL_SKY2:
#endif
#if defined(PARAM_HAS_SUNLIGHT)
		case TYPE_SUN:
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		case TYPE_TRIANGLE:
#endif
#if defined(PARAM_HAS_CONSTANTINFINITELIGHT) || defined(PARAM_HAS_INFINITELIGHT) || defined(PARAM_HAS_SKYLIGHT) || defined(PARAM_HAS_SKYLIGHT2) || defined(PARAM_HAS_SUNLIGHT) || (PARAM_TRIANGLE_LIGHT_COUNT > 0)
			return true;
#endif

#if defined(PARAM_HAS_POINTLIGHT)
		case TYPE_POINT:
#endif
#if defined(PARAM_HAS_MAPPOINTLIGHT)
		case TYPE_MAPPOINT:
#endif
#if defined(PARAM_HAS_SPOTLIGHT)
		case TYPE_SPOT:
#endif
#if defined(PARAM_HAS_PROJECTIONLIGHT)
		case TYPE_PROJECTION:
#endif
#if defined(PARAM_HAS_SHARPDISTANTLIGHT)
		case TYPE_SHARPDISTANT:
#endif
#if defined(PARAM_HAS_DISTANTLIGHT)
		case TYPE_DISTANT:
#endif
#if defined(PARAM_HAS_LASERLIGHT)
		case TYPE_LASER:
#endif
#if defined(PARAM_HAS_POINTLIGHT) || defined(PARAM_HAS_MAPPOINTLIGHT) || defined(PARAM_HAS_SPOTLIGHT) || defined(PARAM_HAS_PROJECTIONLIGHT) || defined(PARAM_HAS_SHARPDISTANTLIGHT) || defined(PARAM_HAS_DISTANTLIGHT) || defined(PARAM_HAS_LASERLIGHT)
			return false;
#endif

		default:
			return false;
	}
}
#line 2 "filter_funcs.cl"

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

//------------------------------------------------------------------------------
// Pixel related functions
//------------------------------------------------------------------------------

void PixelIndex2XY(const uint filmWidth, const uint index, uint *x, uint *y) {
	*y = index / filmWidth;
	*x = index - (*y) * filmWidth;
}

uint XY2PixelIndex(const uint filmWidth, const uint x, const uint y) {
	return x + y * filmWidth;
}

//------------------------------------------------------------------------------
// Image filtering related functions
//------------------------------------------------------------------------------

#if (PARAM_IMAGE_FILTER_TYPE == 0)

// Nothing

#elif (PARAM_IMAGE_FILTER_TYPE == 1)

// Box Filter
float ImageFilter_Evaluate(const float x, const float y) {
	return 1.f;
}

#elif (PARAM_IMAGE_FILTER_TYPE == 2)

float Gaussian(const float d, const float expv) {
	return max(0.f, exp(-PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA * d * d) - expv);
}

// Gaussian Filter
float ImageFilter_Evaluate(const float x, const float y) {
	return Gaussian(x,
			exp(-PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA * PARAM_IMAGE_FILTER_WIDTH_X * PARAM_IMAGE_FILTER_WIDTH_X)) *
		Gaussian(y,
			exp(-PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA * PARAM_IMAGE_FILTER_WIDTH_Y * PARAM_IMAGE_FILTER_WIDTH_Y));
}

#elif (PARAM_IMAGE_FILTER_TYPE == 3)

float Mitchell1D(float x) {
	const float B = PARAM_IMAGE_FILTER_MITCHELL_B;
	const float C = PARAM_IMAGE_FILTER_MITCHELL_C;

	if (x >= 1.f)
		return 0.f;
	x = fabs(2.f * x);

	if (x > 1.f)
		return (((-B / 6.f - C) * x + (B + 5.f * C)) * x +
			(-2.f * B - 8.f * C)) * x + (4.f / 3.f * B + 4.f * C);
	else
		return ((2.f - 1.5f * B - C) * x +
			(-3.f + 2.f * B + C)) * x * x +
			(1.f - B / 3.f);
}

// Mitchell Filter
float ImageFilter_Evaluate(const float x, const float y) {
	const float distance = native_sqrt(
			x * x * (1.f / (PARAM_IMAGE_FILTER_WIDTH_X * PARAM_IMAGE_FILTER_WIDTH_X)) +
			y * y * (1.f / (PARAM_IMAGE_FILTER_WIDTH_Y * PARAM_IMAGE_FILTER_WIDTH_Y)));

	return Mitchell1D(distance);
}

#elif (PARAM_IMAGE_FILTER_TYPE == 4)

float BlackmanHarris1D(float x) {
	if (x < -1.f || x > 1.f)
		return 0.f;
	x = (x + 1.f) * .5f;
	x *= M_PI_F;
	const float A0 =  0.35875f;
	const float A1 = -0.48829f;
	const float A2 =  0.14128f;
	const float A3 = -0.01168f;
	return A0 + A1 * cos(2.f * x) + A2 * cos(4.f * x) + A3 * cos(6.f * x);
}

// Blackman-Harris Filter
float ImageFilter_Evaluate(const float x, const float y) {
	return BlackmanHarris1D(x * (1.f / PARAM_IMAGE_FILTER_WIDTH_X)) *
			BlackmanHarris1D(y *  (1.f / PARAM_IMAGE_FILTER_WIDTH_Y));
}

#else

Error: unknown image filter !!!

#endif
#line 2 "film_funcs.cl"

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

void SampleResult_Init(__global SampleResult *sampleResult) {
	// Initialize only Spectrum fields

#if defined(PARAM_FILM_RADIANCE_GROUP_0)
	VSTORE3F(BLACK, sampleResult->radiancePerPixelNormalized[0].c);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
	VSTORE3F(BLACK, sampleResult->radiancePerPixelNormalized[1].c);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
	VSTORE3F(BLACK, sampleResult->radiancePerPixelNormalized[2].c);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
	VSTORE3F(BLACK, sampleResult->radiancePerPixelNormalized[3].c);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
	VSTORE3F(BLACK, sampleResult->radiancePerPixelNormalized[4].c);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
	VSTORE3F(BLACK, sampleResult->radiancePerPixelNormalized[5].c);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
	VSTORE3F(BLACK, sampleResult->radiancePerPixelNormalized[6].c);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
	VSTORE3F(BLACK, sampleResult->radiancePerPixelNormalized[7].c);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
	VSTORE3F(BLACK, sampleResult->directDiffuse.c);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
	VSTORE3F(BLACK, sampleResult->directGlossy.c);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
	VSTORE3F(BLACK, sampleResult->emission.c);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
	VSTORE3F(BLACK, sampleResult->indirectDiffuse.c);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
	VSTORE3F(BLACK, sampleResult->indirectGlossy.c);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
	VSTORE3F(BLACK, sampleResult->indirectSpecular.c);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
	sampleResult->rayCount = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
	VSTORE3F(BLACK, sampleResult->irradiance.c);
#endif

	sampleResult->firstPathVertexEvent = NONE;
	sampleResult->firstPathVertex = true;
	// sampleResult->lastPathVertex can not be really initialized here without knowing
	// the max. path depth.
	sampleResult->lastPathVertex = true;
}

void SampleResult_AddEmission(__global SampleResult *sampleResult, const uint lightID,
		const float3 pathThroughput, const float3 incomingRadiance) {
	const float3 radiance = pathThroughput * incomingRadiance;

	// Avoid out of bound access if the light group doesn't exist. This can happen
	// with RT modes.
	const uint id = min(lightID, PARAM_FILM_RADIANCE_GROUP_COUNT - 1u);
	VADD3F(sampleResult->radiancePerPixelNormalized[id].c, radiance);

	if (sampleResult->firstPathVertex) {
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
		VADD3F(sampleResult->emission.c, radiance);
#endif
	} else {
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
		sampleResult->indirectShadowMask = 0.f;
#endif
		const BSDFEvent firstPathVertexEvent = sampleResult->firstPathVertexEvent;
		if (firstPathVertexEvent & DIFFUSE) {
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
			VADD3F(sampleResult->indirectDiffuse.c, radiance);
#endif
		} else if (firstPathVertexEvent & GLOSSY) {
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
			VADD3F(sampleResult->indirectGlossy.c, radiance);
#endif
		} else if (firstPathVertexEvent & SPECULAR) {
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
			VADD3F(sampleResult->indirectSpecular.c, radiance);
#endif
		}
	}
}

void SampleResult_AddDirectLight(__global SampleResult *sampleResult, const uint lightID,
		const BSDFEvent bsdfEvent, const float3 pathThroughput, const float3 incomingRadiance,
		const float lightScale) {
	const float3 radiance = pathThroughput * incomingRadiance;

	// Avoid out of bound access if the light group doesn't exist. This can happen
	// with RT modes.
	const uint id = min(lightID, PARAM_FILM_RADIANCE_GROUP_COUNT - 1u);
	VADD3F(sampleResult->radiancePerPixelNormalized[id].c, radiance);

	if (sampleResult->firstPathVertex) {
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
		sampleResult->directShadowMask = fmax(0.f, sampleResult->directShadowMask - lightScale);
#endif

		if (bsdfEvent & DIFFUSE) {
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
			VADD3F(sampleResult->directDiffuse.c, radiance);
#endif
		} else {
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
			VADD3F(sampleResult->directGlossy.c, radiance);
#endif
		}
	} else {
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
		sampleResult->indirectShadowMask = fmax(0.f, sampleResult->indirectShadowMask - lightScale);
#endif

		const BSDFEvent firstPathVertexEvent = sampleResult->firstPathVertexEvent;
		if (firstPathVertexEvent & DIFFUSE) {
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
			VADD3F(sampleResult->indirectDiffuse.c, radiance);
#endif
		} else if (firstPathVertexEvent & GLOSSY) {
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
			VADD3F(sampleResult->indirectGlossy.c, radiance);
#endif
		} else if (firstPathVertexEvent & SPECULAR) {
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
			VADD3F(sampleResult->indirectSpecular.c, radiance);
#endif
		}

#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
		VADD3F(sampleResult->irradiance.c, VLOAD3F(sampleResult->irradiancePathThroughput.c) * incomingRadiance);
#endif
	}
}

float SampleResult_Radiance_Y(__global SampleResult *sampleResult) {
	float y = 0.f;
#if defined(PARAM_FILM_RADIANCE_GROUP_0)
	y += Spectrum_Y(VLOAD3F(sampleResult->radiancePerPixelNormalized[0].c));
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
	y += Spectrum_Y(VLOAD3F(sampleResult->radiancePerPixelNormalized[1].c));
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
	y += Spectrum_Y(VLOAD3F(sampleResult->radiancePerPixelNormalized[2].c));
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
	y += Spectrum_Y(VLOAD3F(sampleResult->radiancePerPixelNormalized[3].c));
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
	y += Spectrum_Y(VLOAD3F(sampleResult->radiancePerPixelNormalized[4].c));
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
	y += Spectrum_Y(VLOAD3F(sampleResult->radiancePerPixelNormalized[5].c));
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
	y += Spectrum_Y(VLOAD3F(sampleResult->radiancePerPixelNormalized[6].c));
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
	y += Spectrum_Y(VLOAD3F(sampleResult->radiancePerPixelNormalized[7].c));
#endif

	return y;
}

void SampleResult_ClampRadiance(__global SampleResult *sampleResult, const float cap) {
	// Initialize only Spectrum fields

#if defined(PARAM_FILM_RADIANCE_GROUP_0)
	sampleResult->radiancePerPixelNormalized[0].c[0] = clamp(sampleResult->radiancePerPixelNormalized[0].c[0], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[0].c[1] = clamp(sampleResult->radiancePerPixelNormalized[0].c[1], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[0].c[2] = clamp(sampleResult->radiancePerPixelNormalized[0].c[2], 0.f, cap);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
	sampleResult->radiancePerPixelNormalized[1].c[0] = clamp(sampleResult->radiancePerPixelNormalized[1].c[0], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[1].c[1] = clamp(sampleResult->radiancePerPixelNormalized[1].c[1], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[1].c[2] = clamp(sampleResult->radiancePerPixelNormalized[1].c[2], 0.f, cap);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
	sampleResult->radiancePerPixelNormalized[2].c[0] = clamp(sampleResult->radiancePerPixelNormalized[2].c[0], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[2].c[1] = clamp(sampleResult->radiancePerPixelNormalized[2].c[1], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[2].c[2] = clamp(sampleResult->radiancePerPixelNormalized[2].c[2], 0.f, cap);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
	sampleResult->radiancePerPixelNormalized[3].c[0] = clamp(sampleResult->radiancePerPixelNormalized[3].c[0], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[3].c[1] = clamp(sampleResult->radiancePerPixelNormalized[3].c[1], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[3].c[2] = clamp(sampleResult->radiancePerPixelNormalized[3].c[2], 0.f, cap);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
	sampleResult->radiancePerPixelNormalized[4].c[0] = clamp(sampleResult->radiancePerPixelNormalized[4].c[0], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[4].c[1] = clamp(sampleResult->radiancePerPixelNormalized[4].c[1], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[4].c[2] = clamp(sampleResult->radiancePerPixelNormalized[4].c[2], 0.f, cap);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
	sampleResult->radiancePerPixelNormalized[5].c[0] = clamp(sampleResult->radiancePerPixelNormalized[5].c[0], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[5].c[1] = clamp(sampleResult->radiancePerPixelNormalized[5].c[1], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[5].c[2] = clamp(sampleResult->radiancePerPixelNormalized[5].c[2], 0.f, cap);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
	sampleResult->radiancePerPixelNormalized[6].c[0] = clamp(sampleResult->radiancePerPixelNormalized[6].c[0], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[6].c[1] = clamp(sampleResult->radiancePerPixelNormalized[6].c[1], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[6].c[2] = clamp(sampleResult->radiancePerPixelNormalized[6].c[2], 0.f, cap);
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
	sampleResult->radiancePerPixelNormalized[7].c[0] = clamp(sampleResult->radiancePerPixelNormalized[7].c[0], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[7].c[1] = clamp(sampleResult->radiancePerPixelNormalized[7].c[1], 0.f, cap);
	sampleResult->radiancePerPixelNormalized[7].c[2] = clamp(sampleResult->radiancePerPixelNormalized[7].c[2], 0.f, cap);
#endif
}

#if defined(PARAM_USE_PIXEL_ATOMICS)
void AtomicAdd(__global float *val, const float delta) {
	union {
		float f;
		unsigned int i;
	} oldVal;
	union {
		float f;
		unsigned int i;
	} newVal;

	do {
		oldVal.f = *val;
		newVal.f = oldVal.f + delta;
	} while (atomic_cmpxchg((__global unsigned int *)val, oldVal.i, newVal.i) != oldVal.i);
}

bool AtomicMin(__global float *val, const float val2) {
	union {
		float f;
		unsigned int i;
	} oldVal;
	union {
		float f;
		unsigned int i;
	} newVal;

	do {
		oldVal.f = *val;
		if (val2 >= oldVal.f)
			return false;
		else
			newVal.f = val2;
	} while (atomic_cmpxchg((__global unsigned int *)val, oldVal.i, newVal.i) != oldVal.i);

	return true;
}
#endif

void Film_SetPixel2(__global float *dst, __global  float *val) {
	dst[0] = val[0];
	dst[1] = val[1];
}

void Film_SetPixel3(__global float *dst, __global  float *val) {
	dst[0] = val[0];
	dst[1] = val[1];
	dst[2] = val[2];
}

bool Film_MinPixel(__global float *dst, const float val) {
#if defined(PARAM_USE_PIXEL_ATOMICS)
	return AtomicMin(&dst[0], val);
#else
	if (val < dst[0]) {
		dst[0] = val;
		return true;
	} else
		return false;
#endif
}

void Film_AddPixelVal(__global float *dst, const float val) {
#if defined(PARAM_USE_PIXEL_ATOMICS)
	AtomicAdd(&dst[0], val);
#else
	dst[0] += val;
#endif
}

void Film_AddWeightedPixel2Val(__global float *dst, const float val, const float weight) {
#if defined(PARAM_USE_PIXEL_ATOMICS)
	AtomicAdd(&dst[0], val * weight);
	AtomicAdd(&dst[1], weight);
#else
	dst[0] += val * weight;
	dst[1] += weight;
#endif
}

void Film_AddWeightedPixel2(__global float *dst, __global float *val, const float weight) {
#if defined(PARAM_USE_PIXEL_ATOMICS)
	AtomicAdd(&dst[0], val[0] * weight);
	AtomicAdd(&dst[1], weight);
#else
	dst[0] += val[0] * weight;
	dst[1] += weight;
#endif
}

void Film_AddWeightedPixel4Val(__global float *dst, float3 val, const float weight) {
	const float r = val.s0;
	const float g = val.s1;
	const float b = val.s2;

	if (!isnan(r) && !isinf(r) &&
			!isnan(g) && !isinf(g) &&
			!isnan(b) && !isinf(b) &&
			!isnan(weight) && !isinf(weight)) {
#if defined(PARAM_USE_PIXEL_ATOMICS)
		AtomicAdd(&dst[0], r * weight);
		AtomicAdd(&dst[1], g * weight);
		AtomicAdd(&dst[2], b * weight);
		AtomicAdd(&dst[3], weight);
#else
		float4 p = VLOAD4F(dst);
		const float4 s = (float4)(r * weight, g * weight, b * weight, weight);
		p += s;
		VSTORE4F(p, dst);
#endif
	} /*else {
		printf("NaN/Inf. error: (%f, %f, %f) [%f]\n", r, g, b, weight);
	}*/
}

void Film_AddWeightedPixel4(__global float *dst, __global float *val, const float weight) {
	const float r = val[0];
	const float g = val[1];
	const float b = val[2];

	if (!isnan(r) && !isinf(r) &&
			!isnan(g) && !isinf(g) &&
			!isnan(b) && !isinf(b) &&
			!isnan(weight) && !isinf(weight)) {
#if defined(PARAM_USE_PIXEL_ATOMICS)
		AtomicAdd(&dst[0], r * weight);
		AtomicAdd(&dst[1], g * weight);
		AtomicAdd(&dst[2], b * weight);
		AtomicAdd(&dst[3], weight);
#else
		float4 p = VLOAD4F(dst);
		const float4 s = (float4)(r * weight, g * weight, b * weight, weight);
		p += s;
		VSTORE4F(p, dst);
#endif
	} /*else {
		printf("NaN/Inf. error: (%f, %f, %f) [%f]\n", r, g, b, weight);
	}*/
}

void Film_AddSampleResultColor(const uint x, const uint y,
		__global SampleResult *sampleResult, const float weight
		FILM_PARAM_DECL) {
	const uint index1 = x + y * filmWidth;
	const uint index2 = index1 * 2;
	const uint index4 = index1 * 4;

#if defined (PARAM_FILM_RADIANCE_GROUP_0)
	Film_AddWeightedPixel4(&((filmRadianceGroup[0])[index4]), sampleResult->radiancePerPixelNormalized[0].c, weight);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_1)
	Film_AddWeightedPixel4(&((filmRadianceGroup[1])[index4]), sampleResult->radiancePerPixelNormalized[1].c, weight);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_2)
	Film_AddWeightedPixel4(&((filmRadianceGroup[2])[index4]), sampleResult->radiancePerPixelNormalized[2].c, weight);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_3)
	Film_AddWeightedPixel4(&((filmRadianceGroup[3])[index4]), sampleResult->radiancePerPixelNormalized[3].c, weight);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_4)
	Film_AddWeightedPixel4(&((filmRadianceGroup[4])[index4]), sampleResult->radiancePerPixelNormalized[4].c, weight);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_5)
	Film_AddWeightedPixel4(&((filmRadianceGroup[5])[index4]), sampleResult->radiancePerPixelNormalized[5].c, weight);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_6)
	Film_AddWeightedPixel4(&((filmRadianceGroup[6])[index4]), sampleResult->radiancePerPixelNormalized[6].c, weight);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_7)
	Film_AddWeightedPixel4(&((filmRadianceGroup[7])[index4]), sampleResult->radiancePerPixelNormalized[7].c, weight);
#endif
#if defined (PARAM_FILM_CHANNELS_HAS_ALPHA)
	Film_AddWeightedPixel2(&filmAlpha[index2], &sampleResult->alpha, weight);
#endif
#if defined (PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
	Film_AddWeightedPixel4(&filmDirectDiffuse[index4], sampleResult->directDiffuse.c, weight);
#endif
#if defined (PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
	Film_AddWeightedPixel4(&filmDirectGlossy[index4], sampleResult->directGlossy.c, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
	Film_AddWeightedPixel4(&filmEmission[index4], sampleResult->emission.c, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
	Film_AddWeightedPixel4(&filmIndirectDiffuse[index4], sampleResult->indirectDiffuse.c, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
	Film_AddWeightedPixel4(&filmIndirectGlossy[index4], sampleResult->indirectGlossy.c, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
	Film_AddWeightedPixel4(&filmIndirectSpecular[index4], sampleResult->indirectSpecular.c, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID_MASK)
	const float materialIDMask = (sampleResult->materialID == PARAM_FILM_MASK_MATERIAL_ID) ? 1.f : 0.f;
	Film_AddWeightedPixel2Val(&filmMaterialIDMask[index2], materialIDMask, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
	Film_AddWeightedPixel2(&filmDirectShadowMask[index2], &sampleResult->directShadowMask, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
	Film_AddWeightedPixel2(&filmIndirectShadowMask[index2], &sampleResult->indirectShadowMask, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_BY_MATERIAL_ID)
	float3 byMaterialIDColor = BLACK;

	if (sampleResult->materialID == PARAM_FILM_BY_MATERIAL_ID) {
#if defined (PARAM_FILM_RADIANCE_GROUP_0)
		byMaterialIDColor += VLOAD3F(sampleResult->radiancePerPixelNormalized[0].c);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_1)
		byMaterialIDColor += VLOAD3F(sampleResult->radiancePerPixelNormalized[1].c);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_2)
		byMaterialIDColor += VLOAD3F(sampleResult->radiancePerPixelNormalized[2].c);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_3)
		byMaterialIDColor += VLOAD3F(sampleResult->radiancePerPixelNormalized[3].c);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_4)
		byMaterialIDColor += VLOAD3F(sampleResult->radiancePerPixelNormalized[4].c);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_5)
		byMaterialIDColor += VLOAD3F(sampleResult->radiancePerPixelNormalized[5].c);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_6)
		byMaterialIDColor += VLOAD3F(sampleResult->radiancePerPixelNormalized[6].c);
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_7)
		byMaterialIDColor += VLOAD3F(sampleResult->radiancePerPixelNormalized[7].c);
#endif
	}
	Film_AddWeightedPixel4Val(&filmByMaterialID[index4], byMaterialIDColor, weight);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
	Film_AddWeightedPixel4(&filmIrradiance[index4], sampleResult->irradiance.c, weight);
#endif
}

void Film_AddSampleResultData(const uint x, const uint y,
		__global SampleResult *sampleResult
		FILM_PARAM_DECL) {
	const uint index1 = x + y * filmWidth;
	const uint index2 = index1 * 2;
	const uint index3 = index1 * 3;

	bool depthWrite = true;
#if defined (PARAM_FILM_CHANNELS_HAS_DEPTH)
	depthWrite = Film_MinPixel(&filmDepth[index1], sampleResult->depth);
#endif

	if (depthWrite) {
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
		Film_SetPixel3(&filmPosition[index3], &sampleResult->position.x);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
		Film_SetPixel3(&filmGeometryNormal[index3], &sampleResult->geometryNormal.x);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
		Film_SetPixel3(&filmShadingNormal[index3], &sampleResult->shadingNormal.x);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
		filmMaterialID[index1] = sampleResult->materialID;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
		Film_SetPixel2(&filmUV[index2], &sampleResult->uv.u);
#endif
	}

#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
	Film_AddPixelVal(&filmRayCount[index1], sampleResult->rayCount);
#endif
}

void Film_AddSample(const uint x, const uint y,
		__global SampleResult *sampleResult, const float weight
		FILM_PARAM_DECL) {
	Film_AddSampleResultColor(x, y, sampleResult, weight
			FILM_PARAM);
	Film_AddSampleResultData(x, y, sampleResult
			FILM_PARAM);
}

#if (PARAM_IMAGE_FILTER_TYPE == 0)

void Film_SplatSample(__global SampleResult *sampleResult, const float weight
	FILM_PARAM_DECL) {
	const int x = Floor2Int(sampleResult->filmX);
	const int y = Floor2Int(sampleResult->filmY);

	if ((x >= 0) && (x < (int)filmWidth) && (y >= 0) && (y < (int)filmHeight)) {
		Film_AddSampleResultColor((uint)x, (uint)y, sampleResult, weight
				FILM_PARAM);
		Film_AddSampleResultData((uint)x, (uint)y, sampleResult
				FILM_PARAM);
	}
}

#elif (PARAM_IMAGE_FILTER_TYPE == 1) || (PARAM_IMAGE_FILTER_TYPE == 2) || (PARAM_IMAGE_FILTER_TYPE == 3) || (PARAM_IMAGE_FILTER_TYPE == 4)

void Film_AddSampleFilteredResultColor(const int x, const int y,
		const float distX, const float distY,
		__global SampleResult *sampleResult, const float weight
		FILM_PARAM_DECL) {
	if ((x >= 0) && (x < (int)filmWidth) && (y >= 0) && (y < (int)filmHeight)) {
		const float filterWeight = ImageFilter_Evaluate(distX, distY);

		Film_AddSampleResultColor(x, y, sampleResult, weight * filterWeight
			FILM_PARAM);
	}
}

void Film_SplatSample(__global SampleResult *sampleResult, const float weight
	FILM_PARAM_DECL) {
	const float px = sampleResult->filmX;
	const float py = sampleResult->filmY;

	//----------------------------------------------------------------------
	// Add all data related information (not filtered)
	//----------------------------------------------------------------------

#if defined (PARAM_FILM_CHANNELS_HAS_DEPTH) || defined (PARAM_FILM_CHANNELS_HAS_POSITION) || defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL) || defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL) || defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID) || defined(PARAM_FILM_CHANNELS_HAS_UV) || defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
	{
		const int x = Floor2Int(px);
		const int y = Floor2Int(py);

		if ((x >= 0) && (x < (int)filmWidth) && (y >= 0) && (y < (int)filmHeight)) {
			Film_AddSampleResultData((uint)x, (uint)y, sampleResult
					FILM_PARAM);
		}
	}
#endif

	//----------------------------------------------------------------------
	// Add all color related information (filtered)
	//----------------------------------------------------------------------

	const uint x = min((uint)floor(px), (uint)(filmWidth - 1));
	const uint y = min((uint)floor(py), (uint)(filmHeight - 1));

	const float sx = px - (float)x;
	const float sy = py - (float)y;

	for (int dy = -PARAM_IMAGE_FILTER_PIXEL_WIDTH_Y; dy <= PARAM_IMAGE_FILTER_PIXEL_WIDTH_Y; ++dy) {
		for (int dx = -PARAM_IMAGE_FILTER_PIXEL_WIDTH_X; dx <= PARAM_IMAGE_FILTER_PIXEL_WIDTH_X; ++dx) {
			Film_AddSampleFilteredResultColor(x + dx, y + dy, sx - dx, sy - dy,
					sampleResult, weight
					FILM_PARAM);
		}
	}
}

#else

Error: unknown image filter !!!

#endif

//------------------------------------------------------------------------------
// Film_Clear Kernel
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void Film_Clear(
		const uint filmWidth, const uint filmHeight
#if defined(PARAM_FILM_RADIANCE_GROUP_0)
		, __global float *filmRadianceGroup0
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
		, __global float *filmRadianceGroup1
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
		, __global float *filmRadianceGroup2
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
		, __global float *filmRadianceGroup3
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
		, __global float *filmRadianceGroup4
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
		, __global float *filmRadianceGroup5
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
		, __global float *filmRadianceGroup6
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
		, __global float *filmRadianceGroup7
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
		, __global float *filmAlpha
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
		, __global float *filmDepth
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
		, __global float *filmPosition
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
		, __global float *filmGeometryNormal
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
		, __global float *filmShadingNormal
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
		, __global uint *filmMaterialID
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
		, __global float *filmDirectDiffuse
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
		, __global float *filmDirectGlossy
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
		, __global float *filmEmission
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
		, __global float *filmIndirectDiffuse
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
		, __global float *filmIndirectGlossy
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
		, __global float *filmIndirectSpecular
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID_MASK)
		, __global float *filmMaterialIDMask
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
		, __global float *filmDirectShadowMask
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
		, __global float *filmIndirectShadowMask
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
		, __global float *filmUV
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
		, __global float *filmRayCount
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_BY_MATERIAL_ID)
		, __global float *filmByMaterialID
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
		, __global float *filmIrradiance
#endif
		) {
	const size_t gid = get_global_id(0);
	if (gid >= filmWidth * filmHeight)
		return;

#if defined (PARAM_FILM_RADIANCE_GROUP_0)
	filmRadianceGroup0[gid * 4] = 0.f;
	filmRadianceGroup0[gid * 4 + 1] = 0.f;
	filmRadianceGroup0[gid * 4 + 2] = 0.f;
	filmRadianceGroup0[gid * 4 + 3] = 0.f;
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_1)
	filmRadianceGroup1[gid * 4] = 0.f;
	filmRadianceGroup1[gid * 4 + 1] = 0.f;
	filmRadianceGroup1[gid * 4 + 2] = 0.f;
	filmRadianceGroup1[gid * 4 + 3] = 0.f;
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_2)
	filmRadianceGroup2[gid * 4] = 0.f;
	filmRadianceGroup2[gid * 4 + 1] = 0.f;
	filmRadianceGroup2[gid * 4 + 2] = 0.f;
	filmRadianceGroup2[gid * 4 + 3] = 0.f;
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_3)
	filmRadianceGroup3[gid * 4] = 0.f;
	filmRadianceGroup3[gid * 4 + 1] = 0.f;
	filmRadianceGroup3[gid * 4 + 2] = 0.f;
	filmRadianceGroup3[gid * 4 + 3] = 0.f;
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_4)
	filmRadianceGroup4[gid * 4] = 0.f;
	filmRadianceGroup4[gid * 4 + 1] = 0.f;
	filmRadianceGroup4[gid * 4 + 2] = 0.f;
	filmRadianceGroup4[gid * 4 + 3] = 0.f;
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_5)
	filmRadianceGroup5[gid * 4] = 0.f;
	filmRadianceGroup5[gid * 4 + 1] = 0.f;
	filmRadianceGroup5[gid * 4 + 2] = 0.f;
	filmRadianceGroup5[gid * 4 + 3] = 0.f;
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_6)
	filmRadianceGroup6[gid * 4] = 0.f;
	filmRadianceGroup6[gid * 4 + 1] = 0.f;
	filmRadianceGroup6[gid * 4 + 2] = 0.f;
	filmRadianceGroup6[gid * 4 + 3] = 0.f;
#endif
#if defined (PARAM_FILM_RADIANCE_GROUP_7)
	filmRadianceGroup7[gid * 4] = 0.f;
	filmRadianceGroup7[gid * 4 + 1] = 0.f;
	filmRadianceGroup7[gid * 4 + 2] = 0.f;
	filmRadianceGroup7[gid * 4 + 3] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
	filmAlpha[gid * 2] = 0.f;
	filmAlpha[gid * 2 + 1] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
	filmDepth[gid] = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
	filmPosition[gid * 3] = INFINITY;
	filmPosition[gid * 3 + 1] = INFINITY;
	filmPosition[gid * 3 + 2] = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
	filmGeometryNormal[gid * 3] = INFINITY;
	filmGeometryNormal[gid * 3 + 1] = INFINITY;
	filmGeometryNormal[gid * 3 + 2] = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
	filmShadingNormal[gid * 3] = INFINITY;
	filmShadingNormal[gid * 3 + 1] = INFINITY;
	filmShadingNormal[gid * 3 + 2] = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
	filmMaterialID[gid] = NULL_INDEX;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
	filmDirectDiffuse[gid * 4] = 0.f;
	filmDirectDiffuse[gid * 4 + 1] = 0.f;
	filmDirectDiffuse[gid * 4 + 2] = 0.f;
	filmDirectDiffuse[gid * 4 + 3] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
	filmDirectGlossy[gid * 4] = 0.f;
	filmDirectGlossy[gid * 4 + 1] = 0.f;
	filmDirectGlossy[gid * 4 + 2] = 0.f;
	filmDirectGlossy[gid * 4 + 3] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
	filmEmission[gid * 4] = 0.f;
	filmEmission[gid * 4 + 1] = 0.f;
	filmEmission[gid * 4 + 2] = 0.f;
	filmEmission[gid * 4 + 3] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
	filmIndirectDiffuse[gid * 4] = 0.f;
	filmIndirectDiffuse[gid * 4 + 1] = 0.f;
	filmIndirectDiffuse[gid * 4 + 2] = 0.f;
	filmIndirectDiffuse[gid * 4 + 3] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
	filmIndirectGlossy[gid * 4] = 0.f;
	filmIndirectGlossy[gid * 4 + 1] = 0.f;
	filmIndirectGlossy[gid * 4 + 2] = 0.f;
	filmIndirectGlossy[gid * 4 + 3] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
	filmIndirectSpecular[gid * 4] = 0.f;
	filmIndirectSpecular[gid * 4 + 1] = 0.f;
	filmIndirectSpecular[gid * 4 + 2] = 0.f;
	filmIndirectSpecular[gid * 4 + 3] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID_MASK)
	filmMaterialIDMask[gid * 2] = 0.f;
	filmMaterialIDMask[gid * 2 + 1] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
	filmDirectShadowMask[gid * 2] = 0.f;
	filmDirectShadowMask[gid * 2 + 1] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
	filmIndirectShadowMask[gid * 2] = 0.f;
	filmIndirectShadowMask[gid * 2 + 1] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
	filmUV[gid * 2] = INFINITY;
	filmUV[gid * 2 + 1] = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
	filmRayCount[gid] = 0;
#endif
#if defined (PARAM_FILM_CHANNELS_HAS_BY_MATERIAL_ID)
	filmByMaterialID[gid * 4] = 0.f;
	filmByMaterialID[gid * 4 + 1] = 0.f;
	filmByMaterialID[gid * 4 + 2] = 0.f;
	filmByMaterialID[gid * 4 + 3] = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
	filmIrradiance[gid * 4] = 0.f;
	filmIrradiance[gid * 4 + 1] = 0.f;
	filmIrradiance[gid * 4 + 2] = 0.f;
	filmIrradiance[gid * 4 + 3] = 0.f;
#endif
}
#line 2 "sampler_funcs.cl"

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

//------------------------------------------------------------------------------
// Random Sampler Kernel
//------------------------------------------------------------------------------

#if (PARAM_SAMPLER_TYPE == 0)

#define Sampler_GetSamplePath(index) (Rnd_FloatValue(seed))
#define Sampler_GetSamplePathVertex(depth, index) (Rnd_FloatValue(seed))

__global float *Sampler_GetSampleData(__global Sample *sample, __global float *samplesData) {
	const size_t gid = get_global_id(0);
	return &samplesData[gid * TOTAL_U_SIZE];
}

__global float *Sampler_GetSampleDataPathBase(__global Sample *sample, __global float *sampleData) {
	return sampleData;
}

__global float *Sampler_GetSampleDataPathVertex(__global Sample *sample,
		__global float *sampleDataPathBase, const uint depth) {
	return &sampleDataPathBase[IDX_BSDF_OFFSET + depth * VERTEX_SAMPLE_SIZE];
}

void Sampler_SplatSample(
		Seed *seed,
		__global Sample *sample,
		__global float *sampleData
		FILM_PARAM_DECL
		) {
	Film_SplatSample(&sample->result, 1.f
			FILM_PARAM);
}

void Sampler_NextSample(
		Seed *seed,
		__global Sample *sample,
		__global float *sampleData,
		const uint filmWidth, const uint filmHeight
		) {
	// Move to the next sample
	const float u0 = Rnd_FloatValue(seed);
	const float u1 = Rnd_FloatValue(seed);

	// TODO: remove sampleData[]
	sampleData[IDX_SCREEN_X] = u0;
	sampleData[IDX_SCREEN_Y] = u1;

	SampleResult_Init(&sample->result);
	sample->result.filmX = min(u0 * filmWidth, (float)(filmWidth - 1));
	sample->result.filmY = min(u1 * filmHeight, (float)(filmHeight - 1));
}

void Sampler_Init(Seed *seed, __global Sample *sample, __global float *sampleData,
		const uint filmWidth, const uint filmHeight) {
	Sampler_NextSample(seed, sample, sampleData, filmWidth, filmHeight);
}

#endif

//------------------------------------------------------------------------------
// Metropolis Sampler Kernel
//------------------------------------------------------------------------------

#if (PARAM_SAMPLER_TYPE == 1)

#define Sampler_GetSamplePath(index) (sampleDataPathBase[index])
#define Sampler_GetSamplePathVertex(depth, index) (sampleDataPathVertexBase[index])

__global float *Sampler_GetSampleData(__global Sample *sample, __global float *samplesData) {
	const size_t gid = get_global_id(0);
	return &samplesData[gid * (2 * TOTAL_U_SIZE)];
}

__global float *Sampler_GetSampleDataPathBase(__global Sample *sample, __global float *sampleData) {
	return &sampleData[sample->proposed * TOTAL_U_SIZE];
}

__global float *Sampler_GetSampleDataPathVertex(__global Sample *sample,
		__global float *sampleDataPathBase, const uint depth) {
	return &sampleDataPathBase[IDX_BSDF_OFFSET + depth * VERTEX_SAMPLE_SIZE];
}

void LargeStep(Seed *seed, __global float *proposedU) {
	for (int i = 0; i < TOTAL_U_SIZE; ++i)
		proposedU[i] = Rnd_FloatValue(seed);
}

float Mutate(Seed *seed, const float x) {
	const float s1 = 1.f / 512.f;
	const float s2 = 1.f / 16.f;

	const float randomValue = Rnd_FloatValue(seed);

	const float dx = s1 / (s1 / s2 + fabs(2.f * randomValue - 1.f)) -
		s1 / (s1 / s2 + 1.f);

	float mutatedX = x;
	if (randomValue < 0.5f) {
		mutatedX += dx;
		mutatedX = (mutatedX < 1.f) ? mutatedX : (mutatedX - 1.f);
	} else {
		mutatedX -= dx;
		mutatedX = (mutatedX < 0.f) ? (mutatedX + 1.f) : mutatedX;
	}

	return mutatedX;
}

float MutateScaled(Seed *seed, const float x, const float range) {
	const float s1 = 32.f;

	const float randomValue = Rnd_FloatValue(seed);

	const float dx = range / (s1 / (1.f + s1) + (s1 * s1) / (1.f + s1) *
		fabs(2.f * randomValue - 1.f)) - range / s1;

	float mutatedX = x;
	if (randomValue < 0.5f) {
		mutatedX += dx;
		mutatedX = (mutatedX < 1.f) ? mutatedX : (mutatedX - 1.f);
	} else {
		mutatedX -= dx;
		mutatedX = (mutatedX < 0.f) ? (mutatedX + 1.f) : mutatedX;
	}

	return mutatedX;
}

void SmallStep(Seed *seed, __global float *currentU, __global float *proposedU) {
	proposedU[IDX_SCREEN_X] = MutateScaled(seed, currentU[IDX_SCREEN_X],
			PARAM_SAMPLER_METROPOLIS_IMAGE_MUTATION_RANGE);
	proposedU[IDX_SCREEN_Y] = MutateScaled(seed, currentU[IDX_SCREEN_Y],
			PARAM_SAMPLER_METROPOLIS_IMAGE_MUTATION_RANGE);

	for (int i = IDX_SCREEN_Y + 1; i < TOTAL_U_SIZE; ++i)
		proposedU[i] = Mutate(seed, currentU[i]);
}

void Sampler_Init(Seed *seed, __global Sample *sample, __global float *sampleData,
		const uint filmWidth, const uint filmHeight) {
	sample->totalI = 0.f;
	sample->largeMutationCount = 1.f;

	sample->current = NULL_INDEX;
	sample->proposed = 1;

	sample->smallMutationCount = 0;
	sample->consecutiveRejects = 0;

	sample->weight = 0.f;

	__global float *sampleDataPathBase = Sampler_GetSampleDataPathBase(sample, sampleData);
	LargeStep(seed, sampleDataPathBase);

	SampleResult_Init(&sample->result);
	sample->result.filmX = min(sampleDataPathBase[IDX_SCREEN_X] * filmWidth, (float)(filmWidth - 1));
	sample->result.filmY = min(sampleDataPathBase[IDX_SCREEN_Y] * filmHeight, (float)(filmHeight - 1));
}

void Sampler_SplatSample(
		Seed *seed,
		__global Sample *sample,
		__global float *sampleData
		FILM_PARAM_DECL
		) {
	//--------------------------------------------------------------------------
	// Accept/Reject the sample
	//--------------------------------------------------------------------------

	uint current = sample->current;
	uint proposed = sample->proposed;

	if (current == NULL_INDEX) {
		// It is the very first sample, I have still to initialize the current
		// sample

		Film_SplatSample(&sample->result, 1.f
					FILM_PARAM);

		sample->currentResult = sample->result;
		sample->totalI = SampleResult_Radiance_Y(&sample->result);

		current = proposed;
		proposed ^= 1;
	} else {
		const float currentI = SampleResult_Radiance_Y(&sample->currentResult);

		float proposedI = SampleResult_Radiance_Y(&sample->result);
		proposedI = (isnan(proposedI) || isinf(proposedI)) ? 0.f : proposedI;

		float totalI = sample->totalI;
		uint largeMutationCount = sample->largeMutationCount;
		uint smallMutationCount = sample->smallMutationCount;
		if (smallMutationCount == 0) {
			// It is a large mutation
			totalI += proposedI;
			largeMutationCount += 1;

			sample->totalI = totalI;
			sample->largeMutationCount = largeMutationCount;
		}

		const float meanI = (totalI > 0.f) ? (totalI / largeMutationCount) : 1.f;

		// Calculate accept probability from old and new image sample
		uint consecutiveRejects = sample->consecutiveRejects;

		float accProb;
		if ((currentI > 0.f) && (consecutiveRejects < PARAM_SAMPLER_METROPOLIS_MAX_CONSECUTIVE_REJECT))
			accProb = min(1.f, proposedI / currentI);
		else
			accProb = 1.f;

		const float newWeight = accProb + ((smallMutationCount == 0) ? 1.f : 0.f);
		float weight = sample->weight;
		weight += 1.f - accProb;

		const float rndVal = Rnd_FloatValue(seed);

		/*if (get_global_id(0) == 0)
			printf(\"[%d] Current: (%f, %f, %f) [%f] Proposed: (%f, %f, %f) [%f] accProb: %f <%f>\\n\",
					consecutiveRejects,
					currentL.r, currentL.g, currentL.b, weight,
					proposedL.r, proposedL.g, proposedL.b, newWeight,
					accProb, rndVal);*/

		__global SampleResult *contrib;
		float norm;

		if ((accProb == 1.f) || (rndVal < accProb)) {
			/*if (get_global_id(0) == 0)
				printf(\"\\t\\tACCEPTED !\\n\");*/

			// Add accumulated contribution of previous reference sample
			norm = weight / (currentI / meanI + PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE);
			contrib = &sample->currentResult;

			current ^= 1;
			proposed ^= 1;
			consecutiveRejects = 0;

			weight = newWeight;
		} else {
			/*if (get_global_id(0) == 0)
				printf(\"\\t\\tREJECTED !\\n\");*/

			// Add contribution of new sample before rejecting it
			norm = newWeight / (proposedI / meanI + PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE);
			contrib = &sample->result;

			++consecutiveRejects;
		}

		if (norm > 0.f) {
			/*if (get_global_id(0) == 0)
				printf(\"\\t\\tContrib: (%f, %f, %f) [%f] consecutiveRejects: %d\\n\",
						contrib.r, contrib.g, contrib.b, norm, consecutiveRejects);*/

			Film_SplatSample(contrib, norm
					FILM_PARAM);
		}

		// Check if it is an accepted mutation
		if (consecutiveRejects == 0) {
			// I can now (after Film_SplatSample()) overwrite sample->currentResult and sample->result
			sample->currentResult = sample->result;
		}

		sample->weight = weight;
		sample->consecutiveRejects = consecutiveRejects;
	}

	sample->current = current;
	sample->proposed = proposed;
}

void Sampler_NextSample(
		Seed *seed,
		__global Sample *sample,
		__global float *sampleData,
		const uint filmWidth, const uint filmHeight
		) {
	//--------------------------------------------------------------------------
	// Mutate the sample
	//--------------------------------------------------------------------------

	__global float *proposedU = &sampleData[sample->proposed * TOTAL_U_SIZE];
	if (Rnd_FloatValue(seed) < PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE) {
		LargeStep(seed, proposedU);
		sample->smallMutationCount = 0;
	} else {
		__global float *currentU = &sampleData[sample->current * TOTAL_U_SIZE];

		SmallStep(seed, currentU, proposedU);
		sample->smallMutationCount += 1;
	}

	SampleResult_Init(&sample->result);
	sample->result.filmX = min(proposedU[IDX_SCREEN_X] * filmWidth, (float)(filmWidth - 1));
	sample->result.filmY = min(proposedU[IDX_SCREEN_Y] * filmHeight, (float)(filmHeight - 1));
}

#endif

//------------------------------------------------------------------------------
// Sobol Sampler Kernel
//------------------------------------------------------------------------------

#if (PARAM_SAMPLER_TYPE == 2)

uint SobolSampler_SobolDimension(const uint index, const uint dimension) {
	const uint offset = dimension * SOBOL_BITS;
	uint result = 0;
	uint i = index;

	for (uint j = 0; i; i >>= 1, j++) {
		if (i & 1)
			result ^= SOBOL_DIRECTIONS[offset + j];
	}

	return result;
}

float SobolSampler_GetSample(__global Sample *sample, const uint index) {
	const uint pass = sample->pass;

	const uint iResult = SobolSampler_SobolDimension(pass, index);
	const float fResult = iResult * (1.f / 0xffffffffu);

	// Cranley-Patterson rotation to reduce visible regular patterns
	const float shift = (index & 1) ? PARAM_SAMPLER_SOBOL_RNG0 : PARAM_SAMPLER_SOBOL_RNG1;
	const float val = fResult + shift;

	return val - floor(val);
}

#define Sampler_GetSamplePath(index) (SobolSampler_GetSample(sample, index))
#define Sampler_GetSamplePathVertex(depth, index) ((depth > PARAM_SAMPLER_SOBOL_MAXDEPTH) ? \
	Rnd_FloatValue(seed) : \
	SobolSampler_GetSample(sample, IDX_BSDF_OFFSET + (depth - 1) * VERTEX_SAMPLE_SIZE + index))

__global float *Sampler_GetSampleData(__global Sample *sample, __global float *samplesData) {
	const size_t gid = get_global_id(0);
	return &samplesData[gid * TOTAL_U_SIZE];
}

__global float *Sampler_GetSampleDataPathBase(__global Sample *sample, __global float *sampleData) {
	return sampleData;
}

__global float *Sampler_GetSampleDataPathVertex(__global Sample *sample,
		__global float *sampleDataPathBase, const uint depth) {
	return &sampleDataPathBase[IDX_BSDF_OFFSET + depth * VERTEX_SAMPLE_SIZE];
}

void Sampler_SplatSample(
		Seed *seed,
		__global Sample *sample,
		__global float *sampleData
		FILM_PARAM_DECL
		) {
	Film_SplatSample(&sample->result, 1.f
			FILM_PARAM);
}

void Sampler_NextSample(
		Seed *seed,
		__global Sample *sample,
		__global float *sampleData,
		const uint filmWidth, const uint filmHeight
		) {
	// Move to the next sample
	sample->pass += get_global_size(0);

	const float u0 = Sampler_GetSamplePath(IDX_SCREEN_X);
	const float u1 = Sampler_GetSamplePath(IDX_SCREEN_Y);

	sampleData[IDX_SCREEN_X] = u0;
	sampleData[IDX_SCREEN_Y] = u1;

	SampleResult_Init(&sample->result);
	sample->result.filmX = min(u0 * filmWidth, (float)(filmWidth - 1));
	sample->result.filmY = min(u1 * filmHeight, (float)(filmHeight - 1));
}

void Sampler_Init(Seed *seed, __global Sample *sample, __global float *sampleData,
		const uint filmWidth, const uint filmHeight) {
	sample->pass = PARAM_SAMPLER_SOBOL_STARTOFFSET + get_global_id(0);

	Sampler_NextSample(seed, sample, sampleData, filmWidth, filmHeight);
}

#endif

#line 2 "bsdf_funcs.cl"

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

// TODO: move in a separate extmesh_funcs.h file

void ExtMesh_GetDifferentials(
		__global const Mesh* restrict meshDescs,
		__global const Point* restrict vertices,
#if defined(PARAM_HAS_NORMALS_BUFFER)
		__global const Vector* restrict vertNormals,
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
		__global const UV* restrict vertUVs,
#endif
		__global const Triangle* restrict triangles,
		const uint meshIndex,
		const uint triangleIndex,
		float3 shadeNormal,
		float3 *dpdu, float3 *dpdv,
        float3 *dndu, float3 *dndv) {
	__global const Mesh* restrict meshDesc = &meshDescs[meshIndex];
	__global const Point* restrict iVertices = &vertices[meshDesc->vertsOffset];
	__global const Triangle* restrict iTriangles = &triangles[meshDesc->trisOffset];

	// Compute triangle partial derivatives
	__global const Triangle* restrict tri = &iTriangles[triangleIndex];
	const uint vi0 = tri->v[0];
	const uint vi1 = tri->v[1];
	const uint vi2 = tri->v[2];

	float2 uv0, uv1, uv2;
#if defined(PARAM_HAS_UVS_BUFFER)
	if (meshDesc->uvsOffset != NULL_INDEX) {
		// Ok, UV coordinates are available, use them to build the reference
		// system around the shading normal.

		__global const UV* restrict iVertUVs = &vertUVs[meshDesc->uvsOffset];
		uv0 = VLOAD2F(&iVertUVs[vi0].u);
		uv1 = VLOAD2F(&iVertUVs[vi1].u);
		uv2 = VLOAD2F(&iVertUVs[vi2].u);
	} else {
#endif
		uv0 = (float2)(.5f, .5f);
		uv1 = (float2)(.5f, .5f);
		uv2 = (float2)(.5f, .5f);
#if defined(PARAM_HAS_UVS_BUFFER)
	}
#endif

	// Compute deltas for triangle partial derivatives
	const float du1 = uv0.s0 - uv2.s0;
	const float du2 = uv1.s0 - uv2.s0;
	const float dv1 = uv0.s1 - uv2.s1;
	const float dv2 = uv1.s1 - uv2.s1;
	const float determinant = du1 * dv2 - dv1 * du2;

	if (determinant == 0.f) {
		// Handle 0 determinant for triangle partial derivative matrix
		CoordinateSystem(shadeNormal, dpdu, dpdv);
		*dndu = ZERO;
		*dndv = ZERO;
	} else {
		const float invdet = 1.f / determinant;

		// Vertices expressed in local coordinates
		const float3 p0 = VLOAD3F(&iVertices[vi0].x);
		const float3 p1 = VLOAD3F(&iVertices[vi1].x);
		const float3 p2 = VLOAD3F(&iVertices[vi2].x);
		// Transform to global coordinates
		const float3 dp1 = Transform_InvApplyVector(&meshDesc->trans, p0 - p2);
		const float3 dp2 = Transform_InvApplyVector(&meshDesc->trans, p1 - p2);

		//------------------------------------------------------------------
		// Compute dpdu and dpdv
		//------------------------------------------------------------------

		const float3 geometryDpDu = ( dv2 * dp1 - dv1 * dp2) * invdet;
		const float3 geometryDpDv = (-du2 * dp1 + du1 * dp2) * invdet;

		*dpdu = cross(shadeNormal, cross(geometryDpDu, shadeNormal));
		*dpdv = cross(shadeNormal, cross(geometryDpDv, shadeNormal));

		//------------------------------------------------------------------
		// Compute dndu and dndv
		//------------------------------------------------------------------

#if defined(PARAM_HAS_NORMALS_BUFFER)
		if (meshDesc->normalsOffset != NULL_INDEX) {
			__global const Vector* restrict iVertNormals = &vertNormals[meshDesc->normalsOffset];
			// Shading normals expressed in local coordinates
			const float3 n0 = VLOAD3F(&iVertNormals[tri->v[0]].x);
			const float3 n1 = VLOAD3F(&iVertNormals[tri->v[1]].x);
			const float3 n2 = VLOAD3F(&iVertNormals[tri->v[2]].x);
			const float3 dn1 = n0 - n2;
			const float3 dn2 = n1 - n2;

			*dndu = ( dv2 * dn1 - dv1 * dn2) * invdet;
			*dndv = (-du2 * dn1 + du1 * dn2) * invdet;
			// Transform to global coordinates
			*dndu = normalize(Transform_InvApplyNormal(&meshDesc->trans, *dndu));
			*dndv = normalize(Transform_InvApplyNormal(&meshDesc->trans, *dndv));
		} else {
#endif
			*dndu = ZERO;
			*dndv = ZERO;
#if defined(PARAM_HAS_NORMALS_BUFFER)
		}
#endif
	}
}

// Used when hitting a surface
void BSDF_Init(
		__global BSDF *bsdf,
		//const bool fromL,
		__global const Mesh* restrict meshDescs,
		__global const uint* restrict meshMats,
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		__global const uint* restrict meshTriLightDefsOffset,
#endif
		__global const Point* restrict vertices,
#if defined(PARAM_HAS_NORMALS_BUFFER)
		__global const Vector* restrict vertNormals,
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
		__global const UV* restrict vertUVs,
#endif
#if defined(PARAM_HAS_COLS_BUFFER)
		__global const Spectrum* restrict vertCols,
#endif
#if defined(PARAM_HAS_ALPHAS_BUFFER)
		__global const float* restrict vertAlphas,
#endif
		__global const Triangle* restrict triangles,
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		Ray *ray,
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		const RayHit *rayHit
#if defined(PARAM_HAS_PASSTHROUGH)
		, const float u0
#endif
#if defined(PARAM_HAS_VOLUMES)
		, __global PathVolumeInfo *volInfo
#endif
		MATERIALS_PARAM_DECL
		) {
	//bsdf->fromLight = fromL;
#if defined(PARAM_HAS_PASSTHROUGH)
	bsdf->hitPoint.passThroughEvent = u0;
#endif

#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
	const float3 rayOrig = VLOAD3F(&ray->o.x);
	const float3 rayDir = VLOAD3F(&ray->d.x);
#else
	const float3 rayOrig = (float3)(ray->o.x, ray->o.y, ray->o.z);
	const float3 rayDir = (float3)(ray->d.x, ray->d.y, ray->d.z);
#endif
	const float3 hitPointP = rayOrig + rayHit->t * rayDir;
	VSTORE3F(hitPointP, &bsdf->hitPoint.p.x);
	VSTORE3F(-rayDir, &bsdf->hitPoint.fixedDir.x);

	const uint meshIndex = rayHit->meshIndex;
	const uint triangleIndex = rayHit->triangleIndex;

	__global const Mesh* restrict meshDesc = &meshDescs[meshIndex];
	__global const Point* restrict iVertices = &vertices[meshDesc->vertsOffset];
	__global const Triangle* restrict iTriangles = &triangles[meshDesc->trisOffset];

	// Get the material
	const uint matIndex = meshMats[meshIndex];
	bsdf->materialIndex = matIndex;

	//--------------------------------------------------------------------------
	// Get face normal
	//--------------------------------------------------------------------------

	const float b1 = rayHit->b1;
	const float b2 = rayHit->b2;

	// Geometry normal expressed in local coordinates
	float3 geometryN = Mesh_GetGeometryNormal(iVertices, iTriangles, triangleIndex);
	// Transform to global coordinates
	geometryN = normalize(Transform_InvApplyNormal(&meshDesc->trans, geometryN));
	// Store the geometry normal
	VSTORE3F(geometryN, &bsdf->hitPoint.geometryN.x);

	// The shading normal
	float3 shadeN;
#if defined(PARAM_HAS_NORMALS_BUFFER)
	if (meshDesc->normalsOffset != NULL_INDEX) {
		__global const Vector* restrict iVertNormals = &vertNormals[meshDesc->normalsOffset];
		// Shading normal expressed in local coordinates
		shadeN = Mesh_InterpolateNormal(iVertNormals, iTriangles, triangleIndex, b1, b2);
		// Transform to global coordinates
		shadeN = normalize(Transform_InvApplyNormal(&meshDesc->trans, shadeN));
	} else
#endif
		shadeN = geometryN;
    VSTORE3F(shadeN, &bsdf->hitPoint.shadeN.x);

	//--------------------------------------------------------------------------
	// Set interior and exterior volumes
	//--------------------------------------------------------------------------

#if defined(PARAM_HAS_VOLUMES)
	bsdf->hitPoint.intoObject = (dot(rayDir, geometryN) < 0.f);

	PathVolumeInfo_SetHitPointVolumes(
			volInfo,
			&bsdf->hitPoint,
			Material_GetInteriorVolume(matIndex, &bsdf->hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
				, u0
#endif
			MATERIALS_PARAM),
			Material_GetExteriorVolume(matIndex, &bsdf->hitPoint
#if defined(PARAM_HAS_PASSTHROUGH)
				, u0
#endif
			MATERIALS_PARAM)
			MATERIALS_PARAM);
#endif

	//--------------------------------------------------------------------------
	// Get UV coordinate
	//--------------------------------------------------------------------------

	float2 hitPointUV;
#if defined(PARAM_HAS_UVS_BUFFER)
	if (meshDesc->uvsOffset != NULL_INDEX) {
		__global const UV* restrict iVertUVs = &vertUVs[meshDesc->uvsOffset];
		hitPointUV = Mesh_InterpolateUV(iVertUVs, iTriangles, triangleIndex, b1, b2);
	} else
#endif
		hitPointUV = 0.f;
	VSTORE2F(hitPointUV, &bsdf->hitPoint.uv.u);

	//--------------------------------------------------------------------------
	// Get color value
	//--------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_HITPOINTCOLOR) || defined(PARAM_ENABLE_TEX_HITPOINTGREY) || defined(PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR)
	float3 hitPointColor;
#if defined(PARAM_HAS_COLS_BUFFER)
	if (meshDesc->colsOffset != NULL_INDEX) {
		__global const Spectrum* restrict iVertCols = &vertCols[meshDesc->colsOffset];
		hitPointColor = Mesh_InterpolateColor(iVertCols, iTriangles, triangleIndex, b1, b2);
	} else
#endif
		hitPointColor = WHITE;
	VSTORE3F(hitPointColor, bsdf->hitPoint.color.c);
#endif

	//--------------------------------------------------------------------------
	// Get alpha value
	//--------------------------------------------------------------------------

#if defined(PARAM_ENABLE_TEX_HITPOINTALPHA)
	float hitPointAlpha;
#if defined(PARAM_HAS_ALPHAS_BUFFER)
	if (meshDesc->alphasOffset != NULL_INDEX) {
		__global const float* restrict iVertAlphas = &vertAlphas[meshDesc->alphasOffset];
		hitPointAlpha = Mesh_InterpolateAlpha(iVertAlphas, iTriangles, triangleIndex, b1, b2);
	} else
#endif
		hitPointAlpha = 1.f;
	bsdf->hitPoint.alpha = hitPointAlpha;
#endif

	//--------------------------------------------------------------------------

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
	// Check if it is a light source
	bsdf->triangleLightSourceIndex = meshTriLightDefsOffset[meshIndex];
#endif

    //--------------------------------------------------------------------------
	// Build the local reference system
	//--------------------------------------------------------------------------

	float3 dndu, dndv, dpdu, dpdv;
	ExtMesh_GetDifferentials(
			meshDescs,
			vertices,
#if defined(PARAM_HAS_NORMALS_BUFFER)
			vertNormals,
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
			vertUVs,
#endif
			triangles,
			meshIndex,
			triangleIndex,
			shadeN,
			&dpdu, &dpdv,
			&dndu, &dndv);

	//--------------------------------------------------------------------------
	// Apply bump or normal mapping
	//--------------------------------------------------------------------------

#if defined(PARAM_HAS_BUMPMAPS)
	VSTORE3F(dpdu, &bsdf->hitPoint.dpdu.x);
	VSTORE3F(dpdv, &bsdf->hitPoint.dpdv.x);
	VSTORE3F(dndu, &bsdf->hitPoint.dndu.x);
	VSTORE3F(dndv, &bsdf->hitPoint.dndv.x);
	Material_Bump(matIndex, &bsdf->hitPoint
			MATERIALS_PARAM);
	// Re-read the shadeN modified by Material_Bump()
	shadeN = VLOAD3F(&bsdf->hitPoint.shadeN.x);
	dpdu = VLOAD3F(&bsdf->hitPoint.dpdu.x);
	dpdv = VLOAD3F(&bsdf->hitPoint.dpdv.x);
#endif

	//--------------------------------------------------------------------------
	// Build the local reference system
	//--------------------------------------------------------------------------
	Frame_Set(&bsdf->frame, dpdu, dpdv, shadeN);

#if defined(PARAM_HAS_VOLUMES)
	bsdf->isVolume = false;
#endif
}

#if defined(PARAM_HAS_VOLUMES)
// Used when hitting a volume scatter point
void BSDF_InitVolume(
		__global BSDF *bsdf,
		__global const Material* restrict mats,
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		Ray *ray,
		const uint volumeIndex, const float t, const float passThroughEvent) {
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
	const float3 rayOrig = VLOAD3F(&ray->o.x);
	const float3 rayDir = VLOAD3F(&ray->d.x);
#else
	const float3 rayOrig = (float3)(ray->o.x, ray->o.y, ray->o.z);
	const float3 rayDir = (float3)(ray->d.x, ray->d.y, ray->d.z);
#endif
	const float3 hitPointP = rayOrig + t * rayDir;
	VSTORE3F(hitPointP, &bsdf->hitPoint.p.x);
	const float3 shadeN = -rayDir;
	VSTORE3F(shadeN, &bsdf->hitPoint.fixedDir.x);

	bsdf->hitPoint.passThroughEvent = passThroughEvent;

	bsdf->materialIndex = volumeIndex;

	VSTORE3F(shadeN, &bsdf->hitPoint.geometryN.x);
	VSTORE3F(shadeN, &bsdf->hitPoint.shadeN.x);
#if defined(PARAM_HAS_BUMPMAPS)
	float3 dpdu, dpdv;
	CoordinateSystem(shadeN, &dpdu, &dpdv);
	VSTORE3F(dpdu, &bsdf->hitPoint.dpdu.x);
	VSTORE3F(dpdv, &bsdf->hitPoint.dpdv.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &bsdf->hitPoint.dndu.x);
	VSTORE3F((float3)(0.f, 0.f, 0.f), &bsdf->hitPoint.dndv.x);
#endif

	bsdf->hitPoint.intoObject = true;
	bsdf->hitPoint.interiorVolumeIndex = volumeIndex;
	bsdf->hitPoint.exteriorVolumeIndex = volumeIndex;

	const uint iorTexIndex = (volumeIndex != NULL_INDEX) ? mats[volumeIndex].volume.iorTexIndex : NULL_INDEX;
	bsdf->hitPoint.interiorIorTexIndex = iorTexIndex;
	bsdf->hitPoint.exteriorIorTexIndex = iorTexIndex;

#if defined(PARAM_ENABLE_TEX_HITPOINTCOLOR) || defined(PARAM_ENABLE_TEX_HITPOINTGREY) || defined(PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR)
	VSTORE3F(WHITE, bsdf->hitPoint.color.c);
#endif
#if defined(PARAM_ENABLE_TEX_HITPOINTALPHA)
	bsdf->hitPoint.alpha = 1.f;
#endif

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
	bsdf->triangleLightSourceIndex = NULL_INDEX;
#endif

	VSTORE2F((float2)(0.f, 0.f), &bsdf->hitPoint.uv.u);

	bsdf->isVolume = true;

	// Build the local reference system
	Frame_SetFromZ(&bsdf->frame, shadeN);
}
#endif

float3 BSDF_Evaluate(__global BSDF *bsdf,
		const float3 generatedDir, BSDFEvent *event, float *directPdfW
		MATERIALS_PARAM_DECL) {
	//const Vector &eyeDir = fromLight ? generatedDir : hitPoint.fixedDir;
	//const Vector &lightDir = fromLight ? hitPoint.fixedDir : generatedDir;
	const float3 eyeDir = VLOAD3F(&bsdf->hitPoint.fixedDir.x);
	const float3 lightDir = generatedDir;
	const float3 geometryN = VLOAD3F(&bsdf->hitPoint.geometryN.x);

	const float dotLightDirNG = dot(lightDir, geometryN);
	const float absDotLightDirNG = fabs(dotLightDirNG);
	const float dotEyeDirNG = dot(eyeDir, geometryN);
	const float absDotEyeDirNG = fabs(dotEyeDirNG);

#if defined(PARAM_HAS_VOLUMES)
	if (!bsdf->isVolume) {
		// These kind of tests make sense only for materials
#endif
		if ((absDotLightDirNG < DEFAULT_COS_EPSILON_STATIC) ||
				(absDotEyeDirNG < DEFAULT_COS_EPSILON_STATIC))
			return BLACK;

		const float sideTest = dotEyeDirNG * dotLightDirNG;
		const BSDFEvent matEvent = Material_GetEventTypes(bsdf->materialIndex
				MATERIALS_PARAM);
		if (((sideTest > 0.f) && !(matEvent & REFLECT)) ||
				((sideTest < 0.f) && !(matEvent & TRANSMIT)))
			return BLACK;
#if defined(PARAM_HAS_VOLUMES)
	}
#endif

	__global Frame *frame = &bsdf->frame;
	const float3 localLightDir = Frame_ToLocal(frame, lightDir);
	const float3 localEyeDir = Frame_ToLocal(frame, eyeDir);
	const float3 result = Material_Evaluate(bsdf->materialIndex, &bsdf->hitPoint,
			localLightDir, localEyeDir,	event, directPdfW
			MATERIALS_PARAM);

	// Adjoint BSDF
//	if (fromLight) {
//		const float absDotLightDirNS = AbsDot(lightDir, shadeN);
//		const float absDotEyeDirNS = AbsDot(eyeDir, shadeN);
//		return result * ((absDotLightDirNS * absDotEyeDirNG) / (absDotEyeDirNS * absDotLightDirNG));
//	} else
		return result;
}

float3 BSDF_Sample(__global BSDF *bsdf, const float u0, const float u1,
		float3 *sampledDir, float *pdfW, float *cosSampledDir, BSDFEvent *event,
		const BSDFEvent requestedEvent
		MATERIALS_PARAM_DECL) {
	const float3 fixedDir = VLOAD3F(&bsdf->hitPoint.fixedDir.x);
	const float3 localFixedDir = Frame_ToLocal(&bsdf->frame, fixedDir);
	float3 localSampledDir;

	const float3 result = Material_Sample(bsdf->materialIndex, &bsdf->hitPoint,
			localFixedDir, &localSampledDir, u0, u1,
#if defined(PARAM_HAS_PASSTHROUGH)
			bsdf->hitPoint.passThroughEvent,
#endif
			pdfW, cosSampledDir, event,
			requestedEvent
			MATERIALS_PARAM);
	if (Spectrum_IsBlack(result))
		return 0.f;

	*sampledDir = Frame_ToWorld(&bsdf->frame, localSampledDir);

	// Adjoint BSDF
//	if (fromLight) {
//		const float absDotFixedDirNS = fabsf(localFixedDir.z);
//		const float absDotSampledDirNS = fabsf(localSampledDir.z);
//		const float absDotFixedDirNG = AbsDot(fixedDir, geometryN);
//		const float absDotSampledDirNG = AbsDot(*sampledDir, geometryN);
//		return result * ((absDotFixedDirNS * absDotSampledDirNG) / (absDotSampledDirNS * absDotFixedDirNG));
//	} else
		return result;
}

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
bool BSDF_IsLightSource(__global BSDF *bsdf) {
	return (bsdf->triangleLightSourceIndex != NULL_INDEX);
}

float3 BSDF_GetEmittedRadiance(__global BSDF *bsdf, float *directPdfA
		LIGHTS_PARAM_DECL) {
	const uint triangleLightSourceIndex = bsdf->triangleLightSourceIndex;
	if (triangleLightSourceIndex == NULL_INDEX)
		return BLACK;
	else
		return IntersectableLight_GetRadiance(&lights[triangleLightSourceIndex],
				&bsdf->hitPoint, directPdfA
				LIGHTS_PARAM);
}
#endif

#if defined(PARAM_HAS_PASSTHROUGH)
float3 BSDF_GetPassThroughTransparency(__global BSDF *bsdf
		MATERIALS_PARAM_DECL) {
	const float3 localFixedDir = Frame_ToLocal(&bsdf->frame, VLOAD3F(&bsdf->hitPoint.fixedDir.x));

	return Material_GetPassThroughTransparency(bsdf->materialIndex,
			&bsdf->hitPoint, localFixedDir, bsdf->hitPoint.passThroughEvent
			MATERIALS_PARAM);
}
#endif
#line 2 "scene_funcs.cl"

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

float Scene_SampleAllLightPdf(__global const float *distribution1D, const uint lightIndex) {
	return Distribution1D_Pdf_UINT(distribution1D, lightIndex);
}

uint Scene_SampleAllLights(__global const float *distribution1D, const float u, float *pdf) {
	// Power based light strategy
	return Distribution1D_SampleDiscrete(distribution1D, u, pdf);
}
#line 2 "patchoclbase_funcs.cl"

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

// List of symbols defined at compile time:
//  PARAM_TASK_COUNT
//  PARAM_RAY_EPSILON_MIN
//  PARAM_RAY_EPSILON_MAX
//  PARAM_HAS_IMAGEMAPS
//  PARAM_HAS_PASSTHROUGH
//  PARAM_USE_PIXEL_ATOMICS
//  PARAM_HAS_BUMPMAPS
//  PARAM_ACCEL_BVH or PARAM_ACCEL_MBVH or PARAM_ACCEL_QBVH or PARAM_ACCEL_MQBVH
//  PARAM_DEVICE_INDEX
//  PARAM_DEVICE_COUNT
//  PARAM_LIGHT_WORLD_RADIUS_SCALE
//  PARAM_TRIANGLE_LIGHT_COUNT
//  PARAM_TRIANGLE_LIGHT_HAS_VERTEX_COLOR
//  PARAM_LIGHT_COUNT
//  PARAM_HAS_VOLUMEs (and SCENE_DEFAULT_VOLUME_INDEX)

// To enable single material support
//  PARAM_ENABLE_MAT_MATTE
//  PARAM_ENABLE_MAT_MIRROR
//  PARAM_ENABLE_MAT_GLASS
//  PARAM_ENABLE_MAT_ARCHGLASS
//  PARAM_ENABLE_MAT_MIX
//  PARAM_ENABLE_MAT_NULL
//  PARAM_ENABLE_MAT_MATTETRANSLUCENT
//  PARAM_ENABLE_MAT_ROUGHMATTETRANSLUCENT
//  PARAM_ENABLE_MAT_GLOSSY2
//  PARAM_ENABLE_MAT_METAL2
//  PARAM_ENABLE_MAT_ROUGHGLASS
//  PARAM_ENABLE_MAT_CLOTH
//  PARAM_ENABLE_MAT_CARPAINT
//  PARAM_ENABLE_MAT_GLOSSYTRANSLUCENT
//  PARAM_ENABLE_MAT_GLOSSYCOATING
//  PARAM_ENABLE_MAT_CLEAR_VOL

// To enable single texture support
//  PARAM_ENABLE_TEX_CONST_FLOAT
//  PARAM_ENABLE_TEX_CONST_FLOAT3
//  PARAM_ENABLE_TEX_CONST_FLOAT4
//  PARAM_ENABLE_TEX_IMAGEMAP
//  PARAM_ENABLE_TEX_SCALE
//  etc.

// Film related parameters:
//  PARAM_FILM_RADIANCE_GROUP_COUNT
//  PARAM_FILM_CHANNELS_HAS_ALPHA
//  PARAM_FILM_CHANNELS_HAS_DEPTH
//  PARAM_FILM_CHANNELS_HAS_POSITION
//  PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL
//  PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL
//  PARAM_FILM_CHANNELS_HAS_MATERIAL_ID
//  PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE
//  PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY
//  PARAM_FILM_CHANNELS_HAS_EMISSION
//  PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE
//  PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY
//  PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR
//  PARAM_FILM_CHANNELS_HAS_MATERIAL_ID_MASK (and PARAM_FILM_MASK_MATERIAL_ID)
//  PARAM_FILM_CHANNELS_HAS_BY_MATERIAL_ID (and PARAM_FILM_BY_MATERIAL_ID)
//  PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK
//  PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK
//  PARAM_FILM_CHANNELS_HAS_UV
//  PARAM_FILM_CHANNELS_HAS_RAYCOUNT
//  PARAM_FILM_CHANNELS_HAS_BY_MATERIAL_ID (and PARAM_FILM_BY_MATERIAL_ID)
//  PARAM_FILM_CHANNELS_HAS_IRRADIANCE

// (optional)
//  PARAM_CAMERA_HAS_DOF

// (optional)
//  PARAM_HAS_INFINITELIGHT
//  PARAM_HAS_SUNLIGHT
//  PARAM_HAS_SKYLIGHT
//  PARAM_HAS_SKYLIGHT2
//  PARAM_HAS_POINTLIGHT
//  PARAM_HAS_MAPPOINTLIGHT
//  PARAM_HAS_SPOTLIGHT
//  PARAM_HAS_PROJECTIONLIGHT
//  PARAM_HAS_CONSTANTINFINITELIGHT
//  PARAM_HAS_SHARPDISTANTLIGHT
//  PARAM_HAS_DISTANTLIGHT
//  PARAM_HAS_LASERLIGHT
//  PARAM_HAS_INFINITELIGHTS (if it has any infinite light)
//  PARAM_HAS_ENVLIGHTS (if it has any env. light)

// (optional)
//  PARAM_HAS_NORMALS_BUFFER
//  PARAM_HAS_UVS_BUFFER
//  PARAM_HAS_COLS_BUFFER
//  PARAM_HAS_ALPHAS_BUFFER

void MangleMemory(__global unsigned char *ptr, const size_t size) {
	Seed seed;
	Rnd_Init(7 + get_global_id(0), &seed);

	for (uint i = 0; i < size; ++i)
		*ptr++ = (unsigned char)(Rnd_UintValue(&seed) & 0xff);
}

bool Scene_Intersect(
#if defined(PARAM_HAS_VOLUMES)
		__global PathVolumeInfo *volInfo,
		__global HitPoint *tmpHitPoint,
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
		const float passThrough,
#endif
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		Ray *ray,
#if !defined(RENDER_ENGINE_BIASPATHOCL) && !defined(RENDER_ENGINE_RTBIASPATHOCL)
		__global
#endif
		RayHit *rayHit,
		__global BSDF *bsdf,
		float3 *connectionThroughput,  const float3 pathThroughput,
		__global SampleResult *sampleResult,
		// BSDF_Init parameters
		__global const Mesh* restrict meshDescs,
		__global const uint* restrict meshMats,
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		__global const uint *meshTriLightDefsOffset,
#endif
		__global const Point* restrict vertices,
#if defined(PARAM_HAS_NORMALS_BUFFER)
		__global const Vector* restrict vertNormals,
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
		__global const UV* restrict vertUVs,
#endif
#if defined(PARAM_HAS_COLS_BUFFER)
		__global const Spectrum* restrict vertCols,
#endif
#if defined(PARAM_HAS_ALPHAS_BUFFER)
		__global const float* restrict vertAlphas,
#endif
		__global const Triangle* restrict triangles
		MATERIALS_PARAM_DECL
		) {
	*connectionThroughput = WHITE;
	const bool hit = (rayHit->meshIndex != NULL_INDEX);

#if defined(PARAM_HAS_VOLUMES)
	uint rayVolumeIndex = volInfo->currentVolumeIndex;
#endif
	if (hit) {
		// Initialize the BSDF of the hit point
		BSDF_Init(bsdf,
				meshDescs,
				meshMats,
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
				meshTriLightDefsOffset,
#endif
				vertices,
#if defined(PARAM_HAS_NORMALS_BUFFER)
				vertNormals,
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
				vertUVs,
#endif
#if defined(PARAM_HAS_COLS_BUFFER)
				vertCols,
#endif
#if defined(PARAM_HAS_ALPHAS_BUFFER)
				vertAlphas,
#endif
				triangles, ray, rayHit
#if defined(PARAM_HAS_PASSTHROUGH)
				, passThrough
#endif
#if defined(PARAM_HAS_VOLUMES)
				, volInfo
#endif
				MATERIALS_PARAM
				);

#if defined(PARAM_HAS_VOLUMES)
		rayVolumeIndex = bsdf->hitPoint.intoObject ? bsdf->hitPoint.exteriorVolumeIndex : bsdf->hitPoint.interiorVolumeIndex;
#endif
	}
#if defined(PARAM_HAS_VOLUMES)
	else if (rayVolumeIndex == NULL_INDEX) {
		// No volume information, I use the default volume
		rayVolumeIndex = SCENE_DEFAULT_VOLUME_INDEX;
	}
#endif

#if defined(PARAM_HAS_VOLUMES)
	// Check if there is volume scatter event
	if (rayVolumeIndex != NULL_INDEX) {
		// This applies volume transmittance too
		// Note: by using passThrough here, I introduce subtle correlation
		// between scattering events and pass-through events
		float3 connectionEmission = BLACK;

		const float t = Volume_Scatter(&mats[rayVolumeIndex], ray,
				hit ? rayHit->t : ray->maxt,
				passThrough, volInfo->scatteredStart,
				connectionThroughput, &connectionEmission,
				tmpHitPoint
				TEXTURES_PARAM);

		// Add the volume emitted light to the appropriate light group
		if (!Spectrum_IsBlack(connectionEmission) && sampleResult)
			SampleResult_AddEmission(sampleResult, BSDF_GetLightID(bsdf
				MATERIALS_PARAM),
					pathThroughput, connectionEmission);

		if (t > 0.f) {
			// There was a volume scatter event

			// I have to set RayHit fields even if there wasn't a real
			// ray hit
			rayHit->t = t;
			// This is a trick in order to have RayHit::Miss() return
			// false. I assume 0xfffffffeu will trigger a memory fault if
			// used (and the bug will be noticed)
			rayHit->meshIndex = 0xfffffffeu;

			BSDF_InitVolume(bsdf, mats, ray, rayVolumeIndex, t, passThrough);
			volInfo->scatteredStart = true;

			return false;
		}
	}
#endif

	if (hit) {
		// Check if the volume priority system tells me to continue to trace the ray
		bool continueToTrace =
#if defined(PARAM_HAS_VOLUMES)
			PathVolumeInfo_ContinueToTrace(volInfo, bsdf
				MATERIALS_PARAM);
#else
		false;
#endif

#if defined(PARAM_HAS_PASSTHROUGH)
		// Check if it is a pass through point
		if (!continueToTrace) {
			const float3 passThroughTrans = BSDF_GetPassThroughTransparency(bsdf
				MATERIALS_PARAM);
			if (!Spectrum_IsBlack(passThroughTrans)) {
				*connectionThroughput *= passThroughTrans;

				// It is a pass through point, continue to trace the ray
				continueToTrace = true;
			}
		}
#endif

		if (continueToTrace) {
#if defined(PARAM_HAS_VOLUMES)
			// Update volume information
			const BSDFEvent eventTypes = BSDF_GetEventTypes(bsdf
						MATERIALS_PARAM);
			PathVolumeInfo_Update(volInfo, eventTypes, bsdf
					MATERIALS_PARAM);
#endif

			// It is a transparent material, continue to trace the ray
			ray->mint = rayHit->t + MachineEpsilon_E(rayHit->t);

			// A safety check
			if (ray->mint >= ray->maxt)
				return false;
			else
				return true;
		} else
			return false;
	} else {
		// Nothing was hit, stop tracing the ray
		return false;
	}
}
#line 2 "pathocl_datatypes.cl"

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

//------------------------------------------------------------------------------
// Some OpenCL specific definition
//------------------------------------------------------------------------------

#if defined(SLG_OPENCL_KERNEL)

#if defined(PARAM_USE_PIXEL_ATOMICS)
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#endif

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#endif

//------------------------------------------------------------------------------
// GPUTask data types
//------------------------------------------------------------------------------

typedef enum {
	// Mega-kernel states
	RT_NEXT_VERTEX = 0,
	GENERATE_DL_RAY = 1,
	RT_DL = 2,
	GENERATE_NEXT_VERTEX_RAY = 3,
	SPLAT_SAMPLE = 4,

	// Micro-kernel states
	MK_RT_NEXT_VERTEX = 0, // Must have the same value of RT_NEXT_VERTEX
	MK_HIT_NOTHING = 1,
	MK_HIT_OBJECT = 2,
	MK_DL_ILLUMINATE = 3,
	MK_DL_SAMPLE_BSDF = 4,
	MK_RT_DL = 5,
	MK_GENERATE_NEXT_VERTEX_RAY = 6,
	MK_SPLAT_SAMPLE = 7,
	MK_NEXT_SAMPLE = 8,
	MK_GENERATE_CAMERA_RAY = 9
} PathState;

typedef struct {
	unsigned int lightIndex;
	float pickPdf;

	Vector dir;
	float distance, directPdfW;

	// Radiance to add to the result if light source is visible
	// Note: it doesn't include the pathThroughput
	Spectrum lightRadiance;
	// This is used only if PARAM_FILM_CHANNELS_HAS_IRRADIANCE is defined and
	// only for the first path vertex
	Spectrum lightIrradiance;

	unsigned int lightID;
} DirectLightIlluminateInfo;

// This is defined only under OpenCL because of variable size structures
#if defined(SLG_OPENCL_KERNEL)

// The state used to keep track of the rendered path
typedef struct {
	PathState state;
	unsigned int pathVertexCount;

	Spectrum throughput;
	BSDF bsdf; // Variable size structure
} GPUTaskState;

typedef struct {
	// Used to store some intermediate result
	DirectLightIlluminateInfo illumInfo;

	BSDFEvent lastBSDFEvent;
	float lastPdfW;

#if defined(PARAM_HAS_PASSTHROUGH)
	float rayPassThroughEvent;
#endif
} GPUTaskDirectLight;

typedef struct {
	// The task seed
	Seed seed;

	// Space for temporary storage
#if defined(PARAM_HAS_PASSTHROUGH) || defined(PARAM_HAS_VOLUMES)
	BSDF tmpBsdf; // Variable size structure
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0) || defined(PARAM_HAS_VOLUMES)
	// This is used by TriangleLight_Illuminate() to temporary store the
	// point on the light sources.
	// Also used by Scene_Intersect() for evaluating volume textures.
	HitPoint tmpHitPoint;
#endif
} GPUTask;

#endif

typedef struct {
	unsigned int sampleCount;
} GPUTaskStats;
#line 2 "patchocl_funcs.cl"

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

// List of symbols defined at compile time:
//  PARAM_MAX_PATH_DEPTH
//  PARAM_RR_DEPTH
//  PARAM_RR_CAP

// (optional)
//  PARAM_CAMERA_TYPE (0 = Perspective, 1 = Orthographic, 2 = Stereo)
//  PARAM_CAMERA_HAS_DOF
//  PARAM_CAMERA_ENABLE_CLIPPING_PLANE
//  PARAM_CAMERA_ENABLE_OCULUSRIFT_BARREL

// (optional)
//  PARAM_IMAGE_FILTER_TYPE (0 = No filter, 1 = Box, 2 = Gaussian, 3 = Mitchell, 4 = Blackman-Harris)
//  PARAM_IMAGE_FILTER_WIDTH_X
//  PARAM_IMAGE_FILTER_WIDTH_Y
//  PARAM_IMAGE_FILTER_PIXEL_WIDTH_X
//  PARAM_IMAGE_FILTER_PIXEL_WIDTH_Y
// (Box filter)
// (Gaussian filter)
//  PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA
// (Mitchell filter)
//  PARAM_IMAGE_FILTER_MITCHELL_B
//  PARAM_IMAGE_FILTER_MITCHELL_C

// (optional)
//  PARAM_SAMPLER_TYPE (0 = Inlined Random, 1 = Metropolis, 2 = Sobol)
// (Metropolis)
//  PARAM_SAMPLER_METROPOLIS_LARGE_STEP_RATE
//  PARAM_SAMPLER_METROPOLIS_MAX_CONSECUTIVE_REJECT
//  PARAM_SAMPLER_METROPOLIS_IMAGE_MUTATION_RANGE
// (Sobol)
//  PARAM_SAMPLER_SOBOL_STARTOFFSET
//  PARAM_SAMPLER_SOBOL_MAXDEPTH


//------------------------------------------------------------------------------
// Init Kernel
//------------------------------------------------------------------------------

void GenerateCameraPath(
		__global GPUTaskDirectLight *taskDirectLight,
		__global GPUTaskState *taskState,
		__global Sample *sample,
		__global float *sampleData,
		__global const Camera* restrict camera,
		const uint filmWidth,
		const uint filmHeight,
		__global Ray *ray,
		Seed *seed) {
#if (PARAM_SAMPLER_TYPE == 0)
	const float time = Rnd_FloatValue(seed);

#if defined(PARAM_CAMERA_HAS_DOF)
	const float dofSampleX = Rnd_FloatValue(seed);
	const float dofSampleY = Rnd_FloatValue(seed);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	const float eyePassThrough = Rnd_FloatValue(seed);
#endif
#endif

#if (PARAM_SAMPLER_TYPE == 1)
	__global float *sampleDataPathBase = Sampler_GetSampleDataPathBase(sample, sampleData);

	const float time = Sampler_GetSamplePath(IDX_EYE_TIME);

#if defined(PARAM_CAMERA_HAS_DOF)
	const float dofSampleX = Sampler_GetSamplePath(IDX_DOF_X);
	const float dofSampleY = Sampler_GetSamplePath(IDX_DOF_Y);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	const float eyePassThrough = Sampler_GetSamplePath(IDX_EYE_PASSTHROUGH);
#endif
#endif

#if (PARAM_SAMPLER_TYPE == 2)
	const float time = Sampler_GetSamplePath(IDX_EYE_TIME);

#if defined(PARAM_CAMERA_HAS_DOF)
	const float dofSampleX = Sampler_GetSamplePath(IDX_DOF_X);
	const float dofSampleY = Sampler_GetSamplePath(IDX_DOF_Y);
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
	const float eyePassThrough = Sampler_GetSamplePath(IDX_EYE_PASSTHROUGH);
#endif
#endif

	Camera_GenerateRay(camera, filmWidth, filmHeight, ray,
			sample->result.filmX, sample->result.filmY, time
#if defined(PARAM_CAMERA_HAS_DOF)
			, dofSampleX, dofSampleY
#endif
			);

	// Initialize the path state
	taskState->state = RT_NEXT_VERTEX; // Or MK_RT_NEXT_VERTEX (they have the same value)
	taskState->pathVertexCount = 1;
	VSTORE3F(WHITE, taskState->throughput.c);
	taskDirectLight->lastBSDFEvent = SPECULAR; // SPECULAR is required to avoid MIS
	taskDirectLight->lastPdfW = 1.f;
#if defined(PARAM_HAS_PASSTHROUGH)
	// This is a bit tricky. I store the passThroughEvent in the BSDF
	// before of the initialization because it can be used during the
	// tracing of next path vertex ray.

	taskState->bsdf.hitPoint.passThroughEvent = eyePassThrough;
#endif

#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
	sample->result.directShadowMask = 1.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
	sample->result.indirectShadowMask = 1.f;
#endif

	sample->result.lastPathVertex = (PARAM_MAX_PATH_DEPTH == 1);
}

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void Init(
		uint seedBase,
		__global GPUTask *tasks,
		__global GPUTaskDirectLight *tasksDirectLight,
		__global GPUTaskState *tasksState,
		__global GPUTaskStats *taskStats,
		__global Sample *samples,
		__global float *samplesData,
#if defined(PARAM_HAS_VOLUMES)
		__global PathVolumeInfo *pathVolInfos,
#endif
		__global Ray *rays,
		__global Camera *camera,
		const uint filmWidth,
		const uint filmHeight
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Initialize the task
	__global GPUTask *task = &tasks[gid];
	__global GPUTaskDirectLight *taskDirectLight = &tasksDirectLight[gid];
	__global GPUTaskState *taskState = &tasksState[gid];

	// Initialize random number generator
	Seed seed;
	Rnd_Init(seedBase + gid, &seed);

	// Initialize the sample and path
	__global Sample *sample = &samples[gid];
	__global float *sampleData = Sampler_GetSampleData(sample, samplesData);
	Sampler_Init(&seed, sample, sampleData, filmWidth, filmHeight);
	GenerateCameraPath(taskDirectLight, taskState, sample, sampleData, camera, filmWidth, filmHeight, &rays[gid], &seed);

	// Save the seed
	task->seed.s1 = seed.s1;
	task->seed.s2 = seed.s2;
	task->seed.s3 = seed.s3;

	__global GPUTaskStats *taskStat = &taskStats[gid];
	taskStat->sampleCount = 0;

#if defined(PARAM_HAS_VOLUMES)
	PathVolumeInfo_Init(&pathVolInfos[gid]);
#endif
}

//------------------------------------------------------------------------------
// Utility functions
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_ENVLIGHTS)
void DirectHitInfiniteLight(
		const BSDFEvent lastBSDFEvent,
		__global const Spectrum* restrict pathThroughput,
		const float3 eyeDir, const float lastPdfW,
		__global SampleResult *sampleResult
		LIGHTS_PARAM_DECL) {
	const float3 throughput = VLOAD3F(pathThroughput->c);

	for (uint i = 0; i < envLightCount; ++i) {
		__global const LightSource* restrict light = &lights[envLightIndices[i]];

		float directPdfW;
		const float3 lightRadiance = EnvLight_GetRadiance(light, -eyeDir, &directPdfW
				LIGHTS_PARAM);

		if (!Spectrum_IsBlack(lightRadiance)) {
			// MIS between BSDF sampling and direct light sampling
			const float weight = ((lastBSDFEvent & SPECULAR) ? 1.f : PowerHeuristic(lastPdfW, directPdfW));

			SampleResult_AddEmission(sampleResult, light->lightID, throughput, weight * lightRadiance);
		}
	}
}
#endif

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
void DirectHitFiniteLight(
		const BSDFEvent lastBSDFEvent,
		__global const Spectrum* restrict pathThroughput, const float distance, __global BSDF *bsdf,
		const float lastPdfW, __global SampleResult *sampleResult
		LIGHTS_PARAM_DECL) {
	float directPdfA;
	const float3 emittedRadiance = BSDF_GetEmittedRadiance(bsdf, &directPdfA
			LIGHTS_PARAM);

	if (!Spectrum_IsBlack(emittedRadiance)) {
		// Add emitted radiance
		float weight = 1.f;
		if (!(lastBSDFEvent & SPECULAR)) {
			const float lightPickProb = Scene_SampleAllLightPdf(lightsDistribution,
					lights[bsdf->triangleLightSourceIndex].lightSceneIndex);
			const float directPdfW = PdfAtoW(directPdfA, distance,
				fabs(dot(VLOAD3F(&bsdf->hitPoint.fixedDir.x), VLOAD3F(&bsdf->hitPoint.shadeN.x))));

			// MIS between BSDF sampling and direct light sampling
			weight = PowerHeuristic(lastPdfW, directPdfW * lightPickProb);
		}

		SampleResult_AddEmission(sampleResult, BSDF_GetLightID(bsdf
				MATERIALS_PARAM), VLOAD3F(pathThroughput->c), weight * emittedRadiance);
	}
}
#endif

float RussianRouletteProb(const float3 color) {
	return clamp(Spectrum_Filter(color), PARAM_RR_CAP, 1.f);
}

bool DirectLight_Illuminate(
#if defined(PARAM_HAS_INFINITELIGHTS)
		const float worldCenterX,
		const float worldCenterY,
		const float worldCenterZ,
		const float worldRadius,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
		__global HitPoint *tmpHitPoint,
#endif
		const float u0, const float u1, const float u2,
#if defined(PARAM_HAS_PASSTHROUGH)
		const float lightPassThroughEvent,
#endif
		const float3 point,
		__global DirectLightIlluminateInfo *info
		LIGHTS_PARAM_DECL) {
	// Pick a light source to sample
	float lightPickPdf;
	const uint lightIndex = Scene_SampleAllLights(lightsDistribution, u0, &lightPickPdf);
	__global const LightSource* restrict light = &lights[lightIndex];

	info->lightIndex = lightIndex;
	info->lightID = light->lightID;
	info->pickPdf = lightPickPdf;

	// Illuminate the point
	float3 lightRayDir;
	float distance, directPdfW;
	const float3 lightRadiance = Light_Illuminate(
			&lights[lightIndex],
			point,
			u1, u2,
#if defined(PARAM_HAS_PASSTHROUGH)
			lightPassThroughEvent,
#endif
#if defined(PARAM_HAS_INFINITELIGHTS)
			worldCenterX, worldCenterY, worldCenterZ, worldRadius,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
			tmpHitPoint,
#endif
			&lightRayDir, &distance, &directPdfW
			LIGHTS_PARAM);

	if (Spectrum_IsBlack(lightRadiance))
		return false;
	else {
		VSTORE3F(lightRayDir, &info->dir.x);
		info->distance = distance;
		info->directPdfW = directPdfW;
		VSTORE3F(lightRadiance, info->lightRadiance.c);
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
		VSTORE3F(lightRadiance, info->lightIrradiance.c);
#endif
		return true;
	}
}

bool DirectLight_BSDFSampling(
		__global DirectLightIlluminateInfo *info,
		const float time,
		const bool lastPathVertex, const uint pathVertexCount,
		__global BSDF *bsdf,
		__global Ray *shadowRay
		LIGHTS_PARAM_DECL) {
	const float3 lightRayDir = VLOAD3F(&info->dir.x);

	// Sample the BSDF
	BSDFEvent event;
	float bsdfPdfW;
	const float3 bsdfEval = BSDF_Evaluate(bsdf,
			lightRayDir, &event, &bsdfPdfW
			MATERIALS_PARAM);

	if (Spectrum_IsBlack(bsdfEval))
		return false;

	const float cosThetaToLight = fabs(dot(lightRayDir, VLOAD3F(&bsdf->hitPoint.shadeN.x)));
	const float directLightSamplingPdfW = info->directPdfW * info->pickPdf;
	const float factor = 1.f / directLightSamplingPdfW;

	// Russian Roulette
	// The +1 is there to account the current path vertex used for DL
	bsdfPdfW *= (pathVertexCount + 1 >= PARAM_RR_DEPTH) ? RussianRouletteProb(bsdfEval) : 1.f;

	// MIS between direct light sampling and BSDF sampling
	//
	// Note: I have to avoiding MIS on the last path vertex
	__global const LightSource* restrict light = &lights[info->lightIndex];
	const float weight = (!lastPathVertex && Light_IsEnvOrIntersectable(light)) ?
		PowerHeuristic(directLightSamplingPdfW, bsdfPdfW) : 1.f;

	const float3 lightRadiance = VLOAD3F(info->lightRadiance.c);
	VSTORE3F(bsdfEval * (weight * factor) * lightRadiance, info->lightRadiance.c);
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
	VSTORE3F(factor * lightRadiance, info->lightIrradiance.c);
#endif

	// Setup the shadow ray
	const float3 hitPoint = VLOAD3F(&bsdf->hitPoint.p.x);
	const float distance = info->distance;
	const float epsilon = fmax(MachineEpsilon_E_Float3(hitPoint), MachineEpsilon_E(distance));

	Ray_Init4(shadowRay, hitPoint, lightRayDir,
		epsilon,
		distance - epsilon, time);

	return true;
}

//------------------------------------------------------------------------------
// Kernel parameters
//------------------------------------------------------------------------------

#if defined(PARAM_HAS_VOLUMES)
#define KERNEL_ARGS_VOLUMES \
		, __global PathVolumeInfo *pathVolInfos \
		, __global PathVolumeInfo *directLightVolInfos
#else
#define KERNEL_ARGS_VOLUMES
#endif

#if defined(PARAM_FILM_RADIANCE_GROUP_0)
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_0 \
		, __global float *filmRadianceGroup0
#else
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_0
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_1 \
		, __global float *filmRadianceGroup1
#else
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_1
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_2 \
		, __global float *filmRadianceGroup2
#else
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_2
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_3 \
		, __global float *filmRadianceGroup3
#else
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_3
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_4 \
		, __global float *filmRadianceGroup4
#else
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_4
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_5 \
		, __global float *filmRadianceGroup5
#else
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_5
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_6 \
		, __global float *filmRadianceGroup6
#else
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_6
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_7 \
		, __global float *filmRadianceGroup7
#else
#define KERNEL_ARGS_FILM_RADIANCE_GROUP_7
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
#define KERNEL_ARGS_FILM_CHANNELS_ALPHA \
		, __global float *filmAlpha
#else
#define KERNEL_ARGS_FILM_CHANNELS_ALPHA
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
#define KERNEL_ARGS_FILM_CHANNELS_DEPTH \
		, __global float *filmDepth
#else
#define KERNEL_ARGS_FILM_CHANNELS_DEPTH
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
#define KERNEL_ARGS_FILM_CHANNELS_POSITION \
		, __global float *filmPosition
#else
#define KERNEL_ARGS_FILM_CHANNELS_POSITION
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
#define KERNEL_ARGS_FILM_CHANNELS_GEOMETRY_NORMAL \
		, __global float *filmGeometryNormal
#else
#define KERNEL_ARGS_FILM_CHANNELS_GEOMETRY_NORMAL
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
#define KERNEL_ARGS_FILM_CHANNELS_SHADING_NORMAL \
		, __global float *filmShadingNormal
#else
#define KERNEL_ARGS_FILM_CHANNELS_SHADING_NORMAL
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
#define KERNEL_ARGS_FILM_CHANNELS_MATERIAL_ID \
		, __global uint *filmMaterialID
#else
#define KERNEL_ARGS_FILM_CHANNELS_MATERIAL_ID
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_DIFFUSE)
#define KERNEL_ARGS_FILM_CHANNELS_DIRECT_DIFFUSE \
		, __global float *filmDirectDiffuse
#else
#define KERNEL_ARGS_FILM_CHANNELS_DIRECT_DIFFUSE
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_GLOSSY)
#define KERNEL_ARGS_FILM_CHANNELS_DIRECT_GLOSSY \
		, __global float *filmDirectGlossy
#else
#define KERNEL_ARGS_FILM_CHANNELS_DIRECT_GLOSSY
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_EMISSION)
#define KERNEL_ARGS_FILM_CHANNELS_EMISSION \
		, __global float *filmEmission
#else
#define KERNEL_ARGS_FILM_CHANNELS_EMISSION
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_DIFFUSE)
#define KERNEL_ARGS_FILM_CHANNELS_INDIRECT_DIFFUSE \
		, __global float *filmIndirectDiffuse
#else
#define KERNEL_ARGS_FILM_CHANNELS_INDIRECT_DIFFUSE
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_GLOSSY)
#define KERNEL_ARGS_FILM_CHANNELS_INDIRECT_GLOSSY \
		, __global float *filmIndirectGlossy
#else
#define KERNEL_ARGS_FILM_CHANNELS_INDIRECT_GLOSSY
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SPECULAR)
#define KERNEL_ARGS_FILM_CHANNELS_INDIRECT_SPECULAR \
		, __global float *filmIndirectSpecular
#else
#define KERNEL_ARGS_FILM_CHANNELS_INDIRECT_SPECULAR
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID_MASK)
#define KERNEL_ARGS_FILM_CHANNELS_ID_MASK \
		, __global float *filmMaterialIDMask
#else
#define KERNEL_ARGS_FILM_CHANNELS_ID_MASK
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DIRECT_SHADOW_MASK)
#define KERNEL_ARGS_FILM_CHANNELS_DIRECT_SHADOW_MASK \
		, __global float *filmDirectShadowMask
#else
#define KERNEL_ARGS_FILM_CHANNELS_DIRECT_SHADOW_MASK
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_INDIRECT_SHADOW_MASK)
#define KERNEL_ARGS_FILM_CHANNELS_INDIRECT_SHADOW_MASK \
		, __global float *filmIndirectShadowMask
#else
#define KERNEL_ARGS_FILM_CHANNELS_INDIRECT_SHADOW_MASK
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
#define KERNEL_ARGS_FILM_CHANNELS_UV \
		, __global float *filmUV
#else
#define KERNEL_ARGS_FILM_CHANNELS_UV
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
#define KERNEL_ARGS_FILM_CHANNELS_RAYCOUNT \
		, __global float *filmRayCount
#else
#define KERNEL_ARGS_FILM_CHANNELS_RAYCOUNT
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_BY_MATERIAL_ID)
#define KERNEL_ARGS_FILM_CHANNELS_BY_MATERIAL_ID \
		, __global float *filmByMaterialID
#else
#define KERNEL_ARGS_FILM_CHANNELS_BY_MATERIAL_ID
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
#define KERNEL_ARGS_FILM_CHANNELS_IRRADIANCE \
		, __global float *filmIrradiance
#else
#define KERNEL_ARGS_FILM_CHANNELS_IRRADIANCE
#endif

#define KERNEL_ARGS_FILM \
		, const uint filmWidth, const uint filmHeight \
		KERNEL_ARGS_FILM_RADIANCE_GROUP_0 \
		KERNEL_ARGS_FILM_RADIANCE_GROUP_1 \
		KERNEL_ARGS_FILM_RADIANCE_GROUP_2 \
		KERNEL_ARGS_FILM_RADIANCE_GROUP_3 \
		KERNEL_ARGS_FILM_RADIANCE_GROUP_4 \
		KERNEL_ARGS_FILM_RADIANCE_GROUP_5 \
		KERNEL_ARGS_FILM_RADIANCE_GROUP_6 \
		KERNEL_ARGS_FILM_RADIANCE_GROUP_7 \
		KERNEL_ARGS_FILM_CHANNELS_ALPHA \
		KERNEL_ARGS_FILM_CHANNELS_DEPTH \
		KERNEL_ARGS_FILM_CHANNELS_POSITION \
		KERNEL_ARGS_FILM_CHANNELS_GEOMETRY_NORMAL \
		KERNEL_ARGS_FILM_CHANNELS_SHADING_NORMAL \
		KERNEL_ARGS_FILM_CHANNELS_MATERIAL_ID \
		KERNEL_ARGS_FILM_CHANNELS_DIRECT_DIFFUSE \
		KERNEL_ARGS_FILM_CHANNELS_DIRECT_GLOSSY \
		KERNEL_ARGS_FILM_CHANNELS_EMISSION \
		KERNEL_ARGS_FILM_CHANNELS_INDIRECT_DIFFUSE \
		KERNEL_ARGS_FILM_CHANNELS_INDIRECT_GLOSSY \
		KERNEL_ARGS_FILM_CHANNELS_INDIRECT_SPECULAR \
		KERNEL_ARGS_FILM_CHANNELS_ID_MASK \
		KERNEL_ARGS_FILM_CHANNELS_DIRECT_SHADOW_MASK \
		KERNEL_ARGS_FILM_CHANNELS_INDIRECT_SHADOW_MASK \
		KERNEL_ARGS_FILM_CHANNELS_UV \
		KERNEL_ARGS_FILM_CHANNELS_RAYCOUNT \
		KERNEL_ARGS_FILM_CHANNELS_BY_MATERIAL_ID \
		KERNEL_ARGS_FILM_CHANNELS_IRRADIANCE

#if defined(PARAM_HAS_INFINITELIGHTS)
#define KERNEL_ARGS_INFINITELIGHTS \
		, const float worldCenterX \
		, const float worldCenterY \
		, const float worldCenterZ \
		, const float worldRadius
#else
#define KERNEL_ARGS_INFINITELIGHTS
#endif

#if defined(PARAM_HAS_NORMALS_BUFFER)
#define KERNEL_ARGS_NORMALS_BUFFER \
		, __global const Vector* restrict vertNormals
#else
#define KERNEL_ARGS_NORMALS_BUFFER
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
#define KERNEL_ARGS_UVS_BUFFER \
		, __global const UV* restrict vertUVs
#else
#define KERNEL_ARGS_UVS_BUFFER
#endif
#if defined(PARAM_HAS_COLS_BUFFER)
#define KERNEL_ARGS_COLS_BUFFER \
		, __global const Spectrum* restrict vertCols
#else
#define KERNEL_ARGS_COLS_BUFFER
#endif
#if defined(PARAM_HAS_ALPHAS_BUFFER)
#define KERNEL_ARGS_ALPHAS_BUFFER \
		, __global const float* restrict vertAlphas
#else
#define KERNEL_ARGS_ALPHAS_BUFFER
#endif

#if defined(PARAM_HAS_ENVLIGHTS)
#define KERNEL_ARGS_ENVLIGHTS \
		, __global const uint* restrict envLightIndices \
		, const uint envLightCount
#else
#define KERNEL_ARGS_ENVLIGHTS
#endif
#if defined(PARAM_HAS_INFINITELIGHT)
#define KERNEL_ARGS_INFINITELIGHT \
		, __global const float* restrict infiniteLightDistribution
#else
#define KERNEL_ARGS_INFINITELIGHT
#endif

#if defined(PARAM_IMAGEMAPS_PAGE_0)
#define KERNEL_ARGS_IMAGEMAPS_PAGE_0 \
		, __global const ImageMap* restrict imageMapDescs, __global const float* restrict imageMapBuff0
#else
#define KERNEL_ARGS_IMAGEMAPS_PAGE_0
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_1)
#define KERNEL_ARGS_IMAGEMAPS_PAGE_1 \
		, __global const float* restrict imageMapBuff1
#else
#define KERNEL_ARGS_IMAGEMAPS_PAGE_1
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_2)
#define KERNEL_ARGS_IMAGEMAPS_PAGE_2 \
		, __global const float* restrict imageMapBuff2
#else
#define KERNEL_ARGS_IMAGEMAPS_PAGE_2
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_3)
#define KERNEL_ARGS_IMAGEMAPS_PAGE_3 \
		, __global const float* restrict imageMapBuff3
#else
#define KERNEL_ARGS_IMAGEMAPS_PAGE_3
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_4)
#define KERNEL_ARGS_IMAGEMAPS_PAGE_4 \
		, __global const float* restrict imageMapBuff4
#else
#define KERNEL_ARGS_IMAGEMAPS_PAGE_4
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_5)
#define KERNEL_ARGS_IMAGEMAPS_PAGE_5 \
		, __global const float* restrict imageMapBuff5
#else
#define KERNEL_ARGS_IMAGEMAPS_PAGE_5
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_6)
#define KERNEL_ARGS_IMAGEMAPS_PAGE_6 \
		, __global const float* restrict imageMapBuff6
#else
#define KERNEL_ARGS_IMAGEMAPS_PAGE_6
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_7)
#define KERNEL_ARGS_IMAGEMAPS_PAGE_7 \
		, __global const float* restrict imageMapBuff7
#else
#define KERNEL_ARGS_IMAGEMAPS_PAGE_7
#endif
#define KERNEL_ARGS_IMAGEMAPS_PAGES \
		KERNEL_ARGS_IMAGEMAPS_PAGE_0 \
		KERNEL_ARGS_IMAGEMAPS_PAGE_1 \
		KERNEL_ARGS_IMAGEMAPS_PAGE_2 \
		KERNEL_ARGS_IMAGEMAPS_PAGE_3 \
		KERNEL_ARGS_IMAGEMAPS_PAGE_4 \
		KERNEL_ARGS_IMAGEMAPS_PAGE_5 \
		KERNEL_ARGS_IMAGEMAPS_PAGE_6 \
		KERNEL_ARGS_IMAGEMAPS_PAGE_7

#define KERNEL_ARGS \
		__global GPUTask *tasks \
		, __global GPUTaskDirectLight *tasksDirectLight \
		, __global GPUTaskState *tasksState \
		, __global GPUTaskStats *taskStats \
		, __global Sample *samples \
		, __global float *samplesData \
		KERNEL_ARGS_VOLUMES \
		, __global Ray *rays \
		, __global RayHit *rayHits \
		/* Film parameters */ \
		KERNEL_ARGS_FILM \
		/* Scene parameters */ \
		KERNEL_ARGS_INFINITELIGHTS \
		, __global const Material* restrict mats \
		, __global const Texture* restrict texs \
		, __global const uint* restrict meshMats \
		, __global const Mesh* restrict meshDescs \
		, __global const Point* restrict vertices \
		KERNEL_ARGS_NORMALS_BUFFER \
		KERNEL_ARGS_UVS_BUFFER \
		KERNEL_ARGS_COLS_BUFFER \
		KERNEL_ARGS_ALPHAS_BUFFER \
		, __global const Triangle* restrict triangles \
		, __global const Camera* restrict camera \
		/* Lights */ \
		, __global const LightSource* restrict lights \
		KERNEL_ARGS_ENVLIGHTS \
		, __global const uint* restrict meshTriLightDefsOffset \
		KERNEL_ARGS_INFINITELIGHT \
		, __global const float* restrict lightsDistribution \
		/* Images */ \
		KERNEL_ARGS_IMAGEMAPS_PAGES


//------------------------------------------------------------------------------
// To initialize image maps page pointer table
//------------------------------------------------------------------------------

#if defined(PARAM_IMAGEMAPS_PAGE_0)
#define INIT_IMAGEMAPS_PAGE_0 imageMapBuff[0] = imageMapBuff0;
#else
#define INIT_IMAGEMAPS_PAGE_0
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_1)
#define INIT_IMAGEMAPS_PAGE_1 imageMapBuff[1] = imageMapBuff1;
#else
#define INIT_IMAGEMAPS_PAGE_1
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_2)
#define INIT_IMAGEMAPS_PAGE_2 imageMapBuff[2] = imageMapBuff2;
#else
#define INIT_IMAGEMAPS_PAGE_2
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_3)
#define INIT_IMAGEMAPS_PAGE_3 imageMapBuff[3] = imageMapBuff3;
#else
#define INIT_IMAGEMAPS_PAGE_3
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_4)
#define INIT_IMAGEMAPS_PAGE_4 imageMapBuff[4] = imageMapBuff4;
#else
#define INIT_IMAGEMAPS_PAGE_4
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_5)
#define INIT_IMAGEMAPS_PAGE_5 imageMapBuff[5] = imageMapBuff5;
#else
#define INIT_IMAGEMAPS_PAGE_5
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_6)
#define INIT_IMAGEMAPS_PAGE_6 imageMapBuff[6] = imageMapBuff6;
#else
#define INIT_IMAGEMAPS_PAGE_6
#endif
#if defined(PARAM_IMAGEMAPS_PAGE_7)
#define INIT_IMAGEMAPS_PAGE_7 imageMapBuff[7] = imageMapBuff7;
#else
#define INIT_IMAGEMAPS_PAGE_7
#endif

#if defined(PARAM_HAS_IMAGEMAPS)
#define INIT_IMAGEMAPS_PAGES \
	__global const float* restrict imageMapBuff[PARAM_IMAGEMAPS_COUNT]; \
	INIT_IMAGEMAPS_PAGE_0 \
	INIT_IMAGEMAPS_PAGE_1 \
	INIT_IMAGEMAPS_PAGE_2 \
	INIT_IMAGEMAPS_PAGE_3 \
	INIT_IMAGEMAPS_PAGE_4 \
	INIT_IMAGEMAPS_PAGE_5 \
	INIT_IMAGEMAPS_PAGE_6 \
	INIT_IMAGEMAPS_PAGE_7
#else
#define INIT_IMAGEMAPS_PAGES
#endif
#line 2 "patchocl_kernels_micro.cl"

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

//------------------------------------------------------------------------------
// AdvancePaths (Micro-Kernels)
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_RT_NEXT_VERTEX
// To: MK_HIT_NOTHING or MK_HIT_OBJECT or MK_RT_NEXT_VERTEX
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_RT_NEXT_VERTEX(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

#if defined(PARAM_FILM_CHANNELS_HAS_RAYCOUNT)
	// This has to be done by the first kernel to run after RT kernel
	samples[gid].result.rayCount += 1;
#endif

	// Read the path state
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_RT_NEXT_VERTEX)
		return;

	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	// Initialize image maps page pointer table
	INIT_IMAGEMAPS_PAGES

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	float3 connectionThroughput;
	const bool continueToTrace = Scene_Intersect(
#if defined(PARAM_HAS_VOLUMES)
			&pathVolInfos[gid],
			&tasks[gid].tmpHitPoint,
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
			taskState->bsdf.hitPoint.passThroughEvent,
#endif
			&rays[gid], &rayHits[gid], &taskState->bsdf,
			&connectionThroughput, VLOAD3F(taskState->throughput.c),
			&samples[gid].result,
			// BSDF_Init parameters
			meshDescs,
			meshMats,
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
			meshTriLightDefsOffset,
#endif
			vertices,
#if defined(PARAM_HAS_NORMALS_BUFFER)
			vertNormals,
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
			vertUVs,
#endif
#if defined(PARAM_HAS_COLS_BUFFER)
			vertCols,
#endif
#if defined(PARAM_HAS_ALPHAS_BUFFER)
			vertAlphas,
#endif
			triangles
			MATERIALS_PARAM
			);
	VSTORE3F(connectionThroughput * VLOAD3F(taskState->throughput.c), taskState->throughput.c);

	// If continueToTrace, there is nothing to do, just keep the same state
	if (!continueToTrace) {
		const bool rayMiss = (rayHits[gid].meshIndex == NULL_INDEX);
		taskState->state = rayMiss ? MK_HIT_NOTHING : MK_HIT_OBJECT;
	}
#if defined(PARAM_HAS_PASSTHROUGH)
	else {
		// I generate a new random variable starting from the previous one. I'm
		// not really sure about the kind of correlation introduced by this
		// trick.
		taskState->bsdf.hitPoint.passThroughEvent = fabs(taskState->bsdf.hitPoint.passThroughEvent - .5f) * 2.f;
	}
#endif
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_HIT_NOTHING
// To: MK_SPLAT_SAMPLE
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_HIT_NOTHING(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_HIT_NOTHING)
		return;

	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	__global GPUTaskDirectLight *taskDirectLight = &tasksDirectLight[gid];

	// Initialize image maps page pointer table
	INIT_IMAGEMAPS_PAGES

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	// Nothing was hit, add environmental lights radiance

#if defined(PARAM_HAS_ENVLIGHTS)
	DirectHitInfiniteLight(
			taskDirectLight->lastBSDFEvent,
			&taskState->throughput,
			VLOAD3F(&rays[gid].d.x), taskDirectLight->lastPdfW,
			&samples[gid].result
			LIGHTS_PARAM);
#endif

	if (taskState->pathVertexCount == 1) {
		__global Sample *sample = &samples[gid];

#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
		sample->result.alpha = 0.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
		sample->result.depth = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
		sample->result.position.x = INFINITY;
		sample->result.position.y = INFINITY;
		sample->result.position.z = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
		sample->result.geometryNormal.x = INFINITY;
		sample->result.geometryNormal.y = INFINITY;
		sample->result.geometryNormal.z = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
		sample->result.shadingNormal.x = INFINITY;
		sample->result.shadingNormal.y = INFINITY;
		sample->result.shadingNormal.z = INFINITY;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
		sample->result.materialID = NULL_INDEX;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
		sample->result.uv.u = INFINITY;
		sample->result.uv.v = INFINITY;
#endif
	}

	taskState->state = MK_SPLAT_SAMPLE;
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_HIT_OBJECT
// To: MK_DL_ILLUMINATE or MK_SPLAT_SAMPLE
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_HIT_OBJECT(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_HIT_OBJECT)
		return;

	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	__global BSDF *bsdf = &taskState->bsdf;
	__global Sample *sample = &samples[gid];

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	// Something was hit

	if (taskState->pathVertexCount == 1) {
#if defined(PARAM_FILM_CHANNELS_HAS_ALPHA)
		sample->result.alpha = 1.f;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_DEPTH)
		sample->result.depth = rayHits[gid].t;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_POSITION)
		sample->result.position = bsdf->hitPoint.p;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_GEOMETRY_NORMAL)
		sample->result.geometryNormal = bsdf->hitPoint.geometryN;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_SHADING_NORMAL)
		sample->result.shadingNormal = bsdf->hitPoint.shadeN;
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_MATERIAL_ID)
		// Initialize image maps page pointer table
		INIT_IMAGEMAPS_PAGES

		sample->result.materialID = BSDF_GetMaterialID(bsdf
				MATERIALS_PARAM);
#endif
#if defined(PARAM_FILM_CHANNELS_HAS_UV)
		sample->result.uv = bsdf->hitPoint.uv;
#endif
	}

#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
	// Check if it is a light source (note: I can hit only triangle area light sources)
	if (BSDF_IsLightSource(bsdf)) {
		__global GPUTaskDirectLight *taskDirectLight = &tasksDirectLight[gid];

		// Initialize image maps page pointer table
		INIT_IMAGEMAPS_PAGES

		DirectHitFiniteLight(
				taskDirectLight->lastBSDFEvent,
				&taskState->throughput,
				rayHits[gid].t, bsdf, taskDirectLight->lastPdfW,
				&sample->result
				LIGHTS_PARAM);
	}
#endif

	// Check if this is the last path vertex (but not also the first)
	//
	// I handle as a special case when the path vertex is both the first
	// and the last: I do direct light sampling without MIS.
	taskState->state = (sample->result.lastPathVertex && !sample->result.firstPathVertex) ?
		MK_SPLAT_SAMPLE : MK_DL_ILLUMINATE;
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_RT_DL
// To: MK_GENERATE_NEXT_VERTEX_RAY
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_RT_DL(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTask *task = &tasks[gid];
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_RT_DL)
		return;

 	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	__global GPUTaskDirectLight *taskDirectLight = &tasksDirectLight[gid];

	// Initialize image maps page pointer table
	INIT_IMAGEMAPS_PAGES

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	float3 connectionThroughput = WHITE;
#if defined(PARAM_HAS_PASSTHROUGH) || defined(PARAM_HAS_VOLUMES)
	const bool continueToTrace =
		Scene_Intersect(
#if defined(PARAM_HAS_VOLUMES)
			&directLightVolInfos[gid],
			&task->tmpHitPoint,
#endif
#if defined(PARAM_HAS_PASSTHROUGH)
			taskDirectLight->rayPassThroughEvent,
#endif
			&rays[gid], &rayHits[gid], &task->tmpBsdf,
			&connectionThroughput, WHITE,
			NULL,
			// BSDF_Init parameters
			meshDescs,
			meshMats,
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
			meshTriLightDefsOffset,
#endif
			vertices,
#if defined(PARAM_HAS_NORMALS_BUFFER)
			vertNormals,
#endif
#if defined(PARAM_HAS_UVS_BUFFER)
			vertUVs,
#endif
#if defined(PARAM_HAS_COLS_BUFFER)
			vertCols,
#endif
#if defined(PARAM_HAS_ALPHAS_BUFFER)
			vertAlphas,
#endif
			triangles
			MATERIALS_PARAM
			);
	VSTORE3F(connectionThroughput * VLOAD3F(taskDirectLight->illumInfo.lightRadiance.c), taskDirectLight->illumInfo.lightRadiance.c);
#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
	VSTORE3F(connectionThroughput * VLOAD3F(taskDirectLight->illumInfo.lightIrradiance.c), taskDirectLight->illumInfo.lightIrradiance.c);
#endif
#else
	const bool continueToTrace = false;
#endif

	const bool rayMiss = (rayHits[gid].meshIndex == NULL_INDEX);

	// If continueToTrace, there is nothing to do, just keep the same state
	if (!continueToTrace) {
		__global Sample *sample = &samples[gid];

		if (rayMiss) {
			// Nothing was hit, the light source is visible

			const float3 lightRadiance = VLOAD3F(taskDirectLight->illumInfo.lightRadiance.c);
			SampleResult_AddDirectLight(&sample->result, taskDirectLight->illumInfo.lightID,
					BSDF_GetEventTypes(&taskState->bsdf
						MATERIALS_PARAM),
					VLOAD3F(taskState->throughput.c), lightRadiance,
					1.f);

#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
			// The first path vertex is not handled by AddDirectLight(). This is valid
			// for irradiance AOV only if it is not a SPECULAR material.
			//
			// Note: irradiance samples the light sources only here (i.e. no
			// direct hit, no MIS, it would be useless)
			if ((sample->result.firstPathVertex) && !(BSDF_GetEventTypes(&taskState->bsdf
						MATERIALS_PARAM) & SPECULAR)) {
				const float3 irradiance = (M_1_PI_F * fabs(dot(
							VLOAD3F(&taskState->bsdf.hitPoint.shadeN.x),
							VLOAD3F(&rays[gid].d.x)))) *
						VLOAD3F(taskDirectLight->illumInfo.lightIrradiance.c);
				VSTORE3F(irradiance, sample->result.irradiance.c);
			}
#endif
		}

		// Check if this is the last path vertex
		if (sample->result.lastPathVertex)
			pathState = MK_SPLAT_SAMPLE;
		else
			pathState = MK_GENERATE_NEXT_VERTEX_RAY;

		// Save the state
		taskState->state = pathState;
	}
#if defined(PARAM_HAS_PASSTHROUGH)
	else {
		// I generate a new random variable starting from the previous one. I'm
		// not really sure about the kind of correlation introduced by this
		// trick.
		taskDirectLight->rayPassThroughEvent = fabs(taskDirectLight->rayPassThroughEvent - .5f) * 2.f;
	}
#endif
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_DL_ILLUMINATE
// To: MK_DL_SAMPLE_BSDF or MK_GENERATE_NEXT_VERTEX_RAY
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_DL_ILLUMINATE(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTask *task = &tasks[gid];
	__global GPUTaskState *taskState = &tasksState[gid];
	if (taskState->state != MK_DL_ILLUMINATE)
		return;

 	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	const uint pathVertexCount = taskState->pathVertexCount;

	__global BSDF *bsdf = &taskState->bsdf;

	__global Sample *sample = &samples[gid];
	__global float *sampleData = Sampler_GetSampleData(sample, samplesData);
	__global float *sampleDataPathBase = Sampler_GetSampleDataPathBase(sample, sampleData);
#if (PARAM_SAMPLER_TYPE != 0)
	// Used by Sampler_GetSamplePathVertex() macro
	__global float *sampleDataPathVertexBase = Sampler_GetSampleDataPathVertex(
			sample, sampleDataPathBase, pathVertexCount);
#endif

	// Read the seed
	Seed seedValue = task->seed;
	// This trick is required by Sampler_GetSample() macro
	Seed *seed = &seedValue;


	// Initialize image maps page pointer table
	INIT_IMAGEMAPS_PAGES

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	if (!BSDF_IsDelta(bsdf
			MATERIALS_PARAM) &&
			DirectLight_Illuminate(
#if defined(PARAM_HAS_INFINITELIGHTS)
				worldCenterX, worldCenterY, worldCenterZ, worldRadius,
#endif
#if (PARAM_TRIANGLE_LIGHT_COUNT > 0)
				&task->tmpHitPoint,
#endif
				Sampler_GetSamplePathVertex(pathVertexCount, IDX_DIRECTLIGHT_X),
				Sampler_GetSamplePathVertex(pathVertexCount, IDX_DIRECTLIGHT_Y),
				Sampler_GetSamplePathVertex(pathVertexCount, IDX_DIRECTLIGHT_Z),
#if defined(PARAM_HAS_PASSTHROUGH)
				Sampler_GetSamplePathVertex(pathVertexCount, IDX_DIRECTLIGHT_W),
#endif
				VLOAD3F(&bsdf->hitPoint.p.x), &tasksDirectLight[gid].illumInfo
				LIGHTS_PARAM)) {
		// I have now to evaluate the BSDF
		taskState->state = MK_DL_SAMPLE_BSDF;
	} else {
		// No shadow ray to trace, move to the next vertex ray
		// however, I have to Check if this is the last path vertex
		taskState->state = (sample->result.lastPathVertex) ? MK_SPLAT_SAMPLE : MK_GENERATE_NEXT_VERTEX_RAY;
	}

	//--------------------------------------------------------------------------

	// Save the seed
	task->seed = seedValue;
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_DL_SAMPLE_BSDF
// To: MK_GENERATE_NEXT_VERTEX_RAY or MK_RT_DL or MK_SPLAT_SAMPLE
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_DL_SAMPLE_BSDF(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_DL_SAMPLE_BSDF)
		return;

 	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	const uint pathVertexCount = taskState->pathVertexCount;
	__global Sample *sample = &samples[gid];

	// Initialize image maps page pointer table
	INIT_IMAGEMAPS_PAGES

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	if (DirectLight_BSDFSampling(
			&tasksDirectLight[gid].illumInfo,
			rays[gid].time, sample->result.lastPathVertex, taskState->pathVertexCount,
			&taskState->bsdf,
			&rays[gid]
			LIGHTS_PARAM)) {
#if defined(PARAM_HAS_PASSTHROUGH)
		__global float *sampleData = Sampler_GetSampleData(sample, samplesData);
		__global float *sampleDataPathBase = Sampler_GetSampleDataPathBase(sample, sampleData);
#if (PARAM_SAMPLER_TYPE != 0)
		// Used by Sampler_GetSamplePathVertex() macro
		__global float *sampleDataPathVertexBase = Sampler_GetSampleDataPathVertex(
				sample, sampleDataPathBase, pathVertexCount);
#endif
		__global GPUTask *task = &tasks[gid];
		Seed seedValue = task->seed;
		// This trick is required by Sampler_GetSample() macro
		Seed *seed = &seedValue;


		// Initialize the pass-through event for the shadow ray
		tasksDirectLight[gid].rayPassThroughEvent = Sampler_GetSamplePathVertex(pathVertexCount, IDX_DIRECTLIGHT_A);

		// Save the seed
		task->seed = seedValue;
#endif
#if defined(PARAM_HAS_VOLUMES)
		// Make a copy of current PathVolumeInfo for tracing the
		// shadow ray
		directLightVolInfos[gid] = pathVolInfos[gid];
#endif
		// I have to trace the shadow ray
		taskState->state = MK_RT_DL;
	} else {
		// No shadow ray to trace, move to the next vertex ray
		// however, I have to check if this is the last path vertex
		taskState->state = (sample->result.lastPathVertex) ? MK_SPLAT_SAMPLE : MK_GENERATE_NEXT_VERTEX_RAY;
	}
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_GENERATE_NEXT_VERTEX_RAY
// To: MK_SPLAT_SAMPLE or MK_RT_NEXT_VERTEX
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_GENERATE_NEXT_VERTEX_RAY(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTask *task = &tasks[gid];
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_GENERATE_NEXT_VERTEX_RAY)
		return;

 	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	uint pathVertexCount = taskState->pathVertexCount;

	__global BSDF *bsdf = &taskState->bsdf;

	__global Sample *sample = &samples[gid];
	__global float *sampleData = Sampler_GetSampleData(sample, samplesData);
	__global float *sampleDataPathBase = Sampler_GetSampleDataPathBase(sample, sampleData);
#if (PARAM_SAMPLER_TYPE != 0)
	// Used by Sampler_GetSamplePathVertex() macro
	__global float *sampleDataPathVertexBase = Sampler_GetSampleDataPathVertex(
			sample, sampleDataPathBase, pathVertexCount);
#endif

	// Read the seed
	Seed seedValue = task->seed;
	// This trick is required by Sampler_GetSample() macro
	Seed *seed = &seedValue;

	// Initialize image maps page pointer table
	INIT_IMAGEMAPS_PAGES

	__global Ray *ray = &rays[gid];

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	// Sample the BSDF
	float3 sampledDir;
	float lastPdfW;
	float cosSampledDir;
	BSDFEvent event;

	const float3 bsdfSample = BSDF_Sample(bsdf,
			Sampler_GetSamplePathVertex(pathVertexCount, IDX_BSDF_X),
			Sampler_GetSamplePathVertex(pathVertexCount, IDX_BSDF_Y),
			&sampledDir, &lastPdfW, &cosSampledDir, &event, ALL
			MATERIALS_PARAM);

	// Russian Roulette
	const bool rrEnabled = (pathVertexCount >= PARAM_RR_DEPTH);
	const float rrProb = rrEnabled ? RussianRouletteProb(bsdfSample) : 1.f;
	const bool rrContinuePath = !rrEnabled || !(rrProb < Sampler_GetSamplePathVertex(pathVertexCount, IDX_RR));

	// Max. path depth
	const bool maxPathDepth = (pathVertexCount >= PARAM_MAX_PATH_DEPTH);

	const bool continuePath = !Spectrum_IsBlack(bsdfSample) && rrContinuePath && !maxPathDepth;
	if (continuePath) {
		float3 throughputFactor = WHITE;

		// RR increases path contribution
		throughputFactor /= rrProb;
		// PDF clamping (or better: scaling)
		const float pdfFactor = (event & SPECULAR) ? 1.f : min(1.f, lastPdfW / PARAM_PDF_CLAMP_VALUE);
		throughputFactor *= bsdfSample * pdfFactor;

		VSTORE3F(throughputFactor * VLOAD3F(taskState->throughput.c), taskState->throughput.c);

#if defined(PARAM_FILM_CHANNELS_HAS_IRRADIANCE)
		// This is valid for irradiance AOV only if it is not a SPECULAR material and
		// first path vertex. Set or update sampleResult.irradiancePathThroughput
		if (sample->result.firstPathVertex) {
			if (!(BSDF_GetEventTypes(&taskState->bsdf
						MATERIALS_PARAM) & SPECULAR))
				VSTORE3F(M_1_PI_F * fabs(dot(
						VLOAD3F(&bsdf->hitPoint.shadeN.x),
						sampledDir)) / rrProb,
						sample->result.irradiancePathThroughput.c);
			else
				VSTORE3F(BLACK, sample->result.irradiancePathThroughput.c);
		} else
			VSTORE3F(throughputFactor * VLOAD3F(sample->result.irradiancePathThroughput.c), sample->result.irradiancePathThroughput.c);
#endif

#if defined(PARAM_HAS_VOLUMES)
		// Update volume information
		PathVolumeInfo_Update(&pathVolInfos[gid], event, bsdf
				MATERIALS_PARAM);
#endif

		Ray_Init2(ray, VLOAD3F(&bsdf->hitPoint.p.x), sampledDir, ray->time);

		++pathVertexCount;
		sample->result.firstPathVertex = false;
		sample->result.lastPathVertex = (pathVertexCount == PARAM_MAX_PATH_DEPTH);

		if (sample->result.firstPathVertex)
			sample->result.firstPathVertexEvent = event;

		taskState->pathVertexCount = pathVertexCount;
		tasksDirectLight[gid].lastBSDFEvent = event;
		tasksDirectLight[gid].lastPdfW = lastPdfW;
#if defined(PARAM_HAS_PASSTHROUGH)
		// This is a bit tricky. I store the passThroughEvent in the BSDF
		// before of the initialization because it can be use during the
		// tracing of next path vertex ray.

		// This sampleDataPathVertexBase is used inside Sampler_GetSamplePathVertex() macro
		__global float *sampleDataPathVertexBase = Sampler_GetSampleDataPathVertex(
			sample, sampleDataPathBase, pathVertexCount);
		taskState->bsdf.hitPoint.passThroughEvent = Sampler_GetSamplePathVertex(pathVertexCount, IDX_PASSTHROUGH);
#endif

		pathState = MK_RT_NEXT_VERTEX;
	} else
		pathState = MK_SPLAT_SAMPLE;

	// Save the state
	taskState->state = pathState;

	//--------------------------------------------------------------------------

	// Save the seed
	task->seed = seedValue;
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_SPLAT_SAMPLE
// To: MK_NEXT_SAMPLE
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_SPLAT_SAMPLE(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTask *task = &tasks[gid];
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_SPLAT_SAMPLE)
		return;

	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	__global Sample *sample = &samples[gid];
	__global float *sampleData = Sampler_GetSampleData(sample, samplesData);

	// Read the seed
	Seed seedValue = task->seed;

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	// Initialize Film radiance group pointer table
	__global float *filmRadianceGroup[PARAM_FILM_RADIANCE_GROUP_COUNT];
#if defined(PARAM_FILM_RADIANCE_GROUP_0)
	filmRadianceGroup[0] = filmRadianceGroup0;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_1)
	filmRadianceGroup[1] = filmRadianceGroup1;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_2)
	filmRadianceGroup[2] = filmRadianceGroup2;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_3)
	filmRadianceGroup[3] = filmRadianceGroup3;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_4)
	filmRadianceGroup[4] = filmRadianceGroup4;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_5)
	filmRadianceGroup[5] = filmRadianceGroup5;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_6)
	filmRadianceGroup[6] = filmRadianceGroup6;
#endif
#if defined(PARAM_FILM_RADIANCE_GROUP_7)
	filmRadianceGroup[7] = filmRadianceGroup7;
#endif

	if (PARAM_RADIANCE_CLAMP_MAXVALUE > 0.f) {
		// Radiance clamping
		SampleResult_ClampRadiance(&sample->result, PARAM_RADIANCE_CLAMP_MAXVALUE);
	}

	Sampler_SplatSample(&seedValue, sample, sampleData
			FILM_PARAM);
	taskStats[gid].sampleCount += 1;

	// Save the state
	taskState->state = MK_NEXT_SAMPLE;

	//--------------------------------------------------------------------------

	// Save the seed
	task->seed = seedValue;
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_NEXT_SAMPLE
// To: MK_GENERATE_CAMERA_RAY
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_NEXT_SAMPLE(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTask *task = &tasks[gid];
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_NEXT_SAMPLE)
		return;

	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	__global Sample *sample = &samples[gid];
	__global float *sampleData = Sampler_GetSampleData(sample, samplesData);

	// Read the seed
	Seed seedValue = task->seed;

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	Sampler_NextSample(&seedValue, sample, sampleData, filmWidth, filmHeight);

	// Save the state
	taskState->state = MK_GENERATE_CAMERA_RAY;

	//--------------------------------------------------------------------------

	// Save the seed
	task->seed = seedValue;
}

//------------------------------------------------------------------------------
// Evaluation of the Path finite state machine.
//
// From: MK_GENERATE_CAMERA_RAY
// To: MK_RT_NEXT_VERTEX
//------------------------------------------------------------------------------

__kernel __attribute__((work_group_size_hint(64, 1, 1))) void AdvancePaths_MK_GENERATE_CAMERA_RAY(
		KERNEL_ARGS
		) {
	const size_t gid = get_global_id(0);
	if (gid >= PARAM_TASK_COUNT)
		return;

	// Read the path state
	__global GPUTask *task = &tasks[gid];
	__global GPUTaskState *taskState = &tasksState[gid];
	PathState pathState = taskState->state;
	if (pathState != MK_GENERATE_CAMERA_RAY)
		return;

	//--------------------------------------------------------------------------
	// Start of variables setup
	//--------------------------------------------------------------------------

	__global Sample *sample = &samples[gid];
	__global float *sampleData = Sampler_GetSampleData(sample, samplesData);

	// Read the seed
	Seed seedValue = task->seed;

	__global Ray *ray = &rays[gid];

	//--------------------------------------------------------------------------
	// End of variables setup
	//--------------------------------------------------------------------------

	GenerateCameraPath(&tasksDirectLight[gid], taskState, sample, sampleData, camera, filmWidth, filmHeight, ray, &seedValue);
	// taskState->state is set to RT_NEXT_VERTEX inside GenerateCameraPath()

	// Re-initialize the volume information
#if defined(PARAM_HAS_VOLUMES)
	PathVolumeInfo_Init(&pathVolInfos[gid]);
#endif

	//--------------------------------------------------------------------------

	// Save the seed
	task->seed = seedValue;
}


// buildOptions= -D LUXRAYS_OPENCL_KERNEL -D SLG_OPENCL_KERNEL -D RENDER_ENGINE_PATHOCL -D PARAM_RAY_EPSILON_MIN=1.000000e-009f -D PARAM_RAY_EPSILON_MAX=1.000000e-001f -D PARAM_LIGHT_WORLD_RADIUS_SCALE=1.000000e+001f -D PARAM_ACCEL_BVH -D PARAM_FILM_RADIANCE_GROUP_0 -D PARAM_FILM_RADIANCE_GROUP_COUNT=1 -D PARAM_HAS_NORMALS_BUFFER -D PARAM_HAS_UVS_BUFFER -D PARAM_ENABLE_TEX_CONST_FLOAT3 -D PARAM_ENABLE_TEX_IMAGEMAP -D PARAM_ENABLE_MAT_MATTE -D PARAM_ENABLE_MAT_MIRROR -D PARAM_CAMERA_TYPE=0 -D PARAM_CAMERA_HAS_DOF -D PARAM_HAS_INFINITELIGHT -D PARAM_TRIANGLE_LIGHT_COUNT=0 -D PARAM_LIGHT_COUNT=1 -D PARAM_HAS_INFINITELIGHTS -D PARAM_HAS_ENVLIGHTS -D PARAM_HAS_IMAGEMAPS -D PARAM_IMAGEMAPS_PAGE_0 -D PARAM_IMAGEMAPS_COUNT=1 -D PARAM_DEVICE_INDEX=0 -D PARAM_DEVICE_COUNT=1 -cl-fast-relaxed-math -cl-mad-enable -cl-no-signed-zeros -D PARAM_TASK_COUNT=262144 -D PARAM_MAX_PATH_DEPTH=12 -D PARAM_RR_DEPTH=3 -D PARAM_RR_CAP=5.000000e-001f -D PARAM_RADIANCE_CLAMP_MAXVALUE=0.000000e+000f -D PARAM_PDF_CLAMP_VALUE=0.000000e+000f -D PARAM_IMAGE_FILTER_TYPE=2 -D PARAM_IMAGE_FILTER_WIDTH_X=1.000000e+000f -D PARAM_IMAGE_FILTER_WIDTH_Y=1.000000e+000f -D PARAM_IMAGE_FILTER_PIXEL_WIDTH_X=1 -D PARAM_IMAGE_FILTER_PIXEL_WIDTH_Y=1 -D PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA=2.000000e+000f -D PARAM_SAMPLER_TYPE=0
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S  -D LUXRAYS_OPENCL_KERNEL -D SLG_OPENCL_KERNEL -D RENDER_ENGINE_PATHOCL -D PARAM_RAY_EPSILON_MIN=1.000000e-009f -D PARAM_RAY_EPSILON_MAX=1.000000e-001f -D PARAM_LIGHT_WORLD_RADIUS_SCALE=1.000000e+001f -D PARAM_ACCEL_BVH -D PARAM_FILM_RADIANCE_GROUP_0 -D PARAM_FILM_RADIANCE_GROUP_COUNT=1 -D PARAM_HAS_NORMALS_BUFFER -D PARAM_HAS_UVS_BUFFER -D PARAM_ENABLE_TEX_CONST_FLOAT3 -D PARAM_ENABLE_TEX_IMAGEMAP -D PARAM_ENABLE_MAT_MATTE -D PARAM_ENABLE_MAT_MIRROR -D PARAM_CAMERA_TYPE=0 -D PARAM_CAMERA_HAS_DOF -D PARAM_HAS_INFINITELIGHT -D PARAM_TRIANGLE_LIGHT_COUNT=0 -D PARAM_LIGHT_COUNT=1 -D PARAM_HAS_INFINITELIGHTS -D PARAM_HAS_ENVLIGHTS -D PARAM_HAS_IMAGEMAPS -D PARAM_IMAGEMAPS_PAGE_0 -D PARAM_IMAGEMAPS_COUNT=1 -D PARAM_DEVICE_INDEX=0 -D PARAM_DEVICE_COUNT=1 -cl-fast-relaxed-math -cl-mad-enable -cl-no-signed-zeros -D PARAM_TASK_COUNT=262144 -D PARAM_MAX_PATH_DEPTH=12 -D PARAM_RR_DEPTH=3 -D PARAM_RR_CAP=5.000000e-001f -D PARAM_RADIANCE_CLAMP_MAXVALUE=0.000000e+000f -D PARAM_PDF_CLAMP_VALUE=0.000000e+000f -D PARAM_IMAGE_FILTER_TYPE=2 -D PARAM_IMAGE_FILTER_WIDTH_X=1.000000e+000f -D PARAM_IMAGE_FILTER_WIDTH_Y=1.000000e+000f -D PARAM_IMAGE_FILTER_PIXEL_WIDTH_X=1 -D PARAM_IMAGE_FILTER_PIXEL_WIDTH_Y=1 -D PARAM_IMAGE_FILTER_GAUSSIAN_ALPHA=2.000000e+000f -D PARAM_SAMPLER_TYPE=0" %cfg_path --cl-device=%cl_device 2>&1
