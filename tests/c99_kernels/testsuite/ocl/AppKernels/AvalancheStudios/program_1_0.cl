#pragma OPENCL EXTENSION cl_khr_byte_addressable_store : enable

#define VOXELSIZE_F 63.f
#define MAX_SCALARFIELD_DISTANCE_F 127.f

enum ScalarFieldConstants
{
	LOOKAHEAD_NEG		         = 1,
	LOOKAHEAD_POS		         = 2,
};

inline float4 mul_m4_v4(float16 m, float4 v)
{
	return (float4) (
		dot(m.s048C, v),
		dot(m.s159D, v),
		dot(m.s26AE, v),
		dot(m.s37BF, v)
	);
}

inline float3 mul_m4_iv3(float16 m, int3 iv)
{
	float4 res = mul_m4_v4(m, (float4)(iv.x, iv.y, iv.z, 1.0f));
	return res.xyz; // projection is ignored for now
}

// Given a normal direction, returns one of the tangents
// generated from the estimate of best axis aligned perpendicular plane
inline float3 GetTangentEstimate(float3 N)
{
	float3 NA = N*N;

	// X -> Y, Y -> Z, Z -> X
	int idx = (NA.x >= NA.y && NA.x >= NA.z) ? 1 : -1;
	idx = (NA.y >= NA.z && NA.y >= NA.z) ? 2 : idx;
	idx = (NA.z >= NA.x && NA.z >= NA.y) ? 0 : idx;

	float3 T = (float3)(0.0f,0.0f,0.0f);
	if(idx==0) T.x = 1.0f;
	if(idx==1) T.y = 1.0f;
	if(idx==2) T.z = 1.0f;

	float3 B = normalize(cross(T, N));
	return cross(N, B);
}

inline uint GridIDFromPos(int3 pos, uint4 side)
{
	return pos.x + pos.y*side.x + pos.z*side.x*side.y;
}

inline float SampleFieldPointFull(__global const char* volume,
								 float3 pos,
								 float distance_scale,
								 uint4 side)
{
	int3 int_pos = convert_int3(pos) + LOOKAHEAD_NEG;
	uint4 stride = side + ( LOOKAHEAD_NEG + LOOKAHEAD_POS );
	int3 clamped_pos = clamp(int_pos, (int3)0, convert_int3(stride.xyz) - (int3)1);

	uint voxel_id = GridIDFromPos(clamped_pos, stride);

	return volume[voxel_id] * distance_scale;
}


float CardinalSplineGetControlPointDistanceSq(__global const float* cps, int cpcount, int index, const float3 position)
{
	(void)cpcount;
	return (cps[index*4]-position.x)*(cps[index*4]-position.x) + (cps[index*4+1]-position.y)*(cps[index*4+1]-position.y) + (cps[index*4+2]-position.z)*(cps[index*4+2]-position.z);
}

float4 CardinalSplineGetControlPointPosition(__global const float* cps, int cpcount, int index)
{
	(void)cpcount;
	return (float4)(cps[index*4], cps[index*4+1], cps[index*4+2], cps[index*4+3]);
}

float Scalef(float variable, float min_in, float max_in, float min_out, float max_out)
{
    float v = (variable - min_in) / (max_in - min_in);
	float ret = min_out + v * (max_out - min_out);
    return ret;
} ///< Scales variable from the ranged defined by min_in and max_in to the range defined by min_out and max_out.

void CardinalSplineGetSubIndexAndT(__global const float* cps, int cpcount, float t2, int* out_index2, float* out_t2)
{
	(void)cps;
	float t = clamp(t2, 0.f, 1.f);
	float float_index = Scalef(t, 0.0f, 1.0f, 1.0f, (float)(cpcount - 2));

	int out_index = (int)floor(float_index);
	float out_t = float_index - (float)out_index;

	if (out_index == cpcount - 2)
	{
		out_index = cpcount - 3;
		out_t = 1.f;
	}
	else
	{
		float out_t3 = clamp(out_t, 0.f, 1.f);
		out_t = out_t3;
		int out_index3 = clamp(out_index, 1, cpcount - 3);
		out_index = out_index3;
	}
	*out_index2 = out_index;
	*out_t2 = out_t;
}

