float colordiff (float4 pixA,
                 float4 pixB)
{
    float4 pix = pixA-pixB;
    pix *= pix;
    return pix.x+pix.y+pix.z;
}

__kernel void snn_mean_CL (__global const   float4 *src_buf,
                                            int src_width,
                                            int src_height,
                           __global         float4 *dst_buf,
                                            int radius,
                                            int pairs)
{
    int gidx   =get_global_id(0);
    int gidy   =get_global_id(1);
    int offset =gidy * get_global_size(0) + gidx;

    __global const float4 *center_pix=
        src_buf + ((radius+gidx) + (gidy+radius)* src_width);
    float4 accumulated=0;

    int count=0;
    if(pairs==2)
    {
        for(int i=-radius;i<0;i++)
        {
            for(int j=-radius;j<0;j++)
            {
                __global const float4 *selected_pix = center_pix;
                float  best_diff = 1000.0f;

                    int xs[4]={
                        gidx+j+radius, gidx-j+radius,
                        gidx-j+radius, gidx+j+radius
                    };
                    int ys[4]={
                        gidy+i+radius, gidy-i+radius,
                        gidy+i+radius, gidy-i+radius};

                    for (int k=0;k<4;k++)
                    {
                        if (xs[k] >= 0 && xs[k] < src_width &&
                            ys[k] >= 0 && ys[k] < src_height)
                        {
                            __global const float4 *tpix =
                                src_buf + (xs[k] + ys[k] * src_width);
                            float diff=colordiff(*tpix, *center_pix);
                            if (diff < best_diff)
                            {
                                best_diff = diff;
                                selected_pix = tpix;
                            }
                        }
                    }

                accumulated += *selected_pix;

                ++count;
                if (i==0 && j==0)
                    break;
            }
        }
        dst_buf[offset] = accumulated/count;
        return;
    }
    else if(pairs==1)
    {
        for(int i=-radius;i<=0;i++)
        {
            for(int j=-radius;j<=radius;j++)
            {
                __global const float4 *selected_pix = center_pix;
                float  best_diff = 1000.0f;

                /* skip computations for the center pixel */
                if (i != 0 && j != 0)
                {
                    int xs[4]={
                        gidx+i+radius, gidx-i+radius,
                        gidx-i+radius, gidx+i+radius
                    };
                    int ys[4]={
                        gidy+j+radius, gidy-j+radius,
                        gidy+j+radius, gidy-j+radius
                    };

                    for (i=0;i<2;i++)
                    {
                        if (xs[i] >= 0 && xs[i] < src_width &&
                            ys[i] >= 0 && ys[i] < src_height)
                        {
                            __global const float4 *tpix =
                                src_buf + (xs[i] + ys[i] * src_width);
                            float diff=colordiff (*tpix, *center_pix);
                            if (diff < best_diff)
                            {
                                best_diff = diff;
                                selected_pix = tpix;
                            }
                        }
                    }
                }
                accumulated += *selected_pix;
                ++count;
                if (i==0 && j==0)
                    break;
            }
        }
        dst_buf[offset] = accumulated/count;
        return;
    }
    return;
}


// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
