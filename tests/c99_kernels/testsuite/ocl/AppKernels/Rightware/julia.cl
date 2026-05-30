/**
* 2D Julia fractal renderer.
* Copyright 2011 by Rightware. All rights reserved.
*/

// TODO: Remove all commented code
float2 mulcomp(float2 a,float2 b)
{
  return (float2)(a.x*b.x-a.y*b.y,a.y*b.x+a.x*b.y);
}

float2 invcomp(float2 c)
{
c.y = -c.y;
return c/dot(c,c);
}

/* Takes points a, b, c to 0, 1, infinity */
float2 moebius01toinf(float2 z, float2 a, float2 b, float2 c)
{
z = mulcomp(mulcomp(z - a, b - c), invcomp(mulcomp(z - c, b - a)));
return z;
}

float2 moebius(float2 z, float2 a, float2 b, float2 c, float2 d)
{
z = mulcomp(mulcomp(z,a) + b, invcomp(mulcomp(z,c) + d));
return z;
}

float2 iterator(float2 z, float2 c, float2 ctr)
{
  const int maxiter = 64;
  const float radius = 2.0;
  int i = 0;
  float v = 0;
  float2 trapped = z - ctr;
  /*const float2 ctr = (float2)(0.0f, 1.0f);*/

  for(i=0;i < maxiter; i++)
  {
    z = (float2)(z.x*z.x-z.y*z.y,2.0*z.y*z.x) + c;

    if(dot(trapped, trapped) > dot(z - ctr,z - ctr)) trapped = z - ctr;

    if(dot(z,z) > radius*radius) break;

  }
 /* if(i == maxiter)
  {
    v = 0.0f;
  }
  else
  {

    z = (float2)(z.x*z.x-z.y*z.y,2.0*z.y*z.x) + c;i++;
    z = (float2)(z.x*z.x-z.y*z.y,2.0*z.y*z.x) + c;i++;

    v = (float)i+1.0f - (log(log(length(z))) / log(2.0));
    v = v/(float)maxiter;
  }
  return (float2)(sqrt(v),sqrt(v));*/
  return trapped;
}



/* TODO: Add parameters to control which julia set to select (or mandelbrot) and support for Möbius transformation.*/
__kernel void juliaImage(__write_only image2d_t dst_image, __read_only image2d_t colour_image, float scale)
{
  const sampler_t sampler= CLK_NORMALIZED_COORDS_TRUE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_LINEAR;
  int x = get_global_id(0);
  int y = get_global_id(1);

  float4 col = (float4)(0,0,0,0);
  float4 quaternion = (float4)(0, 0, 0, 0);

  quaternion.x = cos(scale/2);

  quaternion.y = 0.1f;
  quaternion.z = cos(scale/5.0f);
  quaternion.w = sin(scale/5.0f);

  quaternion.yzw = fast_normalize(quaternion.yzw)*sin(scale/2);



  float2 z = (float2)(x,y) /(float2)((float)get_global_size(0),(float)get_global_size(1));

  z = (z - (float2)(0.5f,0.5f))*(float2)(1.5f);

  z = z*5.0f ;

  z = moebius(z, (float2)(quaternion.x,quaternion.y), (float2)(quaternion.z,quaternion.w), (float2)(-quaternion.z,quaternion.w), (float2)(quaternion.x,-quaternion.y));

  float2 c = ( float2)(cos(scale/3.0f + 1.0f), sin(scale/3.0f + 1.0f))*0.7f;

  float2 trap = iterator(z, c, (float2)(0.3f, -0.023541f ));
  col += read_imagef(colour_image, sampler, (float2)(length(trap),0.0f));


  write_imagef(dst_image, (int2)(x,y), col);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