float4 float4_at_index(__global const float* cps, int index)
{
	return (float4)(cps[index*4], cps[index*4+1], cps[index*4+2], cps[index*4+3]);
}

float3 CardinalSplineSampleTangentLocal(__global const float* cps, int cpcount, int point_index, float t)
{
	(void)cpcount;
	float4 p1 = float4_at_index(cps, point_index);
	float4 p2 = float4_at_index(cps, point_index+1);

	// Do we have a straight line?
	if (fabs(p1.w) < 0.015f || fabs(p2.w) < 0.015f)
	{
		return (p2-p1).xyz;
	}

	// calculate hermite curve basis functions
	float t_pow_3 = 3*t*t;
	float t_pow_2 = 2*t;
	float h1 =  2*t_pow_3 - 3*t_pow_2;
	float h2 = -2*t_pow_3 + 3*t_pow_2;
	float h3 =  t_pow_3 - 2*t_pow_2 + 1;
	float h4 =  t_pow_3 - t_pow_2;

	float4 p0 = float4_at_index(cps, point_index-1);
	float4 p3 = float4_at_index(cps, point_index+2);

	// cardinal splines, we calculate the tangent
	float4 tangent1 = p1.w * (p2-p0);	// tangent for index point
	float4 tangent2 = p2.w * (p3-p1);   // tangent for index+1 point

	float4 new_point = h1 * p1 + h2 *p2 + h3 * tangent1 + h4 * tangent2;
	return new_point.xyz;
}

float3 CardinalSplineSampleTangent(__global const float* cps, int cpcount, float t)
{
	int oi;
	float ot;
	CardinalSplineGetSubIndexAndT(cps, cpcount, t, &oi, &ot);
	return CardinalSplineSampleTangentLocal(cps, cpcount, oi, ot);
}

float3 CardinalSplineSampleLocal(__global const float* cps, int cpcount, int point_index, float t)
{
	(void)cpcount;

	// calculate hermite curve basis functions
	float t_pow_3 = t*t*t;
	float t_pow_2 = t*t;
	float h1 =  2*t_pow_3 - 3*t_pow_2 + 1;
	float h2 = -2*t_pow_3 + 3*t_pow_2;
	float h3 =  t_pow_3 - 2*t_pow_2 + t;
	float h4 =  t_pow_3 - t_pow_2;

	float4 p0 = float4_at_index(cps, point_index-1);
	float4 p1 = float4_at_index(cps, point_index);
	float4 p2 = float4_at_index(cps, point_index+1);
	float4 p3 = float4_at_index(cps, point_index+2);

	// cardinal splines, we calculate the tangents
	float4 tangent1 = p1.w * (p2-p0);	// tangent for index point
	float4 tangent2 = p2.w * (p3-p1); // tangent for index+1 point
	float4 new_point = h1 * p1 + h2 * p2 + h3 * tangent1 + h4 * tangent2;
	return new_point.xyz;
}

float3 CardinalSplineSample(__global const float* cps, int cpcount, float t)
{
	int oi;
	float ot;
	CardinalSplineGetSubIndexAndT(cps, cpcount, t, &oi, &ot);
	return CardinalSplineSampleLocal(cps, cpcount, oi, ot);
}

float4 pos_and_banking_at_index(__global const float* cps, __global const float* banking, int index)
{
	return (float4)(cps[index*4], cps[index*4+1], cps[index*4+2], banking[index]);
}

