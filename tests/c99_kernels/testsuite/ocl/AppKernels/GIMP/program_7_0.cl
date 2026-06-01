__kernel void kernel_temp(__global const float4     *in,
                          __global       float4     *out,
                          float coeff1,
                          float coeff2,
                          float coeff3)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;
  out_v.xyz = in_v.xyz * (float3) (coeff1, coeff2, coeff3);
  out_v.w   = in_v.w;
  out[gid]  =  out_v;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
