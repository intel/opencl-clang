__kernel void kernel_levels(__global const float4     *in,
                            __global       float4     *out,
                            float in_offset,
                            float out_offset,
                            float scale)
{
  int gid = get_global_id(0);
  float4 in_v  = in[gid];
  float4 out_v;
  out_v.xyz = (in_v.xyz - in_offset) * scale + out_offset;
  out_v.w   =  in_v.w;
  out[gid]  =  out_v;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
