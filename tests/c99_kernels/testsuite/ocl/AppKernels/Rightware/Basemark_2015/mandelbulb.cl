/**
* Mandelbulb 3D fractal renderer.
*
* Copyright 2011 by Rightware. All rights reserved.
*/

#ifdef ALLOW_NATIVE
#define bmark_sqrt native_sqrt
#define bmark_sin native_sin
#define bmark_cos native_cos
#define bmark_powr native_powr
#define bmark_log native_log
#else
#define bmark_sqrt half_sqrt
#define bmark_sin half_sin
#define bmark_cos half_cos
#define bmark_powr half_powr
#define bmark_log half_log
#endif

#define RADIUS_2 2.0f
#define POWER 8
#define POWERF 8.0f

#define DIFFMULT 0.0001f


float3 mpower(float3 w,const float r, float power)
{
    const float wi = atan2(w.x, w.z);
    const float wo = acos(w.y / r);
    w = (float3)(bmark_sin(power * wo) * bmark_sin(power * wi), bmark_cos(power * wo), bmark_sin(power * wo) * bmark_cos(power * wi) );
    return bmark_powr(r, power) * w;
}

float distanceEstimator(const float3 z0, const int maxIter, float power)
{
    float3 z = z0;
    float dr = 1.0f;

    float r = fast_length(z);
    int n = 0;
    while (n < maxIter && r < 8.0f)
    {
        dr = power * bmark_powr(r, power - 1.0f) * dr + 1.0f;
        z = mpower(z, r, power) + z0;
        r = fast_length(z);

        n++;
    }

    return 0.5f * bmark_log(r) * r / dr;
}

float4 origoTrap(const float3 z0, const int maxIter, float power)
{
    float3 z = z0;

    float dr = 1.0f;

    float r = fast_length(z);
    float4 closest = (float4)(fabs(z.x), fabs(z.y), fabs(z.z), r);
    int n = 0;
    while (n < maxIter && r < 8.0f)
    {
        dr = power * bmark_powr(r, power - 1.0f) * dr + 1.0f;
        z = mpower(z, r, power) + z0;
        r = fast_length(z);
        select(closest, (float4)(fabs(z.x), fabs(z.y), fabs(z.z), r), closest > (float4)(fabs(z.x), fabs(z.y), fabs(z.z), r));
        n++;
    }

    return closest;

}

float findIntersect(const float3 start, const float3 direction, int maxIter, const float power, const float dist_epsilon, const float maxDist)
{
    float3 z = start;
    float dist = 0.0f;
    float marchedDistance = 0.0f;
    float shortestDistance = INFINITY;

    do
    {
        marchedDistance += dist;
        z += direction * dist;
        dist = distanceEstimator(z, maxIter, power);
        if(dist < shortestDistance) shortestDistance = dist;

    } while(marchedDistance < maxDist && dist > dist_epsilon + DIFFMULT * marchedDistance);

    if (marchedDistance >= maxDist)
    {
        marchedDistance = -shortestDistance;
    }

    return marchedDistance;
}

float3 normalEstimate(float3 collisionpoint, float3 direction, int maxIter, const float power, const float dist_epsilon)
{
    float3 N;
    const float3 x = (float3)(dist_epsilon, 0.0f, 0.0f);
    const float3 y = (float3)(0.0f, dist_epsilon, 0.0f);
    const float3 z = (float3)(0.0f, 0.0f, dist_epsilon);

    /* dropped lengths as result is normalized anyway. */
    N.x = (distanceEstimator(collisionpoint + x , maxIter, power)) - (distanceEstimator(collisionpoint - x , maxIter, power));
    N.y = (distanceEstimator(collisionpoint + y , maxIter, power)) - (distanceEstimator(collisionpoint - y , maxIter, power));
    N.z = (distanceEstimator(collisionpoint + z , maxIter, power)) - (distanceEstimator(collisionpoint - z , maxIter, power));

    return fast_normalize(N);

}

float4 lighting(float3 N, float3 collisionpoint, int maxIter, const float power, const float dist_epsilon)
{
    const float4 origotrap = origoTrap(collisionpoint, maxIter, power);
    float aoFactor = pow(max(0.f, origotrap.w - 0.15f), 4.0f);

    const float4 col1 = (float4)(0.4f, 0.8f, 0.9f, 1.0f);
    const float4 col2 = (float4)(0.3f, 0.35f, 0.5f, 1.0f);
    const float4 col3 = (float4)(0.8f, 0.9f, 0.97f, 1.0f);

    const float3 ldir = (float3)(0.32f, 0.49f, 0.82f);
    float ddd = 0.75f + dot(N, ldir);
    if(ddd < 0.) ddd = 0.;

    return (float4)(aoFactor * (col1 * origotrap.x + col2 * origotrap.y + origotrap.z * col3) * ddd);
}

/** Render the mandelbulb fractal into an OpenCL Image. */
__kernel void mandelbulbImage(__write_only image2d_t dst_image, float cx)
{
    int x = get_global_id(0);
    int y = get_global_id(1);
    int w = get_global_size(0);
    int h = get_global_size(1);
    float4 col = (float4)(0.0f);

    const float3 camera_origin= (float3)(cx, 3.01f, 2.0f*cos(cx/2.0f)) * (float3)(2.0f);
    const float3 camera_target = (float3)(0.0f, 0.0f, 0.0f);
    const float3 camera_dir = fast_normalize(camera_target - camera_origin);
    const float3 camera_up = (float3)(0.0f, 1.0f, 0.0f);

    const float3 camera_x = fast_normalize(cross(camera_dir, camera_up)) * ((float)w/(float)h) * 0.25f;
    const float3 camera_y = fast_normalize(cross(camera_dir, camera_x)) * 0.25f;

    /* Calculate the eye ray */
    const float kx = ((float)x/(float)w - 0.5f);
    const float ky = ((float)y/(float)h - 0.5f);
    const float3 eye_dir = fast_normalize(camera_x * kx + camera_y * ky + camera_dir);
    const float3 eye_origin = camera_origin;

    /* Check if we intersect the bounding sphere */
    const float b = 2.0f * dot(eye_dir, eye_origin);
    float det = b * b - 4.0f*(dot(eye_origin, eye_origin) - RADIUS_2);
    float t0 = 0.0f;
    float t1 = 0.0f;
    float dist = 0.0f;
    if(det >= 0) /* The ray intersects the sphere TODO: Handle the case when camera is inside the sphere */
    {
      t0 = ((-b - bmark_sqrt(det)) / 2.0f);
      t1 = ((-b + bmark_sqrt(det)) / 2.0f);

      /* We are inside the bounding sphere, iterate the collision with the set */
      dist = findIntersect(eye_origin + eye_dir*t0, eye_dir, 10, POWERF, DIFFMULT * t0, t1-t0);
      if(dist > 0.0f) /* We have found the collision point with the set which is eye_origin + (t0+dist) * eye_dir*/
      {
          float3 collisionpoint = eye_origin + (t0 + dist) * eye_dir;
          float3 surface_normal = normalEstimate(collisionpoint, eye_dir, 10, POWERF, DIFFMULT*(t0 + dist) / 2.0f);
          col = lighting(surface_normal, collisionpoint, 10, POWERF, DIFFMULT*(t0 + dist));
      }
      else
      {
        float4 outGlowColor = (float4)(0.8f, 0.9f, 0.97f, 1.0f);
        col = outGlowColor * max(0.0f, dist+0.25f);
      }
    }

    write_imagef(dst_image, (int2)(x,y), col);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
