__kernel void clBilateralGaussian(__read_only image2d_t depthIn,
								  __write_only image2d_t depthOut,
                                  int r,
								  float delta,
                                  int w,
                                  int h)
{
	const sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_FILTER_NEAREST | CLK_ADDRESS_REPEAT;

    int x = mul24((uint)get_group_id(0), (uint)get_local_size(0)) + get_local_id(0);
    int y = mul24((uint)get_group_id(1), (uint)get_local_size(1)) + get_local_id(1);

    if (x < w && y < h)
	{
        float4 sum = 0.0f;
        float4 t = 0.0f;
        float4 factor;

        float4 dc = read_imagef(depthIn, sampler, (float2)(x,y));
		if (dc.w != 10000)
		{
			for(int i = -r; i <= r; i++)
			{
				for(int j = -r; j <= r; j++)
				{
					int lx = min(max(x+j, 0), w-1);
					int ly = min(max(y+i, 0), h-1);
					float4 dp = read_imagef(depthIn, sampler, (float2)(lx,ly));

					// range domain
					float r2 = (dc.w-dp.w)/(2*delta*delta);
					float g = exp(-r2*r2);

					// spatial domain
					float4 r = dp.w * 1.01;
					float4 w = exp(-r*r);

					t += dp * w * g;
					sum += w * g;
					/*
					float4 factor = (gaussian[i+r] * gaussian[j+r]) * exp(-(dc.w-dp.w)*(dc.w-dp.w)/(2*delta*delta));
					t += factor * dp;
					sum += factor;
					*/
				}
			}
			float4 result = t/sum;
			float4 normal = result;
			normal.w = 0;
			normal = normalize(normal);
			normal.w = result.w;

			write_imagef(depthOut, (int2)(x,y), (float4)(normal));
			//write_imagef(depthOut, (int2)(x,y), (float4)(t/sum));

		}
		//write_imagef(depthOut, (int2)(x,y),  dc);
	}
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
