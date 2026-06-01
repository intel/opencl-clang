__kernel void Mono_mixer_cl(__global const float4 *src_buf,
                            float4                 color,
                            __global float2       *dst_buf)
{
  int gid = get_global_id(0);
  float4 tmp = src_buf[gid] * color;
  dst_buf[gid].x = tmp.x + tmp.y + tmp.z;
  dst_buf[gid].y = tmp.w;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