float4 CardinalSplineSampleWithBanking(__global const float* cps, __global const float* banking, int cpcount, float t)
{
	int oi;
	float ot;
	CardinalSplineGetSubIndexAndT(cps, cpcount, t, &oi, &ot);

	// calculate hermite curve basis functions
	float t_pow_3 = ot*ot*ot;
	float t_pow_2 = ot*ot;
	float h1 =  2*t_pow_3 - 3*t_pow_2 + 1;
	float h2 = -2*t_pow_3 + 3*t_pow_2;
	float h3 =  t_pow_3 - 2*t_pow_2 + ot;
	float h4 =  t_pow_3 - t_pow_2;

	float tension1 = cps[oi*4+3];
	float tension2 = cps[oi*4+7];
	float4 p0 = pos_and_banking_at_index(cps, banking, oi-1);
	float4 p1 = pos_and_banking_at_index(cps, banking, oi);
	float4 p2 = pos_and_banking_at_index(cps, banking, oi+1);
	float4 p3 = pos_and_banking_at_index(cps, banking, oi+2);

	// cardinal splines, we calculate the tangents
	float4 tangent1 = tension1 * (p2-p0);	// tangent for index point
	float4 tangent2 = tension2 * (p3-p1); // tangent for index+1 point
	float4 new_point = h1 * p1 + h2 * p2 + h3 * tangent1 + h4 * tangent2;
	return new_point;
}

float CardinalSplineGetNearestT(__global const float* cps, int cpcount, float3 position3, int sub_cp, float min_dist_to_ends, int sub_precision)
{
	float nearest_t = 0.0f;
	float nearest_value = CardinalSplineGetControlPointDistanceSq(cps, cpcount, 1, position3);
	int closest_ind = 1;

	int first = 2;
	int last = cpcount -1;

	if (min_dist_to_ends > 0.1f)
	{
		float sq_min_dist = min_dist_to_ends*min_dist_to_ends;
		float4 start = CardinalSplineGetControlPointPosition(cps, cpcount, 1);
		float4 end = CardinalSplineGetControlPointPosition(cps, cpcount, cpcount - 1);

		//find first point
		int i = first + 1;
		while (i < last && CardinalSplineGetControlPointDistanceSq(cps, cpcount, i, start.xyz) < sq_min_dist)
			++i;

		first = i;
		//find last point
		i = last-1;
		while (i > first && CardinalSplineGetControlPointDistanceSq(cps, cpcount, i, end.xyz) < sq_min_dist)
			--i;

		last = i;

		if (first > last)
			return 0.5f;//return dummy value
	}

	for (int i = first; i < last; ++i)
	{
		float sq_distance = CardinalSplineGetControlPointDistanceSq(cps, cpcount, i, position3);
		if (sq_distance < nearest_value)
		{
			nearest_value = sq_distance;
			closest_ind = i;
			nearest_t = (float)(i-1) / (float)(cpcount-3);
		}
	}

	// if sub_cp refine t
	if (sub_cp)
	{
		float3 tangent = CardinalSplineSampleTangent(cps, cpcount, nearest_t);
		float4 diff4 = CardinalSplineGetControlPointPosition(cps, cpcount, closest_ind);
		float3 diff = diff4.xyz;

		diff = position3 - diff;

		float next_nearest_t = nearest_t;

		float stepsize = 1.f / (float)(cpcount-3);

		if (dot(diff, tangent) > 0)
		{
			next_nearest_t = nearest_t + stepsize;
			if (next_nearest_t > 1)
				next_nearest_t = 1;
		}
		else
		{
			next_nearest_t = nearest_t - stepsize;
			if (next_nearest_t < 0)
				next_nearest_t = 0;
		}

		// do a binary search between the controlpoints
		stepsize = (next_nearest_t - nearest_t) * .5f;

		nearest_t += stepsize; // in the middle of nearest and next nearest

		for (int iter = 0 ; iter < sub_precision ; ++iter)
		{
			stepsize *= .5f;
			float3 v0 = CardinalSplineSample(cps, cpcount, nearest_t - stepsize);
			float3 v1 = CardinalSplineSample(cps, cpcount, nearest_t + stepsize);

			float dist0 = length(position3 - v0);
			float dist1 = length(position3 - v1);
			if (dist0 < dist1)
				nearest_t -= stepsize;
			else
				nearest_t += stepsize;
		}
	}
	return nearest_t;
}


