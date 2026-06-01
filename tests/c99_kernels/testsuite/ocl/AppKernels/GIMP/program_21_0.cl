__kernel void vignette_cl (__global const float4 *in,
                           __global       float4 *out,
                                          float4 color,
                                          float  scale,
                                          float  cost,
                                          float  sint,
                                          int    roi_x,
                                          int    roi_y,
                                          int    midx,
                                          int    midy,
                                          int    o_shape,
                                          float  gamma,
                                          float  length,
                                          float  radius0,
                                          float  rdiff)
{
  int gidx = get_global_id(0);
  int gidy = get_global_id(1);
  int gid = gidx + gidy * get_global_size(0);
  float strength = 0.0f;
  float u,v,costy,sinty;
  int x,y;
  x = gidx + roi_x;
  y = gidy + roi_y;
  sinty = sint * (y-midy) - midx;
  costy = cost * (y-midy) + midy;

  u = cost * (x-midx) - sinty;
  v = sint * (x-midx) + costy;

  if (length == 0.0f)
    strength = 0.0f;
  else
    {
      switch (o_shape)
        {
          case 0:
          strength = hypot ((u-midx) / scale, v-midy);
          break;

          case 1:
          strength = fmax (fabs(u-midx)/scale, fabs(v-midy));
          break;

          case 2:
          strength = fabs (u-midx) / scale + fabs(v-midy);
          break;
        }
      strength /= length;
      strength = (strength-radius0) / rdiff;
    }

  if (strength < 0.0f) strength = 0.0f;
  if (strength > 1.0f) strength = 1.0f;

  if (gamma > 0.9999f && gamma < 2.0001f)
    strength *= strength;
  else if (gamma != 1.0f)
    strength = pow(strength, gamma);

  out[gid] = in[gid]*(1.0f-strength) + color * strength;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
