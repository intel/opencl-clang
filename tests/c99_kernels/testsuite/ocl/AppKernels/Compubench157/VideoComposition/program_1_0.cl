
inline float4 quaternionConjugate(const float4 v)
{
	return (float4)(-v.s0, -v.s1, -v.s2, v.s3);
}

inline float4 quaternionMultiply(const float4 a, const float4 b)
{
	return (float4)
	(
		a.s3*b.s0 +a.s0*b.s3 +a.s1*b.s2 -a.s2*b.s1,
		a.s3*b.s1 -a.s0*b.s2 +a.s1*b.s3 +a.s2*b.s0,
		a.s3*b.s2 +a.s0*b.s1 -a.s1*b.s0 +a.s2*b.s3,
		a.s3*b.s3 -a.s0*b.s0 -a.s1*b.s1 -a.s2*b.s2
	);
}

inline float4 quaternionMultiplyVector(const float4 q, const float4 v)
{
	return (float4)
	(
		q.s3*v.s0 +q.s0*v.s3 +q.s1*v.s2 -q.s2*v.s1,
		q.s3*v.s1 -q.s0*v.s2 +q.s1*v.s3 +q.s2*v.s0,
		q.s3*v.s2 +q.s0*v.s1 -q.s1*v.s0 +q.s2*v.s3,
		0.0f
	);
}

inline float4 quaternionAngleRotator(const float angle, const float4 axis)
{
	float cosAngle;
	float sinAngle = sincos(angle*0.5f, &cosAngle);

	float4 r = axis;
	r.s0 *= sinAngle;
	r.s1 *= sinAngle;
	r.s2 *= sinAngle;
	r.s3  = cosAngle;

	return r;
}

inline float4 rotateVectorAxisAngle(const float4 v, const float angle, const float4 axis)
{
	float4 q = quaternionAngleRotator(angle, axis);
	return quaternionMultiplyVector(q, quaternionMultiply(v, quaternionConjugate(q)));
}

__kernel void transformImage(
	const float lt_x, //left top x
	const float lt_y, //left top y
	const float horizontalScale, //horizontal scale
	const float verticalScale, //horizontal scale
	const float angle,	//angle between horizontal vector and (1,0,0)
	global float2* restrict stageX,
	global float2* restrict stageY,
	read_only image2d_t imgIn,
	write_only image2d_t imgOut)
{
	const sampler_t smp = CLK_ADDRESS_CLAMP;
	int x = get_global_id(0);
	int y = get_global_id(1);
	int b =	(y > stageX[x].x && y < stageX[x].y) && (x > stageY[y].x && x < stageY[y].y);
	uint4 result = (uint4)(0,0,0,255);

	if (b) {
		float2 v = (float2)(x-lt_x, y-lt_y);
		float4 rotVec = rotateVectorAxisAngle((float4)(v.x, 0.0f, v.y, 0.0f), angle, (float4)(0.0f,1.0f,0.0f,0.0f));
		result = read_imageui(imgIn, smp, (int2)(rotVec.x*horizontalScale, rotVec.z*verticalScale));
		write_imageui(imgOut, (int2)(x, y), result);
	}

	//write_imageui(imgOut, (int2)(x, y), result);
}


// buildOptions=-cl-fast-relaxed-math
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S -cl-fast-relaxed-math" %cfg_path --cl-device=%cl_device 2>&1