// function copied from te/brushes
inline float BoxBrushRotatedFunc(int3 p, float3 brush_position, float4 brush_dimension, float16 brush_transform )
{
	// Apply transform to input position
	float4 the_pos = mul_m4_v4(brush_transform, (float4)(convert_float3(p)-brush_position,1.0f)) + (float4)(brush_position.x, brush_position.y, brush_position.z, 0.0f);

	// Oriented box
	float3 fp = the_pos.xyz - brush_position;
	return max(max(fabs(fp.x)-brush_dimension.x, fabs(fp.y)-brush_dimension.y), fabs(fp.z) - brush_dimension.z) * VOXELSIZE_F;
}

char rclamp(float distance)
{
	return convert_char_rte(clamp(distance, -MAX_SCALARFIELD_DISTANCE_F, MAX_SCALARFIELD_DISTANCE_F));
}

float4 quaternion_multiply(float4 a, float4 b)
{
	float4 ans;
	ans.xyz = cross( a.xyz, b.xyz );
	ans += a.w * b + b.w * a;
	ans.w = a.w * b.w - (a.x * b.x + a.y * b.y + a.z * b.z);
	return ans;
}

float4 quaternion_from_axis_angle(float3 axis, float angle)
{
	float4 q;
	float cos_angle;
	q.xyz = axis.xyz * sincos(angle / 2, &cos_angle);
	q.w = cos_angle;
	return q;
}

float3 quaternion_rotate(float4 quaternion, float3 to_change)
{
	float4 as_quaternion;
	as_quaternion.xyz = to_change.xyz;
	as_quaternion.w = 0.0f;
	float4 qInv;
	qInv.xyz = -quaternion.xyz;
	qInv.w = quaternion.w;
	float4 out = quaternion_multiply(quaternion_multiply(quaternion,as_quaternion),qInv);
	return out.xyz;
}

float3 side_from_tangent_and_banking(float3 t, float banking)
{
	float3 side = normalize(cross(t, (float3)(0, 1, 0)));
	float4 rot = quaternion_from_axis_angle(t, banking);
	return quaternion_rotate(rot, side);
}
float3 normal_from_tangent_and_banking(float3 t, float banking)
{
	float3 x = side_from_tangent_and_banking(normalize(t), banking);
	return normalize(cross(x, t));
}

float16 mat_from_vec(float3 t, float banking)
{
	t = normalize(t); // z-axis == spline tangent
	float3 x = normalize(side_from_tangent_and_banking(t, banking));
	float3 y = normalize(cross(x, t)); // make y-axis
	return (float16)(x.x, y.x, t.x, 0,
	                 x.y, y.y, t.y, 0,
	                 x.z, y.z, t.z, 0,
	                 0,0,0,1);
}
float16 mat_from_tangent_and_normal(float3 z, float3 y)
{
	y = normalize(y);
	float3 x = normalize(cross(z, y));
	z = normalize(cross(y, x));
	return (float16)(x.x, y.x, z.x, 0,
	                 x.y, y.y, z.y, 0,
	                 x.z, y.z, z.z, 0,
	                 0,0,0,1);
}

int3 getrawpos()
{
	return (int3)(get_global_id(0), get_global_id(1), get_global_id(2));
}

uint getgid(uint4 side)
{
	return GridIDFromPos(getrawpos(), side + LOOKAHEAD_NEG + LOOKAHEAD_POS);
}

float4 plane_from_normal_and_point(float3 normal, float3 point)
{
	return (float4)(normal.x, normal.y, normal.z, -dot(normal, point));
}

