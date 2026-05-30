__kernel void kernel_op_3 (__global const float4     *in,
                           __global const float      *aux,
                           __global       float4     *out,
                           float value)
{
  int gid = get_global_id(0);
  float4 in_v  = in [gid];
  float  aux_v = aux[gid];
  float4 out_v;
  out_v = in_v * aux_v * value;
  out[gid]  =  out_v;
}
__kernel void kernel_op_2 (__global const float4     *in,
                           __global       float4     *out,
                           float value)
{
  int gid = get_global_id(0);
  float4 in_v  = in [gid];
  float4 out_v;
  out_v = in_v * value;
  out[gid]  =  out_v;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
