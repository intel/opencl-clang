__kernel void kernel_thr_3 (__global const float2     *in,
                            __global const float      *aux,
                            __global       float2     *out)
{
  int gid = get_global_id(0);
  float2 in_v  = in [gid];
  float  aux_v = aux[gid];
  float2 out_v;
  out_v.x = (in_v.x > aux_v)? 1.0f : 0.0f;
  out_v.y = in_v.y;
  out[gid]  =  out_v;
}
__kernel void kernel_thr_2 (__global const float2     *in,
                            __global       float2     *out,
                            float value)
{
  int gid = get_global_id(0);
  float2 in_v  = in [gid];
  float2 out_v;
  out_v.x = (in_v.x > value)? 1.0f : 0.0f;
  out_v.y = in_v.y;
  out[gid]  =  out_v;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
