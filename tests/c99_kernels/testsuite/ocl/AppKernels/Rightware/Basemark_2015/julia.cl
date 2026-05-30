/**
* 2D Julia fractal renderer.
*
* Copyright 2011 by Rightware. All rights reserved.
*/

#ifdef ALLOW_NATIVE
#define bmark_sqrt native_sqrt
#define bmark_sin native_sin
#define bmark_cos native_cos
#else
#define bmark_sqrt half_sqrt
#define bmark_sin half_sin
#define bmark_cos half_cos
#endif

/* Complex multiplication */
inline float2 mulcomp(float2 a,float2 b)
{
    return (float2)(a.x*b.x - a.y*b.y, a.y*b.x + a.x*b.y);
}

/* Multiplicative inverse of complex number */
inline float2 invcomp(float2 c)
{
    c.y = -c.y;
    return c/dot(c, c);
}

/** Takes points a, b, c to 0, 1, infinity respectively. */
inline float2 moebius01toinf(float2 z, float2 a, float2 b, float2 c)
{
    z = mulcomp(mulcomp(z - a, b - c), invcomp(mulcomp(z - c, b - a)));
    return z;
}

/* Applies moebius transformation to z */
inline float2 moebius(float2 z, float2 a, float2 b, float2 c, float2 d)
{
    z = mulcomp(mulcomp(z, a) + b, invcomp(mulcomp(z, c) + d));
    return z;
}

float2 iterator(float2 z, float2 c, float2 ctr)
{
    const int maxiter = 64;
    const float radius = 2.0f;
    int i = 0;
    float v = 0;
    float2 trapped = z - ctr;

    for(i=0;i < maxiter; i++)
    {
    z = (float2)(z.x*z.x - z.y*z.y, 2.0f*z.y*z.x) + c;

    if(dot(trapped, trapped) > dot(z - ctr,z - ctr)) trapped = z - ctr;

    if(dot(z,z) > radius*radius) break;
    }
    return trapped;
}


__kernel void juliaImage(__write_only image2d_t dst_image, __read_only image2d_t colour_image, float scale)
{
    const sampler_t sampler= CLK_NORMALIZED_COORDS_TRUE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;
    int x = get_global_id(0);
    int y = get_global_id(1);

    float4 col = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
    float4 quaternion = (float4)(0.0f, 0.0f, 0.0f, 0.0f);

    /* Construct a quaternion representing a rotation */
    quaternion.x = bmark_cos(scale/2);
    quaternion.y = 0.1f;
    quaternion.z = bmark_cos(scale/5.0f);
    quaternion.w = bmark_sin(scale/5.0f);
    quaternion.yzw = fast_normalize(quaternion.yzw) * bmark_sin(scale/2.0f);

    /* Calculate which complex number this pixel corresponds to */
    float2 z = (float2)(x,y) /(float2)((float)get_global_size(0),(float)get_global_size(1));
    z = (z - (float2)(0.5f,0.5f))*(float2)(1.5f);
    z = z*5.0f ;

    /* Use the imaginary matrix formulation of quaternion as a moebius transformation, thus producing transformations directly corresponding to rotation of the riemann sphere */
    z = moebius(z, (float2)(quaternion.x, quaternion.y), (float2)(quaternion.z, quaternion.w), (float2)(-quaternion.z, quaternion.w), (float2)(quaternion.x, -quaternion.y));

    /* Calculate the point of which we take the julia set from. */
    float2 c = ( float2)(bmark_cos(scale/3.0f + 1.0f), bmark_sin(scale/3.0f + 1.0f))*0.7f;

    /* Calculate the closest distance from the pointtrap */
    float2 trap = iterator(z, c, (float2)(0.3f, -0.023541f ));
    col += read_imagef(colour_image, sampler, (float2)(fast_length(trap),0.0f));

    write_imagef(dst_image, (int2)(x,y), col);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
