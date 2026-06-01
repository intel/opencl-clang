//global include for a all OpenCL programs

#define BOUNDING_RADIUS_2 4.f

typedef struct
{
    float4 xAxis;
    float4 yAxis;
    float4 zAxis;
    float4 ePos;
    float4 xAxisInv;
    float4 yAxisInv;
    float4 zAxisInv;
    float dFar;
    float dNear;
}
_camera;


float4 qmult(float4 q1, float4 q2)
{
    float4 q1yzw = (float4)(q1.y, q1.z, q1.w, 0);
    float4 q2yzw = (float4)(q2.y, q2.z, q2.w, 0);
    float4 c = cross(q1yzw, q2yzw);

    float4 t = q2yzw * q1.x + q1yzw * q2.x + c;
    float4 r;
    r.x = q1.x * q2.x - dot(q1yzw, q2yzw);
    r.yzw = t.xyz;
    return r;
}

float4 qsqr(float4 q)
{
    float4 qyzw = (float4)(q.y, q.z, q.w, 0);

    float4 t = 2.0f * q.x * qyzw;
    float4 r;
    r.x = q.x * q.x - dot( qyzw, qyzw );
    r.yzw = t.xyz;
    return r;
}

float4 IntersectJulia(float4 rO, float4 rD, float4 c, float epsilon, uint iterations)
{
    float rd = 0.0f;
    float dist = epsilon;

    while (dist >= epsilon && rd < BOUNDING_RADIUS_2)
    {
        float4 z = (float4)(rO.x, rO.y, rO.z, 0.0f);
        float4 zp = (float4)(1.0f, 0.0f, 0.0f, 0.0f);
        float zd = 0.0f;

        uint count = 0;
        while(zd < BOUNDING_RADIUS_2 && count < iterations)
        {
            zp = 2.0f * qmult(z, zp);
            z = qsqr(z) + c;
            zd = dot(z, z);
            count++;
        }

        float normZ = fast_length(z);
        dist = 0.5f * normZ * half_log(normZ)/ fast_length(zp);
        rO += rD * dist;
        rd = dot(rO, rO);
    }

    return (float4)(rO.x, rO.y, rO.z, dist);
}

#define DELTA 1e-4f

float4 EstimateNormal(float4 p, float4 c, int iterations)
{
    float4 qp = (float4)( p.x, p.y, p.z, 0.0f );
    float4 gx1 = qp - (float4)( DELTA, 0.0f, 0.0f, 0.0f );
    float4 gx2 = qp + (float4)( DELTA, 0.0f, 0.0f, 0.0f );
    float4 gy1 = qp - (float4)( 0.0f, DELTA, 0.0f, 0.0f );
    float4 gy2 = qp + (float4)( 0.0f, DELTA, 0.0f, 0.0f );
    float4 gz1 = qp - (float4)( 0.0f, 0.0f, DELTA, 0.0f );
    float4 gz2 = qp + (float4)( 0.0f, 0.0f, DELTA, 0.0f );

    for ( int i = 0; i < iterations; i++ )
    {
        gx1 = qsqr( gx1 ) + c;
        gx2 = qsqr( gx2 ) + c;
        gy1 = qsqr( gy1 ) + c;
        gy2 = qsqr( gy2 ) + c;
        gz1 = qsqr( gz1 ) + c;
        gz2 = qsqr( gz2 ) + c;
    }

    float nx = fast_length(gx2) - fast_length(gx1);
    float ny = fast_length(gy2) - fast_length(gy1);
    float nz = fast_length(gz2) - fast_length(gz1);

    return normalize((float4)( nx, ny, nz, 0 ));
}

float IntersectSphere(float4 rO, float4 rD)
{
    float fB = 2.0f * dot( rO, rD );
    float fB2 = fB * fB;
    float fC = dot( rO, rO ) - BOUNDING_RADIUS_2;
    float fT = (fB2 - 4.0f * fC);
    if (fT <= 0.0f)
        return 0.0f;
    float fD = half_sqrt(fT);
    float fT0 = ( -fB + fD ) * 0.5f;
    float fT1 = ( -fB - fD ) * 0.5f;
    fT = fmin(fT0, fT1);
    return fT;
}

__kernel void JuliaGPU(
	__write_only image2d_t diffuse,
	__write_only image2d_t normals,
	const float epsilon,
	const uint iterations,
	const float4 mu,
	__global _camera *camera,
	const uint imageW,
	const uint imageH) {

	const int width = get_global_size(0);
	const int height = get_global_size(1);
	const int x = get_global_id(0);
	const int y = get_global_id(1);

    float u = (x / (float) imageW)*2.0f-1.0f;
    float v = (y / (float) imageH)*2.0f-1.0f;
    float4 eyeRayOrig = camera->ePos;
	float4 eyeRayDir = normalize(-camera->zAxis + u*camera->xAxis + v*camera->yAxis);

	float4 color = (float4) (0,0,0,HUGE_VALF);
	float4 normal = (float4) (0,0,0,0);

	float distSphere = IntersectSphere(eyeRayOrig, eyeRayDir);
	if (distSphere >= 0.f)
	{
		float4 rayOrig = eyeRayOrig + eyeRayDir * (float4)distSphere;

		float4 hitPoint = IntersectJulia(rayOrig, eyeRayDir, mu, epsilon, iterations);
		if (hitPoint.w < epsilon)
		{

			float4 hitVec = hitPoint - eyeRayOrig;
			float4 eyeVec;
			eyeVec.x = dot(camera->xAxis, hitVec);
			eyeVec.y = dot(camera->yAxis, hitVec);
			eyeVec.z = -dot(camera->zAxis, hitVec);
			color = (float4) (0.4,0.4,0.4,eyeVec.z);

			float4 normalVec = EstimateNormal(hitPoint, mu, iterations);
			normal.x = dot(camera->xAxis, normalVec);
			normal.y = dot(camera->yAxis, normalVec);
			normal.z = dot(camera->zAxis, normalVec);
		}
	}

	write_imagef(diffuse, (int2)(x,y), color);
	write_imagef(normals, (int2)(x,y), normal);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
