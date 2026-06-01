__kernel void kernel_blur_hor (__global const float4     *in,
                               __global       float4     *aux,
                               int width, int radius)
{
  const int in_index = get_global_id(0) * (width + 2 * radius)
                       + (radius + get_global_id (1));

  const int aux_index = get_global_id(0) * width + get_global_id (1);
  int i;
  float4 mean;

  mean = (float4)(0.0f);

  for (i=-radius; i <= radius; i++)
   {
     mean += in[in_index + i];
   }

  aux[aux_index] = mean / (2 * radius + 1);
}
__kernel void kernel_blur_ver (__global const float4     *aux,
                               __global       float4     *out,
                               int width, int radius)
{
  const int aux_index = (radius + get_global_id(0)) * width + get_global_id (1);

  const int out_index = get_global_id(0) * width + get_global_id (1);
  int i;
  float4 mean;

  mean = (float4)(0.0f);

  for (i=-radius; i <= radius; i++)
   {
     mean += aux[aux_index + i * width];
   }

  out[out_index] = mean / (2 * radius + 1);
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
