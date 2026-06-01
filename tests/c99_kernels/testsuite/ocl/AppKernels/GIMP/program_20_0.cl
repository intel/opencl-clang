__kernel void kernel_vinv(__global const float4     *in,
                          __global       float4     *out)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;

  float value = fmax (in_v.x, fmax (in_v.y, in_v.z));
  float minv  = fmin (in_v.x, fmin (in_v.y, in_v.z));
  float delta = value - minv;

  if (value == 0.0f || delta == 0.0f)
    {
      out_v.xyz = (float3) (1.0f - value);
    }
  else
    {
      if (in_v.x == value)
        {
          out_v.xzy = (float3) ((1.0f - in_v.x),
                                (1.0f - in_v.x) * in_v.z / value,
                                (1.0f - in_v.x) * in_v.y / value);
        }
      else if (in_v.y == value)
        {
          out_v.yxz = (float3) ((1.0f - in_v.y),
                                (1.0f - in_v.y) * in_v.x / value,
                                (1.0f - in_v.y) * in_v.z / value);
        }
      else
        {
          out_v.zyx = (float3) ((1.0f - in_v.z),
                                (1.0f - in_v.z) * in_v.y / value,
                                (1.0f - in_v.z) * in_v.x / value);
        }
    }

  out_v.w   =  in_v.w;
  out[gid]  =  out_v;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