float3 plane_intersection(float4 plane, float3 start_point, float3 direction)
{
	float dot_dir = dot(plane.xyz, direction);
	if (fabs(dot_dir) < 0.0001f) return start_point;
	float t = -(dot(plane.xyz, start_point) + plane.w) / dot_dir;
	return start_point + direction * t;
}

bool GetRoadArgs(__global const float* cps, __global const float* banking, int cpcount, int ipos_multiplier, int3* out_ipos, float3* out_pos, float16* out_matrix)
{
	int3 rawpos = getrawpos();
	int3 ipos = (rawpos - LOOKAHEAD_NEG) * ipos_multiplier;
	float3 pos = convert_float3(ipos);
	*out_ipos = ipos;

	float t = CardinalSplineGetNearestT(cps, cpcount, pos, 1, 0.f, 15);
	float4 rp = CardinalSplineSampleWithBanking(cps, banking, cpcount, t);
	float3 tangent = CardinalSplineSampleTangent(cps, cpcount, t);
	*out_pos = rp.xyz;

	int sub_index;
	float sub_t;
	CardinalSplineGetSubIndexAndT(cps, cpcount, t, &sub_index, &sub_t);

	int last_point = cpcount - 3;

	if (sub_index > 1 && sub_index < last_point)
	{
		*out_matrix = mat_from_vec( tangent, rp.w );
	}
	else
	{
		float3 junction_tangent;
		float4 junction_rp;
		float lerp_t;
		if (sub_index == 1)
		{
			junction_rp = CardinalSplineSampleWithBanking(cps, banking, cpcount, 0.0f);
			junction_tangent = CardinalSplineSampleTangent(cps, cpcount, 0.0f);
			lerp_t = (sub_t <= 0.5f ? 1.0f : 2 * (1 - sub_t));
		}
		else
		{
			junction_rp = CardinalSplineSampleWithBanking(cps, banking, cpcount, 1.0f);
			junction_tangent = CardinalSplineSampleTangent(cps, cpcount, 1.0f);
			lerp_t = (sub_t >= 0.5f ? 1.0f : 2 * sub_t);
		}
		float3 junction_normal = normal_from_tangent_and_banking(junction_tangent, junction_rp.w);
		float4 plane = plane_from_normal_and_point(junction_normal, junction_rp.xyz);
		float3 normal = normal_from_tangent_and_banking(tangent, rp.w);
		float plane_y = plane_intersection(plane, rp.xyz, normal).y;
		if (lerp_t >= 1.0f)
		{
			*out_matrix = mat_from_tangent_and_normal(junction_tangent, junction_normal);
			(*out_pos).y = plane_y;
		}
		else
		{
			float3 interpolated_normal = mix(normal, junction_normal, lerp_t);
			float3 interpolated_tangent = mix(tangent, junction_tangent, lerp_t);
			*out_matrix = mat_from_tangent_and_normal(interpolated_tangent, interpolated_normal);
			(*out_pos).y = mix(rp.y, plane_y, lerp_t);
		}
	}
	return dot( tangent, tangent ) > 0.0f;
}

__kernel void PaintRoadsQualityAdd(__global char* voxels, uint4 side, __global const float* cps, __global const float* banking, int cpcount, float radius)
{
	uint gid = getgid(side);
	int3 ipos;
	float3 road_pos;
	float16 matrix;
	int quality_resolution = 2;
	if( !GetRoadArgs(cps, banking, cpcount, quality_resolution, &ipos, &road_pos, &matrix) )
		return;

	float road_radius = radius * 1.2f;
	float distance = BoxBrushRotatedFunc(ipos, road_pos, (float4)(road_radius, road_radius/2, road_radius, 0), matrix) * ( 1.0f / VOXELSIZE_F );
	int weight = (int)clamp( ( 2.0f - distance * 0.5f ) * 64.0f, 0.0f, 64.0f );		// Fade over one voxel.
	voxels[ gid ] = (uchar)weight;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
